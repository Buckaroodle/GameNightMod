SMODS.Seal {
    key = 'chance',
    atlas = 'bgn_consumables',
    pos = { x = 4, y = 0 },
    config = { extra = { inc = 1 } },
    badge_colour = G.C.GREEN,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.inc } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand then
            if context.mod_probability then
                return {
                    numerator = context.numerator + self.config.extra.inc,
                    denominator = context.denominator + self.config.extra.inc
                }
            end
        end
    end
}