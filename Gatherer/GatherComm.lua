--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.4.1 (<%codename%>)
	Revision: $Id: GatherComm.lua 1106 2014-02-23 01:00:37Z Esamynn $

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
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_4.4.1/Gatherer/GatherComm.lua $", "$Rev: 1106 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local lib = Gatherer.Comm

function Gatherer.Comm.OnLoad()
	-- register prefixes
	RegisterAddonMessagePrefix("GathX")
	RegisterAddonMessagePrefix("Gatherer")
end

local sendOfferer
local acceptFrom = {}

local commVersion = 2

local lastHarvest = {}
function Gatherer.Comm.Send( objectId, gatherType, indoorNode, gatherZ, gatherX, gatherY, nodeIndex )
	if ( type(objectId) == "number" ) then
		local zoneToken = Gatherer.ZoneTokens.GetZoneToken(gatherZ)
		
		-- Check if this node has been just broadcast by us
		if not (lastHarvest and lastHarvest.z == zoneToken and lastHarvest.o == objectId and lastHarvest.i == nodeIndex) then
			-- Ok, so lets broadcast this node
			local guildAlert, raidAlert, raidType
			local sendMessage = strjoin(";", objectId, zoneToken, tostring(indoorNode and true or false), gatherX, gatherY)
			sendMessage = strjoin(":", commVersion, sendMessage)
			if Gatherer.Config.GetSetting("guild.enable") then
				if ( IsInGuild() ) then
					SendAddonMessage("GathX", sendMessage, "GUILD")
					if (Gatherer.Config.GetSetting("guild.print.send")) then guildAlert = true end
				end
			end
			if (Gatherer.Config.GetSetting("raid.enable")) then
				if GetNumGroupMembers() > 0 then
					raidType = "GROUP"
				end
				SendAddonMessage("GathX", sendMessage, "RAID")
				if (raidType and Gatherer.Config.GetSetting("raid.print.send")) then raidAlert = true end
			end
			
			if Gatherer.Config.GetSetting("personal.print") then
				local objName = Gatherer.Util.GetNodeName(objectId);
				Gatherer.Util.ChatPrint(_tr("NODE_ADD", objName))
			end
			if (guildAlert or raidAlert) then
				local objName = Gatherer.Util.GetNodeName(objectId);
				local whom
				if guildAlert then
					whom = "GUILD"
				else
					whom = raidType
				end
				if (guildAlert and raidAlert) then
					Gatherer.Util.ChatPrint(_tr("COMM_NODE_SEND_TWO", objName, _tr("GUILD"), _tr("GROUP")))
				else
					Gatherer.Util.ChatPrint(_tr("COMM_NODE_SEND", objName, _tr(whom)))
				end
			end
		end
		lastHarvest.z = zoneToken
		lastHarvest.o = objectId
		lastHarvest.i = nodeIndex
	end
end

function Gatherer.Comm.SendMsg( sendType, target, objectId, gatherType, indoorNode, gatherZ, gatherX, gatherY )
	local zoneToken = Gatherer.ZoneTokens.GetZoneToken(gatherZ)
	local sendMessage = strjoin(";", objectId, zoneToken, tostring(indoorNode and true or false), gatherX, gatherY)
	sendMessage = strjoin(":", commVersion, sendMessage)
	SendAddonMessage("GathX", sendMessage, sendType, target)
end

local lastMessage = ""
local playerNameFull = UnitName("player").."-"..((GetRealmName()):gsub(" ", ""))
function Gatherer.Comm.Receive( message, how, who )
	local setting = Gatherer.Config.GetSetting
	local msgtype = "raid"

	-- check if the player is on our sharing blacklist
	local blacklisted = Gatherer.Config.SharingBlacklist_IsPlayerIgnored(who)
	if ( blacklisted ) then
		return
	end

	if ( message ~= lastMessage and who ~= playerNameFull ) then
		if (how == "GUILD") then msgtype = "guild" end
		if (how == "WHISPER") then
			msgtype = "whisper"
			if not ( acceptFrom[who:lower()] ) then
				return
			end
		elseif ( not (setting(msgtype..".enable") and setting(msgtype..".receive")) ) then
			return
		end
		
		lastMessage = message
		local commVersion, data = strsplit(":", message, 2)
		commVersion = tonumber(commVersion)
		local objectID, zoneToken, gatherX, gatherY
		local indoorNode = false
		if ( commVersion == 2 ) then
			objectID, zoneToken, indoorNode, gatherX, gatherY = strsplit(";", data)
			objectID = tonumber(objectID)
			indoorNode = (indoorNode == "true" and true or false)
			gatherX = tonumber(gatherX)
			gatherY = tonumber(gatherY)
		elseif ( commVersion == 3 ) then
			objectID, zoneToken, indoorNode, gatherX, gatherY = strsplit(";", data)
			objectID = tonumber(objectID)
			indoorNode = (indoorNode == "true" and true or false)
			gatherX = tonumber(gatherX)
			gatherY = tonumber(gatherY)
		end
		local gatherType = Gatherer.Nodes.Objects[objectID]
		zoneToken = Gatherer.ZoneTokens.GetZoneToken(zoneToken)
		if ( objectID and gatherType and zoneToken and gatherX and gatherY ) then
			Gatherer.Storage.MassImportMode = (how == "WHISPER")
			Gatherer.Api.AddGather(objectID, gatherType, indoorNode, who, nil, nil, false, nil, zoneToken, gatherX, gatherY)
			Gatherer.Storage.MassImportMode = false
			local objName = Gatherer.Util.GetNodeName(objectID);
			if ( how == "WHISPER" ) then
				Gatherer.Report.SendFeedback(who, "RECV", objectID)
			elseif ( setting(msgtype..".print.recv") ) then
				local gatherC, gatherZ = Gatherer.ZoneTokens.GetContinentAndZone(zoneToken)
				local localizedZoneName = select(gatherZ, GetMapZones(gatherC))
				Gatherer.Util.ChatPrint(_tr("COMM_RECEIVE_NODE", objName, localizedZoneName, who, _tr(how)))
			end
		end
		
	end
end

StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"] = {
	text = _trL("MASS_SHARING_GATHERER_COMM_REQUESTSEND"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function()
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = 1
			Gatherer.Comm.SendFeedback("ACCEPT")
	end,
	OnCancel = function()
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = -2
			Gatherer.Comm.SendFeedback("REJECT")
	end,
	OnShow = function()
		StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = nil
	end,
	OnHide = function()
		if StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted == nil then
			Gatherer.Comm.SendFeedback("TIMEOUT")
			StaticPopupDialogs["GATHERER_COMM_REQUESTSEND"].accepted = -1
		end
	end,
	timeout = 60,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};

function Gatherer.Comm.SendFeedback(reply)
	SendAddonMessage("Gatherer", "SENDNODES:"..reply, "WHISPER", sendOfferer)
	Gatherer.Report.SendFeedback(sendOfferer, a)
	if (reply == "ACCEPT") then
		acceptFrom[sendOfferer:lower()] = true
		Gatherer.Report.SendFeedback(sendOfferer, "ACCEPTED")
	end
	if (reply ~= "PROMPT") then
		sendOfferer = nil
	end
end

function Gatherer.Comm.General( msg, how, who )
	if ( UnitName("player") == who ) then
		return
	end
	local cmd, a,b,c,d = strsplit(":", msg)
	if ( msg == "VER" ) then
		SendAddonMessage("Gatherer", "VER:"..Gatherer.Var.Version, how, who)
	elseif ( cmd == "SENDNODES" ) then
		-- check if the player is on our sharing blacklist
		local blacklisted = Gatherer.Config.SharingBlacklist_IsPlayerIgnored(who)
		if ( blacklisted ) then
			local tmp = sendOfferer
			sendOfferer = who
			Gatherer.Comm.SendFeedback("REJECT")
			sendOfferer = tmp
			return
		end
		if (Gatherer.Report.IsOpen()) then
			if (a == "OFFER") then
				local count = tonumber(b) or 0
				if (count > 0) then
					if (sendOfferer) then
						SendAddonMessage("Gatherer", "SENDNODES:BUSY", "WHISPER", who)
					else
						sendOfferer = who
						SendAddonMessage("Gatherer", "SENDNODES:PROMPT", "WHISPER", who)
						StaticPopup_Show("GATHERER_COMM_REQUESTSEND", who, count)
					end
				end
			elseif (a == "DONE") then
				if (acceptFrom[who:lower()]) then
					acceptFrom[who:lower()] = nil
					Gatherer.Report.SendFeedback(who, a)
					SendAddonMessage("Gatherer", "SENDNODES:COMPLETE", "WHISPER", who)
				end
			elseif (a == "PAUSE") then
				if (acceptFrom[who:lower()]) then
					SendAddonMessage("Gatherer", "SENDNODES:CONTINUE", "WHISPER", who)
				end
			elseif (a == "CONTINUE") then
				Gatherer.Report.SendFeedback(who, a)
			elseif (a == "ABORTED") then
				Gatherer.Report.SendFeedback(who, a)
			elseif (a == "COMPLETE") then
				Gatherer.Report.SendFeedback(who, a)
			end
		elseif (a == "OFFER") then
			SendAddonMessage("Gatherer", "SENDNODES:CLOSED", "WHISPER", who)
		end
		if (a == "PROMPT" or a == "ACCEPT" or a == "REJECT" or a == "BUSY" or a == "TIMEOUT") then
			Gatherer.Report.SendFeedback(who, a)
		end
	end
end
