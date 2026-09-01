--[[local contains = function (tbl, item)
    for k, v in pairs(tbl) do
        if v == item then
            return true
        end
    end
    return false
end]]

SMODS.Joker {
    key = 'safetyzone',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'passive', 'position'
    },
    pos = {
        x = 5,
        y = 0
    },
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_type_destroyed or (context.check_eternal and not context.trigger.from_sell) and not context.blueprint then
            local card_to_be_destroyed = context.card or context.other_card
            if card_to_be_destroyed == G.jokers.cards[1] or card_to_be_destroyed == G.jokers.cards[2] then
                return {
                    no_destroy = { override_compat = true }
                }
            end
        end
    end
}