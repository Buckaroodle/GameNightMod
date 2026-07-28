SMODS.Joker {
    key = 'yacht',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'reroll',
        'economy'
    },
    pos = {
        x = 4,
        y = 8
    },
    config = {
        extra = {
            money = 8,
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
        --[[if context.starting_shop then
            card.ability.extra.reroll_count = G.GAME.round_scores.times_rerolled.amt
        end
        --[[if context.reroll_shop then
            card.ability.extra.rerolled_shop = true
        end
        if context.ending_shop and not card.ability.extra.rerolled_shop then
            return {
                dollars = card.ability.extra.money
            }
        end]]
        if context.ending_shop and G.GAME.round_scores.times_rerolled.amt == G.GAME.total_rerolls_on_shop_entry then
            return {
                dollars = card.ability.extra.money
            }
        end
    end,

    --G.GAME.total_rerolls_on_shop_entry
}