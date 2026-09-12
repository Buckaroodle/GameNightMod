SMODS.Blind {
    key = 'car',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 23 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('ED6797'),
    calculate = function(self, blind, context)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp then
            return
        end
        if context.after and not temp then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            for i = 1, #G.hand.cards do
                if not G.hand.cards[i].debuffed then
                    G.E_MANAGER:add_event(Event({func = function() SMODS.debuff_card(G.hand.cards[i], true, 'bgn_car') G.hand.cards[i]:juice_up(); return true end })) 
                end
            end
            return true end })) 
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'bgn_car')
        end
    end,

    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'bgn_car')
        end
    end
}