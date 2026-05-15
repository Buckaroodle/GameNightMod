return {
    descriptions = {
        Joker = {
            j_bgn_bettelmann = {
                name = 'Bettelmann',
                text = {
                    {
                        '{C:green}#1# in #2#{} chance',
                        'to give {C:chips}+#3#{} chips'
                    },{
                        '{C:inactive}Art by VoxDaFox'
                    }
                }
            },
            j_bgn_draw4wild = {
                name = 'Draw 4 Wild',
                text = {
                    '{C:attention}+#1#{} hand size',
                    'for every {C:attention}#2#{} Wild{} cards',
                    'in your full deck',
                    "{C:inactive}(Currently {C:attention}+#3#{C:inactive} hand size){}",
                    '{C:inactive}(Max of {C:attention}+#4#{C:inactive}){}'
                }
            },
            j_bgn_applestoapples = {
                name = 'Apples to Apples',
                text = {
                    'If played hand is a {C:attention}Pair{}',
                    'and contains exactly {C:attention}2{} cards,',
                    'convert the {C:attention}left{} card',
                    'into the {C:attention}right{} card'
                }
            },
            j_bgn_stand = {
                name = 'Stand',
                text = {
                    'If all cards {C:attention}held in hand',
                    'are {C:attention}different ranks,',
                    'each one scores {C:mult}Mult{}',
                    'equal to the number of',
                    'cards held in hand'
                }
            },
            j_bgn_assassin = {
                name = 'Assassin',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    "per {C:attention}consecutive{} hand",
                    "played without scoring a",
                    "{C:attention}#3#{} of {V:1}#4#{}",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{s:0.8}Card changes every round"
                }
            },
            j_bgn_pegboard = {
                name = "Pegboard",
                text = {
                    {
                        'This Joker gains {C:chips}+#2#{} chips',
                        'for every {C:attention}combination{} of',
                        'scoring cards',
                        '{C:attention}totaling 15',
                        '{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips)'
                    },{
                        '{C:attention}Jacks, Queens, and',
                        '{C:attention}Kings{}{C:inactive} are each worth {C:attention}10,',
                        '{C:attention}Aces{}{C:inactive} are worth {C:attention}1'
                    }
                }
            },
            j_bgn_scoundrel = {
                name = "Scoundrel",
                text = {
                    {
                        '{X:mult,C:white}X#1#{} Mult if',
                        'played hand is {C:attention}weaker',
                        'than a {C:attention}#2#.',
                        'Poker hand decreases',
                        'after each successful trigger'
                    },{
                        'If played hand is a',
                        '{C:attention}High Card{}, this Joker',
                        'is destroyed'
                    }
                }
            },
            j_bgn_garbage = {
                name = "Garbage",
                text = {
                    'This Joker gains {C:chips}+#2#{} chips',
                    'for every {C:attention}consecutive{}',
                    '{C:attention}10{} {C:inactive}[#4#]{} cards discarded',
                    'without a discarded',
                    '{C:attention}face card',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips)'
                }
            },
            j_bgn_trafficlight = {
                name = "Traffic Light",
                text = {
                    {
                        '{X:mult,C:white}X#3#{} Mult when',
                        'light is {C:attention}green,',
                        '{C:green}#1# in #2#{} chance',
                        'after each hand played',
                        'to turn {C:attention}red{}'
                    },{
                        'A {C:attention}#4#{} must be',
                        'played to turn light',
                        'back to {C:attention}green'
                    }
                }
            },
            j_bgn_newrule = {
                name = "New Rule",
                text = {
                    'Adds {C:green}#1# and #2#',
                    'to the left and right sides',
                    'of all {C:green}probabilities',
                    '{C:inactive}(ex: {C:green}1 in 4{} -> {C:green}#3# in #4#{})'
                }
            },
            j_bgn_mermaid = {
                name = "Mermaid",
                text = {
                    'Earn {C:money}$#1#{} for each',
                    'card held in hand',
                    'of the suit you have',
                    'the most of in your hand',
                    'at the end of round'
                }
            },
            j_bgn_dominanttrait = {
                name = "Dominant Trait",
                text = {
                    {
                      '{X:mult,C:white}X#1#{} Mult'
                    },{
                        'All Jokers gain',
                        'Eternal stickers'
                    }
                }
            },
            j_bgn_scoutandshow = {
                name = "Scout & Show",
                text = {
                    'After scoring,',
                    'return a random scored card',
                    '{C:attention}back to your hand'
                }
            },
            j_bgn_freecell = {
                name = "Free Cell",
                text = {
                    'This Joker gives',
                    '{C:dark_edition}+#1#{} Joker slot',
                    'when a {C:dark_edition}Negative{} Joker',
                    'is sold or destroyed',
                    '{C:inactive}(Currently {C:dark_edition}+#2#{C:inactive} slots)',
                    '{C:inactive}(Max of {C:dark_edition}+#3#{C:inactive}){}'
                }
            },
            j_bgn_palace = {
                name = "Palace",
                text = {
                    'After scoring,',
                    'all cards {C:attention}held in hand',
                    'move to your {C:attention}discards'
                }
            }
            --[[,j_bgn_tripleletterscore = {
                name = "Triple Letter Score",
                text = {
                    '+#2# chips for each',
                    'letter in all Joker names',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips)'
                }
            }]]
        },

        Back = {
            b_bgn_pinochle = {
                name = 'Frontloaded Deck',
                text = {
                    "Start run with {C:attention}2{} copies",
                    "of the ranks {C:attention}9 - Ace",
                    "",
                    "{C:blue}#1#{} hand",
                    "{C:red}#2#{} discard",
                    "every round",
                    "",
                    '{C:inactive,s:0.85}Art by mintycreamfluff'
                }
            }
            --[[,b_bgn_stocked = {
                name = 'Stocked Deck',
                text = {
                    '{C:attention}+1{} card slot in shop',
                    '{C:attention}+1{} voucher slot in shop',
                    '{C:attention}+1{} pack slot in shop',
                    '',
                    'Reroll cost starts at {C:money}$0{}',
                    'and does not reset each shop'
                }
            }]]
        }
    }
}