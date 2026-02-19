local ADDON, NS = ...
NS.UI = NS.UI or {}

local function GetColors()
    local theme = NS.UI and NS.UI.Theme
    return theme and theme.colors, theme and theme.textures
end

local function ensureProfile()
    local prof = NS.db and NS.db.profile
    if not prof then return nil end
    prof.mapPins = prof.mapPins or {}
    if prof.mapPins.minimap   == nil then prof.mapPins.minimap   = true    end
    if prof.mapPins.worldmap  == nil then prof.mapPins.worldmap  = true    end
    if prof.mapPins.pinStyle  == nil then prof.mapPins.pinStyle  = "house" end
    if prof.mapPins.pinSize   == nil then prof.mapPins.pinSize   = 1.0     end
    if prof.mapPins.pinColor  == nil or type(prof.mapPins.pinColor) ~= "table" then
        prof.mapPins.pinColor = { r = 1.0, g = 1.0, b = 1.0 }
    end
    prof.tracker = prof.tracker or {}
    if prof.tracker.hideCompleted        == nil then prof.tracker.hideCompleted        = false end
    if prof.tracker.hideCompletedVendors == nil then prof.tracker.hideCompletedVendors = false end
    return prof
end

local function refreshPins()
    local MP = NS.Systems and NS.Systems.MapPins
    if not MP then return end
    if MP.RefreshCurrentZone then pcall(function() MP:RefreshCurrentZone() end) end
    if MP.RefreshWorldMap    then pcall(function() MP:RefreshWorldMap()    end) end
end

local function applyTrackerFlag(key, value)
    local frame = NS.UI and NS.UI.Tracker and NS.UI.Tracker.frame
    if frame then
        frame[key] = value
        if frame.RequestRefresh then frame:RequestRefresh("worldmapbtn") end
    end
    local p = ensureProfile()
    if p then p.tracker[key:sub(2)] = value end
    local MP = NS.UI and NS.UI.MapPopup
    if MP and MP.frame and MP.frame:IsShown() then
        pcall(function() MP:Refresh() end)
    end
end

local dropPanel = nil

local function hideDropPanel()
    if dropPanel then dropPanel:Hide() end
end

local PIN_STYLES = {
    { value = "house", label = "House Icon" },
    { value = "dot",   label = "Dot"        },
}

local PANEL_W   = 200  
local ROW_H     = 22   
local SEC_H     = 18   
local PAD       = 6     
local GAP       = 4   

local function buildDropPanel()
    if dropPanel then return dropPanel end

    local C      = NS.UI.Controls
    local colors = GetColors()

    local f = CreateFrame("Frame", "HomeDecorMapButtonDropPanel", UIParent, "BackdropTemplate")
    f:SetWidth(PANEL_W)
    f:SetFrameStrata("FULLSCREEN_DIALOG")
    f:SetFrameLevel(200)
    f:EnableMouse(true)
    if C then C:Backdrop(f, colors and colors.bg, colors and colors.border) end

    WorldMapFrame:HookScript("OnHide", hideDropPanel)
    f:Hide()

    local y = 0  

    local TITLE_H = 28
    local titleBar = CreateFrame("Frame", nil, f, "BackdropTemplate")
    titleBar:SetPoint("TOPLEFT",  f, "TOPLEFT",  1, -1)
    titleBar:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
    titleBar:SetHeight(TITLE_H)
    if C then C:Backdrop(titleBar, colors and colors.header, colors and colors.border) end

    local titleTxt = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleTxt:SetPoint("LEFT", titleBar, "LEFT", 8, 0)
    titleTxt:SetText("Home|cffff7d0aDecor|r")

    local closeBtn = CreateFrame("Button", nil, titleBar)
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -4, 0)
    local closeFS = closeBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    closeFS:SetAllPoints(); closeFS:SetJustifyH("CENTER")
    closeFS:SetText("|cff888888×|r")
    closeBtn:SetScript("OnClick",  hideDropPanel)
    closeBtn:SetScript("OnEnter",  function() closeFS:SetText("|cffff7d0a×|r") end)
    closeBtn:SetScript("OnLeave",  function() closeFS:SetText("|cff888888×|r") end)

    y = y + TITLE_H + 2

    local function addSection(label)
        local bar = CreateFrame("Frame", nil, f, "BackdropTemplate")
        bar:SetPoint("TOPLEFT",  f, "TOPLEFT",  1, -(y + 1))
        bar:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -(y + 1))
        bar:SetHeight(SEC_H)
        if C then C:Backdrop(bar, colors and colors.header, colors and colors.border) end
        local lbl = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        lbl:SetPoint("LEFT", bar, "LEFT", 8, 0)
        lbl:SetTextColor(unpack(colors and colors.accent or {0.9, 0.72, 0.18}))
        lbl:SetText(label:upper())
        y = y + SEC_H + GAP
    end

    local function addCheck(label, getter, setter)
        local row = CreateFrame("Frame", nil, f, "BackdropTemplate")
        row:SetPoint("TOPLEFT",  f, "TOPLEFT",  1, -y)
        row:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -y)
        row:SetHeight(ROW_H)
        if C then C:Backdrop(row, colors and colors.row, colors and colors.border) end

        local cb = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
        cb:SetSize(18, 18)
        cb:SetPoint("LEFT", row, "LEFT", 6, 0)
        cb:SetChecked(getter())
        cb:SetScript("OnClick", function(self) setter(self:GetChecked() and true or false) end)

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lbl:SetPoint("LEFT", cb, "RIGHT", 3, 0)
        lbl:SetPoint("RIGHT", row, "RIGHT", -4, 0)
        lbl:SetTextColor(unpack(colors and colors.text or {0.92, 0.92, 0.92}))
        lbl:SetText(label)

        cb.Sync = function() cb:SetChecked(getter()) end
        y = y + ROW_H + GAP
        return cb
    end

    local function addRow(label, buildFn)
        local row = CreateFrame("Frame", nil, f, "BackdropTemplate")
        row:SetPoint("TOPLEFT",  f, "TOPLEFT",  1, -y)
        row:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -y)
        row:SetHeight(ROW_H)
        if C then C:Backdrop(row, colors and colors.row, colors and colors.border) end

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lbl:SetPoint("LEFT", row, "LEFT", 10, 0)
        lbl:SetTextColor(unpack(colors and colors.textMuted or {0.65, 0.65, 0.68}))
        lbl:SetText(label)

        buildFn(row, lbl)
        y = y + ROW_H + GAP
        return row
    end

    addSection("Map Pins")
    local cbWorld = addCheck("Show on world map",
        function() local p = ensureProfile(); return p and p.mapPins.worldmap ~= false end,
        function(v) local p = ensureProfile(); if p then p.mapPins.worldmap = v; refreshPins() end end)
    local cbMini  = addCheck("Show on minimap",
        function() local p = ensureProfile(); return p and p.mapPins.minimap ~= false end,
        function(v) local p = ensureProfile(); if p then p.mapPins.minimap = v; refreshPins() end end)
    y = y + 2

    addSection("Vendor Tracker")
    local cbHideColl = addCheck("Hide collected items",
        function() local p = ensureProfile(); return p and p.tracker.hideCompleted == true end,
        function(v) applyTrackerFlag("_hideCompleted", v) end)
    local cbHideVend = addCheck("Hide completed vendors",
        function() local p = ensureProfile(); return p and p.tracker.hideCompletedVendors == true end,
        function(v) applyTrackerFlag("_hideCompletedVendors", v) end)
    y = y + 2

    addSection("Pin Appearance")

    local styleControl
    addRow("Style", function(row, lbl)
        local styleValues = {}
        for _, e in ipairs(PIN_STYLES) do styleValues[#styleValues+1] = e.label end

        if C and C.Segmented then
            local BTN_W = 72
            local BTN_H = 18
            local BTN_PAD = 2
            local totalW = #styleValues * BTN_W + (#styleValues - 1) * BTN_PAD

            local seg = CreateFrame("Frame", nil, row)
            seg:SetSize(totalW, BTN_H)
            seg:SetPoint("RIGHT",  row, "RIGHT",  -6, 0)
            seg:SetPoint("CENTER", row, "CENTER", (totalW / 2) - 6, 0)

            local btns = {}
            local function styleRefresh()
                local p  = ensureProfile()
                local cur = p and p.mapPins.pinStyle or "house"
                for i, btn in ipairs(btns) do
                    local isActive = (PIN_STYLES[i].value == cur)
                    if btn.bg then
                        btn.bg:SetVertexColor(
                            isActive and 0.90 or 0.13,
                            isActive and 0.72 or 0.13,
                            isActive and 0.18 or 0.15,
                            isActive and 0.30 or 1.0)
                    end
                    btn.txt:SetTextColor(
                        isActive and 1.0  or (colors and colors.textMuted or {0.65,0.65,0.68})[1],
                        isActive and 0.95 or (colors and colors.textMuted or {0.65,0.65,0.68})[2],
                        isActive and 0.6  or (colors and colors.textMuted or {0.65,0.65,0.68})[3])
                end
            end

            for i, entry in ipairs(PIN_STYLES) do
                local btn = CreateFrame("Button", nil, seg, "BackdropTemplate")
                btn:SetSize(BTN_W, BTN_H)
                if i == 1 then
                    btn:SetPoint("LEFT", seg, "LEFT", 0, 0)
                else
                    btn:SetPoint("LEFT", btns[i-1], "RIGHT", BTN_PAD, 0)
                end
                if C then C:Backdrop(btn, colors and colors.panel, colors and colors.border) end

                btn.bg = btn:CreateTexture(nil, "BACKGROUND", nil, 1)
                btn.bg:SetAllPoints()
                btn.bg:SetColorTexture(0.13, 0.13, 0.15, 1)

                btn.txt = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                btn.txt:SetAllPoints()
                btn.txt:SetJustifyH("CENTER")
                btn.txt:SetText(entry.label)

                btn:SetScript("OnClick", function()
                    local p = ensureProfile(); if not p then return end
                    p.mapPins.pinStyle = entry.value
                    styleRefresh()
                    refreshPins()
                end)

                btns[i] = btn
            end

            styleControl = seg
            styleControl.Refresh = styleRefresh
            styleRefresh()
        end
    end)

    local swatch
    addRow("Color", function(row, lbl)
        local swatchBtn = CreateFrame("Button", nil, row, "BackdropTemplate")
        swatchBtn:SetSize(18, 18)
        swatchBtn:SetPoint("RIGHT", row, "RIGHT", -40, 0)
        if C then C:Backdrop(swatchBtn, {0, 0, 0, 0.7}, colors and colors.border) end

        swatch = swatchBtn:CreateTexture(nil, "ARTWORK")
        swatch:SetPoint("TOPLEFT", 2, -2)
        swatch:SetPoint("BOTTOMRIGHT", -2, 2)
        swatch:SetColorTexture(1, 1, 1)

        local resetBtn = CreateFrame("Button", nil, row, "BackdropTemplate")
        resetBtn:SetSize(34, 16)
        resetBtn:SetPoint("LEFT", swatchBtn, "RIGHT", 3, 0)
        if C then
            C:Backdrop(resetBtn, colors and colors.panel, colors and colors.border)
            C:ApplyHover(resetBtn, colors and colors.panel, colors and colors.hover,
                                   colors and colors.border, colors and colors.accentSoft)
        end
        local rTxt = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        rTxt:SetAllPoints(); rTxt:SetJustifyH("CENTER")
        rTxt:SetTextColor(unpack(colors and colors.textMuted or {0.65, 0.65, 0.68}))
        rTxt:SetText("Reset")

        resetBtn:SetScript("OnClick", function()
            local p = ensureProfile(); if not p then return end
            p.mapPins.pinColor = { r = 1, g = 1, b = 1 }
            swatch:SetColorTexture(1, 1, 1)
            refreshPins()
        end)
        swatchBtn:SetScript("OnClick", function()
            if not _G.ColorPickerFrame then return end
            local p = ensureProfile(); if not p then return end
            _G.ColorPickerFrame:SetupColorPickerAndShow({
                r = p.mapPins.pinColor.r, g = p.mapPins.pinColor.g, b = p.mapPins.pinColor.b,
                hasOpacity = false,
                swatchFunc = function()
                    local r, g, b = _G.ColorPickerFrame:GetColorRGB()
                    p.mapPins.pinColor.r, p.mapPins.pinColor.g, p.mapPins.pinColor.b = r, g, b
                    swatch:SetColorTexture(r, g, b); refreshPins()
                end,
                cancelFunc = function(restore)
                    p.mapPins.pinColor.r, p.mapPins.pinColor.g, p.mapPins.pinColor.b = restore.r, restore.g, restore.b
                    swatch:SetColorTexture(restore.r, restore.g, restore.b); refreshPins()
                end,
            })
        end)
    end)

    local slider, sizeVal
    local SLIDER_ROW_H = 28
    do
        local row = CreateFrame("Frame", nil, f, "BackdropTemplate")
        row:SetPoint("TOPLEFT",  f, "TOPLEFT",  1, -y)
        row:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -y)
        row:SetHeight(SLIDER_ROW_H)
        if C then C:Backdrop(row, colors and colors.row, colors and colors.border) end

        local lbl = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lbl:SetPoint("LEFT", row, "LEFT", 10, 4)
        lbl:SetTextColor(unpack(colors and colors.textMuted or {0.65, 0.65, 0.68}))
        lbl:SetText("Size")

        sizeVal = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        sizeVal:SetPoint("LEFT", lbl, "RIGHT", 6, 0)
        sizeVal:SetTextColor(unpack(colors and colors.accent or {0.9, 0.72, 0.18}))

        slider = CreateFrame("Slider", nil, row, "OptionsSliderTemplate")
        slider:SetSize(PANEL_W - 24, 14)
        slider:SetPoint("BOTTOMLEFT",  row, "BOTTOMLEFT",  10, 4)
        slider:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -10, 4)
        slider:SetMinMaxValues(0.5, 2.0)
        slider:SetValueStep(0.1)
        slider:SetObeyStepOnDrag(true)
        slider.Low:SetText("0.5x")
        slider.High:SetText("2.0x")
        slider.Low:SetTextColor(unpack(colors and colors.textMuted or {0.65, 0.65, 0.68}))
        slider.High:SetTextColor(unpack(colors and colors.textMuted or {0.65, 0.65, 0.68}))

        slider:SetScript("OnValueChanged", function(self, val)
            val = math.floor(val * 10 + 0.5) / 10
            local p = ensureProfile(); if not p then return end
            p.mapPins.pinSize = val
            sizeVal:SetText(string.format("%.1fx", val))
            refreshPins()
        end)

        y = y + SLIDER_ROW_H + GAP
    end

    y = y + 4  
    f:SetHeight(y)

    function f:Sync()
        local p = ensureProfile(); if not p then return end
        local trackerFrame = NS.UI and NS.UI.Tracker and NS.UI.Tracker.frame

        cbWorld:Sync(); cbMini:Sync()
        cbHideColl:SetChecked(
            (trackerFrame and trackerFrame._hideCompleted == true) or p.tracker.hideCompleted == true)
        cbHideVend:SetChecked(
            (trackerFrame and trackerFrame._hideCompletedVendors == true) or p.tracker.hideCompletedVendors == true)

        if styleControl and styleControl.Refresh then styleControl:Refresh() end

        local c = p.mapPins.pinColor
        swatch:SetColorTexture(c.r, c.g, c.b)

        local sz = p.mapPins.pinSize or 1.0
        slider:SetValue(sz)
        sizeVal:SetText(string.format("%.1fx", sz))
    end

    dropPanel = f
    return f
end

HomeDecorWorldMapButtonMixin = {}

function HomeDecorWorldMapButtonMixin:OnLoad() end

function HomeDecorWorldMapButtonMixin:Refresh()
    self:Show()
end

function HomeDecorWorldMapButtonMixin:OnMouseDown()
    self.Icon:SetPoint("TOPLEFT", 8, -8)
end

function HomeDecorWorldMapButtonMixin:OnMouseUp()
    self.Icon:SetPoint("TOPLEFT", 6, -6)
end

function HomeDecorWorldMapButtonMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine("Home|cffff7d0aDecor|r")
    GameTooltip:AddLine("Map & tracker settings", 1, 1, 1)
    GameTooltip:Show()
end

function HomeDecorWorldMapButtonMixin:OnClick()
    local panel = buildDropPanel()
    if panel:IsShown() then
        panel:Hide()
        return
    end
    panel:ClearAllPoints()
    panel:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -4)
    panel:Sync()
    panel:Show()
    panel:Raise()
end

local buttonCreated = false

local function CreateWorldMapButton()
    if buttonCreated then return end
    buttonCreated = true
    local KWB = LibStub("Krowi_WorldMapButtons-1.4")
    NS.UI.worldMapButton = KWB:Add("HomeDecorWorldMapButtonTemplate", "Button")
end

function NS.UI.CreateWorldMapButton()
    if buttonCreated then return end
    if WorldMapFrame and WorldMapFrame.AddDataProvider then
        CreateWorldMapButton()
    else
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("ADDON_LOADED")
        frame:SetScript("OnEvent", function(self, event, addonName)
            if addonName == "Blizzard_WorldMap" then
                CreateWorldMapButton()
                self:UnregisterEvent("ADDON_LOADED")
            end
        end)
    end
end
