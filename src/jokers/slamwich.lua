SMODS.Joker {
    key = 'slamwich',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'retrigger',
        'hand_type'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.poker_hands and next(context.poker_hands['Pair']) then
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
        end
        
    end
}