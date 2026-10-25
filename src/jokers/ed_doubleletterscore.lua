SMODS.Joker {
    key = 'doubleletterscore',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'joker'
    },
    pos = {
        x = 2,
        y = 3
    },
    pixel_size = { h = 71 },
    config = {
        extra = {
            chips_gain = 2,
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local total_letters = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key }) 
                local _, letterCount = text:gsub("%a", "")
                total_letters = total_letters + letterCount
            end
        end
        if G.consumeables then --check for mini edition
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Joker' then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.consumeables.cards[i].config.center.key }) 
                    local _, letterCount = text:gsub("%a", "")
                    total_letters = total_letters + letterCount
                end
            end
        end
        return {
            vars = {
                card.ability.extra.chips_gain,
                card.ability.extra.chips_gain * (G.jokers and G.consumeables and total_letters or 0)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
                local total_letters = 0
                if G.jokers then
                    for i = 1, #G.jokers.cards do
                            local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key }) 
                            local _, letterCount = text:gsub("%a", "")
                            total_letters = total_letters + letterCount
                    end
                end
                if G.consumeables then --check for mini edition
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability.set == 'Joker' then
                            local text = localize({ type = 'name_text', set = "Joker", key = G.consumeables.cards[i].config.center.key }) 
                            local _, letterCount = text:gsub("%a", "")
                            total_letters = total_letters + letterCount
                        end
                    end
                end
            return
            {
                chips = card.ability.extra.chips_gain * (G.jokers and G.consumeables and total_letters or 0)
            }
        end
    end
}