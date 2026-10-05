SMODS.Joker {
    key = 'cootie',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'hands',
        'passive',
        'discards',
        'hand_size'
    },
    pos = {
        x = 3,
        y = 10
    },
    config = {
        extra = {
            mod = 2,
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mod,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local die = {1, 2, 3}
            card.ability.extra.choice = pseudorandom_element(die, 'bgn_cootie')
            if card.ability.extra.choice == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_hands_played(card.ability.extra.mod)
                        return true
                    end
                }))
            elseif card.ability.extra.choice == 2 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_discard(card.ability.extra.mod)
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:change_size(card.ability.extra.mod)
                        return true
                    end
                }))
            end
            return nil, true -- This is for Joker retrigger purposes
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.choice == 3 then
            G.hand:change_size(-card.ability.extra.mod)
            card.ability.extra.choice = nil
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.choice == 3 then
            G.hand:change_size(-card.ability.extra.mod)
        end
    end
}