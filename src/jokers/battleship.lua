SMODS.Joker {
    key = 'battleship',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'enhancement'
    },
    pos = {
        x = 4,
        y = 3
    },
    rarity = 2,
    cost = 6,
    config = {
        extra = {
            Xmult_gain = 0.25,
            Xmult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bgn_holepunched
        if G.bgn_holepunched_discard ~= nil then
            local cards_in_limbo = #G.bgn_holepunched_discard.cards or 0
            card.ability.extra.Xmult = 1 + (cards_in_limbo * card.ability.extra.Xmult_gain)
        else
            card.ability.extra.Xmult = 1
        end
        return {
            vars = {
                card.ability.extra.Xmult_gain,
                card.ability.extra.Xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.bgn_holepunched_discard ~= nil then
                local cards_in_limbo = #G.bgn_holepunched_discard.cards or 0
                card.ability.extra.Xmult = 1 + (cards_in_limbo * card.ability.extra.Xmult_gain)
            else
                card.ability.extra.Xmult = 1
            end
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}