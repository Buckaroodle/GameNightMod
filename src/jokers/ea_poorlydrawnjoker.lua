SMODS.Joker {
    key = 'poorlydrawnjoker',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'hand_size',
        'joker_slot'
    },
    pos = {
        x = 2,
        y = 9
    },
    config = {
        extra = {
            hand_size = 0
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.hand_size = 0
        local count = 0
        card.ability.extra.hand_size = G.jokers.config.card_limit-#G.jokers.cards
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    update = function(self, card, dt)
        if G.jokers then
            if card.added_to_deck then
                G.hand:change_size((G.jokers.config.card_limit-#G.jokers.cards)-card.ability.extra.hand_size)
            end
            card.ability.extra.hand_size = G.jokers.config.card_limit-#G.jokers.cards
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end
}