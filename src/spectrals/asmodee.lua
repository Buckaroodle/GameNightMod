SMODS.Consumable {
    key = 'asmodee',
    atlas = 'bgn_consumables',
    set = 'Spectral',
    pos = { x = 2, y = 2 },
    config = { extra = { destroy = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy } }
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end

        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'bgn_asmodee')

        for i = 1, card.ability.extra.destroy do
            destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
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

        SMODS.destroy_cards(destroyed_cards)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, (#temp_hand - card.ability.extra.destroy) do
            local percent = 1.15 - (i - 0.999) / ((#temp_hand - card.ability.extra.destroy) - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    temp_hand[i + card.ability.extra.destroy]:flip()
                    play_sound('card1', percent)
                    temp_hand[i + card.ability.extra.destroy]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, (#temp_hand - card.ability.extra.destroy) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local random_enhancement = SMODS.poll_enhancement {key = "bgn_asmodee", guaranteed = true}
                    temp_hand[i + card.ability.extra.destroy]:set_ability(random_enhancement)
                    return true
                end
            }))
        end
        for i = 1, (#temp_hand - card.ability.extra.destroy) do
            local percent = 0.85 + (i - 0.999) / ((#temp_hand - card.ability.extra.destroy) - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    temp_hand[i + card.ability.extra.destroy]:flip()
                    play_sound('tarot2', percent, 0.6)
                    temp_hand[i + card.ability.extra.destroy]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)

    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    draw = function(self, card, layer)
        -- This is for the Spectral shader. You don't need this with `set = "Spectral"`
        -- Also look into SMODS.DrawStep if you make multiple cards that need the same shader
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}