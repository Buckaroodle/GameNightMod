SMODS.Joker {
    key = 'assassin',
    atlas = 'bgn_joker_sprites',
    pos = {
        x = 4,
        y = 0
    },
    config = {
        extra = {
            mult = 0,
            mult_gain = 1
        }
    },
    rarity = 1,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local assassin_card = G.GAME.current_round.assassin_card or { rank = 'Ace', suit = 'Spades' }
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_gain,
                localize(assassin_card.rank, 'ranks'),
                localize(assassin_card.suit, 'suits_plural'),
                colours = { G.C.SUITS[assassin_card.suit] }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then -- check to see if assassin_card was scored BEFORE cards score
        local assassin_triggered = false
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() == G.GAME.current_round.assassin_card.id and -- NOTE: get_id() returns a rank, and we're doing a rank == rank comparison
            playing_card:is_suit(G.GAME.current_round.assassin_card.suit)then -- HOWEVER here, we're asking "is the card's suit the same as the other suit), returning a true/false value"
                assassin_triggered = true
                break
            end
        end
        if assassin_triggered then
                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

local function reset_assassin_card()
    G.GAME.current_round.assassin_card = { rank = 'Ace', suit = 'Spades' }
    local valid_assassin_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_assassin_cards[#valid_assassin_cards + 1] = playing_card
        end
    end
    local assassin_card = pseudorandom_element(valid_assassin_cards, 'assassin' .. G.GAME.round_resets.ante)
    if assassin_card then
        G.GAME.current_round.assassin_card.rank = assassin_card.base.value
        G.GAME.current_round.assassin_card.suit = assassin_card.base.suit
        G.GAME.current_round.assassin_card.id = assassin_card.base.id
    end
end


function SMODS.current_mod.reset_game_globals(run_start)
    reset_assassin_card()
end