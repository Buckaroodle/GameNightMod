SMODS.Blind {
    key = 'marble',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 22 },
    attributes = { 'face_down' },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('3CB53E'),
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

        if context.stay_flipped and context.to_area == G.hand and
            context.other_card.ability.played_this_ante then
            return {
                stay_flipped = true
            }
        end
    end
}