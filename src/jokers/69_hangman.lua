SMODS.Joker {
    key = 'hangman',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'generation',
        'consumable',
        'tarot',
        'passive'
    },
    unlocked = false,
    pos = {
        x = 6,
        y = 6
    },
    config = {
        extra = {
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hanged_man
        return {
            vars = {
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {key = 'c_hanged_man'}
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { (G.PROFILES[G.SETTINGS.profile].consumeable_usage['c_hanged_man'] or {count = 0}).count } }
    end,
    check_for_unlock = function(self, args)
        if args and args.type and args.type == 'consumeable' and args.context and next(args.context) then
            return G.PROFILES[G.SETTINGS.profile].consumeable_usage['c_hanged_man'].count >= 15
        end
        return false
    end
}

SMODS.Consumable:take_ownership('hanged_man',
    {
        loc_vars = function(self, info_queue, card)
            if G.jokers and next(SMODS.find_card("j_bgn_hangman")) then
                card.ability.max_highlighted = 3
            else
                card.ability.max_highlighted = 2
            end
            return {
                vars = {
                    card.ability.max_highlighted
                }
            }
        end,
        can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= (G.jokers and next(SMODS.find_card("j_bgn_hangman")) and 3 or card.ability.max_highlighted)
    end
    },
    true
)