SMODS.Joker {
    key = 'palace',
    atlas = 'bgn_joker_sprites',
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
        if context.after then
            for _, playing_card in ipairs(G.hand.cards) do
                draw_card(G.hand, G.discard, 90, 'up', nil, playing_card)
            end
        end
    end
}