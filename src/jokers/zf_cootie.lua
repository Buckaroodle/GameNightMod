SMODS.Joker {
    key = 'cootie',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'hands',
        'passive',
        'discards',
        'hand_size'
    },
    pos = {
        x = 4,
        y = 9
    },
    config = {
        extra = {
            mod = 2,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mod,
            }
        }
    end,
    
}