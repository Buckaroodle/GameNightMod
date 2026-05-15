SMODS.Joker {
    key = 'tripleletterscore',
    atlas = 'placeholders',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 0,
            chips_gain = 3,
            --total_letters = 0
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_gain,
                --card.ability.extra.total_letters
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_letters = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    --if G.jokers.cards[i] ~= card then
                        local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key }) 
                        --local text = G.jokers.cards[i].center.name
                        local _, letterCount = text:gsub("%a", "")
                        total_letters = total_letters + letterCount
                    --end
                end
            end
            card.ability.extra.chips = card.ability.extra.chips_gain * total_letters
            return
            {
                chips = card.ability.extra.chips_gain * total_letters
            }
        end
    end
}