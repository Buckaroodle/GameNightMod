SMODS.Joker {
    key = 'crazyeights',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'generation',
        'enhancement',
        'rank',
        'eight',
    },
    pos = {
        x = 0,
        y = 9
    },
    config = {
        extra = {
            numerator = 1,
            denominator = 2,
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
        return {
            vars = {
                num,
                denom,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 8) and SMODS.pseudorandom_probability(card, 'bgn_crazyeights', card.ability.extra.numerator, card.ability.extra.denominator) then
                --SMODS.add_card { set = "Enhanced" }
                local _card = SMODS.create_card { set = "Enhanced", area = G.discard, key_append = "bgn_crazyeights" }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:start_materialize()
                        G.hand:emplace(_card)
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then
                            context.blueprint_card:juice_up()
                        else
                            card:juice_up()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                        save_run()
                        return true
                    end
                }))
            end
        end
    end
}