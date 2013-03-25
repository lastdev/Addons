--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.2.0 (<%codename%>)
	Revision: $Id: ImportCTMapMod.lua 997 2012-09-11 03:14:32Z Esamynn $

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
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/Import/ImportCTMapMod.lua $", "$Rev: 997 $")

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

local module = {}
Gatherer.ImportModules["CT_MapMod"] = module

-- Module Courtesy of Pachelbel.
-- http://norganna.org/discuss/discussion/4096/ctmapmod-import
function module.ImportFunction()
   if (CT_UserMap_Notes) then
      Gatherer.Storage.MassImportMode = true
      for ctzone, ctdata in pairs(CT_UserMap_Notes) do
         for gatherC, zones in pairs(Gatherer.Util.ZoneNames) do
            local zoneIndex = zones[ctzone]
            if ( zoneIndex ) then
               local zoneToken = Gatherer.ZoneTokens.GetZoneToken(gatherC, zoneIndex)
               if ( zoneToken ) then
                  for _, ctnode in ipairs(ctdata) do
                     local name = ctnode["name"]
                     if ( name ) then
                        local objectID = Gatherer.Nodes.Names[name]
                        if ( objectID ) then
                           local gatherX = ctnode["x"]
                           local gatherY = ctnode["y"]
                           local gatherType = Gatherer.Nodes.Objects[objectID]
                           local gatherZ = Gatherer.ZoneTokens.GetZoneIndex(gatherC, zoneToken)
                           Gatherer.Api.AddGather(objectID, gatherType, "", "CT_MapMod", nil, nil, false, 
                                                                gatherC, gatherZ, gatherX, gatherY)
                        end
                     end
                  end
               end
               break
            end
         end
      end
	  Gatherer.Storage.MassImportMode = false
      Gatherer.Util.ChatPrint(_tr("IMPORT_CTMOD_DONE"))
   else
      Gatherer.Util.ChatPrint(_tr("IMPORT_CTMOD_NODATA"))
   end
end  

