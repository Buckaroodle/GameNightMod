SMODS.Blind {
    key = 'pawn',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 3 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('E696B0'),
    
    stay_flipped = function(self, area, card)
        if area == G.hand then
            if next(SMODS.get_enhancements(card)) then
                return true
            end
        end
    end,

    disable = function(self)
        for k, v in pairs(G.hand.cards) do
            if v.facing == 'back' then
                v:flip()
            end
            for k, v in pairs(G.playing_cards) do
                v.ability.wheel_flipped = nil
            end
        end
    end,

    defeat = function(self)
        for k, v in pairs(G.hand.cards) do
            if v.facing == 'back' then
                v:flip()
            end
            for k, v in pairs(G.playing_cards) do
                v.ability.wheel_flipped = nil
            end
        end
    end
}