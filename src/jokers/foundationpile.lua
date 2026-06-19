SMODS.Joker {
    key = 'foundationpile',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'mult',
        'scaling',
        'discard',
        'rank'
    },
    pos = {
        x = 3,
        y = 5
    },
    config = {
        extra = {
            mult = 0,
            mult_gain = 2,
            needed_rank = 'Ace',
            needed_id = 14
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local assassin_card = G.GAME.current_round.assassin_card or { rank = 'Ace', suit = 'Spades' }
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_gain,
                card.ability.extra.needed_rank,
                card.ability.extra.needed_id
            }
        }
    end,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint and #context.full_hand == 1 then
            if context.other_card:get_id() == card.ability.extra.needed_id then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                card.ability.extra.needed_id = card.ability.extra.needed_id + 1
                if card.ability.extra.needed_id >= 15 then
                    card.ability.extra.needed_id = 2
                end
                local cardMap = {
                    [2]  = "Two",
                    [3]  = "Three",
                    [4]  = "Four",
                    [5]  = "Five",
                    [6]  = "Six",
                    [7]  = "Seven",
                    [8]  = "Eight",
                    [9]  = "Nine",
                    [10] = "Ten",
                    [11] = "Jack",
                    [12] = "Queen",
                    [13] = "King",
                    [14] = "Ace"
                }
                card.ability.extra.needed_rank = cardMap[card.ability.extra.needed_id]
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}