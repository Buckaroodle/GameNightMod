SMODS.Joker {
    key = 'palace',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'discard',
    },
    pos = {
        x = 2,
        y = 2
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,
}

local discard_from_highlighted_ref = G.FUNCS.discard_cards_from_highlighted
function G.FUNCS.discard_cards_from_highlighted(e, hook)
    if #G.hand.highlighted == 1 and next(SMODS.find_card("j_bgn_palace")) then
        local preselected_card = G.hand.highlighted[1]
        local selected_card_limit_mod = #G.hand.cards - 5
        if #G.hand.cards > 5 then
            SMODS.change_discard_limit(selected_card_limit_mod)
        end
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_card ~= preselected_card then
                G.hand:add_to_highlighted(playing_card, true)
            end
        end
        if selected_card_limit_mod > 0 then
            SMODS.change_discard_limit(-selected_card_limit_mod)
        end
    end
    return discard_from_highlighted_ref(e, hook)
end