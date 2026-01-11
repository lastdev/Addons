local T = AngleurUnderlight_Translate
local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)

local debugChannel = 0

AngleurUnderlight_MainFishingRod = {
    name = nil,
    link = nil,
    itemID = nil,
    icon = nil
}

AngleurUnderlightConfig = {
    waterwalking = false,
    delveMode = false
}

local queue = AngleurUnderlight_Queue
local UNDERLIGHT = 133755
local angLoaded = AngleurUnderlight_AngLoaded

function AngleurUnderlight_SavedVariables()
    if not AngleurUnderlightConfig then
        AngleurUnderlightConfig = {}
    end
    if AngleurUnderlightConfig.waterwalking == nil then
        AngleurUnderlightConfig.waterwalking = false
    end

    if AngleurUnderlightConfig.delveMode == nil then
        AngleurUnderlightConfig.delveMode = false
    end
end

function AngleurUnderlight_UpdateButton(self)
    if AngleurUnderlight_MainFishingRod.name then
        self.icon:SetTexture(AngleurUnderlight_MainFishingRod.icon)
        self.removeRod:Show()
            self.tooltipTitle = AngleurUnderlight_MainFishingRod.link .. T["\nset as Main Fishing Rod."]
            self.tooltipText = T["\nWhen you start swimming, the " .. colorUnderlight:WrapTextInColorCode("Underlight Angler ") .. " will be " 
            .. "equipped to trigger the buff.\n\nWhen you stop swimming, your main fishing rod will be re-equipped"]
    else
        self.removeRod:Hide()
        self.icon:SetTexture()
        self.tooltipTitle = T["No main fishing rod set"]
        self.tooltipText = T["\nYour " .. colorUnderlight:WrapTextInColorCode("Underlight Angler ") 
        .. "will be swapped in and out to keep the buff active when you start/stop swimming.\n\n" 
        .. colorYello:WrapTextInColorCode("Drag ") .. "a fishing rod here to set it as main."]
    end
end

function AngleurUnderlight_RemoveMainRod(self)
    AngleurUnderlight_MainFishingRod.name = nil
    AngleurUnderlight_MainFishingRod.link = nil
    AngleurUnderlight_MainFishingRod.itemID = nil
    AngleurUnderlight_MainFishingRod.icon = nil
    local parent = self:GetParent()
    AngleurUnderlight_UpdateButton(parent)
end

function AngleurUnderlight_GrabFishingRod(self)
    Angleur_BetaPrint(debugChannel, "I wonder if this is a fishing rod.")
    if InCombatLockdown() then
        ClearCursor()
        print(T["Can't drag item in combat."])
        return
    end
    local itemLoc = C_Cursor.GetCursorItem()
    local itemID = C_Item.GetItemID(itemLoc)
    if not C_Item.IsEquippableItem(itemID) then
        print(T["Not an equippable item. Please drag in your main fishing rod."])
        ClearCursor()
        return
    end
    local profession = C_TradeSkillUI.GetProfessionForCursorItem()
    if profession ~= 10 then
        print(T["Not a fishing rod. Please drag in your main fishing rod."])
        ClearCursor()
        return
    end
    local itemInfo = {C_Item.GetItemInfo(itemID)}
    if itemInfo[9] ~= "INVTYPE_PROFESSION_TOOL" then
        print(T["Item is equippable and fishing related, but not a fishing rod. Please drag in your main fishing rod."])
        ClearCursor()
        return
    end
    if itemID == UNDERLIGHT then
        print(colorUnderlight:WrapTextInColorCode("Angleur_Underlight: ") .. T[" the draggable item slot is reserved fishing rods that are NOT the " 
        .. colorUnderlight:WrapTextInColorCode("Underlight Angler. ") .. "If you would like to use the Underlight Angler as your \'Main\' fishing rod, " 
        .. "you can keep the box empty."])
        ClearCursor()
        return
    end
    AngleurUnderlight_MainFishingRod.name = itemInfo[1]
    AngleurUnderlight_MainFishingRod.link = itemInfo[2]
    AngleurUnderlight_MainFishingRod.itemID = itemID
    AngleurUnderlight_MainFishingRod.icon = itemInfo[10]
    AngleurUnderlight_UpdateButton(self)
    ClearCursor()
end
-- /dump IsSwimming("player")
-- /dump IsSubmerged("player")
-- /dump C_PlayerInfo.GetGlidingInfo()

function AngleurUnderlight_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ADDON_LOADED")
    self:SetScript("OnEvent", AngleurUnderlight_EventLoader)
    if angLoaded then
        self:SetParent(Angleur_ConfigPanel)
        self:SetPoint("TOPLEFT", Angleur_ConfigPanel, "TOPRIGHT", 0, -30)
    else
        self:SetParent(Angleur_Underlight_NoAngleurFrame)
        self:SetPoint("TOPRIGHT", Angleur_Underlight_NoAngleurFrame, "TOPRIGHT", -32, -36)
    end
end

function AngleurUnderlight_EventLoader(self, event, unit, ...)
    if event == "ADDON_LOADED" and unit == "Angleur_Underlight" then
        AngleurUnderlight_SavedVariables()
        AngleurUnderlight_CollapseConfig_LoadSavedVars(self.collapseConfig)
    elseif event == "PLAYER_ENTERING_WORLD" then
        AngleurUnderlight_UpdateButton(self)
        if not AngleurUnderlight_FirstInstall then
            self.firstInstall:Show()
            if angLoaded then
                Angleur_ConfigPanel:Show()
            else
                Angleur_Underlight_NoAngleurFrame:Show()
            end
            AngleurUnderlight_FirstInstall = true
        end
    end
end

local function isEligible(itemID)
    if not C_Item.IsEquippableItem(itemID) then return false end
    if not (C_Item.GetItemCount(itemID) >= 1) then
        return false
    end
    return true
end
local function checkWaterwalking()
    if not angLoaded then return false end
    if AngleurUnderlightConfig.waterwalking == false then return false end
    if AngleurCharacter.sleeping == false then return false end
    -- true if they have angleur, it is on sleep mode, and they have checked the waterwalking checkbox
    return true
end
local function checkReEquip()
    if InCombatLockdown() then return false end
    local mainRod = AngleurUnderlight_MainFishingRod.itemID
    if not mainRod then return end
    if not isEligible(mainRod) then 
        print(T["The main fishing rod not found in bags. Cannot swap."])
        if not angLoaded then
            print(colorYello:WrapTextInColorCode("/undang") .. T[" to open up the configuration if you'd like to change/remove the main fishing rod."])
        end
        return 
    end
    if checkWaterwalking() == true then
        --skip the unequip so the waterwalking buff stays
        return
    end

    local mainRodEquipped = C_Item.IsEquippedItem(mainRod)
    if mainRodEquipped then
        -- do nothing
    else
        queue.unequip = false
        queue.equip = mainRod
        AngleurUnderlight_HandleQueue()
    end
end

local function checkEquip()
    if InCombatLockdown() then return false end
    if not isEligible(UNDERLIGHT) then 
        print(T["Underlight Angler not found in bags. Cannot equip."])
        return
    end
    local fishingAura = C_UnitAuras.GetPlayerAuraBySpellID(394009)
    local underlightEquipped = C_Item.IsEquippedItem(UNDERLIGHT)
    Angleur_BetaPrint(debugChannel, "fishing aura: ", fishingAura, "\nunderlight equipped: ", underlightEquipped)
    if fishingAura then
        if underlightEquipped then
            --do nothing
        else
            queue.unequip = false
            queue.equip = UNDERLIGHT
            AngleurUnderlight_HandleQueue()
        end
    else
        if underlightEquipped then
            queue.unequip = true
            queue.equip = UNDERLIGHT
            AngleurUnderlight_HandleQueue()
        else
            queue.unequip = false
            queue.equip = UNDERLIGHT
            AngleurUnderlight_HandleQueue()
        end
    end
end
    
local inDelve = false
local wasSwimming = false
local swimdelayFrame = CreateFrame("Frame")
swimdelayFrame:Show()
local function checkSwimOrBreath()
    if IsSwimming() then
        return true
    elseif AngleurUnderlightConfig.delveMode == true and GetMirrorTimerProgress("BREATH") ~= 0 then
        return true
    end
    return false
end
function AngleurUnderlight_Events(self, event, unit)
    if event == "PLAYER_REGEN_DISABLED" then
        queue.unequip = false
        queue.equip = nil
        AngleurUnderlight_HandleQueue()
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- need to delay after exiting combat a little bit otherwise the fish form doesn't trigger
        if checkSwimOrBreath() then
            wasSwimming = true
            checkEquip()
        elseif wasSwimming == true then
            wasSwimming = false
            checkReEquip()
        end
    elseif event == "MOUNT_JOURNAL_USABILITY_CHANGED" or "MIRROR_TIMER_START" then
        -- No need to check for it all when in combat, + "wasSwimming" needs to stay unchanged during combat
        if InCombatLockdown() then return end
        Angleur_SingleDelayer(1, 0, 0.2, swimdelayFrame, function()
            if checkSwimOrBreath() then
                wasSwimming = true
                Angleur_BetaPrint(debugChannel, "swimming start")
                checkEquip()
                return true
            else
                if wasSwimming == true then
                    if AngleurUnderlight_CheckDelve() == true then
                        -- do nothing
                    else
                        wasSwimming = false
                        Angleur_BetaPrint(debugChannel, "was swimming")
                        checkReEquip()
                    end
                end
            end
        end,
        function()
            if checkSwimOrBreath() then
                wasSwimming = true
                Angleur_BetaPrint(debugChannel, "swimming started")
                checkEquip()
            else
                if wasSwimming == true then
                    local inInstance, instanceType = IsInInstance()
                    if AngleurUnderlight_CheckDelve() == true then
                        -- do nothing
                    else
                        wasSwimming = false
                        Angleur_BetaPrint(debugChannel, "was swimming")
                        checkReEquip()
                    end
                end
                Angleur_BetaPrint(debugChannel, "player is not swimming, but also wasn't swimming before")
            end
        end)
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("MOUNT_JOURNAL_USABILITY_CHANGED")
eventFrame:RegisterEvent("MIRROR_TIMER_START")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:SetScript("OnEvent", AngleurUnderlight_Events)

function AngleurUnderlight_CheckDelve()
    if not AngleurUnderlightConfig.delveMode then return false end 
    local inInstance, instanceType = IsInInstance()
    if not inInstance or instanceType ~= "scenario" then return false end
    Angleur_BetaPrint(debugChannel, "Inside delve, and using breath mode. Don't unequip.")
    return true
end

function AngleurUnderlight_AngleurWakeUpPing()
    checkReEquip()
end