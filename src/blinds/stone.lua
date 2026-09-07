SMODS.Blind {
    key = 'stone',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 16 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('838383'),
    config = {
        extra = {
            numerator = 1,
            denominator = 3,
        }
    },
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, 3, 'bgn_stone')
        return { vars = { num, denom } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1', '3' } }
    end,
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.after then
            for i, playing_card in ipairs(context.scoring_hand) do
                --if next(SMODS.get_enhancements(playing_card)) then
                    if SMODS.pseudorandom_probability(blind, 'bgn_stone', 1, 3) then
                        --playing_card:set_ability('m_stone', nil, true)
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.15,
                            func = function()
                                play_sound("tarot2")
                                playing_card:set_ability(G.P_CENTERS.m_stone)
                                playing_card:juice_up()
                                return true
                            end
                        }))
                    end
                --end
            end
        end
    end
}