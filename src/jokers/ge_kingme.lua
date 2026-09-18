SMODS.Joker {
    key = 'kingme',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'king', 'modify_card', 'hands', 'rank'
    },
    pos = {
        x = 5,
        y = 6
    },
    rarity = 2,
    cost = 7,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and G.GAME.current_round.hands_left == 0 then
        --print('test')
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
                        local playing_card = context.scoring_hand[i]
                        assert(SMODS.change_base(playing_card, nil, 'King'))
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
            delay(0.5)
        end
    end
}