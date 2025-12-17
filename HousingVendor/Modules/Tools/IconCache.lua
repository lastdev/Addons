-- Icon Cache Module
-- Caches item icons to avoid repeated API calls

local IconCache = {}
IconCache.__index = IconCache

-- Cache global references for performance
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local string_find = string.find
local type = type

-- Icon cache table: [itemID] = iconFileID or iconPath
local iconCache = {}

-- API existence checks (done once at initialization, not in hot path)
local hasC_Item = C_Item ~= nil
local hasC_ItemGetItemInfo = hasC_Item and C_Item.GetItemInfo ~= nil
local hasC_ItemRequestLoadItemDataByID = hasC_Item and C_Item.RequestLoadItemDataByID ~= nil
local hasC_Texture = C_Texture ~= nil
local hasC_TextureGetFileTextureInfo = hasC_Texture and C_Texture.GetFileTextureInfo ~= nil

-- Helper function to validate icon (moved to write-time validation)
local function IsValidIcon(iconPath)
    if not iconPath or iconPath == "" then
        return false
    end
    if iconPath == "Interface\\Icons\\INV_Misc_QuestionMark" then
        return false
    end
    if string.find(iconPath, "INV_Sword") or
       string.find(iconPath, "INV_Weapon") or
       string.find(iconPath, "INV_Axe") or
       string.find(iconPath, "INV_Mace") or
       string.find(iconPath, "INV_Shield") then
        return false
    end
    return true
end

-- Initialize icon cache from saved variables if available
function IconCache:Initialize()
  if HousingDB and HousingDB.iconCache then
    iconCache = HousingDB.iconCache
    -- Clean up any invalid cached icons (weapons, question marks, etc.)
    local cleaned = false
    for key, cachedIcon in pairs(iconCache) do
      if not cachedIcon or cachedIcon == "" or
         cachedIcon == "Interface\\Icons\\INV_Misc_QuestionMark" or
         string.find(cachedIcon, "INV_Sword") or
         string.find(cachedIcon, "INV_Weapon") or
         string.find(cachedIcon, "INV_Axe") or
         string.find(cachedIcon, "INV_Mace") or
         string.find(cachedIcon, "INV_Shield") then
        iconCache[key] = nil
        cleaned = true
      end
    end
    if cleaned and HousingDB then
      HousingDB.iconCache = iconCache
    end
  else
    iconCache = {}
  end
end

-- Get icon for an item ID (with caching)
function IconCache:GetItemIcon(itemID)
  if not itemID or itemID == "" then
    return nil
  end
  
  local numericItemID = tonumber(itemID)
  if not numericItemID then
    return nil
  end
  
  -- Check cache first (no validation needed, already validated at write time)
  local cacheKey = tostring(numericItemID)
  if iconCache[cacheKey] then
    return iconCache[cacheKey]
  end
  
  -- Try to get icon from C_Item API (modern, reliable method)
  local iconFileID = nil
  if hasC_ItemGetItemInfo then
    -- Request item data load first
    if C_Item.RequestLoadItemDataByID then
      C_Item.RequestLoadItemDataByID(numericItemID)
    end

    -- Safely call GetItemInfo with pcall
    local ok, itemInfo = pcall(C_Item.GetItemInfo, numericItemID)
    if ok and itemInfo and itemInfo.iconFileID then
      iconFileID = itemInfo.iconFileID
    end
  end
  
  -- Fallback to GetItemIcon if C_Item doesn't work
  if not iconFileID then
    local iconPath = GetItemIcon(numericItemID)
    if IsValidIcon(iconPath) then
      -- Cache only valid icons
      iconCache[cacheKey] = iconPath
      return iconPath
    end
  end
  
  -- If we got an iconFileID, convert it to texture path and cache it
  if iconFileID then
    local iconPath = "Interface\\Icons\\" .. (iconFileID and ("INV_Misc_QuestionMark") or nil)
    -- Actually, iconFileID needs to be used with SetTexture directly or converted
    -- For now, let's use GetItemIcon which should work with the numeric ID
    local iconPath = GetItemIcon(numericItemID)
    if iconPath then
      iconCache[cacheKey] = iconPath
      return iconPath
    end
  end
  
  return nil
end

-- Get icon using ThumbnailFileDataID (preferred method) or C_Item.GetItemInfo (fallback)
function IconCache:GetItemIconFromAPI(itemID, thumbnailFileID)
  -- PRIORITY 1: Use ThumbnailFileDataID if provided (most accurate for housing items)
  if thumbnailFileID and thumbnailFileID ~= "" then
    local numericThumbnailID = tonumber(thumbnailFileID)
    if numericThumbnailID and numericThumbnailID > 0 then
      -- Cache it with both itemID and thumbnailFileID as keys
      local cacheKey = tostring(itemID) .. "_thumb_" .. tostring(numericThumbnailID)
      if iconCache[cacheKey] then
        return iconCache[cacheKey]
      end
      
      -- FileDataID needs special handling - try to convert to texture path
      -- WoW's SetTexture can accept FileDataID, but it's better to use GetFileTextureInfo
      local texturePath = nil
      if hasC_TextureGetFileTextureInfo then
        -- No pcall needed, API checked at initialization
        local filePath = C_Texture.GetFileTextureInfo(numericThumbnailID)
        if filePath then
          texturePath = filePath
        end
      end
      
      -- If conversion failed, try using FileDataID directly (may work in some cases)
      if not texturePath then
        -- For now, fall back to itemID-based lookup instead of using FileDataID directly
        -- FileDataID direct usage is unreliable
        texturePath = nil -- Will fall through to itemID lookup
      end
      
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
      -- If FileDataID conversion failed, fall through to itemID lookup below
    end
  end
  
  -- PRIORITY 2: Fall back to itemID-based icon lookup
  if not itemID or itemID == "" then
    return nil
  end
  
  local numericItemID = tonumber(itemID)
  if not numericItemID then
    return nil
  end
  
  -- Check cache first (no validation needed, already validated at write time)
  local cacheKey = tostring(numericItemID)
  if iconCache[cacheKey] then
    return iconCache[cacheKey]
  end
  
  -- Request item data if not already loaded
  if hasC_ItemRequestLoadItemDataByID then
    C_Item.RequestLoadItemDataByID(numericItemID)
  end
  
  -- Try C_Item.GetItemInfo first (modern API)
  local iconPath = nil
  if hasC_ItemGetItemInfo then
    local ok, itemInfo = pcall(C_Item.GetItemInfo, numericItemID)
    if ok and itemInfo then
      -- Use GetItemIcon which should work with the itemID now that data is loaded
      iconPath = GetItemIcon(numericItemID)
      -- Validate and cache only if valid
      if IsValidIcon(iconPath) then
        iconCache[cacheKey] = iconPath
        if HousingDB then
          if not HousingDB.iconCache then
            HousingDB.iconCache = {}
          end
          HousingDB.iconCache[cacheKey] = iconPath
        end
        return iconPath
      end
    end
  end
  
  -- Fallback to GetItemIcon directly
  iconPath = GetItemIcon(numericItemID)
  if IsValidIcon(iconPath) then
    iconCache[cacheKey] = iconPath
    if HousingDB then
      if not HousingDB.iconCache then
        HousingDB.iconCache = {}
      end
      HousingDB.iconCache[cacheKey] = iconPath
    end
    return iconPath
  end
  
  -- If we got an invalid icon (weapon/question mark), return nil so fallback icons are used
  return nil
end

-- Save icon cache to saved variables
function IconCache:SaveCache()
  if HousingDB then
    if not HousingDB.iconCache then
      HousingDB.iconCache = {}
    end
    HousingDB.iconCache = iconCache
  end
end

-- Clear icon cache
function IconCache:ClearCache()
  iconCache = {}
  if HousingDB then
    HousingDB.iconCache = {}
  end
end

-- Get cache size
function IconCache:GetCacheSize()
  local count = 0
  for _ in pairs(iconCache) do
    count = count + 1
  end
  return count
end

-- Make module globally accessible
_G["HousingIconCache"] = IconCache

return IconCache

