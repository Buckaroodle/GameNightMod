SMODS.Back {
    key = "stocked",
    atlas = 'placeholders',
    pos = { x = 4, y = 2 },
    config = {
        current_reroll_cost = 0
    },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return {
            vars = {
                self.config.current_reroll_cost
            }
        }
    end,
    apply = function(self, back)
        --[[G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_voucher_limit(1)
                SMODS.change_booster_limit(1)
                return true
            end
        }))]]
        change_shop_size(1)
        SMODS.change_voucher_limit(1)
        SMODS.change_booster_limit(1)
        self.config.current_reroll_cost = 0
    end,
    calculate = function(self, back, context)
        if context.reroll_shop then
            self.config.current_reroll_cost = context.cost + 1
        end
        if context.end_of_round then
            G.GAME.current_round.reroll_cost = self.config.current_reroll_cost
            G.GAME.round_resets.reroll_cost = self.config.current_reroll_cost
        end
    end
}