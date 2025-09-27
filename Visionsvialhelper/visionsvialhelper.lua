local addonName, addon = ...
VisionsVialHelperDB = VisionsVialHelperDB or {}

-- Valid instance IDs for loading
local validInstanceIDs = {2404, 2403, 2828, 2827}

-- Potion color cycle and effects
local potionColors = {"Black", "Green", "Red", "Blue", "Purple"}
local potionEffects = {
    ["Bad"] = "Poison",
    ["Good"] = "+100 Sanity",
    ["Sickening"] = "5% Defensive",
    ["Sluggish"] = "2% Healing",
    ["Spicy"] = "Breath fire"
}

-- Create the main frame
local frame = CreateFrame("Frame", "VisionsVialHelperFrame", UIParent, "BasicFrameTemplateWithInset")
frame:SetSize(160, 135) -- Increased width and height for vertical layout and effect text
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:Hide()

-- Title
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.title:SetPoint("TOP", -12, -5)
frame.title:SetText("Click the BAD Vial")

-- Create separate toggle frame
local toggleFrame = CreateFrame("Frame", "VisionsVialHelperToggleFrame", UIParent, "BackdropTemplate")
toggleFrame:SetSize(135, 45) -- Increased size for easier grabbing
toggleFrame:SetPoint("TOP", UIParent, "TOP", 0, -100)
toggleFrame:SetMovable(true)
toggleFrame:EnableMouse(true)
toggleFrame:RegisterForDrag("LeftButton")
toggleFrame:SetScript("OnDragStart", function(self)
    if not InCombatLockdown() then
        self:StartMoving()
        self:SetBackdropColor(0.2, 0.2, 0.2, 0.9) -- Slightly lighter when dragging
    end
end)
toggleFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    self:SetBackdropColor(0, 0, 0, 0.8) -- Restore original color
end)
toggleFrame:Hide()

-- Add a simple backdrop to make the toggle frame visible
toggleFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {left = 4, right = 4, top = 4, bottom = 4}
})
toggleFrame:SetBackdropColor(0, 0, 0, 0.8)

-- Add a texture to indicate draggability
local dragTexture = toggleFrame:CreateTexture(nil, "BACKGROUND")
dragTexture:SetColorTexture(1, 1, 1, 0.1)
dragTexture:SetAllPoints(toggleFrame)

-- Create toggle button in the toggle frame
local toggleButton = CreateFrame("Button", nil, toggleFrame, "UIPanelButtonTemplate")
toggleButton:SetSize(120, 30) -- Slightly larger button
toggleButton:SetPoint("CENTER", toggleFrame, "CENTER", 0, 0)
toggleButton:SetText("Toggle UI")
toggleButton:SetScript("OnClick", function()
    if frame:IsShown() then
        frame:Hide()
        toggleButton:SetText("Show BAD Vial")
    else
        frame:Show()
        toggleButton:SetText("Hide BAD Vial")
    end
end)

-- Create color buttons and effect text displays
local buttons = {}
local effectTexts = {}
local function CreateColorButton(color, y)
    local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    button:SetSize(48, 20)
    button:SetPoint("TOPLEFT", 10, y)
    button:SetText(color)
    button:SetScript("OnClick", function()
        addon:UpdatePotionEffects(color)
    end)
    buttons[color] = button

    -- Create a text field next to each button for effect display
    local effectText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    effectText:SetPoint("LEFT", button, "RIGHT", 8, 0)
    effectText:SetWidth(170)
    effectText:SetJustifyH("LEFT")
    effectText:SetText("") -- Initially empty
    effectTexts[color] = effectText
end

-- Position buttons vertically
local yOffset = -25
for i, color in ipairs(potionColors) do
    CreateColorButton(color, yOffset - (i-1) * 20) -- Stack vertically with 20px spacing
end

-- Function to check if player is in valid instance
local function IsInValidInstance()
    local _, _, _, _, _, _, _, instanceID = GetInstanceInfo()
    for _, id in ipairs(validInstanceIDs) do
        if instanceID == id then
            return true
        end
    end
    return false
end

-- Function to update potion effects based on bad color
function addon:UpdatePotionEffects(badColor)
    local badIndex
    for i, color in ipairs(potionColors) do
        if color == badColor then
            badIndex = i
            break
        end
    end

    -- Calculate effect assignments based on the cycle
    local effectAssignments = {}
    effectAssignments[potionColors[badIndex]] = potionEffects["Bad"]
    effectAssignments[potionColors[(badIndex%5)+1]] = potionEffects["Good"]
    effectAssignments[potionColors[((badIndex+1)%5)+1]] = potionEffects["Sickening"]
    effectAssignments[potionColors[((badIndex+2)%5)+1]] = potionEffects["Sluggish"]
    effectAssignments[potionColors[((badIndex+3)%5)+1]] = potionEffects["Spicy"]

    -- Update individual text displays next to each button
    for _, color in ipairs(potionColors) do
        effectTexts[color]:SetText(effectAssignments[color])
    end

    -- Save the bad color
    VisionsVialHelperDB.badColor = badColor
end

-- Slash command to show/hide the frame
SLASH_VISIONSVIALHELPER1 = "/vvh"
SlashCmdList["VISIONSVIALHELPER"] = function()
    if IsInValidInstance() then
        if frame:IsShown() then
            frame:Hide()
            toggleButton:SetText("Show BAD Vial")
        else
            frame:Show()
            toggleButton:SetText("Hide BAD Vial")
        end
    else
        print("VisionsVialHelper: COGS: This addon only works in Horrific Visions (instance IDs: 2404, 2403, 2828)")
    end
end

-- Initialize on addon load and instance change
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        if IsInValidInstance() then
            if VisionsVialHelperDB.badColor then
                addon:UpdatePotionEffects(VisionsVialHelperDB.badColor)
            end
            frame:Show()
            toggleButton:SetText("Hide BAD Vial")
            toggleFrame:Show()
        else
            frame:Hide()
            toggleFrame:Hide()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        if IsInValidInstance() then
            if VisionsVialHelperDB.badColor then
                addon:UpdatePotionEffects(VisionsVialHelperDB.badColor)
            end
            frame:Show()
            toggleButton:SetText("Hide BAD Vial")
            toggleFrame:Show()
        else
            frame:Hide()
            toggleFrame:Hide()
        end
    end
end)