local contains = function (tbl, item)
    for k, v in pairs(tbl) do
        if v == item then
            return true
        end
    end
    return false
end

SMODS.Joker {
    key = 'gradedcard',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
        'sell_value',
        'debuff',
        'position',
    },
    pos = {
        x = 4,
        y = 4
    },
    config = {
        extra = {
            mult_per_dollar = 3,
            current_mult = 0, 
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        if card.area == G.consumeables then
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i] == card and G.consumeables.cards[i+1] ~= nil and G.consumeables.cards[i+1].ability.set == 'Joker' then
                    sell_cost = G.consumeables.cards[i+1].sell_cost
                end
            end
        elseif card.area == G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i+1] ~= nil then
                    sell_cost = G.jokers.cards[i+1].sell_cost
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult_per_dollar,
                card.ability.extra.mult_per_dollar * (sell_cost or 0)
            }
        }
    end,
    update = function(self, card, dt)
        if G.jokers then
            local sleeves = SMODS.find_card("j_bgn_gradedcard")
            if #sleeves > 0 then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card and not G.jokers.cards[i].debuff then
                        if G.jokers.cards[i+1] and not G.jokers.cards[i+1].debuff then
                            G.jokers.cards[i+1].debuff = true
                            G.jokers.cards[i+1].ability.bgn_cardsleeve_debuff = true
                        end
                    end
                end
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        if G.jokers.cards[i-1] or G.jokers.cards[i-1] == nil then
                            if not contains(sleeves, G.jokers.cards[i-1]) and G.jokers.cards[i].ability.bgn_cardsleeve_debuff then
                                if G.jokers.cards[i].debuff then
                                    G.jokers.cards[i].debuff = false
                                    G.jokers.cards[i].ability.bgn_cardsleeve_debuff = false
                                end
                            end
                        end
                    end
                end
            else
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.bgn_cardsleeve_debuff then
                        if G.jokers.cards[i].debuff then
                            G.jokers.cards[i].debuff = false
                            G.jokers.cards[i].ability.bgn_cardsleeve_debuff = false
                        end
                    end
                end
            end
        end
        if G.consumeables then --compat for mini edition
            local sleeves = SMODS.find_card("j_bgn_gradedcard")
            if #sleeves > 0 then
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i] == card and not G.consumeables.cards[i].debuff then
                        if G.consumeables.cards[i+1] and not G.consumeables.cards[i+1].debuff and G.consumeables.cards[i+1].ability.set == 'Joker' then
                            G.consumeables.cards[i+1].debuff = true
                            G.consumeables.cards[i+1].ability.bgn_cardsleeve_debuff = true
                        end
                    end
                end
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i] ~= card and G.consumeables.cards[i].ability.set == 'Joker' then
                        if G.consumeables.cards[i-1] or G.consumeables.cards[i-1] == nil then
                            if not contains(sleeves, G.consumeables.cards[i-1]) and G.consumeables.cards[i].ability.bgn_cardsleeve_debuff then
                                if G.consumeables.cards[i].debuff then
                                    G.consumeables.cards[i].debuff = false
                                    G.consumeables.cards[i].ability.bgn_cardsleeve_debuff = false
                                end
                            end
                        end
                    end
                end
            else
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' and G.consumeables.cards[i].ability.bgn_cardsleeve_debuff then
                        if G.consumeables.cards[i].debuff then
                            G.consumeables.cards[i].debuff = false
                            G.consumeables.cards[i].ability.bgn_cardsleeve_debuff = false
                        end
                    end
                end
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.bgn_cardsleeve_debuff then
                if G.jokers.cards[i].debuff then
                    G.jokers.cards[i].debuff = false
                    G.jokers.cards[i].ability.bgn_cardsleeve_debuff = false
                end
            end
        end
        for i = 1, #G.consumeables.cards do --compat for mini edition
            if G.consumeables.cards[i].ability.set == 'Joker' and G.consumeables.cards[i].ability.bgn_cardsleeve_debuff then
                if G.consumeables.cards[i].debuff then
                    G.consumeables.cards[i].debuff = false
                    G.consumeables.cards[i].ability.bgn_cardsleeve_debuff = false
                end
            end
        end
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            if card.area == G.consumeables then
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i] == card and G.consumeables.cards[i+1] ~= nil and G.consumeables.cards[i+1].ability.set == 'Joker' then
                        sell_cost = G.consumeables.cards[i+1].sell_cost
                    end
                end
            else
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card and G.jokers.cards[i+1] ~= nil then
                        sell_cost = G.jokers.cards[i+1].sell_cost
                    end
                end
            end
            return {
                mult = card.ability.extra.mult_per_dollar * sell_cost
            }
        end
    end
}