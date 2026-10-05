SMODS.Joker {
    key = 'maj',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'hand_size'
    },
    pos = {
        x = 6,
        y = 0
    },
    config = {
        extra = {
            hand_size = 5,
        }
    },
    rarity = 3,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size,
            }
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end
}

local discardref = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
    local ref = discardref(e)
    if next(SMODS.find_card("j_bgn_maj")) and #G.hand.highlighted > 1 then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
    else
        return ref
    end
end