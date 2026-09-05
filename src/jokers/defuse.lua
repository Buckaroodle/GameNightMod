SMODS.Joker {
    key = 'defuse',
    atlas = 'bgn_joker_sprites',
    attributes = {
        
    },
    pos = {
        x = 3,
        y = 9
    },
    config = {
        extra = {
            total_rounds = 2,
            defuse_rounds = 0,
        }
    },
    rarity = 3,
    cost = 8,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.total_rounds,
                card.ability.extra.defuse_rounds,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.defuse_rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            if G.GAME.blind and not G.GAME.blind.disabled then
                G.E_MANAGER:add_event(Event({
                blocking = false,
                func = function()
                    if G.STATE == G.STATES.SELECTING_HAND then
                        G.GAME.chips = G.GAME.blind.chips
                        G.STATE = G.STATES.HAND_PLAYED
                        G.STATE_COMPLETE = true
                        end_round()
                        return true
                    end
                end
                }))
            end
        end
        if context.skip_blind and not context.blueprint then
            card.ability.extra.defuse_rounds = card.ability.extra.defuse_rounds + 1
            if card.ability.extra.defuse_rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.defuse_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.defuse_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}