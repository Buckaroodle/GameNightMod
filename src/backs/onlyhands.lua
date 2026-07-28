SMODS.Back {
    key = "onlyhands",
    atlas = 'bgn_consumables',
    pos = { x = 2, y = 0 },
    unlocked = true,
    apply = function(self, back)
        G.GAME.starting_params.hands = (G.GAME.starting_params.hands + G.GAME.starting_params.discards) - 1
        G.GAME.starting_params.discards = 0
        G.GAME.bgn_onlyhands = true
        G.GAME.banned_keys['bl_needle'] = true
        G.GAME.banned_keys['bl_water'] = true
    end,
}

local ease_discard_ref = ease_discard
function ease_discard(mod, instant, silent, ...)
    if G.GAME.bgn_onlyhands == true then
        local _mod = function(mod)
            print(mod)
        local hand_UI = G.HUD:get_UIE_by_ID('hand_UI_count')
        mod = mod or 0
        local text = '+'
        local col = G.C.GREEN
        if mod < 0 then
            text = ''
            col = G.C.RED
        end
        --Ease from current chips to the new number of chips
        --print('discards left: ' .. G.GAME.current_round.discards_left)
        --print('hands left: ' .. G.GAME.current_round.hands_left)
        --G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + mod
        --G.GAME.current_round.hands_left = G.GAME.current_round.discards_left
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + mod
        G.GAME.current_round.discards_left = G.GAME.current_round.hands_left
        --print(G.GAME.current_round.discards_left)
        --print(G.GAME.current_round.hands_left)
        hand_UI.config.object:update()
        G.HUD:recalculate()
        --Popup text next to the chips in UI showing number of chips gained/lost
        attention_text({
          text = text..mod,
          scale = 0.8, 
          hold = 0.7,
          cover = hand_UI.parent,
          cover_colour = col,
          align = 'cm',
          })
        --Play a chip sound
        play_sound('chips2')
        end
        if instant then
            _mod(mod)
        else
            G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                _mod(mod)
                return true
            end
            }))
        end
    else
        return ease_discard_ref(mod, instant, silent, ...)
    end
end

local create_UIBox_HUD_ref = create_UIBox_HUD
function create_UIBox_HUD(...)
    if G.GAME.bgn_onlyhands then
        local scale = 0.4
        local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

        local contents = {}

        local spacing = 0.13
        local temp_col = G.C.DYN_UI.BOSS_MAIN
        local temp_col2 = G.C.DYN_UI.BOSS_DARK
                contents.round = {
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.C, config={id = 'hud_hands',align = "cm", padding = 0.05, minw = 1.45*2 + spacing, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                    {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                        {n=G.UIT.T, config={text = 'Hands/Discards', scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.28*2+spacing, colour = temp_col2}, nodes={
                        {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'hands_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.PURPLE},shadow = true, rotate = true, scale = 2*scale}),id = 'hand_UI_count'}},
                    }}
                    }},
                    {n=G.UIT.C, config={minw = spacing},nodes={}},
                    --[[{n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                    {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                        {n=G.UIT.T, config={text = localize('k_hud_discards'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
                        {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'discards_left'}}, font = G.LANGUAGES['en-us'].font, colours = {G.C.RED},shadow = true, rotate = true, scale = 2*scale}),id = 'discard_UI_count'}},
                        }}
                    }},
                    }},]]
                }},
                {n=G.UIT.R, config={minh = spacing},nodes={}},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45*2 + spacing, minh = 1.15, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        {n=G.UIT.C, config={align = "cm", r = 0.1, minw = 1.28*2+spacing, minh = 1, colour = temp_col2}, nodes={
                        {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'dollars', prefix = localize('$')}},
                                scale_function = function ()
                                    return scale_number(G.GAME.dollars, 2.2 * scale, 99999, 1000000)
                                end, maxw = 1.35, colours = {G.C.MONEY}, font = G.LANGUAGES['en-us'].font, shadow = true,spacing = 2, bump = true, scale = 2.2*scale}), id = 'dollar_text_UI'}}
                    }},
                    }},
                    }},
                }},
                {n=G.UIT.R, config={minh = spacing},nodes={}},
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={id = 'hud_ante',align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                    {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 1.35}, nodes={
                    {n=G.UIT.T, config={text = localize('k_ante'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.round_resets, ref_value = 'ante'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'ante_UI_count'}},
                    {n=G.UIT.T, config={text = " ", scale = 0.3*scale}},
                    {n=G.UIT.T, config={text = "/ ", scale = 0.7*scale, colour = G.C.WHITE, shadow = true}},
                    {n=G.UIT.T, config={ref_table = G.GAME, ref_value='win_ante', scale = scale, colour = G.C.WHITE, shadow = true}}
                    }},
                }},
                {n=G.UIT.C, config={minw = spacing},nodes={}},
                {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1.45, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
                    {n=G.UIT.R, config={align = "cm", maxw = 1.35}, nodes={
                    {n=G.UIT.T, config={text = localize('k_round'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2, id = 'row_round_text'}, nodes={
                    {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'round'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'round_UI_count'}},
                    }},
                }},
                }},            
        }
        contents.hand = SMODS.GUI.hand_score_display_ui(scale)
        contents.dollars_chips = {n=G.UIT.R, config={align = "cm",r=0.1, padding = 0,colour = G.C.DYN_UI.BOSS_MAIN, emboss = 0.05, id = 'row_dollars_chips'}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", minw = 1.3}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
                {n=G.UIT.T, config={text = localize('k_round'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.3}, nodes={
                {n=G.UIT.T, config={text =localize('k_lower_score'), scale = 0.42, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }}
            }},
            {n=G.UIT.C, config={align = "cm", minw = 3.3, minh = 0.7, r = 0.1, colour = G.C.DYN_UI.BOSS_DARK}, nodes={
            {n=G.UIT.O, config={w=0.5,h=0.5 , object = stake_sprite, hover = true, can_collide = false}},
            {n=G.UIT.B, config={w=0.1,h=0.1}},
            {n=G.UIT.T, config={ref_table = G.GAME, ref_value = 'chips_text', lang = G.LANGUAGES['en-us'], scale = 0.85, colour = G.C.WHITE, id = 'chip_UI_count', func = 'chip_UI_set', shadow = true}}
            }}
        }}
        }}

        contents.buttons = {
        {n=G.UIT.C, config={align = "cm", r=0.1, colour = G.C.CLEAR, shadow = true, id = 'button_area', padding = 0.2}, nodes={
            {n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1.75, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
                {n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
                {n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
                }}
            }},
            {n=G.UIT.R, config={align = "cm", minh = 1.75, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
                {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
                {n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                }},
            }}
            }}
        }

        return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK}, nodes={
        {n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minh = 30, padding = 0.08}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 0.3}, nodes={}},
            {n=G.UIT.R, config={align = "cm", id = 'row_blind', minw = 1, minh = 3.75}, nodes={
                {n=G.UIT.B, config={w=0, h=3.64, id = 'row_blind_bottom'}, nodes={}}
            }},
            contents.dollars_chips,
            contents.hand,
            {n=G.UIT.R, config={align = "cm", id = 'row_round'}, nodes={
                {n=G.UIT.C, config={align = "cm"}, nodes=contents.buttons},
                {n=G.UIT.C, config={align = "cm"}, nodes=contents.round}
            }},
            }}
        }}
        }}
    else
        return create_UIBox_HUD_ref(...)
    end
end