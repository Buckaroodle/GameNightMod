SMODS.Consumable {
    key = 'daysofwonder',
    atlas = 'bgn_consumables',
    set = 'Spectral',
    pos = {
        x = 0,
        y = 2
    },
    cost = 4,
    config = { extra = { numerator = 1, denominator = 6 } },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom } }
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'bgn_daysofwonder', card.ability.extra.numerator, card.ability.extra.denominator) then
            local chosen_joker = pseudorandom_element(G.jokers.cards, 'vremade_ankh_choice')
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.4,
                func = function()
                    local copied_joker = SMODS.copy_card(chosen_joker)
                    copied_joker:start_materialize()
                    copied_joker:set_edition("e_negative")
                    return true
                end
            }))
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Spectral,
                        align = (G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end
}