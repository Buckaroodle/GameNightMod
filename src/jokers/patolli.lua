SMODS.Joker {
    key = 'patolli',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'economy',
    },
    pos = {
        x = 1,
        y = 8
    },
    soul_pos = {
        x = 2,
        y = 8
    },
    config = {
        extra = {
        }
    },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            return {
                dollars = G.GAME.hands[context.scoring_name].level,
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
}