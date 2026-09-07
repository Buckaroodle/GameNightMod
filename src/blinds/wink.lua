SMODS.Blind {
    key = 'wink',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 17 },
    dollars = 5,
    mult = 2,
    boss = { min = 3, max = 10 },
    boss_colour = HEX('D47D3D'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.drawing_cards then
            local chosen_cards = {}
            --local target_amount = #context.amount
            for i = #G.deck.cards, 1, -1 do
                if #chosen_cards >= context.amount then
                    break 
                end
                local card = G.deck.cards[i]
                if not card:get_seal() then
                    table.insert(chosen_cards, 1, card)
                    table.remove(G.deck.cards, i)
                end
            end
            for _, card in ipairs(chosen_cards) do
                table.insert(G.deck.cards, card)
            end
        end
    end
}