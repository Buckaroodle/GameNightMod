SMODS.Consumable {
    key = 'squeezers',
    atlas = 'bgn_consumables',
    set = 'Tarot',
    pos = {
        x = 5,
        y = 0
    },
    cost = 3,
    config = { req_highlighted = 2, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.req_highlighted } }
    end,
    use = function(self, card, area, copier)
        local sum = 0
        for i = 1, #G.hand.highlighted do
            sum = sum + G.hand.highlighted[i]:get_id()
        end
        local average_rank = math.ceil(sum / 2)
        local average_rank_string = tostring(average_rank)
        if average_rank == 11 then
            average_rank_string = 'Jack'
        elseif average_rank == 12 then
            average_rank_string = 'Queen'
        elseif average_rank == 13 then
            average_rank_string = 'King'
        elseif average_rank == 14 then
            average_rank_string = 'Ace'
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.change_base(G.hand.highlighted[i], G.hand.highlighted[i].base.suit, average_rank_string))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted == card.ability.req_highlighted
    end
}