if not JokerDisplay then return end

local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand

jd_def["j_bgn_bettelmann"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}
jd_def["j_bgn_pegboard"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
}
jd_def["j_bgn_root"] = {
}
jd_def["j_bgn_foundationpile"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "needed_rank", colour = G.C.ORANGE },
        { text = ")" }
    },
}
jd_def["j_bgn_mermaid"] = {
}
jd_def["j_bgn_storedenergy"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local chips = 0
        if #G.hand.highlighted > 0 then
            local _, _, scoring_cards = JokerDisplay.evaluate_hand()
            chips = card.ability.extra.chips * math.max(#G.hand.highlighted - #scoring_cards, 0)
        elseif #G.play.cards > 0 then
            local _, _, scoring_cards = JokerDisplay.evaluate_hand()
            chips = card.ability.extra.chips * math.max(#G.play.cards - #scoring_cards, 0)
        end
        card.joker_display_values.chips = chips
    end
}
jd_def["j_bgn_garbage"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
}
jd_def["j_bgn_phases"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        card.joker_display_values.mult = card.ability.extra.mult_gain * #card.ability.extra.hand_types_this_ante
    end
}
jd_def["j_bgn_assassin"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "assassin_card", colour = G.C.ORANGE },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.assassin_card = G.GAME.current_round.assassin_card.rank
    end
}
jd_def["j_bgn_fishwish"] = {
}
jd_def["j_bgn_boardwalk"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "plus" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
        {
            border_nodes = {
                { ref_table = "card.joker_display_values", ref_value = 'x' },
                { ref_table = "card.joker_display_values", ref_value = 'Xmult', retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        local monopoly = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key })   
                    if text == 'Park Place' then
                        monopoly = true
                    end
                end
            end
        end
        if monopoly == true then
            card.joker_display_values.plus = ''
            card.joker_display_values.mult = ''
            card.joker_display_values.x = 'X'
            card.joker_display_values.Xmult = card.ability.extra.Xmult
        else
            card.joker_display_values.plus = '+'
            card.joker_display_values.mult = card.ability.extra.mult
            card.joker_display_values.x = ''
            card.joker_display_values.Xmult = ''
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        local monopoly = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key })   
                    if text == 'Park Place' then
                        monopoly = true
                    end
                end
            end
        end
        if monopoly == false then
            if text then
                if text.children[1] then
                    text.children[1].config.colour = G.C.MULT
                end
                if text.children[2] then
                    text.children[2].config.colour = G.C.MULT
                end
                if text.children[3] then
                    text.children[3].config.colour = G.C.CLEAR
                end
            end
        else
            if text then
                if text.children[3] then
                    text.children[3].config.colour = G.C.MULT
                end
            end
        end
    end
}
jd_def["j_bgn_parkplace"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "plus" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
        {
            border_nodes = {
                { ref_table = "card.joker_display_values", ref_value = 'x' },
                { ref_table = "card.joker_display_values", ref_value = 'Xmult', retrigger_type = "exp" }
            }
        }
    },
    calc_function = function(card)
        local monopoly = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key })   
                    if text == 'Boardwalk' then
                        monopoly = true
                    end
                end
            end
        end
        if monopoly == true then
            card.joker_display_values.plus = ''
            card.joker_display_values.mult = ''
            card.joker_display_values.x = 'X'
            card.joker_display_values.Xmult = card.ability.extra.Xmult
        else
            card.joker_display_values.plus = '+'
            card.joker_display_values.mult = card.ability.extra.mult
            card.joker_display_values.x = ''
            card.joker_display_values.Xmult = ''
        end
    end,
    style_function = function(card, text, reminder_text, extra)
        local monopoly = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key })   
                    if text == 'Boardwalk' then
                        monopoly = true
                    end
                end
            end
        end
        if monopoly == false then
            if text then
                if text.children[1] then
                    text.children[1].config.colour = G.C.MULT
                end
                if text.children[2] then
                    text.children[2].config.colour = G.C.MULT
                end
                if text.children[3] then
                    text.children[3].config.colour = G.C.CLEAR
                end
            end
        else
            if text then
                if text.children[3] then
                    text.children[3].config.colour = G.C.MULT
                end
            end
        end
    end
}
jd_def["j_bgn_stand"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local ranks, bust = {}, false
        local hand = SMODS.shallow_copy(G.hand.cards)
        for i = #G.hand.cards, 1, -1 do
            for j = 1, #G.hand.highlighted do
                if G.hand.cards[i] == G.hand.highlighted[j] then
                    table.remove(hand, i)
                end
            end
        end
        for k, v in pairs(hand) do
            if not SMODS.has_no_rank(v) then
                if ranks[v:get_id()] then
                    bust = true
                end
                ranks[v:get_id()] = true
            end
        end
        local mult = 0
        for i = 1, #hand do
            mult = mult + (card.ability.extra.mult * JokerDisplay.calculate_card_triggers(hand[i], nil, true))
        end
        if bust then
            card.joker_display_values.mult = 0
        else
            card.joker_display_values.mult = mult
        end
    end
}
jd_def["j_bgn_inagrove"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "number", retrigger_type = "mult" }
    },
    calc_function = function(card)
        local give_mult = false
        local chips_value = 0
        local mult_value = 5
        local number = 0
        local _, _, scoring_cards = JokerDisplay.evaluate_hand()
        for i, playing_card in ipairs(scoring_cards) do
            if SMODS.has_no_rank(playing_card) == false then
                chips_value = math.max(playing_card:get_id(), chips_value, 0)
                mult_value = math.min(playing_card:get_id(), mult_value, 5)
            end
            if not SMODS.has_no_rank(playing_card) and playing_card:get_id() == 5 then
                give_mult = true
            end
        end
        if give_mult == true then
            for i, playing_card in ipairs(scoring_cards) do
                number = number + (mult_value * JokerDisplay.calculate_card_triggers(playing_card))
            end
        else
            for i, playing_card in ipairs(scoring_cards) do
                number = number + (chips_value * JokerDisplay.calculate_card_triggers(playing_card))
            end
        end
        card.joker_display_values.number = number
    end,
    style_function = function(card, text, reminder_text, extra)
        local _, _, scoring_cards = JokerDisplay.evaluate_hand()
        local colour = G.C.CHIPS
        for i, playing_card in ipairs(scoring_cards) do
            if not SMODS.has_no_rank(playing_card) and playing_card:get_id() == 5 then
                colour = G.C.MULT
            end
        end
        if text then
            if text.children[1] then
                text.children[1].config.colour = colour
            end
            if text.children[2] then
                text.children[2].config.colour = colour
            end
        end
    end
}
jd_def["j_bgn_draw4wild"] = {
}
jd_def["j_bgn_detective"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x",                              scale = 0.35 },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.ability.extra", ref_value = "rank_string", colour = G.C.FILTER },
        { text = " of " },
        { ref_table = "card.ability.extra", ref_value = "suit_string", colour = G.C.FILTER },
    },
    extra = {
        {
            { ref_table = "card.ability.extra", ref_value = "poker_hand_string", colour = G.C.FILTER }
        }
    },
    calc_function = function(card)
        local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        if card.ability.extra.rank_string ~= '???' and card.ability.extra.suit_string ~= '???' and card.ability.extra.poker_hand_string ~= '???' then
            if text == card.ability.extra.chosen_hand_type then
                for _, scoring_card in ipairs(scoring_hand) do
                    if not SMODS.has_no_rank(scoring_card) then
                        if scoring_card:get_id() == card.ability.extra.chosen_rank and not SMODS.has_no_suit(scoring_card) and scoring_card:is_suit(card.ability.extra.chosen_suit) then
                            count = count +
                                JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
            end
        end
        card.joker_display_values.count = count
    end
}
jd_def["j_bgn_palace"] = {
}
jd_def["j_bgn_tilejoker"] = {
}
jd_def["j_bgn_bananasplit"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}
jd_def["j_bgn_timelessclassic"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
        local dollars = 0
        local enhancement_counts = {}
        local scoring_enhancements = {}
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, playing_card in ipairs(scoring_hand) do
                local enhancements = SMODS.get_enhancements(playing_card)
                if enhancements then
                    for enh_key, active in pairs(enhancements) do
                        if active then
                            enhancement_counts[enh_key] = (enhancement_counts[enh_key] or 0) + 1
                        end
                    end
                end
            end
            for enh_key, count in pairs(enhancement_counts) do
                if count >= 2 then
                    table.insert(scoring_enhancements, enh_key)
                end
            end
            for _, enhancement in ipairs(scoring_enhancements) do
                for _, scoring_card in pairs(scoring_hand) do
                    if SMODS.has_enhancement(scoring_card, enhancement) then
                        dollars = dollars +
                            card.ability.extra.money * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
            end
        end
        card.joker_display_values.dollars = dollars
    end
}
jd_def["j_bgn_poorlydrawnjoker"] = {
}
jd_def["j_bgn_mancala"] = {
}
jd_def["j_bgn_crazyeights"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}
jd_def["j_bgn_doubleletterscore"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local total_letters = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                    local text = localize({ type = 'name_text', set = "Joker", key = G.jokers.cards[i].config.center.key }) 
                    local _, letterCount = text:gsub("%a", "")
                    total_letters = total_letters + letterCount
            end
        end
        if G.consumeables then --check for mini edition
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Joker' then
                    local text = localize({ type = 'name_text', set = "Joker", key = G.consumeables.cards[i].config.center.key }) 
                    local _, letterCount = text:gsub("%a", "")
                    total_letters = total_letters + letterCount
                end
            end
        end
        card.joker_display_values.chips = card.ability.extra.chips_gain * (G.jokers and G.consumeables and total_letters or 0)
    end
}
jd_def["j_bgn_scoutandshow"] = {
}
jd_def["j_bgn_routecard"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.ability.extra", ref_value = "rank_1_string", colour = G.C.ORANGE },
        { text = " and " },
        { ref_table = "card.ability.extra", ref_value = "rank_2_string", colour = G.C.ORANGE },
    },
}
jd_def["j_bgn_scoundrel"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.ability.extra", ref_value = "poker_hand", colour = G.C.ORANGE },
    },
}
jd_def["j_bgn_applestoapples"] = {
}
jd_def["j_bgn_trafficlight"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "poker_hand", colour = G.C.ORANGE },
    },
    calc_function = function(card)
        if card.ability.extra.green_light == false then
            card.joker_display_values.poker_hand = card.ability.extra.poker_hand
        else
            card.joker_display_values.poker_hand = ''
        end
    end
}
jd_def["j_bgn_hungryhippo"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}
jd_def["j_bgn_dominanttrait"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}
jd_def["j_bgn_blindnil"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
}
jd_def["j_bgn_newrule"] = {
    extra = {
        {
            { ref_table = "card.ability.extra", ref_value = "num_inc" },
            { text = " and " },
            { ref_table = "card.ability.extra", ref_value = "denom_inc" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
}
jd_def["j_bgn_queensgambit"] = {
}
jd_def["j_bgn_kingme"] = {
}
jd_def["j_bgn_cavitysam"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}
jd_def["j_bgn_memory"] = {
}
jd_def["j_bgn_othello"] = {
}
jd_def["j_bgn_dobble"] = {
}
jd_def["j_bgn_safetyzone"] = {
}
jd_def["j_bgn_gradedcard"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local sell_cost = 0
        if card.area == G.consumeables then
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i] == card and G.consumeables.cards[i+1] ~= nil and G.consumeables.cards[i+1].ability.set == 'Joker' then
                    sell_cost = G.consumeables.cards[i+1].sell_cost
                end
            end
        elseif card.area == G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i+1] ~= nil then
                    sell_cost = G.jokers.cards[i+1].sell_cost
                end
            end
        end
        card.joker_display_values.mult = card.ability.extra.mult_per_dollar * (sell_cost or 0)
    end
}
jd_def["j_bgn_revolution"] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
        { text = "x",                              scale = 0.35 },
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xmult" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" }
    },
    calc_function = function(card)
        local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
        local count = 0
        local active = false
        if poker_hands['Four of a Kind'] and next(poker_hands['Four of a Kind']) then
            active = true
        end
        if card.ability.extra.active or active then
            card.joker_display_values.active = 'Active'
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if not SMODS.has_no_rank(scoring_card) then
                        local id = scoring_card:get_id()
                        if id >= 2 and id <= 5 then
                            count = count +
                                JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
            end
        else
            card.joker_display_values.active = 'Inactive'
        end
        card.joker_display_values.count = count
    end,
}
jd_def["j_bgn_handandfoot"] = {
}
jd_def["j_bgn_shutthebox"] = {
}
jd_def["j_bgn_oldmaid"] = {
}
jd_def["j_bgn_catgoatnarwhalgorilla"] = { -- tough but probably doable
}
jd_def["j_bgn_hazard"] = {
    reminder_text = {
        { ref_table = "card.ability.extra", ref_value = "chosen_rank", colour = G.C.ORANGE },
    },
}
jd_def["j_bgn_polygon"] = {
}
jd_def["j_bgn_wavelength"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult"}
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { ref_table = "card.ability.extra", ref_value = "rank_string", colour = G.C.ORANGE },
    },
    calc_function = function(card)
        local mult = 0
        if card.ability.extra.rank_string ~= '???' then
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if not SMODS.has_no_rank(scoring_card) then
                        if scoring_card:get_id() == card.ability.extra.target_id then
                            mult = mult + (card.ability.extra.large_mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                        elseif (scoring_card:get_id() + 1 == card.ability.extra.target_id) or (scoring_card:get_id() - 1 == card.ability.extra.target_id) then
                            mult = mult + (card.ability.extra.medium_mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                        elseif (scoring_card:get_id() + 2 == card.ability.extra.target_id) or (scoring_card:get_id() - 2 == card.ability.extra.target_id) then
                            mult = mult + (card.ability.extra.small_mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand))
                        end
                    end
                end
            end
        end
        card.joker_display_values.mult = mult
    end
}
jd_def["j_bgn_cherryo"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}
jd_def["j_bgn_cootie"] = {
}
jd_def["j_bgn_conveyorbeltsushi"] = {
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "rerolls", colour = G.C.UI.TEXT_INACTIVE },
    },
    calc_function = function(card)
        card.joker_display_values.rerolls = card.ability.extra.freerolls - card.ability.extra.used_freerolls
    end
}
jd_def["j_bgn_maj"] = {
}
jd_def["j_bgn_landlord"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
}
jd_def["j_bgn_simonsays"] = {
}
jd_def["j_bgn_chutesandladders"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}
jd_def["j_bgn_guesswho"] = {
    text = {
            { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
            { text = "x",                              scale = 0.35 },
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "xmult" }
                }
            }
        },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "string_two", colour = G.C.ORANGE },
        { text = ")" }
    },
    calc_function = function(card)
        local count = 0
        for i, joker in ipairs(G.jokers.cards) do
            if joker:has_attribute(card.ability.extra.chosen_attribute) then
                count = count + 1
            end
        end
        card.joker_display_values.count = count
    end
}
jd_def["j_bgn_freecell"] = {
}
jd_def["j_bgn_yacht"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { text = "[Shop]" }, colour = G.C.UI.TEXT_INACTIVE
    },
    calc_function = function(card)
        if G.GAME.round_scores.times_rerolled.amt == G.GAME.total_rerolls_on_shop_entry then
            card.joker_display_values.money = card.ability.extra.money
        else
            card.joker_display_values.money = 0
        end
    end
}
jd_def["j_bgn_slamwich"] = {
}
jd_def["j_bgn_defuse"] = {
    reminder_text = {
        { text = "("},
        { ref_table = "card.joker_display_values", ref_value = "active"},
        { text = ")"}
    },
    calc_function = function(card)
        card.joker_display_values.is_active = card.ability.extra.defuse_rounds >= card.ability.extra.total_rounds
        card.joker_display_values.active = card.joker_display_values.is_active and
            localize("jdis_active") or
            (card.ability.extra.defuse_rounds .. "/" .. card.ability.extra.total_rounds)
    end,
    style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children and reminder_text.children[2] then
            reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                G.C.UI.TEXT_INACTIVE
        end
    end
}
jd_def["j_bgn_omen"] = {
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}
jd_def["j_bgn_taboo"] = { -- do
}
jd_def["j_bgn_admiral"] = {
}
jd_def["j_bgn_twister"] = {
}
jd_def["j_bgn_chancellor"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
}
jd_def["j_bgn_tinder"] = {
}
jd_def["j_bgn_redrocker"] = {
}
jd_def["j_bgn_hangman"] = {
}
jd_def["j_bgn_dysentery"] = {
}
jd_def["j_bgn_blackjack"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
}
jd_def["j_bgn_azulejos"] = {
}
jd_def["j_bgn_patolli"] = {
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
        local text, _, _ = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' and text ~= 'NULL' then
            card.joker_display_values.dollars = G.GAME.hands[text].level or 0
        else
            card.joker_display_values.dollars = 0
        end
    end
}
jd_def["j_bgn_ur"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
            }
        }
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local num, denom = card.ability.extra.numerator, card.ability.extra.denominator
        if SMODS then num, denom = SMODS.get_probability_vars(card, num, denom) end
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { num, denom } }
    end
}