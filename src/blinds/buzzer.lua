SMODS.Blind {
    key = 'buzzer',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 19 },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 10 },
    boss_colour = HEX('B1695B'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.blind_disabled then
            ease_discard(-1)
        end         
        if context.setting_blind then
            ease_discard(1)
            blind.effect.hands = {}
            for _, poker_hand in ipairs(G.handlist) do
                blind.effect.hands[poker_hand] = false
            end
        end
        if context.debuff_hand then
            if not blind.effect.hands[context.scoring_name] then
                blind.triggered = true
                return {
                    debuff = true
                }
            end
        end
        if context.pre_discard then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            blind.effect.hands[text] = true
        end
    end
}