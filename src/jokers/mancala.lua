SMODS.Joker {
    key = 'mancala',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 4,
        y = 5
    },
    config = {
        extra = {
            chips = 50
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {    
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}