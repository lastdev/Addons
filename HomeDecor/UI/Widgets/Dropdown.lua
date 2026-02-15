local _, NS = ...
NS.UI = NS.UI or {}
NS.UI.Util = NS.UI.Util or {}

local Util = NS.UI.Util
local Dropdown = NS.UI.Dropdown or {}
NS.UI.Dropdown = Dropdown

local OPEN, COUNTER = nil, 0
local SCROLL_THRESHOLD = 14
local SEARCH_THRESHOLD = 20

local function shown(f) return f and f.IsShown and f:IsShown() end
local function closeOpen() if OPEN and OPEN.Close then OPEN:Close() end end

local function children(opt)
    if not opt or not opt.children then return end
    if type(opt.children) == "table" then return opt.children end
    if type(opt.children) == "function" then
        local ok, res = pcall(opt.children)
        if ok and type(res) == "table" then return res end
    end
end

local function backdrop(f, C, T)
    if Util and Util.Backdrop then return Util.Backdrop(f, C, T.panel, T.border) end
    f:SetBackdrop({ bgFile="Interface/Buttons/WHITE8x8", edgeFile="Interface/Buttons/WHITE8x8", edgeSize=1 })
    f:SetBackdropColor(T.panel[1],T.panel[2],T.panel[3],T.panel[4] or 1)
    f:SetBackdropBorderColor(T.border[1],T.border[2],T.border[3],T.border[4] or 1)
end

local function setFont(fs, size)
    if Util and Util.SetFont then return Util.SetFont(fs, size) end
    if fs then fs:SetFont(STANDARD_TEXT_FONT, size, "") end
end

local function setBorder(f, col)
    if Util and Util.SafeBorder then return Util.SafeBorder(f, col) end
    if f and f.SetBackdropBorderColor then f:SetBackdropBorderColor(col[1], col[2], col[3], col[4] or 1) end
end

local function wantsBox(opt) return opt and not opt.separator and (opt.checkable or opt.children) end

local function pickText(dd, opts, v)
    if dd._get and opts then
        local picked = {}
        for _, o in ipairs(opts) do
            if o and not o.separator and not o.children and o.checkable and o.value ~= nil then
                if dd._get(o.value) then picked[#picked+1] = o.text or tostring(o.value) end
            end
        end
        if #picked > 0 then return table.concat(picked, ", ") end
    end

    if v ~= nil and opts then
        for _, o in ipairs(opts) do
            if o and not o.separator and not o.children and not o.checkable and o.value == v then
                return o.text or tostring(o.value)
            end
        end
    end
end

local function labelPrefix(dd, txt)
    local lbl = dd._label
    if not lbl or lbl == "" then return txt or "" end
    lbl = tostring(lbl)
    if lbl:sub(-1) == ":" then return lbl .. " " .. (txt or "") end
    return lbl .. ": " .. (txt or "")
end

local function filterOpts(dd, opts)
    if not dd._hasSearch or not dd.search then return opts end
    local q = tostring(dd.search:GetText() or ""):lower()
    if q == "" then return opts end

    local out = {}
    for _, o in ipairs(opts) do
        if o and (o.separator or o.title) then
            out[#out+1] = o
        else
            local t = tostring(o and o.text or ""):lower()
            if t:find(q, 1, true) then out[#out+1] = o end
        end
    end
    return out
end

local function anyChildOn(dd, opt)
    local kids = children(opt)
    if not (kids and dd._get) then return false end
    for _, o in ipairs(kids) do
        if o and not o.separator and o.value ~= nil and dd._get(o.value) then return true end
    end
    return false
end

local function ensureBtn(dd, pool, i, parentFrame, isSub, T)
    local b = pool[i]
    if not b then
        b = CreateFrame("Button", nil, parentFrame)
        b:SetHeight(dd._rowH)

        b.hl = b:CreateTexture(nil, "BACKGROUND")
        b.hl:SetAllPoints()
        b.hl:SetColorTexture(unpack(T.accent))
        b.hl:SetAlpha(0.18)
        b.hl:Hide()

        b.sel = b:CreateTexture(nil, "ARTWORK")
        b.sel:SetPoint("LEFT", 6, 0)
        b.sel:SetSize(2, dd._rowH - 6)
        b.sel:SetColorTexture(unpack(T.accent))
        b.sel:Hide()

        b.box = b:CreateTexture(nil, "OVERLAY")
        b.box:SetSize(14, 14)
        b.box:SetPoint("LEFT", 8, 0)
        b.box:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
        b.box:Hide()

        b.check = b:CreateTexture(nil, "OVERLAY")
        b.check:SetSize(14, 14)
        b.check:SetPoint("CENTER", b.box, "CENTER", 0, 0)
        b.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
        b.check:Hide()

        b.arrow = b:CreateTexture(nil, "OVERLAY")
        b.arrow:SetSize(10, 10)
        b.arrow:SetPoint("RIGHT", -6, 0)
        b.arrow:SetTexture("Interface\\Buttons\\UI-MicroStream-Green")
        b.arrow:SetRotation(1.57)
        b.arrow:Hide()

        b.div = b:CreateTexture(nil, "ARTWORK")
        b.div:SetHeight(1)
        b.div:SetPoint("LEFT", 10, 0)
        b.div:SetPoint("RIGHT", -10, 0)
        b.div:SetColorTexture(1, 1, 1, 0.15)
        b.div:Hide()

        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        setFont(b.text, 12)
        b.text:SetWordWrap(false)
        if b.text.SetMaxLines then b.text:SetMaxLines(1) end

        b:SetScript("OnEnter", function()
            b.hl:Show()
            if (not isSub) and b.children then
                dd.sub._parentOpt = b.opt
                dd:PositionSub(b)
                dd:BuildSub(b.opt)
                dd.sub:Show()
            end
        end)
        b:SetScript("OnLeave", function() b.hl:Hide() end)

        b:SetScript("OnClick", function()
            if b.separator or b.children then return end
            if dd._set then dd._set(b.value, b.opt) end
            dd:ApplyText()
            dd:RefreshStates()
            if not b.keepOpen then dd:Close() end
            if dd._parent and dd._parent.Refresh then dd._parent:Refresh() end
        end)

        pool[i] = b
    end

    if b:GetParent() ~= parentFrame then b:SetParent(parentFrame) end
    return b
end

function Dropdown.Create(parent, label, y, width, get, set, valuesFn, visibleFn, C, T)
    COUNTER = COUNTER + 1

    local dd = CreateFrame("Button", "HD_CustomDrop_" .. COUNTER, parent, "BackdropTemplate")
    dd:SetHeight(26)
    dd:SetClampedToScreen(true)
    dd:RegisterForClicks("LeftButtonUp")

    dd._parent = parent
    dd._label = label
    dd._get, dd._set = get, set
    dd._valuesFn, dd._visibleFn = valuesFn, visibleFn

    dd._rowH, dd._pad = 24, 6

    backdrop(dd, C, T)

    dd.text = dd:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dd.text:SetPoint("LEFT", 8, 0)
    dd.text:SetPoint("RIGHT", -22, 0)
    dd.text:SetJustifyH("LEFT")
    setFont(dd.text, 12)
    dd.text:SetWordWrap(false)
    if dd.text.SetMaxLines then dd.text:SetMaxLines(1) end

    dd.arrow = dd:CreateTexture(nil, "OVERLAY")
    dd.arrow:SetSize(12, 12)
    dd.arrow:SetPoint("RIGHT", -6, 0)
    dd.arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")

    dd:SetScript("OnEnter", function() setBorder(dd, T.accent) end)
    dd:SetScript("OnLeave", function() setBorder(dd, T.border) end)

    dd._catcher = CreateFrame("Frame", nil, UIParent)
    dd._catcher:SetAllPoints(UIParent)
    dd._catcher:SetFrameStrata("FULLSCREEN_DIALOG")
    dd._catcher:SetFrameLevel(1)
    dd._catcher:EnableMouse(true)
    dd._catcher:Hide()
    dd._catcher:SetScript("OnMouseDown", function()
        if OPEN == dd then dd:Close() end
    end)

    dd.list = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    dd.list:SetFrameStrata("FULLSCREEN_DIALOG")
    dd.list:SetFrameLevel(100)
    dd.list:SetClampedToScreen(true)
    dd.list:Hide()
    backdrop(dd.list, C, T)

    dd.scroll = CreateFrame("ScrollFrame", nil, dd.list, "ScrollFrameTemplate")
    if C and C.SkinScrollFrame then C:SkinScrollFrame(dd.scroll) end
    dd.scroll:SetPoint("TOPLEFT", 6, -6)
    dd.scroll:SetPoint("BOTTOMRIGHT", -26, 6)

    dd.content = CreateFrame("Frame", nil, dd.scroll)
    dd.content:SetPoint("TOPLEFT", 0, 0)
    dd.scroll:SetScrollChild(dd.content)

    dd.search = CreateFrame("EditBox", nil, dd.list, "BackdropTemplate")
    dd.search:SetAutoFocus(false)
    dd.search:SetHeight(22)
    dd.search:SetFont(STANDARD_TEXT_FONT, 12, "")
    dd.search:SetTextInsets(8, 8, 4, 4)
    backdrop(dd.search, nil, T)
    dd.search:SetPoint("TOPLEFT", dd.list, "TOPLEFT", 6, -6)
    dd.search:SetPoint("TOPRIGHT", dd.list, "TOPRIGHT", -6, -6)
    dd.search:Hide()

    dd.sub = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    dd.sub:SetFrameStrata("FULLSCREEN_DIALOG")
    dd.sub:SetFrameLevel(101)
    dd.sub:SetClampedToScreen(true)
    dd.sub:Hide()
    backdrop(dd.sub, C, T)

    dd.btns, dd.subBtns = {}, {}

    function dd:ApplyText(placeholder)
        local v = self._get and self._get()
        local opts = self._valuesFn and self._valuesFn() or {}
        local txt = pickText(self, opts, v)
        self.text:SetText(labelPrefix(self, (txt and txt ~= "" and txt) or (placeholder or "")))
    end

    function dd:PositionMain()
        self.list:ClearAllPoints()
        local l, b = self:GetLeft(), self:GetBottom()
        if l and b then
            self.list:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l, b - 4)
            self.list:SetWidth(math.max(self:GetWidth(), 180))
        end
    end

    function dd:PositionSub(anchorBtn)
        self.sub:ClearAllPoints()
        local l, t = anchorBtn:GetLeft(), anchorBtn:GetTop()
        if l and t then
            self.sub:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l + self.list:GetWidth() - 6, t)
            self.sub:SetWidth(self.list:GetWidth())
        end
    end

    function dd:Close()
        self.list:Hide()
        self.sub:Hide()
        self.sub._parentOpt = nil
        self._catcher:Hide()
        if OPEN == self then OPEN = nil end
    end

    function dd:BuildSub(parentOpt)
        local opts = children(parentOpt) or {}
        local total = #opts
        local visible = math.min(total, SCROLL_THRESHOLD)
        self.sub:SetHeight(self._pad * 2 + visible * self._rowH)

        for i = 1, total do
            local opt = opts[i] or {}
            local b = ensureBtn(self, self.subBtns, i, self.sub, true, T)
            b.opt, b.value = opt, opt.value
            b.separator, b.checkable, b.keepOpen = opt.separator, opt.checkable, opt.keepOpen
            b.children = nil

            if opt.separator then
                b.text:SetText("")
                b.div:Show()
                b.box:Hide(); b.check:Hide(); b.sel:Hide(); b.arrow:Hide()
            else
                b.div:Hide()
                b.text:SetText(opt.text or "")
                b.text:SetTextColor(1,1,1,1)
                b.text:ClearAllPoints()
                if wantsBox(opt) then
                    b.box:Show()
                    b.text:SetPoint("LEFT", 28, 0)
                else
                    b.box:Hide(); b.check:Hide()
                    b.text:SetPoint("LEFT", 12, 0)
                end
                b.text:SetPoint("RIGHT", -18, 0)
                b.arrow:Hide()
            end

            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", self.sub, "TOPLEFT", 0, -(self._pad + (i-1)*self._rowH))
            b:SetPoint("TOPRIGHT", self.sub, "TOPRIGHT", 0, -(self._pad + (i-1)*self._rowH))
            b:Show()
        end

        for i = total + 1, #self.subBtns do
            if self.subBtns[i] then self.subBtns[i]:Hide() end
        end

        self:RefreshStates()
    end

    function dd:UpdateMain()
        local all = self._valuesFn and self._valuesFn() or {}
        self._hasSearch = (#all >= SEARCH_THRESHOLD)

        self.search:SetShown(self._hasSearch)
        self.scroll:ClearAllPoints()
        if self._hasSearch then
            self.scroll:SetPoint("TOPLEFT", 6, -(6 + 26))
            self.scroll:SetPoint("BOTTOMRIGHT", -26, 6)
        else
            self.scroll:SetPoint("TOPLEFT", 6, -6)
            self.scroll:SetPoint("BOTTOMRIGHT", -26, 6)
        end

        local opts = filterOpts(self, all)
        local total = #opts
        local visible = math.min(total, SCROLL_THRESHOLD)

        self.list:SetHeight(self._pad*2 + visible*self._rowH + (self._hasSearch and 28 or 0))

        self.scroll:SetVerticalScroll(0)
        self.content:SetWidth(self.list:GetWidth() - 26)
        self.content:SetHeight(total * self._rowH)

        for i = 1, total do
            local opt = opts[i] or {}
            local b = ensureBtn(self, self.btns, i, self.content, false, T)
            b.opt, b.value = opt, opt.value
            b.separator, b.checkable, b.keepOpen, b.children = opt.separator, opt.checkable, opt.keepOpen, opt.children

            if opt.separator then
                b.text:SetText("")
                b.div:Show()
                b.box:Hide(); b.check:Hide(); b.sel:Hide(); b.arrow:Hide()
            else
                b.div:Hide()
                b.text:SetText(opt.text or "")
                b.text:SetTextColor(1,1,1,1)
                b.text:ClearAllPoints()
                if wantsBox(opt) then
                    b.box:Show()
                    b.text:SetPoint("LEFT", 28, 0)
                else
                    b.box:Hide(); b.check:Hide()
                    b.text:SetPoint("LEFT", 12, 0)
                end
                b.text:SetPoint("RIGHT", -18, 0)
                b.arrow:SetShown(opt.children and true or false)
            end

            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", self.content, "TOPLEFT", 0, -(i-1)*self._rowH)
            b:SetPoint("TOPRIGHT", self.content, "TOPRIGHT", 0, -(i-1)*self._rowH)
            b:Show()
        end

        for i = total + 1, #self.btns do
            if self.btns[i] then self.btns[i]:Hide() end
        end
    end

    function dd:RefreshStates()
        local v = self._get and self._get()

        local function sync(pool, isSub)
            for _, b in ipairs(pool) do
                if b and b:IsShown() then
                    if b.separator then
                        b.sel:Hide(); b.box:Hide(); b.check:Hide()
                    elseif b.children and not isSub then
                        b.sel:Hide()
                        b.box:Show()
                        b.check:SetShown(anyChildOn(self, b.opt))
                    elseif b.checkable then
                        b.sel:Hide()
                        b.box:Show()
                        b.check:SetShown((self._get and b.value ~= nil and self._get(b.value)) and true or false)
                    else
                        b.sel:SetShown(b.value == v)
                        b.box:Hide()
                        b.check:Hide()
                    end
                end
            end
        end

        sync(self.btns, false)
        sync(self.subBtns, true)
    end

    dd.search:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
        dd:UpdateMain()
        dd:RefreshStates()
    end)

    dd.search:SetScript("OnTextChanged", function()
        if shown(dd.list) then
            dd:UpdateMain()
            dd:RefreshStates()
        end
    end)

    dd:SetScript("OnClick", function()
        if dd._visibleFn and not dd._visibleFn() then return end
        if OPEN and OPEN ~= dd then closeOpen() end
        if shown(dd.list) then dd:Close(); return end

        if dd.search then dd.search:SetText("") end

        dd:PositionMain()
        dd:UpdateMain()
        dd.sub:Hide()
        dd.list:Show()
        dd._catcher:Show()
        OPEN = dd

        dd:RefreshStates()
        dd:ApplyText()
    end)

    dd:HookScript("OnHide", function() dd:Close() end)
    dd:HookScript("OnSizeChanged", function()
        if shown(dd.list) then
            dd.list:SetWidth(dd:GetWidth())
            dd:UpdateMain()
            dd:RefreshStates()
            dd:ApplyText()
        end
    end)

    dd:ApplyText()
    return dd
end

return Dropdown
