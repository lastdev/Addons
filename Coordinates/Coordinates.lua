-- Coordinates
-- By Szandos

--Variables
local Coordinates_UpdateInterval = 0.2
local timeSinceLastUpdate = 0
local color = "|cff00ffff"
local fontStyle = "Fonts\\FRIZQT__.TTF"
local fontOutline = "OUTLINE"

-------------------------------------------------------------------------------

-- Need a frame for events
local Coordinates_eventFrame = CreateFrame("Frame")
Coordinates_eventFrame:RegisterEvent("VARIABLES_LOADED")
Coordinates_eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Coordinates_eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
Coordinates_eventFrame:RegisterEvent("ZONE_CHANGED")
Coordinates_eventFrame:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)

-- Andtext for the world map
Coordinates_worldMapText = WorldMapButton:CreateFontString()
Coordinates_worldMapText:SetTextColor(1, 0.82, 0)
Coordinates_worldMapText:SetPoint("BOTTOM", WorldMapButton, "BOTTOM", 0, 3)

-- Create slash command
SLASH_COORDINATES1 = "/coordinates"
SLASH_COORDINATES2 = "/coord"

-- Handle slash commands
function SlashCmdList.COORDINATES(msg)
	msg = string.lower(msg)
	local command, rest = msg:match("^(%S*)%s*(.-)$")
	if (command == "worldmap" or command =="w") then
		if CoordinatesDB["worldmap"] == true then 
			CoordinatesDB["worldmap"] = false
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: World map coordinates disabled")
		else
			CoordinatesDB["worldmap"] = true
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: World map coordinates enabled")
		end
	elseif (command == "minimap" or command =="m") then
		if CoordinatesDB["minimap"] == true then 
			CoordinatesDB["minimap"] = false
			MinimapZoneText:SetText( GetMinimapZoneText() )
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: Mini map coordinates disabled")
		else
			CoordinatesDB["minimap"] = true
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: Mini map coordinates enabled")
		end
	elseif (command == "size" or command =="fontsize") then
		rest = tonumber(rest)
		if rest then
			CoordinatesDB["fontSize"] = rest
			local scale = WorldMapDetailFrame:GetEffectiveScale()
			local scaledFontSize = CoordinatesDB["fontSize"] / scale
			Coordinates_worldMapText:SetFont(fontStyle, scaledFontSize, fontOutline)
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: Font size set to "..CoordinatesDB["fontSize"])
		else
			DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates: Invalid font size")
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(color.."Coordinates by Szandos")
		DEFAULT_CHAT_FRAME:AddMessage(color.."Version: "..GetAddOnMetadata("Coordinates", "Version"))
		DEFAULT_CHAT_FRAME:AddMessage(color.."Usage:")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/coordinates worldmap - Enable/disable coordinates on the world map")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/coordinates minimap - Enable/disable coordinates on the mini map")
		DEFAULT_CHAT_FRAME:AddMessage(color.."/coordinates fontsize <size> - Sets the size of the world map font")
	end
end

--Event handler
function Coordinates_eventFrame:VARIABLES_LOADED()
	if (not CoordinatesDB) then
		CoordinatesDB = {}
		CoordinatesDB["worldmap"] = true
		CoordinatesDB["minimap"] = true
		CoordinatesDB["fontSize"] = 12
	elseif not CoordinatesDB["fontSize"] then
		CoordinatesDB["fontSize"] = 12
	end
	Coordinates_eventFrame:SetScript("OnUpdate", function(self, elapsed) Coordinates_OnUpdate(self, elapsed) end)
end

function Coordinates_eventFrame:ZONE_CHANGED_NEW_AREA()
	Coordinates_UpdateCoordinates()
end

function Coordinates_eventFrame:ZONE_CHANGED_INDOORS()
	Coordinates_UpdateCoordinates()
end

function Coordinates_eventFrame:ZONE_CHANGED()
	Coordinates_UpdateCoordinates()
end

--OnUpdate
function Coordinates_OnUpdate(self, elapsed)
	timeSinceLastUpdate = timeSinceLastUpdate + elapsed
	if (timeSinceLastUpdate > Coordinates_UpdateInterval) then
		-- Update the update time
		timeSinceLastUpdate = 0
		Coordinates_UpdateCoordinates()
	end
end

function Coordinates_UpdateCoordinates()
	--MinimapCoordinates
	if (CoordinatesDB["minimap"] and Minimap:IsVisible()) then
		local px, py = GetPlayerMapPosition("player")
		if ( px ~= 0 and py ~= 0 ) then
			MinimapZoneText:SetText( format("(%d:%d) ",px*100.0,py*100.0) .. GetMinimapZoneText() );
		end
	end

	--WorldMapCoordinates
 	if (CoordinatesDB["worldmap"] and WorldMapFrame:IsVisible()) then
 		-- Get the cursor's coordinates
 		local cursorX, cursorY = GetCursorPosition()
		
		-- Map calculations
 		local scale = WorldMapDetailFrame:GetEffectiveScale()
 		cursorX = cursorX / scale
 		cursorY = cursorY / scale
 		local width = WorldMapDetailFrame:GetWidth()
 		local height = WorldMapDetailFrame:GetHeight()
		local left = WorldMapDetailFrame:GetLeft()
		local top = WorldMapDetailFrame:GetTop()
		cursorX = (cursorX - left) / width * 100
		cursorY = (top - cursorY) / height * 100
 		local worldmapCoordsText = "Cursor(X,Y): "..format("%.1f , %.1f |", cursorX, cursorY)
		
		-- Player position
		local px, py = GetPlayerMapPosition("player")
 		if ( px == 0 and py == 0 ) then
 			worldmapCoordsText = worldmapCoordsText.." Player(X,Y): n/a"
 		else
 			worldmapCoordsText = worldmapCoordsText.." Player(X,Y): "..format("%.1f , %.1f", px * 100, py * 100)
 		end
		
		-- Add text to world map
		local scaledFontSize = CoordinatesDB["fontSize"] / scale
		Coordinates_worldMapText:SetFont(fontStyle, scaledFontSize, fontOutline)
		Coordinates_worldMapText:SetText(worldmapCoordsText)
	end
	if ((not CoordinatesDB["worldmap"]) and WorldMapFrame:IsVisible()) then
		Coordinates_worldMapText:SetFont(fontStyle, CoordinatesDB["fontSize"], fontOutline)
		Coordinates_worldMapText:SetText("")
	end
end