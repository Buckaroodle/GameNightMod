SMODS.Joker {
    key = 'othello',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'modify_card',
        'suit',
        'hand_type'
    },
    pos = {
        x = 0,
        y = 0
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
        if context.before then
            card.ability.extra.convert_suits = false
            local last_card_suit = context.scoring_hand[#context.scoring_hand].base.suit
            if context.scoring_hand[1]:is_suit(last_card_suit) then
                card.ability.extra.convert_suits = true
            end
        end
        if context.after and card.ability.extra.convert_suits and not context.blueprint then
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
            for i = 1, #context.scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.scoring_hand[i]:flip()
                        play_sound('card1', percent)
                        context.scoring_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #context.scoring_hand do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local target_suit = context.scoring_hand[1].base.suit
                        for _, playing_card in ipairs(context.scoring_hand) do
                            if not playing_card:is_suit(target_suit) then
                                SMODS.change_base(playing_card, target_suit)
                            end
                        end
                        return true
                    end
                }))
            end
            for i = 1, #context.scoring_hand do
                local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        context.scoring_hand[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        context.scoring_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
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