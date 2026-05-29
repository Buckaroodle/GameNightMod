SMODS.Joker {
    key = 'mermaid',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'economy',
        'suit'
    },
    pos = {
        x = 4,
        y = 1
    },
    config = {
        extra = {
            dollars = 2
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.spades,
                card.ability.extra.hearts,
                card.ability.extra.clubs,
                card.ability.extra.diamonds,
                card.ability.extra.largest,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.spades = 0
            card.ability.extra.hearts = 0
            card.ability.extra.clubs = 0
            card.ability.extra.diamonds = 0
            for _, playing_card in ipairs(G.hand.cards) do
            --if SMODS.has_enhancement(card, 'm_wild') then
                --spades = spades + 1
                --hearts = hearts + 1
                --clubs = clubs + 1
                --diamonds = diamonds + 1
            if playing_card:is_suit('Spades') == true then
                card.ability.extra.spades = card.ability.extra.spades + 1
            end
            if playing_card:is_suit('Hearts') == true then
                card.ability.extra.hearts = card.ability.extra.hearts + 1
            end
            if playing_card:is_suit('Clubs') == true then
                card.ability.extra.clubs = card.ability.extra.clubs + 1
            end
            if playing_card:is_suit('Diamonds') == true then
                card.ability.extra.diamonds = card.ability.extra.diamonds + 1
            end
        end
        card.ability.extra.largest = math.max(card.ability.extra.spades, card.ability.extra.hearts, card.ability.extra.clubs, card.ability.extra.diamonds)
        end
    end,
    calc_dollar_bonus = function(self, card)
        return
        card.ability.extra.largest * card.ability.extra.dollars
        --card.ability.extra.dollars
    end
}