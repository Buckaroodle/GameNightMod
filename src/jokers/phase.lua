SMODS.Joker {
    key = 'phase',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
        'scaling',
        'reset',
        'hand_type'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            mult = 0,
            mult_gain = 5,
            hand_types_this_ante = {}
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_gain,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local already_played = false
            for i, hand_type in ipairs(card.ability.extra.hand_types_this_ante) do
                if hand_type == context.scoring_name then
                    already_played = true
                end
            end
            if not already_played then
                card.ability.extra.hand_types_this_ante[#card.ability.extra.hand_types_this_ante + 1] = context.scoring_name
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.mult > 1 then
                card.ability.extra.mult = 0
                card.ability.extra.hand_types_this_ante = {}
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
    end
}