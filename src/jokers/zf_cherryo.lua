SMODS.Joker {
    key = 'cherryo',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'food',
    },
    pos = {
        x = 6,
        y = 9
    },
    config = {
        extra = {
            Xmult = 2,
        }
    },
    rarity = 1,
    cost = 5,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and context.removed and #context.removed > 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = 'Popped!',
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}