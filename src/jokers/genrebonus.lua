SMODS.Joker {
    key = 'genrebonus',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'economy',
        'enhancement'
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            money = 3,
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local enhancement_counts = {}
            card.ability.extra.scoring_enhancements = {}
            for _, playing_card in ipairs(context.scoring_hand) do
                local enhancements = SMODS.get_enhancements(playing_card)
                if enhancements then
                    for enh_key, active in pairs(enhancements) do
                        if active then
                            enhancement_counts[enh_key] = (enhancement_counts[enh_key] or 0) + 1
                        end
                    end
                end
            end
            for enh_key, count in pairs(enhancement_counts) do
                if count >= 2 then
                    table.insert(card.ability.extra.scoring_enhancements, enh_key)
                end
            end
        end
        if context.individual and context.cardarea == G.play then
            for _, enhancement in ipairs(card.ability.extra.scoring_enhancements) do
                if SMODS.has_enhancement(context.other_card, enhancement) then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                    return {
                        dollars = card.ability.extra.money,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.dollar_buffer = 0
                                    return true
                                end
                            }))
                        end
                    }
                end
            end
        end
    end
}
