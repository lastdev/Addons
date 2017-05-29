local addon, DRTS = ...
local arrowAvailable, arrowTextAvailable = false, false

local UnitPosition, IsQuestFlaggedCompleted = UnitPosition, IsQuestFlaggedCompleted
local GetCurrentMapDungeonLevel, GetCurrentMapZone, GetCurrentMapAreaID, GetAreaMapInfo, GetPOITextureCoords = GetCurrentMapDungeonLevel, GetCurrentMapZone, GetCurrentMapAreaID, GetAreaMapInfo, GetPOITextureCoords
local abs, format, select, pairs = math.abs, format, select, pairs

if not DRTSOptions then
    DRTSOptions = {
        enabled = true,
        debug = false,
        arrowEnabled = true,
        ignoretm = false,
        minimap = true,
        hidden = { },
    }
end

local TreasureContinentsIds = {
    [1116] = 13, -- Draenor
    [1152] = 13, -- Garrison Level 1 (H)
    [1330] = 13, -- Garrison Level 2 (H)
    [1153] = 13, -- Garrison Level 3 (H)
    [1158] = 13, -- Garrison Level 1 (A)
    [1331] = 13, -- Garrison Level 2 (A)
    [1159] = 13, -- Garrison Level 3 (A)
    [1464] = 13, -- Tanaan Jungle
    [1220] = 14, -- Broken Isles
}

local TreasureQuestsDesc = {
    [36466] = "Talador",
    [36467] = "Spires of Arak",
    [36465] = "Gorgrond",
    [34557] = "Frostfire",
    [36468] = "Nagrand",
    [36464] = "Shadowmoon Valley",
    [36249] = "requires Lumber Yard",
    [36250] = "requires Lumber Yard",
    [36251] = "requires Sparring Arena",
    [36252] = "requires Sparring Arena",
    [39463] = "Tanaan Jungle",
}

local frame = CreateFrame("Frame")

local function GetDistanceToPoint(pointx, pointy, x, y)
    local dX = pointx - x
    local dY = pointy - y
    return (dX * dX + dY * dY) ^ 0.5
end

local function SelectQuest(treasure, type)
    if treasure.flags == 131073 then
        if type == "map" then
            return treasure.quests[1]
        elseif type == "complete" then
            return treasure.quests[2]
        else
            --print("Unknown type "..type.. " for flags 131073")
            return 0
        end
    elseif treasure.flags == 65541 then
        if type == "map" then
            return treasure.quests[2]
        elseif type == "complete" then
            return treasure.quests[1]
        else
            --print("Unknown type "..type.. " for flags 65541")
            return 0
        end
    elseif treasure.flags == 65537 then
        if type == "map" then
            return treasure.quests[2]
        elseif type == "complete" then
            return treasure.quests[1]
        else
            --print("Unknown type "..type.. " for flags 65537")
            return 0
        end
    elseif treasure.flags == 524310 then
        if type == "choise1" then
            return treasure.quests[1]
        elseif type == "choise2" then
            return treasure.quests[2]
        elseif type == "map" then
            return treasure.quests[3]
        elseif type == "complete" then
            return treasure.quests[4]
        else
            --print("Unknown type "..type.. " for flags 524310")
            return 0
        end
    elseif treasure.flags == 0 then
        --print("Treasure "..treasure.id.." has 0 flags")
        return 0
    else
        --print("Unknown flags "..treasure.flags)
        return 0
    end
end

local function GetTreasureCompletion(treasure)
    local trquest, tmquest, c1quest, c2quest = SelectQuest(treasure, "complete"), SelectQuest(treasure, "map"), SelectQuest(treasure, "choise1"), SelectQuest(treasure, "choise2")
    local trCheck = trquest == 0 or not IsQuestFlaggedCompleted(trquest)
    local tmCheck = DRTSOptions.ignoretm or tmquest == 0 or not IsQuestFlaggedCompleted(tmquest)
    local choise1Check = c1quest == 0 or IsQuestFlaggedCompleted(c1quest)
    local choise2Check = c2quest == 0 or IsQuestFlaggedCompleted(c2quest)
    return trCheck, tmCheck, choise1Check, choise2Check, trquest, tmquest, c1quest, c2quest
end

local function GetClosestTreasure()
    local dist = 99999999
    local closest = nil
    local x, y, _, mapID = UnitPosition("player")
    for k,v in pairs(DRTS.treasures) do
        if TreasureContinentsIds[mapID] == v.continent then
            local dist2 = GetDistanceToPoint(x, y, v.x, v.y)
            local trCheck, tmCheck, choise1Check, choise2Check = GetTreasureCompletion(v)
            if dist2 < dist and (DRTSOptions.debug or not DRTSOptions.hidden[v.id]) and (DRTSOptions.debug or (trCheck and tmCheck and choise1Check and choise2Check)) then
                dist = dist2
                closest = v
            end
        end
    end
    return closest, dist
end

if DBM then
    arrowAvailable = true
    if DBMArrow then
        local text = DBMArrow:CreateFontString(nil, "OVERLAY", "GameTooltipText")
        text:SetWidth(150)
        text:SetHeight(60)
        text:SetPoint("CENTER", DBMArrow, "CENTER", 0, -35)
        text:SetTextColor(1, 1, 1, 1)
        text:SetJustifyH("CENTER")
        DBMArrow.text = text
        arrowTextAvailable = true
    end
end

local function ShowArrow(treasure, dist)
    if dist < 5 then return end
    local x, y, text = treasure.x, treasure.y, DRTSOptions.debug and format("%s (%u)\n%.02f yd", treasure.name, treasure.id, dist) or format("%s\n%.02f yd", treasure.name, dist)
    if arrowAvailable then
        DBM.Arrow:ShowRunTo(x, y, nil, 5)
    end
    if arrowTextAvailable then
        if not DBMArrow.text:IsShown() then
            DBMArrow.text:Show()
        end
        DBMArrow.text:SetText(text)
    end
end

local function HideArrow()
    if arrowAvailable then
        DBM.Arrow:Hide()
    end
    if arrowTextAvailable then
        DBMArrow.text:Hide()
    end
end

local function FilterMinimapPOI(v, x, y, mapID, radius)
    local showTreasures = DRTSOptions.enabled and TreasureContinentsIds[mapID] == v.continent
    if not showTreasures then return false end

    local distCheck = GetDistanceToPoint(x, y, v.x, v.y) < radius
    if not distCheck then return false end

    local trCheck, tmCheck, choise1Check, choise2Check, _, _, _, _ = GetTreasureCompletion(v)
    if DRTSOptions.debug or (not DRTSOptions.hidden[v.id] and trCheck and tmCheck and choise1Check and choise2Check) then
        return true
    end
    return false
end

local currentmapid = -1
local interval = 1

local function onUpdate(self,elapsed)
    if not DRTSOptions.enabled then return end
    if not DRTSOptions.arrowEnabled then return end
    currentmapid = select(4, UnitPosition("player"))
    if not TreasureContinentsIds[currentmapid] then return end
    interval = interval + elapsed
    if interval >= 1 then
        interval = 0
        local closest, dist = GetClosestTreasure()
        if not closest then
            HideArrow()
            return
        end
        ShowArrow(closest, dist)
    end
end

local function onEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName ~= addon then return end
        if not DRTSOptions.hidden then
            DRTSOptions.hidden = { }
        end
        if not DRTSOptions.minimap then
            DRTSOptions.minimap = true
        end
        if DRTSOptions.enabled then
            frame:SetScript("OnUpdate", onUpdate)
        else
            frame:SetScript("OnUpdate", nil)
        end
        MinimapPOIHandler:SetFilter(FilterMinimapPOI)
        MinimapPOIHandler:SetDataSource(DRTS.treasures, TreasureContinentsIds)
        if DRTSOptions.minimap then
            MinimapPOIHandler:Enable()
        end
    end
end

frame:SetScript("OnEvent", onEvent)
frame:RegisterEvent("ADDON_LOADED")

SLASH_DRTS1 = "/drts"

SlashCmdList["DRTS"] = function(msg, editBox)
    if msg:lower() == "on" then
        frame:SetScript("OnUpdate", onUpdate)
        DRTSOptions.enabled = true
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures enabled")
    elseif msg:lower() == "off" then
        frame:SetScript("OnUpdate", nil)
        DRTSOptions.enabled = false
        HideArrow()
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures disabled")
    elseif msg:lower() == "toggle" then
        DRTSOptions.enabled = not DRTSOptions.enabled
        frame:SetScript("OnUpdate", (DRTSOptions.enabled and onUpdate or nil))
        if not DRTSOptions.enabled then HideArrow() end
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures "..(DRTSOptions.enabled and "enabled" or "disabled"))
    elseif msg:lower() == "arrow" then
        if not arrowAvailable then
            DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures arrow not available. Please install DBM in order to use arrow.")
            return
        end
        DRTSOptions.arrowEnabled = not DRTSOptions.arrowEnabled
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures arrow "..(DRTSOptions.arrowEnabled and "enabled" or "disabled"))
        if not DRTSOptions.arrowEnabled then
            HideArrow()
        end
    elseif msg:lower() == "debug" then
        DRTSOptions.debug = not DRTSOptions.debug
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures debug "..(DRTSOptions.debug and "enabled" or "disabled"))
    elseif msg:lower() == "closest" then
        local closest, dist = GetClosestTreasure()
        if closest then
            DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: "..closest.id.." ("..closest.name..") "..dist.." yd away")
        else
            DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: there's no treasure nearby")
        end
    elseif msg:lower() == "minimap" then
        DRTSOptions.minimap = not DRTSOptions.minimap
        if DRTSOptions.minimap then
            MinimapPOIHandler:Enable()
        else
            MinimapPOIHandler:Disable()
        end
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures minimap icons "..(DRTSOptions.minimap and "enabled" or "disabled"))
    elseif msg:lower() == "hidepoi" then
        local closest, dist = GetClosestTreasure()
        if closest then
            DRTSOptions.hidden[closest.id] = true
            DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: POI "..closest.name.." ("..closest.id..") is now hidden")
        else
            DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: there's no treasure nearby")
        end
    elseif msg:lower() == "clearhidden" then
    	table.wipe(DRTSOptions.hidden)
    	DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: hidden treasures cleared")
    elseif msg:lower() == "itm" then
        DRTSOptions.ignoretm = not DRTSOptions.ignoretm
        DEFAULT_CHAT_FRAME:AddMessage("DraenorTreasures: treasure map quests now "..(DRTSOptions.ignoretm and "ignored" or "used"))
    else
        DEFAULT_CHAT_FRAME:AddMessage("Usage: /drts on|off")
        DEFAULT_CHAT_FRAME:AddMessage("Usage: /drts arrow (toggle)")
        DEFAULT_CHAT_FRAME:AddMessage("Usage: /drts debug (toggle)")
    end
end

local function WorldPosToScreenPos(x, y)
    local isMapDungeon = true
    local floorIndex, minY, minX, maxY, maxX = GetCurrentMapDungeonLevel()
    local zoneIndex, locLeft, locTop, locRight, locBottom

    if not (minX and minY and maxX and maxY) then
        isMapDungeon = false
        zoneIndex, locLeft, locTop, locRight, locBottom = GetCurrentMapZone()
        if not (locLeft and locTop and locRight and locBottom) then
            return 0, 0, false
        end
    end

    if isMapDungeon then
        local h, w = abs(maxY - minY), abs(maxX - minX)
        local sx = (maxX - x) / w
        local sy = (maxY - y) / h
        local onMap = y < maxY and y > minY and x < maxX and x > minX
        return sy, sx, onMap
    else
        local h, w = abs(locRight - locLeft), abs(locBottom - locTop)
        local sx = (locTop - x) / w
        local sy = (locLeft - y) / h
        local onMap = y < locLeft and y > locRight and x < locTop and x > locBottom
        return sy, sx, onMap
    end
end

local function TreasureMap_ResetPOI(button)
    button:SetWidth(24)
    button:SetHeight(24)
    button.Texture:SetWidth(12)
    button.Texture:SetHeight(12)
    button.Texture:SetPoint("CENTER", 0, 0)
    button.Texture:SetTexture("Interface\\Minimap\\POIIcons")
    if button.HighlightTexture then
        button.HighlightTexture:SetWidth(12)
        button.HighlightTexture:SetHeight(12)
        button.HighlightTexture:SetTexture("Interface\\Minimap\\POIIcons");
    end

    button.specialPOIInfo = nil
end

local debugMsgFormat = "Treasure %s (%u):\nxpos %f\nypos %f\ntracking quest %u (%s)\ntreasuremap quest %u (%s)\ndistance %.02f"

local function TreasureMapPOI_OnClick(self, button)
    if not DRTSOptions.debug or button == "RightButton" then
        WorldMapButton_OnClick(WorldMapButton, button)
        return
    end
    local t = DRTS.treasures[self.id]
    local trCheck, tmCheck, _, _, trquest, tmquest, _, _ = GetTreasureCompletion(t)
    local trstate = trquest ~= 0 and (trCheck and "Not completed" or "Completed") or "No quest"
    local tmstate = tmquest ~= 0 and (tmCheck and "Not completed" or "Completed") or "No quest"
    local x, y = UnitPosition("player")
    print(format(debugMsgFormat, t.name, t.id, t.x, t.y, trquest, trstate, tmquest, tmstate, GetDistanceToPoint(x, y, t.x, t.y)))
end

local function TreasureMap_CreatePOI(index)
    local button = CreateFrame("Button", "TreasureMapFramePOI"..index, WorldMapPOIFrame)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:SetScript("OnEnter", WorldMapPOI_OnEnter)
    button:SetScript("OnLeave", WorldMapPOI_OnLeave)
    button:SetScript("OnClick", TreasureMapPOI_OnClick)

    button.Texture = button:CreateTexture(button:GetName().."Texture", "BACKGROUND")
    button.HighlightTexture = button:CreateTexture(button:GetName().."HighlightTexture", "HIGHLIGHT");
    button.HighlightTexture:SetBlendMode("ADD");
    button.HighlightTexture:SetAlpha(.4);
    button.HighlightTexture:SetAllPoints(button.Texture);

    TreasureMap_ResetPOI(button)
    return button
end

local function DrawTreasurePOI()
    local worldMapID, isContinent = GetCurrentMapAreaID()
    local mapID = GetAreaMapInfo(worldMapID)
    local showTreasures = (not isContinent) and (worldMapID > 0) and DRTSOptions.enabled

    for k,v in pairs(DRTS.treasures) do
        local treasureMapPOI = _G["TreasureMapFramePOI"..k] or TreasureMap_CreatePOI(k)

        local trCheck, tmCheck, choise1Check, choise2Check, _, tmquest, c1quest, _ = GetTreasureCompletion(v)

        if showTreasures and (TreasureContinentsIds[mapID] == v.continent) and (DRTSOptions.debug or (not DRTSOptions.hidden[v.id] and trCheck and tmCheck and choise1Check and choise2Check)) then
            local x, y, onMap = WorldPosToScreenPos(v.x, v.y)
            if onMap then
                local name
                if DRTSOptions.debug then
                    name = format("%s (%u, %.02f, %.02f)", v.name, v.id, x * 100, y * 100)
                else
                    name = format("%s (%.02f, %.02f)", v.name, x * 100, y * 100)
                end

                local description = v.desc ~= "" and v.desc or format("Treasure: %s!", TreasureQuestsDesc[c1quest] or TreasureQuestsDesc[tmquest] or "Unknown")

                --x = x * WorldMapPOIFrame:GetWidth()
                --y = y * WorldMapPOIFrame:GetHeight()
                --treasureMapPOI:SetPoint("CENTER", "WorldMapPOIFrame", "TOPLEFT", x, -y)
                WorldMapPOIFrame_AnchorPOI(treasureMapPOI, x, y, WorldMap_GetFrameLevelForLandmark(LE_MAP_LANDMARK_TYPE_NORMAL));

                TreasureMap_ResetPOI(treasureMapPOI)

                local x1, x2, y1, y2 = GetPOITextureCoords(197)

                treasureMapPOI.Texture:SetTexCoord(x1, x2, y1, y2)
                treasureMapPOI.HighlightTexture:SetTexCoord(x1, x2, y1, y2);

                treasureMapPOI.id = k
                treasureMapPOI.name = name
                treasureMapPOI.description = description
                treasureMapPOI.mapLinkID = nil
                treasureMapPOI.poiID = v.id
                treasureMapPOI.landmarkType = LE_MAP_LANDMARK_TYPE_NORMAL

                treasureMapPOI:Show()
            else
                treasureMapPOI:Hide()
            end
        else
            treasureMapPOI:Hide()
        end
    end
end

local function MyWorldMapFrame_OnUpdate(self, e)
    WorldMapFrame_OnUpdate(self, e)
    DrawTreasurePOI()
end

WorldMapFrame:SetScript("OnUpdate", MyWorldMapFrame_OnUpdate)
