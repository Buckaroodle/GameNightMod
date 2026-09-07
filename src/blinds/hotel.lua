SMODS.Blind {
    key = 'hotel',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 10 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('E96F6F'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.before then
            return {
                dollars = -(G.GAME.hands[context.scoring_name].level)
            }
        end
    end
}

