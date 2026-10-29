SMODS.Joker {
    key = 'phases',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
        'scaling',
        'reset',
        'hand_type',
        'space'
    },
    pos = {
        x = 3,
        y = 8
    },
    config = {
        extra = {
            mult = 0,
            mult_gain = 5,
            hand_types_this_ante = {}
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        --if G.hand_list then
        --print('test')
        --print(G.handlist)
            for i, poker_hand in ipairs(G.handlist) do
                if G.GAME.hands[poker_hand].played_this_ante > 0 then
                    local match_found = false
                    for i, hand in ipairs(card.ability.extra.hand_types_this_ante) do
                        if poker_hand == hand then
                            match_found = true
                        end
                    end
                    if match_found == false then
                        card.ability.extra.hand_types_this_ante[#card.ability.extra.hand_types_this_ante+1] = poker_hand
                    end
                else
                    for i, hand in ipairs(card.ability.extra.hand_types_this_ante) do
                        if poker_hand == hand then
                            table.remove(card.ability.extra.hand_types_this_ante, i)
                        end
                    end
                end
            end
        --end
        local nodes = {}
        local index = 0
        for i = #card.ability.extra.hand_types_this_ante, 1, -1 do
            local key = card.ability.extra.hand_types_this_ante[i]
            nodes[#nodes+1] = {n = G.UIT.R, config = {align = "cm", padding = 0.02}, nodes = {
                {n = G.UIT.T, config = {text = key, colour = G.C.UI.TEXT_INACTIVE, scale = 0.25}}
            }} 
            index = index + 1
        end
        return {
            vars = {
                card.ability.extra.mult_gain * #card.ability.extra.hand_types_this_ante,
                card.ability.extra.mult_gain,
            },
            main_end = {
                {n = G.UIT.R, config = {align = "cm"}, nodes = nodes}
            },
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local already_played = false
            for i, hand_type in ipairs(card.ability.extra.hand_types_this_ante) do
                if hand_type == context.scoring_name then
                    already_played = true
                end
            end
            if not already_played then
                card.ability.extra.hand_types_this_ante[#card.ability.extra.hand_types_this_ante + 1] = context.scoring_name
                --card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult_gain * #card.ability.extra.hand_types_this_ante
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss then
                --card.ability.extra.mult = 0
                card.ability.extra.hand_types_this_ante = {}
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
    end
}

--G.GAME.hands[text].played_this_ante