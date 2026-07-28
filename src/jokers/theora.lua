SMODS.Joker {
    key = 'theora',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'face',
        'seals',
    },
    pos = {
        x = 2,
        y = 10
    },
    rarity = 3,
    cost = 8,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local non_face_found = false
            if #G.hand.cards >= 1 then
                for i, playing_card in ipairs(G.hand.cards) do
                    if not playing_card:is_face() then
                        non_face_found = true
                    end
                end
                if not non_face_found then
                    local unsealed_cards = {}
                    for i, playing_card in ipairs(G.hand.cards) do
                        if playing_card.seal == nil then
                            unsealed_cards[#unsealed_cards+1] = playing_card
                        end
                    end
                    if #unsealed_cards > 0 then
                        local card_to_seal = pseudorandom_element(unsealed_cards, 'bgn_queensgambit')
                        local random_seal = SMODS.poll_seal {key = "modprefix_seed", guaranteed = true}
                        card_to_seal:set_seal(random_seal)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}