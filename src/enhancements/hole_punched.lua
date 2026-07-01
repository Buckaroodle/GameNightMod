SMODS.Enhancement {
    key = 'holepunched',
    --atlas = 'placeholders',
    atlas = 'bgn_consumables',
    pos = { x = 3, y = 0 },
    --[[config = { money = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.money } }
    end,]]
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            --G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
            }))
            return { message = 'Removed!', colour = G.C.YELLOW }
        end
    end,
}