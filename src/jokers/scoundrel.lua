SMODS.Joker {
    key = 'scoundrel',
    atlas = 'placeholders',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            Xmult = 5,
            poker_hand = 'Five of a Kind'
        }
    },
    rarity = 2,
    cost = 6,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.poker_hand
            }
        }
    end,
    calculate = function(self, card, context)
        --local highest_hand = 'Flush Five'
        if context.joker_main then
            if G.GAME.hands[context.scoring_name].order > G.GAME.hands[card.ability.extra.poker_hand].order then
                card.ability.extra.poker_hand = context.scoring_name
                return {
                    xmult = card.ability.extra.Xmult,
                }
            end
        end
        if context.after and card.ability.extra.poker_hand == 'High Card' then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = "Broken!",
            }
        end
    end
}