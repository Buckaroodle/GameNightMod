SMODS.Blind {
    key = 'ship',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 9 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('3C6B75'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.modify_hand then
            --print(G.GAME.current_round.hands_left)
            if G.GAME.current_round.hands_left % 2 == 0 then
                mult = mod_mult(1)
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            else
                hand_chips = mod_chips(1)
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end
}

