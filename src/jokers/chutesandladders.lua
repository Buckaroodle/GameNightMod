SMODS.Joker {
    key = 'chutesandladders',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'chance',
        'scaling'
    },
    pos = {
        x = 4,
        y = 6
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 5,
            chips = 0,
            chips_inc = 3
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.chips,
                card.ability.extra.chips_inc
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_inc
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.after and SMODS.pseudorandom_probability(card, 'bgn_chutesandladders', card.ability.extra.numerator, card.ability.extra.denominator) and not context.blueprint then
            card.ability.extra.chips = math.ceil(card.ability.extra.chips / 2)
            math.ceil(card.ability.extra.chips)
            return {
                message = "Halved!",
            }
        end
    end
}