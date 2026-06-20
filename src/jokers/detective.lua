local function integer_to_rank(id)
    local rank = nil
    for k, v in pairs(SMODS.Ranks) do
        if v.id == id then
            rank = v.key
        end
    end
    return rank
end

SMODS.Joker {
    key = 'detective',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'rank',
        'suit',
        'hand_type',
    },
    pos = {
        x = 0,
        y = 6
    },
    config = {
        extra = {
            Xmult = 3,
            rank_string = '???',
            suit_string = '???',
            poker_hand_string = '???'
        }
    },
    rarity = 1,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.rank_string,
                card.ability.extra.suit_string,
                card.ability.extra.poker_hand_string,
                card.ability.extra.chosen_rank,
                card.ability.extra.chosen_suit,
                card.ability.extra.chosen_hand_type,
                --colours = { G.C.SUITS[assassin_card.suit] }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == card.ability.extra.chosen_hand_type and card.ability.extra.poker_hand_string == '???' then
                card.ability.extra.poker_hand_string = context.scoring_name
                return {
                    message = "Updated!",
                }
            end
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == card.ability.extra.chosen_rank and card.ability.extra.rank_string == '???' then
                    card.ability.extra.rank_string = integer_to_rank(card.ability.extra.chosen_rank)
                    return {
                        message = "Updated!",
                    }
                end
                if playing_card:is_suit(card.ability.extra.chosen_suit) and card.ability.extra.suit_string == '???' then
                    card.ability.extra.suit_string = card.ability.extra.chosen_suit
                    return {
                        message = "Updated!",
                    }
                end
            end
        end
        if context.individual and context.cardarea == G.play and context.scoring_name == card.ability.extra.chosen_hand_type and
            context.other_card:get_id() == card.ability.extra.chosen_rank and
            context.other_card:is_suit(card.ability.extra.chosen_suit) then
                return {
                    xmult = card.ability.extra.Xmult
                }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        if G.playing_cards ~= nil then
            local valid_detective_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
                    valid_detective_cards[#valid_detective_cards + 1] = playing_card
                end
            end
            local detective_card = pseudorandom_element(valid_detective_cards, 'bgn_detective')
            if detective_card then
                card.ability.extra.chosen_rank = detective_card:get_id()
                card.ability.extra.chosen_suit = detective_card.base.suit
            end
            local detective_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    detective_hands[#detective_hands + 1] = handname
                end
            end
            card.ability.extra.chosen_hand_type = pseudorandom_element(detective_hands, 'bgn_detective')
        else
            card.ability.extra.chosen_rank = 14
            card.ability.extra.chosen_suit = 'Spades'
            card.ability.extra.chosen_hand_type = 'High Card'
        end
        --card.ability.extra.chosen_rank = pseudorandom_element(detective_ranks, 'bgn_detective')
        --card.ability.extra.chosen_suit = pseudorandom_element(detective_suits, 'bgn_detective')
        --card.ability.extra.rank_string = '???'
        --card.ability.extra.suit_string = '???'
        --card.ability.extra.
    end
    
}

