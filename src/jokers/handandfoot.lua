SMODS.Joker {
    key = 'handandfoot',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'hands',
        'passive',
    },
    pos = {
        x = 4,
        y = 9
    },
    config = {
        extra = {
            hands_mod = 1,
            consumable_slots_mod = 1,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands_mod,
                card.ability.extra.consumable_slots_mod,
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands_mod
                --G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.hands_mod
                ease_hands_played(card.ability.extra.hands_mod)
                --ease_discard(card.ability.extra.hands_mod)
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slots_mod
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands_mod
                --G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.hands_mod
                ease_hands_played(-card.ability.extra.hands_mod)
                --ease_discard(-card.ability.extra.hands_mod)
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slots_mod
                return true
            end
        }))
    end
}