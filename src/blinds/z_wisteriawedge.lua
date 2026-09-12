SMODS.Blind {
    key = 'wisteriawedge',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 15 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX('C9A0DC'),
    calculate = function(self, blind, context)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp then
            return
        end
        if ((context.hand_drawn and G.GAME.wedge_primed) or (context.first_hand_drawn)) and not temp then
            local cards_in_hand = SMODS.shallow_copy(G.hand.cards)
            local wisteria_cards = {}
            for i = 1, 5 do
                if #cards_in_hand > 0 then
                    local chosen_card, index = pseudorandom_element(cards_in_hand, 'bgn_wisteriawedge')
                    wisteria_cards[#wisteria_cards+1] = chosen_card
                    table.remove(cards_in_hand, index)
                end
            end
            for k, v in pairs(wisteria_cards) do
                G.hand:add_to_highlighted(v)
            end
            G.FUNCS.play_cards_from_highlighted(nil, true)
            ease_hands_played(1)
            G.GAME.bgn_add_next_hand_to_blind = true
        end
        if context.after then
            if not temp then
                if G.GAME.bgn_add_next_hand_to_blind then
                    G.GAME.bgn_add_next_hand_to_blind = nil
                    local score = G.GAME.chips or 0
                    G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    blocking = false,
                    ref_table = G.GAME,
                    ref_value = 'chips',
                    ease_to = score,
                    delay =  0.5,
                    func = (function(t) return math.floor(t) end)
                    }))
                    blind.triggered = true
                    G.GAME.wedge_primed = false
                    return {
                        blindsize = SMODS.calculate_round_score()
                    }
                end
            end
        end
        if context.press_play then
            G.GAME.wedge_primed = true
        end
    end,

    --[[disable = function(self)
        if G.GAME.all_in_jest.advanced_hand_usage_blind[1] then
            All_in_Jest.ease_blind_requirement(nil, -G.GAME.all_in_jest.advanced_hand_usage_blind[1].total_chips)
        end
    end,]]

}