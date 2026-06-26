SMODS.Enhancement {
    key = 'holepunched',
    atlas = 'placeholders',
    --atlas = 'bgn_enhancements',
    pos = { x = 3, y = 2 },
    --[[config = { money = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.money } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            ease_dollars(card.ability.money)
            return {
                message = localize('$')..card.ability.money,
                colour = G.C.MONEY,
                card = card
            }
        end
    end,]]
}