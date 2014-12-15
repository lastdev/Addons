-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local constants = private.addon.constants
local module = private.addon:GetModule(private.module_name)

-------------------------------------------------------------------------------
-- Filter flags. Acquire types, and Reputation levels.
-------------------------------------------------------------------------------
local A = constants.ACQUIRE_TYPE_IDS
local F = constants.FILTER_IDS
local Q = constants.ITEM_QUALITIES
local V = constants.GAME_VERSIONS
local Z = constants.ZONE_NAMES

local FAC = constants.FACTION_IDS
local REP = constants.REP_LEVELS

--------------------------------------------------------------------------------------------------------------------
-- Initialize!
--------------------------------------------------------------------------------------------------------------------
function module:InitializeRecipes()
	local function AddRecipe(spell_id, genesis, quality)
		return private.addon:AddRecipe(spell_id, constants.PROFESSION_SPELL_IDS.INSCRIPTION, genesis, quality)
	end
	local recipe

	-------------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-------------------------------------------------------------------------------
	-- Scroll of Stamina -- 45382
	recipe = AddRecipe(45382, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 40, 45)
	recipe:SetCraftedItem(1180, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Scroll of Intellect -- 48114
	recipe = AddRecipe(48114, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 40, 45)
	recipe:SetCraftedItem(955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Scroll of Spirit -- 48116
	recipe = AddRecipe(48116, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 35, 40, 45)
	recipe:SetCraftedItem(1181, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1, F.HEALER, F.CASTER)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Mysterious Tarot -- 48247
	recipe = AddRecipe(48247, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(37168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Recall -- 48248
	recipe = AddRecipe(48248, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 60, 67, 75)
	recipe:SetCraftedItem(37118, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Intellect II -- 50598
	recipe = AddRecipe(50598, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 80, 85)
	recipe:SetCraftedItem(2290, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Intellect III -- 50599
	recipe = AddRecipe(50599, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 170, 175, 180)
	recipe:SetCraftedItem(4419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Intellect IV -- 50600
	recipe = AddRecipe(50600, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 220, 225, 230)
	recipe:SetCraftedItem(10308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Intellect V -- 50601
	recipe = AddRecipe(50601, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 265, 270, 275)
	recipe:SetCraftedItem(27499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Intellect VI -- 50602
	recipe = AddRecipe(50602, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 310, 315, 320)
	recipe:SetCraftedItem(33458, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Intellect VII -- 50603
	recipe = AddRecipe(50603, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 365, 370, 375)
	recipe:SetCraftedItem(37091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Intellect VIII -- 50604
	recipe = AddRecipe(50604, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(37092, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit II -- 50605
	recipe = AddRecipe(50605, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 80, 85)
	recipe:SetCraftedItem(1712, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Spirit III -- 50606
	recipe = AddRecipe(50606, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 165, 170, 175)
	recipe:SetCraftedItem(4424, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit IV -- 50607
	recipe = AddRecipe(50607, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 215, 220, 225)
	recipe:SetCraftedItem(10306, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit V -- 50608
	recipe = AddRecipe(50608, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 260, 265, 270)
	recipe:SetCraftedItem(27501, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit VI -- 50609
	recipe = AddRecipe(50609, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 305, 310, 315)
	recipe:SetCraftedItem(33460, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit VII -- 50610
	recipe = AddRecipe(50610, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 360, 365, 370)
	recipe:SetCraftedItem(37097, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit VIII -- 50611
	recipe = AddRecipe(50611, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(37098, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina II -- 50612
	recipe = AddRecipe(50612, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 80, 85)
	recipe:SetCraftedItem(1711, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Stamina III -- 50614
	recipe = AddRecipe(50614, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 160, 165, 170)
	recipe:SetCraftedItem(4422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina IV -- 50616
	recipe = AddRecipe(50616, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 210, 215, 220)
	recipe:SetCraftedItem(10307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina V -- 50617
	recipe = AddRecipe(50617, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 260, 265)
	recipe:SetCraftedItem(27502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina VI -- 50618
	recipe = AddRecipe(50618, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 300, 305, 310)
	recipe:SetCraftedItem(33461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina VII -- 50619
	recipe = AddRecipe(50619, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 355, 360, 365)
	recipe:SetCraftedItem(37093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina VIII -- 50620
	recipe = AddRecipe(50620, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(37094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Enchanting Vellum -- 52739
	recipe = AddRecipe(52739, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 87, 100)
	recipe:SetCraftedItem(38682, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Moonglow Ink -- 52843
	recipe = AddRecipe(52843, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:SetCraftedItem(39469, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Midnight Ink -- 53462
	recipe = AddRecipe(53462, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 77, 80)
	recipe:SetCraftedItem(39774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Glyph of Hurricane -- 56946
	recipe = AddRecipe(56946, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(40920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of the Orca -- 56948
	recipe = AddRecipe(56948, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(40919, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of the Stag -- 56950
	recipe = AddRecipe(56950, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(40900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Rake -- 56952
	recipe = AddRecipe(56952, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 315, 320, 325)
	recipe:SetCraftedItem(40903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Regrowth -- 56954
	recipe = AddRecipe(56954, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(40912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Skull Bash -- 56958
	recipe = AddRecipe(56958, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(40921, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Guided Stars -- 56959
	recipe = AddRecipe(56959, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(220, 220, 225, 230, 235)
	recipe:SetCraftedItem(40916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Stars -- 56965
	recipe = AddRecipe(56965, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 325, 330)
	recipe:SetCraftedItem(44922, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Arcane Explosion -- 56972
	recipe = AddRecipe(56972, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 340, 345, 350)
	recipe:SetCraftedItem(42736, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Combustion -- 56975
	recipe = AddRecipe(56975, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42739, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Momentum -- 56978
	recipe = AddRecipe(56978, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 110, 120)
	recipe:SetCraftedItem(42743, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Ice Block -- 56979
	recipe = AddRecipe(56979, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 230, 235, 240)
	recipe:SetCraftedItem(42744, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Splitting Ice -- 56980
	recipe = AddRecipe(56980, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(42745, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Cone of Cold -- 56981
	recipe = AddRecipe(56981, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 180, 185, 190)
	recipe:SetCraftedItem(42746, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Rapid Displacement -- 56983
	recipe = AddRecipe(56983, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42748, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Crittermorph -- 56986
	recipe = AddRecipe(56986, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42751, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Icy Veins -- 56988
	recipe = AddRecipe(56988, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42753, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Spellsteal -- 56989
	recipe = AddRecipe(56989, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42754, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Remove Curse -- 56990
	recipe = AddRecipe(56990, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 355, 360, 365)
	recipe:SetCraftedItem(44920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Arcane Power -- 56991
	recipe = AddRecipe(56991, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 320, 325, 330)
	recipe:SetCraftedItem(44955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Aspects -- 56994
	recipe = AddRecipe(56994, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 180, 185, 190)
	recipe:SetCraftedItem(42897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Camouflage -- 56995
	recipe = AddRecipe(56995, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 105, 110, 115)
	recipe:SetCraftedItem(42898, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Distracting Shot -- 56998
	recipe = AddRecipe(56998, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Endless Wrath -- 56999
	recipe = AddRecipe(56999, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Deterrence -- 57000
	recipe = AddRecipe(57000, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 205, 210, 215)
	recipe:SetCraftedItem(42903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Disengage -- 57001
	recipe = AddRecipe(57001, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 230, 235, 240)
	recipe:SetCraftedItem(42904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Freezing Trap -- 57002
	recipe = AddRecipe(57002, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 265, 270, 275)
	recipe:SetCraftedItem(42905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Ice Trap -- 57003
	recipe = AddRecipe(57003, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 355, 360, 365)
	recipe:SetCraftedItem(42906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Explosive Trap -- 57005
	recipe = AddRecipe(57005, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 135, 140, 145)
	recipe:SetCraftedItem(42908, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of No Escape -- 57007
	recipe = AddRecipe(57007, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(42910, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Tame Beast -- 57009
	recipe = AddRecipe(57009, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 110, 120)
	recipe:SetCraftedItem(42912, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Mend Pet -- 57012
	recipe = AddRecipe(57012, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Solace -- 57014
	recipe = AddRecipe(57014, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Focused Shield -- 57019
	recipe = AddRecipe(57019, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Divine Protection -- 57022
	recipe = AddRecipe(57022, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 100, 110)
	recipe:SetCraftedItem(41096, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Consecration -- 57023
	recipe = AddRecipe(57023, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 210, 215, 220)
	recipe:SetCraftedItem(41099, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Holy Wrath -- 57027
	recipe = AddRecipe(57027, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 100, 110, 120)
	recipe:SetCraftedItem(41095, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Divinity -- 57031
	recipe = AddRecipe(57031, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetCraftedItem(41108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of the Luminous Charger -- 57032
	recipe = AddRecipe(57032, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 160, 165, 170)
	recipe:SetCraftedItem(41100, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Devotion Aura -- 57033
	recipe = AddRecipe(57033, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 340, 345, 350)
	recipe:SetCraftedItem(41094, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Blessed Life -- 57034
	recipe = AddRecipe(57034, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41110, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Burden of Guilt -- 57036
	recipe = AddRecipe(57036, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(41102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Decoy -- 57114
	recipe = AddRecipe(57114, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 100, 110)
	recipe:SetCraftedItem(42956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Blade Flurry -- 57115
	recipe = AddRecipe(57115, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	

	-- Glyph of Evasion -- 57119
	recipe = AddRecipe(57119, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 115, 125)
	recipe:SetCraftedItem(42960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Recovery -- 57120
	recipe = AddRecipe(57120, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 110, 115, 120)
	recipe:SetCraftedItem(42961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Feint -- 57122
	recipe = AddRecipe(57122, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(305, 305, 310, 315, 320)
	recipe:SetCraftedItem(42963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Garrote -- 57123
	recipe = AddRecipe(57123, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 140, 145, 150)
	recipe:SetCraftedItem(42964, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Detection -- 57124
	recipe = AddRecipe(57124, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Gouge -- 57125
	recipe = AddRecipe(57125, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 165, 170, 175)
	recipe:SetCraftedItem(42966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Hemorrhage -- 57126
	recipe = AddRecipe(57126, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Smoke Bomb -- 57127
	recipe = AddRecipe(57127, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42968, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Hemorraghing Veins -- 57129
	recipe = AddRecipe(57129, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 190, 195, 200)
	recipe:SetCraftedItem(42970, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Kick -- 57130
	recipe = AddRecipe(57130, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Shiv -- 57132
	recipe = AddRecipe(57132, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 240, 245, 250)
	recipe:SetCraftedItem(42973, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	

	-- Glyph of Sprint -- 57133
	recipe = AddRecipe(57133, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(285, 285, 290, 295, 300)
	recipe:SetCraftedItem(42974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Shield Slam -- 57152
	recipe = AddRecipe(57152, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Bloody Healing -- 57153
	recipe = AddRecipe(57153, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Hindering Strikes -- 57154
	recipe = AddRecipe(57154, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 245, 250, 255)
	recipe:SetCraftedItem(43414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Rude Interruption -- 57157
	recipe = AddRecipe(57157, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 130, 135, 140)
	recipe:SetCraftedItem(43417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Blitz -- 57159
	recipe = AddRecipe(57159, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Mortal Strike -- 57160
	recipe = AddRecipe(57160, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Die by the Sword -- 57161
	recipe = AddRecipe(57161, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 180, 185)
	recipe:SetCraftedItem(43422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Resonating Power -- 57164
	recipe = AddRecipe(57164, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43430, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	

	-- Glyph of Sweeping Strikes -- 57168
	recipe = AddRecipe(57168, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 325, 330, 335)
	recipe:SetCraftedItem(43428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Raging Wind -- 57172
	recipe = AddRecipe(57172, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 350, 355, 360)
	recipe:SetCraftedItem(43432, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Circle of Healing -- 57181
	recipe = AddRecipe(57181, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42396, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Purify -- 57183
	recipe = AddRecipe(57183, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 235, 240, 245)
	recipe:SetCraftedItem(42397, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Fear Ward -- 57185
	recipe = AddRecipe(57185, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 275, 280, 285)
	recipe:SetCraftedItem(42399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Lightwell -- 57189
	recipe = AddRecipe(57189, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Mass Dispel -- 57190
	recipe = AddRecipe(57190, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Psychic Horror -- 57191
	recipe = AddRecipe(57191, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Weakened Soul -- 57193
	recipe = AddRecipe(57193, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Power Word: Shield -- 57194
	recipe = AddRecipe(57194, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 100, 110)
	recipe:SetCraftedItem(42408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Spirit of Redemption -- 57195
	recipe = AddRecipe(57195, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
	

	-- Glyph of Psychic Scream -- 57196
	recipe = AddRecipe(57196, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 115, 125)
	recipe:SetCraftedItem(42410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Scourge Imprisonment -- 57198
	recipe = AddRecipe(57198, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(42412, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Dispel Magic -- 57200
	recipe = AddRecipe(57200, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 185, 190, 195)
	recipe:SetCraftedItem(42415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Prayer of Mending -- 57202
	recipe = AddRecipe(57202, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Anti-Magic Shell -- 57207
	recipe = AddRecipe(57207, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	

	-- Glyph of the Geist -- 57209
	recipe = AddRecipe(57209, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 335, 340)
	recipe:SetCraftedItem(43535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Icebound Fortitude -- 57210
	recipe = AddRecipe(57210, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 270, 275, 280)
	recipe:SetCraftedItem(43536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Chains of Ice -- 57211
	recipe = AddRecipe(57211, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Death's Embrace -- 57215
	recipe = AddRecipe(57215, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(43539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Horn of Winter -- 57217
	recipe = AddRecipe(57217, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 335, 340)
	recipe:SetCraftedItem(43544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Icy Touch -- 57219
	recipe = AddRecipe(57219, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 285, 290, 295)
	recipe:SetCraftedItem(43546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Enduring Infection -- 57220
	recipe = AddRecipe(57220, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Blood Boil -- 57221
	recipe = AddRecipe(57221, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(43548, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Mind Freeze -- 57222
	recipe = AddRecipe(57222, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 355, 360, 365)
	recipe:SetCraftedItem(43549, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Army of the Dead -- 57223
	recipe = AddRecipe(57223, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Foul Menagerie -- 57224
	recipe = AddRecipe(57224, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 335, 340, 345)
	recipe:SetCraftedItem(43551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Strangulate -- 57225
	recipe = AddRecipe(57225, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(43552, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Pillar of Frost -- 57226
	recipe = AddRecipe(57226, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(305, 305, 310, 315, 320)
	recipe:SetCraftedItem(43553, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Vampiric Blood -- 57227
	recipe = AddRecipe(57227, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 350, 355, 360)
	recipe:SetCraftedItem(43554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Death Gate -- 57228
	recipe = AddRecipe(57228, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(43673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Path of Frost -- 57229
	recipe = AddRecipe(57229, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(43671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Resilient Grip -- 57230
	recipe = AddRecipe(57230, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(43672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Unstable Earth -- 57232
	recipe = AddRecipe(57232, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Chain Lightning -- 57233
	recipe = AddRecipe(57233, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Spirit Walk -- 57234
	recipe = AddRecipe(57234, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 395, 400)
	recipe:SetCraftedItem(41524, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	

	-- Glyph of Capacitor Totem -- 57235
	recipe = AddRecipe(57235, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Purge -- 57236
	recipe = AddRecipe(57236, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 305, 310, 315)
	recipe:SetCraftedItem(41527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Fire Elemental Totem -- 57237
	recipe = AddRecipe(57237, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Fire Nova -- 57238
	recipe = AddRecipe(57238, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 115, 120, 125)
	recipe:SetCraftedItem(41530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Wind Shear -- 57240
	recipe = AddRecipe(57240, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 130, 135, 140)
	recipe:SetCraftedItem(41532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Healing Stream Totem -- 57242
	recipe = AddRecipe(57242, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 220, 225, 230)
	recipe:SetCraftedItem(41533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of the Lakestrider -- 57246
	recipe = AddRecipe(57246, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 115, 125)
	recipe:SetCraftedItem(41537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Grounding Totem -- 57247
	recipe = AddRecipe(57247, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Lava Lash -- 57249
	recipe = AddRecipe(57249, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 170, 175, 180)
	recipe:SetCraftedItem(41540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Chaining -- 57250
	recipe = AddRecipe(57250, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(41552, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Water Shield -- 57251
	recipe = AddRecipe(57251, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 280, 285, 290)
	recipe:SetCraftedItem(41541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Cleansing Waters -- 57252
	recipe = AddRecipe(57252, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 335, 340, 345)
	recipe:SetCraftedItem(41542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Thunderstorm -- 57253
	recipe = AddRecipe(57253, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 355, 360, 365)
	recipe:SetCraftedItem(44923, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Hand of Gul'dan -- 57257
	recipe = AddRecipe(57257, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 355, 360, 365)
	recipe:SetCraftedItem(42453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Conflagrate -- 57258
	recipe = AddRecipe(57258, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42454, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Verdant Spheres -- 57260
	recipe = AddRecipe(57260, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Nightmares -- 57261
	recipe = AddRecipe(57261, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 285, 290, 295)
	recipe:SetCraftedItem(42457, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Felguard -- 57263
	recipe = AddRecipe(57263, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42459, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	

	-- Glyph of Health Funnel -- 57265
	recipe = AddRecipe(57265, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 115, 120, 125)
	recipe:SetCraftedItem(42461, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Subtlety -- 57267
	recipe = AddRecipe(57267, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42463, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Imp Swarm -- 57269
	recipe = AddRecipe(57269, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(140, 140, 145, 150, 155)
	recipe:SetCraftedItem(42465, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Havoc -- 57270
	recipe = AddRecipe(57270, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 220, 225, 230)
	recipe:SetCraftedItem(42466, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Shadow Bolt -- 57271
	recipe = AddRecipe(57271, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 170, 175, 180)
	recipe:SetCraftedItem(42467, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Soulstone -- 57274
	recipe = AddRecipe(57274, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(240, 240, 245, 250, 255)
	recipe:SetCraftedItem(42470, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Unstable Affliction -- 57276
	recipe = AddRecipe(57276, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(42472, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Falling Meteor -- 57277
	recipe = AddRecipe(57277, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 195, 200, 205)
	recipe:SetCraftedItem(42473, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Hunter's Ink -- 57703
	recipe = AddRecipe(57703, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 85, 90, 95)
	recipe:SetCraftedItem(43115, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Lion's Ink -- 57704
	recipe = AddRecipe(57704, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 100, 105)
	recipe:SetCraftedItem(43116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Dawnstar Ink -- 57706
	recipe = AddRecipe(57706, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 130, 135)
	recipe:SetCraftedItem(43117, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Jadefire Ink -- 57707
	recipe = AddRecipe(57707, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 150, 155)
	recipe:SetCraftedItem(43118, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Royal Ink -- 57708
	recipe = AddRecipe(57708, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 175, 180)
	recipe:SetCraftedItem(43119, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Celestial Ink -- 57709
	recipe = AddRecipe(57709, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 200, 205)
	recipe:SetCraftedItem(43120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Fiery Ink -- 57710
	recipe = AddRecipe(57710, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 225, 225, 230)
	recipe:SetCraftedItem(43121, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Shimmering Ink -- 57711
	recipe = AddRecipe(57711, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 250, 255)
	recipe:SetCraftedItem(43122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Ink of the Sky -- 57712
	recipe = AddRecipe(57712, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 295, 300)
	recipe:SetCraftedItem(43123, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Ethereal Ink -- 57713
	recipe = AddRecipe(57713, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 295, 300, 305)
	recipe:SetCraftedItem(43124, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Darkflame Ink -- 57714
	recipe = AddRecipe(57714, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 325, 325, 330)
	recipe:SetCraftedItem(43125, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Ink of the Sea -- 57715
	recipe = AddRecipe(57715, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 350, 355)
	recipe:SetCraftedItem(43126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Snowfall Ink -- 57716
	recipe = AddRecipe(57716, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 375, 375, 380)
	recipe:SetCraftedItem(43127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Aquatic Form -- 58286
	recipe = AddRecipe(58286, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 105, 110, 115)
	recipe:SetCraftedItem(43316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of the Chameleon -- 58287
	recipe = AddRecipe(58287, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43334, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Blooming -- 58288
	recipe = AddRecipe(58288, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43331, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Grace -- 58289
	recipe = AddRecipe(58289, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43332, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Charm Woodland Creature -- 58296
	recipe = AddRecipe(58296, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43335, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Aspect of the Pack -- 58297
	recipe = AddRecipe(58297, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(195, 195, 205, 210, 215)
	recipe:SetCraftedItem(43355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Stampede -- 58298
	recipe = AddRecipe(58298, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Revive Pet -- 58299
	recipe = AddRecipe(58299, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43338, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Lesser Proportion -- 58301
	recipe = AddRecipe(58301, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Fireworks -- 58302
	recipe = AddRecipe(58302, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43351, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Conjure Familiar -- 58306
	recipe = AddRecipe(58306, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43359, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Arcane Language -- 58308
	recipe = AddRecipe(58308, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Contemplation -- 58311
	recipe = AddRecipe(58311, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43365, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Winged Vengeance -- 58312
	recipe = AddRecipe(58312, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43366, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of the Mounted King -- 58314
	recipe = AddRecipe(58314, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43340, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Seal of Blood -- 58315
	recipe = AddRecipe(58315, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43368, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Fire From the Heavens -- 58316
	recipe = AddRecipe(58316, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43369, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Shadow Ravens -- 58317
	recipe = AddRecipe(58317, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Borrowed Time -- 58318
	recipe = AddRecipe(58318, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43371, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Shackle Undead -- 58320
	recipe = AddRecipe(58320, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43373, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Dark Archangel -- 58322
	recipe = AddRecipe(58322, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 355, 360, 365)
	recipe:SetCraftedItem(43374, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Blurred Speed -- 58323
	recipe = AddRecipe(58323, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43379, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Distract -- 58324
	recipe = AddRecipe(58324, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(43376, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Pick Lock -- 58325
	recipe = AddRecipe(58325, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43377, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Pick Pocket -- 58326
	recipe = AddRecipe(58326, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Safe Fall -- 58327
	recipe = AddRecipe(58327, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(195, 195, 205, 210, 215)
	recipe:SetCraftedItem(43378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Poisons -- 58328
	recipe = AddRecipe(58328, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(43380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Astral Recall -- 58329
	recipe = AddRecipe(58329, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43381, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Far Sight -- 58330
	recipe = AddRecipe(58330, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of the Spectral Wolf -- 58332
	recipe = AddRecipe(58332, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Totemic Encirclement -- 58333
	recipe = AddRecipe(58333, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43388, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Unending Breath -- 58336
	recipe = AddRecipe(58336, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43389, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Soul Consumption -- 58337
	recipe = AddRecipe(58337, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43390, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Enslave Demon -- 58339
	recipe = AddRecipe(58339, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(43393, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Eye of Kilrogg -- 58340
	recipe = AddRecipe(58340, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 130, 135, 140)
	recipe:SetCraftedItem(43391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Soulwell -- 58341
	recipe = AddRecipe(58341, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(345, 345, 355, 360, 365)
	recipe:SetCraftedItem(43394, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Mystic Shout -- 58342
	recipe = AddRecipe(58342, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43395, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Bloodcurdling Shout -- 58343
	recipe = AddRecipe(58343, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 80, 85, 90)
	recipe:SetCraftedItem(43396, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Gushing Wound -- 58345
	recipe = AddRecipe(58345, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 105, 110, 115)
	recipe:SetCraftedItem(43398, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Unending Rage -- 58346
	recipe = AddRecipe(58346, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 90, 95, 100)
	recipe:SetCraftedItem(43399, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Mighty Victory -- 58347
	recipe = AddRecipe(58347, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 335, 340)
	recipe:SetCraftedItem(43400, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Scroll of Agility -- 58472
	recipe = AddRecipe(58472, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 35, 40, 45)
	recipe:SetCraftedItem(3012, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Agility II -- 58473
	recipe = AddRecipe(58473, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 85, 90, 95)
	recipe:SetCraftedItem(1477, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility III -- 58476
	recipe = AddRecipe(58476, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 180, 185, 190)
	recipe:SetCraftedItem(4425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility IV -- 58478
	recipe = AddRecipe(58478, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 230, 235, 240)
	recipe:SetCraftedItem(10309, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility V -- 58480
	recipe = AddRecipe(58480, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 275, 280, 285)
	recipe:SetCraftedItem(27498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility VI -- 58481
	recipe = AddRecipe(58481, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 325, 330)
	recipe:SetCraftedItem(33457, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility VII -- 58482
	recipe = AddRecipe(58482, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetCraftedItem(43463, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility VIII -- 58483
	recipe = AddRecipe(58483, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(43464, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength -- 58484
	recipe = AddRecipe(58484, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 35, 40, 45)
	recipe:SetCraftedItem(954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 53415, 56065, 57620, 62327, 64691, 65043, 66355, 85911, 86015)

	-- Scroll of Strength II -- 58485
	recipe = AddRecipe(58485, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(80, 80, 80, 85, 90)
	recipe:SetCraftedItem(2289, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength III -- 58486
	recipe = AddRecipe(58486, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 175, 180, 185)
	recipe:SetCraftedItem(4426, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength IV -- 58487
	recipe = AddRecipe(58487, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(220, 220, 225, 230, 235)
	recipe:SetCraftedItem(10310, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength V -- 58488
	recipe = AddRecipe(58488, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 270, 275, 280)
	recipe:SetCraftedItem(27503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength VI -- 58489
	recipe = AddRecipe(58489, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(305, 305, 315, 320, 325)
	recipe:SetCraftedItem(33462, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength VII -- 58490
	recipe = AddRecipe(58490, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 370, 375, 380)
	recipe:SetCraftedItem(43465, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength VIII -- 58491
	recipe = AddRecipe(58491, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(43466, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Mystic Tome -- 58565
	recipe = AddRecipe(58565, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(85, 85, 95, 100, 105)
	recipe:SetCraftedItem(43515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Ghost Wolf -- 59326
	recipe = AddRecipe(59326, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 110, 115, 120)
	recipe:SetCraftedItem(43725, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Outbreak -- 59339
	recipe = AddRecipe(59339, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 325, 330, 335)
	recipe:SetCraftedItem(43826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Corpse Explosion -- 59340
	recipe = AddRecipe(59340, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 345, 350, 355)
	recipe:SetCraftedItem(43827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Certificate of Ownership -- 59387
	recipe = AddRecipe(59387, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 205, 210, 215)
	recipe:SetCraftedItem(43850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Tome of the Dawn -- 59475
	recipe = AddRecipe(59475, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 162, 175)
	recipe:SetCraftedItem(43654, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Book of Survival -- 59478
	recipe = AddRecipe(59478, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 162, 175)
	recipe:SetCraftedItem(43655, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Strange Tarot -- 59480
	recipe = AddRecipe(59480, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 150, 162, 175)
	recipe:SetCraftedItem(44142, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Tome of Kings -- 59484
	recipe = AddRecipe(59484, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 200, 205, 210)
	recipe:SetCraftedItem(43656, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Royal Guide of Escape Routes -- 59486
	recipe = AddRecipe(59486, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 200, 205, 210)
	recipe:SetCraftedItem(43657, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Arcane Tarot -- 59487
	recipe = AddRecipe(59487, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 200, 205, 210)
	recipe:SetCraftedItem(44161, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Fire Eater's Guide -- 59489
	recipe = AddRecipe(59489, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 245, 250)
	recipe:SetCraftedItem(43660, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Book of Stars -- 59490
	recipe = AddRecipe(59490, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 245, 250)
	recipe:SetCraftedItem(43661, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Shadowy Tarot -- 59491
	recipe = AddRecipe(59491, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 240, 245, 250)
	recipe:SetCraftedItem(44163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Stormbound Tome -- 59493
	recipe = AddRecipe(59493, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 295, 300)
	recipe:SetCraftedItem(43663, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Manual of Clouds -- 59494
	recipe = AddRecipe(59494, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 295, 300)
	recipe:SetCraftedItem(43664, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Hellfire Tome -- 59495
	recipe = AddRecipe(59495, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 340, 345, 350)
	recipe:SetCraftedItem(43666, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Book of Clever Tricks -- 59496
	recipe = AddRecipe(59496, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 340, 345, 350)
	recipe:SetCraftedItem(43667, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Iron-bound Tome -- 59497
	recipe = AddRecipe(59497, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 425, 437, 450)
	recipe:SetCraftedItem(38322, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Faces of Doom -- 59498
	recipe = AddRecipe(59498, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 425, 437, 450)
	recipe:SetCraftedItem(44210, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Darkmoon Card -- 59502
	recipe = AddRecipe(59502, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 290, 295, 300)
	recipe:SetCraftedItem(44316, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Greater Darkmoon Card -- 59503
	recipe = AddRecipe(59503, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 340, 345, 350)
	recipe:SetCraftedItem(44317, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Darkmoon Card of the North -- 59504
	recipe = AddRecipe(59504, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 425, 450, 475)
	recipe:SetCraftedItem(44318, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Immediate Truth -- 59561
	recipe = AddRecipe(59561, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 397, 405)
	recipe:SetCraftedItem(43869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Scroll of Recall II -- 60336
	recipe = AddRecipe(60336, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 215, 220, 225)
	recipe:SetCraftedItem(44314, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Recall III -- 60337
	recipe = AddRecipe(60337, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 350, 355)
	recipe:SetCraftedItem(44315, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Master's Inscription of the Axe -- 61117
	recipe = AddRecipe(61117, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 405)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Master's Inscription of the Crag -- 61118
	recipe = AddRecipe(61118, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 405)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Master's Inscription of the Pinnacle -- 61119
	recipe = AddRecipe(61119, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 405)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Master's Inscription of the Storm -- 61120
	recipe = AddRecipe(61120, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 405)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Rituals of the Moon -- 64051
	recipe = AddRecipe(64051, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(350, 350, 375, 387, 400)
	recipe:SetRecipeItem(46108, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(46108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(26679, 26708, 27546, 27676)

	-- Twilight Tome -- 64053
	recipe = AddRecipe(64053, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 375, 387, 400)
	recipe:SetCraftedItem(45849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Mirrored Blades -- 64246
	recipe = AddRecipe(64246, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45735, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Totemic Vigor -- 64247
	recipe = AddRecipe(64247, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45778, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Life Tap -- 64248
	recipe = AddRecipe(64248, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45785, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Crimson Banish -- 64250
	recipe = AddRecipe(64250, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45789, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Master's Call -- 64253
	recipe = AddRecipe(64253, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45733, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Victorious Throw -- 64255
	recipe = AddRecipe(64255, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45793, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Barkskin -- 64256
	recipe = AddRecipe(64256, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45623, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Deep Freeze -- 64257
	recipe = AddRecipe(64257, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45740, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Cyclone -- 64258
	recipe = AddRecipe(64258, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 262, 270)
	recipe:SetCraftedItem(45622, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Binding Heal -- 64259
	recipe = AddRecipe(64259, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 255, 262, 270)
	recipe:SetCraftedItem(45760, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Disguise -- 64260
	recipe = AddRecipe(64260, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 255, 262, 270)
	recipe:SetCraftedItem(45768, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Deluge -- 64261
	recipe = AddRecipe(64261, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 262, 270)
	recipe:SetCraftedItem(45775, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Shamanistic Rage -- 64262
	recipe = AddRecipe(64262, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 255, 262, 270)
	recipe:SetCraftedItem(45776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Death Coil -- 64266
	recipe = AddRecipe(64266, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 280, 287, 295)
	recipe:SetCraftedItem(45804, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Survival Instincts -- 64268
	recipe = AddRecipe(64268, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45601, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Wild Growth -- 64270
	recipe = AddRecipe(64270, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45602, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Tranquilizing Shot -- 64273
	recipe = AddRecipe(64273, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45731, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Illusion -- 64276
	recipe = AddRecipe(64276, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45738, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Beacon of Light -- 64277
	recipe = AddRecipe(64277, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45741, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Leap of Faith -- 64281
	recipe = AddRecipe(64281, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45755, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Mind Spike -- 64283
	recipe = AddRecipe(64283, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45758, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Vendetta -- 64284
	recipe = AddRecipe(64284, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45761, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Killing Spree -- 64285
	recipe = AddRecipe(64285, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45762, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Feral Spirit -- 64288
	recipe = AddRecipe(64288, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45771, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Riptide -- 64289
	recipe = AddRecipe(64289, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45772, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Wind and Thunder -- 64295
	recipe = AddRecipe(64295, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Death From Above -- 64296
	recipe = AddRecipe(64296, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Dancing Rune Weapon -- 64297
	recipe = AddRecipe(64297, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45799, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Dark Simulacrum -- 64298
	recipe = AddRecipe(64298, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	

	-- Glyph of Tranquil Grip -- 64300
	recipe = AddRecipe(64300, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Spell Reflection -- 64302
	recipe = AddRecipe(64302, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45795, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Cloak of Shadows -- 64303
	recipe = AddRecipe(64303, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45769, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Aspect of the Cheetah -- 64304
	recipe = AddRecipe(64304, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45732, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Stampeding Roar -- 64307
	recipe = AddRecipe(64307, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45604, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Focused Mending -- 64309
	recipe = AddRecipe(64309, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45757, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Unending Resolve -- 64311
	recipe = AddRecipe(64311, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45783, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Intimidating Shout -- 64312
	recipe = AddRecipe(64312, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Demonic Circle -- 64317
	recipe = AddRecipe(64317, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 430, 435, 440)
	recipe:SetCraftedItem(45782, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Thunder Strike -- 68166
	recipe = AddRecipe(68166, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 355, 360, 365)
	recipe:SetCraftedItem(49084, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Runescroll of Fortitude -- 69385
	recipe = AddRecipe(69385, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 440, 442, 460)
	recipe:SetCraftedItem(49632, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Counterspell -- 71101
	recipe = AddRecipe(71101, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 260, 265)
	recipe:SetCraftedItem(50045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Eternal Resolve -- 71102
	recipe = AddRecipe(71102, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 382, 385)
	recipe:SetCraftedItem(50077, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Inferno Blast -- 94000
	recipe = AddRecipe(94000, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 390, 397, 405)
	recipe:SetCraftedItem(63539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CASTER, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-------------------------------------------------------------------------------
	-- Cataclysm.
	-------------------------------------------------------------------------------
	-- Runescroll of Fortitude II -- 85785
	recipe = AddRecipe(85785, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 505, 510, 515)
	recipe:SetCraftedItem(62251, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Blackfallow Ink -- 86004
	recipe = AddRecipe(86004, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 440, 445, 450)
	recipe:SetCraftedItem(61978, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inferno Ink -- 86005
	recipe = AddRecipe(86005, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(475, 475, 480, 482, 485)
	recipe:SetCraftedItem(61981, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Swiftsteel Inscription -- 86375
	recipe = AddRecipe(86375, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 500, 500, 505)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Lionsmane Inscription -- 86401
	recipe = AddRecipe(86401, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 500, 500, 505)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscription of the Earth Prince -- 86402
	recipe = AddRecipe(86402, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 500, 500, 505)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Felfire Inscription -- 86403
	recipe = AddRecipe(86403, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 500, 500, 505)
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Mysterious Fortune Card -- 86609
	recipe = AddRecipe(86609, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetCraftedItem(60838, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Darkmoon Card of Destruction -- 86615
	recipe = AddRecipe(86615, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 530, 535)
	recipe:SetCraftedItem(61987, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Book of Blood -- 86616
	recipe = AddRecipe(86616, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(475, 475, 485, 487, 490)
	recipe:SetCraftedItem(62231, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Lord Rottington's Pressed Wisp Book -- 86640
	recipe = AddRecipe(86640, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(475, 475, 485, 487, 490)
	recipe:SetCraftedItem(62233, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Dungeoneering Guide -- 86641
	recipe = AddRecipe(86641, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 525, 530)
	recipe:SetCraftedItem(62234, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Divine Companion -- 86642
	recipe = AddRecipe(86642, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 525, 530)
	recipe:SetCraftedItem(62235, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Battle Tome -- 86643
	recipe = AddRecipe(86643, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 525, 530)
	recipe:SetCraftedItem(62236, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Origami Slime -- 86644
	recipe = AddRecipe(86644, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 480, 480, 490)
	recipe:SetRecipeItem(65649, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(62239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.VASHJIR)

	-- Origami Rock -- 86645
	recipe = AddRecipe(86645, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 490, 490, 500)
	recipe:SetRecipeItem(65650, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(62238, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.DEEPHOLM)

	-- Origami Beetle -- 86646
	recipe = AddRecipe(86646, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 500, 500, 510)
	recipe:SetRecipeItem(65651, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(63246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.ULDUM)

	-- Key to the Planes -- 86648
	recipe = AddRecipe(86648, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 500, 502, 505)
	recipe:SetCraftedItem(87565, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Runed Staff -- 86649
	recipe = AddRecipe(86649, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(505, 505, 515, 520, 525)
	recipe:SetCraftedItem(87566, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Rosethorn Staff -- 86652
	recipe = AddRecipe(86652, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 530, 535)
	recipe:SetCraftedItem(87562, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Silver Inlaid Staff -- 86653
	recipe = AddRecipe(86653, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 530, 535)
	recipe:SetCraftedItem(87561, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Forged Documents -- 86654
	recipe = AddRecipe(86654, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 522, 535)
	recipe:SetCraftedItem(63276, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.HORDE)
	recipe:AddTrainer(30709, 30715, 30717, 33603, 53415, 66355, 85911, 86015)

	-- Forged Documents -- 89244
	recipe = AddRecipe(89244, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 522, 535)
	recipe:SetCraftedItem(62056, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE)
	recipe:AddTrainer(30709, 30713, 30715, 30717, 33603, 53415, 66355, 85911, 86015)

	-- Scroll of Intellect IX -- 89368
	recipe = AddRecipe(89368, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(445, 445, 450, 455, 460)
	recipe:SetCraftedItem(63305, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Strength IX -- 89369
	recipe = AddRecipe(89369, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(465, 465, 470, 475, 480)
	recipe:SetCraftedItem(63304, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Agility IX -- 89370
	recipe = AddRecipe(89370, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 475, 480, 485)
	recipe:SetCraftedItem(63303, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Spirit IX -- 89371
	recipe = AddRecipe(89371, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(455, 455, 460, 465, 470)
	recipe:SetCraftedItem(63307, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Stamina IX -- 89372
	recipe = AddRecipe(89372, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(460, 460, 465, 470, 475)
	recipe:SetCraftedItem(63306, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Protection IX -- 89373
	recipe = AddRecipe(89373, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetCraftedItem(63308, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Vanishing Powder -- 92026
	recipe = AddRecipe(92026, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 90, 100, 110)
	recipe:SetCraftedItem(64670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Dust of Disappearance -- 92027
	recipe = AddRecipe(92027, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(475, 475, 475, 487, 500)
	recipe:SetCraftedItem(63388, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of Blind -- 92579
	recipe = AddRecipe(92579, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 185, 190, 195)
	recipe:SetCraftedItem(64493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of the Predator -- 94404
	recipe = AddRecipe(94404, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(67486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Recklessness -- 94405
	recipe = AddRecipe(94405, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 155, 160, 165)
	recipe:SetCraftedItem(67483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Vanish -- 94711
	recipe = AddRecipe(94711, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(430, 430, 430, 435, 440)
	recipe:SetCraftedItem(63420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of the Treant -- 95215
	recipe = AddRecipe(95215, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 155, 160, 165)
	recipe:SetCraftedItem(68039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Rapid Teleportation -- 95710
	recipe = AddRecipe(95710, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 155, 160, 165)
	recipe:SetCraftedItem(63416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Protector of the Innocent -- 95825
	recipe = AddRecipe(95825, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 390, 397, 405)
	recipe:SetCraftedItem(66918, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Shadow -- 107907
	recipe = AddRecipe(107907, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 105, 110, 115)
	recipe:SetCraftedItem(77101, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-------------------------------------------------------------------------------
	-- Mists of Pandaria.
	-------------------------------------------------------------------------------
	-- Glyph of Focused Wrath -- 57037
	recipe = AddRecipe(57037, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80581, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Ink of Dreams -- 111645
	recipe = AddRecipe(111645, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(79254, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Starlight Ink -- 111646
	recipe = AddRecipe(111646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(79255, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Darkmoon Card of Mists -- 111830
	recipe = AddRecipe(111830, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 610, 615, 620)
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Fan -- 111908
	recipe = AddRecipe(111908, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79333, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Jade Fan -- 111909
	recipe = AddRecipe(111909, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79334, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Red Fan -- 111910
	recipe = AddRecipe(111910, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79335, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Rain Poppy Staff -- 111917
	recipe = AddRecipe(111917, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79339, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Crane Staff -- 111918
	recipe = AddRecipe(111918, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79340, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Serpent Staff -- 111919
	recipe = AddRecipe(111919, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79341, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Ghost Iron Staff -- 111920
	recipe = AddRecipe(111920, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79342, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Inscribed Tiger Staff -- 111921
	recipe = AddRecipe(111921, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(79343, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(26916, 26977, 26995, 28702, 30706, 30709, 30711, 30713, 30715, 30716, 30717, 30721, 33603, 33615, 33638, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Runescroll of Fortitude III -- 112045
	recipe = AddRecipe(112045, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(580, 580, 590, 595, 600)
	recipe:SetCraftedItem(79257, "BIND_ON_PICKUP")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of the Falling Avenger -- 112264
	recipe = AddRecipe(112264, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Righteous Retreat -- 112265
	recipe = AddRecipe(112265, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Bladed Judgment -- 112266
	recipe = AddRecipe(112266, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Crow Feast -- 112429
	recipe = AddRecipe(112429, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Burning Anger -- 112430
	recipe = AddRecipe(112430, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(80588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Nimble Brew -- 112437
	recipe = AddRecipe(112437, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(220, 220, 230, 235, 240)
	recipe:SetCraftedItem(87880, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Paralysis -- 112440
	recipe = AddRecipe(112440, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 370, 375)
	recipe:SetCraftedItem(87897, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Life Cocoon -- 112442
	recipe = AddRecipe(112442, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 335, 340)
	recipe:SetCraftedItem(87895, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Touch of Karma -- 112444
	recipe = AddRecipe(112444, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 380, 385, 390)
	recipe:SetCraftedItem(87900, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Leer of the Ox -- 112450
	recipe = AddRecipe(112450, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 305, 310, 315)
	recipe:SetCraftedItem(87894, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Detox -- 112454
	recipe = AddRecipe(112454, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 380, 385)
	recipe:SetCraftedItem(87899, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Fortifying Brew -- 112457
	recipe = AddRecipe(112457, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 265, 270, 275)
	recipe:SetCraftedItem(87893, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Detoxing -- 112458
	recipe = AddRecipe(112458, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(380, 380, 390, 395, 400)
	recipe:SetCraftedItem(87901, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Zen Flight -- 112460
	recipe = AddRecipe(112460, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87890, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Water Roll -- 112461
	recipe = AddRecipe(112461, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87889, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Crackling Tiger Lightning -- 112462
	recipe = AddRecipe(112462, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(485, 485, 495, 500, 505)
	recipe:SetCraftedItem(87881, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Flying Serpent Kick -- 112463
	recipe = AddRecipe(112463, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(495, 495, 505, 510, 515)
	recipe:SetCraftedItem(87882, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Honor -- 112464
	recipe = AddRecipe(112464, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87883, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Jab -- 112465
	recipe = AddRecipe(112465, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87884, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Rising Tiger Kick -- 112466
	recipe = AddRecipe(112466, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87885, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Spirit Roll -- 112468
	recipe = AddRecipe(112468, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87887, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Fighting Pose -- 112469
	recipe = AddRecipe(112469, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(87888, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Tome of the Clear Mind -- 112883
	recipe = AddRecipe(112883, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(79249, "BIND_ON_PICKUP")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Scroll of Wisdom -- 112996
	recipe = AddRecipe(112996, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 540, 545)
	recipe:SetCraftedItem(79731, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_SCROLL")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Glyph of the Battle Healer -- 119481
	recipe = AddRecipe(119481, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(81956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Mass Exorcism -- 122030
	recipe = AddRecipe(122030, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(83107, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of the Blazing Trail -- 123781
	recipe = AddRecipe(123781, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(85221, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Aspect of the Beast -- 124442
	recipe = AddRecipe(124442, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetCraftedItem(85683, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Guard -- 124449
	recipe = AddRecipe(124449, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(85691, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Zen Meditation -- 124451
	recipe = AddRecipe(124451, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(380, 380, 390, 395, 400)
	recipe:SetCraftedItem(85695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Renewing Mist -- 124452
	recipe = AddRecipe(124452, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetCraftedItem(85696, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Surging Mist -- 124455
	recipe = AddRecipe(124455, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(465, 465, 475, 480, 485)
	recipe:SetCraftedItem(85699, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Touch of Death -- 124456
	recipe = AddRecipe(124456, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(85700, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Transcendence -- 124457
	recipe = AddRecipe(124457, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(84652, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Mind Flay -- 124459
	recipe = AddRecipe(124459, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(455, 455, 465, 470, 475)
	recipe:SetCraftedItem(79513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Vampiric Embrace -- 124460
	recipe = AddRecipe(124460, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(79515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Shadow Word: Death -- 124461
	recipe = AddRecipe(124461, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(79514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of the Heavens -- 124466
	recipe = AddRecipe(124466, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(79538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Confession -- 126153
	recipe = AddRecipe(126153, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(86541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Holy Resurrection -- 126687
	recipe = AddRecipe(126687, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87276, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of the Val'kyr -- 126696
	recipe = AddRecipe(126696, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87277, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Shadowy Friends -- 126800
	recipe = AddRecipe(126800, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(87392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Fetch -- 126801
	recipe = AddRecipe(126801, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetCraftedItem(87393, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Origami Crane -- 126988
	recipe = AddRecipe(126988, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 610, 615, 620)
	recipe:SetCraftedItem(87647, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Origami Frog -- 126989
	recipe = AddRecipe(126989, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 610, 615, 620)
	recipe:SetCraftedItem(87648, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Greater Ox Horn Inscription -- 126994
	recipe = AddRecipe(126994, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(570, 570, 580, 585, 590)
	recipe:SetCraftedItem(87560, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Greater Crane Wing Inscription -- 126995
	recipe = AddRecipe(126995, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(570, 570, 580, 585, 590)
	recipe:SetCraftedItem(87559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Greater Tiger Claw Inscription -- 126996
	recipe = AddRecipe(126996, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(570, 570, 580, 585, 590)
	recipe:SetCraftedItem(83007, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Greater Tiger Fang Inscription -- 126997
	recipe = AddRecipe(126997, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(570, 570, 580, 585, 590)
	recipe:SetCraftedItem(83006, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Yu'lon Kite -- 127007
	recipe = AddRecipe(127007, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 610, 615, 620)
	recipe:SetCraftedItem(89367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_PET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Chi-ji Kite -- 127009
	recipe = AddRecipe(127009, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 610, 615, 620)
	recipe:SetCraftedItem(89368, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_PET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Tiger Fang Inscription -- 127016
	recipe = AddRecipe(127016, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Tiger Claw Inscription -- 127017
	recipe = AddRecipe(127017, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetCraftedItem(87579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Crane Wing Inscription -- 127018
	recipe = AddRecipe(127018, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetCraftedItem(87578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Ox Horn Inscription -- 127019
	recipe = AddRecipe(127019, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetCraftedItem(87577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Secret Tiger Fang Inscription -- 127020
	recipe = AddRecipe(127020, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 585, 590, 595)
	recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Secret Tiger Claw Inscription -- 127021
	recipe = AddRecipe(127021, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 585, 590, 595)
	recipe:SetCraftedItem(87580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Secret Crane Wing Inscription -- 127023
	recipe = AddRecipe(127023, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 585, 590, 595)
	recipe:SetCraftedItem(87582, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Secret Ox Horn Inscription -- 127024
	recipe = AddRecipe(127024, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 585, 590, 595)
	recipe:SetCraftedItem(87581, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(26916, 26959, 26977, 26995, 28702, 30706, 30709, 30710, 30711, 30713, 30715, 30716, 30717, 30721, 30722, 33603, 33615, 33638, 33679, 46716, 53415, 56065, 62327, 64691, 66355, 85911, 86015)

	-- Commissioned Painting -- 127378
	recipe = AddRecipe(127378, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(87811, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddQuest(31539)
	recipe:AddCustom("LEARNT_BY_ACCEPTING_QUEST")

	-- Glyph of Lightwell -- 127625
	recipe = AddRecipe(127625, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 265, 270, 275)
	recipe:SetCraftedItem(87902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of the Cheetah -- 131152
	recipe = AddRecipe(131152, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 595, 600, 605)
	recipe:SetCraftedItem(89868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of Gateway Attunement -- 135561
	recipe = AddRecipe(135561, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(595, 595, 595, 600, 605)
	recipe:SetCraftedItem(93202, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Crafted Malevolent Gladiator's Medallion of Tenacity -- 146638
	recipe = AddRecipe(146638, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 600, 600, 605)
	recipe:SetRecipeItem(102534, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(102483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_TRINKET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Glyph of Swift Death -- 148255
	recipe = AddRecipe(148255, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Regenerative Magic -- 148257
	recipe = AddRecipe(148257, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Divine Shield -- 148259
	recipe = AddRecipe(148259, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104050, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Hand of Sacrifice -- 148260
	recipe = AddRecipe(148260, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Purging -- 148261
	recipe = AddRecipe(148261, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of the Skeleton -- 148266
	recipe = AddRecipe(148266, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104099, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of the Sprouting Mushroom -- 148268
	recipe = AddRecipe(148268, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104102, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of One with Nature -- 148269
	recipe = AddRecipe(148269, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104103, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of the Unbound Elemental -- 148270
	recipe = AddRecipe(148270, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104104, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Evaporation -- 148271
	recipe = AddRecipe(148271, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104105, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Condensation -- 148272
	recipe = AddRecipe(148272, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104106, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of the Exorcist -- 148273
	recipe = AddRecipe(148273, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104107, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of Pillar of Light -- 148274
	recipe = AddRecipe(148274, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104108, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Angels -- 148275
	recipe = AddRecipe(148275, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104109, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of the Sha -- 148276
	recipe = AddRecipe(148276, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104120, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Inspired Hymns -- 148278
	recipe = AddRecipe(148278, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104122, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Headhunting -- 148279
	recipe = AddRecipe(148279, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104123, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_JADEFIRE")

	-- Glyph of Improved Distraction -- 148280
	recipe = AddRecipe(148280, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104124, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Spirit Raptors -- 148281
	recipe = AddRecipe(148281, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_LIONS")

	-- Glyph of Lingering Ancestors -- 148282
	recipe = AddRecipe(148282, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MIDNIGHT")

	-- Glyph of Spirit Wolf -- 148283
	recipe = AddRecipe(148283, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_MOONGLOW")

	-- Glyph of Flaming Serpent -- 148284
	recipe = AddRecipe(148284, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of the Compy -- 148285
	recipe = AddRecipe(148285, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104130, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_DREAMS")

	-- Glyph of Elemental Familiars -- 148286
	recipe = AddRecipe(148286, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104131, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")

	-- Glyph of Astral Fixation -- 148287
	recipe = AddRecipe(148287, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104133, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of Rain of Frogs -- 148288
	recipe = AddRecipe(148288, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104134, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of the Raging Whirlwind -- 148289
	recipe = AddRecipe(148289, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104135, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SEA")

	-- Glyph of the Subtle Defender -- 148290
	recipe = AddRecipe(148290, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104136, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of the Watchful Eye -- 148291
	recipe = AddRecipe(148291, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104137, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-- Glyph of the Weaponmaster -- 148292
	recipe = AddRecipe(148292, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104138, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_CELESTIAL")

	-- Glyph of the Lean Pack -- 148487
	recipe = AddRecipe(148487, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104270, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_ETHEREAL")

	-- Glyph of Enduring Deceit -- 148489
	recipe = AddRecipe(148489, V.MOP, Q.UNCOMMON)
	recipe:SetSkillLevels(500, 500, 595, 600, 605)
	recipe:SetCraftedItem(104276, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_SHIMMERING")

	-------------------------------------------------------------------------------
	-- Warlords of Draenor.
	-------------------------------------------------------------------------------

	-- Glyph of Absorb Magic -- 162805
	recipe = AddRecipe(162805, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Ice Reaper -- 162806
	recipe = AddRecipe(162806, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110801, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Icy Runes -- 162807
	recipe = AddRecipe(162807, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110802, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Empowerment -- 162808
	recipe = AddRecipe(162808, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110803, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Raise Ally -- 162810
	recipe = AddRecipe(162810, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110805, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Rune Tap -- 162811
	recipe = AddRecipe(162811, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110806, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Runic Power -- 162812
	recipe = AddRecipe(162812, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110807, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Astral Communion -- 162813
	recipe = AddRecipe(162813, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110800, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Imbued Bark -- 162814
	recipe = AddRecipe(162814, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110809, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Enchanted Bark -- 162815
	recipe = AddRecipe(162815, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Ninth Life -- 162817
	recipe = AddRecipe(162817, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110812, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Celestial Alignment -- 162818
	recipe = AddRecipe(162818, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110813, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Nature's Cure -- 162819
	recipe = AddRecipe(162819, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110814, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Maim -- 162820
	recipe = AddRecipe(162820, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110815, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Savagery -- 162821
	recipe = AddRecipe(162821, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110816, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Moonwarding -- 162822
	recipe = AddRecipe(162822, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110817, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Travel -- 162823
	recipe = AddRecipe(162823, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110818, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Play Dead -- 162824
	recipe = AddRecipe(162824, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110819, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Quick Revival -- 162826
	recipe = AddRecipe(162826, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110821, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Snake Trap -- 162827
	recipe = AddRecipe(162827, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110822, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HUNTER)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Dragon's Breath -- 162829
	recipe = AddRecipe(162829, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110824, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Regenerative Ice -- 162830
	recipe = AddRecipe(162830, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110825, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MAGE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Expel Harm -- 162831
	recipe = AddRecipe(162831, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110826, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Floating Butterfly -- 162832
	recipe = AddRecipe(162832, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110827, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Flying Serpent -- 162833
	recipe = AddRecipe(162833, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110828, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Keg Smash -- 162834
	recipe = AddRecipe(162834, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110829, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Renewed Tea -- 162835
	recipe = AddRecipe(162835, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110830, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Freedom Roll -- 162837
	recipe = AddRecipe(162837, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110832, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Soothing Mist -- 162838
	recipe = AddRecipe(162838, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110833, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Zen Focus -- 162839
	recipe = AddRecipe(162839, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110834, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MONK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Ardent Defender -- 162840
	recipe = AddRecipe(162840, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Consecrator -- 162841
	recipe = AddRecipe(162841, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Divine Wrath -- 162842
	recipe = AddRecipe(162842, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Liberator -- 162843
	recipe = AddRecipe(162843, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110838, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Hand of Freedom -- 162844
	recipe = AddRecipe(162844, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110839, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Judgement -- 162845
	recipe = AddRecipe(162845, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Free Action -- 162846
	recipe = AddRecipe(162846, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Delayed Coalescence -- 162847
	recipe = AddRecipe(162847, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Guardian Spirit -- 162848
	recipe = AddRecipe(162848, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Restored Faith -- 162849
	recipe = AddRecipe(162849, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Miraculous Dispelling -- 162850
	recipe = AddRecipe(162850, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Inquisitor -- 162851
	recipe = AddRecipe(162851, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Silence -- 162852
	recipe = AddRecipe(162852, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Spirit of Redemption -- 162853
	recipe = AddRecipe(162853, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Shadow Magic -- 162854
	recipe = AddRecipe(162854, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PRIEST)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Energy -- 162855
	recipe = AddRecipe(162855, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Elusiveness -- 162856
	recipe = AddRecipe(162856, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Energy Flows -- 162857
	recipe = AddRecipe(162857, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Disappearance -- 162858
	recipe = AddRecipe(162858, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ROGUE)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Ephemeral Spirits -- 162859
	recipe = AddRecipe(162859, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Ghostly Speed -- 162860
	recipe = AddRecipe(162860, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Grounding -- 162861
	recipe = AddRecipe(162861, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Lava Spread -- 162862
	recipe = AddRecipe(162862, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Reactive Shielding -- 162863
	recipe = AddRecipe(162863, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Shamanistic Resolve -- 162864
	recipe = AddRecipe(162864, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110859, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Shocks -- 162865
	recipe = AddRecipe(162865, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Spiritwalker's Focus -- 162866
	recipe = AddRecipe(162866, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Spiritwalker's Aegis -- 162867
	recipe = AddRecipe(162867, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.SHAMAN)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Dark Soul -- 162869
	recipe = AddRecipe(162869, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Life Pact -- 162871
	recipe = AddRecipe(162871, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Metamorphosis -- 162872
	recipe = AddRecipe(162872, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110867, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MINOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Shadowflame -- 162873
	recipe = AddRecipe(162873, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Soul Swap -- 162874
	recipe = AddRecipe(162874, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Strengthened Resolve -- 162876
	recipe = AddRecipe(162876, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARLOCK)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Cleave -- 162877
	recipe = AddRecipe(162877, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110872, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Drawn Sword -- 162878
	recipe = AddRecipe(162878, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110873, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Heroic Leap -- 162879
	recipe = AddRecipe(162879, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110874, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Mocking Banner -- 162880
	recipe = AddRecipe(162880, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110875, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Raging Blow -- 162881
	recipe = AddRecipe(162881, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Rallying Cry -- 162882
	recipe = AddRecipe(162882, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110877, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Shattering Throw -- 162883
	recipe = AddRecipe(162883, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110878, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Glyph of Flawless Defense -- 162884
	recipe = AddRecipe(162884, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(110879, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Darkmoon Card of Draenor -- 163294
	recipe = AddRecipe(163294, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Research: Midnight Ink -- 165304
	recipe = AddRecipe(165304, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(175, 175, 175, 225, 275)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Lion's Ink -- 165456
	recipe = AddRecipe(165456, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 250, 300)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Jadefire Ink -- 165460
	recipe = AddRecipe(165460, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 300, 350)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Celestial Ink -- 165461
	recipe = AddRecipe(165461, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 300, 350, 400)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Shimmering Ink -- 165463
	recipe = AddRecipe(165463, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 400, 450)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Ethereal Ink -- 165464
	recipe = AddRecipe(165464, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 390, 400, 490)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Ink of the Sea -- 165465
	recipe = AddRecipe(165465, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 450, 500, 550)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Blackfallow Ink -- 165466
	recipe = AddRecipe(165466, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 560, 595)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Ink of Dreams -- 165467
	recipe = AddRecipe(165467, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(595, 595, 595, 597, 600)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Research: Moonglow Ink -- 165564
	recipe = AddRecipe(165564, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 175, 225)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_INSC_AUTOLEARN")

	-- Warmaster's Firestick -- 165804
	recipe = AddRecipe(165804, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118615, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113131, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_WAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Crystalfire Spellstaff -- 166356
	recipe = AddRecipe(166356, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118605, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113134, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Etched-Blade Warstaff -- 166359
	recipe = AddRecipe(166359, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118607, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(111526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_STAFF")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Shadowtome -- 166363
	recipe = AddRecipe(166363, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118613, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113270, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_OFF_HAND")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Mystical Crystal -- 166366
	recipe = AddRecipe(166366, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118610, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113144, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Glorious Crystal -- 166367
	recipe = AddRecipe(166367, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118608, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113183, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Volatile Crystal -- 166432
	recipe = AddRecipe(166432, V.WOD, Q.UNCOMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetRecipeItem(118614, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(113289, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Card of Omens -- 166669
	recipe = AddRecipe(166669, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 700, 702, 705)
	recipe:SetCraftedItem(113355, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Research: Warbinder's Ink -- 167950
	recipe = AddRecipe(167950, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetItemFilterType("INSCRIPTION_RESEARCH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- War Paints -- 169081
	recipe = AddRecipe(169081, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 800, 1000)
	recipe:SetCraftedItem(112377, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Glyph of Flapping Owl -- 175186
	recipe = AddRecipe(175186, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 300, 450, 600)
	recipe:SetCraftedItem(118573, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_MAJOR_GLYPH")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DRUID)
	recipe:AddDiscovery("DISCOVERY_INSC_WARBINDER")

	-- Ocean Tarot -- 175389
	recipe = AddRecipe(175389, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(118601, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_TRINKET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Laughing Tarot -- 175390
	recipe = AddRecipe(175390, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(118602, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_TRINKET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Savage Tarot -- 175392
	recipe = AddRecipe(175392, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(118603, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_TRINKET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Secrets of Draenor Inscription -- 177045
	recipe = AddRecipe(177045, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 650, 700)
	recipe:SetCraftedItem(119297, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_CREATED_ITEM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	-- Inferno Tarot -- 178248
	recipe = AddRecipe(178248, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 700, 700, 700)
	recipe:SetRecipeItem(120265, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(120263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Molten Tarot -- 178249
	recipe = AddRecipe(178249, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 700, 700, 700)
	recipe:SetRecipeItem(120266, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(120264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("INSCRIPTION_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(77372, 79829, 87063, 87551)

	-- Warbinder's Ink -- 178497
	recipe = AddRecipe(178497, V.WOD, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 600, 600, 600)
	recipe:SetCraftedItem(113111, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("INSCRIPTION_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DRAENOR_DEFAULT")

	self.InitializeRecipes = nil
end
