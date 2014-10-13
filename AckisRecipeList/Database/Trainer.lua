--[[
************************************************************************
Trainer.lua
************************************************************************
File date: 2014-05-26T11:42:13Z
File hash: ba6ae14
Project hash: 5b35dab
Project version: 3.0.5
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]] --

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name, true)

-----------------------------------------------------------------------
-- Imports.
-----------------------------------------------------------------------
local Z = private.ZONE_NAMES

function addon:AddTrainer(id_num, trainer_name, zone_name, coord_x, coord_y, faction)
	if _G.type(trainer_name) == "number" then
		private.AcquireTypes.Trainer:AddEntity(id_num, _G.GetSpellInfo(trainer_name), zone_name, coord_x, coord_y, faction).spell_id = trainer_name
	else
		private.AcquireTypes.Trainer:AddEntity(id_num, L[trainer_name], zone_name, coord_x, coord_y, faction)
	end
end

function addon:InitTrainer()
	addon:AddTrainer(45286, "KTC Train-a-Tron Deluxe", Z.THE_LOST_ISLES, 53.0, 35.6, "Horde")
	addon:AddTrainer(47384, "Lien Farner", Z.ELWYNN_FOREST, 41.95, 67.16, "Alliance")
	addon:AddTrainer(47396, "Wembil Taskwidget", Z.DUN_MOROGH, 53.8, 52.0, "Alliance")
	addon:AddTrainer(47400, "Nedric Sallow", Z.TIRISFAL_GLADES, 61.1, 51.1, "Horde")
	addon:AddTrainer(47418, "Runda", Z.DUROTAR, 52.8, 42.0, "Horde")
	addon:AddTrainer(47419, "Lalum Darkmane", Z.MULGORE, 46.4, 57.6, "Horde")
	addon:AddTrainer(47420, "Iranis Shadebloom", Z.TELDRASSIL, 56.0, 52.2, "Alliance")
	addon:AddTrainer(47431, "Valn", Z.AZUREMYST_ISLE, 48.7, 52.4, "Alliance")
	addon:AddTrainer(48619, "Therisa Sallow", Z.TELDRASSIL, 44.6, 53.1, "Horde")
	addon:AddTrainer(49885, "KTC Train-a-Tron Deluxe", Z.AZSHARA, 57.0, 50.6, "Horde")
	addon:AddTrainer(50247, "Jack \"All-Trades\" Derrington", Z.GILNEAS, 41.6, 37.6, "Alliance")
	addon:AddTrainer(57620, "Whittler Dewei", Z.THE_WANDERING_ISLE, 63., 41.4, "Neutral")
	addon:AddTrainer(65043, "Elder Oakpaw", Z.THE_WANDERING_ISLE, 50.6, 58.6, "Neutral")

	self.InitTrainer = nil
end
