SMODS.Enhancement {
    key = 'chance',
    atlas = 'bgn_consumables',
    pos = { x = 5, y = 0 },
    config = { extra = { inc = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.inc } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand then
            if context.mod_probability then
                return {
                    numerator = context.numerator + card.ability.extra.inc,
                    denominator = context.denominator + card.ability.extra.inc
                }
            end
        end
    end
}