SMODS.Joker {
    key = 'othello',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'modify_card',
        'suit',
        'hand_type'
    },
    pos = {
        x = 3,
        y = 7
    },
    config = {
        extra = {
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand >= 3 then
            card.ability.extra.convert_suits = false
            local is_spades = context.scoring_hand[1]:is_suit("Spades")
            local is_hearts = context.scoring_hand[1]:is_suit("Hearts")
            local is_clubs = context.scoring_hand[1]:is_suit("Clubs")
            local is_diamonds = context.scoring_hand[1]:is_suit("Diamonds")
            card.ability.extra.target_suit = 'Spades'
            if context.scoring_hand[#context.scoring_hand]:is_suit('Spades') and is_spades then
                card.ability.extra.target_suit = 'Spades'
                card.ability.extra.convert_suits = true
            elseif context.scoring_hand[#context.scoring_hand]:is_suit('Hearts') and is_hearts then
                card.ability.extra.target_suit = 'Hearts'
                card.ability.extra.convert_suits = true
            elseif context.scoring_hand[#context.scoring_hand]:is_suit('Clubs') and is_clubs then
                card.ability.extra.target_suit = 'Clubs'
                card.ability.extra.convert_suits = true
            elseif context.scoring_hand[#context.scoring_hand]:is_suit('Diamonds') and is_diamonds then
                card.ability.extra.target_suit = 'Diamonds'
                card.ability.extra.convert_suits = true
            end
        end
        if context.after and card.ability.extra.convert_suits and not context.blueprint then
            local target_cards = {}
            for _, playing_card in ipairs(context.scoring_hand) do
                if not playing_card:is_suit(card.ability.extra.target_suit) then
                    target_cards[#target_cards+1] = playing_card
                end
            end
            --[[G.E_MANAGER:add_event(Event({
                func = function() 
                    local target_suit = context.scoring_hand[1].base.suit
                    for _, playing_card in ipairs(context.scoring_hand) do
                        if not playing_card:is_suit(target_suit) then
                            SMODS.change_base(playing_card, target_suit)
                        end
                    end
                    return true
                end,
            }))]]
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
            }))
            for i = 1, #target_cards do
                local percent = 1.15 - (i - 0.999) / (#target_cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        target_cards[i]:flip()
                        play_sound('card1', percent)
                        target_cards[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #target_cards do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        SMODS.change_base(target_cards[i], card.ability.extra.target_suit)
                        return true
                    end
                }))
            end
            for i = 1, #target_cards do
                local percent = 0.85 + (i - 0.999) / (#target_cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        target_cards[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        target_cards[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
            --[[G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)]]
        end
    end
}