SMODS.Joker {
    key = 'blindnil',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 200
        }
    },
    rarity = 1,
    cost = 2,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand and
            G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
            return {
                stay_flipped = true
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- context.other_card.facing == "back"