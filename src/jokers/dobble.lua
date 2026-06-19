SMODS.Joker {
    key = 'dobble',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'passive'
    },
    pos = {
        x = 3,
        y = 3
    },
    pixel_size = { h = 71 },
    config = {
        extra = {
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {    
            }
        }
    end,
    calculate = function(self, card, context)
        if context.drawing_cards then
            local ranks = {}
            for k, v in pairs(G.hand.cards) do -- go through all cards held in hand
                local id = v:get_id()
                if id then
                    ranks[id] = true 
                end
            end
            local chosen_cards = {}
            --local target_amount = #context.amount
            for i = #G.deck.cards, 1, -1 do
                if #chosen_cards >= context.amount then
                    break 
                end
                local card = G.deck.cards[i]
                local id = card:get_id()
                if not ranks[id] then -- check if it's in dict. if so ...
                    table.insert(chosen_cards, 1, card) -- add it to new table
                    table.remove(G.deck.cards, i)  -- remove it from deck (temp)
                    ranks[id] = true
                end
            end
            for _, card in ipairs(chosen_cards) do
                table.insert(G.deck.cards, card)
            end
        end
    end
}