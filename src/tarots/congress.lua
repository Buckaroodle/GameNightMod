SMODS.Consumable {
    key = 'congress',
    atlas = 'bgn_consumables',
    set = 'Tarot',
    pos = {
        x = 4,
        y = 1
    },
    cost = 3,
    config = { extra = { money = 0, money_per_card = 5 } },
    loc_vars = function(self, info_queue, card)
        local ranks_list = {}
        local max_card_count = 0
        if G.hand then
            for _, playing_card in ipairs(G.hand.cards) do
                if not SMODS.has_no_rank(playing_card) then
                    ranks_list[playing_card:get_id()] = (ranks_list[playing_card:get_id()] or 0) + 1
                    if ranks_list[playing_card:get_id()] > max_card_count then
                        max_card_count = ranks_list[playing_card:get_id()]
                    end
                end
            end
        end
        card.ability.extra.money = card.ability.extra.money_per_card * (max_card_count or 0)
        return { vars = { card.ability.extra.money, card.ability.extra.money_per_card } }
    end,
    use = function(self, card, area, copier)
        local ranks_list = {}
        local max_card_count = 0
        for _, playing_card in ipairs(G.hand.cards) do
            if not SMODS.has_no_rank(playing_card) then
                ranks_list[playing_card:get_id()] = (ranks_list[playing_card:get_id()] or 0) + 1
                if ranks_list[playing_card:get_id()] > max_card_count then
                    max_card_count = ranks_list[playing_card:get_id()]
                end
            end
        end
        card.ability.extra.money = card.ability.extra.money_per_card * max_card_count
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(card.ability.extra.money, true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end
}