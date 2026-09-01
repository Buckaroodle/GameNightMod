SMODS.Joker {
    key = 'ur',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult', 'chance'
    },
    pos = {
        x = 1,
        y = 7
    },
    soul_pos = {
        x = 2,
        y = 7
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 2,
            Xmult_gain = 1,
            Xmult = 1
        }
    },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.Xmult_gain,
                card.ability.extra.Xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'bgn_ur', card.ability.extra.numerator, card.ability.extra.denominator) then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end
    end
}