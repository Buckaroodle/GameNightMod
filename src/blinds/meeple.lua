--[[SMODS.Blind {
    key = 'meeple',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('FFFD82'),
    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.debuff = true
        end
    end
}]]