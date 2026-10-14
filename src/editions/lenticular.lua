SMODS.Shader {
    key = 'lenticular',
    path = 'lenticular.fs',
}

local function get_cycle_integer(x)
    return ((x - 1) % 4) + 1
end

SMODS.Edition {
    key = 'lenticular',
    shader = 'lenticular',
    config = {
        chips = 40,
        mult = 8,
        money = 2,
        xmult = 1.4,
        number = 40,
        pre_number = '+',
        post_number = ' chips',
        style = 'chips',
        x_style = ''
    },
    in_shop = true,
    weight = 5,
    extra_cost = 3,
    loc_vars = function(self, info_queue, card)
        local position_abr
        card.edition.style = G.C.CHIPS
        card.edition.x_style = G.C.WHITE
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if card == G.jokers.cards[i] then
                    position_abr = get_cycle_integer(i)
                end
            end
        end
        if G.hand then
            for i = 1, #G.hand.cards do
                if card == G.hand.cards[i] then
                    position_abr = get_cycle_integer(i)
                end
            end
        end
        if G.hand then
            if G.hand.highlighted then
                local copy = {}
                for k, v in pairs(G.hand.highlighted) do
                    copy[k] = v
                end
                table.sort(copy, function(a, b) return a.T.x < b.T.x end)
                for i = 1, #copy do
                    if card == copy[i] then
                        position_abr = get_cycle_integer(i)
                    end
                end
            end
        end
        if position_abr == 1 then
            card.edition.number = card.edition.chips --chips
            card.edition.pre_number = '+'
            card.edition.post_number = ' chips'
            card.edition.style = G.C.CHIPS
            card.edition.x_style = G.C.WHITE
        elseif position_abr == 2 then
            card.edition.number = card.edition.mult --mult
            card.edition.pre_number = '+'
            card.edition.post_number = ' Mult'
            card.edition.style = G.C.MULT
            card.edition.x_style = G.C.WHITE
        elseif position_abr == 3 then
            card.edition.number = card.edition.money --money
            card.edition.pre_number = '$'
            card.edition.post_number = ''
            card.edition.style = G.C.MONEY
            card.edition.x_style = G.C.WHITE
        elseif position_abr == 4 then
            card.edition.number = card.edition.xmult --xmult
            card.edition.pre_number = 'X'
            card.edition.post_number = ' Mult'
            card.edition.style = G.C.WHITE
            card.edition.x_style = G.C.MULT
        end
        local color = card.edition.style
        local color2 = card.edition.x_style
        return { vars = { card.edition.chips, card.edition.mult, card.edition.money, card.edition.xmult, card.edition.number, card.edition.pre_number, card.edition.post_number, card.edition.style, card.edition.x_style, colours = {color, color2} } }
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            local position_abr
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if card == G.jokers.cards[i] then
                        position_abr = get_cycle_integer(i)
                    end
                end
            end
            --[[if G.hand.highlighted then
                for i = 1, #G.hand.highlighted do
                    if card == G.hand.highlighted[i] then
                        position_abr = get_cycle_integer(i)
                    end
                end
            end]]
            if G.play then
                for i = 1, #G.play.cards do
                    if card == G.play.cards[i] then
                        position_abr = get_cycle_integer(i)
                    end
                end
            end
            if position_abr == 1 then
                card.edition.number = card.edition.chips
                return {
                    chips = card.edition.number
                }
            elseif position_abr == 2 then
                card.edition.number = card.edition.mult
                return {
                    mult = card.edition.number
                }
            elseif position_abr == 3 then
                card.edition.number = card.edition.money
                return {
                    dollars = card.edition.number
                }
            elseif position_abr == 4 then
                card.edition.number = card.edition.xmult
                return {
                    x_mult = card.edition.number
                }
            end
        end
    end
}