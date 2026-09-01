SMODS.Joker {
    key = 'dominanttrait',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'xmult',
        'joker'
    },
    pos = {
        x = 0,
        y = 2
    },
    config = {
        extra = {
            Xmult = 3
        }
    },
    rarity = 3,
    cost = 7,
    --blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult
            }
        }
    end,

    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,

    calculate = function(self, card, context)
        if context.card_added or context.buying_self then
            G.E_MANAGER:add_event(Event({
            func = function() 
                for _, jokers in ipairs(G.jokers.cards) do
                    if jokers.config.center.eternal_compat == true then
                        jokers:add_sticker("eternal", true)
                    end
                end
                return true 
            end,
            }))
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,

    in_pool = function(self, args)
        if args.source == 'sho' then
            return true
        else
            return false
        end
    end
}