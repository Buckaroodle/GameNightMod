SMODS.Enhancement {
    key = 'chance',
    atlas = 'bgn_consumables',
    pos = { x = 5, y = 0 },
    config = { extra = { num_inc = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.num_inc } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand then
            if context.mod_probability then
                return {
                    numerator = context.numerator + card.ability.extra.num_inc,
                }
            end
        end
    end
}