local TooltipInfo, TooltipProcessor, TooltipUtil = C_TooltipInfo, TooltipDataProcessor, TooltipUtil

local function CheckForbidden(tooltip)
    return tooltip:IsForbidden()
end

local function AddLine(tooltip, id, type)
    if not tooltip and id then return end

    tooltip:AddLine(" ")
    tooltip:AddLine(type.."ID: ".."|cffFFFFCF"..id.."|r", 1, 1, 1)
end

local function ItemID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local itemID = data.id
    -- Add line
    AddLine(tooltip, itemID, "Item")
end

local function SpellID(tooltip, data, newHook)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local spellID = data.id
    -- Add line
    AddLine(tooltip, spellID, "Spell")
end

local function AuraID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Get id
    local auraID = data.id
    -- Add line
    AddLine(tooltip, auraID, "Aura")
end

local function UnitID(tooltip, data)
    if CheckForbidden(tooltip) then return end

    -- Assign values otherwise data will be nil
    TooltipUtil.SurfaceArgs(data)
    -- Get guid
    local unitUID = data.guid
    -- Extract id from guid
    local unitID = select(6, strsplit("-", unitUID))
    -- Check if id exists, this will be false on players
    if not unitID then return end
    -- Add line
    AddLine(tooltip, unitID, "Unit")
end

-- Register callbacks
if TooltipDataProcessor then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, ItemID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, SpellID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, AuraID)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, UnitID)
else
    GameTooltip:HookScript("OnTooltipSetItem", function(self, ...)
        local link = select(2, self:GetItem())
        local id = select(5, string.find(link,
        "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"))
        if id then AddLine(self, id, "Item") end
    end)
    GameTooltip:HookScript("OnTooltipSetSpell", function(self, ...)
        local id = select(2, self:GetSpell())
        if id then AddLine(self, id, "Spell") end
    end)
    GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
        
        local unit = select(2, self:GetUnit())
        if unit then
            local guid = UnitGUID(unit)
            local id = tonumber(guid:match("-(%d+)-%x+$"), 10)
            if id and guid:match("%a+") ~= "Player" then
                AddLine(self, id, "Unit")
            end
        end
    end)
    hooksecurefunc(GameTooltip, "SetUnitAura", function(self, unit, index)
        local id = select(10, UnitAura(unit, index))
        AddLine(self, id, "Aura")
    end)
end