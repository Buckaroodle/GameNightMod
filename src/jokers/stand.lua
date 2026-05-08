SMODS.Joker {
    key = 'stand',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = {
            mult = 15
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ranks, bust = {}, false
            for k, v in pairs(G.hand.cards) do -- go through all cards held in hand
                if ranks[v:get_id()] then -- does this rank have an entry in the dictionary?
                    bust = true -- if so, it's a repeat rank. BUST!
                end
                ranks[v:get_id()] = true -- now we add it to the dictionary
            end
            if bust == false then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}