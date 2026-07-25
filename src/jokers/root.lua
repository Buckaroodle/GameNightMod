SMODS.Joker {
    key = 'root',
    atlas = 'placeholders',
    attributes = {
        'mult',
    },
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = math.sqrt(hand_chips)
            }
        end
    end
}