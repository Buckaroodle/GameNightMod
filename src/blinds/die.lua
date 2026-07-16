SMODS.Blind {
    key = 'die',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 1 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('97DE84'),
    calculate = function(self, blind, context)
        if context.fix_probability then
            return {
                numerator = 0
            }
        end
    end
}