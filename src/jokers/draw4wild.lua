SMODS.Joker {
    key = 'draw4wild',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = {
            handsize_mod = 1,
            hand_size = 0,
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.handsize_mod,
                card.ability.extra.handsize,
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
    card.ability.extra.hand_size = math.floor(count/4)
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
            if card.added_to_deck then
                G.hand:change_size(math.floor(count/4)-card.ability.extra.hand_size)
            end
            card.ability.extra.hand_size = math.floor(count/4)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end


}