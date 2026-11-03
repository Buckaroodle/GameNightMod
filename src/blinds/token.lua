SMODS.Blind {
    key = 'token',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 21 },
    attributes = { 'economy', 'debuff', 'joker' },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 10 },
    boss_colour = HEX('CCBA59'),
    calculate = function(self, blind, context)
        if context.blind_disabled or context.blind_defeated then
            for _, joker in ipairs(G.jokers.cards) do
                joker.ability.token_chosen = nil
            end
            for _, consumeable in ipairs(G.consumeables.cards) do
                if consumeable.ability.set == 'Joker' then
                    consumeable.ability.token_chosen = nil
                end
            end
        end

        if blind.disabled then return end

        if context.debuff_card and context.debuff_card.area == G.jokers then
            if context.debuff_card.ability.token_chosen then
                return {
                    debuff = true
                }
            end
        elseif context.debuff_card and context.debuff_card.area == G.consumeables then
            if context.debuff_card.ability.token_chosen then
                return {
                    debuff = true
                }
            end
        end

        if context.first_hand_drawn then
            local mini_jokers = 0
            for i = 1, #G.consumeables.cards do
                if G.consumeables.cards[i].ability.set == 'Joker' then
                    mini_jokers = mini_jokers + 1
                end
            end
            --print(blind.prepped)
            if (G.jokers.cards[1] or mini_jokers >= 2) and G.GAME.dollars >= 20 then
                blind.triggered = true
                --print('2')
                local jokers = SMODS.shallow_copy(G.jokers.cards)
                for i = 1, #G.consumeables.cards do
                    if G.consumeables.cards[i].ability.set == 'Joker' then
                        jokers[#jokers+1] = G.consumeables.cards[i]
                    end
                end
                for i = 1, math.floor(G.GAME.dollars / 20) do
                    local _card, index = pseudorandom_element(jokers, 'bgn_token')
                    if _card then
                        --print('card debuffed!')
                        table.remove(jokers, index)
                        _card.ability.token_chosen = true
                        SMODS.recalc_debuff(_card)
                        _card:juice_up()
                        blind:wiggle()
                    end
                end
            end
        end
    end
}