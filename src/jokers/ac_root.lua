SMODS.Joker {
    key = 'root',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
    },
    pos = {
        x = 0,
        y = 10
    },
    rarity = 1,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = math.sqrt(hand_chips)
            }
        end
    end
}