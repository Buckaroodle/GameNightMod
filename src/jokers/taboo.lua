SMODS.Joker {
    key = 'taboo',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'joker',
        'debuff',
    },
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
}