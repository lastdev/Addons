--[[
************************************************************************
Reputation.lua
************************************************************************
<<<<<<< HEAD
File date: 2014-05-26T04:40:47Z
File hash: 92e273e
Project hash: 5b35dab
Project version: 3.0.5
=======
File date: 2014-02-14T05:23:40Z
File hash: 04922c6
Project hash: fbca907
Project version: 2.6.2
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local addon	= LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L		= LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

function addon:InitReputation()
	local function AddReputation(rep_id, name)
		private.AcquireTypes.Reputation:AddEntity(rep_id, _G.GetFactionInfoByID(rep_id))
	end

<<<<<<< HEAD
	AddReputation(59) -- Thorium Brotherhood
	AddReputation(270) -- Zandalar Tribe
	AddReputation(529) -- Argent Dawn
	AddReputation(576) -- Timbermaw Hold
	AddReputation(589) -- Wintersaber Trainers
	AddReputation(609) -- Cenarion Circle
	AddReputation(932) -- The Aldor
	AddReputation(933) -- The Consortium
	AddReputation(934) -- The Scryers
	AddReputation(935) -- The Sha'tar
	AddReputation(941) -- The Mag'har
	AddReputation(942) -- Cenarion Expedition
	AddReputation(946) -- Honor Hold
	AddReputation(947) -- Thrallmar
	AddReputation(967) -- The Violet Eye
	AddReputation(970) -- Sporeggar
	AddReputation(978) -- Kurenai
	AddReputation(989) -- Keepers of Time
	AddReputation(990) -- The Scale of the Sands
	AddReputation(1011) -- Lower City
	AddReputation(1012) -- Ashtongue Deathsworn
	AddReputation(1037) -- Alliance Vanguard
	AddReputation(1050) -- Valiance Expedition
	AddReputation(1052) -- Horde Expedition
	AddReputation(1064) -- The Taunka
	AddReputation(1067) -- The Hand of Vengeance
	AddReputation(1068) -- Explorers' League
	AddReputation(1073) -- The Kalu'ak
	AddReputation(1077) -- Shattered Sun Offensive
	AddReputation(1085) -- Warsong Offensive
	AddReputation(1090) -- Kirin Tor
	AddReputation(1091) -- The Wyrmrest Accord
	AddReputation(1094) -- The Silver Covenant
	AddReputation(1098) -- Knights of the Ebon Blade
	AddReputation(1104) -- Frenzyheart Tribe
	AddReputation(1105) -- The Oracles
	AddReputation(1106) -- Argent Crusade
	AddReputation(1119) -- The Sons of Hodir
	AddReputation(1124) -- The Sunreavers
	AddReputation(1135) -- The Earthen Ring
	AddReputation(1136) -- Tranquillien Conversion
	AddReputation(1156) -- The Ashen Verdict
	AddReputation(1158) -- Guardians of Hyjal
	AddReputation(1171) -- Therazane
	AddReputation(1172) -- Dragonmaw Clan
	AddReputation(1173) -- Ramkahen
	AddReputation(1174) -- Wildhammer Clan
	AddReputation(1177) -- Baradin's Wardens
	AddReputation(1178) -- Hellscream's Reach
	AddReputation(1216) -- Shang Xi's Academy
	AddReputation(1228) -- Forest Hozen
	AddReputation(1242) -- Pearlfin Jinyu
	AddReputation(1269) -- Golden Lotus
	AddReputation(1270) -- Shado-Pan
	AddReputation(1271) -- Order of the Cloud Serpent
	AddReputation(1272) -- The Tillers
	AddReputation(1273) -- Jogu the Drunk
	AddReputation(1275) -- Ella
	AddReputation(1276) -- Old Hillpaw
	AddReputation(1277) -- Chee Chee
	AddReputation(1278) -- Sho
	AddReputation(1279) -- Haohan Mudclaw
	AddReputation(1280) -- Tina Mudclaw
	AddReputation(1281) -- Gina Mudclaw
	AddReputation(1282) -- Fish Fellreed
	AddReputation(1283) -- Farmer Fung
	AddReputation(1302) -- The Anglers
	AddReputation(1337) -- The Klaxxi
	AddReputation(1341) -- The August Celestials
	AddReputation(1345) -- The Lorewalkers
	AddReputation(1351) -- The Brewmasters
	AddReputation(1352) -- Huojin Pandaren
	AddReputation(1353) -- Tushui Pandaren
	AddReputation(1358) -- Nat Pagle
	AddReputation(1359) -- The Black Prince
=======
	AddReputation(59)
	AddReputation(270)
	AddReputation(529)
	AddReputation(576)
	AddReputation(609)
	AddReputation(932)
	AddReputation(933)
	AddReputation(934)
	AddReputation(935)
	AddReputation(941)
	AddReputation(942)
	AddReputation(946)
	AddReputation(947)
	AddReputation(967)
	AddReputation(970)
	AddReputation(978)
	AddReputation(989)
	AddReputation(990)
	AddReputation(1011)
	AddReputation(1012)
	AddReputation(1037)
	AddReputation(1050)
	AddReputation(1052)
	AddReputation(1064)
	AddReputation(1067)
	AddReputation(1068)
	AddReputation(1073)
	AddReputation(1077)
	AddReputation(1085)
	AddReputation(1090)
	AddReputation(1091)
	AddReputation(1098)
	AddReputation(1104)
	AddReputation(1105)
	AddReputation(1106)
	AddReputation(1119)
	AddReputation(1156)
	AddReputation(1216)
	AddReputation(1228)
	AddReputation(1242)
	AddReputation(1269)
	AddReputation(1270)
	AddReputation(1271)
	AddReputation(1272)
	AddReputation(1273)
	AddReputation(1275)
	AddReputation(1276)
	AddReputation(1277)
	AddReputation(1278)
	AddReputation(1279)
	AddReputation(1280)
	AddReputation(1281)
	AddReputation(1282)
	AddReputation(1283)
	AddReputation(1302)
	AddReputation(1337)
	AddReputation(1341)
	AddReputation(1345)
	AddReputation(1351)
	AddReputation(1352)
	AddReputation(1353)
	AddReputation(1358)
	AddReputation(1359)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	self.InitReputation = nil
end
