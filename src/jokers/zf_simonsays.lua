SMODS.Joker {
    key = 'simonsays',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'copying',
        'position',
        'joker_slot'
    },
    pos = {
        x = 7,
        y = 0
    },
    config = {
        extra = {
        }
    },
    rarity = 3,
    cost = 10,
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local index = nil
            for i, joker_in_area in ipairs(G.jokers.cards) do
                if joker_in_area == card then
                    index = i
                    break
                end
            end

            local joker1 = nil
            local joker2 = nil
            local total_jokers = #G.jokers.cards

            if index then
                if index > 1 then --check if there is a joker on the left
                    joker1 = G.jokers.cards[index - 1]
                end
                if index < total_jokers then --check if there is a joker on the right
                    joker2 = G.jokers.cards[index + 1] -- 
                end
            end
            if joker1 == card then
                joker1 = nil
            end
            if joker2 == card then
                joker2 = nil
            end

            local compat1 = joker1 and joker1.config.center.blueprint_compat
            local compat2 = joker2 and joker2.config.center.blueprint_compat
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compat1 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('bgn_' .. (compat1 and 'leftcompat' or 'leftincompat')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                },
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compat2 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('bgn_' .. (compat2 and 'rightcompat' or 'rightincompat')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
        if card.area and card.area == G.consumeables then
            local index = nil
            for i, joker_in_area in ipairs(G.consumeables.cards) do
                if joker_in_area == card then
                    index = i
                    break
                end
            end

            local joker1 = nil
            local joker2 = nil
            local total_jokers = #G.consumeables.cards

            if index then
                if index > 1 then --check if there is a joker on the left
                    joker1 = G.consumeables.cards[index - 1]
                end
                if index < total_jokers then --check if there is a joker on the right
                    joker2 = G.consumeables.cards[index + 1] -- 
                end
            end
            if joker1 == card then
                joker1 = nil
            end
            if joker2 == card then
                joker2 = nil
            end

            local compat1 = joker1 and joker1.config.center.blueprint_compat and joker1.ability.set == 'Joker'
            local compat2 = joker2 and joker2.config.center.blueprint_compat and joker2.ability.set == 'Joker'
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compat1 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('bgn_' .. (compat1 and 'leftcompat' or 'leftincompat')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                },
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compat2 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('bgn_' .. (compat2 and 'rightcompat' or 'rightincompat')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        if G.jokers then
            if #G.jokers.cards < G.jokers.config.card_limit then
                if card.area == G.jokers then
                    local index = nil
                    for i, joker_in_area in ipairs(G.jokers.cards) do
                        if joker_in_area == card then
                            index = i
                            break
                        end
                    end

                    local joker1 = nil
                    local joker2 = nil
                    local total_jokers = #G.jokers.cards

                    if index then
                        if index > 1 then --check if there is a joker on the left
                            joker1 = G.jokers.cards[index - 1]
                        end
                        if index < total_jokers then --check if there is a joker on the right
                            joker2 = G.jokers.cards[index + 1] -- 
                        end
                    end
                    if joker1 == card then
                        joker1 = nil
                    end
                    if joker2 == card then
                        joker2 = nil
                    end

                    local effect1
                    local effect2
                    if joker1 then
                        effect1 = SMODS.blueprint_effect(card, joker1, context)
                    end
                    if joker2 then
                        effect2 = SMODS.blueprint_effect(card, joker2, context)
                    end

                    local returned_effect
                    if effect1 and effect2 then
                        returned_effect = SMODS.merge_effects{effect1, effect2}
                    else
                        returned_effect = effect1 or effect2
                    end

                    if returned_effect then
                        return returned_effect
                    end
                elseif card.area == G.consumeables then
                    local index = nil
                    for i, joker_in_area in ipairs(G.consumeables.cards) do
                        if joker_in_area == card then
                            index = i
                            break
                        end
                    end

                    local joker1 = nil
                    local joker2 = nil
                    local total_jokers = #G.consumeables.cards

                    if index then
                        if index > 1 then --check if there is a joker on the left
                            joker1 = G.consumeables.cards[index - 1]
                        end
                        if index < total_jokers then --check if there is a joker on the right
                            joker2 = G.consumeables.cards[index + 1] -- 
                        end
                    end
                    if joker1 == card then
                        joker1 = nil
                    end
                    if joker2 == card then
                        joker2 = nil
                    end

                    local effect1
                    local effect2
                    if joker1 and joker1.ability.set == 'Joker' then
                        effect1 = SMODS.blueprint_effect(card, joker1, context)
                    end
                    if joker2 and joker2.ability.set == 'Joker' then
                        effect2 = SMODS.blueprint_effect(card, joker2, context)
                    end

                    local returned_effect
                    if effect1 and effect2 then
                        returned_effect = SMODS.merge_effects{effect1, effect2}
                    else
                        returned_effect = effect1 or effect2
                    end

                    if returned_effect then
                        return returned_effect
                    end
                end
            end
        end
    end
}