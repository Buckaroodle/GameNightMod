SMODS.Joker {
    key = 'pegboard',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'scaling',
        'rank'
    },
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = {
            chips = 0,
            chips_gain = 2
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local total_combos = 0
            local values = {}
            for _, scoring_card in ipairs(context.full_hand) do
                local rank_number = scoring_card:get_id()
                if rank_number == 14 then
                    values[#values + 1] = 1
                elseif rank_number == 13 or rank_number == 12 or rank_number == 11 then
                    values[#values + 1] = 10
                else
                    values[#values + 1] = rank_number
                end
            end

            local function check_sum(index, current_sum)
                for i = index, #values do
                    local new_sum = current_sum + values[i]
                    if new_sum == 15 then
                        total_combos = total_combos + 1
                    elseif new_sum < 15 then
                    check_sum(i + 1, new_sum) -- if under 15 sum, add more cards
                    end
                end
            end

            check_sum(1, 0)

            if total_combos > 0 then
                card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chips_gain * total_combos)
                local upgrade_text = '+' .. (card.ability.extra.chips_gain * total_combos) .. ' Chips'
                return {
                    message = upgrade_text,
                    colour = G.C.CHIPS,
                }
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}