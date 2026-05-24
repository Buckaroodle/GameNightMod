SMODS.Joker {
    key = 'storedenergy',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 2,
        y = 6
    },
    config = {
        extra = {
            chips = 35,
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local debuffed_chips = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card.debuff == true then
                    debuffed_chips = debuffed_chips + card.ability.extra.chips
                end
            end

            return {
                chips = (card.ability.extra.chips * (#context.full_hand - #context.scoring_hand)) + debuffed_chips
            }
        end
    end
}