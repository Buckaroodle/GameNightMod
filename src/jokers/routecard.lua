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
    key = 'routecard',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'hand_type',
        'rank',
        'scaling'
    },
    pos = {
        x = 3,
        y = 4
    },
    config = {
        extra = {
            Xmult = 1,
            Xmult_gain = 0.25,
            rank_1_string = 'Ace',
            rank_2_string = 'Four',
            type = 'Straight'
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_gain,
                card.ability.extra.rank_1,
                card.ability.extra.rank_2,
                card.ability.extra.rank_1_string,
                card.ability.extra.rank_2_string,
                localize(card.ability.extra.type, 'poker_hands')
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands[card.ability.extra.type]) and not context.blueprint then
            local first_rank = false
            local second_rank = false
            for _, scoring_card in ipairs(context.scoring_hand) do
                if scoring_card:get_id() == card.ability.extra.rank_1 then
                    first_rank = true
                elseif scoring_card:get_id() == card.ability.extra.rank_2 then
                    second_rank = true
                end
            end
            if first_rank and second_rank then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local random = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
            local first_number = pseudorandom_element(random, 'bgn_routecard')
            local second_number = first_number + 3
            card.ability.extra.rank_2 = second_number
            if first_number == 1 then
                card.ability.extra.rank_1 = 14
                card.ability.extra.rank_1_string = 'Ace'
            else
                card.ability.extra.rank_1 = first_number
                card.ability.extra.rank_1_string = integer_to_rank(first_number)
            end
            card.ability.extra.rank_2_string = integer_to_rank(second_number)
            return {
                message = "New Route!",
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local random = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
        local first_number = pseudorandom_element(random, 'bgn_routecard')
        local second_number = first_number + 3
        --if first_number == 1 then
            --card.ability.extra.rank_1 = 14
        --else
            card.ability.extra.rank_1 = first_number
        -- end
        card.ability.extra.rank_2 = second_number
        card.ability.extra.rank_1_string = integer_to_rank(first_number)
        card.ability.extra.rank_2_string = integer_to_rank(second_number)
    end
}