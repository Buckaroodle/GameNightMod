SMODS.Back {
    key = "stocked",
    atlas = 'bgn_joker_sprites',
    pos = { x = 3, y = 6 },
    config = {
        current_reroll_cost = 0
    },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return {
            vars = {
                --self.config.current_reroll_cost
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
        --self.config.current_reroll_cost = 0
    end,
    --[[calculate = function(self, back, context)
        if context.reroll_shop then
            self.config.current_reroll_cost = context.cost + 1
        end
        if context.end_of_round then
            G.GAME.current_round.reroll_cost = self.config.current_reroll_cost
            G.GAME.round_resets.reroll_cost = self.config.current_reroll_cost
        end
    end]]
}

local calculate_reroll_cost_ref = calculate_reroll_cost -- this is a hook, basically we're creating a variable equivalent to an existing function
function calculate_reroll_cost(skip_increment, ...) -- then this function runs instead of the normal function
    if G.GAME.selected_back_key.key == "b_bgn_stocked" then -- check to see if the deck is the right one
        if G.GAME.current_round.free_rerolls < 0 then G.GAME.current_round.free_rerolls = 0 end
        if G.GAME.current_round.free_rerolls > 0 then
            G.GAME.current_round.reroll_cost = 0; return -- if free rerolls exist, then we set cost to 0
        end
        G.GAME.bgn_reroll_cost_increase = G.GAME.bgn_reroll_cost_increase or 0 -- global variable created to track total rerolls
        if not skip_increment then G.GAME.bgn_reroll_cost_increase = G.GAME.bgn_reroll_cost_increase +
        1 end -- increase variable by 1
        G.GAME.current_round.reroll_cost = (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost) +
        G.GAME.bgn_reroll_cost_increase -- set cost equal to normal + total rerolls (INSTEAD of the normal "+ reroll increase")
        return
    end
    return calculate_reroll_cost_ref(skip_increment, ...) -- we return the normal function if any other deck
end