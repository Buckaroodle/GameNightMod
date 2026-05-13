SMODS.Joker {
    key = 'garbage',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 4,
        y = 2
    },
    config = {
        extra = {
            chips = 0,
            chips_gain = 10,
            num_of_cards = 0
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_gain,
                card.ability.extra.num_of_cards,
                10 - card.ability.extra.num_of_cards,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            for _, playing_card in ipairs(context.full_hand) do
                if playing_card:is_face() then
                    card.ability.extra.num_of_cards = 0
                    break
                else
                    card.ability.extra.num_of_cards = card.ability.extra.num_of_cards + 1
                    if card.ability.extra.num_of_cards >= 10 then
                        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                        card.ability.extra.num_of_cards = card.ability.extra.num_of_cards - 10
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.CHIPS,
                        }
                    end
                end
            end
            --[[if context.pre_discard and context.other_card:is_face() then
                card.ability.extra.num_of_cards = 0
            elseif context.discard and context.other_card:is_face() == false then
                card.ability.extra.num_of_cards = card.ability.extra.num_of_cards + 1
                if card.ability.extra.num_of_cards >= 10 then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                    card.ability.extra.num_of_cards = card.ability.extra.num_of_cards - 10
                end
            end]]
            
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}