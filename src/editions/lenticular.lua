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
        money = 3,
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
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
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

SMODS.Consumable:take_ownership('wheel_of_fortune',
    {
        config = { extra = { odds = 4 } },
        loc_vars = function(self, info_queue, card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
                'vremade_wheel_of_fortune')
                --info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
                --info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
                --info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
                --info_queue[#info_queue + 1] = G.P_CENTERS.e_bgn_lenticular
            return { vars = { numerator, denominator } }
        end,
        use = function(self, card, area, copier)
            if SMODS.pseudorandom_probability(card, 'vremade_wheel_of_fortune', 1, card.ability.extra.odds) then
                local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

                local eligible_card = pseudorandom_element(editionless_jokers, 'vremade_wheel_of_fortune')
                local edition = SMODS.poll_edition { key = "vremade_wheel_of_fortune", guaranteed = true, no_negative = true }
                if edition == 'e_bgn_wee' then
                    edition = 'e_polychrome'
                end
                eligible_card:set_edition(edition, true)
                check_for_unlock({ type = 'have_edition' })
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end,
    },
    true
)

SMODS.Consumable:take_ownership('aura',
    {
        config = { max_highlighted = 1 },
        loc_vars = function(self, info_queue, card)
            --info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
            --info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
            --info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
            --info_queue[#info_queue + 1] = G.P_CENTERS.e_bgn_lenticular
            return { vars = { card.ability.max_highlighted } }
        end,
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local edition = SMODS.poll_edition { key = "vremade_aura", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil', 'e_bgn_lenticular' } }
                    local aura_card = G.hand.highlighted[1]
                    aura_card:set_edition(edition, true)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end,
    },
    true
)