SMODS.Blind {
    key = 'man',
    atlas = 'bgn_blinds',
    --atlas_table = 'ANIMATION_ATLAS',
    pos = { x = 0, y = 6 },
    dollars = 5,
    mult = 2,
    boss = { min = 4, max = 10 },
    boss_colour = HEX('D95D48'),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.after then
            local all_jokers = SMODS.shallow_copy(G.jokers.cards)
            local all_stickers = {'eternal', 'perishable', 'rental'}
            pseudoshuffle(all_jokers, 'bgn_man')
            pseudoshuffle(all_stickers, 'bgn_man')
            for i, joker in ipairs(all_jokers) do
                local can_get_eternal = false
                local can_get_perishable = false
                local can_get_rental = false
                if not joker.config.center.eternal_compat == false and not joker.ability.eternal == true and not joker.ability.perishable == true then
                    can_get_eternal = true
                end
                if not joker.ability.perishable and not joker.ability.eternal then
                    can_get_perishable = true
                end
                if not joker.ability.rental then
                    can_get_rental = true
                end
                for i = 1, #all_stickers do
                    if all_stickers[i] == 'eternal' and can_get_eternal == true then
                        joker:set_eternal(true)
                        blind:wiggle()
                        return
                    elseif all_stickers[i] == 'perishable' and can_get_perishable == true then
                        joker:set_perishable(true)
                        blind:wiggle()
                        return
                    elseif all_stickers[i] == 'rental' and can_get_rental == true then
                        joker:set_rental(true)
                        blind:wiggle()
                        return
                    end
                end
            end
        end
    end
}