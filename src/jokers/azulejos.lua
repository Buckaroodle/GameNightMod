SMODS.Joker {
    key = 'azulejos',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'discard',
        'hand',
    },
    pos = {
        x = 5,
        y = 3
    },
    config = {
        extra = {
            discards = 1,
        }
    },
    rarity = 3,
    cost = 9,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.discards
            }
        }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and G.GAME.current_round.hands_left == 1 and not card.ability.extra.already_triggered and not context.blueprint then
            --print(#G.discard.cards)
            card.ability.extra.already_triggered = true
            for i, playing_card in ipairs(G.discard.cards) do
                if playing_card.ability.was_discarded then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            draw_card(G.discard, G.hand, 90, 'up', nil, playing_card)
                            return true
                        end,
                    }))
                end
                --print(i)
            end
            --print('done!')
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.already_triggered = false
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
}