SMODS.Joker {
    key = 'hungryhippo',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'joker'
    },
    pos = {
        x = 1,
        y = 6
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_gain = 1
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed and context.card:has_attribute('food') then
            --if context.card:has_attribute('food') then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            --end
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}