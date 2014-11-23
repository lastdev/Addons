--[[
	Auctioneer
	Version: 5.21c.5521 (SanctimoniousSwamprat)
	Revision: $Id: CoreResources.lua 5285 2012-04-17 15:45:55Z brykrys $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]

--[[
	Dynamic Resource support module

	Maintain a table of commonly used values that may change during play,
	for use in a similar manner to the Const table.
	Other modules or AddOns may read from the Resources table at any time, but must not modify it!

	Includes:
	Status flags for AuctionHouse, Mailbox
	Faction information
	Pre-formed serverKeys

	Additionally, Processor event messages will be generated when certain values change
--]]

local AucAdvanced = AucAdvanced
if not AucAdvanced then return end

local coremodule, internal = AucAdvanced.GetCoreModule("CoreResources")
if not (coremodule and internal) then return end
local Const = AucAdvanced.Const

-- internal constants
local PLAYER_REALM = Const.PlayerRealm
local CUT_HOME = 0.05

-- internal variables
local EventFrame


--[[ Install AucAdvanced.Resources table ]]--
local lib = {
	Active = false,
	AuctionHouseOpen = false,
	MailboxOpen = false,
}
AucAdvanced.Resources = lib


--[[ Faction handlers ]]--

local function SetFaction()
	local playerFaction = UnitFactionGroup("player")
	local opposingFaction
	if playerFaction == "Alliance" then
		opposingFaction = "Horde"
	elseif playerFaction == "Horde" then
		opposingFaction = "Alliance"
	else
		playerFaction = "Neutral" -- just in case it was nil
		opposingFaction = "Neutral"
	end

	lib.PlayerFaction = playerFaction
	lib.ServerKeyHome = PLAYER_REALM.."-"..playerFaction
	lib.OpposingFaction = opposingFaction
	lib.ServerKeyOpposing = PLAYER_REALM.."-"..opposingFaction

	lib.CurrentFaction = lib.PlayerFaction
	lib.ServerKeyCurrent = lib.ServerKeyHome

	if playerFaction == "Alliance" or playerFaction == "Horde" then
		SetFaction = nil
	end
end
SetFaction()
-- really constants, but included in Resources along with other serverKey values:
lib.ServerKeyNeutral = PLAYER_REALM.."-Neutral"
lib.AHCutRate = CUT_HOME
lib.AHCutAdjust = 1 - CUT_HOME

-- special handling for Pandaren characters, for the moment they choose their faction
local function OnFactionSelect()
	OnFactionSelect = nil
	EventFrame:UnregisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	if SetFaction then
		SetFaction()
		-- issue serverkey message for compatibility
		AucAdvanced.SendProcessorMessage("serverkey", lib.ServerKeyCurrent)
	end
	AucAdvanced.SendProcessorMessage("factionselect", lib.PlayerFaction)
end

--[[ Event handlers and other entry points ]]--
local function OnEvent(self, event, ...)
	if event == "AUCTION_HOUSE_SHOW" then
		lib.AuctionHouseOpen = true
		AucAdvanced.Scan.LoadScanData()
		AucAdvanced.SendProcessorMessage("auctionopen")
	elseif event == "AUCTION_HOUSE_CLOSED" then
		-- AUCTION_HOUSE_CLOSED usually fires twice; only send message for the first one
		if lib.AuctionHouseOpen then
			lib.AuctionHouseOpen = false
			AucAdvanced.SendProcessorMessage("auctionclose")
			internal.Scan.AHClosed()
		end
	elseif event == "MAIL_SHOW" then
		lib.MailboxOpen = true
		AucAdvanced.SendProcessorMessage("mailopen")
	elseif event == "MAIL_CLOSED" then
		-- MAIL_CLOSED usually fires twice; only send message for the first one
		if lib.MailboxOpen then
			lib.MailboxOpen = false
			AucAdvanced.SendProcessorMessage("mailclose")
		end
	elseif event == "NEUTRAL_FACTION_SELECT_RESULT" then
		-- triggered when a neutral Pandaren character chooses a Faction
		OnFactionSelect()
	end
end

internal.Resources = {
	-- Activate: called by CoreMain near the end of the load process
	-- (expected to be during PLAYER_ENTERING_WORLD or later)
	Activate = function()
		internal.Resources.Activate = nil -- only run once
		lib.Active = true

		-- Setup Event handler
		EventFrame = CreateFrame("Frame")
		EventFrame:SetScript("OnEvent", OnEvent)
		EventFrame:RegisterEvent("AUCTION_HOUSE_SHOW")
		EventFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
		EventFrame:RegisterEvent("MAIL_SHOW")
		EventFrame:RegisterEvent("MAIL_CLOSED")

		-- Set faction info
		if SetFaction then
			SetFaction()
		end
		if SetFaction then
			-- player is Neutral faction; register to detect when they choose a faction
			EventFrame:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
		else
			OnFactionSelect = nil
		end

		-- issue serverkey message for compatibility
		AucAdvanced.SendProcessorMessage("serverkey", lib.ServerKeyCurrent)
	end,

	-- SetResource: permits other Core files to set a resource
	-- Other Cores/Modules must never modify AucAdvanced.Resources directly (or I may make it a read-only table in future!)
	SetResource = function(key, value)
		lib.key = value
	end
}
