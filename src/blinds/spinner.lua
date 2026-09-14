SMODS.Blind {
    key = 'spinner',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 20 },
    attributes = { 'chance', 'lose_economy' },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('2E9BA5'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if blind.inc == nil then
            blind.inc = G.GAME.blind.chips / 4
        end

        if context.pseudorandom_result then  
            if not context.result and context.trigger_obj and (context.trigger_obj.config and context.trigger_obj.config.center and (context.trigger_obj.config.center.set == 'Joker' or context.trigger_obj.config.center.set == 'Default' or context.trigger_obj.config.center.set == 'Enhanced' or context.trigger_obj.config.center.consumeable)) then
                return {
                    dollars = -5
                }
            end
        end
    end
}