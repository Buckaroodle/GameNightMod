SMODS.Blind {
    key = 'checker',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 4 },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('FFFD82'),
    calculate = function(self, blind, context)
        local temp = G.GAME.blind and G.GAME.blind.disabled
        if temp then
            return
        end
        if context.individual and context.cardarea == G.play and not temp then
            local target_card = context.other_card
            target_card.ability = target_card.ability or {}
            target_card.ability.delay_debuff_draw = true
            --context.other_card.ability = context.other_card.ability or {}
            --context.other_card.ability.delay_debuff_draw = true
            SMODS.debuff_card(target_card, true, "bgn_fix")
            G.E_MANAGER:add_event(Event({
                func = function()
                    --extra = {focus = context.other_card, message = "Debuffed!"},
                    target_card.ability.delay_debuff_draw = nil
                    return true
                end,
            }))
            return {
                message = "Debuffed!",
            }
        end
    end,
    disable = function(self)
        for k, v in ipairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'bgn_fix')
        end
    end,
    defeat = function(self)
        for k, v in ipairs(G.playing_cards) do
            SMODS.debuff_card(v, false, 'bgn_fix')
        end
    end
}

local ref = SMODS.DrawSteps.debuff.func
function SMODS.DrawSteps.debuff.func(self)
    if self.ability.delay_debuff_draw then return nil end
    return ref(self)
end