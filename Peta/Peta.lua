local ADDON_NAME, Peta = ...
local debug = Peta.DEBUG.newDebugger(Peta.DEBUG.ERROR)

-------------------------------------------------------------------------------
-- Peta Data
-------------------------------------------------------------------------------

Peta.NAMESPACE = {}
Peta.hookedBagSlots = {}
Peta.EventHandlers = {}

-------------------------------------------------------------------------------
-- Global Functions
-------------------------------------------------------------------------------

function Peta_Foo()
    -- no global functions yet
end

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
setmetatable(Peta.NAMESPACE, { __index = _G }) -- inherit all member of the Global namespace
setfenv(1, Peta.NAMESPACE)

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

local MAX_BAG_INDEX = NUM_TOTAL_BAG_FRAMES

-------------------------------------------------------------------------------
-- Event Handlers
-------------------------------------------------------------------------------

local EventHandlers = Peta.EventHandlers -- just for shorthand

function EventHandlers:ADDON_LOADED(addonName)
    if addonName == ADDON_NAME then
        debug.trace:print("ADDON_LOADED", addonName)
    end
end

function EventHandlers:PLAYER_LOGIN()
    debug.trace:print("PLAYER_LOGIN")
    initalizeAddonStuff()
end

function EventHandlers:PLAYER_ENTERING_WORLD(isInitialLogin, isReloadingUi)
    debug.trace:out("",1,"PLAYER_ENTERING_WORLD", "isInitialLogin",isInitialLogin, "isReloadingUi",isReloadingUi)
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
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, addHelpTextToToolTip)
    hookAllBags()
end

-------------------------------------------------------------------------------
-- Tooltip "Local" Functions
-------------------------------------------------------------------------------

function addHelpTextToToolTip(tooltip, data)
    if tooltip == GameTooltip then
        local itemId = data.id
        if hasThePetTaughtByThisItem(itemId) then
            GameTooltip:AddLine(Peta.L10N.TOOLTIP, 0, 1, 0)
        end
    end
end

-------------------------------------------------------------------------------
-- Pet "Local" Functions
-------------------------------------------------------------------------------

function hasThePetTaughtByThisItem(itemId)
    local _, _, _, _, _, _, _, _, _, _, _, _, speciesID = C_PetJournal.GetPetInfoByItemID(itemId)
    if (speciesID) then
        local numCollected, _ = C_PetJournal.GetNumCollectedInfo(speciesID)
        return numCollected > 0
    else
        return false
    end
end

function getPetFromThisBagSlot(bagSlotFrame)
    local returnPetInfo
    local slotId, bagIndex = bagSlotFrame:GetSlotAndBagID()
    local itemId = C_Container.GetContainerItemID(bagIndex, slotId)
    --debug.info:out(">",1, "getPetFromThisBagSlot()", "bagIndex",bagIndex, "slotId",slotId, "itemId",itemId)
    if itemId then
        local petName, _ = C_PetJournal.GetPetInfoByItemID(itemId)
        if petName then
            debug.info:out(">",2, "getPetFromThisBagSlot()", "petName",petName)
            local _, petGuid = C_PetJournal.FindPetIDByName(petName)
            debug.info:out(">",2, "getPetFromThisBagSlot()", "petGuid",petGuid)
            returnPetInfo = {
                petGuid = petGuid,
                petName = petName,
                itemId = itemId,
                bagIndex = bagIndex,
                slotId = slotId,
            }
        end
    end

    return returnPetInfo
end

function hasPet(petGuid)
    debug.trace:print("hasPet():", petGuid)
    if not petGuid then return false end
    local speciesID = C_PetJournal.GetPetInfoByPetID(petGuid)
    local numCollected, _ = C_PetJournal.GetNumCollectedInfo(speciesID)
    return numCollected > 0
end

-------------------------------------------------------------------------------
-- Bag and Inventory Click Hooking "Local" Functions
-------------------------------------------------------------------------------

function hookAllBags()
    for i = 0, MAX_BAG_INDEX do
        local unreliableBagFrame = getUnreliableBagFrame(i)

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
        local slotId, bagIndex = bagSlotFrame:GetSlotAndBagID()
        debug.info:out("=",7, "hookBagSlots()...", "i",i, "bagIndex",bagIndex, "slotId",slotId)
        if not Peta.hookedBagSlots[bagSlotFrame] then
            Peta.hookedBagSlots[bagSlotFrame] = true
            --addSimpleClickHandler(bagSlotFrame)
            local success = bagSlotFrame:HookScript("PreClick", handleCagerClick)
        end
    end
end

function handleCagerClick(bagSlotFrame, whichMouseButtonStr, isPressed)
    local petInfo = getPetFromThisBagSlot(bagSlotFrame)

    if not petInfo then
        local slotId, bagIndex = bagSlotFrame:GetSlotAndBagID()
        debug.info:out("",1, "handleCagerClick()... abort! NO PET at", "bagIndex",bagIndex, "slotId",slotId)
        return
    end

    local isShiftRightClick = IsShiftKeyDown() and whichMouseButtonStr == "RightButton"
    if not isShiftRightClick then
        debug.info:print("handleCagerClick()... abort!  NOT IsShiftKeyDown", IsShiftKeyDown(), "or wrong whichMouseButtonStr", whichMouseButtonStr)
        return
    end

    if not hasPet(petInfo.petGuid) then
        debug.info:print("handleCagerClick()... abort! NONE LEFT:", petInfo.petName)
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
