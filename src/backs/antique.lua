SMODS.Back {
    key = "antique",
    atlas = 'bgn_consumables',
    pos = { x = 5, y = 0 },
    config = { jokers = { 'j_bgn_oldmaid' } },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.jokers[1] } }
    end,
}