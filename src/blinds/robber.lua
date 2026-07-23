--[[SMODS.Blind {
    key = 'robber',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('FFFD82'),
    set_blind = function(self)
        for i = 1, math.floor(#G.playing_cards / 3) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local chosen_card = pseudorandom_element(G.playing_cards, 'bgn_robber')
                    --blind.ability.extra.discarded_cards = {}
                    draw_card(G.deck, G.discard, 90, 'up', nil, chosen_card)
                    return true
                end,
            }))
        end
    end,
}]]