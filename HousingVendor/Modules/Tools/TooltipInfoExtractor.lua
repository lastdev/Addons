-- Tooltip Information Extractor
-- Lists all information available from WoW item tooltips

-- This file documents all information that can be extracted from item tooltips
-- Run this in-game to see what data is available for a specific item

-- Information currently extracted:
-- 1. Weight (numeric value from "Weight: XX" pattern)
-- 2. House Icon (texture from tooltip line)
-- 3. Description (italic flavor text)

-- Additional information available in tooltips (but not currently extracted):
-- 4. Item Name (official name from Blizzard)
-- 5. Item Quality/Color (Poor, Common, Uncommon, Rare, Epic, Legendary, etc.)
-- 6. Item Level
-- 7. Item Type (Housing Decor, etc.)
-- 8. Binding Type (Binds to Warband, Binds to Account, etc.)
-- 9. Use Text ("Use: Add this Decor to your House Chest")
-- 10. Collection Bonus ("First-Time Collection Bonus: +XX House XP")
-- 11. Sell Price (gold/silver/copper)
-- 12. Item Set Name (if part of a set)
-- 13. Set Bonuses (if part of a set)
-- 14. Required Level
-- 15. Required Class
-- 16. Required Faction
-- 17. Required Reputation
-- 18. Durability (if applicable)
-- 19. Armor Value (if applicable)
-- 20. Stats (Strength, Agility, Intellect, etc. - usually not on housing items)
-- 21. Socket Information (if applicable)
-- 22. Enchantment Information
-- 23. Transmog Information
-- 24. Quest Item Indicator
-- 25. Unique Item Indicator
-- 26. Right-click to use text
-- 27. "Already Known" indicator (for recipes/patterns)
-- 28. "Can't be used" restrictions
-- 29. Tooltip addon data (from other addons)
-- 30. Custom tooltip lines (from addons)

-- Example function to extract ALL tooltip information:
local function ExtractAllTooltipInfo(itemID)
    local tooltip = CreateFrame("GameTooltip", "TooltipInfoExtractor", UIParent, "GameTooltipTemplate")
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()
    tooltip:SetItemByID(itemID)
    
    local allInfo = {
        lines = {},
        textures = {},
        colors = {},
        fonts = {}
    }
    
    local numLines = tooltip:NumLines()
    for i = 1, numLines do
        local leftText = _G["TooltipInfoExtractorTextLeft" .. i]
        local rightText = _G["TooltipInfoExtractorTextRight" .. i]
        local leftTexture = _G["TooltipInfoExtractorTexture" .. i]
        local rightTexture = _G["TooltipInfoExtractorTexture" .. i .. "Right"]
        
        local lineInfo = {
            leftText = nil,
            rightText = nil,
            leftTexture = nil,
            rightTexture = nil,
            leftColor = nil,
            rightColor = nil,
            leftFont = nil,
            rightFont = nil
        }
        
        if leftText then
            lineInfo.leftText = leftText:GetText()
            local r, g, b = leftText:GetTextColor()
            lineInfo.leftColor = {r, g, b}
            lineInfo.leftFont = tostring(leftText:GetFont())
        end
        
        if rightText then
            lineInfo.rightText = rightText:GetText()
            local r, g, b = rightText:GetTextColor()
            lineInfo.rightColor = {r, g, b}
            lineInfo.rightFont = tostring(rightText:GetFont())
        end
        
        if leftTexture and leftTexture:IsShown() then
            lineInfo.leftTexture = tostring(leftTexture:GetTexture())
        end
        
        if rightTexture and rightTexture:IsShown() then
            lineInfo.rightTexture = tostring(rightTexture:GetTexture())
        end
        
        table.insert(allInfo.lines, lineInfo)
    end
    
    return allInfo
end

-- Make function available globally for testing
_G["ExtractAllTooltipInfo"] = ExtractAllTooltipInfo


