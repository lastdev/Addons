local _, NS = ...
NS.UI = NS.UI or {}
NS.UI.Util = NS.UI.Util or {}
local U = NS.UI.Util

local unpack = unpack
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end

if not U.Backdrop then
    function U.Backdrop(frame, controls, bg, border)
        if not frame then return end
        if controls and controls.Backdrop then return controls:Backdrop(frame, bg, border) end
        frame:SetBackdrop({
            bgFile = "Interface/Buttons/WHITE8x8",
            edgeFile = "Interface/Buttons/WHITE8x8",
            edgeSize = 1,
        })
        frame:SetBackdropColor(unpack(bg))
        frame:SetBackdropBorderColor(unpack(border))
    end
end

if not U.SetFont then
    function U.SetFont(fs, size)
        if fs then fs:SetFont(STANDARD_TEXT_FONT, size, "") end
    end
end

if not U.SafeBorder then
    function U.SafeBorder(frame, col)
        if frame and frame.SetBackdropBorderColor and col then
            frame:SetBackdropBorderColor(col[1], col[2], col[3], col[4] or 1)
        end
    end
end

if not U.BindBorderHover then
    function U.BindBorderHover(frame, accent, border)
        if not (frame and frame.SetScript and frame.SetBackdropBorderColor) then return end
        frame:SetScript("OnEnter", function() frame:SetBackdropBorderColor(unpack(accent)) end)
        frame:SetScript("OnLeave", function() frame:SetBackdropBorderColor(unpack(border)) end)
    end
end

local function insertAllSeparator(values)
    if type(values) ~= "table" or values.__hasAllSeparator then return values end
    local first = values[1]
    if first and first.value == "ALL" then
        table.insert(values, 2, { separator = true })
        values.__hasAllSeparator = true
    end
    return values
end

local M = {}
NS.UI.FilterPopup = M

function M:Build(popup, env)
    local C, T, Dropdown, Filters, FiltersSys = env.C, env.T, env.Dropdown, env.Filters, env.FiltersSys
    local HeaderCtrl = NS.UI and NS.UI.HeaderController
    local rerender = env.rerender

    popup._rows = popup._rows or {}
    wipe(popup._rows)

    local function ensureDB()
        local db = NS.db and NS.db.profile
        if db and FiltersSys and FiltersSys.EnsureDefaults then
            pcall(FiltersSys.EnsureDefaults, FiltersSys, db)
        end
        if db then db.filters = db.filters or {} end
        return db
    end

    local function F()
        local db = ensureDB()
        return db and db.filters
    end

    local function rebuild()
        if HeaderCtrl and HeaderCtrl.Reset then HeaderCtrl:Reset() end
        if rerender then rerender() end
    end

    local function setDDText(dd, value)
        local fs = dd and dd.text
        if not fs then return end

        local opts = dd._valuesFn and dd._valuesFn() or nil
        if type(opts) == "table" then
            for i = 1, #opts do
                local o = opts[i]
                if o and not o.separator and o.value == value then
                    fs:SetText(o.text or tostring(value))
                    return
                end
            end
        end
        fs:SetText(tostring(value or ""))
    end

    local function syncAll()
        for i = 1, #popup._rows do
            local r = popup._rows[i]
            if r and r._get and r.dd then
                if r.isCheck then
                    if r.dd.check and r.dd.check.SetShown then r.dd.check:SetShown(r._get() == true) end
                else
                    setDDText(r.dd, r._get())
                end
            end
        end
    end

    local function resetCategoryScope()
        local f = F()
        if not f then return end
        f.category = "ALL"
        f.subcategory = "ALL"
        if Filters then
            Filters.category = "ALL"
            Filters.subcategory = "ALL"
        end
    end

    local function button(text, onClick)
        local b = CreateFrame("Button", nil, popup, "BackdropTemplate")
        b:SetHeight(24)
        U.Backdrop(b, C, T.panel, T.border)
        U.BindBorderHover(b, T.accent, T.border)

        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        b.text:SetPoint("CENTER")
        b.text:SetText(text)

        b:SetScript("OnClick", function() if onClick then onClick() end end)
        popup._rows[#popup._rows + 1] = { isButton = true, dd = b }
        return b
    end

    local function headerRow(titleText)
        local r = {}
        r.title = popup:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        r.title:SetText(titleText)
        r.title:SetTextColor(unpack(T.accent))

        r.line = popup:CreateTexture(nil, "ARTWORK")
        r.line:SetHeight(2)
        r.line:SetColorTexture(unpack(T.accent))
        return r
    end

    local function checkRow(titleText, get, set, resetsCategory)
        local r = headerRow(titleText)
        r.isCheck, r._get = true, get

        local b = CreateFrame("Button", nil, popup, "BackdropTemplate")
        b:SetHeight(24)
        U.Backdrop(b, C, T.panel, T.border)
        U.BindBorderHover(b, T.accent, T.border)

        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        b.text:SetPoint("LEFT", 10, 0)
        b.text:SetText(titleText)

        b.check = b:CreateTexture(nil, "OVERLAY")
        b.check:SetSize(14, 14)
        b.check:SetPoint("RIGHT", -10, 0)
        b.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")

        b:SetScript("OnClick", function()
            set(not get())
            if resetsCategory then resetCategoryScope() end
            if b.check and b.check.SetShown then b.check:SetShown(get() == true) end
            rebuild()
        end)

        r.dd = b
        popup._rows[#popup._rows + 1] = r
        if b.check and b.check.SetShown then b.check:SetShown(get() == true) end
    end

    local function ddRow(titleText, get, set, valuesFn, resetsCategory)
        local r = headerRow(titleText)
        r._get = get

        local dd = Dropdown.Create(
            popup, nil, nil, 1,
            get,
            function(v)
                set(v)
                if resetsCategory then resetCategoryScope() end
                setDDText(dd, get())
                rebuild()
            end,
            valuesFn,
            function() return true end,
            C, T
        )
        dd._valuesFn = valuesFn
        r.dd = dd

        popup._rows[#popup._rows + 1] = r
        setDDText(dd, get())
    end

    local function hardReset()
        local db = ensureDB()
        local f = db and db.filters
        if not f then return end

        f.expansion, f.zone, f.category, f.subcategory, f.faction = "ALL", "ALL", "ALL", "ALL", "ALL"
        f.hideCollected, f.onlyCollected = false, false

        if Filters then
            Filters.expansion, Filters.zone, Filters.category, Filters.subcategory, Filters.faction =
                f.expansion, f.zone, f.category, f.subcategory, f.faction
        end

        syncAll()
        rebuild()
    end

    checkRow("Hide Completed",
        function() local f = F(); return (f and f.hideCollected) == true end,
        function(v) local f = F(); if f then f.hideCollected = (v == true) end end,
    true)

    ddRow("Faction",
        function() local f = F(); return (f and f.faction) or "ALL" end,
        function(v) local f = F(); if f then f.faction = v or "ALL" end end,
        function()
            return {
                { value = "ALL",      text = "All Factions" },
                { value = "Alliance", text = "Alliance" },
                { value = "Horde",    text = "Horde" },
            }
        end,
    true)

    ddRow("Expansion",
        function()
            local f = F()
            local v = (f and f.expansion) or "ALL"
            if Filters then Filters.expansion = v end
            return v
        end,
        function(v)
            local f = F()
            if not f then return end
            f.expansion = v or "ALL"
            f.zone = "ALL"
            if Filters then Filters.expansion, Filters.zone = f.expansion, f.zone end
        end,
        function()
            local out, seen = { { value = "ALL", text = "All Expansions" } }, {}
            local vendors = NS.Data and NS.Data.Vendors
            if type(vendors) == "table" then
                for exp in pairs(vendors) do
                    if not seen[exp] then
                        seen[exp] = true
                        out[#out + 1] = { value = exp, text = exp }
                    end
                end
            end
            table.sort(out, function(a, b) return a.text < b.text end)
            return insertAllSeparator(out)
        end,
    true)

    ddRow("Zone",
        function()
            local f = F()
            local v = (f and f.zone) or "ALL"
            if Filters then Filters.zone = v end
            return v
        end,
        function(v)
            local f = F()
            if not f then return end
            f.zone = v or "ALL"
            if Filters then Filters.zone = f.zone end
        end,
        function()
            local out, seen = { { value = "ALL", text = "All Zones" } }, {}
            local f = F()
            local exp = (f and f.expansion) or "ALL"
            local vendors = NS.Data and NS.Data.Vendors

            local function add(z)
                if type(z) == "string" and z ~= "" and not seen[z] then
                    seen[z] = true
                    out[#out + 1] = { value = z, text = z }
                end
            end

            local function scan(expTbl)
                for _, zoneTbl in pairs(expTbl or {}) do
                    if type(zoneTbl) == "table" then
                        for _, vendor in ipairs(zoneTbl) do
                            local src = vendor and vendor.source
                            if src then add(src.zone) end
                        end
                    end
                end
            end

            if type(vendors) == "table" then
                if exp ~= "ALL" and type(vendors[exp]) == "table" then
                    scan(vendors[exp])
                else
                    for _, expTbl in pairs(vendors) do
                        if type(expTbl) == "table" then scan(expTbl) end
                    end
                end
            end

            table.sort(out, function(a, b) return a.text < b.text end)
            return insertAllSeparator(out)
        end,
    true)

    ddRow("Category",
        function()
            local f = F()
            local v = (f and f.category) or "ALL"
            local FS = NS and NS.Systems and NS.Systems.Filters
            if FS and FS.ResolveCategoryID then
                local nv = FS:ResolveCategoryID(v)
                if f and nv ~= v then f.category = nv end
                v = nv
            end
            if Filters then Filters.category = v end
            return v
        end,
        function(v)
            local f = F()
            if not f then return end
            local FS = NS and NS.Systems and NS.Systems.Filters
            local nv = v or "ALL"
            if FS and FS.ResolveCategoryID then nv = FS:ResolveCategoryID(nv) end
            f.category = nv
            f.subcategory = "ALL"
            if Filters then Filters.category, Filters.subcategory = f.category, f.subcategory end
        end,
        function()
            local FS = NS and NS.Systems and NS.Systems.Filters
            if FS and FS.GetCategoryOptions then
                return FS:GetCategoryOptions()
            end
            return { { value = "ALL", text = "All Categories" } }
        end
    )

    ddRow("Subcategory",
        function()
            local f = F()
            local v = (f and f.subcategory) or "ALL"
            local FS = NS and NS.Systems and NS.Systems.Filters
            if FS and FS.ResolveSubcategoryID then
                local nv = FS:ResolveSubcategoryID(v)
                if f and nv ~= v then f.subcategory = nv end
                v = nv
            end
            if Filters then Filters.subcategory = v end
            return v
        end,
        function(v)
            local f = F()
            if not f then return end
            local FS = NS and NS.Systems and NS.Systems.Filters
            local nv = v or "ALL"
            if FS and FS.ResolveSubcategoryID then nv = FS:ResolveSubcategoryID(nv) end
            f.subcategory = nv
            if Filters then Filters.subcategory = f.subcategory end
        end,
        function()
            local f = F()
            local cat = (f and f.category) or "ALL"
            local FS = NS and NS.Systems and NS.Systems.Filters
            if FS and FS.GetSubcategoryOptions then
                return FS:GetSubcategoryOptions(cat)
            end
            return { { value = "ALL", text = "All Subcategories" } }
        end
    )

    button("Reset All Filters", hardReset)

    function popup:Refresh()
        local y, left, right = -18, 6, 6
        for i = 1, #self._rows do
            local r = self._rows[i]
            if r.isButton then
                r.dd:ClearAllPoints()
                r.dd:SetPoint("TOPLEFT", self, "TOPLEFT", left, y)
                r.dd:SetPoint("TOPRIGHT", self, "TOPRIGHT", -right, y)
                r.dd:SetHeight(24)
                y = y - 34
            else
                r.title:ClearAllPoints()
                r.title:SetPoint("TOPLEFT", self, "TOPLEFT", left, y)
                y = y - 20

                r.line:ClearAllPoints()
                r.line:SetPoint("TOPLEFT", self, "TOPLEFT", left, y)
                r.line:SetPoint("TOPRIGHT", self, "TOPRIGHT", -right, y)
                y = y - 10

                r.dd:ClearAllPoints()
                r.dd:SetPoint("TOPLEFT", self, "TOPLEFT", left, y)
                r.dd:SetPoint("TOPRIGHT", self, "TOPRIGHT", -right, y)
                r.dd:SetHeight((r.isCheck and 24) or 26)
                y = y - 30
            end
        end
        self:SetHeight(-y + 12)
    end

    popup:Refresh()
end

return M
