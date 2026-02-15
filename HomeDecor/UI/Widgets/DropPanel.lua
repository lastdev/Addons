local _, NS = ...
NS.UI = NS.UI or {}

local DropPanel = NS.UI.DropPanel or {}
NS.UI.DropPanel = DropPanel

local C = NS.UI.Controls
local T = (NS.UI.Theme and NS.UI.Theme.colors) or {}
local Navigation = NS.UI.Navigation

local function mobsFromSource(src)
    if not src then return end
    if src.mobSet and src._mobSets then return src._mobSets[src.mobSet] end
    return src.mobs
end

local function buildDropList(it)
    local src = it and it.source
    if not src then return end

    local mobs = mobsFromSource(src)
    if mobs then
        local out, n = {}, 0
        for npcID, m in pairs(mobs) do
            local name, map = m and m.name, m and m.worldmap
            if name and map then
                n = n + 1
                out[n] = { npcID = npcID, name = name, worldmap = map }
            end
        end
        if n == 0 then return end
        table.sort(out, function(a, b) return tostring(a.name) < tostring(b.name) end)
        return out
    end

    if src.npcID and src.npc and src.worldmap then
        return { { npcID = src.npcID, name = src.npc, worldmap = src.worldmap } }
    end
end

local function ensureBadge(frame)
    local b = frame._dropBadge
    if b then return b end

    b = CreateFrame("Button", nil, frame, "BackdropTemplate")
    b:SetFrameLevel((frame:GetFrameLevel() or 0) + 10)
    b:SetHighlightTexture("Interface\\Buttons\\UI-Listbox-Highlight2")
    if C and C.Backdrop then C:Backdrop(b, T.row, T.border) end

    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    b.text:SetPoint("CENTER")

    frame._dropBadge = b
    return b
end

function DropPanel:GetCount(it)
    local list = buildDropList(it)
    return list and #list or 0
end

function DropPanel:AttachBadge(frame, it, mode)
    if not (frame and it) then return end

    local list = buildDropList(it)
    if not (list and #list > 0) then
        if frame._dropBadge then frame._dropBadge:Hide() end
        return
    end

    local b = ensureBadge(frame)
    b:ClearAllPoints()
    if mode == "list" then
        b:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -50)
    else
        b:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 6)
    end

    b:SetSize(80, 16)
    b.text:SetText("Drops (" .. #list .. ")")
    b:Show()

    b:SetScript("OnClick", function()
        DropPanel:ShowForItem(it, frame)
    end)
end

local function ensurePopup(self)
    local f = self._frame
    if f then return f end

    f = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    f:SetFrameStrata("DIALOG")
    f:SetFrameLevel(200)
    f:SetSize(260, 220)
    f:EnableMouse(true)
    f:SetClampedToScreen(true)
    if C and C.Backdrop then C:Backdrop(f, T.panel, T.border) end

    f:SetPropagateKeyboardInput(true)
    f:SetScript("OnKeyDown", function(_, key) if key == "ESCAPE" then f:Hide() end end)
    f:SetScript("OnLeave", function()
        C_Timer.After(0.25, function()
            if f:IsShown() and not MouseIsOver(f) then f:Hide() end
        end)
    end)

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", 12, -10)

    f.rows = {}
    self._frame = f
    return f
end

local function ensureRow(f, i)
    local r = f.rows[i]
    if r then return r end

    r = CreateFrame("Button", nil, f)
    r:SetSize(220, 18)
    r:SetPoint("TOPLEFT", 12, -30 - (i - 1) * 22)
    r:SetHighlightTexture("Interface\\Buttons\\UI-Listbox-Highlight2")

    r.text = r:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    r.text:SetPoint("LEFT")

    r:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:AddLine(self._mobName or "", 1, 0.82, 0)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click: Open Map", 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)
    r:SetScript("OnLeave", function() GameTooltip:Hide() end)
    r:SetScript("OnClick", function(self)
        if Navigation and self._mobMap then
            Navigation:AddWaypoint({ title = self._mobName }, { source = { worldmap = self._mobMap } })
        end
    end)

    f.rows[i] = r
    return r
end

function DropPanel:ShowForItem(it, anchor)
    local list = buildDropList(it)
    if not (list and #list > 0) then return end

    local f = ensurePopup(self)
    f.title:SetText("Drops From (" .. #list .. ")")

    for i = 1, #list do
        local m = list[i]
        local r = ensureRow(f, i)
        r._mobName, r._mobMap = m.name, m.worldmap
        r.text:SetText("• " .. (m.name or ""))
        r:Show()
    end
    for i = #list + 1, #f.rows do
        local r = f.rows[i]
        if r then r:Hide() end
    end

    f:ClearAllPoints()
    if anchor then
        f:SetPoint("TOPLEFT", anchor, "TOPRIGHT", 10, 0)
    else
        f:SetPoint("CENTER")
    end
    f:Show()
end

return DropPanel
