SMODS.Joker {
    key = 'yacht',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'reroll',
        'economy'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            money = 10,
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            card.ability.extra.rerolled_shop = false
        end
        if context.reroll_shop then
            card.ability.extra.rerolled_shop = true
        end
        if context.ending_shop and not card.ability.extra.rerolled_shop then
            return {
                dollars = card.ability.extra.money
            }
        end
    end
}