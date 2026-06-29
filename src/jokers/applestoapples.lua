SMODS.Joker {
    key = 'applestoapples',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'modify_card'
    },
    pos = {
        x = 3,
        y = 1
    },
    config = {
        extra = {
        }
    },
    rarity = 3,
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
        }
    end,
    blueprint_compat = false,
    calculate = function(self, card, context)
        -- if the hand played is EXACTLY a pair
        if context.after and context.scoring_hand then
            if context.poker_hands and next(context.poker_hands['Pair']) then
                if #context.full_hand == 2 then
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
                local rightmost = context.scoring_hand[1]
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i].T.x > rightmost.T.x then
                        rightmost = context.scoring_hand[i]
                    end
                end
                for i = 1, #context.scoring_hand do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            if context.scoring_hand[i] ~= rightmost then
                                copy_card(rightmost, context.scoring_hand[i])
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
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    --[[func = function()
                        G.hand:unhighlight_all()
                        return true
                    end]]--
                }))
                delay(0.5)
                end
            end
        end
    end
}