SMODS.Joker {
    key = 'mancala',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'passive',
    },
    pos = {
        x = 4,
        y = 5
    },
    config = {
        extra = {
            --chips = 40
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {    
                --card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        --[[if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local stone_cards = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then
                    stone_cards = stone_cards + 1
                end
            end
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    chips = card.ability.extra.chips * stone_cards
                }
            end
        end]]

        --[[if context.before then
            local has_stone_card = false
            for _, playing_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') and not playing_card.debuff then
                    has_stone_card = true
                    break
                end
            end
            if has_stone_card == true then
                local percent = 1
                for i = 1, #G.hand.cards do
                    --if G.hand.cards[i]:get_id() == 10 and not G.hand.cards[i].highlighted then
                    if SMODS.has_enhancement(G.hand.cards[i], 'm_stone') and not G.hand.cards[i].highlighted then
                        highlight_card(G.hand.cards[i], (percent - 0.999)/#G.hand.cards)
                        percent = percent + 1
                    end
                end
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 9 then
                local juiced_card = context.blueprint_card or card
                return {
                    card = juiced_card,
                    func = function ()
                        for k, v in pairs(G.hand.cards) do
                            if SMODS.has_enhancement(v, 'm_stone') then
                                local new_context = {
                                cardarea = context.cardarea,
                                full_hand = context.full_hand,
                                scoring_hand = context.scoring_hand,
                                scoring_name = context.scoring_name,
                                poker_hands = context.poker_hands
                                }
                                SMODS.score_card(v, new_context)
                            end
                        end
                    end
                }
            end
        end]]
    end
}

local score_card_ref = SMODS.score_card
function SMODS.score_card(card, context)
	if not G.scorehand and context.cardarea == G.hand and next(SMODS.find_card("j_bgn_mancala")) and SMODS.has_enhancement(card, 'm_stone') then
		G.scorehand = true
		context.cardarea = G.play
		SMODS.score_card(card, context)
		G.scorehand = nil
		context.cardarea = G.hand
	end
	return score_card_ref(card, context)
end