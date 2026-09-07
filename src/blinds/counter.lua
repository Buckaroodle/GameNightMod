SMODS.Blind {
    key = 'counter',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 18 },
    dollars = 5,
    mult = 2,
    boss = { min = 2, max = 10 },
    boss_colour = HEX('4685C0'),
    debuff_hand = function(self, cards, hand, handname, check)
        local card_total = 0
        for _, scoring_card in ipairs(cards) do
            if not SMODS.has_no_rank(scoring_card) then
                --local rank_number = scoring_card:get_id()
                if not scoring_card.debuff then
                    if scoring_card:get_id() == 14 then
                        card_total = card_total + 1
                    elseif scoring_card:get_id() == 13 or scoring_card:get_id() == 12 or scoring_card:get_id() == 11 then
                        card_total = card_total + 10
                    else
                        card_total = card_total + scoring_card:get_id()
                    end
                end
            end
        end
        if card_total < 30 then
            return false
        else
            G.GAME.blind.triggered = true
            return true
        end
    end,
}