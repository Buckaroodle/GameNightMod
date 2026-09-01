SMODS.Joker {
    key = 'draw4wild',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'enhancements',
        'hand_size',
        'full_deck'
    },
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            handsize_mod = 1,
            wilds_per_handsize = 4,
            hand_size = 0,
            handsize_max = 4,
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    enhancement_gate = 'm_wild',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.extra.handsize_mod,
                card.ability.extra.wilds_per_handsize,
                card.ability.extra.hand_size,
                card.ability.extra.handsize_max,
            }
        }
    end,
  
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.hand_size = 0
        local count = 0
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_wild') then
                count = count+1
            end
        end
        card.ability.extra.hand_size = math.min(math.floor(count / 4), card.ability.extra.handsize_max)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    update = function(self, card, dt)
        if G.playing_cards then
            local count = 0
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_wild') then
                    count = count+1
                end
            end

            local new_hand_size = math.min(math.floor(count / 4), card.ability.extra.handsize_max)

            if card.added_to_deck then
                G.hand:change_size(new_hand_size - card.ability.extra.hand_size)
            end
            card.ability.extra.hand_size = new_hand_size
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end


}