SMODS.Joker {
    key = 'bananasplit',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'food',
        'mult',
        'chance'
    },
    pos = {
        x = 0,
        y = 7
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 4,
            mult = 32,
        }
    },
    rarity = 1,
    cost = 5,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'bgn_bananasplit', card.ability.extra.numerator, card.ability.extra.denominator) then
                if card.ability.extra.mult / 2 < 1 then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.RED
                    }
                else
                    card.ability.extra.mult = card.ability.extra.mult / 2
                    return {
                        message = "Split!",
                    }
                end
            end
        end
    end
}