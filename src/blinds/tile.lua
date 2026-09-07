SMODS.Blind {
    key = 'tile',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 7 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('D6C99A'),
    calculate = function(self, blind, context)
        if blind.disabled then return end
    end
}

local has_no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    if G.bgn_dont_crash then return has_no_rank_ref(card) end
    G.bgn_dont_crash = true
    if G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_bgn_tile' and card:is_face() and not G.GAME.blind.disabled then
        G.bgn_dont_crash = nil
        return true
    end
    G.bgn_dont_crash = nil
    return has_no_rank_ref(card)
end

local always_scores_ref = SMODS.always_scores
function SMODS.always_scores(card)
    if G.bgn_dont_crash then return always_scores_ref(card) end
    G.bgn_dont_crash = true
    if G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_bgn_tile' and card:is_face() and not G.GAME.blind.disabled then
        G.bgn_dont_crash = nil
        return true
    end
    G.bgn_dont_crash = nil
    return always_scores_ref(card)
end