SMODS.Blind {
    key = 'peg',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 12 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('767711'),
    config = {
        extra = {
            numerator = 1,
            denominator = 2,
        }
    },
    loc_vars = function(self)
        local num, denom = SMODS.get_probability_vars(self, 1, 2, 'bgn_peg')
        return { vars = { num, denom } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1', '2' } }
    end,
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.before then
            for i, playing_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(playing_card)) then
                    if SMODS.pseudorandom_probability(blind, 'bgn_peg', 1, 2) then
                        playing_card:set_ability('c_base', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                playing_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}