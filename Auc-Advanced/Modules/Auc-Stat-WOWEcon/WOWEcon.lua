--[[
	Auctioneer - WoWEcon price statistics module
	Version: 7.7.6064 (SwimmingSeadragon)
	Revision: $Id: WOWEcon.lua 6064 2018-08-29 01:26:34Z none $
	URL: http://auctioneeraddon.com/

	This is an Auctioneer statistic module that returns a price based on
	any WoWEcon data you have.  You must have the WoWEcon addon installed
	for this statistic to have any affect.

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

-- WoWEcon was decommisioned in 2014
-- We shall wind down this module, with a view to eventually removing it

if not AucAdvanced then return end

local libType, libName = "Stat", "WOWEcon"
local lib,parent,private = AucAdvanced.NewModule(libType, libName)
if not lib then return end
local print,decode,_,_,replicate,empty,get,set,default,debugPrint,fill, _TRANS = AucAdvanced.GetModuleLocals()

local function CleanObsoleteSettings()
	-- We want to delete these obsolete settings where possible.
	-- However, we can only change them in the current profile
	set("stat.wowecon.useglobal", nil, true)
	set("stat.wowecon.enable", nil, true)
	set("stat.wowecon.sanitize", nil, true)
	set("stat.wowecon.tooltip", nil, true)
end

lib.Processors = {}
lib.Processors.configchanged = function(callbackType, fullsetting, value, settingname, settingmodule, settingbase)
	if settingbase == "profile" then
		CleanObsoleteSettings()
	end
end

function lib.OnLoad(addon)
	CleanObsoleteSettings()
end


AucAdvanced.RegisterRevision("$URL: Auc-Advanced/Modules/Auc-Stat-WOWEcon/WOWEcon.lua $", "$Rev: 6064 $")

--[[ The following localizer keys are now obsolete too:
		'WECN_Help_WhatGlobalPrices'
		'WECN_Help_WhatGlobalPricesAnswer'
		'WECN_Help_WhyGlobalPrices'
		'WECN_Help_WhyGlobalPricesAnswer'
		'WECN_Help_WoweconNoMatch'
		'WECN_Help_WoweconNoMatchAnswer'
		'WECN_Help_WhatSanitize'
		'WECN_Help_WhatSanitizeAnswer'
		'WECN_Help_WhyWOWEcon'
		'WECN_Help_WhyWOWEconAnswer'
		'WECN_Interface_WOWEconOptions'

		'WECN_Interface_EnableWOWEconStats'
		'WECN_HelpTooltip_EnableWOWEconStats'

		'WECN_Interface_AlwaysGlobalPrice'
		'WECN_HelpTooltip_AlwaysGlobalPrice'
		'WECN_Interface_SanitizeWOWEcon'
		'WECN_HelpTooltip_SanitizeWOWEcon'
		'WECN_Interface_ShowWOWEconTooltip'
		'WECN_HelpTooltip_ShowWOWEconTooltip'

		'WECN_Tooltip_PricesSeen'

		'WECN_Tooltip_ServerPrice'
		'WECN_Tooltip_GlobalPrice'
		'WECN_Tooltip_Individually'
		'WECN_Tooltip_GlobalSeen'
		'WECN_Tooltip_ServerSeen'
		'WECN_Tooltip_NeverSeen'
--]]