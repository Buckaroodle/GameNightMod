SMODS.Back {
    key = "pinochle",
    atlas = 'placeholders',
    pos = { x = 4, y = 2 },
    config = { hands = -1, discards = -1 },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hands, self.config.discards } }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local v = G.playing_cards[i]
                    local rank_number = v:get_id()
                    local suit_string = v.base.suit
                    if rank_number <= 8 then
                        v:remove()
                    elseif rank_number >= 9 then -- if you're reading this comment, then you are probably looking at this code with disgust
                        local rank_string = "Ace"
                        if rank_number == 14 then -- supposedly, SMODS should be able to accept "rank = 14" and know it's an ace
                            rank_string = "Ace"
                        elseif rank_number == 13 then -- but apparently it's bugged or something
                            rank_string = "King"
                        elseif rank_number == 12 then -- so i had to do this shit
                            rank_string = "Queen"
                            elseif rank_number == 11 then -- i apologize for my sins
                            rank_string = "Jack"
                        elseif rank_number == 10 then
                            rank_string = "10"
                        elseif rank_number == 9 then
                            rank_string = "9"
                        end
                        SMODS.add_card{ set = "Base", rank = rank_string , suit = suit_string, area = G.deck }
                    end
                end
                return true
            end
        }))
    end
}

-- if card has rank 8 or below, remove from deck
-- 2nd runthrough, duplicate all cards