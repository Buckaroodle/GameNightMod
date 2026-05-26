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
    pos = {
        x = 4,
        y = 4
    },
    config = {
        extra = {
            mult_per_dollar = 3,
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        if G.jokers ~= nil then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i+1] ~= nil then
                    sell_cost = G.jokers.cards[i+1].sell_cost
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult_per_dollar * sell_cost
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
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i+1] ~= nil then
                    sell_cost = G.jokers.cards[i+1].sell_cost
                end
            end
            return {
                mult = card.ability.extra.mult_per_dollar * sell_cost
            }
        end
    end
}