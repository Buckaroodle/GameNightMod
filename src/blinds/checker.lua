SMODS.Blind {
    key = 'checker',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 4 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('FFFD82'),
    calculate = function(self, blind, context)
        if context.individual and context.cardarea == G.play then
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
    end
}

local ref = SMODS.DrawSteps.debuff.func
function SMODS.DrawSteps.debuff.func(self)
    if self.ability.delay_debuff_draw then return nil end
    return ref(self)
end