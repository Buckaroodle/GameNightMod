SMODS.Joker {
    key = 'fishwish',
    atlas = 'placeholders',
    attributes = {
        'passive'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 2,
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.create_booster_card and not context.blueprint then
            if context.booster.ability.name:find('Standard') then
                if SMODS.pseudorandom_probability(card, 'bgn_fishwish', card.ability.extra.numerator, card.ability.extra.denominator) then
                    --if context.index:get_id() ~= 4 then
                        local ranks_list = {}
                        for i, playing_card in ipairs(G.playing_cards) do
                            if playing_card:get_id() ~= nil then
                                ranks_list[playing_card:get_id()] = (ranks_list[playing_card:get_id()] or 0) + 1
                            end
                        end
                        local highest_rank = 0
                        local highest_value = {1}
                        for i = 2, #ranks_list do
                            if ranks_list[i] > highest_rank then
                                highest_rank = ranks_list[i]
                                highest_value = {i}
                            elseif ranks_list[i] == highest_rank then
                                highest_value[#highest_value+1] = i
                            end
                        end
                        print(highest_rank)
                        print(highest_value)
                        local chosen_rank = pseudorandom_element(highest_value, 'bgn_fishwish')
                        --local chosen_rank = 4
                        if chosen_rank == 14 then
                            chosen_rank = 'Ace'
                        elseif chosen_rank == 13 then
                            chosen_rank = 'King'
                        elseif chosen_rank == 12 then
                            chosen_rank = 'Queen'
                        elseif chosen_rank == 11 then
                            chosen_rank = 'Jack'
                        end
                        --print(chosen_rank)
                        return {
                            booster_create_flags = { set = "Playing Card", rank = chosen_rank, key_append = "bgn_fishwish" }
                        }
                    --end
                end
            end
        end
    end
}