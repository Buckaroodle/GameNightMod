SMODS.Joker {
    key = 'mancala',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 4,
        y = 5
    },
    config = {
        extra = {
            chips = 40
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
            local stone_cards = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then
                    stone_cards = stone_cards + 1
                end
            end
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    chips = card.ability.extra.chips * stone_cards
                }
            end
        end
    end
}