SMODS.Joker {
    key = 'bettelmann',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 1,
        y = 3
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 2,
            chips = 100
        }
    },
    rarity = 1,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and SMODS.pseudorandom_probability(card, 'example_prob', card.ability.extra.numerator, card.ability.extra.denominator) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}