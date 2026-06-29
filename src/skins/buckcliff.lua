SMODS.Atlas {
  key = "buckcliff_hearts_lc",
  path = "buckcliff_hearts_lc.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "buckcliff_spades_lc",
  path = "buckcliff_spades_lc.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "buckcliff_clubs_lc",
  path = "buckcliff_clubs_lc.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "buckcliff_diamonds_lc",
  path = "buckcliff_diamonds_lc.png",
  px = 71,
  py = 95
}

SMODS.DeckSkin {
    key = 'bgn_buckcliff_hearts',
    suit = 'Hearts',
    loc_txt = { ["en-us"] = "Buckcliff" },
    palettes = {
        {
            key = 'lc',
            ranks = {'King', 'Queen', 'Jack'},
            display_ranks = {'King', 'Queen', 'Jack'},
            atlas = 'bgn_buckcliff_hearts_lc',
            pos_style = 'collab',
        }
    },
    generate_ds_card_ui = function(card, deckskin, palette, info_queue, desc_nodes, specific_vars, full_UI_table)
        if card.base.value == 'Jack' or card.base.value == 'Queen' or card.base.value == 'King' then
            localize{type = 'other', key = 'artist', nodes = desc_nodes, vars = {}}
            localize{type = 'other', key = 'artist_credit', nodes = desc_nodes, vars = { "voxdafox" }}
        end
    end,
    has_ds_card_ui = function(card, deckskin, palette)
        return true
    end
}

SMODS.DeckSkin {
    key = 'bgn_buckcliff_clubs',
    suit = 'Clubs',
    loc_txt = { ["en-us"] = "Buckcliff" },
    palettes = {
        {
            key = 'lc',
            ranks = {'King', 'Queen', 'Jack'},
            display_ranks = {'King', 'Queen', 'Jack'},
            atlas = 'bgn_buckcliff_clubs_lc',
            pos_style = 'collab',
        }
    },
    generate_ds_card_ui = function(card, deckskin, palette, info_queue, desc_nodes, specific_vars, full_UI_table)
        if card.base.value == 'Jack' or card.base.value == 'Queen' or card.base.value == 'King' then
            localize{type = 'other', key = 'artist', nodes = desc_nodes, vars = {}}
            localize{type = 'other', key = 'artist_credit', nodes = desc_nodes, vars = { "voxdafox" }}
        end
    end,
    has_ds_card_ui = function(card, deckskin, palette)
        return true
    end
}

SMODS.DeckSkin {
    key = 'bgn_buckcliff_spades',
    suit = 'Spades',
    loc_txt = { ["en-us"] = "Buckcliff" },
    palettes = {
        {
            key = 'lc',
            ranks = {'King', 'Queen', 'Jack'},
            display_ranks = {'King', 'Queen', 'Jack'},
            atlas = 'bgn_buckcliff_spades_lc',
            pos_style = 'collab',
        }
    },
    generate_ds_card_ui = function(card, deckskin, palette, info_queue, desc_nodes, specific_vars, full_UI_table)
        if card.base.value == 'Jack' or card.base.value == 'Queen' or card.base.value == 'King' then
            localize{type = 'other', key = 'artist', nodes = desc_nodes, vars = {}}
            localize{type = 'other', key = 'artist_credit', nodes = desc_nodes, vars = { "voxdafox" }}
        end
    end,
    has_ds_card_ui = function(card, deckskin, palette)
        return true
    end
}

SMODS.DeckSkin {
    key = 'bgn_buckcliff_diamonds',
    suit = 'Diamonds',
    loc_txt = { ["en-us"] = "Buckcliff" },
    palettes = {
        {
            key = 'lc',
            ranks = {'King', 'Queen', 'Jack'},
            display_ranks = {'King', 'Queen', 'Jack'},
            atlas = 'bgn_buckcliff_diamonds_lc',
            pos_style = 'collab',
        }
    },
    generate_ds_card_ui = function(card, deckskin, palette, info_queue, desc_nodes, specific_vars, full_UI_table)
        if card.base.value == 'Jack' or card.base.value == 'Queen' or card.base.value == 'King' then
            localize{type = 'other', key = 'artist', nodes = desc_nodes, vars = {}}
            localize{type = 'other', key = 'artist_credit', nodes = desc_nodes, vars = { "voxdafox" }}
        end
    end,
    has_ds_card_ui = function(card, deckskin, palette)
        return true
    end
}

