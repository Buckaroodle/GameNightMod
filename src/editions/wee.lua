SMODS.Sound {
  key = 'wee_sfx',
  path = 'WeeJoker.wav'
}

SMODS.Edition {
    key = 'wee',
    shader = false,
    in_shop = true,
    weight = 3,
    extra_cost = 3,
    sound = { sound = "bgn_wee_sfx", per = 1.2, vol = 0.6 },
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    in_pool = function(self, args)
        if args and args.source:sub(1, 16) == 'standard_edition' or args.source:sub(1, 8) == 'illusion' then
            return false
        else
            return true
        end
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
        elseif card.config.center.key == 'j_half' then
            card.T.h = card.original_T.h/(2.6)
            card.T.w = card.original_T.w*(0.7)
        elseif card.config.center.key == 'j_photograph' then
            card.T.h = card.original_T.h/(1.7)
            card.T.w = card.original_T.w*(0.7)
        elseif card.config.center.key == 'j_bgn_omen' then
            card.T.h = card.original_T.h*(0.7)
            card.T.w = card.original_T.w/(2)
        elseif card.config.center.key == 'j_square'
        or card.config.center.key == 'j_bgn_doubleletterscore'
        or card.config.center.key == 'j_bgn_memory'
        or card.config.center.key == 'j_bgn_dobble' then
            card.T.h = card.original_T.h/(1.8)
            card.T.w = card.original_T.w*(0.7)
        else
            card.T.h = card.original_T.h*(0.7)
            card.T.w = card.original_T.w*(0.7)
        end
        --[[if card.config.center.soul_pos then
            card.children.floating_sprite.T.h = card.children.floating_sprite.original_T.h*(0.7)
            card.children.floating_sprite.T.w = card.children.floating_sprite.original_T.w*(0.7)
            print('test!')
        end]]
    end,
    on_remove = function(card)
        if card.config.center.key == "j_wee" then
            card.T.h = card.original_T.h*(0.7)
            card.T.w = card.original_T.w*(0.7)
        elseif card.config.center.key == 'j_half' then
            card.T.h = card.original_T.h/(1.7)
            card.T.w = card.original_T.w
        elseif card.config.center.key == 'j_photograph' then
            card.T.h = card.original_T.h/(1.2)
            card.T.w = card.original_T.w
        elseif card.config.center.key == 'j_bgn_omen' then
            card.T.h = card.original_T.h
            card.T.w = card.original_T.w/(1.5)
        elseif card.config.center.key == 'j_square'
        or card.config.center.key == 'j_bgn_doubleletterscore'
        or card.config.center.key == 'j_bgn_memory'
        or card.config.center.key == 'j_bgn_dobble' then
            card.T.h = card.original_T.h/(1.3)
            card.T.w = card.original_T.w
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
        --[[if context.buying_self then
            G.consumeables:emplace(card)
        end]]
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

SMODS.Joker:take_ownership('j_abstract',
    {
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
        return { vars = { card.ability.extra, card.ability.extra * (G.jokers and G.consumeables and joker_count or 0) } }
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
                mult = card.ability.extra * joker_count
            }
        end
    end
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('j_swashbuckler',
    {
    loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            if joker ~= card then
                sell_cost = sell_cost + joker.sell_cost
            end
        end
        for _, item in ipairs(G.consumeables and G.consumeables.cards or {}) do
            if item.ability.set == 'Joker' and item ~= card then
                print(item.sell_cost)
                sell_cost = sell_cost + item.sell_cost
            end
        end
        card.ability.mult = sell_cost
        return { vars = { card.ability.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                if joker ~= card then
                    sell_cost = sell_cost + joker.sell_cost
                end
            end
            for _, item in ipairs(G.consumeables and G.consumeables.cards or {}) do
                if item.ability.set == 'Joker' and item ~= card then
                    sell_cost = sell_cost + item.sell_cost
                end
            end
            card.ability.mult = sell_cost
            return {
                mult = card.ability.mult
            }
        end
    end,
    },
    true -- silent | suppresses mod badge
)

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
        name = 'bgn_blueprint',
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
        name = 'bgn_perkeo',
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
                --[[else
                    return { message = ':)' } -- if a message isn't returned, the code gets a mind of its own for some reason idk]]
                end
            end
        end,
    },
    true
)

SMODS.Consumable:take_ownership('c_temperance',
    {
        name = 'bgn_temperance',
        loc_vars = function(self, info_queue, card)
            local money = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.set == 'Joker' then
                        money = money + G.jokers.cards[i].sell_cost
                    end
                end
            end
            if G.consumeables then
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' then
                        money = money + G.consumeables.cards[i].sell_cost
                    end
                end
            end
            card.ability.money = math.min(money, card.ability.extra)

            return { vars = { card.ability.extra, card.ability.money } }
        end,
        use = function(self, card, area, copier)
            local money = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    money = money + G.jokers.cards[i].sell_cost
                end
            end
            if G.consumeables then
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' then
                        money = money + G.consumeables.cards[i].sell_cost
                    end
                end
            end
            card.ability.money = math.min(money, card.ability.extra)

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    card:juice_up(0.3, 0.5)
                    ease_dollars(card.ability.money, true)
                    return true
                end
            }))
            delay(0.6)
        end,
        can_use = function(self, card)
            return true
        end
    },
    true
)

SMODS.Blind:take_ownership('final_heart',
    {
        calculate = function(self, blind, context)
            if context.blind_disabled or context.blind_defeated then
                for _, joker in ipairs(G.jokers.cards) do
                    joker.ability.crimson_heart_chosen = nil
                end
                for _, consumeable in ipairs(G.consumeables.cards) do
                    if consumeable.ability.set == 'Joker' then
                        consumeable.ability.crimson_heart_chosen = nil
                    end
                end
            end

            if blind.disabled then return end

            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.crimson_heart_chosen then
                    return {
                        debuff = true
                    }
                end
            elseif context.debuff_card and context.debuff_card.area == G.consumeables then
                if context.debuff_card.ability.crimson_heart_chosen then
                    return {
                        debuff = true
                    }
                end
            end
            if context.press_play then
                local mini_jokers = 0
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' then
                        mini_jokers = mini_jokers + 1
                    end
                end
                if (G.jokers.cards[1] or mini_jokers >= 2) then
                    blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                    blind.prepped = true
                end
            end
            if context.hand_drawn then
                local mini_jokers = 0
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' then
                        mini_jokers = mini_jokers + 1
                    end
                end
                if blind.prepped and (G.jokers.cards[1] or mini_jokers >= 2) then
                    local prev_chosen_set = {}
                    local fallback_jokers = {}
                    local jokers = {}
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.crimson_heart_chosen then
                            prev_chosen_set[G.jokers.cards[i]] = true
                            G.jokers.cards[i].ability.crimson_heart_chosen = nil
                            if G.jokers.cards[i].debuff then SMODS.recalc_debuff(G.jokers.cards[i]) end
                        end
                    end
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability.crimson_heart_chosen then
                            prev_chosen_set[G.jokers.cards[i]] = true
                            G.jokers.cards[i].ability.crimson_heart_chosen = nil
                            if G.jokers.cards[i].debuff then SMODS.recalc_debuff(G.consumeables.cards[i]) end
                        end
                    end
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff then
                            if not prev_chosen_set[G.jokers.cards[i]] then
                                jokers[#jokers + 1] = G.jokers.cards[i]
                            end
                            table.insert(fallback_jokers, G.jokers.cards[i])
                        end
                    end
                    for i = 1, #G.consumeables.cards do
                        if not G.consumeables.cards[i].debuff then
                            if G.consumeables.cards[i].ability.set == 'Joker' then
                                if not prev_chosen_set[G.consumeables.cards[i]] then
                                    jokers[#jokers + 1] = G.consumeables.cards[i]
                                end
                                table.insert(fallback_jokers, G.consumeables.cards[i])
                            end
                        end
                    end
                    if #jokers == 0 then jokers = fallback_jokers end
                    local _card = pseudorandom_element(jokers, 'vremade_crimson_heart')
                    if _card then
                        _card.ability.crimson_heart_chosen = true
                        SMODS.recalc_debuff(_card)
                        _card:juice_up()
                        blind:wiggle()
                    end
                end
                blind.prepped = nil
            end
        end
    },
    true
)

SMODS.Blind:take_ownership('final_acorn',
    {
        name = 'bgn_acorn',
        calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.setting_blind then
            local mini_jokers = 0
            local shuffle_consumeables = false
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Joker' then
                    mini_jokers = mini_jokers + 1
                    if mini_jokers >= 2 then
                        shuffle_consumeables = true
                    end
                end
            end
            if #G.jokers.cards > 0 or shuffle_consumeables then
                G.jokers:unhighlight_all()
                if shuffle_consumeables then
                    G.consumeables:unhighlight_all()
                end
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:flip()
                end
                if shuffle_consumeables then
                    for i = 1, #G.consumeables.cards do
                        G.consumeables.cards[i]:flip()
                    end
                end
                if #G.jokers.cards > 1 or shuffle_consumeables then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    if shuffle_consumeables then
                                        G.consumeables:shuffle('aajk')
                                    end
                                    play_sound('cardSlide1', 0.85)
                                    return true
                                end,
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    if shuffle_consumeables then
                                        G.consumeables:shuffle('aajk')
                                    end
                                    play_sound('cardSlide1', 1.15)
                                    return true
                                end
                            }))
                            delay(0.15)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.jokers:shuffle('aajk')
                                    if shuffle_consumeables then
                                        G.consumeables:shuffle('aajk')
                                    end
                                    play_sound('cardSlide1', 1)
                                    return true
                                end
                            }))
                            delay(0.5)
                            return true
                        end
                    }))
                end
            end
        end
    end
    },
    true
)