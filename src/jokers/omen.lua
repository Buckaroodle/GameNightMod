SMODS.Joker {
    key = 'omen',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'generation', 'chance', 'mod_chance'
    },
    pos = {
        x = 5,
        y = 1
    },
    pixel_size = { w = 49 },
    config = {
        extra = {
            numerator = 1,
            denominator = 13,
            inc = 1
        }
    },
    rarity = 2,
    cost = 6,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.inc
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'bgn_omen'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral }, context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'vremade_gros_michel', card.ability.extra.numerator, card.ability.extra.denominator) then
                SMODS.destroy_cards(card, nil, nil, true)
            else
                card.ability.extra.numerator = card.ability.extra.numerator + card.ability.extra.inc
                return {
                    message = '+1 Odds'
                }
            end
        end
    end
}