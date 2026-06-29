--#region Atlases

SMODS.Atlas {
    key = 'placeholders',
    path = 'placeholders.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
  key = "bgn_joker_sprites",
  path = "bgn_joker_sprites.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "bgn_consumables",
  path = "bgn_consumables.png",
  px = 71,
  py = 95
}

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

local backs_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/backs")
for _, file in ipairs(backs_src) do
    assert(SMODS.load_file("src/backs/" .. file))()
end

local tarots_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/tarots")
for _, file in ipairs(tarots_src) do
    assert(SMODS.load_file("src/tarots/" .. file))()
end

local enhancements_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/enhancements")
for _, file in ipairs(enhancements_src) do
    assert(SMODS.load_file("src/enhancements/" .. file))()
end

local skins_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/skins")
for _, file in ipairs(skins_src) do
    assert(SMODS.load_file("src/skins/" .. file))()
end