SMODS.Joker {
    key = 'blackjack',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'chips',
        'scaling',
        'reset',
        'rank',
    },
    unlocked = false,
    pos = {
        x = 5,
        y = 4
    },
    config = {
        extra = {
            chips = 0,
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local chip_total = 0
            local ace_count = 0
            for i, playing_card in ipairs(context.scoring_hand) do
                if SMODS.has_no_rank(playing_card) == false then
                    local id = playing_card:get_id()
                    if id == 14 then -- count aces separately
                        ace_count = ace_count + 1
                    elseif id <= 13 and id >= 11 then -- count all face cards as 10
                        chip_total = chip_total + 10
                    else -- count all other cards normally
                        chip_total = chip_total + id
                    end
                end
            end
            if chip_total <= 21 and ace_count > 0 then
                for i = 1, ace_count do
                    if chip_total + 11 <= 21 then
                        chip_total = chip_total + 11
                    else
                        chip_total = chip_total + 1
                    end
                end
            end
            if chip_total <= 21 then
                card.ability.extra.chips = card.ability.extra.chips + chip_total
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                }
            else
                card.ability.extra.chips = 0
                return {
                    message = 'Bust!',
                    colour = G.C.BLUE
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local tally = 0
            for j = 1, #args.cards do
                --if SMODS.has_enhancement(args.cards[j], 'm_gold') then
                if args.cards[j]:get_id() == 11 and (args.cards[j]:is_suit('Spades') or args.cards[j]:is_suit('Clubs')) then
                    tally = tally + 1
                    if tally == 5 then
                        return true
                    end
                end
            end
        end
        return false
    end
}