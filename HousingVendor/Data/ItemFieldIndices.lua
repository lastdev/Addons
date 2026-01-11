-- Item Field Indices for Array-Based Storage
-- This eliminates string key overhead in HousingAllItems
--
-- Memory savings: ~40-50% reduction in AllItems.lua memory footprint
-- Before: {name="Chair", decorID=494, ...} - 9 string keys per item
-- After:  {494, ...} - numeric indices only
--
-- OPTIMIZATION: NAME field removed - names fetched from C_Item.GetItemNameByID(itemID) instead
-- Memory saved: ~100-200 KB (2,312 items × ~20 chars average + table overhead)

_G.HousingItemFields = {
    DECOR_ID = 1,       -- Decoration ID (number)
    MODEL_FILE_ID = 2,  -- 3D model file ID (number)
    ICON_FILE_ID = 3    -- Icon texture file ID (number)
    -- REMOVED: NAME (get from game API instead, saves 100-200 KB)
    -- REMOVED: FLAGS, TYPE, WEIGHT_COST, INITIAL_SCALE (never used, saves ~50-80 KB)
}

-- Helper function to access item fields by name
-- Usage: GetItemField(itemData, "NAME") instead of itemData.name
function HousingGetItemField(itemData, fieldName)
    if not itemData then return nil end
    local index = _G.HousingItemFields[fieldName]
    return index and itemData[index]
end

-- Helper function to create item data from named fields
-- Usage for backward compatibility or testing
function HousingCreateItemData(fields)
    return {
        fields.decorID or 0,
        fields.modelFileID or 0,
        fields.iconFileID or 0
    }
end

-- Reverse mapping for debugging/logging
_G.HousingItemFieldNames = {}
for name, index in pairs(_G.HousingItemFields) do
    _G.HousingItemFieldNames[index] = name
end
