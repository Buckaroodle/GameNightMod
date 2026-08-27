SMODS.Joker {
    key = 'admiral',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'destroy_card',
        'enhancement'
    },
    pos = {
        x = 4,
        y = 3
    },
    rarity = 1,
    cost = 5,
    enhancement_gate = 'm_bgn_holepunched',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bgn_holepunched
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, "m_bgn_holepunched") then
            return {
                remove = true,
                delay = 0.45
            }
        end
    end
}