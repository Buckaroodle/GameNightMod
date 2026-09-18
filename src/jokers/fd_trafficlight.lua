SMODS.Joker {
    key = 'trafficlight',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'hand_type',
        'chance'
    },
    pos = {
        x = 0,
        y = 1
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 5,
            Xmult = 2,
            poker_hand = 'poker hand',
            green_light = true
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
                card.ability.extra.Xmult,
                card.ability.extra.poker_hand,
                card.ability.extra.green_light,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand and card.ability.extra.green_light ~= true then
            card.ability.extra.green_light = true
            card.children.center:set_sprite_pos({x = 0, y = 1})
            return {
                message = "Green Light!",
            }
        end
        if context.joker_main and card.ability.extra.green_light == true then
            if SMODS.pseudorandom_probability(card, 'example_prob', card.ability.extra.numerator, card.ability.extra.denominator) then
                red_light_triggered = true
            end
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.after and red_light_triggered == true then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'bgn_trafficlight')
            card.ability.extra.green_light = false
            red_light_triggered = false          
            G.E_MANAGER:add_event(Event({
            func = function() 
                card.children.center:set_sprite_pos({x = 1, y = 1})
                return true 
            end,
            }))
            return {
                message = "Red Light!",
            }
        end
    end
}