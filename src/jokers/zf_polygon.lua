SMODS.Joker {
    key = 'polygon',
    atlas = 'placeholders',
    attributes = {
        'chance',
        'edition',
        'rank',
        'six',
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 6,
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
        --[[if context.individual and context.cardarea == G.play then
            if not SMODS.has_no_rank(context.other_card) and context.other_card:get_id() == 6 and SMODS.pseudorandom_probability(card, 'bgn_polygon', card.ability.extra.numerator, card.ability.extra.denominator) then
               context.other_card:set_edition('e_polychrome')
            end
        end]]
        if context.before then
            --local fail = false
            for i, playing_card in ipairs(context.full_hand) do
                if not SMODS.has_no_rank(playing_card) and playing_card:get_id() ~= 6 then
                    print('test!')
                    --fail = true
                    return
                end
            end
            --if not fail then
                for i, playing_card in ipairs(context.scoring_hand) do
                    if SMODS.pseudorandom_probability(card, 'bgn_polygon', card.ability.extra.numerator, card.ability.extra.denominator) then
                        playing_card:set_edition('e_polychrome')
                    end
                end
            --end
        end
    end
}