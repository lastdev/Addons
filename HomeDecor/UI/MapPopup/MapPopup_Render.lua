local ADDON, NS = ...
NS.UI = NS.UI or {}

local MapPopup = NS.UI.MapPopup or {}
NS.UI.MapPopup = MapPopup

local Render = NS.UI.MapPopupRender or {}
NS.UI.MapPopupRender = Render
MapPopup.Render = Render

local C_Timer = _G.C_Timer

local Rows = NS.UI.MapPopupRows
local Util = NS.UI.MapPopupUtil
local TT = NS.UI.Tooltips
local TrackerUtil = NS.UI.TrackerUtil
local IA = NS.UI.ItemInteractions

local NPCNames = NS.Systems and NS.Systems.NPCNames

local VENDOR_CLASS_LABEL = {
  [103693] = "Hunter",
  [105986] = "Rogue",
  [112318] = "Shaman",
  [112323] = "Druid",
  [93550] = "Death Knight",
  [100196] = "Paladin",
  [112338] = "Monk",
  [112392] = "Warrior",
  [112401] = "Priest",
  [112407] = "Demon Hunter",
  [112434] = "Warlock",
  [112440] = "Mage",
}

local SPECIAL_ZONES = {
  [2352] = "Founder's Point",  
  [2351] = "Razorshore",       
}

local CONTINENT_IDS = {
  [619] = "Broken Isles",
  [875] = "Zandalar",
  [876] = "Kul Tiras",
  [1978] = "Dragon Isles",
  [2274] = "Khaz Algar",
  [13] = "Eastern Kingdoms",
  [12] = "Kalimdor",
  [101] = "Outland",
  [113] = "Northrend",
  [948] = "The Maelstrom",
  [905] = "Argus",
  [424] = "Pandaria",
  [572] = "Draenor",
}

local C_Map = _G.C_Map

local function GetContinentForMap(mapID)
  if not mapID or not C_Map then return nil end

  if CONTINENT_IDS[mapID] then
    return mapID, CONTINENT_IDS[mapID]
  end

  local currentMapID = mapID
  for i = 1, 10 do 
    local info = C_Map.GetMapInfo and C_Map.GetMapInfo(currentMapID)
    if not info then break end
    
    if info.parentMapID and CONTINENT_IDS[info.parentMapID] then
      return info.parentMapID, CONTINENT_IDS[info.parentMapID]
    end
    
    if not info.parentMapID then break end
    currentMapID = info.parentMapID
  end
  
  return nil, nil
end

function Render:SetTitle(frame, vendorID)
  if not (Util and frame) then return end
  local vendorName = Util.GetVendorName(vendorID)
  frame.header.title:SetText(vendorName)
end

function Render:SetMultipleTitle(frame, vendors)
  if not frame then return end
  frame.header.title:SetText(#vendors .. " Vendors")
end

function Render:ScheduleRefresh(popup, frame)
  if not frame then return end
  frame.needsRefresh = true
  if not frame.refreshScheduled then
    frame.refreshScheduled = true
    C_Timer.After(0.1, function()
      if frame and frame.needsRefresh then
        popup:Refresh()
        frame.needsRefresh = false
      end
      frame.refreshScheduled = false
    end)
  end
end

function Render:RefreshContent(popup, frame, vendors)
  if not frame then return end
  if not Rows then return end
  if not Util then return end
  
  if frame.isRefreshing then return end
  frame.isRefreshing = true

  local activeRows = Rows.GetActive()
  for row in pairs(activeRows) do
    Rows.Release(row)
  end

  vendors = vendors or {}
  
  if #vendors == 0 then
    frame.noItems:SetText("No vendors")
    frame.noItems:Show()
    frame.isRefreshing = false
    return
  end

  frame.noItems:Hide()

  local seenVendorIDs = {}
  local uniqueVendors = {}
  for _, vendor in ipairs(vendors) do
    local vendorID = vendor.id
    if vendorID and not seenVendorIDs[vendorID] then
      seenVendorIDs[vendorID] = true
      uniqueVendors[#uniqueVendors + 1] = vendor
    end
  end
  vendors = uniqueVendors
  
  if frame.header and frame.header.title and #vendors > 1 then
    frame.header.title:SetText(#vendors .. " Vendors")
  end

  local classHall = {} 
  local continents = {} 
  local specialZones = {} 
  local other = {}
  
  for _, vendor in ipairs(vendors) do
    local vendorID = vendor.id

    if VENDOR_CLASS_LABEL[vendorID] then
      local className = VENDOR_CLASS_LABEL[vendorID]
      if not classHall[className] then
        classHall[className] = {}
      end
      table.insert(classHall[className], vendor)
    else
      local mapID = vendor.data and vendor.data.mapID
      
      local specialZoneName = mapID and SPECIAL_ZONES[mapID]
      if specialZoneName then
        if not specialZones[specialZoneName] then
          specialZones[specialZoneName] = {}
        end
        table.insert(specialZones[specialZoneName], vendor)
      else
        local continentID, continentName = GetContinentForMap(mapID)
        
        if continentName then
          if not continents[continentName] then
            continents[continentName] = {}
          end
          table.insert(continents[continentName], vendor)
        else
          table.insert(other, vendor)
        end
      end
    end
  end

  local yOffset = -4
  local hasItems = false
  local needsItemLoad = false
  
  local vendorIDs = {}
  for _, vendor in ipairs(vendors) do
    vendorIDs[#vendorIDs + 1] = vendor.id
  end
  if NPCNames and NPCNames.PrefetchMany then
    NPCNames.PrefetchMany(vendorIDs)
  end

  local function RenderSectionHeader(title, colorR, colorG, colorB)
    local section = Rows.GetOrCreate("section", frame.content)
    section.label:SetText(title)
    if colorR and colorG and colorB then
      section.label:SetTextColor(colorR, colorG, colorB)
    end
    section:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 4, yOffset)
    section:SetPoint("TOPRIGHT", frame.content, "TOPRIGHT", -4, yOffset)
    section:Show()
    Rows.SetActive(section)
    yOffset = yOffset - section:GetHeight() - 2
  end

  local function RenderVendors(vendorList)
    for _, vendor in ipairs(vendorList) do
      local vendorID = vendor.id
      local items = Util.GetVendorItems(vendorID)
      
      if #items > 0 then
        local allCollected = false
        local prof = NS.db and NS.db.profile
        if prof and prof.tracker and prof.tracker.hideCompletedVendors then
          allCollected = true
          for _, item in ipairs(items) do
            if not Util.IsCollected(item.decorID) then
              allCollected = false
              break
            end
          end
        end
        if not allCollected then

        hasItems = true
        
        local header = Rows.GetOrCreate("vendor", frame.content)
        header.vendorID = vendorID
        
        local vKey = Util.VendorKey(vendorID)
        local isOpen = frame.openVendors[vKey] == true
        
        local vendorName = Util.GetVendorName(vendorID)
        header.label:SetText(vendorName)
        header.npcID = vendorID
        
        local total = 0
        local collected = 0
        local _profCount = NS.db and NS.db.profile
        local _hideCompleted = _profCount and _profCount.tracker and _profCount.tracker.hideCompleted
        for _, item in ipairs(items) do
          local isCollected = Util.IsCollected(item.decorID)
          if isCollected then
            collected = collected + 1
          end
          if not (_hideCompleted and isCollected) then
            total = total + 1
          end
        end
        
        header.count:SetText(collected .. "/" .. total)
        
        if header.arrow.SetRotation then
          header.arrow:SetRotation(isOpen and 0 or -1.5708)
        end
        
        header:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 4, yOffset)
        header:SetPoint("TOPRIGHT", frame.content, "TOPRIGHT", -4, yOffset)
        header:Show()
        
        Rows.SetActive(header)
        
        if not header.clickHandlerSet then
          header:SetScript("OnClick", function()
            local key = Util.VendorKey(header.vendorID)
            frame.openVendors[key] = not frame.openVendors[key]
            popup:Refresh()
          end)
          header.clickHandlerSet = true
        end
        
        yOffset = yOffset - header:GetHeight() - 4
        
        if isOpen then
          table.sort(items, function(a, b)
            local aC = Util.IsCollected(a.decorID)
            local bC = Util.IsCollected(b.decorID)
            if aC ~= bC then return bC end
            return (a.itemID or 0) < (b.itemID or 0)
          end)
          
          for _, item in ipairs(items) do
            local _skipItem = false
            local _profCheck = NS.db and NS.db.profile
            if _profCheck and _profCheck.tracker and _profCheck.tracker.hideCompleted then
              if Util.IsCollected(item.decorID) then _skipItem = true end
            end

            if not _skipItem then
            local itemData = Util.GetItemData(item.itemID)
            
            if itemData then
              local row = Rows.GetOrCreate("item", frame.content)
              row.itemData = itemData
              row.fullItem = item
              
              row.icon:SetTexture(itemData.icon)
              row.title:SetText(itemData.name)
              
              local r, g, b = Util.GetQualityColor(itemData.quality)
              row.title:SetTextColor(r, g, b)
              
              local collected = Util.IsCollected(item.decorID)
              row.check:SetShown(collected)
              row:SetAlpha(collected and 0.6 or 1)
              
              local aqLine, repLine = nil, nil
              if TrackerUtil and TrackerUtil.GetAQAndRepLines then
                aqLine, repLine = TrackerUtil.GetAQAndRepLines(item)
              end
              
              if not aqLine and item.requirements then
                local req = item.requirements
                
                if req.achievement and req.achievement.id then
                  local achID = tonumber(req.achievement.id)
                  local achName = req.achievement.title or req.achievement.name
                  
                  if not achName and achID and _G.GetAchievementInfo then
                    local ok, id, name = pcall(_G.GetAchievementInfo, achID)
                    if ok then achName = name end
                  end
                  
                  achName = achName or ("Achievement #" .. tostring(achID))
                  aqLine = "|cffffd100*|r |cffd8d8d8Achievement: " .. tostring(achName) .. "|r"
                  
                elseif req.quest and req.quest.id then
                  local questID = tonumber(req.quest.id)
                  local questName = req.quest.title or req.quest.name
                  
                  if not questName and questID and _G.C_QuestLog and _G.C_QuestLog.GetTitleForQuestID then
                    local ok, name = pcall(_G.C_QuestLog.GetTitleForQuestID, questID)
                    if ok and type(name) == "string" and name ~= "" then
                      questName = name
                    end
                  end
                  
                  questName = questName or ("Quest #" .. tostring(questID))
                  aqLine = "|cffffd100!|r |cffd8d8d8Quest: " .. tostring(questName) .. "|r"
                end
              end
              
              if not repLine then
                local Viewer = NS.UI and NS.UI.Viewer
                local Requirements = Viewer and Viewer.Requirements
                
                if Requirements and Requirements.GetRepRequirement and Requirements.BuildRepDisplay then
                  local repReq = Requirements.GetRepRequirement(item)
                  if repReq then
                    local repText = Requirements.BuildRepDisplay(repReq, false)
                    if repText and repText ~= "" then
                      repLine = repText
                      
                      local RepAlts = NS.Systems and NS.Systems.ReputationAlts
                      if RepAlts and RepAlts.GetAnyOtherCharacter and RepAlts.CurrentCharacterHas and repReq.text then
                        local hasOnCurrent = RepAlts:CurrentCharacterHas(repReq.text)
                        if not hasOnCurrent then
                          local who = RepAlts:GetAnyOtherCharacter(repReq.text)
                          if who then
                            repLine = repLine .. " |cffc0ffc0(" .. tostring(who) .. ")|r"
                          end
                        end
                      end
                    end
                  end
                elseif item.requirements and (item.requirements.rep or item.requirements.reputation) then
                  local rep = item.requirements.rep or item.requirements.reputation
                  if type(rep) == "string" and rep ~= "" and rep:lower() ~= "true" then
                    repLine = "|cffb0b0b0Reputation: " .. rep .. "|r"
                  else
                    repLine = "|cffb0b0b0Reputation required|r"
                  end
                end
              end
              
              if aqLine then
                row.reqAQ:SetText(aqLine)
                row.reqAQ:Show()
                
                if row.reqBtn then
                  local Viewer = NS.UI and NS.UI.Viewer
                  local Requirements = Viewer and Viewer.Requirements
                  local req = Requirements and Requirements.GetRequirementLink and Requirements.GetRequirementLink(item)
                  
                  if req then
                    row.reqAQ.req = req
                    row.reqBtn:ClearAllPoints()
                    row.reqBtn:SetPoint("TOPLEFT", row.reqAQ, "TOPLEFT", -2, 2)
                    row.reqBtn:SetPoint("BOTTOMRIGHT", row.reqAQ, "BOTTOMRIGHT", 2, -2)
                    row.reqBtn:Show()
                    self:BindReqButton(row.reqBtn)
                  else
                    row.reqBtn:Hide()
                  end
                end
              else
                row.reqAQ:Hide()
                if row.reqBtn then row.reqBtn:Hide() end
              end
              
              if repLine then
                row.reqRep:SetText(repLine)
                row.reqRep:Show()
              else
                row.reqRep:Hide()
              end
              
              if row.faction then
                local faction = item.source and item.source.faction
                if faction == "Alliance" then
                  row.faction:SetTexture(row.texAlliance)
                  row.faction:Show()
                elseif faction == "Horde" then
                  row.faction:SetTexture(row.texHorde)
                  row.faction:Show()
                else
                  row.faction:Hide()
                end
              end
              
              local ItemIA = IA or (NS.UI and NS.UI.ItemInteractions)
              if ItemIA and ItemIA.Bind then
                ItemIA:Bind(row, item, item.navVendor)
              end
              
              row:SetPoint("TOPLEFT", frame.content, "TOPLEFT", 4, yOffset)
              row:SetPoint("TOPRIGHT", frame.content, "TOPRIGHT", -4, yOffset)
              row:Show()
              
              Rows.SetActive(row)
              
              yOffset = yOffset - row:GetHeight() - 4
            else
              needsItemLoad = true
            end
            end 
          end
        end
        end 
      end
    end
  end

  if next(classHall) then
    RenderSectionHeader("Class Hall", 1, 0.82, 0)

    local classNames = {}
    for className in pairs(classHall) do
      table.insert(classNames, className)
    end
    table.sort(classNames)
    
    for _, className in ipairs(classNames) do
      RenderVendors(classHall[className])
    end
    
    yOffset = yOffset - 8 
  end

  local continentNames = {}
  for continentName in pairs(continents) do
    table.insert(continentNames, continentName)
  end
  table.sort(continentNames)
  
  for _, continentName in ipairs(continentNames) do
    RenderSectionHeader(continentName, 0.7, 0.85, 1)
    RenderVendors(continents[continentName])
    yOffset = yOffset - 8
  end

  local specialZoneNames = {}
  for zoneName in pairs(specialZones) do
    table.insert(specialZoneNames, zoneName)
  end
  table.sort(specialZoneNames)
  
  for _, zoneName in ipairs(specialZoneNames) do
    local r, g, b = 0.9, 0.9, 0.9
    if zoneName == "Founder's Point" then
      r, g, b = 0.3, 0.6, 1
    elseif zoneName == "Razorshore" then
      r, g, b = 0.9, 0.3, 0.3
    end
    
    RenderSectionHeader(zoneName, r, g, b)
    RenderVendors(specialZones[zoneName])
    yOffset = yOffset - 8
  end

  if #other > 0 then
    RenderVendors(other)
  end

  if not hasItems then
    frame.noItems:SetText("No items found")
    frame.noItems:Show()
  end

  frame.content:SetHeight(math.max(math.abs(yOffset) + 10, 100))
  frame.isRefreshing = false
  
  if needsItemLoad and not frame.pendingItemLoad then
    frame.pendingItemLoad = true
    C_Timer.After(0.2, function()
      if frame and frame:IsShown() then
        frame.pendingItemLoad = false
        popup:Refresh()
      else
        frame.pendingItemLoad = false
      end
    end)
  end
end

function Render:BindReqButton(btn)
  if not btn then return end
  
  btn:SetScript("OnEnter", function(self)
    local req = self:GetParent().req
    if req and TT and TT.ShowRequirement then
      TT:ShowRequirement(self, req)
    end
  end)
  
  btn:SetScript("OnLeave", function()
    if _G.GameTooltip then _G.GameTooltip:Hide() end
  end)
  
  btn:SetScript("OnClick", function(self)
    local req = self:GetParent().req
    if req then
      local Viewer = NS.UI and NS.UI.Viewer
      local Requirements = Viewer and Viewer.Requirements
      if Requirements and Requirements.HandleClick then
        Requirements:HandleClick(req)
      end
    end
  end)
end

function Render:Attach(popup, frame)
end

return Render