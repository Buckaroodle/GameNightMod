SMODS.Joker {
    key = 'parkplace',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
        'xmult'
    },
    pos = {
        x = 1,
        y = 4
    },
    config = {
        extra = {
            mult = 4,
            Xmult = 2
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.Xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local monopoly = false
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key })   
                        if text == 'Boardwalk' then
                            monopoly = true
                        end
                    end
                end
            end
            if monopoly == true then
                return {
                    mult = card.ability.extra.mult,
                    Xmult = card.ability.extra.Xmult
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}