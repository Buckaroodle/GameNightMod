SMODS.Edition {
    key = 'wee',
    shader = false,
    in_shop = true,
    weight = 3,
    extra_cost = 3,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    on_apply = function(card)
        if G.jokers then
            if card.area == G.jokers then
                local card_copy = card.area:remove_card(card)
                G.consumeables:emplace(card_copy)
            end
        end
        if card.config.center.key == "j_wee" then
            card.T.h = card.original_T.h*(0.4)
            card.T.w = card.original_T.w*(0.4)
        elseif card.config.center.key == 'j_square' then

        else
            card.T.h = card.original_T.h*(0.7)
            card.T.w = card.original_T.w*(0.7)
        end
    end,
    on_remove = function(card)
        if card.config.center.key == "j_wee" then
            card.T.h = card.original_T.h*(0.7)
            card.T.w = card.original_T.w*(0.7)
        else
            card.T.h = card.original_T.h
            card.T.w = card.original_T.w
        end
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.consumeables then
                    if card.area == G.consumeables then
                        local card_copy = card.area:remove_card(card)
                        G.jokers:emplace(card_copy)
                    end
                end
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.buying_self then
            G.consumeables:emplace(card)
        end
    end
}

local bgn_check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.edition and card.edition.key == "e_bgn_wee" then
        card.ability.set = ""
        card.ability.consumeable = true
    end
    local ret = bgn_check_for_buy_space_ref(card)
    if card.edition and card.edition.key == "e_bgn_wee" then
        card.ability.set = "Joker"
        card.ability.consumeable = nil
    end
    return ret
end

local bgn_can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    local card = e.config.ref_table
    local card_limit = card.ability.card_limit - card.ability.extra_slots_used
    if card.edition and card.edition.key == "e_bgn_wee" then
        e.config.colour = G.C.GREEN
        e.config.button = 'use_card'
    else
        bgn_can_select_card_ref(e)
    end
end

-- provided below are code changes to all the vanilla jokers, tarots, and blinds that the mini edition completely fuck with

--[[SMODS.Joker:take_ownership('j_abstract',
    {
config = { extra = { mult = 3 } },
loc_vars = function(self, info_queue, card)
    local joker_count = 0
    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.set == 'Joker' then
                joker_count = joker_count + 1
            end
        end
    end
    if G.consumeables then
        for i = 1, #G.consumeables.cards do
            if G.consumeables.cards[i].ability.set == 'Joker' then
                joker_count = joker_count + 1
            end
        end
    end
    return { vars = { card.ability.extra.mult, card.ability.extra.mult * (G.jokers and G.consumeables and joker_count or 0) } }
end,
calculate = function(self, card, context)
    if context.joker_main then
        local joker_count = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    joker_count = joker_count + 1
                end
            end
        end
        if G.consumeables then
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Joker' then
                    joker_count = joker_count + 1
                end
            end
        end
        return {
            mult = card.ability.extra.mult * joker_count
        }
    end
end
    },
    true -- silent | suppresses mod badge
)]]

SMODS.Joker:take_ownership('j_madness',
    {
        config = { extra = { xmult_gain = 0.5, xmult = 1 } },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
            if context.setting_blind and not context.blueprint and not context.blind.boss then
                -- See note about SMODS Scaling Manipulation on the wiki
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                        destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
                    end
                end
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i] ~= card and G.consumeables.cards[i].ability.set == 'Joker' and not SMODS.is_eternal(G.consumeables.cards[i], card) and not G.consumeables.cards[i].getting_sliced then
                        destructable_jokers[#destructable_jokers+1] = G.consumeables.cards[i]
                    end
                end
                local joker_to_destroy = pseudorandom_element(destructable_jokers, 'madness')

                if joker_to_destroy then
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            (context.blueprint_card or card):juice_up(0.8, 0.8)
                            joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                end
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end,
    },
    true
)

SMODS.Joker:take_ownership('j_blueprint',
    {
        loc_vars = function(self, info_queue, card)
            if card.area then
                local other_joker
                if card.area == G.jokers then
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
                    end
                elseif card.area == G.consumeables then
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i] == card then other_joker = G.consumeables.cards[i+1] end
                    end
                end
                local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
                local main_end = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", minh = 0.4 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                                }
                            }
                        }
                    }
                }
                return { main_end = main_end }
            end
        end,
        calculate = function(self, card, context)
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i] == card then other_joker = G.consumeables.cards[i+1] end
            end
            local ret = SMODS.blueprint_effect(card, other_joker, context)
            if ret then
                ret.colour = G.C.BLUE
            end
            return ret
        end,
    },
    true
)

SMODS.Joker:take_ownership('j_invisible',
    {
        calculate = function(self, card, context)
            if context.selling_self and (card.ability.invis_rounds >= card.ability.extra) and not context.blueprint then
                local jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card then
                        jokers[#jokers + 1] = G.jokers.cards[i]
                    end
                end
                if #G.consumeables.cards < G.consumeables.config.card_limit and not (card.edition and card.edition.key == 'e_bgn_wee') then --if the consumable slots are NOT full AND the invis joker is NOT mini then
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i] ~= card and G.consumeables.cards[i].ability.set == 'Joker' then
                            jokers[#jokers+1] = G.consumeables.cards[i]
                        end
                    end
                end
                if #jokers > 0 then
                    if #G.jokers.cards <= G.jokers.config.card_limit then
                        local chosen_joker = pseudorandom_element(jokers, 'invisible')
                        local copied_joker = SMODS.copy_card(chosen_joker,
                            { strip_edition = chosen_joker.edition and chosen_joker.edition.negative })
                        if copied_joker.ability.invis_rounds then copied_joker.ability.invis_rounds = 0 end
                        if type(copied_joker.ability) == "table" and copied_joker.ability.invis_rounds then copied_joker.ability.invis_rounds = 0 end
                        return { message = localize('k_duplicated_ex') }
                    else
                        return { message = localize('k_no_room_ex') }
                    end
                else
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability.set == 'Joker' then
                            return { message = localize('k_no_room_ex') }
                        end
                    end
                    return { message = localize('k_no_other_jokers') }
                end
                return nil, true
            end
            if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                card.ability.invis_rounds = card.ability.invis_rounds + 1
                if card.ability.invis_rounds == card.ability.extra then
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
                return {
                    message = (card.ability.invis_rounds < card.ability.extra) and
                        (card.ability.invis_rounds .. '/' .. card.ability.extra) or
                        localize('k_active_ex'),
                    colour = G.C.FILTER
                }
            end
        end,
    },
    true
)

SMODS.Joker:take_ownership('j_perkeo',
    {
        calculate = function(self, card, context)
            if context.ending_shop and G.consumeables.cards[1] then
                local can_trigger = false
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set ~= 'Joker' then
                        can_trigger = true
                    end
                end
                if can_trigger then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local valid_consumeables = {}
                            for i = 1, #G.consumeables.cards do
                                if G.consumeables.cards[i].ability.set == 'Joker' then
                                else
                                    valid_consumeables[#valid_consumeables+1] = G.consumeables.cards[i]
                                end
                            end
                            local card_to_copy = pseudorandom_element(valid_consumeables, 'perkeo')
                            local copied_card = SMODS.copy_card(card_to_copy)
                            copied_card:set_edition("e_negative", true)
                            return true
                        end
                    }))
                    return { message = localize('k_duplicated_ex') }
                else
                    return { message = ':)' } -- if a message isn't returned, the code gets a mind of its own for some reason idk
                end
            end
        end,
    }
)

SMODS.Blind:take_ownership('final_heart',
    {
        calculate = function(self, card, context)
            if context.ending_shop and G.consumeables.cards[1] then
                local can_trigger = false
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set ~= 'Joker' then
                        can_trigger = true
                    end
                end
                if can_trigger then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local valid_consumeables = {}
                            for i = 1, #G.consumeables.cards do
                                if G.consumeables.cards[i].ability.set == 'Joker' then
                                else
                                    valid_consumeables[#valid_consumeables+1] = G.consumeables.cards[i]
                                end
                            end
                            local card_to_copy = pseudorandom_element(valid_consumeables, 'perkeo')
                            local copied_card = SMODS.copy_card(card_to_copy)
                            copied_card:set_edition("e_negative", true)
                            return true
                        end
                    }))
                    return { message = localize('k_duplicated_ex') }
                else
                    return { message = ':)' } -- if a message isn't returned, the code gets a mind of its own for some reason idk
                end
            end
        end,
    }
)