SMODS.Joker {
    key = 'freecell',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 3,
        y = 2
    },
    config = {
        extra = {
            slots_per_neg = 1,
            extra_slots_given = 0
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.slots_per_neg,
                card.ability.extra.extra_slots_given,
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.joker_type_destroyed or context.selling_card) and context.card.ability.set == 'Joker' and context.card ~= card then
            if context.card.edition and context.card.edition.type == 'negative' then
                G.jokers:change_size(1)
                card.ability.extra.extra_slots_given = card.ability.extra.extra_slots_given + 1
            end
        end
        if context.selling_self then
            G.jokers:change_size(-card.ability.extra.extra_slots_given)
        end
    end
}