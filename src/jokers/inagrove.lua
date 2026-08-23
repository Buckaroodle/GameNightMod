SMODS.Joker {
    key = 'inagrove',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips', 'mult', 'five'
    },
    pos = {
        x = 5,
        y = 2
    },
    rarity = 1,
    cost = 4,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local give_mult = false
            local chips_value = 0
            local mult_value = 5
            for i, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() ~= nil then
                    chips_value = math.max(playing_card:get_id(), chips_value, 0)
                    mult_value = math.min(playing_card:get_id(), mult_value, 5)
                end
                if playing_card:get_id() == 5 then
                    give_mult = true
                end
            end
                --print(chips_value)
                --print(mult_value)
                --print(give_mult)
            if give_mult == true then
                --print('hello!!!')
                return {
                    mult = mult_value
                }
            else
                return {
                    chips = chips_value
                }
            end
        end
    end
}