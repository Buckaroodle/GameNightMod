SMODS.Blind {
    key = 'miniature',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 11 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('41967B'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.after then
            local eligible_cards = {}
            local chosen_cards = {}
            for i, playing_card in ipairs(G.hand.cards) do
                print(playing_card:get_id())
                if not SMODS.has_no_rank(playing_card) and playing_card:get_id() ~= 2 then
                    print('HELO')
                    eligible_cards[#eligible_cards+1] = playing_card
                    --table.insert(eligible_cards, playing_card) 
                    print(#eligible_cards)
                end
            end
            --print(#eligible_cards)
            for i = 1, 3 do
                if eligible_cards[1] then
                    local selected_card, card_index = pseudorandom_element(eligible_cards, 'bgn_miniature')
                    chosen_cards[#chosen_cards+1] = selected_card
                    table.remove(eligible_cards, card_index)
                end
            end
            --print(#chosen_cards)
            for i = 1, #chosen_cards do
                local percent = 1.15 - (i - 0.999) / (#chosen_cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        chosen_cards[i]:flip()
                        play_sound('card1', percent)
                        chosen_cards[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #chosen_cards do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                        assert(SMODS.modify_rank(chosen_cards[i], -1))
                        return true
                    end
                }))
            end
            for i = 1, #chosen_cards do
                local percent = 0.85 + (i - 0.999) / (#chosen_cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        chosen_cards[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        chosen_cards[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
        end
    end
}

