local function integer_to_rank(id)
    local rank = nil
    for k, v in pairs(SMODS.Ranks) do
        if v.id == id then
            rank = v.key
        end
    end
    return rank
end

SMODS.Joker {
    key = 'wavelength',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'rank',
        'mult',
    },
    pos = {
        x = 6,
        y = 3
    },
    config = {
        extra = {
            large_mult = 15,
            medium_mult = 10,
            small_mult = 5,
            target_id = 7,
            rank_string = '???'
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.large_mult,
                card.ability.extra.medium_mult,
                card.ability.extra.small_mult,
                card.ability.extra.target_id,
                card.ability.extra.rank_string,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not SMODS.has_no_rank(context.other_card) then
               if context.other_card:get_id() == card.ability.extra.target_id then
                    card.ability.extra.rank_string = integer_to_rank(card.ability.extra.target_id)
                    return {
                        mult = card.ability.extra.large_mult
                    }
               elseif (context.other_card:get_id() + 1 == card.ability.extra.target_id) or (context.other_card:get_id() - 1 == card.ability.extra.target_id) then
                    return {
                        mult = card.ability.extra.medium_mult
                    }
               elseif (context.other_card:get_id() + 2 == card.ability.extra.target_id) or (context.other_card:get_id() - 2 == card.ability.extra.target_id) then
                    return {
                        mult = card.ability.extra.small_mult
                    }
               end
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local seen_ranks = {}
            local all_ranks = {}
            for i, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(playing_card) then
                    local id = playing_card:get_id()
                    if not seen_ranks[id] then
                        seen_ranks[id] = true
                        table.insert(all_ranks, id)
                    end
                end
            end
            card.ability.extra.target_id = pseudorandom_element(all_ranks, 'bgn_wavelength')
            card.ability.extra.rank_string = '???'
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if G.playing_cards ~= nil then
            local seen_ranks = {}
            local all_ranks = {}
            for i, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(playing_card) then
                    local id = playing_card:get_id()
                    if not seen_ranks[id] then
                        seen_ranks[id] = true
                        table.insert(all_ranks, id)
                    end
                end
            end
            card.ability.extra.target_id = pseudorandom_element(all_ranks, 'bgn_wavelength')
            card.ability.extra.rank_string = '???'
        end
    end
}