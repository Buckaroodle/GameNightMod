SMODS.Consumable {
    key = 'aristocrat',
    atlas = 'bgn_consumables',
    set = 'Tarot',
    pos = {
        x = 2,
        y = 0
    },
    cost = 3,
    config = { extra = { consumeables = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.consumeables } }
    end,
    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.consumeables, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        local card_types = {'Tarot', 'Planet'}
                        local edition = SMODS.poll_edition { key = "bgn_congress", guaranteed = true, no_negative = true, options = { 'e_holo', 'e_foil' } }
                        local chosen_type = pseudorandom_element(card_types, 'bgn_congress')
                        play_sound('timpani')
                        SMODS.add_card({ set = chosen_type, key_append = "bgn_congress", edition = edition })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
         return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or
            (card.area == G.consumeables)
    end
}