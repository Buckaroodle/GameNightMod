SMODS.Blind {
    key = 'checker',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 4 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('E58366'),
    --[[calculate = function(self, blind, context)
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
    end]]
}

local calculate_repetitions_ref = SMODS.calculate_repetitions
function SMODS.calculate_repetitions(card, context, reps) 
    if G.GAME.blind.config.blind.key == 'bl_bgn_checker' and not G.GAME.blind.disabled and context.cardarea == G.play and (card.config.center.set == 'Default' or card.config.center.set == 'Base' or card.config.center.set == 'Enhanced') then
        return reps
    end
    return calculate_repetitions_ref(card, context, reps)
end
local calculate_retriggers_ref = SMODS.calculate_retriggers
function SMODS.calculate_retriggers(card, context, _ret)
    if G.GAME.blind.config.blind.key == 'bl_bgn_checker' and not G.GAME.blind.disabled and context.cardarea == G.play and (card.config.center.set == 'Default' or card.config.center.set == 'Base' or card.config.center.set == 'Enhanced') then
        return {}
    end
    return calculate_retriggers_ref(card, context, _ret)
end

--[[local ref = SMODS.DrawSteps.debuff.func
function SMODS.DrawSteps.debuff.func(self)
    if self.ability.delay_debuff_draw then return nil end
    return ref(self)
end

SMODS.Joker:take_ownership('photograph', -- object key (class prefix not required)
    { -- table of properties to change from the existing object,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            if card.ability.first_face == nil then
                local is_first_face = false
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i]:is_face() then
                        is_first_face = context.scoring_hand[i] == context.other_card
                        card.ability.first_face = context.other_card
                        break
                    end
                end
                if is_first_face then
                    --card.ability.first_face = context.other_card
                    print('first!')
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            else
                if context.other_card == card.ability.first_face then
                    print('second!')
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
        if context.after then
            card.ability.first_face = nil
        end
    end
    },
    true -- silent | suppresses mod badge
)]]