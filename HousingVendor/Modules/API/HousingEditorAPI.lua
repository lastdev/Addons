-- Housing Editor API Integration for HousingVendor addon
local HousingEditorAPI = {}
HousingEditorAPI.__index = HousingEditorAPI

-- Check if housing editor APIs are available
function HousingEditorAPI:IsAvailable()
    return C_HouseEditor ~= nil
end

-- Check if house editor is active
function HousingEditorAPI:IsHouseEditorActive()
    if not self:IsAvailable() or not C_HouseEditor.IsHouseEditorActive then
        return false
    end
    
    local success, isActive = pcall(function()
        return C_HouseEditor.IsHouseEditorActive()
    end)
    
    if success then
        return isActive
    else
        return false
    end
end

-- Get active house editor mode
function HousingEditorAPI:GetActiveHouseEditorMode()
    if not self:IsAvailable() or not C_HouseEditor.GetActiveHouseEditorMode then
        return nil
    end
    
    local success, mode = pcall(function()
        return C_HouseEditor.GetActiveHouseEditorMode()
    end)
    
    if success then
        return mode
    else
        return nil
    end
end

-- Enter house editor
function HousingEditorAPI:EnterHouseEditor()
    if not self:IsAvailable() or not C_HouseEditor.EnterHouseEditor then
        return false
    end
    
    local success = pcall(function()
        return C_HouseEditor.EnterHouseEditor()
    end)
    
    return success
end

-- Leave house editor
function HousingEditorAPI:LeaveHouseEditor()
    if not self:IsAvailable() or not C_HouseEditor.LeaveHouseEditor then
        return false
    end
    
    local success = pcall(function()
        C_HouseEditor.LeaveHouseEditor()
    end)
    
    return success
end

-- Get house editor availability
function HousingEditorAPI:GetHouseEditorAvailability()
    if not self:IsAvailable() or not C_HouseEditor.GetHouseEditorAvailability then
        return nil
    end
    
    local success, availability = pcall(function()
        return C_HouseEditor.GetHouseEditorAvailability()
    end)
    
    if success then
        return availability
    else
        return nil
    end
end

-- Check if house editor status is available
function HousingEditorAPI:IsHouseEditorStatusAvailable()
    if not self:IsAvailable() or not C_HouseEditor.IsHouseEditorStatusAvailable then
        return false
    end
    
    local success, isAvailable = pcall(function()
        return C_HouseEditor.IsHouseEditorStatusAvailable()
    end)
    
    if success then
        return isAvailable
    else
        return false
    end
end

-- Initialize the module
function HousingEditorAPI:Initialize()
    if self:IsAvailable() then
        print("HousingEditorAPI: Initialized with live API access")
    else
        print("HousingEditorAPI: Live API not available, module loaded in stub mode")
    end
end