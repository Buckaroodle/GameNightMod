SMODS.Blind {
    key = 'auburnhourglass',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 8 },
    dollars = 8,
    mult = 2,
    boss = { showdown = true },
    boss_colour = HEX('A33E12'),
    calculate = function(self, blind, context)
        if context.blind_disabled or context.blind_defeated then
            for _, joker in ipairs(G.jokers.cards) do
                joker.ability.auburn_hourglass_chosen = nil
            end
        end

        if blind.disabled then return end

        if context.debuff_card and context.debuff_card.area == G.jokers then
            if context.debuff_card.ability.auburn_hourglass_chosen then
                return {
                    debuff = true
                }
            end
        end
        if context.press_play and G.jokers.cards[1] then
            blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
            blind.prepped = true
        end
        if context.hand_drawn and G.GAME.current_round.hands_played > 0 then
            --print(blind.prepped)
            if blind.prepped and G.jokers.cards[1] then
                --print('2')
                local prev_chosen_set = {}
                local fallback_jokers = {}
                local jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.auburn_hourglass_chosen then
                        prev_chosen_set[G.jokers.cards[i]] = true
                        --G.jokers.cards[i].ability.crimson_heart_chosen = nil
                        --if G.jokers.cards[i].debuff then SMODS.recalc_debuff(G.jokers.cards[i]) end
                    end
                end
                for i = 1, #G.jokers.cards do
                    --if not G.jokers.cards[i].debuff then
                        if not prev_chosen_set[G.jokers.cards[i]] then
                            jokers[#jokers + 1] = G.jokers.cards[i]
                        end
                        table.insert(fallback_jokers, G.jokers.cards[i])
                    --end
                end
                if #jokers == 0 then jokers = fallback_jokers end
                local _card = pseudorandom_element(jokers, 'bgn_auburn_hourglass')
                if _card then
                    _card.ability.auburn_hourglass_chosen = true
                    SMODS.recalc_debuff(_card)
                    _card:juice_up()
                    blind:wiggle()
                end
            end
            blind.prepped = nil
        end
    end
}