SMODS.Joker {
    key = 'cardczar',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        --if context.end_of_round and context.game_over == false and context.main_eval then
        if context.after and SMODS.calculate_round_score() + G.GAME.chips > G.GAME.blind.chips then
            local possible_cards = {}
            for _, scoring_card in ipairs(context.scoring_hand) do
                if scoring_card.edition == nil then
                   table.insert(possible_cards, scoring_card)
                end
            end
            if possible_cards ~= nil then
                local chosen_card = pseudorandom_element(possible_cards, 'bgn_cardczar')
                local random_edition = SMODS.poll_edition { key = "modprefix_seed", guaranteed = true, no_negative = true }
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if chosen_card ~= nil then
                            chosen_card:set_edition(random_edition)
                            chosen_card:juice_up()
                        end
                    return true 
                    end,
                }))
            end
        end
    end
}