SMODS.Joker {
    key = 'scoutandshow',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 1,
        y = 2
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
                card.ability.extra.scouted_card
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and context.end_of_round ~= true then
           card.ability.extra.scouted_card = pseudorandom_element(context.scoring_hand, 'bgn_scoutandshow')
        end
        if context.end_of_round ~= true and context.stay_flipped and context.other_card == card.ability.extra.scouted_card and context.from_area == G.play and context.to_area == G.discard then
            return {modify = {to_area = G.hand}}
        end
    end
}