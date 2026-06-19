SMODS.Joker {
    key = 'palace',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'discard',
    },
    pos = {
        x = 2,
        y = 2
    },
    config = {
        extra = {
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and #context.full_hand == 1 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local any_selected = nil
                                    local selected_card_limit_mod = #G.hand.cards - 5
                                    if #G.hand.cards > 5 then
                                        SMODS.change_discard_limit(selected_card_limit_mod)
                                    end
                                    for _, playing_card in ipairs(G.hand.cards) do
                                        G.hand:add_to_highlighted(playing_card, true)
                                        any_selected = true
                                        --play_sound('card1', 1)
                                    end
                                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                                    if selected_card_limit_mod > 0 then
                                        SMODS.change_discard_limit(-selected_card_limit_mod)
                                    end
                                    return true
                                end,
                            }))
                            delay(0.7)
                            G.E_MANAGER:add_event(Event({
                                trigger = 'immediate',
                                func = (function()
                                    --SMODS.juice_up_blind()
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                                        blockable = false,
                                        blocking = false,
                                        func = function()
                                            play_sound('tarot2', 0.76, 0.4); return true
                                        end
                                    }))
                                    play_sound('tarot2', 1, 0.4)
                                    return true
                                end)
                            }))
                            delay(0.4)
                            return true
                        end,
                    }))
                return true
                end,
            }))
        end
    end
    --[[calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.press_play then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local any_selected = nil
                    local _cards = {}
                    for _, playing_card in ipairs(G.hand.cards) do
                        _cards[#_cards + 1] = playing_card
                    end
                    for i = 1, 2 do
                        if G.hand.cards[i] then
                            local selected_card, card_index = pseudorandom_element(_cards, 'vremade_hook')
                            G.hand:add_to_highlighted(selected_card, true)
                            table.remove(_cards, card_index)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                    return true
                end
            }))
            blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
            delay(0.7)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4); return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    return true
                end)
            }))
            delay(0.4)
        end
    end]]

    --SMODS.change_discard_limit(card.ability.extra.limit)
}