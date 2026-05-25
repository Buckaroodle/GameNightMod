SMODS.Joker {
    key = 'tilejoker',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 2,
        y = 4
    },
    config = {
        extra = {
            total_needed = 30,
            poker_hand = 'Three of a Kind'
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.total_needed,
                card.ability.extra.poker_hand
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local card_total = 0
            for _, scoring_card in ipairs(context.scoring_hand) do
                local rank_number = scoring_card:get_id()
                if scoring_card:get_id() == 14 then
                    card_total = card_total + 11
                elseif scoring_card:get_id() == 13 or scoring_card:get_id() == 12 or scoring_card:get_id() == 11 then
                    card_total = card_total + 10
                else
                    card_total = card_total + scoring_card:get_id()
                end
            end
            if card_total >= 30 then
                local card_to_juice = context.blueprint_card or card
                return {
                    message = localize('k_upgrade_ex'),
                    func = function ()
                        local text = card.ability.extra.poker_hand
                        level_up_hand(card_to_juice, text, nil, 1)
                    end
                }
            end
        end
    end
}