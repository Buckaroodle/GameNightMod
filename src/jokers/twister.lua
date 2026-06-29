SMODS.Joker {
    key = 'twister',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'seals',
        'passive'
    },
    pos = {
        x = 1,
        y = 9
    },
    config = {
        extra = {
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual then
            if context.cardarea == G.play then
                if context.other_card:get_seal() == 'Purple' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            SMODS.add_card({ set = 'Tarot' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return { message = localize('k_plus_tarot'), colour = G.C.PURPLE }
                end
                if context.other_card:get_seal() == 'Blue' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            if context.scoring_name then
                                local _planet = nil
                                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                                    if planet_center.config.hand_type == context.scoring_name then
                                        _planet = planet_center.key
                                    end
                                end
                                if _planet then
                                    SMODS.add_card({ key = _planet })
                                end
                                G.GAME.consumeable_buffer = 0
                            end
                            return true
                        end
                    }))
                    return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
                end
            end
            if context.cardarea == G.hand then
                if context.other_card:get_seal() == 'Gold' and not context.end_of_round then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 3
                    return {
                        message_card = context.other_card,
                        dollars = 3,
                        func = function() -- This is for timing purposes, it runs after the dollar manipulation
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.dollar_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }
                end
            end
        end
    end
}