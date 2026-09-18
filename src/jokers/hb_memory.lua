--local possible_cards = {}

SMODS.Joker {
    key = 'memory',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'edition', 'face_down'
    },
    pos = {
        x = 0,
        y = 5
    },
    pixel_size = { h = 71 },
    config = {
        extra = {
            flipped_cards = {}
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.flipped_cards
            }
        }
    end,

    -- option 1
    --[[calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card.facing == "back" then
                if context.other_card.edition == nil then
                    local random_edition = SMODS.poll_edition { key = "bgn_memory", guaranteed = true, no_negative = true }
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if chosen_card ~= nil then
                                chosen_card:set_edition(random_edition)
                                chosen_card:juice_up()
                            end
                        return true 
                        end,
                    }))
                end
            end
        end
    end]]

    -- option 2
    calculate = function(self, card, context)
        --local possible_cards = {}
        if context.press_play then
            card.ability.extra.flipped_cards = {}
            for _, playing_card in ipairs(G.hand.highlighted) do
                if playing_card.edition == nil and playing_card.facing == "back" then
                   table.insert(card.ability.extra.flipped_cards, playing_card)
                end
            end
        end
        if context.before and context.scoring_hand then
            if card.ability.extra.flipped_cards and #card.ability.extra.flipped_cards > 0 then
                for _, scoring_card in ipairs(context.scoring_hand) do
                    for _, flipped_card in ipairs(card.ability.extra.flipped_cards) do
                        if flipped_card == scoring_card then
                            local target_card = scoring_card
                            local random_edition = SMODS.poll_edition { key = "modprefix_seed", guaranteed = true, no_negative = true }
                            --G.E_MANAGER:add_event(Event({
                                --func = function()
                                    if target_card ~= nil then
                                        target_card:set_edition(random_edition)
                                        target_card:juice_up()
                                    end
                                --return true 
                                --end,
                            --}))
                        end
                    end
                end
            end
        end
    end
}

-- context.other_card.facing == "back"