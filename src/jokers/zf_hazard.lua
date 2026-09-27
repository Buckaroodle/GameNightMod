SMODS.Joker {
    key = 'hazard',
    atlas = 'placeholders',
    attributes = {
        'retrigger',
        'rank'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            repetitions = 1,
            chosen_rank = '7',
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
                card.ability.extra.chosen_rank
            }
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and not SMODS.has_no_rank(context.other_card) and context.other_card.base.value == card.ability.extra.chosen_rank then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local die = {1, 2, 3, 4, 5, 6}
            local number1 = pseudorandom_element(die, 'bgn_hazard')
            local number2 = pseudorandom_element(die, 'bgn_hazard')
            card.ability.extra.chosen_rank_id = number1 + number2
            if card.ability.extra.chosen_rank_id == 11 then
                card.ability.extra.chosen_rank = 'Jack'
            elseif card.ability.extra.chosen_rank_id == 12 then
                card.ability.extra.chosen_rank = 'Queen'
            else
                card.ability.extra.chosen_rank = tostring(card.ability.extra.chosen_rank_id)
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local die = {1, 2, 3, 4, 5, 6}
        local number1 = pseudorandom_element(die, 'bgn_hazard')
        local number2 = pseudorandom_element(die, 'bgn_hazard')
        card.ability.extra.chosen_rank_id = number1 + number2
        if card.ability.extra.chosen_rank_id == 11 then
            card.ability.extra.chosen_rank = 'Jack'
        elseif card.ability.extra.chosen_rank_id == 12 then
            card.ability.extra.chosen_rank = 'Queen'
        else
            card.ability.extra.chosen_rank = tostring(card.ability.extra.chosen_rank_id)
        end
    end
}