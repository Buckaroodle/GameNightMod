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
                        '{C:inactive}Art by voxdafox'
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
                    'each one scores {C:mult}+#1#{} Mult',
                    --'equal to the number of',
                    --'cards held in hand'
                }
            },
            j_bgn_assassin = {
                name = 'Assassin',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    "per {C:attention}consecutive{} hand",
                    "played without",
                    "a scoring {C:attention}#3#{}",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{s:0.8}Rank changes every round"
                }
            },
            j_bgn_pegboard = {
                name = "Pegboard",
                text = {
                    {
                        'This Joker gains {C:chips}+#2#{} chips',
                        'for every {C:attention}combination{} of',
                        'played cards {C:attention}totaling 15',
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
                    'This Joker gains {X:mult,C:white}X#2#{} Mult',
                    'per {C:attention}consecutive{} hand played',
                    '{C:attention}weaker{} than your last played hand',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                    '{C:inactive}Last played hand was a #3#'
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
                    'card {C:attention}held in hand',
                    'of the {C:attention}suit{} you have',
                    'the {C:attention}most{} of in your hand',
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
                    'If only {C:attention}1{} card',
                    'is discarded,',
                    'all cards {C:attention}held in hand',
                    'move to your {C:attention}discards'
                }
            },
            j_bgn_doubleletterscore = {
                name = "Double Letter Score",
                text = {
                    '{C:chips}+#2#{} chips for each',
                    '{C:attention}letter{} in all Joker {C:attention}names',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips)'
                }
            },
            j_bgn_foundationpile = {
                name = "Foundation Pile",
                text = {
                    'If a single {C:attention}#3#{} is discarded,',
                    'this Joker gains {C:mult}+#2#{} Mult',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
                    '{s:0.8}Rank increases every successful discard'
                }
            },
            j_bgn_parkplace = {
                name = "Park Place",
                text = {
                    {
                        '{C:mult}+#1#{} Mult',
                    },{
                        '{X:mult,C:white}X#2#{} Mult',
                        'if {C:attention}Boardwalk{} is owned'
                    }
                }
            },
            j_bgn_boardwalk = {
                name = "Boardwalk",
                text = {
                    {
                        '{C:mult}+#1#{} Mult',
                    },{
                        '{X:mult,C:white}X#2#{} Mult',
                        'if {C:attention}Park Place{} is owned'
                    }
                }
            },
            j_bgn_tilejoker = {
                name = "Tile Joker",
                text = {
                    {
                        'If the scored cards',
                        'in the {C:attention}first hand{} of round',
                        'total {C:attention}#1# or greater,',
                        'level up {C:attention}#2#'
                    },{ 
                        '{C:attention}Jacks, Queens, and',
                        '{C:attention}Kings{}{C:inactive} are each worth {C:attention}10,',
                        '{C:attention}Aces{}{C:inactive} are worth {C:attention}11'
                    }
                    
                }
            },
            j_bgn_blindnil = {
                name = 'Blind Nil',
                text = {
                    {
                        '{C:chips}+#1#{} chips'
                    },{
                        'First hand each round',
                        'is {C:attention}drawn face down'
                    }
                }
            },
            j_bgn_routecard = {
                name = 'Route Card',
                text = {
                    'This Joker gains {X:mult,C:white}X#2#{} Mult',
                    'if played hand contains a {C:attention}Straight',
                    'and contains the ranks {C:attention}#5#{} and {C:attention}#6#{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                    '{s:0.8}Ranks change every round'
                }
            },
            j_bgn_dobble = {
                name = 'Dobble',
                text = {
                    'Cards drawn from the deck',
                    'will be {C:attention}different{} ranks',
                    'from cards held in hand',
                    '{s:0.8,C:inactive}(if possible)'
                }
            },
            j_bgn_cardczar = {
                name = 'Card Czar',
                text = {
                    'Gives 1 random {C:attention}scored card',
                    'a random {C:attention}edition',
                    'at end of round'
                }
            },
            j_bgn_gradedcard = {
                name = 'Graded Card',
                text = {
                    'Debuffs Joker on the {C:attention}right,',
                    'Gives {C:mult}Mult{} equal to',
                    'triple its sell value'
                }
            },
            j_bgn_memory = {
                name = 'Memory',
                text = {
                    'All scoring cards',
                    'played {C:attention}face down',
                    'gain a {C:attention}random edition'
                }
            },
            j_bgn_hungryhippo = {
                name = 'Hungry Hippo',
                text = {
                    'If a {C:attention}Food Joker{} is destroyed,',
                    'this Joker gains {X:mult,C:white}X#2#{C:inactive} Mult',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
                }
            },
            j_bgn_mancala = {
                name = 'Mancala',
                text = {
                    'Each {C:attention}Stone Card{} held in hand',
                    'gives {C:chips}+#1#{} chips {C:attention}multiplied',
                    'by the total number of',
                    '{C:attention}Stone Cards{} held in hand',
                }
            },
            j_bgn_detective = {
                name = 'Detective',
                text = {
                    {
                        'Each played {C:attention}#2#',
                        'of {C:attention}#3#{} gives',
                        '{X:mult,C:white}X#1#{} Mult if poker',
                        'hand is a {C:attention}#4#'
                    },{
                        '{C:inactive}Art by voxdafox'
                    }
                }
            },
            j_bgn_taboo = {
                name = 'Taboo',
                text = {
                    '{C:attention}Debuffed{} Jokers',
                    'and playing cards',
                    'give {X:mult,C:white}X#1#{} Mult'
                }
            },
            j_bgn_storedenergy = {
                name = 'Stored Energy',
                text = {
                    '{C:chips}+#1#{} chips for',
                    'each {C:attention}played{} card',
                    'that does not score'
                }
            },
            j_bgn_slamwich = {
                name = 'Slamwich',
                text = {
                    'If played hand is a {C:attention}Pair,',
                    'both scoring cards',
                    'retrigger additional times',
                    '{C:attention}equal{} to the number of',
                    '{C:attention}unscoring cards{} between them'
                }
            },
            j_bgn_ur = {
                name = 'Ur',
                text = {
                    'This Joker has a',
                    '{C:green}#1# in #2#{} chance',
                    'to gain {X:mult,C:white}X#3#{} Mult',
                    'at end of round',
                    '{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)'
                }
            },
            j_bgn_bananasplit = {
                name = 'Banana Split',
                text = {
                    '{C:mult}+#3#{} Mult',
                    '{C:green}#1# in #2#{} chance to {C:attention}halve{}',
                    '{C:mult}Mult{} at end of round'
                }
            },
            j_bgn_chutesandladders = {
                name = 'Chutes & Ladders',
                text = {
                    'This Joker gains {C:chips}+#4#{} chips',
                    'per card scored,',
                    '',
                    '{C:green}#1# in #2#{} chance to {C:attention}halve',
                    'chips each hand played',
                    '{C:inactive}(Currently {C:chips}+#3#{C:inactive} chips)'
                }
            },
            j_bgn_othello = {
                name = 'Othello',
                text = {
                    {
                        'If the {C:attention}first{} and {C:attention}last{} card',
                        'of the scoring hand',
                        'are the {C:attention}same suit,',
                        '{C:attention}convert{} all scoring cards',
                        'to that suit'
                    },{
                        '{C:inactive}Art by Hackakat'
                    }
                }
            },
            j_bgn_phase = {
                name = 'Phase',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    'for each {C:attention}unique{} poker hand',
                    'played this ante, resets',
                    'when Boss Blind is defeated'
                }
            },
            j_bgn_chancellor = {
                name = 'Chancellor',
                text = {
                    'This Joker gains {C:chips}+#2#{} chips',
                    'for each card {C:attention}taken{} or {C:attention}used{}',
                    'from a {C:attention}Booster Pack{}, resets',
                    'when a pack is {C:attention}skipped',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} chips)'
                }
            },
            j_bgn_yacht = {
                name = 'Yacht',
                text = {
                    'Earn {C:money}$#1#{} if shop',
                    'is not rerolled'
                }
            },
            j_bgn_genrebonus = {
                name = 'Genre Bonus',
                text = {
                    'Scored cards with the',
                    'same {C:attention}enhancement{} give {C:money}$#1#{}'
                }
            },
            j_bgn_patolli = {
                name = 'Patolli',
                text = {
                    'Earn {C:money}money{} equal to',
                    'the base {C:mult}Mult{} of',
                    'your played hand'
                }
            }
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
            },
            b_bgn_stocked = {
                name = 'Stocked Deck',
                text = {
                    '{C:attention}+1{} card slot in shop',
                    '{C:attention}+1{} voucher slot in shop',
                    '{C:attention}+1{} pack slot in shop',
                    '',
                    'Reroll cost does not reset each shop'
                }
            }
        }
    }
}
