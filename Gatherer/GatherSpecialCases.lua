--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.0.6 (<%codename%>)
	Revision: $Id: GatherSpecialCases.lua 894 2010-12-02 22:46:33Z Esamynn $

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
	
	Special Case Handling
	
	This file handles modifications that need to be made to various data tables
	throughout Gatherer that need to be "hacked up" in some fashion to handle
	Special Case nodes.
	
	THIS FILE SHOULD ALWAYS BE HEAVILY COMMENTED SO THAT IT IS EASY TO UNDERSTAND
	EXACTLY WHAT IS BEING DONE AND WHY!!!
]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/trunk/Gatherer/GatherSpecialCases.lua $", "$Rev: 894 $")

--[[
	Processing function that does the actual work.  This function nils itself
	out after running, to ensure that it can only ever be run once.  
]]
function Gatherer.SpecialCases.ProcessSpecialCases()
	
	
	-- nil out this function so that it cannot be called again
	Gatherer.SpecialCases.ProcessSpecialCases = nil
end
