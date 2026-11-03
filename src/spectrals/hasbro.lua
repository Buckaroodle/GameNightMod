SMODS.Consumable {
    key = 'hasbro',
    atlas = 'bgn_consumables',
    set = 'Spectral',
    pos = {
        x = 4,
        y = 2
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bgn_mini
    end,
    use = function(self, card, area, copier)
        local destructable_cards = {}
        for i = 1, #G.consumeables.cards do
            if G.consumeables.cards[i] ~= card and not SMODS.is_eternal(G.consumeables.cards[i], card) then
                destructable_cards[#destructable_cards+1] = G.consumeables.cards[i]
            end
        end
        local card_to_destroy = pseudorandom_element(destructable_cards, 'bgn_hasbro')
        if card_to_destroy then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    SMODS.destroy_cards(card_to_destroy)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'bgn_hasbro')
                eligible_card:set_edition("e_bgn_wee")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}