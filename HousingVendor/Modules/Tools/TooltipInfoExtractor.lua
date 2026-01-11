-- Tooltip Information Extractor
-- Lists all information available from WoW item tooltips


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


