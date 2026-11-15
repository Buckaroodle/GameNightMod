local function bgn_catgoatnarwhalgorilla_cycle(suit)
    if suit == "Hearts" then
        return "Clubs"
    elseif suit == "Clubs" then
        return "Diamonds"
    elseif suit == "Diamonds" then
        return "Spades"
    elseif suit == "Spades" then
        return "Hearts"
    else
        return "Clubs"
    end
end

SMODS.Joker {
    key = 'catgoatnarwhalgorilla',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'suit',
        'spades',
        'hearts',
        'clubs',
        'diamonds'
    },
    pos = {
        x = 6,
        y = 2
    },
    config = {
        extra = {
            chips = 50,
            current_suit = 'Spades',
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.current_suit
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local triggered = false
            if context.other_card:is_suit(card.ability.extra.current_suit) then
                triggered = true
            end
            card.ability.extra.current_suit = bgn_catgoatnarwhalgorilla_cycle(card.ability.extra.current_suit)
            if triggered then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}