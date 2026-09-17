SMODS.Back {
    key = "antique",
    atlas = 'bgn_consumables',
    pos = { x = 5, y = 0 },
    config = { jokers = { 'j_bgn_oldmaid' } },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.jokers[1] } }
    end,
    check_for_unlock = function(self, args)
        --return context.joker_type_destroyed and context.card.config.center.key == 'j_bgn_oldmaid'
        --return args.type == 'win_deck' and get_deck_win_stake('b_red') > 0
        if args and args.type and args.type == 'maid_destruction' and args.context and next(args.context) then
            return true
        end
    end
}