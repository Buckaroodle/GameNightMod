SMODS.Joker {
    key = 'blackjack',
    atlas = 'placeholders',
    attributes = {
        'chips',
        'scaling',
        'reset',
    },
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {
            chips = 0,
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local chip_total = 0
            local ace_count = 0
            for i, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() ~= nil then
                    local id = playing_card:get_id()
                    if id == 14 then -- count aces separately
                        ace_count = ace_count + 1
                    elseif id <= 13 and id >= 11 then -- count all face cards as 10
                        chip_total = chip_total + 10
                    else -- count all other cards normally
                        chip_total = chip_total + id
                    end
                end
            end
            if chip_total <= 21 and ace_count > 0 then
                for i = 1, ace_count do
                    if chip_total + 11 <= 21 then
                        chip_total = chip_total + 11
                    else
                        chip_total = chip_total + 1
                    end
                end
            end
            if chip_total <= 21 then
                card.ability.extra.chips = card.ability.extra.chips + chip_total
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                }
            else
                card.ability.extra.chips = 0
                return {
                    message = 'Bust!',
                    colour = G.C.BLUE
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