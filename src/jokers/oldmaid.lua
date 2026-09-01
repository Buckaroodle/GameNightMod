SMODS.Joker {
    key = 'oldmaid',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'generation',
    },
    pos = {
        x = 5,
        y = 5
    },
    rarity = 3,
    cost = 10,
    eternal_compat = false,
    calculate = function(self, card, context)
        if context.joker_type_destroyed then
            print('almost!')
            if context.card == card then
                print('done!')
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Joker', legendary = true, key_append = "bgn_oldmaid" })
                    check_for_unlock { type = 'spawn_legendary' }
                    card:juice_up(0.3, 0.5)
                    return true
                end
                }))
                delay(0.6)
            end
        end
    end
}

local can_sell_card_ref = Card.can_sell_card
function Card:can_sell_card(context)
	if self.config.center.key == 'j_bgn_oldmaid' then
		return false
	end
	return can_sell_card_ref(self, context)
end