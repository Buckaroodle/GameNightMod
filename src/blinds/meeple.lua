SMODS.Blind {
    key = 'meeple',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('D7D688'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.before then
            if #G.play.cards > 1 then
                --G.E_MANAGER:add_event(Event({
                    --trigger = 'after',
                    --delay = 1,
                    --func = function()
                        --G.E_MANAGER:add_event(Event({
                            --func = function()
                                G.play:shuffle('bgn_meeple')
                                --print('SHUFFLING!!!')
                                play_sound('cardSlide1', 1)
                                table.sort(context.scoring_hand, function(a, b)
                                    return get_index(G.play.cards, a) < get_index(G.play.cards, b)
                                end)
                                return true
                            --end,
                        --}))
                        --delay(0.5)
                        --return true
                    --end
                --}))
            else
                print('oops!')
            end
        end
    end
}