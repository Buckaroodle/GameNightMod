SMODS.Blind {
    key = 'domino',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 2 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('96C7CA'),
    recalc_debuff = function(self, card, from_blind)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp or SMODS.has_no_rank(card) or not card:get_id() then
            return false
        end
        if card.area ~= G.jokers and not SMODS.has_no_rank(card) and ((card:get_id() == 14) or (card:get_id() == 2)) then
            return true
        end
        return false
    end
}