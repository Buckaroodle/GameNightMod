SMODS.Joker {
    key = 'freecell',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'joker_slot',
        'joker'
    },
    pos = {
        x = 3,
        y = 2
    },
    config = {
        extra = {
            slots_per_neg = 1,
            extra_slots_given = 0,
            extra_slot_max = 3,
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return {
            vars = {
                card.ability.extra.slots_per_neg,
                card.ability.extra.extra_slots_given,
                card.ability.extra.extra_slot_max,
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.joker_type_destroyed or context.selling_card) and context.card.ability.set == 'Joker' and context.card ~= card then
            if context.card.edition and context.card.edition.type == 'negative' then
                if card.ability.extra.extra_slots_given < card.ability.extra.extra_slot_max then
                    G.jokers:change_size(1)
                    card.ability.extra.extra_slots_given = card.ability.extra.extra_slots_given + 1
                end
            end
        end
        --[[if context.selling_self then
            G.jokers:change_size(-card.ability.extra.extra_slots_given)
        end]]
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers:change_size(-card.ability.extra.extra_slots_given)
    end
}