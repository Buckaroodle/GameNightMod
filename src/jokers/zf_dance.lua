--[[SMODS.Joker {
    key = 'dance',
    atlas = 'placeholders',
    attributes = {
        'economy',
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            money = 2
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money
            }
        }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            local hand_type = G.FUNCS.get_poker_hand_info(G.hand.cards)
            print(hand_type)
        end
    end,
}]]