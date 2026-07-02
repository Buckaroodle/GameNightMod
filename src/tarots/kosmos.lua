SMODS.Consumable {
    key = 'kosmos',
    atlas = 'bgn_consumables',
    set = 'Spectral',
    pos = { x = 1, y = 2 },
    cost = 4,
    config = { max_highlighted = 5, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end
}