SMODS.Blind {
    key = 'icterinerack',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 14 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX('D4DB5C'),
    modifies_draw = true,
    calculate = function(self, blind, context)

        if context.blind_disabled then
            G.hand:change_size(-blind.hand_size_orig)
        end

        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 0
            }
        end

        if context.setting_blind then
            blind.hand_size_orig = G.hand.config.card_limit
            G.hand:change_size(blind.hand_size_orig)
        end

        if context.blind_defeated then
            G.hand:change_size(-blind.hand_size_orig)
        end
    end
}

