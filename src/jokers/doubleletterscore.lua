SMODS.Joker {
    key = 'doubleletterscore',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 2,
        y = 3
    },
    pixel_size = { h = 71 },
    config = {
        extra = {
            chips = 34,
            chips_gain = 2,
            --total_letters = 0
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_gain,
                --card.ability.extra.total_letters
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
                func = function() 
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
                    return true 
                end,
            }))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            --local total_letters = 0
            G.E_MANAGER:add_event(Event({
                func = function() 
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
                    return true 
                end,
            }))
            return
            {
                chips = card.ability.extra.chips
            }
        end
        if context.card_added or context.joker_type_destroyed or context.selling_card then
            G.E_MANAGER:add_event(Event({
                func = function() 
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
                    return true 
                end,
            }))
        end
    end
}