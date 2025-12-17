-- Housing Decor API Integration
local HousingDecorAPI = {}
HousingDecorAPI.__index = HousingDecorAPI

-- Check if housing decor APIs are available
function HousingDecorAPI:IsAvailable()
    return C_HousingDecor ~= nil
end

-- Get hovered decor info
function HousingDecorAPI:GetHoveredDecorInfo()
    if C_HousingBasicMode and C_HousingBasicMode.GetHoveredDecorInfo then
        local success, info = pcall(function()
            return C_HousingBasicMode.GetHoveredDecorInfo()
        end)
        
        if success and info then
            return info
        end
    end
    
    if C_HousingDecor and C_HousingDecor.GetHoveredDecorInfo then
        local success, info = pcall(function()
            return C_HousingDecor.GetHoveredDecorInfo()
        end)
        
        if success and info then
            return info
        end
    end
    
    return nil
end

-- Get selected decor info
function HousingDecorAPI:GetSelectedDecorInfo()
    if C_HousingBasicMode and C_HousingBasicMode.GetSelectedDecorInfo then
        local success, info = pcall(function()
            return C_HousingBasicMode.GetSelectedDecorInfo()
        end)
        
        if success and info then
            return info
        end
    end
    
    if C_HousingDecor and C_HousingDecor.GetSelectedDecorInfo then
        local success, info = pcall(function()
            return C_HousingDecor.GetSelectedDecorInfo()
        end)
        
        if success and info then
            return info
        end
    end
    
    return nil
end

-- Check if a decor item is selected
function HousingDecorAPI:IsDecorSelected()
    if C_HousingBasicMode and C_HousingBasicMode.IsDecorSelected then
        local success, isSelected = pcall(function()
            return C_HousingBasicMode.IsDecorSelected()
        end)
        
        if success then
            return isSelected
        end
    end
    
    if C_HousingDecor and C_HousingDecor.IsDecorSelected then
        local success, isSelected = pcall(function()
            return C_HousingDecor.IsDecorSelected()
        end)
        
        if success then
            return isSelected
        end
    end
    
    return false
end

-- Check if hovering over a decor item
function HousingDecorAPI:IsHoveringDecor()
    if C_HousingBasicMode and C_HousingBasicMode.IsHoveringDecor then
        local success, isHovering = pcall(function()
            return C_HousingBasicMode.IsHoveringDecor()
        end)
        
        if success then
            return isHovering
        end
    end
    
    if C_HousingDecor and C_HousingDecor.IsHoveringDecor then
        local success, isHovering = pcall(function()
            return C_HousingDecor.IsHoveringDecor()
        end)
        
        if success then
            return isHovering
        end
    end
    
    return false
end

-- Get all placed decor
function HousingDecorAPI:GetAllPlacedDecor()
    if C_HousingDecor and C_HousingDecor.GetAllPlacedDecor then
        local success, decor = pcall(function()
            return C_HousingDecor.GetAllPlacedDecor()
        end)
        
        if success and decor then
            return decor
        end
    end
    
    return {}
end

-- Get decor instance info for GUID
function HousingDecorAPI:GetDecorInstanceInfoForGUID(decorGUID)
    if C_HousingDecor and C_HousingDecor.GetDecorInstanceInfoForGUID then
        local success, info = pcall(function()
            return C_HousingDecor.GetDecorInstanceInfoForGUID(decorGUID)
        end)
        
        if success and info then
            return info
        end
    end
    
    return nil
end

-- Initialize the module
function HousingDecorAPI:Initialize()
    if self:IsAvailable() then
        -- Live API access available (silent)
    else
        -- Live API not available (silent)
    end
end