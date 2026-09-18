SMODS.Joker {
    key = 'newrule',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mod_chance',
        'passive'
    },
    pos = {
        x = 2,
        y = 1
    },
    config = {
        extra = {
            num_inc = 0,
            denom_inc = 0,
            num_ex = 0,
            denom_ex = 0
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.num_inc,
                card.ability.extra.denom_inc,
                card.ability.extra.num_ex,
                card.ability.extra.denom_ex
            }
        }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator + card.ability.extra.num_inc,
                denominator = context.denominator + card.ability.extra.denom_inc
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss then
                local num_table = {0, 1, 2, 3}
                local denom_table = {0, 1, 2, 3, 4}
                card.ability.extra.num_inc = pseudorandom_element(num_table, 'vremade_to_do')
                card.ability.extra.denom_inc = pseudorandom_element(denom_table, 'vremade_to_do')
                card.ability.extra.num_ex = card.ability.extra.num_inc + 1
                card.ability.extra.denom_ex = card.ability.extra.denom_inc + 4
            end
        end
    end,
    
    set_ability = function(self, card, initial, delay_sprites)
        local num_table = {0, 1, 2, 3}
        local denom_table = {0, 1, 2, 3, 4}
        card.ability.extra.num_inc = pseudorandom_element(num_table, 'vremade_to_do')
        card.ability.extra.denom_inc = pseudorandom_element(denom_table, 'vremade_to_do')
        card.ability.extra.num_ex = card.ability.extra.num_inc + 1
        card.ability.extra.denom_ex = card.ability.extra.denom_inc + 4
    end
}