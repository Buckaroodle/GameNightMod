SMODS.Joker {
    key = 'morris',
    atlas = 'placeholders',
    attributes = {
        'hand_size',
    },
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = {
            jacks = 3,
        }
    },
    rarity = 4,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.jacks,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after then
            local jacks = 0
            for i, playing_card in ipairs(context.scoring_hand) do
                if not SMODS.has_no_rank(playing_card) and playing_card:get_id() == 11 then
                    jacks = jacks + 1
                end
            end
            if jacks >= card.ability.extra.jacks then
                local card_to_destroy = G.hand.cards[#G.hand.cards]
                local destroy_id = nil
                if not SMODS.has_no_rank(card_to_destroy) then
                    destroy_id = card_to_destroy:get_id()
                end
                SMODS.destroy_cards(card_to_destroy)
                for i, playing_card in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(playing_card) and destroy_id and playing_card:get_id() == destroy_id then
                        SMODS.destroy_cards(playing_card)
                    end
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
    end,
}