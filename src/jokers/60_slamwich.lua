SMODS.Joker {
    key = 'slamwich',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'retrigger'
    },
    unlocked = false,
    pos = {
        x = 7,
        y = 1
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
        }
    end, -- scoring cards retrigger additional times equal to the number of unscoring cards next to them
    calculate = function(self, card, context)
        --[[if context.before and context.poker_hands and next(context.poker_hands['Pair']) then
            card.ability.extra.repetition_amount = 0
            local first_card_found = false
            local second_card_found = false
            for _, playing_card in ipairs(context.full_hand) do
                local is_scoring = false
                for _, scoring_card in ipairs(context.scoring_hand) do
                    if playing_card == scoring_card then
                        is_scoring = true
                        break
                    end
                end
                if is_scoring == true then
                    if not first_card_found then
                        first_card_found = true
                    else
                        second_card_found = true
                        break
                    end
                else
                    if first_card_found and not second_card_found then
                        card.ability.extra.repetition_amount = card.ability.extra.repetition_amount + 1
                    end
                end
            end
        end

        if context.repetition and context.cardarea == G.play and context.poker_hands and next(context.poker_hands['Pair']) and ((context.other_card == context.scoring_hand[1]) or (context.other_card == context.scoring_hand[2])) then
            return {
                repetitions = card.ability.extra.repetition_amount
                --repetitions = 1
            }
        end]]

        if context.repetition and context.cardarea == G.play then
            local retriggers, card_position = 0, 0
            for i = 1, #context.full_hand do
                if context.full_hand[i] == context.other_card then
                    card_position = i
                end
            end
            local left_is_scoring, right_is_scoring = false, false
            local left_card, right_card = context.full_hand[card_position-1], context.full_hand[card_position+1]
            if left_card then
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i] == left_card then
                        left_is_scoring = true
                    end 
                end
            else
                left_is_scoring = true
            end
            if right_card then
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i] == right_card then
                        right_is_scoring = true
                    end 
                end
            else
                right_is_scoring = true
            end
            print(left_is_scoring)
            print(right_is_scoring)
            if left_is_scoring == false then
                retriggers = retriggers + 1
            end
            if right_is_scoring == false then
                retriggers = retriggers + 1
            end
            print(retriggers)
            if retriggers > 0 then
                return {
                    repetitions = retriggers
                }
            end
        end
        --in card.individual do the following
        -- figure out the position of the scoring card
        -- 
        
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { G.PROFILES[G.SETTINGS.profile].career_stats.c_bgn_unscoring_cards } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'c_face_cards_played', extra = 300 }`
        if args.type == 'career_stat' and args.statname == 'c_bgn_unscoring_cards' then
            --print(G.PROFILES[G.SETTINGS.profile].career_stats.c_bgn_unscoring_cards)
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 40
        end
        return false
    end
}