SMODS.Joker {
    key = 'scoundrel',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 0,
        y = 3
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_gain = 0.5,
            poker_hand = 'N/A'
        }
    },
    rarity = 3,
    cost = 8,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_gain,
                card.ability.extra.poker_hand
            }
        }
    end,
    calculate = function(self, card, context)
        --local highest_hand = 'Flush Five'
        if context.before and not context.blueprint then
            if card.ability.extra.poker_hand ~= nil and card.ability.extra.poker_hand ~= 'N/A' then
                if G.GAME.hands[context.scoring_name].order > G.GAME.hands[card.ability.extra.poker_hand].order then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                else--if G.GAME.hands[context.scoring_name].order <= G.GAME.hands[SMODS.last_hand.scoring_name].order then
                    card.ability.extra.Xmult = 1
                    return {
                        message = localize('k_reset')
                    }
                end
            end
            card.ability.extra.poker_hand = context.scoring_name
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult,
            }
        end
    end
}