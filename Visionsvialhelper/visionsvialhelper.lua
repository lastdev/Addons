local addonName, addon = ...

--Initialize saved variables with out a full wipe each time
VisionsVialHelperDB = VisionsVialHelperDB or {}
VisionsVialHelperDB.framePos = VisionsVialHelperDB.framePos or {
	point = "CENTER",
	relativePoint = "CENTER",
	x = 0,
	y = 0
}
VisionsVialHelperDB.togglePos = VisionsVialHelperDB.togglePos or {
	point = "TOP",
	relativePoint = "TOP",
	x = 0,
	y = -100
}
VisionsVialHelperDB.badColor = VisionsVialHelperDB.badColor or nil


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
local frame = CreateFrame("Frame", nil, UIParent, "InsetFrameTemplate")
frame:SetSize(160, 140) -- Increased width and height for vertical layout and effect text
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
	VisionsVialHelperDB.framePos = {point=point, relativePoint=relativePoint, x=xOfs, y=yOfs}
end)
frame:Hide()

-- Title
frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.title:SetPoint("TOP", 0, -9)
frame.title:SetText("Click the BAD Vial")

-- Create separate toggle frame
local toggleFrame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
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
	self:SetBackdropColor(0, 0, 0, 0.8)
	local point, _, relativePoint, xOfs, yOfs = self:GetPoint()
	VisionsVialHelperDB.togglePos = {point=point, relativePoint=relativePoint, x=xOfs, y=yOfs}
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
	CreateColorButton(color, yOffset - (i-1) * 22) -- Stack vertically with 22px spacing
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
	end
end

-- Initialize on addon load and instance change

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

eventFrame:SetScript("OnEvent", function(_, event, arg1)
	if event == "ADDON_LOADED" and arg1 == addonName then
		-- Restore saved positions safely
		local pos = VisionsVialHelperDB.framePos or {}
		frame:ClearAllPoints()
		frame:SetPoint(
			pos.point or "CENTER",
			UIParent,
			pos.relativePoint or "CENTER",
			pos.x or 0,
			pos.y or 0
		)
		
		local tpos = VisionsVialHelperDB.togglePos or {}
		toggleFrame:ClearAllPoints()
		toggleFrame:SetPoint(
			tpos.point or "TOP",
			UIParent,
			tpos.relativePoint or "TOP",
			tpos.x or 0,
			tpos.y or -100
		)
		
		-- Restore badColor and show/hide logic
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
		-- Show/hide logic when entering world
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
