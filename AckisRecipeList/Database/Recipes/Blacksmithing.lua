--[[
************************************************************************
Blacksmithing.lua
************************************************************************
File date: 2014-02-11T16:24:06Z
File hash: 86666de
Project hash: fbca907
Project version: 2.6.2
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]] --

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub	= _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-------------------------------------------------------------------------------
-- Filter flags. Acquire types, and Reputation levels.
-------------------------------------------------------------------------------
local F = private.FILTER_IDS
local A = private.ACQUIRE_TYPE_IDS
local Q = private.ITEM_QUALITIES
local REP = private.REP_LEVELS
local FAC = private.FACTION_IDS
local V = private.GAME_VERSIONS
local Z = private.ZONE_NAMES

--------------------------------------------------------------------------------------------------------------------
-- Initialize!
--------------------------------------------------------------------------------------------------------------------
function addon:InitBlacksmithing()
	local function AddRecipe(spell_id, genesis, quality)
		return addon:AddRecipe(spell_id, private.PROFESSION_SPELL_IDS.BLACKSMITHING, genesis, quality)
	end

	private:InitializeBlacksmithingTrainers()

	local recipe

	-------------------------------------------------------------------------------
	-- Classic.
	-------------------------------------------------------------------------------
	-- Rough Sharpening Stone -- 2660
	recipe = AddRecipe(2660, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(2862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1, F.DPS)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Copper Chain Belt -- 2661
	recipe = AddRecipe(2661, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetCraftedItem(2851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Copper Chain Pants -- 2662
	recipe = AddRecipe(2662, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 50, 70, 90)
	recipe:SetCraftedItem(2852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Copper Bracers -- 2663
	recipe = AddRecipe(2663, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 20, 40, 60)
	recipe:SetCraftedItem(2853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Runed Copper Bracers -- 2664
	recipe = AddRecipe(2664, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(90, 90, 115, 127, 140)
	recipe:SetCraftedItem(2854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Coarse Sharpening Stone -- 2665
	recipe = AddRecipe(2665, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 65, 72, 80)
	recipe:SetCraftedItem(2863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Runed Copper Belt -- 2666
	recipe = AddRecipe(2666, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 110, 130, 150)
	recipe:SetCraftedItem(2857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Runed Copper Breastplate -- 2667
	recipe = AddRecipe(2667, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(80, 80, 120, 140, 160)
	recipe:SetRecipeItem(2881, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Rough Bronze Leggings -- 2668
	recipe = AddRecipe(2668, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 160, 175)
	recipe:SetCraftedItem(2865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Rough Bronze Cuirass -- 2670
	recipe = AddRecipe(2670, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 145, 160, 175)
	recipe:SetCraftedItem(2866, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Patterned Bronze Bracers -- 2672
	recipe = AddRecipe(2672, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetCraftedItem(2868, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Silvered Bronze Breastplate -- 2673
	recipe = AddRecipe(2673, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetRecipeItem(5578, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(2869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Sharpening Stone -- 2674
	recipe = AddRecipe(2674, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 132, 140)
	recipe:SetCraftedItem(2871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Shining Silver Breastplate -- 2675
	recipe = AddRecipe(2675, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetCraftedItem(2870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Copper Mace -- 2737
	recipe = AddRecipe(2737, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(15, 15, 55, 75, 95)
	recipe:SetCraftedItem(2844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Copper Axe -- 2738
	recipe = AddRecipe(2738, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 60, 80, 100)
	recipe:SetCraftedItem(2845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Copper Shortsword -- 2739
	recipe = AddRecipe(2739, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 65, 85, 105)
	recipe:SetCraftedItem(2847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Bronze Mace -- 2740
	recipe = AddRecipe(2740, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(2848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Bronze Axe -- 2741
	recipe = AddRecipe(2741, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(115, 115, 145, 160, 175)
	recipe:SetCraftedItem(2849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Bronze Shortsword -- 2742
	recipe = AddRecipe(2742, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(120, 120, 150, 165, 180)
	recipe:SetCraftedItem(2850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Rough Weightstone -- 3115
	recipe = AddRecipe(3115, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(3239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Coarse Weightstone -- 3116
	recipe = AddRecipe(3116, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 65, 72, 80)
	recipe:SetCraftedItem(3240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Heavy Weightstone -- 3117
	recipe = AddRecipe(3117, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 132, 140)
	recipe:SetCraftedItem(3241, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Copper Broadsword -- 3292
	recipe = AddRecipe(3292, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 135, 155, 175)
	recipe:SetCraftedItem(3487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Copper Battle Axe -- 3293
	recipe = AddRecipe(3293, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetCraftedItem(3488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Thick War Axe -- 3294
	recipe = AddRecipe(3294, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(70, 70, 110, 130, 150)
	recipe:SetCraftedItem(3489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Deadly Bronze Poniard -- 3295
	recipe = AddRecipe(3295, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 195)
	recipe:SetRecipeItem(2883, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Bronze Mace -- 3296
	recipe = AddRecipe(3296, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(3491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Mighty Iron Hammer -- 3297
	recipe = AddRecipe(3297, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetRecipeItem(3608, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3492, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Copper Chain Boots -- 3319
	recipe = AddRecipe(3319, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(20, 20, 60, 80, 100)
	recipe:SetCraftedItem(3469, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Rough Grinding Stone -- 3320
	recipe = AddRecipe(3320, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(25, 25, 45, 65, 85)
	recipe:SetCraftedItem(3470, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Copper Chain Vest -- 3321
	recipe = AddRecipe(3321, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetRecipeItem(3609, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3471, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runed Copper Gauntlets -- 3323
	recipe = AddRecipe(3323, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(40, 40, 80, 100, 120)
	recipe:SetCraftedItem(3472, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Runed Copper Pants -- 3324
	recipe = AddRecipe(3324, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(45, 45, 85, 105, 125)
	recipe:SetCraftedItem(3473, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Gemmed Copper Gauntlets -- 3325
	recipe = AddRecipe(3325, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(60, 60, 100, 120, 140)
	recipe:SetRecipeItem(3610, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3474, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Coarse Grinding Stone -- 3326
	recipe = AddRecipe(3326, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(75, 75, 75, 87, 100)
	recipe:SetCraftedItem(3478, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Rough Bronze Shoulders -- 3328
	recipe = AddRecipe(3328, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(3480, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Silvered Bronze Shoulders -- 3330
	recipe = AddRecipe(3330, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetRecipeItem(2882, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3481, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Silvered Bronze Boots -- 3331
	recipe = AddRecipe(3331, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(3482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Silvered Bronze Gauntlets -- 3333
	recipe = AddRecipe(3333, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 180, 195)
	recipe:SetCraftedItem(3483, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Green Iron Boots -- 3334
	recipe = AddRecipe(3334, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(145, 145, 175, 190, 205)
	recipe:SetRecipeItem(3611, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Gauntlets -- 3336
	recipe = AddRecipe(3336, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(3612, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3485, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Grinding Stone -- 3337
	recipe = AddRecipe(3337, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 125, 137, 150)
	recipe:SetCraftedItem(3486, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Big Bronze Knife -- 3491
	recipe = AddRecipe(3491, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(105, 105, 135, 150, 165)
	recipe:SetCraftedItem(3848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Iron Shortsword -- 3492
	recipe = AddRecipe(3492, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(12162, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddLimitedVendor(2843, 1, 3356, 1, 5512, 1, 45549, 1, 46359, 1, 52641, 1)

	-- Jade Serpentblade -- 3493
	recipe = AddRecipe(3493, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(3866, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Solid Iron Maul -- 3494
	recipe = AddRecipe(3494, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetRecipeItem(10858, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddLimitedVendor(1471, 1, 8878, 1, 26081, 1)

	-- Golden Iron Destroyer -- 3495
	recipe = AddRecipe(3495, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetRecipeItem(3867, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Moonsteel Broadsword -- 3496
	recipe = AddRecipe(3496, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetRecipeItem(12163, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(2482, 1)

	-- Frost Tiger Blade -- 3497
	recipe = AddRecipe(3497, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetRecipeItem(3868, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Massive Iron Axe -- 3498
	recipe = AddRecipe(3498, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(12164, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddLimitedVendor(1146, 1, 2483, 1)

	-- Shadow Crescent Axe -- 3500
	recipe = AddRecipe(3500, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetRecipeItem(3869, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Bracers -- 3501
	recipe = AddRecipe(3501, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(165, 165, 190, 202, 215)
	recipe:SetCraftedItem(3835, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Green Iron Helm -- 3502
	recipe = AddRecipe(3502, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetCraftedItem(3836, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Golden Scale Coif -- 3503
	recipe = AddRecipe(3503, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(6047, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3837, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddLimitedVendor(5411, 1)

	-- Green Iron Shoulders -- 3504
	recipe = AddRecipe(3504, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(3870, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3840, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Shoulders -- 3505
	recipe = AddRecipe(3505, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(3871, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3841, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Leggings -- 3506
	recipe = AddRecipe(3506, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetCraftedItem(3842, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Golden Scale Leggings -- 3507
	recipe = AddRecipe(3507, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(170, 170, 195, 207, 220)
	recipe:SetRecipeItem(3872, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Green Iron Hauberk -- 3508
	recipe = AddRecipe(3508, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetCraftedItem(3844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Golden Scale Cuirass -- 3511
	recipe = AddRecipe(3511, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(195, 195, 220, 232, 245)
	recipe:SetRecipeItem(3873, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Polished Steel Boots -- 3513
	recipe = AddRecipe(3513, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(3874, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Boots -- 3515
	recipe = AddRecipe(3515, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(200, 200, 210, 215, 220)
	recipe:SetRecipeItem(3875, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(3847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Pearl-handled Dagger -- 6517
	recipe = AddRecipe(6517, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(110, 110, 140, 155, 170)
	recipe:SetCraftedItem(5540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Iridescent Hammer -- 6518
	recipe = AddRecipe(6518, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(140, 140, 170, 185, 200)
	recipe:SetRecipeItem(5543, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(5541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Iron Shield Spike -- 7221
	recipe = AddRecipe(7221, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(150, 150, 180, 195, 210)
	recipe:SetRecipeItem(6044, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Iron Counterweight -- 7222
	recipe = AddRecipe(7222, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(165, 165, 190, 202, 215)
	recipe:SetRecipeItem(6045, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Golden Scale Bracers -- 7223
	recipe = AddRecipe(7223, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetCraftedItem(6040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Steel Weapon Chain -- 7224
	recipe = AddRecipe(7224, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(6046, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Copper Maul -- 7408
	recipe = AddRecipe(7408, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(65, 65, 105, 125, 145)
	recipe:SetCraftedItem(6214, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Rough Bronze Boots -- 7817
	recipe = AddRecipe(7817, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(95, 95, 125, 140, 155)
	recipe:SetCraftedItem(6350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Ironforge Breastplate -- 8367
	recipe = AddRecipe(8367, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(100, 100, 140, 160, 180)
	recipe:SetRecipeItem(6735, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(6731, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.DPS)
	recipe:AddQuest(1618)

	-- Iron Buckle -- 8768
	recipe = AddRecipe(8768, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 152, 155)
	recipe:SetCraftedItem(7071, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Copper Dagger -- 8880
	recipe = AddRecipe(8880, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 70, 90, 110)
	recipe:SetCraftedItem(7166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Barbaric Iron Shoulders -- 9811
	recipe = AddRecipe(9811, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(7978, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7913, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.HORDE, F.DPS)
	recipe:AddQuest(2752)

	-- Barbaric Iron Breastplate -- 9813
	recipe = AddRecipe(9813, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(160, 160, 185, 197, 210)
	recipe:SetRecipeItem(7979, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7914, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.HORDE, F.DPS)
	recipe:AddQuest(2751)

	-- Barbaric Iron Helm -- 9814
	recipe = AddRecipe(9814, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(175, 175, 200, 212, 225)
	recipe:SetRecipeItem(7980, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7915, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddQuest(2754)

	-- Barbaric Iron Boots -- 9818
	recipe = AddRecipe(9818, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetRecipeItem(7981, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7916, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddQuest(2753)

	-- Barbaric Iron Gloves -- 9820
	recipe = AddRecipe(9820, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(185, 185, 210, 222, 235)
	recipe:SetRecipeItem(7982, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7917, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.HORDE, F.DPS)
	recipe:AddQuest(2755)

	-- Steel Breastplate -- 9916
	recipe = AddRecipe(9916, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetCraftedItem(7963, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Solid Sharpening Stone -- 9918
	recipe = AddRecipe(9918, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7964, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Solid Grinding Stone -- 9920
	recipe = AddRecipe(9920, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7966, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Solid Weightstone -- 9921
	recipe = AddRecipe(9921, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 205, 210)
	recipe:SetCraftedItem(7965, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Mithril Shoulder -- 9926
	recipe = AddRecipe(9926, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(7918, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Mithril Gauntlet -- 9928
	recipe = AddRecipe(9928, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetCraftedItem(7919, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Mithril Scale Pants -- 9931
	recipe = AddRecipe(9931, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetCraftedItem(7920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Mithril Pants -- 9933
	recipe = AddRecipe(9933, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(210, 210, 230, 240, 250)
	recipe:SetRecipeItem(7975, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7921, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Steel Plate Helm -- 9935
	recipe = AddRecipe(9935, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetCraftedItem(7922, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Mithril Scale Bracers -- 9937
	recipe = AddRecipe(9937, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetRecipeItem(7995, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7924, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(8161)
	recipe:AddLimitedVendor(8176, 1)

	-- Mithril Shield Spike -- 9939
	recipe = AddRecipe(9939, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(215, 215, 235, 245, 255)
	recipe:SetRecipeItem(7976, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7967, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Mithril Pants -- 9945
	recipe = AddRecipe(9945, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(7983, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:Retire()

	-- Ornate Mithril Gloves -- 9950
	recipe = AddRecipe(9950, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 240, 250, 260)
	recipe:SetRecipeItem(7984, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Ornate Mithril Shoulder -- 9952
	recipe = AddRecipe(9952, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetRecipeItem(7985, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7928, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:Retire()

	-- Truesilver Gauntlets -- 9954
	recipe = AddRecipe(9954, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(225, 225, 245, 255, 265)
	recipe:SetCraftedItem(7938, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Orcish War Leggings -- 9957
	recipe = AddRecipe(9957, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 250, 260, 270)
	recipe:SetCraftedItem(7929, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.HORDE, F.DPS)
	recipe:Retire()

	-- Heavy Mithril Breastplate -- 9959
	recipe = AddRecipe(9959, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(7930, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Mithril Coif -- 9961
	recipe = AddRecipe(9961, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 250, 260, 270)
	recipe:SetCraftedItem(7931, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Mithril Spurs -- 9964
	recipe = AddRecipe(9964, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetRecipeItem(7989, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Mithril Scale Shoulders -- 9966
	recipe = AddRecipe(9966, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetRecipeItem(7991, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7932, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Heavy Mithril Boots -- 9968
	recipe = AddRecipe(9968, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 255, 265, 275)
	recipe:SetCraftedItem(7933, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Mithril Helm -- 9970
	recipe = AddRecipe(9970, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(245, 245, 255, 265, 275)
	recipe:SetRecipeItem(7990, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7934, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Mithril Breastplate -- 9972
	recipe = AddRecipe(9972, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 260, 270, 280)
	recipe:SetCraftedItem(7935, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Truesilver Breastplate -- 9974
	recipe = AddRecipe(9974, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(245, 245, 265, 275, 285)
	recipe:SetCraftedItem(7939, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Ornate Mithril Boots -- 9979
	recipe = AddRecipe(9979, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(265, 265, 265, 275, 285)
	recipe:SetCraftedItem(7936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Ornate Mithril Helm -- 9980
	recipe = AddRecipe(9980, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(265, 265, 265, 275, 285)
	recipe:SetCraftedItem(7937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Copper Claymore -- 9983
	recipe = AddRecipe(9983, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(30, 30, 70, 90, 110)
	recipe:SetCraftedItem(7955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 47384, 47396, 47400, 47418, 47419, 47420, 47431, 48619, 52640, 57620, 65043, 65114, 65129)

	-- Bronze Warhammer -- 9985
	recipe = AddRecipe(9985, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(125, 125, 155, 170, 185)
	recipe:SetCraftedItem(7956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Bronze Greatsword -- 9986
	recipe = AddRecipe(9986, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(130, 130, 160, 175, 190)
	recipe:SetCraftedItem(7957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Bronze Battle Axe -- 9987
	recipe = AddRecipe(9987, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(135, 135, 165, 180, 195)
	recipe:SetCraftedItem(7958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Heavy Mithril Axe -- 9993
	recipe = AddRecipe(9993, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(210, 210, 235, 247, 260)
	recipe:SetCraftedItem(7941, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Blue Glittering Axe -- 9995
	recipe = AddRecipe(9995, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(220, 220, 245, 257, 270)
	recipe:SetRecipeItem(7992, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Wicked Mithril Blade -- 9997
	recipe = AddRecipe(9997, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(225, 225, 250, 262, 275)
	recipe:SetRecipeItem(8029, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Big Black Mace -- 10001
	recipe = AddRecipe(10001, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(230, 230, 255, 267, 280)
	recipe:SetCraftedItem(7945, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- The Shatterer -- 10003
	recipe = AddRecipe(10003, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(235, 235, 260, 272, 285)
	recipe:SetCraftedItem(7954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Dazzling Mithril Rapier -- 10005
	recipe = AddRecipe(10005, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(240, 240, 265, 277, 290)
	recipe:SetRecipeItem(7993, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7944, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Phantom Blade -- 10007
	recipe = AddRecipe(10007, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(270, 270, 270, 282, 295)
	recipe:SetRecipeItem(74274, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7961, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddWorldDrop(Z.STRATHOLME)

	-- Runed Mithril Hammer -- 10009
	recipe = AddRecipe(10009, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(245, 245, 270, 282, 295)
	recipe:SetRecipeItem(8028, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(7946, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Blight -- 10011
	recipe = AddRecipe(10011, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 275, 287, 300)
	recipe:SetCraftedItem(7959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Ebon Shiv -- 10013
	recipe = AddRecipe(10013, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 280, 292, 305)
	recipe:SetRecipeItem(8030, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(7947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(11278)

	-- Truesilver Champion -- 10015
	recipe = AddRecipe(10015, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 285, 297, 310)
	recipe:SetCraftedItem(7960, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Inlaid Mithril Cylinder -- 11454
	recipe = AddRecipe(11454, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 225, 237, 250)
	recipe:SetRecipeItem(10713, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(9060, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("CRAFTED_ENGINEERS")

	-- Golden Scale Gauntlets -- 11643
	recipe = AddRecipe(11643, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(205, 205, 225, 235, 245)
	recipe:SetRecipeItem(9367, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(9366, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.DPS)
	recipe:Retire()

	-- Silvered Bronze Leggings -- 12259
	recipe = AddRecipe(12259, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(155, 155, 180, 192, 205)
	recipe:SetRecipeItem(10424, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(10423, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Rough Copper Vest -- 12260
	recipe = AddRecipe(12260, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 15, 35, 55)
	recipe:SetCraftedItem(10421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.MISC1)
	recipe:AddCustom("DEFAULT_RECIPE")

	-- Dark Iron Pulverizer -- 15292
	recipe = AddRecipe(15292, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetRecipeItem(11610, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11608, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(9028)

	-- Dark Iron Mail -- 15293
	recipe = AddRecipe(15293, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(11614, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(11606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACKROCK_DEPTHS)
	recipe:AddCustom("BRD_MAIL")

	-- Dark Iron Sunderer -- 15294
	recipe = AddRecipe(15294, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(11611, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.TANK)
	recipe:AddMobDrop(9554, 10043)

	-- Dark Iron Shoulders -- 15295
	recipe = AddRecipe(15295, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetRecipeItem(11615, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(11605, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.BLACKROCK_DEPTHS)
	recipe:AddCustom("BRD_SHOULDERS")

	-- Dark Iron Plate -- 15296
	recipe = AddRecipe(15296, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(11612, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(11604, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(9543)

	-- Glinting Steel Dagger -- 15972
	recipe = AddRecipe(15972, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(180, 180, 205, 217, 230)
	recipe:SetCraftedItem(12259, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Searing Golden Blade -- 15973
	recipe = AddRecipe(15973, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(12261, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12260, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dense Grinding Stone -- 16639
	recipe = AddRecipe(16639, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12644, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Dense Weightstone -- 16640
	recipe = AddRecipe(16640, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12643, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Dense Sharpening Stone -- 16641
	recipe = AddRecipe(16641, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 255, 257, 260)
	recipe:SetCraftedItem(12404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Thorium Armor -- 16642
	recipe = AddRecipe(16642, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(12405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Thorium Belt -- 16643
	recipe = AddRecipe(16643, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(250, 250, 270, 280, 290)
	recipe:SetCraftedItem(12406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Thorium Bracers -- 16644
	recipe = AddRecipe(16644, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(255, 255, 275, 285, 295)
	recipe:SetCraftedItem(12408, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Radiant Belt -- 16645
	recipe = AddRecipe(16645, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetRecipeItem(12685, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12416, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Shoulders -- 16646
	recipe = AddRecipe(16646, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(12428, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Imperial Plate Belt -- 16647
	recipe = AddRecipe(16647, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(265, 265, 285, 295, 305)
	recipe:SetCraftedItem(12424, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Radiant Breastplate -- 16648
	recipe = AddRecipe(16648, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(12689, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12415, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Bracers -- 16649
	recipe = AddRecipe(16649, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetCraftedItem(12425, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Wildthorn Mail -- 16650
	recipe = AddRecipe(16650, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(270, 270, 290, 300, 310)
	recipe:SetRecipeItem(12691, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12624, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Shield Spike -- 16651
	recipe = AddRecipe(16651, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 295, 305, 315)
	recipe:SetRecipeItem(12692, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12645, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Boots -- 16652
	recipe = AddRecipe(16652, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(12409, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Thorium Helm -- 16653
	recipe = AddRecipe(16653, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 300, 310, 320)
	recipe:SetCraftedItem(12410, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Radiant Gloves -- 16654
	recipe = AddRecipe(16654, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(12695, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12418, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Fiery Plate Gauntlets -- 16655
	recipe = AddRecipe(16655, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12699, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12631, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Radiant Boots -- 16656
	recipe = AddRecipe(16656, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12697, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12419, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Boots -- 16657
	recipe = AddRecipe(16657, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetCraftedItem(12426, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Imperial Plate Helm -- 16658
	recipe = AddRecipe(16658, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetCraftedItem(12427, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Radiant Circlet -- 16659
	recipe = AddRecipe(16659, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(12702, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12417, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Dawnbringer Shoulders -- 16660
	recipe = AddRecipe(16660, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(12698, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12625, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Storm Gauntlets -- 16661
	recipe = AddRecipe(16661, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(12703, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12632, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(11278)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Thorium Leggings -- 16662
	recipe = AddRecipe(16662, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12414, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Imperial Plate Chest -- 16663
	recipe = AddRecipe(16663, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12422, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Runic Plate Shoulders -- 16664
	recipe = AddRecipe(16664, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12706, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12610, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(38561)

	-- Runic Plate Boots -- 16665
	recipe = AddRecipe(16665, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12707, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(38561)

	-- Demon Forged Breastplate -- 16667
	recipe = AddRecipe(16667, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(285, 285, 305, 315, 325)
	recipe:SetRecipeItem(12696, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12628, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Whitesoul Helm -- 16724
	recipe = AddRecipe(16724, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12711, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12633, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Radiant Leggings -- 16725
	recipe = AddRecipe(16725, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12713, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Runic Plate Helm -- 16726
	recipe = AddRecipe(16726, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12714, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12612, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(38561)

	-- Helm of the Great Chief -- 16728
	recipe = AddRecipe(16728, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12716, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12636, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Lionheart Helm -- 16729
	recipe = AddRecipe(16729, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12717, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12640, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Imperial Plate Leggings -- 16730
	recipe = AddRecipe(16730, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(12429, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Runic Breastplate -- 16731
	recipe = AddRecipe(16731, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12718, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12613, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Runic Plate Leggings -- 16732
	recipe = AddRecipe(16732, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12719, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12614, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(38561)

	-- Stronghold Gauntlets -- 16741
	recipe = AddRecipe(16741, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12720, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12639, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Enchanted Thorium Helm -- 16742
	recipe = AddRecipe(16742, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12725, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12620, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:Retire()

	-- Enchanted Thorium Leggings -- 16744
	recipe = AddRecipe(16744, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12726, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12619, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:Retire()

	-- Enchanted Thorium Breastplate -- 16745
	recipe = AddRecipe(16745, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12727, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12618, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:Retire()

	-- Invulnerable Mail -- 16746
	recipe = AddRecipe(16746, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12728, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12641, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Ornate Thorium Handaxe -- 16969
	recipe = AddRecipe(16969, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(275, 275, 300, 312, 325)
	recipe:SetRecipeItem(12819, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12773, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)
	recipe:AddVendor(11278)

	-- Dawn's Edge -- 16970
	recipe = AddRecipe(16970, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(275, 275, 300, 312, 325)
	recipe:SetRecipeItem(12821, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12774, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Huge Thorium Battleaxe -- 16971
	recipe = AddRecipe(16971, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(12823, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(12775, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)
	recipe:AddVendor(11278)

	-- Enchanted Battlehammer -- 16973
	recipe = AddRecipe(16973, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(12824, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:Retire()

	-- Blazing Rapier -- 16978
	recipe = AddRecipe(16978, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(280, 280, 305, 317, 330)
	recipe:SetRecipeItem(12825, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12777, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Serenity -- 16983
	recipe = AddRecipe(16983, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(285, 285, 310, 322, 335)
	recipe:SetRecipeItem(12827, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12781, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddWorldDrop(Z.STRATHOLME)
	recipe:AddCustom("STRATH_BS_PLANS")

	-- Volcanic Hammer -- 16984
	recipe = AddRecipe(16984, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(290, 290, 315, 327, 340)
	recipe:SetRecipeItem(12828, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12792, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(10119)

	-- Corruption -- 16985
	recipe = AddRecipe(16985, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 315, 327, 340)
	recipe:SetRecipeItem(12830, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12782, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
	recipe:AddWorldDrop(Z.STRATHOLME)
	recipe:AddCustom("STRATH_BS_PLANS")

	-- Hammer of the Titans -- 16988
	recipe = AddRecipe(16988, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12833, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12796, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
	recipe:AddMobDrop(10438)

	-- Arcanite Champion -- 16990
	recipe = AddRecipe(16990, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12834, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12790, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
	recipe:AddMobDrop(10899)

	-- Annihilator -- 16991
	recipe = AddRecipe(16991, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12835, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12798, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.TANK)
	recipe:AddMobDrop(9736)

	-- Frostguard -- 16992
	recipe = AddRecipe(16992, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12836, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12797, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(1844)
	recipe:AddLimitedVendor(50129, 1)

	-- Masterwork Stormhammer -- 16993
	recipe = AddRecipe(16993, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12837, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12794, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE)
	recipe:AddMobDrop(10899)

	-- Arcanite Reaper -- 16994
	recipe = AddRecipe(16994, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12838, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12784, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS)
	recipe:AddMobDrop(9596)

	-- Heartseeker -- 16995
	recipe = AddRecipe(16995, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(12839, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(12783, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(10997)

	-- Silver Skeleton Key -- 19666
	recipe = AddRecipe(19666, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(100, 100, 100, 110, 120)
	recipe:SetCraftedItem(15869, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Golden Skeleton Key -- 19667
	recipe = AddRecipe(19667, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(150, 150, 150, 160, 170)
	recipe:SetCraftedItem(15870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 43429, 44781, 45548, 52640, 65114, 65129)

	-- Truesilver Skeleton Key -- 19668
	recipe = AddRecipe(19668, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(200, 200, 200, 210, 220)
	recipe:SetCraftedItem(15871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16669, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Arcanite Skeleton Key -- 19669
	recipe = AddRecipe(19669, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(275, 275, 275, 280, 285)
	recipe:SetCraftedItem(15872, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2836, 2998, 3136, 3174, 3355, 3478, 3557, 4258, 4596, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 15400, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fiery Chain Girdle -- 20872
	recipe = AddRecipe(20872, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(17049, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16989, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Fiery Chain Shoulders -- 20873
	recipe = AddRecipe(20873, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17053, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(16988, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Dark Iron Bracers -- 20874
	recipe = AddRecipe(20874, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(295, 295, 315, 325, 335)
	recipe:SetRecipeItem(17051, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17014, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.FRIENDLY, 12944)

	-- Dark Iron Leggings -- 20876
	recipe = AddRecipe(20876, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17052, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17013, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Dark Iron Reaver -- 20890
	recipe = AddRecipe(20890, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17059, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17015, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Dark Iron Destroyer -- 20897
	recipe = AddRecipe(20897, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(17060, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(17016, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Sulfuron Hammer -- 21161
	recipe = AddRecipe(21161, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 325, 337, 350)
	recipe:SetRecipeItem(18592, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17193, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddQuest(7604)

	-- Edge of Winter -- 21913
	recipe = AddRecipe(21913, V.ORIG, Q.UNCOMMON)
	recipe:SetSkillLevels(190, 190, 215, 227, 240)
	recipe:SetRecipeItem(17706, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(17704, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldEvent("WINTER_VEIL")

	-- Elemental Sharpening Stone -- 22757
	recipe = AddRecipe(22757, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 300, 310, 320)
	recipe:SetRecipeItem(18264, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(18262, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.MOLTEN_CORE)

	-- Heavy Timbermaw Belt -- 23628
	recipe = AddRecipe(23628, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19202, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TIMBERMAW_HOLD)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.HONORED, 11557)

	-- Heavy Timbermaw Boots -- 23629
	recipe = AddRecipe(23629, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19204, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19048, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TIMBERMAW_HOLD)
	recipe:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.REVERED, 11557)

	-- Girdle of the Dawn -- 23632
	recipe = AddRecipe(23632, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(290, 290, 310, 320, 330)
	recipe:SetRecipeItem(19203, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19051, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ARGENTDAWN)
	recipe:AddRepVendor(FAC.ARGENTDAWN, REP.HONORED, 10856, 10857, 11536)

	-- Gloves of the Dawn -- 23633
	recipe = AddRecipe(23633, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19205, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19057, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.ARGENTDAWN)
	recipe:AddRepVendor(FAC.ARGENTDAWN, REP.REVERED, 10856, 10857, 11536)

	-- Dark Iron Helm -- 23636
	recipe = AddRecipe(23636, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19206, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19148, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.HONORED, 12944)

	-- Dark Iron Gauntlets -- 23637
	recipe = AddRecipe(23637, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19207, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19164, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Black Amnesty -- 23638
	recipe = AddRecipe(23638, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19166, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Blackfury -- 23639
	recipe = AddRecipe(23639, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19167, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.REVERED, 12944)

	-- Ebon Hand -- 23650
	recipe = AddRecipe(23650, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19210, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19170, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Blackguard -- 23652
	recipe = AddRecipe(23652, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19211, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19168, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Nightfall -- 23653
	recipe = AddRecipe(23653, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19212, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19169, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Bloodsoul Breastplate -- 24136
	recipe = AddRecipe(24136, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19776, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19690, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Bloodsoul Shoulders -- 24137
	recipe = AddRecipe(24137, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19777, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19691, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Bloodsoul Gauntlets -- 24138
	recipe = AddRecipe(24138, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19778, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19692, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Darksoul Breastplate -- 24139
	recipe = AddRecipe(24139, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19779, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19693, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:Retire()

	-- Darksoul Leggings -- 24140
	recipe = AddRecipe(24140, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19780, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19694, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:Retire()

	-- Darksoul Shoulders -- 24141
	recipe = AddRecipe(24141, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(19781, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(19695, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:Retire()

	-- Dark Iron Boots -- 24399
	recipe = AddRecipe(24399, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20040, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(20039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.THORIUM_BROTHERHOOD)
	recipe:AddRepVendor(FAC.THORIUM_BROTHERHOOD, REP.EXALTED, 12944)

	-- Darkrune Gauntlets -- 24912
	recipe = AddRecipe(24912, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20553, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20549, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddQuest(8323)

	-- Darkrune Helm -- 24913
	recipe = AddRecipe(24913, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20555, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20551, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddQuest(8323)

	-- Darkrune Breastplate -- 24914
	recipe = AddRecipe(24914, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(20554, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(20550, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddQuest(8323)

	-- Heavy Obsidian Belt -- 27585
	recipe = AddRecipe(27585, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22197, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15176)

	-- Jagged Obsidian Shield -- 27586
	recipe = AddRecipe(27586, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22219, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22198, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15471)

	-- Thick Obsidian Breastplate -- 27587
	recipe = AddRecipe(27587, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22222, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22196, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS)
	recipe:AddMobDrop(15263)

	-- Light Obsidian Belt -- 27588
	recipe = AddRecipe(27588, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22214, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22195, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15176)

	-- Black Grasp of the Destroyer -- 27589
	recipe = AddRecipe(27589, V.ORIG, Q.RARE)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22220, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22194, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(15340)

	-- Obsidian Mail Tunic -- 27590
	recipe = AddRecipe(27590, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22221, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22191, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.EXALTED, 15471)

	-- Titanic Leggings -- 27829
	recipe = AddRecipe(27829, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22388, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22385, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Persuader -- 27830
	recipe = AddRecipe(27830, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22390, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Sageblade -- 27832
	recipe = AddRecipe(27832, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22389, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(22383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.EASTERN_KINGDOMS, Z.KALIMDOR)

	-- Icebane Breastplate -- 28242
	recipe = AddRecipe(28242, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Icebane Gauntlets -- 28243
	recipe = AddRecipe(28243, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Icebane Bracers -- 28244
	recipe = AddRecipe(28244, V.ORIG, Q.EPIC)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(22671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Ironvine Breastplate -- 28461
	recipe = AddRecipe(28461, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22766, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22762, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.REVERED, 15176)

	-- Ironvine Gloves -- 28462
	recipe = AddRecipe(28462, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22767, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22763, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.HONORED, 15176)

	-- Ironvine Belt -- 28463
	recipe = AddRecipe(28463, V.ORIG, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetRecipeItem(22768, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(22764, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_CIRCLE)
	recipe:AddRepVendor(FAC.CENARION_CIRCLE, REP.FRIENDLY, 15176)

	-------------------------------------------------------------------------------
	-- The Burning Crusade.
	-------------------------------------------------------------------------------
	-- Fel Iron Plate Gloves -- 29545
	recipe = AddRecipe(29545, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 310, 320, 330)
	recipe:SetCraftedItem(23482, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Plate Belt -- 29547
	recipe = AddRecipe(29547, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(305, 305, 315, 325, 335)
	recipe:SetCraftedItem(23484, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Plate Boots -- 29548
	recipe = AddRecipe(29548, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 325, 335, 345)
	recipe:SetCraftedItem(23487, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Plate Pants -- 29549
	recipe = AddRecipe(29549, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 325, 335, 345)
	recipe:SetCraftedItem(23488, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Breastplate -- 29550
	recipe = AddRecipe(29550, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 345, 355)
	recipe:SetCraftedItem(23489, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Chain Coif -- 29551
	recipe = AddRecipe(29551, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 320, 330, 340)
	recipe:SetCraftedItem(23493, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Chain Gloves -- 29552
	recipe = AddRecipe(29552, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 330, 340)
	recipe:SetCraftedItem(23491, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Chain Bracers -- 29553
	recipe = AddRecipe(29553, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 325, 335, 345)
	recipe:SetCraftedItem(23494, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Chain Tunic -- 29556
	recipe = AddRecipe(29556, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 340, 350)
	recipe:SetCraftedItem(23490, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Hatchet -- 29557
	recipe = AddRecipe(29557, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(310, 310, 320, 330, 340)
	recipe:SetCraftedItem(23497, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Hammer -- 29558
	recipe = AddRecipe(29558, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(315, 315, 325, 335, 345)
	recipe:SetCraftedItem(23498, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fel Iron Greatsword -- 29565
	recipe = AddRecipe(29565, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(320, 320, 330, 340, 350)
	recipe:SetCraftedItem(23499, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Adamantite Maul -- 29566
	recipe = AddRecipe(29566, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 335, 345, 355)
	recipe:SetRecipeItem(23590, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23502, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Cleaver -- 29568
	recipe = AddRecipe(29568, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(23591, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23503, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Dagger -- 29569
	recipe = AddRecipe(29569, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetRecipeItem(23592, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23504, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Rapier -- 29571
	recipe = AddRecipe(29571, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23593, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23505, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddLimitedVendor(16670, 1, 16713, 1, 19662, 1)

	-- Adamantite Plate Bracers -- 29603
	recipe = AddRecipe(29603, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23594, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23506, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(19342, 19694)

	-- Adamantite Plate Gloves -- 29605
	recipe = AddRecipe(29605, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(335, 335, 345, 355, 365)
	recipe:SetRecipeItem(23595, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(19342, 19694)

	-- Adamantite Breastplate -- 29606
	recipe = AddRecipe(29606, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 350, 360, 370)
	recipe:SetRecipeItem(23596, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23507, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(19342, 19694)

	-- Enchanted Adamantite Belt -- 29608
	recipe = AddRecipe(29608, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23597, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23510, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.SCRYER)
	recipe:AddRepVendor(FAC.SCRYER, REP.FRIENDLY, 19331)

	-- Enchanted Adamantite Breastplate -- 29610
	recipe = AddRecipe(29610, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23599, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23509, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER, F.SCRYER)
	recipe:AddRepVendor(FAC.SCRYER, REP.REVERED, 19331)

	-- Enchanted Adamantite Boots -- 29611
	recipe = AddRecipe(29611, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23598, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23511, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.SCRYER)
	recipe:AddRepVendor(FAC.SCRYER, REP.HONORED, 19331)

	-- Enchanted Adamantite Leggings -- 29613
	recipe = AddRecipe(29613, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23600, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23512, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.SCRYER)
	recipe:AddRepVendor(FAC.SCRYER, REP.EXALTED, 19331)

	-- Flamebane Bracers -- 29614
	recipe = AddRecipe(29614, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetRecipeItem(23601, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23515, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.ALDOR)
	recipe:AddRepVendor(FAC.ALDOR, REP.FRIENDLY, 19321)

	-- Flamebane Helm -- 29615
	recipe = AddRecipe(29615, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(355, 355, 365, 375, 385)
	recipe:SetRecipeItem(23602, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23516, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER, F.ALDOR)
	recipe:AddRepVendor(FAC.ALDOR, REP.EXALTED, 19321)

	-- Flamebane Gloves -- 29616
	recipe = AddRecipe(29616, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23603, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23514, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.ALDOR)
	recipe:AddRepVendor(FAC.ALDOR, REP.HONORED, 19321)

	-- Flamebane Breastplate -- 29617
	recipe = AddRecipe(29617, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23604, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23513, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.ALDOR)
	recipe:AddRepVendor(FAC.ALDOR, REP.REVERED, 19321)

	-- Felsteel Gloves -- 29619
	recipe = AddRecipe(29619, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23605, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23517, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.TANK)
	recipe:AddMobDrop(18497)

	-- Felsteel Leggings -- 29620
	recipe = AddRecipe(29620, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23606, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23518, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.TANK)
	recipe:AddMobDrop(20900)

	-- Felsteel Helm -- 29621
	recipe = AddRecipe(29621, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23607, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23519, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.TANK, F.CASTER)
	recipe:AddMobDrop(18830)

	-- Gauntlets of the Iron Tower -- 29622
	recipe = AddRecipe(29622, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23621, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Khorium Belt -- 29628
	recipe = AddRecipe(29628, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23608, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23524, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(18203)

	-- Khorium Pants -- 29629
	recipe = AddRecipe(29629, V.TBC, Q.RARE)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23609, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23523, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(20878)

	-- Khorium Boots -- 29630
	recipe = AddRecipe(29630, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23610, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23525, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(18873)

	-- Ragesteel Gloves -- 29642
	recipe = AddRecipe(29642, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23611, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23520, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(17136)

	-- Ragesteel Helm -- 29643
	recipe = AddRecipe(29643, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23612, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(16952)

	-- Ragesteel Breastplate -- 29645
	recipe = AddRecipe(29645, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23613, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23522, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(21454, 23305, 23324)

	-- Swiftsteel Gloves -- 29648
	recipe = AddRecipe(29648, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23615, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23526, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.DPS, F.CASTER)
	recipe:AddMobDrop(18314)

	-- Earthpeace Breastplate -- 29649
	recipe = AddRecipe(29649, V.TBC, Q.RARE)
	recipe:SetSkillLevels(370, 370, 380, 390, 400)
	recipe:SetRecipeItem(23617, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.INSTANCE, F.HEALER, F.CASTER)
	recipe:AddMobDrop(17975)

	-- Fel Sharpening Stone -- 29654
	recipe = AddRecipe(29654, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 300, 305, 310)
	recipe:SetCraftedItem(23528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Adamantite Sharpening Stone -- 29656
	recipe = AddRecipe(29656, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(23618, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Felsteel Shield Spike -- 29657
	recipe = AddRecipe(29657, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 380, 390)
	recipe:SetRecipeItem(23619, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HELLFIRE)
	recipe:AddRepVendor(FAC.HONOR_HOLD, REP.EXALTED, 17657)
	recipe:AddRepVendor(FAC.THRALLMAR, REP.EXALTED, 17585)

	-- Felfury Gauntlets -- 29658
	recipe = AddRecipe(29658, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23620, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Steelgrip Gauntlets -- 29662
	recipe = AddRecipe(29662, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23622, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Storm Helm -- 29663
	recipe = AddRecipe(29663, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23623, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Helm of the Stalwart Defender -- 29664
	recipe = AddRecipe(29664, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23624, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Oathkeeper's Helm -- 29668
	recipe = AddRecipe(29668, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23625, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Black Felsteel Bracers -- 29669
	recipe = AddRecipe(29669, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23626, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Bracers of the Green Fortress -- 29671
	recipe = AddRecipe(29671, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23627, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Blessed Bracers -- 29672
	recipe = AddRecipe(29672, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23628, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Felsteel Longblade -- 29692
	recipe = AddRecipe(29692, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23629, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Khorium Champion -- 29693
	recipe = AddRecipe(29693, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23630, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23541, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Fel Edged Battleaxe -- 29694
	recipe = AddRecipe(29694, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23631, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Felsteel Reaper -- 29695
	recipe = AddRecipe(29695, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23632, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Runic Hammer -- 29696
	recipe = AddRecipe(29696, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23633, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Fel Hardened Maul -- 29697
	recipe = AddRecipe(29697, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23634, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Eternium Runed Blade -- 29698
	recipe = AddRecipe(29698, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23635, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23554, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Dirge -- 29699
	recipe = AddRecipe(29699, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23636, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23555, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Hand of Eternity -- 29700
	recipe = AddRecipe(29700, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(23637, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23556, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Lesser Ward of Shielding -- 29728
	recipe = AddRecipe(29728, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(340, 340, 340, 345, 350)
	recipe:SetRecipeItem(23638, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(23575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(16583, 19373)

	-- Greater Ward of Shielding -- 29729
	recipe = AddRecipe(29729, V.TBC, Q.RARE)
	recipe:SetSkillLevels(375, 375, 375, 375, 375)
	recipe:SetRecipeItem(23639, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(23576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(18853)

	-- Lesser Rune of Warding -- 32284
	recipe = AddRecipe(32284, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(325, 325, 325, 330, 335)
	recipe:SetCraftedItem(23559, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Greater Rune of Warding -- 32285
	recipe = AddRecipe(32285, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(25526, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(25521, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Nether Chain Shirt -- 34529
	recipe = AddRecipe(34529, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(23563, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:Retire()

	-- Twisting Nether Chain Shirt -- 34530
	recipe = AddRecipe(34530, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(23564, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Breastplate of Kings -- 34533
	recipe = AddRecipe(34533, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28483, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Bulwark of Kings -- 34534
	recipe = AddRecipe(34534, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28484, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Fireguard -- 34535
	recipe = AddRecipe(34535, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28425, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Blazeguard -- 34537
	recipe = AddRecipe(34537, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28426, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Lionheart Blade -- 34538
	recipe = AddRecipe(34538, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28428, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Lionheart Champion -- 34540
	recipe = AddRecipe(34540, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28429, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- The Planar Edge -- 34541
	recipe = AddRecipe(34541, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28431, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Black Planar Edge -- 34542
	recipe = AddRecipe(34542, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28432, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Lunar Crescent -- 34543
	recipe = AddRecipe(34543, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28434, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Mooncleaver -- 34544
	recipe = AddRecipe(34544, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28435, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Drakefist Hammer -- 34545
	recipe = AddRecipe(34545, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28437, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Dragonmaw -- 34546
	recipe = AddRecipe(34546, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28438, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Thunder -- 34547
	recipe = AddRecipe(34547, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(28440, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Deep Thunder -- 34548
	recipe = AddRecipe(34548, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28441, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Fel Weightstone -- 34607
	recipe = AddRecipe(34607, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(300, 300, 300, 305, 310)
	recipe:SetCraftedItem(28420, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16583, 16724, 16823, 17245, 19341, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 33675, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Adamantite Weightstone -- 34608
	recipe = AddRecipe(34608, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 350, 355, 360)
	recipe:SetRecipeItem(28632, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(28421, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.HONORED, 17904)

	-- Earthforged Leggings -- 36122
	recipe = AddRecipe(36122, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30069, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Windforged Leggings -- 36124
	recipe = AddRecipe(36124, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30070, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Light Earthforged Blade -- 36125
	recipe = AddRecipe(36125, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30071, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Light Skyforged Axe -- 36126
	recipe = AddRecipe(36126, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30072, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Light Emberforged Hammer -- 36128
	recipe = AddRecipe(36128, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(260, 260, 280, 290, 300)
	recipe:SetCraftedItem(30073, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Heavy Earthforged Breastplate -- 36129
	recipe = AddRecipe(36129, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30074, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:Retire()

	-- Stormforged Hauberk -- 36130
	recipe = AddRecipe(36130, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30076, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Windforged Rapier -- 36131
	recipe = AddRecipe(36131, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30077, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Stoneforged Claymore -- 36133
	recipe = AddRecipe(36133, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30086, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Stormforged Axe -- 36134
	recipe = AddRecipe(36134, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30087, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Skyforged Great Axe -- 36135
	recipe = AddRecipe(36135, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30088, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Lavaforged Warhammer -- 36136
	recipe = AddRecipe(36136, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30089, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Great Earthforged Hammer -- 36137
	recipe = AddRecipe(36137, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(330, 330, 340, 350, 360)
	recipe:SetCraftedItem(30093, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Embrace of the Twisting Nether -- 36256
	recipe = AddRecipe(36256, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(23565, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Bulwark of the Ancient Kings -- 36257
	recipe = AddRecipe(36257, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28485, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Blazefury -- 36258
	recipe = AddRecipe(36258, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28427, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Lionheart Executioner -- 36259
	recipe = AddRecipe(36259, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28430, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Wicked Edge of the Planes -- 36260
	recipe = AddRecipe(36260, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28433, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Bloodmoon -- 36261
	recipe = AddRecipe(36261, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28436, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Dragonstrike -- 36262
	recipe = AddRecipe(36262, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28439, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:Retire()

	-- Stormherald -- 36263
	recipe = AddRecipe(36263, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetCraftedItem(28442, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Belt of the Guardian -- 36389
	recipe = AddRecipe(36389, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30321, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Red Belt of Battle -- 36390
	recipe = AddRecipe(36390, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30322, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Boots of the Protector -- 36391
	recipe = AddRecipe(36391, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30323, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(30033, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Red Havoc Boots -- 36392
	recipe = AddRecipe(36392, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(30324, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(30031, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK)
	recipe:AddWorldDrop(Z.SERPENTSHRINE_CAVERN, Z.TEMPEST_KEEP)

	-- Wildguard Breastplate -- 38473
	recipe = AddRecipe(38473, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31390, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31364, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.EXALTED, 17904)

	-- Wildguard Leggings -- 38475
	recipe = AddRecipe(38475, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31391, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31367, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

	-- Wildguard Helm -- 38476
	recipe = AddRecipe(38476, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31392, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31368, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.CENARION_EXPEDITION)
	recipe:AddRepVendor(FAC.CENARION_EXPEDITION, REP.REVERED, 17904)

	-- Iceguard Breastplate -- 38477
	recipe = AddRecipe(38477, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31393, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31369, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.VIOLETEYE)
	recipe:AddRepVendor(FAC.VIOLETEYE, REP.HONORED, 16388)

	-- Iceguard Leggings -- 38478
	recipe = AddRecipe(38478, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31394, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31370, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.VIOLETEYE)
	recipe:AddRepVendor(FAC.VIOLETEYE, REP.REVERED, 16388)

	-- Iceguard Helm -- 38479
	recipe = AddRecipe(38479, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(31395, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(31371, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.VIOLETEYE)
	recipe:AddRepVendor(FAC.VIOLETEYE, REP.HONORED, 16388)

	-- Shadesteel Sabots -- 40033
	recipe = AddRecipe(40033, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32441, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE, REP.HONORED, 23159)

	-- Shadesteel Bracers -- 40034
	recipe = AddRecipe(40034, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32442, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE, REP.FRIENDLY, 23159)

	-- Shadesteel Greaves -- 40035
	recipe = AddRecipe(40035, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32443, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32404, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE, REP.HONORED, 23159)

	-- Shadesteel Girdle -- 40036
	recipe = AddRecipe(40036, V.TBC, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32444, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32401, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.ASHTONGUE)
	recipe:AddRepVendor(FAC.ASHTONGUE, REP.FRIENDLY, 23159)

	-- Swiftsteel Bracers -- 41132
	recipe = AddRecipe(41132, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32736, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32568, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Swiftsteel Shoulders -- 41133
	recipe = AddRecipe(41133, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32737, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32570, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Dawnsteel Bracers -- 41134
	recipe = AddRecipe(41134, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32738, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(32571, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE)

	-- Dawnsteel Shoulders -- 41135
	recipe = AddRecipe(41135, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(375, 375, 385, 395, 405)
	recipe:SetRecipeItem(32739, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32573, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.BLACK_TEMPLE, Z.MOUNT_HYJAL)

	-- Ragesteel Shoulders -- 42662
	recipe = AddRecipe(42662, V.TBC, Q.RARE)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(33174, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33173, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(21050, 21059, 21060, 21061)

	-- Adamantite Weapon Chain -- 42688
	recipe = AddRecipe(42688, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(335, 335, 345, 350, 355)
	recipe:SetRecipeItem(35296, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(33185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddMobDrop(24664)

	-- Heavy Copper Longsword -- 43549
	recipe = AddRecipe(43549, V.TBC, Q.UNCOMMON)
	recipe:SetSkillLevels(35, 35, 75, 95, 115)
	recipe:SetRecipeItem(33792, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(33791, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.DPS)
	recipe:AddQuest(1578)

	-- Hammer of Righteous Might -- 43846
	recipe = AddRecipe(43846, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 385, 395)
	recipe:SetRecipeItem(33954, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(32854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.OUTLAND)

	-- Sunblessed Gauntlets -- 46140
	recipe = AddRecipe(46140, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34380, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Battlefists -- 46141
	recipe = AddRecipe(46141, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35209, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(34378, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Sunblessed Breastplate -- 46142
	recipe = AddRecipe(46142, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35210, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34379, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-- Hard Khorium Battleplate -- 46144
	recipe = AddRecipe(46144, V.TBC, Q.EPIC)
	recipe:SetSkillLevels(365, 365, 375, 392, 410)
	recipe:SetRecipeItem(35211, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(34377, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS)
	recipe:AddWorldDrop(Z.SUNWELL_PLATEAU)

	-------------------------------------------------------------------------------
	-- Wrath of the Lich King.
	-------------------------------------------------------------------------------
	-- Cobalt Legplates -- 52567
	recipe = AddRecipe(52567, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetCraftedItem(39086, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Belt -- 52568
	recipe = AddRecipe(52568, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(39087, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Boots -- 52569
	recipe = AddRecipe(52569, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 370, 380)
	recipe:SetCraftedItem(39088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Chestpiece -- 52570
	recipe = AddRecipe(52570, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(39085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Helm -- 52571
	recipe = AddRecipe(52571, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 375, 380, 385)
	recipe:SetCraftedItem(39084, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Shoulders -- 52572
	recipe = AddRecipe(52572, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetCraftedItem(39083, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Triangle Shield -- 54550
	recipe = AddRecipe(54550, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetCraftedItem(40668, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Belt -- 54551
	recipe = AddRecipe(54551, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(40669, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Boots -- 54552
	recipe = AddRecipe(54552, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(40671, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Breastplate -- 54553
	recipe = AddRecipe(54553, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(40672, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Legplates -- 54554
	recipe = AddRecipe(54554, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(40674, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Helm -- 54555
	recipe = AddRecipe(54555, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(40673, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Shoulders -- 54556
	recipe = AddRecipe(54556, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(40675, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Saronite Defender -- 54557
	recipe = AddRecipe(54557, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 395, 400, 405)
	recipe:SetCraftedItem(40670, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Helm -- 54917
	recipe = AddRecipe(54917, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(375, 375, 380, 385, 390)
	recipe:SetCraftedItem(40942, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Boots -- 54918
	recipe = AddRecipe(54918, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(380, 380, 385, 390, 395)
	recipe:SetCraftedItem(40949, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Shoulders -- 54941
	recipe = AddRecipe(54941, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 395, 400)
	recipe:SetCraftedItem(40950, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Chestpiece -- 54944
	recipe = AddRecipe(54944, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 395, 400)
	recipe:SetCraftedItem(40951, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Gauntlets -- 54945
	recipe = AddRecipe(54945, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 395, 400, 405)
	recipe:SetCraftedItem(40952, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Belt -- 54946
	recipe = AddRecipe(54946, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(40953, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Legplates -- 54947
	recipe = AddRecipe(54947, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(40943, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Cobalt Bracers -- 54948
	recipe = AddRecipe(54948, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(40954, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Horned Cobalt Helm -- 54949
	recipe = AddRecipe(54949, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(40955, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Reinforced Cobalt Shoulders -- 54978
	recipe = AddRecipe(54978, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 395, 400, 405)
	recipe:SetRecipeItem(41124, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40956, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(27333)

	-- Reinforced Cobalt Helm -- 54979
	recipe = AddRecipe(54979, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 405, 410, 415)
	recipe:SetRecipeItem(41123, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40957, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(26270)

	-- Reinforced Cobalt Legplates -- 54980
	recipe = AddRecipe(54980, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 410, 415, 420)
	recipe:SetRecipeItem(41120, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40958, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddMobDrop(29235)

	-- Reinforced Cobalt Chestpiece -- 54981
	recipe = AddRecipe(54981, V.WOTLK, Q.UNCOMMON)
	recipe:SetSkillLevels(375, 375, 415, 420, 425)
	recipe:SetRecipeItem(41122, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(40959, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(28123)

	-- Saronite Protector -- 55013
	recipe = AddRecipe(55013, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 395, 400, 405)
	recipe:SetCraftedItem(41117, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Saronite Bulwark -- 55014
	recipe = AddRecipe(55014, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(41113, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Gauntlets -- 55015
	recipe = AddRecipe(55015, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41114, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Saronite Bracers -- 55017
	recipe = AddRecipe(55017, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(41116, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Legplates -- 55055
	recipe = AddRecipe(55055, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(41126, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Gauntlets -- 55056
	recipe = AddRecipe(55056, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(41127, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Boots -- 55057
	recipe = AddRecipe(55057, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(41128, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Breastplate -- 55058
	recipe = AddRecipe(55058, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41129, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Honed Cobalt Cleaver -- 55174
	recipe = AddRecipe(55174, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 395, 400, 405)
	recipe:SetCraftedItem(41181, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Cobalt Slicer -- 55177
	recipe = AddRecipe(55177, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(41182, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Saronite Ambusher -- 55179
	recipe = AddRecipe(55179, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(41183, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Saronite Shiv -- 55181
	recipe = AddRecipe(55181, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(41184, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Furious Saronite Beatstick -- 55182
	recipe = AddRecipe(55182, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(41185, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Corroded Saronite Edge -- 55183
	recipe = AddRecipe(55183, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41186, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Corroded Saronite Woundbringer -- 55184
	recipe = AddRecipe(55184, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41187, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Saronite Mindcrusher -- 55185
	recipe = AddRecipe(55185, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41188, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Chestplate of Conquest -- 55186
	recipe = AddRecipe(55186, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41189, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Legplates of Conquest -- 55187
	recipe = AddRecipe(55187, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41190, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:Retire()

	-- Sturdy Cobalt Quickblade -- 55200
	recipe = AddRecipe(55200, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(380, 380, 385, 390, 395)
	recipe:SetCraftedItem(41239, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Tenderizer -- 55201
	recipe = AddRecipe(55201, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(380, 380, 385, 390, 395)
	recipe:SetCraftedItem(41240, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Forged Cobalt Claymore -- 55203
	recipe = AddRecipe(55203, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(385, 385, 390, 395, 400)
	recipe:SetCraftedItem(41242, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Notched Cobalt War Axe -- 55204
	recipe = AddRecipe(55204, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(390, 390, 395, 400, 405)
	recipe:SetCraftedItem(41243, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Deadly Saronite Dirk -- 55206
	recipe = AddRecipe(55206, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 415, 420, 425)
	recipe:SetCraftedItem(41245, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_THROWN")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Vengeance Bindings -- 55298
	recipe = AddRecipe(55298, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(41355, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Righteous Gauntlets -- 55300
	recipe = AddRecipe(55300, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41356, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Daunting Handguards -- 55301
	recipe = AddRecipe(55301, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41357, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Helm of Command -- 55302
	recipe = AddRecipe(55302, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41344, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Daunting Legplates -- 55303
	recipe = AddRecipe(55303, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41345, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Righteous Greaves -- 55304
	recipe = AddRecipe(55304, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41346, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Bracers -- 55305
	recipe = AddRecipe(55305, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(41354, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Pauldrons -- 55306
	recipe = AddRecipe(55306, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41351, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Waistguard -- 55307
	recipe = AddRecipe(55307, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41352, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Walkers -- 55308
	recipe = AddRecipe(55308, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41348, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Gauntlets -- 55309
	recipe = AddRecipe(55309, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(41349, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Legplates -- 55310
	recipe = AddRecipe(55310, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41347, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Hauberk -- 55311
	recipe = AddRecipe(55311, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41353, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Savage Saronite Skullshield -- 55312
	recipe = AddRecipe(55312, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(41350, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titansteel Destroyer -- 55369
	recipe = AddRecipe(55369, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41257, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titansteel Bonecrusher -- 55370
	recipe = AddRecipe(55370, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41383, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titansteel Guardian -- 55371
	recipe = AddRecipe(55371, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41384, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Titansteel Helm -- 55372
	recipe = AddRecipe(55372, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41386, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Titansteel Helm -- 55373
	recipe = AddRecipe(55373, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41387, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Titansteel Helm -- 55374
	recipe = AddRecipe(55374, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41388, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Spiked Titansteel Treads -- 55375
	recipe = AddRecipe(55375, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41391, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Tempered Titansteel Treads -- 55376
	recipe = AddRecipe(55376, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41392, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Titansteel Treads -- 55377
	recipe = AddRecipe(55377, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(41394, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Socket Bracer -- 55628
	recipe = AddRecipe(55628, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 400)
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Socket Gloves -- 55641
	recipe = AddRecipe(55641, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 400, 400, 400)
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Eternal Belt Buckle -- 55656
	recipe = AddRecipe(55656, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(41611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Bracers -- 55834
	recipe = AddRecipe(55834, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(360, 360, 370, 375, 380)
	recipe:SetCraftedItem(41974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Gauntlets -- 55835
	recipe = AddRecipe(55835, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(370, 370, 380, 385, 390)
	recipe:SetCraftedItem(41975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titanium Weapon Chain -- 55839
	recipe = AddRecipe(55839, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(41976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titansteel Shanker -- 56234
	recipe = AddRecipe(56234, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(42435, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cudgel of Saronite Justice -- 56280
	recipe = AddRecipe(56280, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(42443, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titanium Shield Spike -- 56357
	recipe = AddRecipe(56357, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(42500, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titansteel Shield Wall -- 56400
	recipe = AddRecipe(56400, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(42508, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Bracers -- 56549
	recipe = AddRecipe(56549, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 425, 430, 435)
	recipe:SetCraftedItem(42723, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Pauldrons -- 56550
	recipe = AddRecipe(56550, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(42727, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Waistguard -- 56551
	recipe = AddRecipe(56551, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(42729, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Walkers -- 56552
	recipe = AddRecipe(56552, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(42730, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Gauntlets -- 56553
	recipe = AddRecipe(56553, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(42724, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Legplates -- 56554
	recipe = AddRecipe(56554, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(42726, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Hauberk -- 56555
	recipe = AddRecipe(56555, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(42725, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ornate Saronite Skullshield -- 56556
	recipe = AddRecipe(56556, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(42728, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cobalt Skeleton Key -- 59405
	recipe = AddRecipe(59405, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(350, 350, 360, 365, 370)
	recipe:SetCraftedItem(43854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titanium Skeleton Key -- 59406
	recipe = AddRecipe(59406, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(430, 430, 435, 440, 445)
	recipe:SetCraftedItem(43853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Belt -- 59436
	recipe = AddRecipe(59436, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(395, 395, 400, 405, 410)
	recipe:SetCraftedItem(43860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Bracers -- 59438
	recipe = AddRecipe(59438, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 405, 410, 415)
	recipe:SetCraftedItem(43864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Pauldrons -- 59440
	recipe = AddRecipe(59440, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(405, 405, 410, 415, 420)
	recipe:SetCraftedItem(43865, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Brilliant Saronite Helm -- 59441
	recipe = AddRecipe(59441, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(415, 415, 420, 425, 430)
	recipe:SetCraftedItem(43870, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Saronite Spellblade -- 59442
	recipe = AddRecipe(59442, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(410, 410, 415, 420, 425)
	recipe:SetCraftedItem(43871, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Icebane Chestguard -- 61008
	recipe = AddRecipe(61008, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 435, 445, 455)
	recipe:SetCraftedItem(43586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Icebane Girdle -- 61009
	recipe = AddRecipe(61009, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(43587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Icebane Treads -- 61010
	recipe = AddRecipe(61010, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(420, 420, 430, 440, 450)
	recipe:SetCraftedItem(43588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Titanium Plating -- 62202
	recipe = AddRecipe(62202, V.WOTLK, Q.RARE)
	recipe:SetSkillLevels(450, 450, 455, 460, 465)
	recipe:SetRecipeItem(44937, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(44936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.TANK, F.WRATHCOMMON1)
	recipe:AddRepVendor(FAC.HORDE_EXPEDITION, REP.EXALTED, 32565, 32774)
	recipe:AddRepVendor(FAC.ALLIANCE_VANGUARD, REP.EXALTED, 32564, 32773)

	-- Titansteel Spellblade -- 63182
	recipe = AddRecipe(63182, V.WOTLK, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 460, 470)
	recipe:SetCraftedItem(45085, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddTrainer(514, 1241, 2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29505, 29506, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Belt of the Titans -- 63187
	recipe = AddRecipe(63187, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45088, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45088, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Battlelord's Plate Boots -- 63188
	recipe = AddRecipe(63188, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45089, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45089, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Plate Girdle of Righteousness -- 63189
	recipe = AddRecipe(63189, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45090, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45090, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Treads of Destiny -- 63190
	recipe = AddRecipe(63190, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45091, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45091, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Indestructible Plate Girdle -- 63191
	recipe = AddRecipe(63191, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45092, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45092, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Spiked Deathdealers -- 63192
	recipe = AddRecipe(63192, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(45093, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(45093, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.ULDUAR)

	-- Breastplate of the White Knight -- 67091
	recipe = AddRecipe(67091, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47622, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47591, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Saronite Swordbreakers -- 67092
	recipe = AddRecipe(67092, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47623, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47570, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.TANK, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Razorplate -- 67093
	recipe = AddRecipe(67093, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47624, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47589, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Spikeguards -- 67094
	recipe = AddRecipe(67094, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47625, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47572, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Breastplate -- 67095
	recipe = AddRecipe(67095, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47626, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47593, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Bracers -- 67096
	recipe = AddRecipe(67096, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47627, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47574, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Alliance")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Breastplate of the White Knight -- 67130
	recipe = AddRecipe(67130, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47640, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47592, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Saronite Swordbreakers -- 67131
	recipe = AddRecipe(67131, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47641, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47571, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.TANK, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Razorplate -- 67132
	recipe = AddRecipe(67132, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47644, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47590, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Titanium Spikeguards -- 67133
	recipe = AddRecipe(67133, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47645, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47573, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Breastplate -- 67134
	recipe = AddRecipe(67134, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 460, 467, 475)
	recipe:SetRecipeItem(47643, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47594, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Sunforged Bracers -- 67135
	recipe = AddRecipe(67135, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 455, 465, 475)
	recipe:SetRecipeItem(47642, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(47575, "BIND_ON_EQUIP")
	recipe:SetRequiredFaction("Horde")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.TRIAL_OF_THE_CRUSADER)
	recipe:AddCustom("NORMAL")

	-- Puresteel Legplates -- 70562
	recipe = AddRecipe(70562, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49969, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49902, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.REVERED, 37687)

	-- Protectors of Life -- 70563
	recipe = AddRecipe(70563, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49970, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49905, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.HONORED, 37687)

	-- Legplates of Painful Death -- 70565
	recipe = AddRecipe(70565, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49971, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49903, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.REVERED, 37687)

	-- Hellfrozen Bonegrinders -- 70566
	recipe = AddRecipe(70566, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49972, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49906, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.HONORED, 37687)

	-- Pillars of Might -- 70567
	recipe = AddRecipe(70567, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49973, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49904, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.REVERED, 37687)

	-- Boots of Kingly Upheaval -- 70568
	recipe = AddRecipe(70568, V.WOTLK, Q.EPIC)
	recipe:SetSkillLevels(450, 450, 475, 487, 500)
	recipe:SetRecipeItem(49974, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(49907, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER, F.ASHEN_VERDICT)
	recipe:AddRepVendor(FAC.ASHEN_VERDICT, REP.HONORED, 37687)

	-------------------------------------------------------------------------------
	-- Cataclysm.
	-------------------------------------------------------------------------------
	-- Folded Obsidium -- 76178
	recipe = AddRecipe(76178, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(425, 425, 450, 452, 455)
	recipe:SetCraftedItem(65365, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Bracers -- 76179
	recipe = AddRecipe(76179, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 460, 462, 465)
	recipe:SetCraftedItem(54850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Gauntlets -- 76180
	recipe = AddRecipe(76180, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetCraftedItem(54852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Belt -- 76181
	recipe = AddRecipe(76181, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(460, 460, 470, 475, 480)
	recipe:SetCraftedItem(54853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Boots -- 76182
	recipe = AddRecipe(76182, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(54854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Shoulders -- 76258
	recipe = AddRecipe(76258, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(54876, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Legguards -- 76259
	recipe = AddRecipe(76259, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(55022, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Helm -- 76260
	recipe = AddRecipe(76260, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(55023, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Breastplate -- 76261
	recipe = AddRecipe(76261, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(55024, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Bracers -- 76262
	recipe = AddRecipe(76262, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetCraftedItem(55025, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Gauntlets -- 76263
	recipe = AddRecipe(76263, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetCraftedItem(55026, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Belt -- 76264
	recipe = AddRecipe(76264, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(460, 460, 470, 475, 480)
	recipe:SetCraftedItem(55027, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Boots -- 76265
	recipe = AddRecipe(76265, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(55028, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Shoulders -- 76266
	recipe = AddRecipe(76266, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55029, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Legguards -- 76267
	recipe = AddRecipe(76267, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(55030, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Helm -- 76269
	recipe = AddRecipe(76269, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(55031, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Redsteel Breastplate -- 76270
	recipe = AddRecipe(76270, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(55032, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Bracers -- 76280
	recipe = AddRecipe(76280, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(440, 440, 450, 455, 460)
	recipe:SetCraftedItem(55033, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Gauntlets -- 76281
	recipe = AddRecipe(76281, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetCraftedItem(55034, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Belt -- 76283
	recipe = AddRecipe(76283, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(460, 460, 470, 475, 480)
	recipe:SetCraftedItem(55035, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Boots -- 76285
	recipe = AddRecipe(76285, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(55036, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Shoulders -- 76286
	recipe = AddRecipe(76286, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55037, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Legguards -- 76287
	recipe = AddRecipe(76287, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55038, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Helm -- 76288
	recipe = AddRecipe(76288, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(55039, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Breastplate -- 76289
	recipe = AddRecipe(76289, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(55040, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Hardened Obsidium Shield -- 76291
	recipe = AddRecipe(76291, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(450, 450, 460, 465, 470)
	recipe:SetCraftedItem(55041, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Stormforged Shield -- 76293
	recipe = AddRecipe(76293, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(55042, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Decapitator's Razor -- 76433
	recipe = AddRecipe(76433, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(460, 460, 470, 475, 480)
	recipe:SetCraftedItem(55043, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Cold-Forged Shank -- 76434
	recipe = AddRecipe(76434, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(55044, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Fire-Etched Dagger -- 76435
	recipe = AddRecipe(76435, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55045, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Lifeforce Hammer -- 76436
	recipe = AddRecipe(76436, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Obsidium Executioner -- 76437
	recipe = AddRecipe(76437, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(480, 480, 490, 495, 500)
	recipe:SetCraftedItem(55052, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Obsidium Skeleton Key -- 76438
	recipe = AddRecipe(76438, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(475, 475, 485, 490, 495)
	recipe:SetCraftedItem(55053, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ebonsteel Belt Buckle -- 76439
	recipe = AddRecipe(76439, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 525, 525, 525)
	recipe:SetRecipeItem(66100, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Pyrium Shield Spike -- 76440
	recipe = AddRecipe(76440, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 530, 535, 540)
	recipe:SetRecipeItem(66101, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Shield Spike -- 76441
	recipe = AddRecipe(76441, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(490, 490, 500, 505, 510)
	recipe:SetCraftedItem(55055, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Pyrium Weapon Chain -- 76442
	recipe = AddRecipe(76442, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 505, 510, 515)
	recipe:SetRecipeItem(66103, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Hardened Elementium Hauberk -- 76443
	recipe = AddRecipe(76443, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66104, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Hardened Elementium Girdle -- 76444
	recipe = AddRecipe(76444, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66105, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Deathplate -- 76445
	recipe = AddRecipe(76445, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66106, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Girdle of Pain -- 76446
	recipe = AddRecipe(76446, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66107, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Light Elementium Chestguard -- 76447
	recipe = AddRecipe(76447, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66108, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Light Elementium Belt -- 76448
	recipe = AddRecipe(76448, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66109, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Spellblade -- 76449
	recipe = AddRecipe(76449, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66110, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Hammer -- 76450
	recipe = AddRecipe(76450, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66111, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Poleaxe -- 76451
	recipe = AddRecipe(76451, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66112, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Bonesplitter -- 76452
	recipe = AddRecipe(76452, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(66113, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Shank -- 76453
	recipe = AddRecipe(76453, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66114, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Earthguard -- 76454
	recipe = AddRecipe(76454, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66115, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Elementium Stormshield -- 76455
	recipe = AddRecipe(76455, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(66116, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Bracers -- 76456
	recipe = AddRecipe(76456, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 512, 515)
	recipe:SetRecipeItem(66117, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Gauntlets -- 76457
	recipe = AddRecipe(76457, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(505, 505, 515, 517, 520)
	recipe:SetRecipeItem(66118, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Belt -- 76458
	recipe = AddRecipe(76458, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66119, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Boots -- 76459
	recipe = AddRecipe(76459, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 527, 530)
	recipe:SetRecipeItem(66120, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Shoulders -- 76461
	recipe = AddRecipe(76461, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 530, 532, 535)
	recipe:SetRecipeItem(66121, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Legguards -- 76462
	recipe = AddRecipe(76462, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66122, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Helm -- 76463
	recipe = AddRecipe(76463, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66123, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Pyrium Breastplate -- 76464
	recipe = AddRecipe(76464, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66124, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Bracers -- 76465
	recipe = AddRecipe(76465, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 512, 515)
	recipe:SetRecipeItem(66125, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Gauntlets -- 76466
	recipe = AddRecipe(76466, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(505, 505, 515, 517, 520)
	recipe:SetRecipeItem(66126, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Belt -- 76467
	recipe = AddRecipe(76467, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(510, 510, 520, 522, 525)
	recipe:SetRecipeItem(66127, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Boots -- 76468
	recipe = AddRecipe(76468, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 525, 527, 530)
	recipe:SetRecipeItem(66128, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Shoulders -- 76469
	recipe = AddRecipe(76469, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 530, 532, 535)
	recipe:SetRecipeItem(66129, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Legguards -- 76470
	recipe = AddRecipe(76470, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66130, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Helm -- 76471
	recipe = AddRecipe(76471, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66131, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Vicious Ornate Pyrium Breastplate -- 76472
	recipe = AddRecipe(76472, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 537, 540)
	recipe:SetRecipeItem(66132, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Obsidium Bladespear -- 76474
	recipe = AddRecipe(76474, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(470, 470, 480, 485, 490)
	recipe:SetCraftedItem(55246, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(514, 1241, 2998, 3136, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16669, 16724, 16823, 17245, 20124, 20125, 26564, 26904, 26981, 26988, 28694, 29505, 29506, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Elementium Gutslicer -- 94718
	recipe = AddRecipe(94718, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(515, 515, 515, 515, 525)
	recipe:SetRecipeItem(67603, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Forged Elementium Mindcrusher -- 94732
	recipe = AddRecipe(94732, V.CATA, Q.COMMON)
	recipe:SetSkillLevels(520, 520, 520, 520, 525)
	recipe:SetRecipeItem(67606, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddVendor(2999, 3356, 4259, 4597, 5512, 16670, 16713, 45549, 46359, 50375, 50382, 52641)

	-- Fists of Fury -- 99439
	recipe = AddRecipe(99439, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69957, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69936, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Eternal Elementium Handguards -- 99440
	recipe = AddRecipe(99440, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69958, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69937, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Holy Flame Gauntlets -- 99441
	recipe = AddRecipe(99441, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69959, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69938, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Warboots of Mighty Lords -- 99452
	recipe = AddRecipe(99452, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69968, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69946, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Mirrored Boots -- 99453
	recipe = AddRecipe(99453, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69969, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69947, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Emberforged Elementium Boots -- 99454
	recipe = AddRecipe(99454, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(69970, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(69948, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.FIRELANDS)

	-- Brainsplinter -- 99652
	recipe = AddRecipe(99652, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70166, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70155, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(53214)

	-- Masterwork Elementium Spellblade -- 99653
	recipe = AddRecipe(99653, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70167, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70156, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(53214)

	-- Lightforged Elementium Hammer -- 99654
	recipe = AddRecipe(99654, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70168, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70157, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(53214)

	-- Elementium-Edged Scalper -- 99655
	recipe = AddRecipe(99655, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70169, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70158, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(53214)

	-- Pyrium Spellward -- 99656
	recipe = AddRecipe(99656, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70170, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70162, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(53214)

	-- Unbreakable Guardian -- 99657
	recipe = AddRecipe(99657, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70171, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70163, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(53214)

	-- Masterwork Elementium Deathblade -- 99658
	recipe = AddRecipe(99658, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70172, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70164, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(53214)

	-- Witch-Hunter's Harvester -- 99660
	recipe = AddRecipe(99660, V.CATA, Q.RARE)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(70173, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(70165, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_POLEARM")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(53214)

	-- Pyrium Legplates of Purified Evil -- 101924
	recipe = AddRecipe(101924, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72001, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71982, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Unstoppable Destroyer's Legplates -- 101925
	recipe = AddRecipe(101925, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72012, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71983, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Foundations of Courage -- 101928
	recipe = AddRecipe(101928, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72013, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71984, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Soul Redeemer Bracers -- 101929
	recipe = AddRecipe(101929, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72014, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71991, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Bracers of Destructive Strength -- 101931
	recipe = AddRecipe(101931, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72015, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71992, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK, F.HEALER, F.CASTER)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-- Titanguard Wristplates -- 101932
	recipe = AddRecipe(101932, V.CATA, Q.EPIC)
	recipe:SetSkillLevels(525, 525, 525, 527, 530)
	recipe:SetRecipeItem(72016, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(71993, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddWorldDrop(Z.DRAGON_SOUL)

	-------------------------------------------------------------------------------
	-- Mists of Pandaria.
	-------------------------------------------------------------------------------
	-- Socket Bracer -- 113263
	recipe = AddRecipe(113263, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 410, 415, 420)
	recipe:SetPreviousRankID(55628)
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Socket Gloves -- 114112
	recipe = AddRecipe(114112, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(400, 400, 410, 415, 420)
	recipe:SetPreviousRankID(55641)
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 3174, 3355, 4258, 4888, 5164, 5511, 7230, 7231, 11146, 11177, 11178, 16724, 17245, 20124, 20125, 26564, 26904, 26952, 26981, 26988, 27034, 28694, 29924, 33591, 33609, 33631, 37072, 44781, 45548, 52640, 65114, 65129)

	-- Ghost-Forged Helm -- 122576
	recipe = AddRecipe(122576, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 560, 565, 570)
	recipe:SetCraftedItem(82903, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Shoulders -- 122577
	recipe = AddRecipe(122577, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetCraftedItem(82904, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Breastplate -- 122578
	recipe = AddRecipe(122578, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(550, 550, 560, 565, 570)
	recipe:SetCraftedItem(82905, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Gauntlets -- 122579
	recipe = AddRecipe(122579, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 540, 545)
	recipe:SetCraftedItem(82906, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Legplates -- 122580
	recipe = AddRecipe(122580, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(530, 530, 540, 545, 550)
	recipe:SetCraftedItem(82907, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Bracers -- 122581
	recipe = AddRecipe(122581, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetCraftedItem(82908, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Boots -- 122582
	recipe = AddRecipe(122582, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(530, 530, 540, 545, 550)
	recipe:SetCraftedItem(82909, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Belt -- 122583
	recipe = AddRecipe(122583, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(525, 525, 535, 540, 545)
	recipe:SetCraftedItem(82910, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Masterwork Spiritguard Helm -- 122592
	recipe = AddRecipe(122592, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84224, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Shoulders -- 122593
	recipe = AddRecipe(122593, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84227, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Breastplate -- 122594
	recipe = AddRecipe(122594, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84222, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Gauntlets -- 122595
	recipe = AddRecipe(122595, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84223, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Legplates -- 122596
	recipe = AddRecipe(122596, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84225, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Bracers -- 122597
	recipe = AddRecipe(122597, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84221, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Boots -- 122598
	recipe = AddRecipe(122598, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84220, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Belt -- 122599
	recipe = AddRecipe(122599, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84219, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Helm -- 122616
	recipe = AddRecipe(122616, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84163, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Shoulders -- 122617
	recipe = AddRecipe(122617, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84165, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Breastplate -- 122618
	recipe = AddRecipe(122618, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84161, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Gauntlets -- 122619
	recipe = AddRecipe(122619, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84162, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Legplates -- 122620
	recipe = AddRecipe(122620, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84164, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Bracers -- 122621
	recipe = AddRecipe(122621, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84160, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Boots -- 122622
	recipe = AddRecipe(122622, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84159, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Revenant Belt -- 122623
	recipe = AddRecipe(122623, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84158, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Helm -- 122624
	recipe = AddRecipe(122624, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84171, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Shoulders -- 122625
	recipe = AddRecipe(122625, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84173, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Breastplate -- 122626
	recipe = AddRecipe(122626, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84169, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Gauntlets -- 122627
	recipe = AddRecipe(122627, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84170, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Legplates -- 122628
	recipe = AddRecipe(122628, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84172, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Bracers -- 122629
	recipe = AddRecipe(122629, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84168, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Boots -- 122630
	recipe = AddRecipe(122630, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84167, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Contender's Spirit Belt -- 122631
	recipe = AddRecipe(122631, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 575, 575, 600)
	recipe:SetRecipeItem(84166, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Living Steel Belt Buckle -- 122632
	recipe = AddRecipe(122632, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(84196, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(90046, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Ghostly Skeleton Key -- 122633
	recipe = AddRecipe(122633, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 510, 515, 520)
	recipe:SetItemFilterType("BLACKSMITHING_SKELETON_KEY")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Lightsteel Shield -- 122635
	recipe = AddRecipe(122635, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 555, 560)
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Spiritguard Shield -- 122636
	recipe = AddRecipe(122636, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(545, 545, 555, 560, 565)
	recipe:SetCraftedItem(82962, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Forgewire Axe -- 122637
	recipe = AddRecipe(122637, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(545, 545, 555, 560, 565)
	recipe:SetCraftedItem(82963, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost-Forged Blade -- 122638
	recipe = AddRecipe(122638, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(545, 545, 555, 560, 565)
	recipe:SetCraftedItem(82964, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Phantasmal Hammer -- 122639
	recipe = AddRecipe(122639, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(560, 560, 570, 575, 580)
	recipe:SetCraftedItem(82965, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Spiritblade Decimator -- 122640
	recipe = AddRecipe(122640, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 575, 580, 585)
	recipe:SetCraftedItem(82966, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Ghost Shard -- 122641
	recipe = AddRecipe(122641, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(565, 565, 575, 580, 585)
	recipe:SetCraftedItem(82967, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(2998, 4258, 4888, 5164, 5511, 11146, 16724, 17245, 33591, 37072, 45548, 52640, 64058, 64085, 65114, 65129)

	-- Masterwork Lightsteel Shield -- 122642
	recipe = AddRecipe(122642, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84208, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82968, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Spiritguard Shield -- 122643
	recipe = AddRecipe(122643, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84226, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82969, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK)
	recipe:AddVendor(64058, 64085)

	-- Masterwork Forgewire Axe -- 122644
	recipe = AddRecipe(122644, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84197, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82970, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Masterwork Ghost-Forged Blade -- 122645
	recipe = AddRecipe(122645, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84200, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82971, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Masterwork Phantasmal Hammer -- 122646
	recipe = AddRecipe(122646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84217, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82972, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Masterwork Spiritblade Decimator -- 122647
	recipe = AddRecipe(122647, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84218, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Masterwork Ghost Shard -- 122648
	recipe = AddRecipe(122648, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(575, 575, 600, 602, 605)
	recipe:SetRecipeItem(84198, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82974, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_DAGGER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Ghost Reaver's Breastplate -- 122649
	recipe = AddRecipe(122649, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83787, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82975, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Ghost Reaver's Gauntlets -- 122650
	recipe = AddRecipe(122650, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83788, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82976, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Living Steel Breastplate -- 122651
	recipe = AddRecipe(122651, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83789, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82977, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Living Steel Gauntlets -- 122652
	recipe = AddRecipe(122652, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83790, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82978, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.HEALER, F.CASTER, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Breastplate of Ancient Steel -- 122653
	recipe = AddRecipe(122653, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83791, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82979, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Gauntlets of Ancient Steel -- 122654
	recipe = AddRecipe(122654, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetRecipeItem(83792, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(82980, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Unyielding Bloodplate -- 126850
	recipe = AddRecipe(126850, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87408, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87405, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.TANK)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Gauntlets of Battle Command -- 126851
	recipe = AddRecipe(126851, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87409, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87406, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Ornate Battleplate of the Master -- 126852
	recipe = AddRecipe(126852, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87410, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87402, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.TANK)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Bloodforged Warfists -- 126853
	recipe = AddRecipe(126853, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87411, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87407, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Chestplate of Limitless Faith -- 126854
	recipe = AddRecipe(126854, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87412, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Gauntlets of Unbound Devotion -- 126855
	recipe = AddRecipe(126855, V.MOP, Q.EPIC)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetRecipeItem(87413, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(87403, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.RAID, F.DPS, F.HEALER, F.CASTER)
	recipe:AddCustom("HEROIC")
	recipe:AddWorldDrop(Z.HEART_OF_FEAR, Z.MOGUSHAN_VAULTS, Z.TERRACE_OF_ENDLESS_SPRING)

	-- Ghost Iron Shield Spike -- 131928
	recipe = AddRecipe(131928, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 550, 557, 565)
	recipe:SetRecipeItem(90531, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86599, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Living Steel Weapon Chain -- 131929
	recipe = AddRecipe(131929, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(540, 540, 600, 602, 605)
	recipe:SetRecipeItem(90532, "BIND_ON_EQUIP")
	recipe:SetCraftedItem(86597, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ITEM_ENHANCEMENT")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.KLAXXI)
	recipe:AddRepVendor(FAC.KLAXXI, REP.HONORED, 64599)

	-- Haunted Steel Greaves -- 137766
	recipe = AddRecipe(137766, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94263, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Headcover -- 137767
	recipe = AddRecipe(137767, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94264, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Treads -- 137768
	recipe = AddRecipe(137768, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94265, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Greathelm -- 137769
	recipe = AddRecipe(137769, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94266, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Warboots -- 137770
	recipe = AddRecipe(137770, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94267, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Haunted Steel Headguard -- 137771
	recipe = AddRecipe(137771, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94268, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Gauntlets -- 137772
	recipe = AddRecipe(137772, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93528, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Helm -- 137773
	recipe = AddRecipe(137773, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93529, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Legguards -- 137774
	recipe = AddRecipe(137774, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93530, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Scaled Shoulders -- 137775
	recipe = AddRecipe(137775, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93531, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Clasp of Cruelty -- 137776
	recipe = AddRecipe(137776, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93532, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Clasp of Meditation -- 137777
	recipe = AddRecipe(137777, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93533, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Greaves of Alacrity -- 137778
	recipe = AddRecipe(137778, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93534, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Greaves of Meditation -- 137779
	recipe = AddRecipe(137779, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93535, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Bracers of Prowess -- 137780
	recipe = AddRecipe(137780, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93536, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Bracers of Meditation -- 137781
	recipe = AddRecipe(137781, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93537, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Chestguard -- 137782
	recipe = AddRecipe(137782, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93538, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Gloves -- 137783
	recipe = AddRecipe(137783, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93539, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Headcover -- 137784
	recipe = AddRecipe(137784, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93540, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Legplates -- 137785
	recipe = AddRecipe(137785, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Ornamented Spaulders -- 137786
	recipe = AddRecipe(137786, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93542, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Girdle of Accuracy -- 137787
	recipe = AddRecipe(137787, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93543, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Girdle of Prowess -- 137788
	recipe = AddRecipe(137788, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Warboots of Cruelty -- 137789
	recipe = AddRecipe(137789, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93545, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Warboots of Alacrity -- 137790
	recipe = AddRecipe(137790, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Armplates of Proficiency -- 137791
	recipe = AddRecipe(137791, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93547, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Armplates of Alacrity -- 137792
	recipe = AddRecipe(137792, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93546, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Chestpiece -- 137793
	recipe = AddRecipe(137793, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93620, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Gauntlets -- 137794
	recipe = AddRecipe(137794, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93621, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Helm -- 137795
	recipe = AddRecipe(137795, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93622, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Legguards -- 137796
	recipe = AddRecipe(137796, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93623, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Plate Shoulders -- 137797
	recipe = AddRecipe(137797, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 602, 605)
	recipe:SetCraftedItem(93544, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Lightning Steel Ingot -- 138646
	recipe = AddRecipe(138646, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94552, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94111, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddMobDrop(69461)

	-- The Planar Edge, Reborn -- 138876
	recipe = AddRecipe(138876, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94570, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94575, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Lunar Crescent, Reborn -- 138877
	recipe = AddRecipe(138877, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94569, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94576, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Black Planar Edge, Reborn -- 138878
	recipe = AddRecipe(138878, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94577, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Mooncleaver, Reborn -- 138879
	recipe = AddRecipe(138879, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94578, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Wicked Edge of the Planes, Reborn -- 138880
	recipe = AddRecipe(138880, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94579, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Bloodmoon, Reborn -- 138881
	recipe = AddRecipe(138881, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94580, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_AXE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Drakefist Hammer, Reborn -- 138882
	recipe = AddRecipe(138882, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94568, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94581, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.HEALER, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Thunder, Reborn -- 138883
	recipe = AddRecipe(138883, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94567, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94582, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Deep Thunder, Reborn -- 138884
	recipe = AddRecipe(138884, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94583, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Dragonmaw, Reborn -- 138885
	recipe = AddRecipe(138885, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94584, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Dragonstrike, Reborn -- 138886
	recipe = AddRecipe(138886, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94585, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Stormherald, Reborn -- 138887
	recipe = AddRecipe(138887, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94586, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_MACE")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Fireguard, Reborn -- 138888
	recipe = AddRecipe(138888, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94572, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94587, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Lionheart Blade, Reborn -- 138889
	recipe = AddRecipe(138889, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(500, 500, 605, 610, 615)
	recipe:SetRecipeItem(94571, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(94588, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DPS, F.TANK, F.CASTER)
	recipe:AddMobDrop(69461)

	-- Blazeguard, Reborn -- 138890
	recipe = AddRecipe(138890, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94589, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Lionheart Champion, Reborn -- 138891
	recipe = AddRecipe(138891, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94590, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Blazefury, Reborn -- 138892
	recipe = AddRecipe(138892, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94591, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_ONE_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Lionheart Executioner, Reborn -- 138893
	recipe = AddRecipe(138893, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(94592, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_TWO_HAND_SWORD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_WEAP_PANDARIA")

	-- Training Project: Ghost Iron Pins -- 139745
	recipe = AddRecipe(139745, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(1, 1, 11, 16, 21)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Simple Eating Utensils -- 139746
	recipe = AddRecipe(139746, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(21, 21, 31, 36, 41)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Wok -- 139747
	recipe = AddRecipe(139747, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(59, 59, 69, 74, 79)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Ladle -- 139748
	recipe = AddRecipe(139748, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(71, 71, 81, 86, 91)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Poker -- 139749
	recipe = AddRecipe(139749, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(86, 86, 96, 101, 106)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Hook -- 139750
	recipe = AddRecipe(139750, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(121, 121, 131, 136, 141)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Spatulas -- 139751
	recipe = AddRecipe(139751, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(136, 136, 146, 151, 156)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Decorative Spoons -- 139753
	recipe = AddRecipe(139753, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(151, 151, 161, 166, 171)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Spade -- 139754
	recipe = AddRecipe(139754, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(186, 186, 196, 201, 206)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Needles -- 139755
	recipe = AddRecipe(139755, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(199, 199, 209, 214, 219)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Barrel -- 139756
	recipe = AddRecipe(139756, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(206, 206, 216, 221, 226)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Saw -- 139757
	recipe = AddRecipe(139757, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(231, 231, 241, 246, 251)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Wire -- 139759
	recipe = AddRecipe(139759, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(248, 248, 258, 263, 268)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Pot -- 139760
	recipe = AddRecipe(139760, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(256, 256, 266, 271, 276)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Cups -- 139761
	recipe = AddRecipe(139761, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(289, 289, 299, 304, 309)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Bowls -- 139762
	recipe = AddRecipe(139762, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(299, 299, 309, 314, 319)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Bells -- 139763
	recipe = AddRecipe(139763, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(326, 326, 336, 341, 346)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Crate -- 139764
	recipe = AddRecipe(139764, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(347, 347, 357, 362, 367)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Picks -- 140165
	recipe = AddRecipe(140165, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(376, 376, 386, 391, 396)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Frames -- 140166
	recipe = AddRecipe(140166, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(421, 421, 431, 436, 441)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Pans -- 140167
	recipe = AddRecipe(140167, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(456, 456, 466, 471, 476)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Training Project: Ghost Iron Statue -- 140168
	recipe = AddRecipe(140168, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(486, 486, 496, 501, 506)
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddTrainer(64058, 64085)

	-- Crafted Dreadful Gladiator's Scaled Chestpiece -- 140841
	recipe = AddRecipe(140841, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93527, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Shoulders -- 140842
	recipe = AddRecipe(140842, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93457, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Legguards -- 140843
	recipe = AddRecipe(140843, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93456, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Helm -- 140844
	recipe = AddRecipe(140844, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93455, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Gauntlets -- 140845
	recipe = AddRecipe(140845, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93454, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Crafted Dreadful Gladiator's Dreadplate Chestpiece -- 140846
	recipe = AddRecipe(140846, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 605, 610, 615)
	recipe:SetCraftedItem(93453, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_PANDARIA")

	-- Blessed Trillium Greaves -- 142954
	recipe = AddRecipe(142954, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98602, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Protector's Trillium Legguards -- 142958
	recipe = AddRecipe(142958, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98606, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Avenger's Trillium Legplates -- 142959
	recipe = AddRecipe(142959, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98607, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Blessed Trillium Belt -- 142963
	recipe = AddRecipe(142963, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98611, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Protector's Trillium Waistguard -- 142967
	recipe = AddRecipe(142967, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98615, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Avenger's Trillium Waistplate -- 142968
	recipe = AddRecipe(142968, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 611, 618)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98616, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Chestpiece -- 143163
	recipe = AddRecipe(143163, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98784, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Gauntlets -- 143164
	recipe = AddRecipe(143164, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98785, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Helm -- 143165
	recipe = AddRecipe(143165, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98786, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Legguards -- 143166
	recipe = AddRecipe(143166, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98787, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Dreadplate Shoulders -- 143167
	recipe = AddRecipe(143167, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98788, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Chestpiece -- 143168
	recipe = AddRecipe(143168, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98843, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Gauntlets -- 143169
	recipe = AddRecipe(143169, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98844, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Helm -- 143170
	recipe = AddRecipe(143170, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98845, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Legguards -- 143171
	recipe = AddRecipe(143171, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98846, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Scaled Shoulders -- 143172
	recipe = AddRecipe(143172, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98847, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Clasp of Cruelty -- 143173
	recipe = AddRecipe(143173, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98848, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Clasp of Meditation -- 143174
	recipe = AddRecipe(143174, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98849, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Greaves of Alacrity -- 143175
	recipe = AddRecipe(143175, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98850, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Greaves of Meditation -- 143176
	recipe = AddRecipe(143176, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98851, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Bracers of Prowess -- 143177
	recipe = AddRecipe(143177, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98852, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Bracers of Meditation -- 143178
	recipe = AddRecipe(143178, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98853, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Chestguard -- 143179
	recipe = AddRecipe(143179, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98854, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Gloves -- 143180
	recipe = AddRecipe(143180, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98855, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Headcover -- 143181
	recipe = AddRecipe(143181, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98856, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Legplates -- 143182
	recipe = AddRecipe(143182, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98857, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Ornamented Spaulders -- 143183
	recipe = AddRecipe(143183, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98858, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.PALADIN)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Girdle of Accuracy -- 143184
	recipe = AddRecipe(143184, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98859, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Girdle of Prowess -- 143185
	recipe = AddRecipe(143185, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98860, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WAIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Warboots of Cruelty -- 143186
	recipe = AddRecipe(143186, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98861, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Warboots of Alacrity -- 143187
	recipe = AddRecipe(143187, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98862, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_FEET")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Armplates of Proficiency -- 143188
	recipe = AddRecipe(143188, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98863, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Armplates of Alacrity -- 143189
	recipe = AddRecipe(143189, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98864, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_WRIST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.DK, F.PALADIN, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Chestpiece -- 143190
	recipe = AddRecipe(143190, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98926, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_CHEST")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Gauntlets -- 143191
	recipe = AddRecipe(143191, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98927, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HANDS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Helm -- 143192
	recipe = AddRecipe(143192, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98928, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_HEAD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Legguards -- 143193
	recipe = AddRecipe(143193, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98929, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_LEGS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Plate Shoulders -- 143194
	recipe = AddRecipe(143194, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98930, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHOULDER")
	recipe:AddFilters(F.ALLIANCE, F.HORDE, F.WARRIOR)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Barrier -- 143195
	recipe = AddRecipe(143195, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98776, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Redoubt -- 143196
	recipe = AddRecipe(143196, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98810, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Crafted Malevolent Gladiator's Shield Wall -- 143197
	recipe = AddRecipe(143197, V.MOP, Q.COMMON)
	recipe:SetSkillLevels(600, 600, 600, 603, 606)
	recipe:SetCraftedItem(98920, "BIND_ON_EQUIP")
	recipe:SetItemFilterType("BLACKSMITHING_SHIELD")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	-- Balanced Trillium Ingot -- 143255
	recipe = AddRecipe(143255, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 610, 616)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98717, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddWorldDrop(Z.PANDARIA)

	-- Accelerated Balanced Trillium Ingot -- 146921
	recipe = AddRecipe(146921, V.MOP, Q.RARE)
	recipe:SetSkillLevels(600, 600, 605, 610, 616)
	recipe:SetRecipeItem(100865, "BIND_ON_PICKUP")
	recipe:SetCraftedItem(98717, "BIND_ON_PICKUP")
	recipe:SetItemFilterType("BLACKSMITHING_MATERIALS")
	recipe:AddFilters(F.ALLIANCE, F.HORDE)
	recipe:AddDiscovery("DISCOVERY_BS_INGOT_PANDARIA")

	self.InitBlacksmithing = nil
end
