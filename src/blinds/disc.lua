--[[SMODS.Blind {
    key = 'disc',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('FFFD82'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.press_play then
            if #G.hand.highlighted > 1 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.hand.highlighted:shuffle('bgn_disc')
                                print('SHUFFLING!!!')
                                play_sound('cardSlide1', 1)
                                return true
                            end,
                        }))
                        delay(0.5)
                        return true
                    end
                }))
            else
                print('oops!')
            end
        end
    end
}]]