local attributeStringOneTable = { --before orange text
    ['chips'] = 'give ',
    ['mult'] = 'give ',
    ['xmult'] = 'give ',
    ['xchips'] = 'give ',
    ['score'] = 'give ',
    ['Xscore'] = 'give ',
    ['blindsize'] = 'give ',
    ['Xblindsize'] = 'give ',
    ['scaling'] = 'have ',
    ['suit'] = 'trigger on a certain ',
    ['rank'] = 'trigger on a certain ',
    ['hand_type'] = 'trigger on a certain ',
    ['spades'] = 'trigger on ',
    ['hearts'] = 'trigger on ',
    ['clubs'] = 'trigger on ',
    ['diamonds'] = 'trigger on ',
    ['hand_level'] = 'affect ',
    ['ace'] = 'trigger on ',
    ['king'] = 'trigger on ',
    ['queen'] = 'trigger on ',
    ['jack'] = 'trigger on ',
    ['ten'] = 'trigger on ',
    ['nine'] = 'trigger on ',
    ['eight'] = 'trigger on ',
    ['seven'] = 'trigger on ',
    ['six'] = 'trigger on ',
    ['five'] = 'trigger on ',
    ['four'] = 'trigger on ',
    ['three'] = 'trigger on ',
    ['two'] = 'trigger on ',
    ['face'] = 'trigger on ',
    ['economy'] = 'relate to',
    ['lose_economy'] = 'relate to',
    ['generation'] = 'relate to card ',
    ['shop'] = 'relate to',
    ['booster'] = 'relate to',
    ['destroy_card'] = 'relate to card ',
    ['hands'] = 'relate to',
    ['discards'] = 'relate to',
    ['hand_size'] = 'relate to',
    ['chance'] = 'relate to',
    ['consumable_slot'] = 'relate to',
    ['mod_chance'] = 'affect ',
    ['passive'] = 'give a ',
    ['copying'] = 'relate to ',
    ['full_deck'] = 'relate to the ',
    ['joker'] = 'relate to ',
    ['consumable'] = 'relate to ',
    ['joker_slot'] = 'relate to ',
    ['rarity'] = 'relate to Joker ',
    ['position'] = 'relate to card ',
    ['tarot'] = 'relate to ',
    ['planet'] = 'relate to ',
    ['spectral'] = 'relate to ',
    ['playing_card'] = 'relate to ',
    ['enhancements'] = 'relate to ',
    ['seals'] = 'relate to ',
    ['editions'] = 'relate to ',
    ['tag'] = 'relate to ',
    ['skip'] = 'relate to ',
    ['perma_bonus'] = 'give ',
    ['boss_blind'] = 'relate to ',
    ['debuff'] = 'relate to ',
    ['face_down'] = 'relate to ',
    ['large_blind'] = 'set ',
    ['ante'] = 'affect the ',
    ['reroll'] = 'relate to ',
    ['on_sell'] = 'relate to ',
    ['sell_value'] = 'relate to ',
    ['food'] = 'relate to ',
    ['space'] = 'relate to ',
}

local attributeStringTwoTable = { --orange text
    ['chips'] = 'chips',
    ['mult'] = 'Mult',
    ['xmult'] = 'Xmult',
    ['xchips'] = 'Xchips',
    ['score'] = 'score',
    ['Xscore'] = 'Xscore',
    ['blindsize'] = 'Blind size',
    ['Xblindsize'] = 'XBlind size ',
    ['balance'] = 'balance',
    ['swap'] = 'swap',
    ['retrigger'] = 'retrigger',
    ['scaling'] = 'scaling',
    ['reset'] = 'reset',
    ['suit'] = 'suit',
    ['rank'] = 'rank',
    ['hand_type'] = 'hand type',
    ['spades'] = 'Spades',
    ['hearts'] = 'Hearts',
    ['clubs'] = 'Clubs',
    ['diamonds'] = 'Diamonds',
    ['hand_level'] = 'hand levels',
    ['ace'] = 'Aces',
    ['king'] = 'Kings',
    ['queen'] = 'Queens',
    ['jack'] = 'Jacks',
    ['ten'] = '10s',
    ['nine'] = '9s',
    ['eight'] = '8s',
    ['seven'] = '7s',
    ['six'] = '6s',
    ['five'] = '5s',
    ['four'] = '4s',
    ['three'] = '3s',
    ['two'] = '2s',
    ['face'] = 'face cards',
    ['economy'] = 'economy',
    ['lose_economy'] = 'losing money',
    ['generation'] = 'generation',
    ['shop'] = 'the Shop',
    ['booster'] = 'Booster Packs',
    ['destroy_card'] = 'destruction',
    ['hands'] = 'hands',
    ['discards'] = 'discards',
    ['hand_size'] = 'hand size',
    ['chance'] = 'chance',
    ['consumable_slot'] = 'consumable slots',
    ['mod_chance'] = 'probabilities',
    ['passive'] = 'passive bonus',
    ['copying'] = 'copying',
    ['full_deck'] = 'full deck',
    ['joker'] = 'Joker',
    ['consumable'] = 'consumables',
    ['joker_slot'] = 'Joker slots',
    ['rarity'] = 'rarity',
    ['position'] = 'positions',
    ['tarot'] = 'Tarot',
    ['planet'] = 'Planet',
    ['spectral'] = 'Spectral',
    ['playing_card'] = 'playing cards',
    ['enhancements'] = 'enhancements',
    ['seals'] = 'seals',
    ['editions'] = 'editions',
    ['tag'] = 'tags',
    ['skip'] = 'skipping',
    ['modify'] = 'modify',
    ['perma_bonus'] = 'permanent modifications',
    ['prevents_death'] = 'prevent Death',
    ['boss_blind'] = 'Boss Blinds',
    ['debuff'] = 'debuffs',
    ['face_down'] = 'face down',
    ['large_blind'] = 'large Blind',
    ['ante'] = 'Ante',
    ['reroll'] = 'rerolls',
    ['on_sell'] = 'selling',
    ['sell_value'] = 'sell values',
    ['food'] = 'food',
    ['space'] = 'space',
}

local attributeStringThreeTable = { --after orange text
    ['balance'] = ' chips and Mult',
    ['swap'] = ' chips and Mult',
    ['retrigger'] = ' cards',
    ['joker'] = ' cards',
    ['tarot'] = ' cards',
    ['planet'] = ' cards',
    ['spectral'] = ' cards',
    ['skip'] = ' Blinds',
    ['modify_card'] = 'playing cards',
    ['face_down'] = ' cards',
    ['large_blind'] = ' requirements',
    ['on_sell'] = ' cards'
}

SMODS.Joker {
    key = 'guesswho',
    atlas = 'bgn_joker_sprites',
    attributes = {
        'joker',
        'xmult',
    },
    pos = {
        x = 2,
        y = 10
    },
    config = {
        extra = {
            xmult = 1.5,
            string_one = '',
            string_two = '',
            string_three = '',
            chosen_attribute = '',
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.string_one,
                card.ability.extra.string_two,
                card.ability.extra.string_three,
                card.ability.extra.chosen_attribute,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:has_attribute(card.ability.extra.chosen_attribute) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local total_attributes = {}
            for i, joker in ipairs(G.jokers.cards) do
                for i, thing in pairs(joker.config.center.attributes) do
                    local value = i
                    if type(value) == 'string' then
                        local dupe = false
                        for i, attribute in ipairs(total_attributes) do
                            if attribute == value then
                                dupe = true
                            end
                        end
                        if not dupe then
                            table.insert(total_attributes, value)
                        end
                    end
                end
            end
            card.ability.extra.chosen_attribute = pseudorandom_element(total_attributes, 'bgn_guesswho')
            card.ability.extra.string_one = attributeStringOneTable[card.ability.extra.chosen_attribute] or ''
            card.ability.extra.string_two = attributeStringTwoTable[card.ability.extra.chosen_attribute] or ''
            card.ability.extra.string_three = attributeStringThreeTable[card.ability.extra.chosen_attribute] or ''
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local total_attributes = {}
        if G.jokers then
            for i, joker in ipairs(G.jokers.cards) do
                for i, thing in pairs(joker.config.center.attributes) do
                    local value = i
                    if type(value) == 'string' and not card.ability.extra.chosen_attribute then
                        local dupe = false
                        for i, attribute in ipairs(total_attributes) do
                            if attribute == value then
                                dupe = true
                            end
                        end
                        if not dupe then
                            table.insert(total_attributes, value)
                        end
                    end
                end
            end
        end
        card.ability.extra.chosen_attribute = pseudorandom_element(total_attributes, 'bgn_guesswho') or 'chips'
        card.ability.extra.string_one = attributeStringOneTable[card.ability.extra.chosen_attribute] or ''
        card.ability.extra.string_two = attributeStringTwoTable[card.ability.extra.chosen_attribute] or ''
        card.ability.extra.string_three = attributeStringThreeTable[card.ability.extra.chosen_attribute] or ''
    end
}