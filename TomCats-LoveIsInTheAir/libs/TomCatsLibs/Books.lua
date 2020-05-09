local _, addon = ...
local TCL = addon.TomCatsLibs
local Books = TCL.Books
addon.eligibleCharacters = 0
addon.completedCharacters = 0
local totalsFont
local showUnopenedBoxesAlert
local BookMixin = {
    pages = { }
}
local PageMixin = {
    components = { }
}
local InsetMixin = { }
local insetFramePool = { }
function Books.CreateBook()
    local book = _G["TomCats-LoveIsInTheAirTourGuideFrame"]
    book.pageOffsetX = 77
    book.pageOffsetY = -54
    book.pageWidth = 442
    book.pageHeight = 500 -- todo: measure and set
    Mixin(book, BookMixin)
    return book
end
function BookMixin:CreatePage(pageName)
    local page = CreateFromMixins(PageMixin)
    page.frame = self
    self.pages[pageName] = page
    return page
end
function PageMixin:CreateInset( points )
    local inset = CreateFromMixins(InsetMixin)
    inset.points = points
    inset.page = self
    table.insert(self.components, inset)
    return inset
end
local region
local eventResets = {
--    EU = 1549954800,
    EU = 1581058800,
    --NA = 1581174000,
    NA = 1581087600,
--    NA = 1549983600
}
local eventEnds = {
--    EU = 1551171600, -- 2/26/2019 10:00am CET
    EU = 1582282740, -- 2/21/2020 11:59pm CET
--    NA = 1551204000 -- 2/26/2019 10:00am PST
    NA = 1582358340 -- 2/21/2020 11:59pm PST
}
local eventStarts = {
    EU = 1581116460, -- 2/8/2020 12:01am CET
    NA = 1581148860 -- 2/8/2020 12:01am PST
}
local currentOffsetMinutes
local function getCurrentOffsetMinutes()
    if (currentOffsetMinutes) then return currentOffsetMinutes end
    local localTime = C_DateAndTime.GetCalendarTimeFromEpoch(GetServerTime()* 1000000)
    local serverTime = C_DateAndTime.GetCurrentCalendarTime()
    local minutesOffset = serverTime.minute - localTime.minute
    local hoursOffset = serverTime.hour - localTime.hour
    local daysOffset = serverTime.weekday - localTime.weekday
    if (daysOffset > 1) then daysOffset = -1 end
    if (daysOffset < -1) then daysOffset = 1 end
    currentOffsetMinutes = math.floor( (minutesOffset + (hoursOffset * 60) + (daysOffset * 60 * 24)) / 15 + 0.5) * 15
    return currentOffsetMinutes
end
local function getRegion()
    local region = GetCurrentRegionName();
    if (region == "EU") then return "EU" end
    return "NA";
    --if (not region) then
    --    local serverTimestamp = math.floor(GetServerTime() / 60)
    --    local epoch = 1549929600 / 60-- 2/12/2019 0:00:00 UTC
    --    local currentCalendar = C_DateAndTime.GetCurrentCalendarTime()
    --    local days = currentCalendar.monthDay - 12
    --    local hours = currentCalendar.hour
    --    local minutes = currentCalendar.minute
    --    local diff1 = ((days * 24 + hours) * 60) + minutes
    --    local diff2 = serverTimestamp - epoch
    --    if (diff1 - diff2 > 0 and diff1 - diff2 < 120) then
    --        region = "EU"
    --    else
    --        region = "NA"
    --    end
    --end
    --return region
end
local lastResetTimestamp
local eventEndsTime
local function getEventEndsTime()
    if (not eventEndsTime) then
        eventEndsTime = eventEnds[getRegion()]
    end
    return eventEndsTime
end
local eventStartsTime
local function getEventStartsTime()
    if (not eventStartsTime) then
        eventStartsTime = eventStarts[getRegion()]
    end
    return eventStartsTime
end
function addon:GetNextResetTimestamp()
    if (not lastResetTimestamp) then
        addon:GetLastResetTimestamp()
    end
    return lastResetTimestamp + 60 * 60 * 24
end
function addon:GetLastResetTimestamp()
    if (not lastResetTimestamp) then
        local serverTime = GetServerTime()
        local firstReset = eventResets[getRegion()]
        lastResetTimestamp = firstReset
        for i = firstReset, firstReset + (60 * 60 * 24 * 15), 60 * 60 * 24 do
            if (i > serverTime) then
                break
            end
            lastResetTimestamp = i
        end
        local cal = C_DateAndTime.GetCalendarTimeFromEpoch(lastResetTimestamp * 1000000)
    end
    local time = GetServerTime()
    if (addon:GetNextResetTimestamp() <= time) then
        lastResetTimestamp = addon:GetNextResetTimestamp()
    end
    return lastResetTimestamp
end
local FACTION_ICON_TCOORDS = {
    Alliance = { 0, 0.5, 0, 1 },
    Horde = { 0.5, 1, 0, 1 }
}
local function SetupCharacterButton(button, character)
    if (character) then
        if (character.boxes > 0 and character ~= addon.character) then
            button.Alert:Show()
            button.Complete:Hide()
        else
            if (character.completedDungeon and (character.timestamp >= addon:GetLastResetTimestamp())) then
                button.Complete:Show()
            else
                button.Complete:Hide()
            end
        end
        if (character.faction == "Alliance") then
            button.CharacterFactionAlliance:Show()
            button.CharacterFactionHorde:Hide()
        else
            button.CharacterFactionAlliance:Hide()
            button.CharacterFactionHorde:Show()
        end
        button.CharacterClass:SetTexCoord(unpack(CLASS_ICON_TCOORDS[character.class]))
        local color = RAID_CLASS_COLORS[character.class];
        button.CharacterName:SetTextColor(color.r, color.g, color.b);
        button.CharacterName:SetText(character.name)
        button.CharacterRealm:SetText(character.realm)
        button.CharacterLevel:SetText(tostring(character.level))
        button.Charms:SetText(tostring(character.charms))
        button.Tokens:SetText(tostring(character.tokens))
        button.Bracelets:SetText(tostring(character.bracelets))
        button:Show()
    else
        button:Hide()
    end
end
function addon:SortedCharacterList()
    local characters = addon.savedVariables.account.characters
    local keys = { }
    local keyedCharacters = {}
    local currentCharacterGUID = UnitGUID("player")
    addon.eligibleCharacters = 0
    addon.completedCharacters = 0
    showUnopenedBoxesAlert = false
    for guid, character in pairs(characters) do
        if (character.canLootMount) then
            addon.eligibleCharacters = addon.eligibleCharacters + 1
            local key
            if (guid == currentCharacterGUID) then
                key = "0:"
                if (character.completedDungeon) then
                    addon.completedCharacters = addon.completedCharacters + 1
                end
            elseif (character.boxes > 0) then
                key = "1:"
                showUnopenedBoxesAlert = true
            elseif (character.realm == addon.characterRealm) then
                if (character.completedDungeon and (character.timestamp >= addon:GetLastResetTimestamp())) then
                    addon.completedCharacters = addon.completedCharacters + 1
                    key = "4:"
                else
                    key = "2:"
                end
            else
                if (character.completedDungeon and (character.timestamp >= addon:GetLastResetTimestamp())) then
                    addon.completedCharacters = addon.completedCharacters + 1
                    key = "4:"
                else
                    key = "3:"
                end
            end
            key = key .. character.realm .. ":" .. character.name
            table.insert(keys, key)
            keyedCharacters[key] = character
        end
    end
    local characters = { }
    table.sort(keys)
    for _, key in ipairs(keys) do
        table.insert(characters, keyedCharacters[key])
    end
    if (showUnopenedBoxesAlert) then
        addon.charm.MinimapLoopPulseAnim:Play()
    end
    return characters
end
local scrollFrameVars
function PageMixin:Show()
    --todo: Debug a condition that causes the list to fail to render if the minimap icon is clicked while the game menu is opened
    for _, component in ipairs(self.components) do
        component:Show()
    end
    local warning1Font = self.components[1].frame:CreateFontString(nil, nil, "GameFontNormal")
    warning1Font:SetPoint("BOTTOMLEFT", self.components[2].frame, "TOPLEFT", 0, 4)
    warning1Font:SetPoint("RIGHT", self.components[1].frame, "RIGHT", 0, 0)
    warning1Font:SetShadowOffset(1,-1)
    warning1Font:SetText("Characters must be level 110-120 to be eligible for the mount to drop")
    local warning2Font = self.components[1].frame:CreateFontString(nil, nil, "GameFontHighlightLarge")
    warning2Font:SetPoint("BOTTOMLEFT", warning1Font, "TOPLEFT", 0, 4)
    warning2Font:SetPoint("BOTTOMRIGHT", warning1Font, "TOPRIGHT", 0, 4)
    warning2Font:SetShadowOffset(1,-1)
    warning2Font:SetText("Unopened Heart-Shaped Boxes detected")
    warning2Font:Hide()
    local warningIcon1 = self.components[1].frame:CreateTexture()
    warningIcon1:SetSize(32,32)
    warningIcon1:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
    warningIcon1:SetPoint("LEFT", warning2Font, "LEFT", 0, 0)
    warningIcon1:Hide()
    local warningIcon2 = self.components[1].frame:CreateTexture()
    warningIcon2:SetSize(32,32)
    warningIcon2:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")
    warningIcon2:SetPoint("RIGHT", warning2Font, "RIGHT", 0, 0)
    warningIcon2:Hide()
    local insetFrame = self.components[2].frame
-- Testing scrollframe
    local scrollFrame = CreateFrame("ScrollFrame", nil, self.components[2].frame, "MinimalHybridScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", self.components[2].frame, "TOPLEFT", 0, -24)
    scrollFrame:SetPoint("BOTTOM", self.components[2].frame, "BOTTOM", 0, 18)
    local heartIconTexture = insetFrame:CreateTexture()
    heartIconTexture:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\inv_valentinesboxofchocolates02")
    heartIconTexture:SetSize(16, 16)
    heartIconTexture:SetPoint("TOPLEFT", insetFrame, "TOPLEFT", 4, -4)
    local factionIconTexture = insetFrame:CreateTexture()
    factionIconTexture:SetTexture("Interface\\WORLDSTATEFRAME\\CombatSwords")
    factionIconTexture:SetSize(18, 18)
    factionIconTexture:SetTexCoord(0, 0.5, 0, 0.5)
    factionIconTexture:SetPoint("TOPLEFT", heartIconTexture, "TOPRIGHT", 4, 0)
    local classIconTexture = insetFrame:CreateTexture()
    classIconTexture:SetTexture("Interface\\MINIMAP\\TRACKING\\Class")
    classIconTexture:SetSize(16, 16)
    classIconTexture:SetPoint("TOPLEFT", factionIconTexture, "TOPRIGHT", 2, -2)
    local characterNameFont = insetFrame:CreateFontString(nil, nil, "GameFontHighlightLeft")
    characterNameFont:SetPoint("TOPLEFT", insetFrame, "TOPLEFT", 66, -8)
    characterNameFont:SetWidth(90)
    characterNameFont:SetText("Name")
    local characterRealmFont = insetFrame:CreateFontString(nil, nil, "GameFontHighlightLeft")
    characterRealmFont:SetPoint("TOPLEFT", characterNameFont, "TOPRIGHT", 4, 0)
    characterRealmFont:SetText("Realm")
    local lvlFont = insetFrame:CreateFontString(nil, nil, "GameFontHighlight")
    lvlFont:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -127, 16)
    lvlFont:SetWidth("22")
    lvlFont:SetText("Lvl")
    local braceletIconTexture = insetFrame:CreateTexture()
    braceletIconTexture:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\inv_jewelry_necklace_43")
    braceletIconTexture:SetSize(16, 16)
    braceletIconTexture:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -23.5, 18)
    local charmIconTexture = insetFrame:CreateTexture()
    charmIconTexture:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\inv_misc_gem_sapphire_01")
    charmIconTexture:SetSize(16, 16)
    charmIconTexture:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -57, 18)
    local tokenIconTexture = insetFrame:CreateTexture()
    tokenIconTexture:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\inv_valentinescard01")
    tokenIconTexture:SetSize(16, 16)
    tokenIconTexture:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", -94, 18)
    local trackBG = scrollFrame.scrollBar.trackBG
    trackBG:SetColorTexture(0.7803 * 0.5, 0.6705 * 0.5, 0.6117 * 0.5)
    trackBG:SetBlendMode("MOD")
    local buttonCounter = 1
    local characters = addon:SortedCharacterList()
    local totalHeight = #characters * 20
    local displayedHeight = scrollFrame:GetHeight()
    scrollFrameVars = {
        totalHeight = totalHeight,
        displayedHeight = displayedHeight,
        scrollFrame = scrollFrame
    }
    if (totalHeight > displayedHeight) then
        scrollFrame:SetPoint("RIGHT", self.components[2].frame, "RIGHT", -22, 0)
    else
        scrollFrame:SetPoint("RIGHT", self.components[2].frame, "RIGHT", 0, 0)
    end
    HybridScrollFrame_CreateButtons(scrollFrame, "TomCats-LoveIsInTheAirCharacterListEntryTemplate", 0, 0, "TOPLEFT", "TOPLEFT", 0, 0, "TOP", "BOTTOM");
    for _, button in next, scrollFrame.buttons do
        local character = characters[buttonCounter]
        buttonCounter = buttonCounter + 1
        button:SetWidth(scrollFrame:GetWidth())
        local bg = button:CreateTexture(nil,"BACKGROUND")
        local adj = 0.6
        bg:SetColorTexture(0.7803 * adj, 0.6705 * adj, 0.6117 * adj)
        bg:SetBlendMode("MOD")
        bg:SetAllPoints()
        if (character) then
            SetupCharacterButton(button, character)
        else
            button:Hide()
        end
    end
    totalsFont = insetFrame:CreateFontString(nil, nil, "GameFontHighlightSmall")
    totalsFont:SetPoint("BOTTOMLEFT", insetFrame, "BOTTOMLEFT", 0, 5)
    totalsFont:SetPoint("BOTTOMRIGHT", insetFrame, "BOTTOMRIGHT", 0, 5)
    totalsFont:SetShadowOffset(1,-1)
    totalsFont:SetText("The Crown Chemical Co.: " .. addon.completedCharacters .. " of " .. addon.eligibleCharacters .. " completed since last reset")
    local leaveframe = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    leaveframe:SetNormalTexture(nil)
    SetItemButtonTexture(leaveframe, "Interface\\VEHICLES\\UI-Vehicles-Button-Exit-Up")
    leaveframe:SetScript("OnClick", function(self, button)
        ConfirmOrLeaveLFGParty()
    end)
    local WHITE_COLOR = CreateColor(1.0, 1.0, 1.0, 1.0)
--    leaveframe:SetScript("OnEnter", function(self, button)
    --- -        GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 10, 20)
    ---- GameTooltip:ClearLines();
    ---- GameTooltip_AddColoredLine(GameTooltip, "Exit Instance", WHITE_COLOR, true)
    ---- GameTooltip:Show()
    ---- GameTooltip.recalculatePadding = true
    ---- end)
    ---- leaveframe:SetScript("OnLeave", function(self, button)
    ---- GameTooltip:Hide()
    ---- end)
    leaveframe:SetPoint("BOTTOMLEFT", self.components[2].frame, "BOTTOMRIGHT", 10, -16)
    local item1frame = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    item1frame:SetNormalTexture(nil)
    SetItemButtonTexture(item1frame, "Interface\\ICONS\\inv_valentinesboxofchocolates02")
    SetItemButtonQuality(item1frame, LE_ITEM_QUALITY_EPIC, 54537, false)
    item1frame:SetScript("OnClick", function(self, button)
        UseItemByName("Heart-Shaped Box")
    end)
    item1frame.Count:Show()
    item1frame:SetPoint("TOPLEFT", self.components[2].frame, "TOPRIGHT", 10, 0)
    local item3frame = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    item3frame:SetNormalTexture(nil)
    SetItemButtonTexture(item3frame, "Interface\\ICONS\\inv_valentinescard01")
    SetItemButtonQuality(item3frame, LE_ITEM_QUALITY_NORMAL, 49927, false)
    item3frame.Count:Show()
    item3frame:SetPoint("TOPLEFT", item1frame, "BOTTOMLEFT", 0, -10)
    local item2frame = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    item2frame:SetNormalTexture(nil)
    SetItemButtonTexture(item2frame, "Interface\\ICONS\\inv_misc_gem_sapphire_01")
    SetItemButtonQuality(item2frame, LE_ITEM_QUALITY_NORMAL, 49655, false)
    item2frame:SetAttribute("type1", "macro")
    item2frame:SetAttribute("macrotext1", "/use item:49655")
    item2frame.Count:Show()
    item2frame:SetPoint("TOPLEFT", item3frame, "BOTTOMLEFT", 0, -10)
    local item4frame = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    item4frame:SetNormalTexture(nil)
    SetItemButtonTexture(item4frame, "Interface\\ICONS\\inv_jewelry_necklace_43")
    SetItemButtonQuality(item4frame, LE_ITEM_QUALITY_NORMAL, 49916, false)
    item4frame.Count:Show()
    item4frame:SetPoint("TOPLEFT", item2frame, "BOTTOMLEFT", 0, -10)
    local item5frame = CreateFrame("ItemButton", nil, _G["TomCats-LoveIsInTheAirTourGuideFrame"], "SecureActionButtonTemplate")
    item5frame:SetNormalTexture(nil)
    SetItemButtonTexture(item5frame, "Interface\\ICONS\\inv_box_04")
    SetItemButtonQuality(item5frame, LE_ITEM_QUALITY_NORMAL, 49661, false)
    item5frame.Count:Show()
    item5frame:SetPoint("TOPLEFT", item4frame, "BOTTOMLEFT", 0, -10)
    scrollFrame.update = function()
        buttonCounter = HybridScrollFrame_GetOffset(scrollFrame) + 1;
        local characters = addon:SortedCharacterList()
        for _, button in next, scrollFrame.buttons do
            local character = characters[buttonCounter]
            buttonCounter = buttonCounter + 1
            SetupCharacterButton(button, character)
        end
        addon:UpdateCompleted()
    end
    if (showUnopenedBoxesAlert) then
        warning2Font:Show()
        warningIcon1:Show()
        warningIcon2:Show()
    end
    HybridScrollFrame_Update(scrollFrameVars.scrollFrame, scrollFrameVars.totalHeight, scrollFrameVars.displayedHeight)
    function addon:bagUpdate()
        local item1count = GetItemCount(54537, true)
        local item2count = GetItemCount(49655, true)
        local item3count = GetItemCount(49927, true)
        local item4count = GetItemCount(49916, true)
        local item5count = GetItemCount(49661, false)
        SetItemButtonCount(item1frame, item1count)
        SetItemButtonCount(item2frame, item2count)
        SetItemButtonCount(item3frame, item3count)
        SetItemButtonCount(item4frame, item4count)
        SetItemButtonCount(item5frame, item5count)
        item1frame.icon:SetDesaturated(item1count == 0)
        item2frame.icon:SetDesaturated(item2count == 0)
        item3frame.icon:SetDesaturated(item3count == 0)
        item4frame.icon:SetDesaturated(item4count == 0)
        item5frame.icon:SetDesaturated(item5count == 0)
    end
    addon:bagUpdate()
    local nextRun = addon:GetNextResetTimestamp()
    local dailyResetLabel = self.components[3].frame:CreateFontString(nil, nil, "GameFontNormal")
    dailyResetLabel:SetPoint("BOTTOM", self.components[3].frame, "CENTER", 0, 4)
    dailyResetLabel:SetShadowOffset(1,-1)
    local dailyResetTime = self.components[3].frame:CreateFontString(nil, nil, "GameFontHighlight")
    dailyResetTime:SetPoint("TOP", self.components[3].frame, "CENTER", 0, -4)
    dailyResetTime:SetShadowOffset(1,-1)
    local eventEndLabel = self.components[4].frame:CreateFontString(nil, nil, "GameFontNormal")
    eventEndLabel:SetPoint("BOTTOM", self.components[4].frame, "CENTER", 0, 4)
    eventEndLabel:SetShadowOffset(1,-1)
    local eventEndTime = self.components[3].frame:CreateFontString(nil, nil, "GameFontHighlight")
    eventEndTime:SetPoint("TOP", self.components[4].frame, "CENTER", 0, -4)
    eventEndTime:SetShadowOffset(1,-1)
    local lastLocalTimeSetting = not GetCVarBool("timeMgrUseLocalTime")
    local function setTimerText()
        local nextReset
        local endTime
        local startTime
        local newLocalTimeSetting = GetCVarBool("timeMgrUseLocalTime")
        if (GetCVarBool("timeMgrUseLocalTime")) then
            nextReset = C_DateAndTime.GetCalendarTimeFromEpoch(nextRun * 1000000)
            endTime = C_DateAndTime.GetCalendarTimeFromEpoch(getEventEndsTime() * 1000000)
            startTime = C_DateAndTime.GetCalendarTimeFromEpoch(getEventStartsTime() * 1000000)
        else
            nextReset = C_DateAndTime.GetCalendarTimeFromEpoch((nextRun + getCurrentOffsetMinutes() * 60) * 1000000)
            endTime = C_DateAndTime.GetCalendarTimeFromEpoch((getEventEndsTime() + getCurrentOffsetMinutes() * 60) * 1000000)
            startTime = C_DateAndTime.GetCalendarTimeFromEpoch((getEventStartsTime() + getCurrentOffsetMinutes() * 60) * 1000000)
        end
        local time = GetServerTime()
        if (newLocalTimeSetting ~= lastLocalTimeSetting) then
            if (newLocalTimeSetting) then
                dailyResetLabel:SetText("Next Daily Reset (Local Time):")
                if (time > getEventStartsTime()) then
                    eventEndLabel:SetText("Event Ends (Local Time):")
                else
                    eventEndLabel:SetText("Event Starts (Local Time):")
                end
            else
                dailyResetLabel:SetText("Next Daily Reset (Server Time):")
                if (time > getEventStartsTime()) then
                    eventEndLabel:SetText("Event Ends (Server Time):")
                else
                    eventEndLabel:SetText("Event Starts (Server Time):")
                end
            end
            lastLocalTimeSetting = newLocalTimeSetting
            end
        dailyResetTime:SetText(
            CalendarUtil.FormatCalendarTimeWeekday(nextReset) .. ", " ..
            GameTime_GetFormattedTime(nextReset.hour,nextReset.minute, true))
        if (time > getEventStartsTime()) then
            eventEndTime:SetText(
                    CalendarUtil.FormatCalendarTimeWeekday(endTime) .. ", " ..
                            GameTime_GetFormattedTime(endTime.hour,endTime.minute, true))
        else
            eventEndTime:SetText(
                    CalendarUtil.FormatCalendarTimeWeekday(startTime) .. ", " ..
                            GameTime_GetFormattedTime(startTime.hour,startTime.minute, true))
        end
    end
    local function UpdateTimer()
        local time = GetServerTime()
        if (time > nextRun) then
            while(time > nextRun) do
                nextRun = nextRun + 60 * 60 * 24
            end
            addon:UpdateScrollFrame()
        end
        setTimerText()
    end
    setTimerText()
    TCL.Events.RegisterEvent("ON_UPDATE", UpdateTimer)
end
function addon:UpdateCompleted()
    addon.eligibleCharacters = 0
    addon.completedCharacters = 0
    local characters = addon.savedVariables.account.characters
    local lastResetTimestamp = addon:GetLastResetTimestamp()
    for guid, character in pairs(characters) do
        if (character.canLootMount) then
            addon.eligibleCharacters = addon.eligibleCharacters + 1
            if (character.completedDungeon and (character.timestamp >= lastResetTimestamp)) then
                addon.completedCharacters = addon.completedCharacters + 1
            end
        end
    end
    if (totalsFont) then
        totalsFont:SetText("The Crown Chemical Co.: " .. addon.completedCharacters .. " of " .. addon.eligibleCharacters .. " completed since last reset")
    end
end
function addon:UpdateScrollFrame()
    if (scrollFrameVars) then
        scrollFrameVars.scrollFrame.update()
    end
end
local function CreateInsetTexture(frame, points, left, right, top, bottom)
    local texture = frame:CreateTexture(nil, "BACKGROUND")
    texture:SetTexture("Interface\\AddOns\\TomCats-LoveIsInTheAir\\images\\box")
    texture:SetBlendMode("MOD")
    if (points) then
        for i = 1, #points do
            local point = points[i]
            texture:SetPoint(point[1], point[2], point[3], point[4], point[5])
        end
    end
    texture:SetTexCoord(left, right, top, bottom)
    return texture
end
local function CreateInsetFrame()
    local texSizeX, texSizeY = 32, 256
    local cornerX, cornerY = 13, 14
    local insetFrame = CreateFrame("Frame")
    local topLeft = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", insetFrame, "TOPLEFT", 0, 0 },
        { "BOTTOMRIGHT", insetFrame, "TOPLEFT", cornerX, -cornerY }
    }, 0, 0.40625, 0, 0.0546875)
    local topRight = CreateInsetTexture(insetFrame, {
        { "TOPRIGHT", insetFrame, "TOPRIGHT", 0, 0 },
        { "BOTTOMLEFT", insetFrame, "TOPRIGHT", -cornerX, -cornerY }
    }, 0.59375, 1, 0, 0.0546875)
    local bottomLeft = CreateInsetTexture(insetFrame, {
        { "BOTTOMLEFT", insetFrame, "BOTTOMLEFT", 0, 0 },
        { "TOPRIGHT", insetFrame, "BOTTOMLEFT", cornerX, cornerY }
    }, 0, 0.40625, 0.9453125, 1)
    local bottomRight = CreateInsetTexture(insetFrame, {
        { "BOTTOMRIGHT", insetFrame, "BOTTOMRIGHT", 0, 0 },
        { "TOPLEFT", insetFrame, "BOTTOMRIGHT", -cornerX, cornerY }
    }, 0.59375, 1, 0.9453125, 1 )
    local left = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "BOTTOMLEFT", 0, 0 },
        { "BOTTOMRIGHT", bottomLeft, "TOPRIGHT", 0, 0 }
    }, 0, 0.40625, 0.0546875, 0.9453125 )
    local right = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topRight, "BOTTOMLEFT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "TOPRIGHT", 0, 0 }
    }, 0.59375, 1, 0.0546875, 0.9453125 )
    local top = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "TOPRIGHT", 0, 0 },
        { "BOTTOMRIGHT", topRight, "BOTTOMLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0, 0.0546875 )
    local bottom = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", bottomLeft, "TOPRIGHT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "BOTTOMLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0.9453125, 1 )
    local center = CreateInsetTexture(insetFrame, {
        { "TOPLEFT", topLeft, "BOTTOMRIGHT", 0, 0 },
        { "BOTTOMRIGHT", bottomRight, "TOPLEFT", 0, 0 }
    }, 0.40625, 0.59375, 0.0546875, 0.9453125 )
    return insetFrame
end
local namecount = 0
function InsetMixin:Show()
    local insetFrame
    if (#insetFramePool == 0) then
        namecount = namecount + 1
        insetFrame = CreateInsetFrame()
    else
        insetFrame = insetFramePool[#insetFramePool]
        insetFramePool[#insetFramePool] = nil
    end
    insetFrame:SetParent(self.page.frame)
    self.frame = insetFrame
    for i = 1, #self.points do
        local point = self.points[i]
        insetFrame:SetPoint(point[1], point[2].frame or point[2], point[3], point[4], point[5])
    end
end
