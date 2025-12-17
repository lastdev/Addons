-- Model Viewer Module
-- Separate side panel for 3D model previews

local ModelViewer = {}
ModelViewer.__index = ModelViewer
-- Make globally accessible for other modules (PreviewPanel, HousingUI)
_G["HousingModelViewer"] = ModelViewer

-- Import required libraries
local C_Timer = C_Timer or _G.C_Timer

-- Global state for rotation
local modelFrame = nil
local isInitialized = false
local currentRotation = 0
local rotationSpeed = 0.5
local isDragging = false
local lastMouseX = 0

-- Camera settings for better positioning
local cameraDistance = 4.0
local cameraPosition = { x = 0, y = 0, z = 0 }

-- Debug function (disabled to reduce spam)
local function DebugPrint(message)
    -- Silently discard debug messages
end

-- Helper to fit the model into the frame with proper centering
local function ApplyFitToFrame(actor, modelFileID)
    if not actor then return end
    
    -- Reset transformations
    currentScale = 1.0
    currentYaw = 0
    currentPitch = 0
    currentActor = actor
    
    -- Check if we have positioning data for this model
    local positionData = nil
    if modelFileID and HousingModelPositions then
        positionData = HousingModelPositions[tonumber(modelFileID)]
    end
    
    if positionData then
        -- Use custom positioning from HousingModelPositions
        DebugPrint(string.format("Using custom positioning for model %s", tostring(modelFileID)))
        
        actor:SetPosition(positionData.model_x, positionData.camera_y, positionData.model_z)
        
        -- Use zoom as scale (converted appropriately)
        local scale = positionData.zoom / 10.0  -- Adjust scale factor as needed
        currentScale = math.max(0.1, math.min(scale, 5.0))
        actor:SetScale(currentScale)
        
        DebugPrint(string.format("Custom position: x=%.2f, y=%.2f, z=%.2f, scale=%.2f",
            positionData.model_x, positionData.camera_y, positionData.model_z, currentScale))
    else
        -- Use default positioning
        actor:SetPosition(0, 0, 0)
        actor:SetScale(currentScale)
        DebugPrint("Using default positioning (no custom data)")
    end
    
    -- Reset rotations
    if actor.SetYaw then actor:SetYaw(0) end
    if actor.SetPitch then actor:SetPitch(0) end
    if actor.SetRoll then actor:SetRoll(0) end
    if actor.Show then actor:Show() end
    
    -- Try to auto-adjust the camera to fit the model
    if actor.SetCamera then
        pcall(function() 
            actor:SetCamera(0)  -- Use default camera
        end)
    end
    
    -- Debug: Check if actor is actually visible
    local isShown = actor:IsShown()
    local x, y, z = actor:GetPosition()
    local scale = actor:GetScale()
    
    DebugPrint(string.format("Actor setup: visible=%s, scale=%.2f, pos=(%.2f,%.2f,%.2f)",
        tostring(isShown), scale, x, y, z))
end

-- Initialize the model viewer
function ModelViewer:Initialize(parentFrame, anchorFrame)
    if isInitialized then return end
    
    DebugPrint("Initializing ModelViewer...")
    
    -- Create main frame
    modelFrame = CreateFrame("Frame", "HousingModelViewerFrame", parentFrame, "BackdropTemplate")
    modelFrame:SetSize(420, 500)
    
    if anchorFrame then
        -- Place immediately to the right of the info panel
        modelFrame:ClearAllPoints()
        modelFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 10, 0)
        modelFrame:SetPoint("BOTTOMLEFT", anchorFrame, "BOTTOMRIGHT", 10, 0)
    else
        -- Fallback positioning relative to parent
        local filterTopOffset = parentFrame.warningMessage and -105 or -70
        local modelTopOffset = filterTopOffset - 110 - 5  -- Same as preview panel
        modelFrame:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -520, modelTopOffset)
        modelFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -520, 52)
    end
    modelFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left=4, right=4, top=4, bottom=4 }
    })
    modelFrame:SetBackdropColor(0, 0, 0, 0.9)
    modelFrame:Hide()
    
    -- Title bar (taller to fit instructions)
    local titleBar = CreateFrame("Frame", nil, modelFrame)
    titleBar:SetPoint("TOP", 0, -5)
    titleBar:SetSize(390, 45)
    
    local title = titleBar:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("LEFT", 10, 0)
    title:SetText("3D Model Preview")
    title:SetTextColor(1, 0.82, 0, 1)
    modelFrame.title = title

    -- Control instructions
    local instructions = titleBar:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    instructions:SetPoint("LEFT", title, "BOTTOMLEFT", 0, -5)
    instructions:SetText("")
    instructions:SetTextColor(0.7, 0.7, 0.7, 1)
    modelFrame.instructions = instructions

    -- Close button
    local closeBtn = CreateFrame("Button", nil, modelFrame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        ModelViewer:Hide()
    end)

    -- Reset View button
    local resetBtn = CreateFrame("Button", nil, titleBar, "UIPanelButtonTemplate")
    resetBtn:SetSize(80, 22)
    resetBtn:SetPoint("RIGHT", closeBtn, "LEFT", -5, 0)
    resetBtn:SetText("Reset View")
    resetBtn:SetScript("OnClick", function()
        if currentActor then
            ApplyFitToFrame(currentActor)
            DebugPrint("View reset to default position")
        end
    end)
    modelFrame.resetBtn = resetBtn
    
    -- Debug info text (scrollable for long debug output)
    local debugScroll = CreateFrame("ScrollFrame", nil, modelFrame, "UIPanelScrollFrameTemplate")
    debugScroll:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 5, -5)
    debugScroll:SetPoint("TOPRIGHT", titleBar, "BOTTOMRIGHT", -25, -5)
    debugScroll:SetHeight(1)  -- Hide debug area
    debugScroll:Hide()  -- Don't show debug
    modelFrame.debugScroll = debugScroll
    
    local debugContent = CreateFrame("Frame", nil, debugScroll)
    debugContent:SetWidth(debugScroll:GetWidth() - 20)
    debugScroll:SetScrollChild(debugContent)
    
    local debugText = debugContent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    debugText:SetPoint("TOPLEFT", 0, 0)
    debugText:SetPoint("RIGHT", 0, 0)
    debugText:SetJustifyH("LEFT")
    debugText:SetTextColor(0.8, 0.8, 0.5, 1)  -- Yellowish for debug
    debugText:SetWordWrap(true)
    modelFrame.debugText = debugText
    
    -- Store camera distance for zoom controls
    modelFrame.cameraDistance = 4.0
    
    -- Control buttons container BELOW TITLE BAR
    local controlsFrame = CreateFrame("Frame", "HousingModelViewerControls", modelFrame)
    controlsFrame:SetPoint("TOP", titleBar, "BOTTOM", 0, -5)  -- Below title bar
    controlsFrame:SetSize(200, 32)
    controlsFrame:SetFrameStrata("HIGH")
    
    -- Add visible background for debugging
    local controlsBg = controlsFrame:CreateTexture(nil, "BACKGROUND")
    controlsBg:SetAllPoints()
    controlsBg:SetColorTexture(0.1, 0.1, 0.1, 0.8)  -- Dark semi-transparent background
    
    -- Rotate Left button
    local rotateLeftBtn = CreateFrame("Button", nil, controlsFrame)
    rotateLeftBtn:SetSize(32, 32)
    rotateLeftBtn:SetPoint("RIGHT", controlsFrame, "RIGHT", -140, 0)
    rotateLeftBtn:SetNormalAtlas("UI-ModelSceneRotateLeft")
    rotateLeftBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateLeftBtn:SetScript("OnClick", function()
        currentRotation = currentRotation - 0.3
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    rotateLeftBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Left", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateLeftBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Rotate Right button
    local rotateRightBtn = CreateFrame("Button", nil, controlsFrame)
    rotateRightBtn:SetSize(32, 32)
    rotateRightBtn:SetPoint("RIGHT", controlsFrame, "RIGHT", -105, 0)
    rotateRightBtn:SetNormalAtlas("UI-ModelSceneRotateRight")
    rotateRightBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    rotateRightBtn:SetScript("OnClick", function()
        currentRotation = currentRotation + 0.3
        modelFrame.modelScene:SetFacing(currentRotation)
    end)
    rotateRightBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Rotate Right", 1, 1, 1)
        GameTooltip:Show()
    end)
    rotateRightBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Reset button
    local resetViewBtn = CreateFrame("Button", nil, controlsFrame)
    resetViewBtn:SetSize(32, 32)
    resetViewBtn:SetPoint("RIGHT", controlsFrame, "RIGHT", -70, 0)
    resetViewBtn:SetNormalAtlas("UI-ModelSceneReset")
    resetViewBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    resetViewBtn:SetScript("OnClick", function()
        currentRotation = 0
        modelFrame.cameraDistance = 4.0
        modelFrame.modelScene:SetFacing(0)
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(4.0)
        end
    end)
    resetViewBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Reset View", 1, 1, 1)
        GameTooltip:Show()
    end)
    resetViewBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Zoom In button
    local zoomInBtn = CreateFrame("Button", nil, controlsFrame)
    zoomInBtn:SetSize(32, 32)
    zoomInBtn:SetPoint("RIGHT", controlsFrame, "RIGHT", -35, 0)
    zoomInBtn:SetNormalAtlas("UI-ModelSceneZoomIn")
    zoomInBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomInBtn:SetScript("OnClick", function()
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist - 1.5
        newDist = math.max(0.5, math.min(newDist, 30))
        modelFrame.cameraDistance = newDist
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(newDist)
        end
    end)
    zoomInBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom In", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomInBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Zoom Out button
    local zoomOutBtn = CreateFrame("Button", nil, controlsFrame)
    zoomOutBtn:SetSize(32, 32)
    zoomOutBtn:SetPoint("RIGHT", controlsFrame, "RIGHT", 0, 0)
    zoomOutBtn:SetNormalAtlas("UI-ModelSceneZoomOut")
    zoomOutBtn:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    zoomOutBtn:SetScript("OnClick", function()
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist + 1.5
        newDist = math.max(0.5, math.min(newDist, 30))
        modelFrame.cameraDistance = newDist
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(newDist)
        end
    end)
    zoomOutBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Zoom Out", 1, 1, 1)
        GameTooltip:Show()
    end)
    zoomOutBtn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    modelFrame.controlsFrame = controlsFrame
    controlsFrame:Show()  -- Explicitly show controls
    
    -- Model viewer (use PlayerModel instead of ModelScene for simplicity)
    local modelScene = CreateFrame("PlayerModel", nil, modelFrame)
    modelScene:SetPoint("TOP", controlsFrame, "BOTTOM", 0, -5)  -- Below controls
    modelScene:SetPoint("LEFT", 10, 0)
    modelScene:SetPoint("RIGHT", -10, 0)
    modelScene:SetPoint("BOTTOM", 0, 10)
    
    -- Simple background for the model scene
    local bg = modelScene:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.05, 0.05, 0.05, 0.9)
    
    -- Set up camera when model loads
    modelScene:SetScript("OnModelLoaded", function(self)
        if self.MakeCurrentCameraCustom then
            self:MakeCurrentCameraCustom()
        end
        self:SetPosition(0, 0, 0)
        if self.SetCameraPosition then
            self:SetCameraPosition(0, 0, 4)
        end
        if self.SetCameraDistance then
            self:SetCameraDistance(10)
        end
    end)
    
    modelFrame.modelScene = modelScene

    -- Interaction: Right-click drag to rotate, mouse wheel to zoom
    modelScene:EnableMouse(true)
    modelScene:EnableMouseWheel(true)
    modelScene:RegisterForDrag("RightButton")  -- Enable right-button drag
    
    -- Right-click drag to manually rotate
    modelScene:SetScript("OnMouseDown", function(self, button)
        if button == "RightButton" then
            isDragging = true
            local scale = self:GetEffectiveScale()
            lastMouseX = GetCursorPosition() / scale
        end
    end)
    
    modelScene:SetScript("OnMouseUp", function(self, button)
        if button == "RightButton" then
            isDragging = false
        end
    end)
    
    modelScene:SetScript("OnUpdate", function(self, elapsed)
        if isDragging then
            local scale = self:GetEffectiveScale()
            local mouseX = GetCursorPosition() / scale
            local delta = (mouseX - lastMouseX) * 0.005  -- Smoother rotation speed
            currentRotation = currentRotation + delta
            self:SetFacing(currentRotation)
            lastMouseX = mouseX
        end
    end)

    -- Mouse wheel zoom
    modelScene:SetScript("OnMouseWheel", function(self, delta)
        -- Zoom by adjusting camera distance
        local currentDist = modelFrame.cameraDistance or 4.0
        local newDist = currentDist - (delta * 1.5)  -- Increased sensitivity
        newDist = math.max(0.5, math.min(newDist, 30))  -- Allow closer zoom
        modelFrame.cameraDistance = newDist
        
        if self.SetCameraDistance then
            self:SetCameraDistance(newDist)
        end
        
        DebugPrint(string.format("Zoom: distance=%.1f (delta=%d)", newDist, delta))
    end)
    
    -- Store reference
    _G["HousingModelViewer"] = ModelViewer
    
    isInitialized = true
    DebugPrint("ModelViewer initialized successfully")
end

-- Show model from catalog data (prioritize API data, fallback to ModelMapping)
function ModelViewer:ShowModel(catalogData, itemName, itemID)
    if not modelFrame or not isInitialized then
        DebugPrint("ERROR: ModelViewer not initialized")
        return false
    end
    
    if not catalogData then
        DebugPrint("ERROR: No catalog data provided")
        return false
    end
    
    DebugPrint("=== ShowModel called ===")
    DebugPrint("Item Name: " .. (itemName or "Unknown"))
    DebugPrint("Item ID: " .. (itemID or "Unknown"))
    
    DebugPrint("API Data:")
    DebugPrint("  uiModelSceneID: " .. tostring(catalogData.uiModelSceneID or "nil"))
    DebugPrint("  asset: " .. tostring(catalogData.asset or "nil"))
    DebugPrint("  modelFileID (from catalog): " .. tostring(catalogData.modelFileID or "nil"))

    local hasModel = false
    local debugInfo = {}
    local sourceUsed = nil
    local modelFileID = nil
    
    -- Determine which model ID to use (simplified priority)
    if catalogData.asset and catalogData.asset > 0 then
        modelFileID = catalogData.asset
        sourceUsed = "API (asset)"
    elseif itemID and HousingDecorData then
        local numericItemID = tonumber(itemID)
        local decorData = numericItemID and HousingDecorData[numericItemID]
        if decorData and decorData.modelFileID then
            modelFileID = tonumber(decorData.modelFileID)
            sourceUsed = "HousingDecorData"
        end
    end
    
    table.insert(debugInfo, "Source: " .. (sourceUsed or "None"))
    table.insert(debugInfo, "ModelFileID: " .. tostring(modelFileID or "nil"))
    
    -- If we have a model ID, load it
    if modelFileID and modelFileID > 0 then
        -- Reset rotation and camera distance for new model
        currentRotation = 0
        modelFrame.cameraDistance = 4.0
        
        -- PlayerModel uses SetModel() instead of CreateActor
        modelFrame.modelScene:SetModel(modelFileID)
        modelFrame.modelScene:SetFacing(0)  -- Reset rotation
        
        -- Reset camera position
        if modelFrame.modelScene.SetCameraDistance then
            modelFrame.modelScene:SetCameraDistance(modelFrame.cameraDistance)
        end
        if modelFrame.modelScene.SetCameraPosition then
            modelFrame.modelScene:SetCameraPosition(0, 0, 4)
        end
        
        modelFrame.modelScene:Show()
        
        table.insert(debugInfo, "Model set with ID: " .. modelFileID)
        hasModel = true
    else
        table.insert(debugInfo, "ERROR: No valid model ID")
    end
    
    -- Update debug text
    local debugString = "Debug Info:\n"
    if #debugInfo > 0 then
        debugString = debugString .. table.concat(debugInfo, "\n")
    else
        debugString = debugString .. "No model data available"
    end
    
    if hasModel then
        debugString = debugString .. "\n\nStatus: Model loaded successfully"
        if sourceUsed then
            debugString = debugString .. "\nSource: " .. sourceUsed
            if sourceUsed:match("static") then
                debugString = debugString .. "\nWARNING: Using static data - may be outdated!"
            else
                debugString = debugString .. "\nOK: Using current data"
            end
        end
    else
        debugString = debugString .. "\n\nStatus: No model could be loaded"
        debugString = debugString .. "\n\nTried:"
        debugString = debugString .. "\n1. API uiModelSceneID"
        debugString = debugString .. "\n2. API asset"
        debugString = debugString .. "\n3. HousingDecorData.lua"
        debugString = debugString .. "\n4. catalogData.modelFileID"
    end
    
    -- Update debug text and scroll to top
    if modelFrame.debugText then
        modelFrame.debugText:SetText(debugString)
        -- Resize debug content to fit text
        if modelFrame.debugScroll then
            local textHeight = modelFrame.debugText:GetStringHeight()
            modelFrame.debugText:GetParent():SetHeight(math.max(120, textHeight + 10))
            modelFrame.debugScroll:SetVerticalScroll(0)  -- Scroll to top
        end
    end
    
    -- Always show frame when ShowModel is called (even if no model, to show debug info)
    modelFrame:Show()
    if hasModel then
        DebugPrint("ModelViewer frame shown - Model loaded successfully")
    else
        DebugPrint("ModelViewer frame shown - No model could be loaded (see debug info)")
    end
    
    return hasModel
end

-- Hide the model viewer
function ModelViewer:Hide()
    if modelFrame then
        -- Clear current actor
        if currentActor then
            currentActor:ClearModel()
            currentActor:Hide()
            currentActor = nil
        end

        modelFrame:Hide()
        DebugPrint("ModelViewer hidden and actor cleared")
    end
end

-- Check if model viewer is visible
function ModelViewer:IsVisible()
    return modelFrame and modelFrame:IsVisible() or false
end

return ModelViewer

