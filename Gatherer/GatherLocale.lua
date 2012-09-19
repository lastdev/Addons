--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.2 (<%codename%>)
	Revision: $Id: GatherLocale.lua 970 2012-09-03 00:18:31Z Esamynn $

	Localization routines

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
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherLocale.lua $", "$Rev: 970 $")

local Babylonian = LibStub("Babylonian")
assert(Babylonian, "Babylonian is not installed")
local babylonian = Babylonian(GathererLocalizations)

local metatable = { __index = getfenv(0) }
setmetatable( Gatherer.Locale, metatable )
setfenv(1, Gatherer.Locale)

SECTION_HIGHLIGHT_CODE = HIGHLIGHT_FONT_COLOR_CODE

function Tr(key, ...)
	local localization = babylonian[key] or key
	return Translate(localization, ...)
end
function TrClient(key)
	return babylonian(GetLocale(), key)
end
function TrLocale(key)
	return babylonian[key] or key
end

function Translate(localization, ...)
	if (not localization) then return "" end
	local newloc = ""

	for i = 1, select("#", ...) do
		local s, b, e
		s = 1 b = 1
		while (b > 0) do
			b,e = string.find(localization, "%"..i, s, true)
			if (b and b > 0) then
				local argv = select(i, ...) or ""
				if (type(argv) == "table") then argv = "TABLE" end
				newloc = newloc .. string.sub(localization, s, b-1) .. argv;
				s = e + 1
			else
				b = 0
			end
		end
		newloc = newloc .. string.sub(localization, s)
		localization = newloc
		newloc = ""
	end
	for highlightSection in localization:gmatch("%b{}") do
		local highlight = highlightSection:gsub("^{{(.+)}}$", SECTION_HIGHLIGHT_CODE.."%1".."|r")
		if ( highlight ~= highlightSection ) then
			local s, f = localization:find(highlightSection, 1, true)
			localization = localization:sub(1,s-1)..highlight..localization:sub(f+1)
		end
	end
	return localization
end

function GetText( token, ordinal )
	if ( ordinal and ordinal > 1 ) then
		token = token.."_P1"
	end
	return TrLocale(token)
end
