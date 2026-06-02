SMODS.Joker {
    key = 'chancellor',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'scaling',
        'reset',
    },
    pos = {
        x = 4,
        y = 7
    },
    config = {
        extra = {
            chips = 0,
            chips_gain = 10,
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_gain,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.bgn_interacting_with_booster_card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.skipping_booster and card.ability.extra.chips > 0 then
            card.ability.extra.chips = 0
            return {
                message = localize('k_reset'),
                colour = G.C.BLUE
            }
        end
    end
}

local use_card_ref = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave, ...)
    if e.config.ref_table.area == G.pack_cards then
        SMODS.calculate_context({bgn_interacting_with_booster_card = true})
    end
return use_card_ref(e, mute, nosave, ...)
end