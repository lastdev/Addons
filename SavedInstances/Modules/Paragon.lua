local SI, L = unpack((select(2, ...)))
local Module = SI:NewModule("Paragon", "AceEvent-3.0", "AceTimer-3.0")

-- Lua functions
local pairs, tinsert = pairs, tinsert

local factionID = {
  -- Legion
  1828, -- Highmountain Tribe
  1859, -- The Nightfallen
  1883, -- Dreamweavers
  1894, -- The Wardens
  1900, -- Court of Farondis
  1948, -- Valarjar
  2045, -- Armies of Legionfall
  2165, -- Army of the Light
  2170, -- Argussian Reach

  -- Battle for Azeroth
  2103, -- Zandalari Empire
  2156, -- Talanji's Expedition
  2157, -- The Honorbound
  2158, -- Voldunai
  2159, -- 7th Legion
  2160, -- Proudmoore Admiralty
  2161, -- Order of Embers
  2162, -- Storm's Wake
  2163, -- Tortollan Seekers
  2164, -- Champions of Azeroth
  2373, -- The Unshackled
  2391, -- Rustbolt Resistance
  2400, -- Waveblade Ankoan
  2415, -- Rajani
  2417, -- Uldum Accord

  -- Shadowlands
  2407, -- The Ascended
  2410, -- The Undying Army
  2413, -- Court of Harvesters
  2432, -- Ve'nari
  2465, -- The Wild Hunt
  2470, -- Death's Advance
  2472, -- The Archivists' Codex
  2478, -- The Enlightened

  -- Dragonflight
  2503, -- Maruuk Centaur
  2507, -- Dragonscale Expedition
  2510, -- Valdrakken Accord
  2511, -- Iskaara Tuskarr
  2564, -- Loamm Niffen
  2574, -- Dream Wardens

  -- The War Within
  2570, -- Hallowfall Arathi
  2590, -- Council of Dornogal
  2594, -- The Assembly of the Deeps
  2600, -- The Severed Threads
  2601, -- The Weaver
  2605, -- The General
  2607, -- The Vizier
  2653, -- The Cartels of Undermine
  2669, -- Darkfuse Solutions
  2671, -- Venture Company
  2673, -- Bilgewater Cartel
  2675, -- Blackwater Cartel
  2677, -- Steamwheedle Cartel
  2685, -- Gallagio Loyalty Rewards Club
}

function Module:OnEnable()
  self:RegisterEvent("UPDATE_FACTION")
  self:UPDATE_FACTION()
end

function Module:UPDATE_FACTION()
  local t = SI.db.Toons[SI.thisToon]
  t.Paragon = {}
  for _, faction in pairs(factionID) do
    local currentValue, _, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(faction)
    if currentValue and hasRewardPending then
      tinsert(t.Paragon, faction)
    end
  end
  SI:Debug("Paragon faction update: %d", #t.Paragon)
end

hooksecurefunc("GetQuestReward", function()
  Module:ScheduleTimer("UPDATE_FACTION", 1)
end)
