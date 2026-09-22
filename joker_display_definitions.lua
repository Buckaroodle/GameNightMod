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
    --[[text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local chips = 0
        local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, playing_card in ipairs(scoring_hand) do
                if playing_card.debuff == true then
                    chips = chips +
                        card.ability.extra *
                        JokerDisplay.calculate_card_triggers(playing_card, scoring_hand)
                end
            end
            chips = chips +
                card.ability.extra *
                (#G.play.cards - #scoring_hand)
        end
        card.joker_display_values.chips = chips
    end]]
}
--[[jd_def["j_bgn_phases"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
}]]
--[[jd_def["j_bgn_assassin"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.joker_display_values", ref_value = "assassin_card", colour = G.C.RED },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.assassin_card = localize { type = 'variable', key = "jdis_rank_of_suit", vars = localize(G.GAME.current_round.assassin_card.rank, 'ranks') }
    end
}]]
--[[jd_def["j_bgn_boardwalk"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    --text_config = { colour = G.C.MULT },
    calc_function = function(card)
        
    end
}]]
--[[jd_def["j_bgn_parkplace"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.MULT },
}]]
--[[jd_def["j_bgn_stand"] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    calc_function = function(card)
        local ranks, bust = {}, false
        local hand = SMODS.shallow_copy(G.hand.cards)
        for _, playing_card in ipairs(G.hand.highlighted) do
            for _, playing_card2 in ipairs(G.hand.cards) do
                if playing_card == playing_card2 then
                    table.remove()
                end
            end
        end
        for k, v in pairs(G.hand.cards) do -- go through all cards held in hand
            if not SMODS.has_no_rank(v) then
                if ranks[v:get_id()] then -- does this rank have an entry in the dictionary?
                    bust = true -- if so, it's a repeat rank. BUST!
                end
                ranks[v:get_id()] = true -- now we add it to the dictionary
            end
        end
        if bust then
            card.joker_display_values.mult = 0
        else
            card.joker_display_values.mult = card.ability.extra.mult * #G.hand.cards
        end
    end
}]]
jd_def["j_bgn_palace"] = {
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
jd_def["j_bgn_scoutandshow"] = {
}
jd_def["j_bgn_applestoapples"] = {
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
jd_def["j_bgn_handandfoot"] = {
}
jd_def["j_bgn_shutthebox"] = {
}
jd_def["j_bgn_oldmaid"] = {
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
}
jd_def["j_bgn_freecell"] = {
}
--[[jd_def["j_bgn_defuse"] = {
    reminder_text = {
        {
            { text = "("},
            { ref_table = "card.joker_display_values", ref_value = "active"},
            { text = ")"}
        }
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
}]]
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
jd_def["j_bgn_blackjack"] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
    },
    text_config = { colour = G.C.CHIPS },
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
jd_def["j_bgn_taboo"] = {
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
jd_def["j_bgn_slamwich"] = {
}
jd_def["j_bgn_azulejos"] = {
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