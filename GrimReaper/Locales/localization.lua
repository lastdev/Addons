-- For translation purposes, the name "Grim Reaper" refers to the mythical agent of death. You know, big black robe, scythe and all that jazz.

local L = LibStub("AceLocale-3.0"):NewLocale("GrimReaper", "enUS", true)
if not L then return end

L["TITLE"]												= "Grim Reaper"
L["TITLECOLOUR"]										= "|cFFEFDFFFG|cFFA020E0rim |cFFEFDFFFR|cFFA020E0eaper"
L["LDBTITLE"]											= "GrimReaper"
L["HINT"]												= "|cffeda55fClick|r to hide/show Grim Reaper"
L["BINDING_REPORT"]										= "Report Selected"
L["BINDING_LOCK"]										= "Lock to Current"
L["BINDING_HOLD"]										= "Quick View"

-- General
L["CRUSHING"]											= "c"
L["NOINFO"]												= "No combat information"
L["LOCKED"]												= "Locked to %s"
L["Error: %s"]											= true

	-- Reporting
L["REPORTTITLE"]											= "<Grim Reaper> report for %s"
L["REPORTNOTHING"]										= "Nothing relevant to show for %s"
L["REPORT_NF"]											= ERR_GUILD_PLAYER_NOT_FOUND_S

-- Menu
L["Configuration"]										= true
L["Profile"]											= true
L["General Settings"]									= true
L["Display"]											= true
L["Display options"]									= true
L["Appearance"]											= true
L["Health Bars"]										= true
L["Show health bars"]									= true
L["Bars Inside"]										= true
L["Show health bars inside the frame"]					= true
L["Bars Left"]											= true
L["Show health bars on left of frame"] 					= true
L["Time"]												= true
L["Timestamp formatting"]								= true
L["None"]												= true
L["Don't show timestamps"]								= true
L["Full Time"]											= true
L["Displays full time stamps"]							= true
L["Delta Time"]											= true
L["Display time stamps as an offset from the most recent line"] = true
L["Delta Time Next"]									= true
L["Display time stamps as an offset from the next line"] = true
L["Width"]												= true
L["Adjust the width of the Grim Reaper"]				= true
L["Blizzard Colours"] 									= true
L["Use Blizzard magic school colours"]					= true
L["Include"]											= true
L["What to show in the list"] 							= true
L["Buff Gains/Losses"] 									= true
L["Display buff gains and losses"] 						= true
L["Debuff Gains/Losses"] 								= true
L["Display debuff gains and losses"] 					= true
L["Lock"] 												= true
L["Lock to the current unit"] 							= true
L["Hide"] 												= true
L["Hide the grim reaper, but keep it active. You can also do this by clicking on the Grim Reaper icon"] = true
L["Docking"] 											= true
L["Docking options"] 									= true
L["Enable"] 											= true
L["Enable docking to the game's default tooltip"]	 	= true
L["Dock Point"]											= true
L["TOPLEFT"]											= "Top-Left"
L["TOPRIGHT"]											= "Top-Right"
L["BOTTOMLEFT"]											= "Bottom-Left"
L["BOTTOMRIGHT"]										= "Bottom-Right"
L["Lines"] 												= true
L["How many lines to show"] 							= true
L["Scale"] 												= true
L["Adjust the scale of the Grim Reaper"]				= true
L["Report"]												= true
L["Report options"]										= true
L["Shown"]												= true
L["Self"]												= true
L["Heal"]												= true
L["Bar Texture"]										= true
L["Set the texture for the buff timer bars"]			= true
L["Hover"]												= true
L["Hover options for expanding information on the reaper lines"] = true
L["Channel"]											= true
L["Channel output options"]								= true
L["Buff Tips"]											= true
L["Display buff tooltips detailing any buffs used on this line"] = true
L["Debuff Tips"]										= true
L["Display debuff tooltips detailing any debuffs used on this line"] = true
L["Log"]												= true
L["Show this player's combat log"]						= true
L["Both"]												= true
L["Show this player's combat log for all events"]		= true
L["Incoming"]											= true
L["Show this player's combat log for incoming events"]	= true
L["Outgoing"]											= true
L["Show this player's combat log for outgoing events"]	= true
L["Casts on player"]									= true
L["Display spells cast on player"]						= true
L["Cures & Steals"]										= true
L["Show when player is cured or has buff stolen"]		= true
L["Time Format"]										= true
L["Adjust the time format (Default: %X)"]				= true
L["<format>\r%X = HH:MM:SS\r%H = HH, %M = MM, %S = SS\reg: %M:%S"] = true
L["Select the player to view, then release the hold key"] = true
L["Press the Hold key once more to hide Grim Reaper"]	= true
L["Filter ID: %d (%s)"]									= true
L["Filter %s from helpful spells (By ID)"]				= true
L["Filter Name: %s"]									= true
L["Filter %s from helpful spells (By Name)"]			= true
L["Reset Filters"]										= true
L["This will remove all custom spell filters."]			= true
L["Grow Direction"]										= true
L["Set the grow direction"]								= true
L["Auto"]												= true
L["Up"]													= true
L["Down"]												= true
