--[[	*** LibCraftLevels ***
Written by : Thaoky, EU-Marécages de Zangar
September 21st, 2013

This library contains a database of craft levels.

Updated 18/08/2020 to store values as a table instead of bitwise.
--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibCraftLevels-1.0", 3
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

--	*** API ***

-- Returns the craft levels of a given spellID
function lib:GetCraftLevels(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		local grey = attrib.grey
		local green = attrib.green
		local yellow = attrib.yellow
		local orange = attrib.orange
		
		return orange, yellow, green, grey
	end
end

-- Returns the level at which a craft is learned
function lib:GetCraftLearnedAtLevel(spellID)
	local attrib = lib.dataSource[spellID]
	
	if attrib then
		return attrib.orange
	end
end

-- Sets the craft levels of a given spellID
function lib:SetCraftLevels(spellID, learnedAt, orange, yellow, green, grey)
	lib.dataSource[spellID] = {["grey"] = grey, ["green"] = green, ["yellow"] = yellow, ["orange"] = orange} 
end