SMODS.Blind {
    key = 'block',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 24 },
    attributes = { 'hand_type' },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('A13838'),
    --[[debuff_hand = function(self, cards, hand, handname, check) --
        if G.GAME.hands[context.scoring_name].order < G.GAME.hands[SMODS.last_hand.scoring_name].order then
            return false
        else
            G.GAME.blind.triggered = true
            return true
        end
    end,]]
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.debuff_hand then
            if (G.GAME.hands[context.scoring_name].order < G.GAME.hands[SMODS.last_hand.scoring_name or 'High Card'].order) or (G.GAME.current_round.hands_played == 0) then
                return
            else
                G.GAME.blind.triggered = true
                return {
                    debuff = true
                }
            end
        end
    end
}