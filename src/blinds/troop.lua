SMODS.Blind {
    key = 'troop',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 13 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('416B38'),
    calculate = function(self, blind, context)
        if context.blind_disabled then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].facing == 'back' then
                    G.hand.cards[i]:flip()
                end
            end
            for _, playing_card in pairs(G.playing_cards) do
                playing_card.ability.wheel_flipped = nil
            end
        end

        if blind.disabled then return end

        if context.stay_flipped and context.to_area == G.hand and G.GAME.current_round.hands_left % 2 == 0 then
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                return {
                    stay_flipped = true
                }
            end
        elseif context.stay_flipped and context.to_area == G.hand and G.GAME.current_round.hands_left % 2 ~= 0 then
            local id = context.other_card:get_id()
            if (id <= 10 and id >= 0 and id % 2 == 1) or (id == 14) then
                return {
                    stay_flipped = true
                }
            end
        end
    end
}