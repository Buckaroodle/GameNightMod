SMODS.Joker {
    key = 'shutthebox',
    atlas = 'placeholders',
    attributes = {
        'rank',
        'tag',
        'generation',
    },
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            needed_ranks = {'Ace', 'King', 'Queen', 'Jack', '10', '9', '8', '7', '6', '5', '4', '3', '2'}
        }
    },
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        local concat_ranks = {}
        local max_characters = 15
        local max_concat = 5
        local current_group = {}
        local current_characters = 0
        for i, rank in ipairs(card.ability.extra.needed_ranks) do
            local string_length = #rank
            local concat_limit_reached = (current_characters + string_length > max_characters) or (#current_group >= max_concat)
            if concat_limit_reached and #current_group > 0 then
                table.insert(concat_ranks, 1, table.concat(current_group, ", "))
                current_group = {}
                current_characters = 0
            end
            table.insert(current_group, rank)
            current_characters = current_characters + string_length
        end
        if #current_group > 0 then
            table.insert(concat_ranks, 1, table.concat(current_group, ", "))
        end
        local nodes = {}
        local index = 0
        for i = #concat_ranks, 1, -1 do
            local key = concat_ranks[i]
            nodes[#nodes+1] = {n = G.UIT.R, config = {align = "cm", padding = 0.02}, nodes = {
                {n = G.UIT.T, config = {text = key, colour = G.C.FILTER, scale = 0.32}}
            }} 
            index = index + 1
        end
        return {main_end = {{n = G.UIT.R, config = {align = "cm"}, nodes = nodes}},}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card.base.value
            for i, rank in ipairs(card.ability.extra.needed_ranks) do
                if id == card.ability.extra.needed_ranks[i] then
                    table.remove(card.ability.extra.needed_ranks, i)
                    break
                end
            end
            if #card.ability.extra.needed_ranks == 0 then
                card.ability.extra.needed_ranks = {'Ace', 'King', 'Queen', 'Jack', '10', '9', '8', '7', '6', '5', '4', '3', '2'}
                return {
                    focus = card,
                    message = localize('bgn_plus_tag'),
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                bgn_add_tag(bgn_poll_tag("bgn_shutthebox"))
                                return true
                            end)
                        }))
                    end,
                    card = card
                }
            end
        end
    end
}

-- taken from AIJ which repurposed from paperback
function bgn_poll_tag(seed, options)
  -- This part is basically a copy of how the base game does it
  -- Look at get_next_tag_key in common_events.lua
  local pool = options or get_current_pool('Tag')
  local tag_key = pseudorandom_element(pool, pseudoseed(seed))

  while tag_key == 'UNAVAILABLE' do
    tag_key = pseudorandom_element(pool, pseudoseed(seed))
  end

  local tag = Tag(tag_key)

  -- The way the hand for an orbital tag in the base game is selected could cause issues
  -- with mods that modify blinds, so we randomly pick one from all visible hands
  if tag_key == "tag_orbital" then
    local available_hands = {}

    for _, k in ipairs(G.handlist) do
      local hand = G.GAME.hands[k]
      if hand.visible then
        available_hands[#available_hands + 1] = k
      end
    end

    tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed(seed .. '_orbital'))
  end

  return tag
end

-- also taken from AIJ which repurposed from paperback
function bgn_add_tag(tag, event, silent)
  local func = function()
    add_tag(type(tag) == 'string' and Tag(tag) or tag)
    if not silent then
      play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
      play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
    end
    return true
  end

  if event then
    G.E_MANAGER:add_event(Event {
      func = func
    })
  else
    func()
  end
end