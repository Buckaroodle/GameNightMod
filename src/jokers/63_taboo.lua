SMODS.Joker {
    key = 'taboo',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'joker',
        'debuff',
    },
    unlocked = false,
    pos = {
        x = 2,
        y = 5
    },
    config = {
        extra = {
            xmult = 2,
        }
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local tally = 0
            for j = 1, #args.cards do
                --if SMODS.has_enhancement(args.cards[j], 'm_gold') then
                if args.cards[j].debuff then
                    tally = tally + 1
                    if tally == 5 then
                        return true
                    end
                end
            end
        end
        return false
    end
}