SMODS.Blind {
    key = 'buzzer',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 19 },
    attributes = { 'hand_type', 'discard' },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 10 },
    boss_colour = HEX('B1695B'),
    calculate = function(self, blind, context)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp then
            return
        end
        --[[if context.pre_discard and not temp then
            local text,_ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            G.GAME.current_round.bgn_buzzer.allowed_hands[#G.GAME.current_round.bgn_buzzer.allowed_hands+1] = text
        end]]
      
        --[[if context.setting_blind then
            blind.effect.hands = {}
            for _, poker_hand in ipairs(G.handlist) do
                blind.effect.hands[poker_hand] = false
            end
        end]]
        --[[if context.debuff_hand then
            if not blind.effect.hands[context.scoring_name] then
                blind.triggered = true
                return {
                    debuff = true
                }
            end
        end]]
        --[[if context.pre_discard then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            blind.effect.hands[text] = true
        end]]
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        local bool = true
        if G.GAME.hands[handname].discarded_this_ante == nil then
            bool = true
        elseif G.GAME.hands[handname].discarded_this_ante > 0 then
            bool = false
        end
        blind.triggered = bool
        return bool
    end,
}