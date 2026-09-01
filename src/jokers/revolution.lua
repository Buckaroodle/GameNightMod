SMODS.Joker {
    key = 'revolution',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult', 'hand_type', 'two', 'three', 'four', 'five'
    },
    pos = {
        x = 5,
        y = 8
    },
    config = {
        extra = {
            xmult = 2,
            active = false
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                --card.ability.extra.active,
                localize("bgn_".. (card.ability.extra.active and "active" or "inactive"))
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Four of a Kind']) then
            card.ability.extra.active = true
            if not context.blueprint then
                local eval = function(card) return card.ability.extra.active == true and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == (2 or 3 or 4 or 5) and card.ability.extra.active then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.active then
            card.ability.extra.active = false
        end
    end
}