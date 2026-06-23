SMODS.Consumable {
    key = 'bicycle',
    atlas = 'bgn_consumables',
    set = 'Tarot',
    pos = {
        x = 1,
        y = 0
    },
    cost = 3,
    config = { extra = { numerator = 1, denominator = 2 } },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { num, denom } }
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'bgn_bicycle', card.ability.extra.numerator, card.ability.extra.denominator) then
            local valid_cards = {}
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card.edition == nil then
                    valid_cards[#valid_cards + 1] = playing_card
                end
            end
            local eligible_card = pseudorandom_element(valid_cards, 'bgn_bicycle')
            local edition = SMODS.poll_edition { key = "bgn_bicycle", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } }
            eligible_card:set_edition(edition, true)
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
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
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
        return G.hand and #G.hand.cards > 1
    end
}