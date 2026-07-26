SMODS.Joker {
    key = 'queensgambit',
    atlas = 'placeholders',
    attributes = {
        'rank',
        'queen',
        'destroy_card'
    },
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local queen_found = false
            local too_many_queens = false
            for i, playing_card in ipairs(context.scoring_hand) do
                if playing_card.base.value == 'Queen' then
                    if queen_found == false then
                        queen_found = true
                    else
                        too_many_queens = true
                    end
                end
            end
            if #G.hand.cards >= 1 and queen_found and not too_many_queens then
                local card_to_destroy = pseudorandom_element(G.hand.cards, 'bgn_queensgambit')
                SMODS.destroy_cards(card_to_destroy)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.8, 0.8)
                    play_sound('slice1', 0.96 + math.random() * 0.08)
                    return true
                end
            }))
        end
    end
}