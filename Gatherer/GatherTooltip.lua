--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.2 (<%codename%>)
	Revision: $Id: GatherTooltip.lua 989 2012-09-07 05:11:13Z Esamynn $

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

	Tooltip functions
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherTooltip.lua $", "$Rev: 989 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

setmetatable(Gatherer.Tooltip, {__index = getfenv(0)})
setfenv(1, Gatherer.Tooltip)

function AddDropRates( tooltip, nodeId, zone, maxDropsToShow )
	if not ( maxDropsToShow ) then maxDropsToShow = 5 end
	local total = Gatherer.DropRates.GetDropsTotal(nodeId)
	local ArchaeologyCurrencies = Gatherer.Constants.ArchaeologyCurrencies
	if ( total and (total > 0) ) then
		tooltip:AddLine(_tr("NOTE_OVERALLDROPS"))
		local numLeft = 0
		for i, item, count in Gatherer.DropRates.ObjectDrops(nodeId, zone, "DESC") do
			local itemName, itemLink, _
			if ( ArchaeologyCurrencies[item] ) then
				itemName, _, invTexture = GetCurrencyInfo(item)
				invTexture = "Interface\\Icons\\"..invTexture
				itemLink = "|cff00aa00["..itemName.."]|r"
			else
				itemName, itemLink, _, _, _, _, _, _, _, invTexture = GetItemInfo(item)
			end
			if ( itemName and (i <= maxDropsToShow) ) then
				tooltip:AddDoubleLine(itemLink, string.format("x%0.2f", count/total))
				tooltip:AddTexture(invTexture)
			else
				numLeft = numLeft + 1
			end
		end
		if ( numLeft > 0 ) then
			tooltip:AddLine(_tr("NOTE_ADDITIONAL", numLeft))
		end
	end
end


-- Hijack the game tooltips for ore and herb nodes so that we can add the
-- required skill level to the information displayed

local reqHERB = _trC("UNIT_SKINNABLE_HERB")
local reqMINE = _trC("UNIT_SKINNABLE_ROCK")

function Gatherer.GameTooltip_OnShow()

		if GameTooltip:NumLines() ~= 2 then return end

		local line = {}
		for n = 1, 2 do
		  local left = _G["GameTooltipTextLeft"..n]
		  local right = _G["GameTooltipTextRight"..n]
		  if not left or not left:IsShown() then return end
		  if right and right:IsShown() then return end
		  table.insert(line, left)
		end
		
		local profession;
		local requires = line[2]:GetText()
		if ( requires:find(reqHERB, 0, true) ) then
			profession = _trC("TRADE_HERBALISM")
		elseif ( requires:find(reqMINE, 0, true) ) then
			profession = _trC("TRADE_MINING")
		end
		if not profession then return end
		
		local nodeName = line[1]:GetText()
		local nodeID = Gatherer.Nodes.Names[nodeName]
		if not nodeID then return end
		
		local category = Gatherer.Categories.ObjectCategories[nodeID]
		if not category then return end
		
		local skill = Gatherer.Constants.SkillLevel[category]
		if not skill then return end
		
		line[2]:SetText(requires:gsub(profession, profession.." "..skill))
		GameTooltip:Show()

end

GameTooltip:HookScript("OnShow", Gatherer.GameTooltip_OnShow)


Tooltips = {}

-- custom tooltips
function GetTooltip( id )
	local tooltip
	if ( Tooltips[id] ) then
		tooltip = Tooltips[id]
	else
		tooltip = CreateFrame("GameTooltip", "GathererTooltip"..id, UIParent, "GathererTooltipTemplate")
		Tooltips[id] = tooltip
	end
	return tooltip
end

function HideTooltips()
	for k, tooltip in pairs(Tooltips) do
		tooltip:Hide()
	end
end

function SetClamps( numTooltips )
	if numTooltips <= 0 then return end
	local bottom, right = 0, 0
	local maxWidth = Tooltips[1]:GetWidth()
	for id = 2, numTooltips do
		bottom = bottom + Tooltips[id]:GetHeight()
		local myWidth = Tooltips[id]:GetWidth()
		if ( myWidth > maxWidth ) then
			right = right + myWidth - maxWidth
		end
	end
	Tooltips[1]:SetClampRectInsets(0,-right,0,-bottom)
	for i, tooltip in pairs(Tooltips) do
		if ( tooltip:IsShown() ) then
			tooltip:Show()
		end
	end
end