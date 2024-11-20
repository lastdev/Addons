local ADDON_NAME, Peta = ...

---@type Debuggers -- IntelliJ-EmmyLua annotation
local debug = Peta.Debug:newDebugger(Peta.DEBUG_LEVEL.ERROR)

-------------------------------------------------------------------------------
-- Peta Data
-------------------------------------------------------------------------------

Peta.hookedBagSlots = {}
Peta.EventHandlers = {}
local didLastDitchHookAttempt

-------------------------------------------------------------------------------
-- Namespace Manipulation
--
-- I want the ability to give variables and functions SIMPLE names
-- without fear of colliding with the names inside other addons.
-- Thus, I leverage Lua's "set function env" (setfenv) to
-- restrict all of my declarations to my own private "namespace"
-- Now, I can create "Local" functions without needing the local keyword
-------------------------------------------------------------------------------

local _G = _G -- but first, grab the global namespace or else we lose it
setmetatable(Peta, { __index = _G }) -- inherit all member of the Global namespace
setfenv(1, Peta) -- replace the Global namespace with the Peta table

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

local INCLUDE_BANK = true -- TODO: make this a config option?
local INCLUDE_CAGED_PET = true -- TODO: make this a config option?
local MAX_INDEX_FOR_CARRIED_BAGS = NUM_BAG_FRAMES -- Bliz blobal
local MAX_INDEX_FOR_CARRIED_AND_BANK_BAGS = NUM_CONTAINER_FRAMES -- Bliz global
local BIGGEST_BAG = 64

---@class CAGEY -- IntelliJ-EmmyLua annotation
local CAGEY = {
    CAN_CAGE = 1,
    HAS_NONE = 2,
    UNCAGEABLE = 3,
    NOT_PET = 4,
}

-------------------------------------------------------------------------------
-- Event Handlers
-------------------------------------------------------------------------------

function EventHandlers:ADDON_LOADED(addonName)
    if addonName == ADDON_NAME then
        debug.trace:print("ADDON_LOADED", addonName)
    end
end

function EventHandlers:PLAYER_LOGIN()
    debug.trace:print("PLAYER_LOGIN")
end

function EventHandlers:PLAYER_ENTERING_WORLD(isInitialLogin, isReloadingUi)
    debug.trace:out("",1,"PLAYER_ENTERING_WORLD", "isInitialLogin",isInitialLogin, "isReloadingUi",isReloadingUi)
    initalizeAddonStuff()
end

-------------------------------------------------------------------------------
-- Event Handler Registration
-------------------------------------------------------------------------------

function createEventListener(targetSelfAsProxy, eventHandlers)
    debug.info:print(ADDON_NAME .. " EventListener:Activate() ...")

    local dispatcher = function(listenerFrame, eventName, ...)
        -- ignore the listenerFrame and instead
        eventHandlers[eventName](targetSelfAsProxy, ...)
    end

    local eventListenerFrame = CreateFrame("Frame")
    eventListenerFrame:SetScript("OnEvent", dispatcher)

    for eventName, _ in pairs(eventHandlers) do
        debug.info:print("EventListener:activate() - registering " .. eventName)
        eventListenerFrame:RegisterEvent(eventName)
    end
end

-------------------------------------------------------------------------------
-- Addon Lifecycle
-------------------------------------------------------------------------------

function initalizeAddonStuff()
    -- modify the tooltip behavior
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, addHelpTextToToolTip)
    if INCLUDE_CAGED_PET then
        --TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.AllTypes, addHelpTextToToolTip)
        --TooltipDataProcessor.AddTooltipPostCall("ALL", addHelpTextToToolTip)
        -- Neither of the above affect the tooltip produced when the user points at a caged pet in the inventory.
        -- With tenacious consistency, the Bliz API never fails to disappoint and confound.  Facepalm.
    end

    -- modify the behavior of clicking on items in your inventory
    hookAllBagsOnShow()
    ContainerFrameCombinedBags:HookScript("OnShow", hookUnibagSlots)
    if INCLUDE_BANK then
        BankFrame:HookScript("OnShow", hookBankSlots)
    end
end

-------------------------------------------------------------------------------
-- Tooltip "Local" Functions
-------------------------------------------------------------------------------

function findBagWithMouseFocus()
    if GetMouseFocus then --v10
        return GetMouseFocus()
    end

    local foci  = GetMouseFoci() --v11
    for i, frame in ipairs(foci) do
        if frame.GetBagID and frame:GetBagID() then return frame end
    end
end

function addHelpTextToToolTip(tooltip, data)
    if tooltip ~= GameTooltip then return end

    local itemId = data.id
    local cagey = canCageThisPet(itemId)
    local notPet = cagey == CAGEY.NOT_PET
    if notPet then return end

    local bag = findBagWithMouseFocus()

    if not bag then return end

    local hasPeta = bag.hasPeta
    if not hasPeta then
        local didHook = hookSlot(bag)
        if didHook then return end
    end

    if CAGEY.HAS_NONE == cagey then
        return
    elseif not hasPeta then
        GameTooltip:AddLine(Peta.L10N.PETA_HOOKS_FAILED, 0, 1, 0)
    elseif CAGEY.CAN_CAGE == cagey then
        GameTooltip:AddLine(Peta.L10N.TOOLTIP, 0, 1, 0)
    elseif CAGEY.UNCAGEABLE == cagey then
        GameTooltip:AddLine(Peta.L10N.TOOLTIP_CANNOT_CAGE, 0, 1, 0)
    end
end

-------------------------------------------------------------------------------
-- Pet "Local" Functions
-------------------------------------------------------------------------------

---@return CAGEY -- IntelliJ-EmmyLua annotation
function canCageThisPet(itemId)
    local returnStatus
    local _, _, _, _, _, _, _, _, canTrade, _, _, _, speciesID = C_PetJournal.GetPetInfoByItemID(itemId)
    if speciesID then
        if canTrade then
            local numCollected, _ = C_PetJournal.GetNumCollectedInfo(speciesID)
            returnStatus = (numCollected > 0) and CAGEY.CAN_CAGE or CAGEY.HAS_NONE
        else
            returnStatus = CAGEY.UNCAGEABLE
        end
    else
        returnStatus = CAGEY.NOT_PET
    end
    return returnStatus
end

function hasPet(petGuid)
    debug.trace:print("hasPet():", petGuid)
    if not petGuid then return false end
    local speciesID = C_PetJournal.GetPetInfoByPetID(petGuid)
    local numCollected, _ = C_PetJournal.GetNumCollectedInfo(speciesID)
    return numCollected > 0
end

function getPetInfoFromThisBagSlot(bagSlotFrame)
    if not bagSlotFrame.GetSlotAndBagID then return end -- some addons copy Peta onto a non bagSlotFrame
    local slotId, bagIndex = bagSlotFrame:GetSlotAndBagID()
    if not (slotId and bagIndex) then return end -- some addons copy Peta onto a non bagSlotFrame
    local itemId = C_Container.GetContainerItemID(bagIndex, slotId)
    -- callback to handle the fact that Bliz's GetPetInfoByItemID doesn't understand caged pets.  Facepalm.
    local cagedPetAnalyzer = function()
        return getNameFromHyperlink(bagIndex, slotId)
    end
    return getPetInfoFromThisItemId(itemId, cagedPetAnalyzer)
end

function getPetInfoFromThisItemId(itemId, cagedPetAnalyzer)
    local returnPetInfo
    debug.info:out(">",3, "getPetFromThisBagSlot()", "itemId",itemId)
    if itemId then
        local petName, _, _, _, _, _, _, _, canTrade, _, _, _, speciesId = C_PetJournal.GetPetInfoByItemID(itemId)

        if not petName and INCLUDE_CAGED_PET and cagedPetAnalyzer then
            -- Oh GOODY. Bliz's GetPetInfoByItemID() provides zilch from a caged pet.  Thanks Bliz!
            petName = cagedPetAnalyzer() or nil
            canTrade = petName and true -- assume that any pet in a cage can be caged... but, this is Bliz API, so wtf knows.
        end

        if petName then
            debug.info:out(">",5, "getPetFromThisBagSlot()", "petName",petName, "speciesId",speciesId)
            local _, petGuid = C_PetJournal.FindPetIDByName(petName)
            local hasPet = hasPet(petGuid)
            debug.info:out(">",5, "getPetFromThisBagSlot()", "petGuid",petGuid, "hasPet",hasPet)
            returnPetInfo = {
                petGuid = petGuid,
                petName = petName,
                itemId = itemId,
                bagIndex = bagIndex,
                slotId = slotId,
                canTrade = canTrade,
                hasPet = hasPet,
            }
        end
    end

    return returnPetInfo
end

function getNameFromHyperlink(bagIndex, slotId)
    local d = C_Container.GetContainerItemInfo(bagIndex, slotId)

    -- Now I get to parse the hyperlink text because inexplicably,
    -- Bliz's GetContainerItemInfo() doesn't include name (the mind boggles)
    -- and adding insult to injury, C_Item.GetItemNameByID() only provides "Pet Cage" [facepalm]
    local str = d.hyperlink
    if not str then return nil end

    -- verify this is a pet cage
    local isPet = string.find(str, "battlepet") and true or false
    debug.info:out("#",3,"squeezeBloodFromStone()", "isPet",isPet)
    if not isPet then return nil end

    -- assume the name is inside [Brackets].
    local start = string.find(str, "[[]") -- search patterns are funky!  google "regular expression"
    local stop = string.find(str, "]")
    debug.info:out("#",3,"squeezeBloodFromStone()", "start",start, "stop",stop)
    if not (start and stop) then return nil end

    -- move the indices to strip the brackets off the [Name] so it just leaves the name
    start = start + 1
    stop = stop - 1
    if (start >= stop) then return nil end -- the Bliz API could have given me bulshit data such as an empty name []

    local name = string.sub(str, start, stop)
    debug.trace:out("#",3,"squeezeBloodFromStone()", "name",name)
    return name
end

-------------------------------------------------------------------------------
-- Bag and Inventory Click Hooking "Local" Functions
-------------------------------------------------------------------------------

function tryLastDitchHookAttempt()
    if didLastDitchHookAttempt then
        return
    end
    didLastDitchHookAttempt = true

    debug.info:out(X,10,"tryLastDitchHookAttempt()")

    for c = 1, MAX_INDEX_FOR_CARRIED_AND_BANK_BAGS do
        for slot=1, BIGGEST_BAG do
            local name = "ContainerFrame"..c.."Item"..slot
            local slotFrame = _G[name];
            if slotFrame then
                debug.info:out(X,5,"tryLastDitchHookAttempt()", "c",c, "slot",slot, "name",name, "slotFrame",slotFrame)
                hookSlot(slotFrame)
            end
        end
    end
end

function hookAllBagsOnShow()
    local maxBagIndex = (INCLUDE_BANK) and MAX_INDEX_FOR_CARRIED_AND_BANK_BAGS or MAX_INDEX_FOR_CARRIED_BAGS
    for i = 0, maxBagIndex do
        local unreliableBagFrame = getUnreliableBagFrame(i)
        if not unreliableBagFrame then return end

        -- HOOK FUNC
        function showMe(bagFrame)
            local bagIndex = bagFrame:GetBagID()
            debug.info:out("",1, "OnShow", "i", i, "IsBagOpen(i)", IsBagOpen(i), "-- bagIndex", bagIndex, "IsBagOpen(bagIndex)", IsBagOpen(bagIndex))
            if isValidBagFrame(bagFrame) then
                hookBagSlots(bagFrame)
            else
                -- Bliz API provided an uninitialized bag frame.
                -- force the bag to reopen itself
                --OpenBag(bagIndex, true) -- THIS!  This is the cause of taint!  FUCK YOU! FUCK YOU! FUCK YOU!
                --securecallfunction(OpenBag, bagIndex, force) -- not so "secure" is it?!  THIS CAUSES TAINT TOO

                debug.info:out("=",7, "FORCING bag to reopen...", "bagIndex",bagIndex)
                OpenBag(bagIndex) -- this does NOT cause taint.  Hallelujah

                -- RECURSIVE HOOK FUNC
                local delaySeconds = 1
                C_Timer.After(delaySeconds, function()
                    showMe(bagFrame)
                end)

            end
        end

        unreliableBagFrame:HookScript("OnShow", showMe)
    end
end

-- I can't rely on Bliz's global structures to actually have the on-screen bag frame :(
-- but it seems to work if I just want to react to the OnShow event
function getUnreliableBagFrame(bagIndex)
    -- bagIndex: 0..n
    local bagId = bagIndex + 1
    local bagFrameId = "ContainerFrame" .. bagId
    local unreliableBagFrame = _G[bagFrameId]
    return unreliableBagFrame
end

-- I can't rely on Bliz's API to provide me with a valid bag with the proper contents :(
-- check #1 - verify that all slots in this bag think they are in the same bag
function isValidBagFrame(bagFrame)
    local supposedBagIndex
    for i, bagSlotFrame in bagFrame:EnumerateValidItems() do
        if not bagSlotFrame.GetSlotAndBagID then return false end -- some addons copy Peta onto a non bagSlotFrame
        local slotId, reportedBagIndex = bagSlotFrame:GetSlotAndBagID()
        if (not supposedBagIndex) then supposedBagIndex = reportedBagIndex end
        if (supposedBagIndex ~= reportedBagIndex) then
            return false
        end
    end
    return true
end

function hookBagSlots(bagFrame)
    local bagIndex = bagFrame:GetBagID()
    local bagName = C_Container.GetBagName(bagIndex) or "BLANK"
    local bagSize = C_Container.GetContainerNumSlots(bagIndex) -- UNRELIABLE (?)
    local isOpen = IsBagOpen(bagIndex)
    local isHeldBag = isHeldBag(bagIndex)
    debug.info:out("=",5, "hookBagToAddHooks()...", "bagFrame",bagFrame, "bagIndex", bagIndex, "name", bagName, "size", bagSize, "isOpen", isOpen, "isHeldBag", isHeldBag)

    for i, bagSlotFrame in bagFrame:EnumerateValidItems() do
        hookSlot(bagSlotFrame)
    end
end

function hookUnibagSlots(unibagFrame)
    for i, slot in ipairs(unibagFrame.Items) do
        hookSlot(slot)
    end
end

function hookBankSlots(bankSlotsFrame)
    for i=1, NUM_BANKGENERIC_SLOTS, 1 do
        local bankSlotFrame = bankSlotsFrame["Item"..i];
        hookSlot(bankSlotFrame)
    end
end

function hookSlot(slotFrame)
    local didHook = false
    if not Peta.hookedBagSlots[slotFrame] then
        Peta.hookedBagSlots[slotFrame] = true
        slotFrame:HookScript("PreClick", handleCagerClick)
        slotFrame.hasPeta = true
        didHook = true

        if debug.info:isActive() and bagSlotFrame.GetSlotAndBagID then
            local slotId, bagIndex = slotFrame:GetSlotAndBagID()
            debug.trace:out("=",7, "hookBagSlots()", "bagIndex",bagIndex, "slotId",slotId)
        end
    end
    return didHook
end

function handleCagerClick(bagSlotFrame, whichMouseButtonStr, isPressed)
    local petInfo = getPetInfoFromThisBagSlot(bagSlotFrame)
    if not petInfo then
        if not bagSlotFrame.GetSlotAndBagID then return end -- some addons copy Peta onto a non bagSlotFrame
        local slotId, bagIndex = bagSlotFrame:GetSlotAndBagID()
        debug.info:out("",1, "handleCagerClick()... abort! NO PET at", "bagIndex",bagIndex, "slotId",slotId)
        return
    end

    local isShiftRightClick = IsShiftKeyDown() and whichMouseButtonStr == "RightButton"
    if not isShiftRightClick then
        debug.info:print("handleCagerClick()... abort!  NOT IsShiftKeyDown", IsShiftKeyDown(), "or wrong whichMouseButtonStr", whichMouseButtonStr)
        return
    end

    if not petInfo.canTrade then
        debug.info:print("handleCagerClick()... abort! untradable pet:", petInfo.petName)
        UIErrorsFrame:AddMessage(Peta.L10N.TOOLTIP_CANNOT_CAGE, 1.0, 0.1, 0.0)
        return
    end

    if not petInfo.hasPet then
        debug.info:print("handleCagerClick()... abort! NONE LEFT:", petInfo.petName)
        UIErrorsFrame:AddMessage(Peta.L10N.MSG_HAS_NONE, 1.0, 0.1, 0.0)
        return
    end

    debug.info:print("handleCagerClick()... CAGING:", petInfo.petName)
    C_PetJournal.CagePetByID(petInfo.petGuid)
end

function isHeldBag(bagIndex)
    return bagIndex >= Enum.BagIndex.Backpack and bagIndex <= NUM_TOTAL_BAG_FRAMES;
end

-------------------------------------------------------------------------------
-- OK, Go for it!
-------------------------------------------------------------------------------

createEventListener(Peta, Peta.EventHandlers)
