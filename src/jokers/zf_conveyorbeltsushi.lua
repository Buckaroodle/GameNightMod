SMODS.Joker {
    key = 'conveyorbeltsushi',
    atlas = 'placeholders',
    attributes = {
        'reroll',
        'food'
    },
    pos = {
        x = 1,
        y = 0
    },
    config = {
		extra = {
			freerolls = 6,
			cached_freerolls = 0,
			used_freerolls = 0
		}
	},
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.freerolls - card.ability.extra.used_freerolls
			}
		}
	end,
    calculate = function(self, card, context)
		if context.reroll_shop and not context.blueprint and card.ability.extra.used_freerolls < card.ability.extra.freerolls then
			for _, v in ipairs(G.jokers.cards) do	-- this is to allow multiple tires to work together (ghostsalt)
				if v.config.center.key == "j_bgn_conveyorbeltsushi" and v.ability.extra.i_rerolled then
					return
				end
			end
			card.ability.extra.i_rerolled = true

			card.ability.extra.used_freerolls = card.ability.extra.used_freerolls + 1
			card.ability.extra.cached_freerolls = card.ability.extra.cached_freerolls + 1

            if card.ability.extra.used_freerolls >= card.ability.extra.freerolls then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            end
			
			G.E_MANAGER:add_event(Event({
                func = function()
					card.ability.extra.i_rerolled = nil
					return true
				end
			}))
		end

		if context.ending_shop and not context.blueprint then
			SMODS.change_free_rerolls(-card.ability.extra.cached_freerolls)
			card.ability.extra.cached_freerolls = 0
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.freerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.used_freerolls < card.ability.extra.freerolls or card.ability.extra.cached_freerolls > 0 then
        	SMODS.change_free_rerolls(-(card.ability.extra.freerolls - card.ability.extra.used_freerolls + card.ability.extra.cached_freerolls))
		end
    end
}