-- Simple Icon Cache for HousingVendor addon
-- Uses GetItemIcon with basic caching

local Icons = {}
Icons.__index = Icons

-- Icon cache: [itemID] = iconPath
local iconCache = {}

-- Initialize icon cache from saved variables
function Icons:Initialize()
    if HousingDB and HousingDB.iconCache then
        iconCache = HousingDB.iconCache
    else
        iconCache = {}
    end
end

-- Get icon for itemID (with caching)
-- Priority: thumbnailFileID > C_Item.GetItemInfo > GetItemIcon
function Icons:GetIcon(itemID, thumbnailFileID)
    -- PRIORITY 1: Use thumbnailFileID if provided (FileDataID)
    if thumbnailFileID and thumbnailFileID ~= "" then
        local numericThumbnailID = tonumber(thumbnailFileID)
        if numericThumbnailID and numericThumbnailID > 0 then
            local cacheKey = "thumb_" .. tostring(numericThumbnailID)
            
            -- Check cache first
            if iconCache[cacheKey] then
                return iconCache[cacheKey]
            end
            
            -- Try to get texture path from FileDataID
            local texturePath = nil
            if C_Texture and C_Texture.GetFileTextureInfo then
                local success, result = pcall(function()
                    return C_Texture.GetFileTextureInfo(numericThumbnailID)
                end)
                if success and result then
                    texturePath = result
                end
            end
            
            -- If we got a texture path, cache and return it
            if texturePath then
                iconCache[cacheKey] = texturePath
                if HousingDB then
                    if not HousingDB.iconCache then
                        HousingDB.iconCache = {}
                    end
                    HousingDB.iconCache[cacheKey] = texturePath
                end
                return texturePath
            end

            -- If texture path lookup failed, try to use FileDataID directly
            -- We'll return it as a number but caller should handle it properly
            -- Return the fileID for use with texture:SetTexture(fileID)
            return numericThumbnailID
        end
    end
    
    -- PRIORITY 2: Use itemID with C_Item.GetItemInfo
    if not itemID or itemID == "" then
        return nil
    end
    
    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return nil
    end
    
    local cacheKey = tostring(numericItemID)
    
    -- Check cache first
    if iconCache[cacheKey] then
        return iconCache[cacheKey]
    end
    
    -- Try C_Item.GetItemInfo first (modern API)
    if C_Item and C_Item.GetItemInfo then
        local itemInfo = C_Item.GetItemInfo(numericItemID)
        if itemInfo and itemInfo.iconFileID then
            local iconFileID = itemInfo.iconFileID
            -- Try to get texture path
            if C_Texture and C_Texture.GetFileTextureInfo then
                local success, texturePath = pcall(function()
                    return C_Texture.GetFileTextureInfo(iconFileID)
                end)
                if success and texturePath then
                    iconCache[cacheKey] = texturePath
                    if HousingDB then
                        if not HousingDB.iconCache then
                            HousingDB.iconCache = {}
                        end
                        HousingDB.iconCache[cacheKey] = texturePath
                    end
                    return texturePath
                end
            end
            -- Return FileDataID for direct use
            return iconFileID
        end
    end
    
    -- PRIORITY 3: Fallback to GetItemIcon (deprecated but still works)
    local iconPath = GetItemIcon(numericItemID)
    if iconPath and iconPath ~= "" then
        -- Cache it
        iconCache[cacheKey] = iconPath
        if HousingDB then
            if not HousingDB.iconCache then
                HousingDB.iconCache = {}
            end
            HousingDB.iconCache[cacheKey] = iconPath
        end
        return iconPath
    end
    
    return nil
end

-- Save cache to saved variables
function Icons:SaveCache()
    if HousingDB then
        HousingDB.iconCache = iconCache
    end
end

-- Clear cache
function Icons:ClearCache()
    iconCache = {}
    if HousingDB then
        HousingDB.iconCache = {}
    end
end

-- Make globally accessible
_G["HousingIcons"] = Icons

return Icons

