SMODS.Joker {
    key = 'hungryhippo',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_gain = 1
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_gain
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed then
            if context.card:has_attribute('food') then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}