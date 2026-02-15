local ADDON, NS = ...
NS.UI = NS.UI or {}
NS.UI.StatusIcon = NS.UI.StatusIcon or {}

local TEX_CHECKBOX = "Interface\\Buttons\\UI-CheckBox-Check"
local TEX_READY    = "Interface\\RaidFrame\\ReadyCheck-Ready"
local TEX_ALLI     = "Interface\\Icons\\INV_BannerPVP_02"
local TEX_HORDE    = "Interface\\Icons\\INV_BannerPVP_01"

NS.UI.StatusIcon.TEX_CHECK = TEX_CHECKBOX
NS.UI.StatusIcon.TEX_ALLI  = TEX_ALLI
NS.UI.StatusIcon.TEX_HORDE = TEX_HORDE

local function IsCollectedState(state)
    return state == "COLLECTED"
        or state == true
        or (type(state) == "table" and state.collected)
end

function NS.UI.StatusIcon:Attach(parent, state, it)
    if not parent then return end

    local collected = IsCollectedState(state)
    local kind = parent._kind

    if kind == "list" then
        if parent.check then
            parent.check:SetTexture(TEX_READY)
            if collected then
                parent.check:SetVertexColor(1, 1, 1)
                parent.check:Show()
            else
                parent.check:Hide()
            end
        end

        local faction = it and (it.faction or (it.source and it.source.faction))
        if parent.faction then
            if faction == "Alliance" then
                parent.faction:SetTexture(TEX_ALLI)
                parent.faction:Show()
            elseif faction == "Horde" then
                parent.faction:SetTexture(TEX_HORDE)
                parent.faction:Show()
            else
                parent.faction:Hide()
            end
        end

        if parent._statusIcon then parent._statusIcon:Hide() end
        if parent._factionIcon then parent._factionIcon:Hide() end
        return
    end

    if kind ~= "tile" then
        if parent._statusIcon then parent._statusIcon:Hide() end
        if parent._factionIcon then parent._factionIcon:Hide() end
        return
    end

    local check = parent.check or parent._statusIcon
    if not check then
        check = parent:CreateTexture(nil, "OVERLAY")
        parent._statusIcon = check
    end

    check:ClearAllPoints()
    local anchor = parent.media or parent
    check:SetPoint("TOP", anchor, "TOP", 0, -6)
    check:SetSize(16, 16)

    if collected then
        check:SetTexture(TEX_CHECKBOX)
        check:SetVertexColor(0.2, 1, 0.2)
        check:Show()
    else
        check:Hide()
    end

    if parent._factionIcon then parent._factionIcon:Hide() end

end
