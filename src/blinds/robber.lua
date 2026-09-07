SMODS.Blind {
    key = 'robber',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 5 },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('EDBA57'),
    --[[set_blind = function(self)
        if self.disabled then return end
        local all_cards = SMODS.shallow_copy(G.deck.cards)
        for i = 1, math.floor(#G.deck.cards / 3) do
            --G.E_MANAGER:add_event(Event({
                --func = function()
                    local chosen_card, index = pseudorandom_element(all_cards, 'bgn_robber')
                    --blind.ability.extra.discarded_cards = {}
                    table.remove(all_cards, index)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            draw_card(G.deck, G.discard, 90, 'up', nil, chosen_card)
                            return true
                        end,
                    }))
                --end,
            --}))
        end
    end,]]
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.hand_drawn and not blind.activated == true then
            local all_cards = SMODS.shallow_copy(G.deck.cards)
            for i = 1, math.floor((#G.deck.cards + #G.hand.cards) / 3) do
                local chosen_card, index = pseudorandom_element(all_cards, 'bgn_robber')
                table.remove(all_cards, index)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        draw_card(G.deck, G.discard, 90, 'up', nil, chosen_card)
                        return true
                    end,
                }))
            end
            blind.activated = true
        end
    end
}

