-- Housing Vendor Theme System
-- Multiple color themes with seamless switching

local _, addon = ...

-- Create the theme namespace
HousingTheme = {}

--------------------------------------------------------------------------------
-- THEME DEFINITIONS
--------------------------------------------------------------------------------

HousingTheme.Themes = {}

-- Midnight Theme (original)
HousingTheme.Themes["Midnight"] = {
    name = "Midnight",
    description = "Deep purples, moonlit blues, and silver accents",
    Colors = {
        -- Primary backgrounds (deep, dark purples)
        bgPrimary = {0.08, 0.06, 0.12, 0.95},
        bgSecondary = {0.12, 0.09, 0.18, 0.92},
        bgTertiary = {0.16, 0.12, 0.24, 0.90},
        bgHover = {0.22, 0.16, 0.32, 0.95},
        bgSelected = {0.28, 0.20, 0.42, 0.98},
        
        -- Accent colors
        accentPrimary = {0.55, 0.65, 0.90, 1.0},
        accentSecondary = {0.75, 0.70, 0.95, 1.0},
        accentGold = {0.85, 0.75, 0.45, 1.0},
        accentSilver = {0.78, 0.80, 0.85, 1.0},
        
        -- Text colors
        textPrimary = {0.92, 0.90, 0.96, 1.0},
        textSecondary = {0.70, 0.68, 0.78, 1.0},
        textMuted = {0.50, 0.48, 0.58, 1.0},
        textHighlight = {1.0, 0.95, 0.80, 1.0},
        
        -- Border colors
        borderPrimary = {0.35, 0.30, 0.50, 0.8},
        borderAccent = {0.55, 0.50, 0.75, 1.0},
        borderGlow = {0.60, 0.55, 0.85, 0.6},
        
        -- Status colors
        statusSuccess = {0.30, 0.85, 0.50, 1.0},
        statusWarning = {0.95, 0.75, 0.30, 1.0},
        statusError = {0.90, 0.35, 0.40, 1.0},
        statusInfo = {0.40, 0.70, 0.95, 1.0},
        
        -- Faction colors
        factionHorde = {0.85, 0.20, 0.25, 1.0},
        factionAlliance = {0.25, 0.50, 0.90, 1.0},
        factionNeutral = {0.60, 0.58, 0.65, 1.0},
        
        -- Source type colors
        sourceVendor = {0.35, 0.80, 0.45, 1.0},
        sourceQuest = {0.40, 0.70, 0.95, 1.0},
        sourceDrop = {0.95, 0.60, 0.25, 1.0},
        sourceAchievement = {0.95, 0.80, 0.25, 1.0},
        
        -- Quality colors
        qualityPoor = {0.62, 0.62, 0.62, 1.0},
        qualityCommon = {0.95, 0.95, 0.95, 1.0},
        qualityUncommon = {0.12, 0.90, 0.12, 1.0},
        qualityRare = {0.25, 0.50, 0.95, 1.0},
        qualityEpic = {0.65, 0.30, 0.90, 1.0},
        qualityLegendary = {0.95, 0.50, 0.15, 1.0},
    }
}

-- Alliance Theme
HousingTheme.Themes["Alliance"] = {
    name = "Alliance",
    description = "Royal blues and gold - For the Alliance!",
    Colors = {
        -- Primary backgrounds (deep blues)
        bgPrimary = {0.05, 0.10, 0.20, 0.95},
        bgSecondary = {0.08, 0.15, 0.28, 0.92},
        bgTertiary = {0.12, 0.20, 0.35, 0.90},
        bgHover = {0.15, 0.25, 0.42, 0.95},
        bgSelected = {0.18, 0.32, 0.55, 0.98},
        
        -- Accent colors (royal blue and gold)
        accentPrimary = {0.30, 0.55, 0.95, 1.0},
        accentSecondary = {0.50, 0.70, 1.0, 1.0},
        accentGold = {0.95, 0.80, 0.30, 1.0},
        accentSilver = {0.85, 0.88, 0.92, 1.0},
        
        -- Text colors
        textPrimary = {0.95, 0.96, 0.98, 1.0},
        textSecondary = {0.72, 0.78, 0.88, 1.0},
        textMuted = {0.50, 0.56, 0.68, 1.0},
        textHighlight = {0.95, 0.85, 0.45, 1.0},
        
        -- Border colors
        borderPrimary = {0.25, 0.40, 0.65, 0.8},
        borderAccent = {0.40, 0.60, 0.95, 1.0},
        borderGlow = {0.50, 0.70, 1.0, 0.6},
        
        -- Status colors
        statusSuccess = {0.30, 0.85, 0.50, 1.0},
        statusWarning = {0.95, 0.75, 0.30, 1.0},
        statusError = {0.90, 0.35, 0.40, 1.0},
        statusInfo = {0.40, 0.70, 0.95, 1.0},
        
        -- Faction colors
        factionHorde = {0.85, 0.20, 0.25, 1.0},
        factionAlliance = {0.30, 0.55, 0.95, 1.0},
        factionNeutral = {0.60, 0.58, 0.65, 1.0},
        
        -- Source type colors
        sourceVendor = {0.35, 0.80, 0.45, 1.0},
        sourceQuest = {0.40, 0.70, 0.95, 1.0},
        sourceDrop = {0.95, 0.60, 0.25, 1.0},
        sourceAchievement = {0.95, 0.80, 0.25, 1.0},
        
        -- Quality colors
        qualityPoor = {0.62, 0.62, 0.62, 1.0},
        qualityCommon = {0.95, 0.95, 0.95, 1.0},
        qualityUncommon = {0.12, 0.90, 0.12, 1.0},
        qualityRare = {0.25, 0.50, 0.95, 1.0},
        qualityEpic = {0.65, 0.30, 0.90, 1.0},
        qualityLegendary = {0.95, 0.50, 0.15, 1.0},
    }
}

-- Horde Theme
HousingTheme.Themes["Horde"] = {
    name = "Horde",
    description = "Crimson reds and dark iron - Lok'tar Ogar!",
    Colors = {
        -- Primary backgrounds (dark reds and blacks)
        bgPrimary = {0.15, 0.05, 0.05, 0.95},
        bgSecondary = {0.22, 0.08, 0.08, 0.92},
        bgTertiary = {0.28, 0.12, 0.12, 0.90},
        bgHover = {0.35, 0.15, 0.15, 0.95},
        bgSelected = {0.45, 0.18, 0.18, 0.98},
        
        -- Accent colors (crimson and bronze)
        accentPrimary = {0.90, 0.20, 0.20, 1.0},
        accentSecondary = {1.0, 0.35, 0.30, 1.0},
        accentGold = {0.85, 0.60, 0.25, 1.0},
        accentSilver = {0.60, 0.58, 0.56, 1.0},
        
        -- Text colors
        textPrimary = {0.95, 0.92, 0.90, 1.0},
        textSecondary = {0.78, 0.70, 0.68, 1.0},
        textMuted = {0.58, 0.50, 0.48, 1.0},
        textHighlight = {1.0, 0.85, 0.70, 1.0},
        
        -- Border colors
        borderPrimary = {0.55, 0.25, 0.25, 0.8},
        borderAccent = {0.80, 0.30, 0.30, 1.0},
        borderGlow = {0.95, 0.40, 0.35, 0.6},
        
        -- Status colors
        statusSuccess = {0.30, 0.85, 0.50, 1.0},
        statusWarning = {0.95, 0.75, 0.30, 1.0},
        statusError = {0.90, 0.35, 0.40, 1.0},
        statusInfo = {0.40, 0.70, 0.95, 1.0},
        
        -- Faction colors
        factionHorde = {0.90, 0.20, 0.20, 1.0},
        factionAlliance = {0.25, 0.50, 0.90, 1.0},
        factionNeutral = {0.60, 0.58, 0.65, 1.0},
        
        -- Source type colors
        sourceVendor = {0.35, 0.80, 0.45, 1.0},
        sourceQuest = {0.40, 0.70, 0.95, 1.0},
        sourceDrop = {0.95, 0.60, 0.25, 1.0},
        sourceAchievement = {0.95, 0.80, 0.25, 1.0},
        
        -- Quality colors
        qualityPoor = {0.62, 0.62, 0.62, 1.0},
        qualityCommon = {0.95, 0.95, 0.95, 1.0},
        qualityUncommon = {0.12, 0.90, 0.12, 1.0},
        qualityRare = {0.25, 0.50, 0.95, 1.0},
        qualityEpic = {0.65, 0.30, 0.90, 1.0},
        qualityLegendary = {0.95, 0.50, 0.15, 1.0},
    }
}

-- Sleek Black Theme
HousingTheme.Themes["Sleek Black"] = {
    name = "Sleek Black",
    description = "Modern minimalist with pure blacks and cyan accents",
    Colors = {
        -- Primary backgrounds (pure blacks and dark grays)
        bgPrimary = {0.05, 0.05, 0.05, 0.98},
        bgSecondary = {0.08, 0.08, 0.08, 0.95},
        bgTertiary = {0.12, 0.12, 0.12, 0.92},
        bgHover = {0.18, 0.18, 0.18, 0.95},
        bgSelected = {0.22, 0.22, 0.22, 0.98},
        
        -- Accent colors (cyan and white)
        accentPrimary = {0.20, 0.85, 0.95, 1.0},
        accentSecondary = {0.40, 0.95, 1.0, 1.0},
        accentGold = {0.95, 0.85, 0.40, 1.0},
        accentSilver = {0.90, 0.90, 0.90, 1.0},
        
        -- Text colors
        textPrimary = {0.98, 0.98, 0.98, 1.0},
        textSecondary = {0.75, 0.75, 0.75, 1.0},
        textMuted = {0.50, 0.50, 0.50, 1.0},
        textHighlight = {0.20, 0.95, 1.0, 1.0},
        
        -- Border colors
        borderPrimary = {0.25, 0.25, 0.25, 0.8},
        borderAccent = {0.20, 0.85, 0.95, 1.0},
        borderGlow = {0.30, 0.90, 1.0, 0.6},
        
        -- Status colors
        statusSuccess = {0.30, 0.85, 0.50, 1.0},
        statusWarning = {0.95, 0.75, 0.30, 1.0},
        statusError = {0.90, 0.35, 0.40, 1.0},
        statusInfo = {0.20, 0.85, 0.95, 1.0},
        
        -- Faction colors
        factionHorde = {0.85, 0.20, 0.25, 1.0},
        factionAlliance = {0.25, 0.50, 0.90, 1.0},
        factionNeutral = {0.70, 0.70, 0.70, 1.0},
        
        -- Source type colors
        sourceVendor = {0.35, 0.80, 0.45, 1.0},
        sourceQuest = {0.20, 0.85, 0.95, 1.0},
        sourceDrop = {0.95, 0.60, 0.25, 1.0},
        sourceAchievement = {0.95, 0.80, 0.25, 1.0},
        
        -- Quality colors
        qualityPoor = {0.62, 0.62, 0.62, 1.0},
        qualityCommon = {0.95, 0.95, 0.95, 1.0},
        qualityUncommon = {0.12, 0.90, 0.12, 1.0},
        qualityRare = {0.25, 0.50, 0.95, 1.0},
        qualityEpic = {0.65, 0.30, 0.90, 1.0},
        qualityLegendary = {0.95, 0.50, 0.15, 1.0},
    }
}

-- Active theme pointer (defaults to Midnight)
HousingTheme.ActiveThemeName = "Midnight"

-- Get current theme colors
function HousingTheme:GetActiveTheme()
    return self.Themes[self.ActiveThemeName] or self.Themes["Midnight"]
end

-- Set active theme
function HousingTheme:SetTheme(themeName)
    if self.Themes[themeName] then
        self.ActiveThemeName = themeName
        -- Save to DB
        if not HousingDB then HousingDB = {} end
        HousingDB.theme = themeName
        -- Notify UI to refresh
        if self.OnThemeChanged then
            self:OnThemeChanged(themeName)
        end
        return true
    end
    return false
end

-- Get list of available themes
function HousingTheme:GetThemeNames()
    local names = {}
    for name, _ in pairs(self.Themes) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

-- Initialize theme from saved data
function HousingTheme:Initialize()
    if HousingDB and HousingDB.theme then
        self:SetTheme(HousingDB.theme)
    end
end

-- Expose active theme colors as HousingTheme.Colors for backward compatibility
setmetatable(HousingTheme, {
    __index = function(t, k)
        if k == "Colors" then
            return t:GetActiveTheme().Colors
        end
        return rawget(t, k)
    end
})

--------------------------------------------------------------------------------
-- FONTS
--------------------------------------------------------------------------------

HousingTheme.Fonts = {
    -- Font sizes
    sizeTitle = 18,
    sizeHeader = 14,
    sizeNormal = 12,
    sizeSmall = 10,
    sizeTiny = 9,
    
    -- Font objects (will use game fonts)
    title = "GameFontNormalLarge",
    header = "GameFontNormal",
    normal = "GameFontNormalSmall",
    small = "GameFontHighlightSmall",
    tiny = "GameFontHighlightExtraSmall",
}

--------------------------------------------------------------------------------
-- DIMENSIONS
--------------------------------------------------------------------------------

HousingTheme.Dimensions = {
    -- Main frame
    mainFrameWidth = 1100,
    mainFrameHeight = 700,
    mainFrameMinWidth = 900,
    mainFrameMinHeight = 550,
    
    -- Header
    headerHeight = 50,
    
    -- Filters
    filterPanelHeight = 100,
    filterButtonHeight = 28,
    filterButtonWidth = 140,
    filterSpacing = 8,
    
    -- Item list
    itemListWidth = 480,
    itemButtonHeight = 52,
    itemButtonSpacing = 4,
    itemIconSize = 40,
    
    -- Preview panel
    previewPanelWidth = 380,
    previewPadding = 16,
    
    -- General
    borderRadius = 4,
    padding = 12,
    spacing = 8,
    
    -- Scrollbar
    scrollbarWidth = 8,
}

--------------------------------------------------------------------------------
-- BACKDROP TEMPLATES
--------------------------------------------------------------------------------

HousingTheme.Backdrops = {
    -- Main frame backdrop
    mainFrame = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 2,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    },
    
    -- Panel backdrop (for sections)
    panel = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    },
    
    -- Card backdrop (for items)
    card = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    },
    
    -- Button backdrop
    button = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    },
    
    -- Input field backdrop
    input = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    },
    
    -- Tooltip backdrop
    tooltip = {
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    },
}

--------------------------------------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------------------------------------

-- Apply theme colors to a frame with backdrop
function HousingTheme:ApplyBackdrop(frame, backdropType, bgColorKey, borderColorKey)
    if not frame.SetBackdrop then
        Mixin(frame, BackdropTemplateMixin)
    end
    
    local backdrop = self.Backdrops[backdropType] or self.Backdrops.panel
    frame:SetBackdrop(backdrop)
    
    local bgColor = self.Colors[bgColorKey] or self.Colors.bgSecondary
    local borderColor = self.Colors[borderColorKey] or self.Colors.borderPrimary
    
    frame:SetBackdropColor(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    frame:SetBackdropBorderColor(borderColor[1], borderColor[2], borderColor[3], borderColor[4])
end

-- Create a styled button
function HousingTheme:CreateButton(parent, text, width, height)
    local button = CreateFrame("Button", nil, parent, "BackdropTemplate")
    button:SetSize(width or 100, height or 28)
    
    self:ApplyBackdrop(button, "button", "bgTertiary", "borderPrimary")
    
    local label = button:CreateFontString(nil, "OVERLAY", self.Fonts.normal)
    label:SetPoint("CENTER")
    label:SetText(text or "")
    label:SetTextColor(unpack(self.Colors.textPrimary))
    button.label = label
    
    -- Hover effects
    button:SetScript("OnEnter", function(self)
        HousingTheme:ApplyBackdrop(self, "button", "bgHover", "accentPrimary")
        if self.label then
            self.label:SetTextColor(unpack(HousingTheme.Colors.textHighlight))
        end
    end)
    
    button:SetScript("OnLeave", function(self)
        HousingTheme:ApplyBackdrop(self, "button", "bgTertiary", "borderPrimary")
        if self.label then
            self.label:SetTextColor(unpack(HousingTheme.Colors.textPrimary))
        end
    end)
    
    return button
end

-- Create a styled text input
function HousingTheme:CreateInput(parent, width, height, placeholder)
    local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    container:SetSize(width or 200, height or 28)
    self:ApplyBackdrop(container, "input", "bgPrimary", "borderPrimary")
    
    local editBox = CreateFrame("EditBox", nil, container)
    editBox:SetPoint("TOPLEFT", 8, -6)
    editBox:SetPoint("BOTTOMRIGHT", -8, 6)
    editBox:SetFontObject(self.Fonts.normal)
    editBox:SetTextColor(unpack(self.Colors.textPrimary))
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(100)
    
    if placeholder then
        local placeholderText = editBox:CreateFontString(nil, "ARTWORK", self.Fonts.normal)
        placeholderText:SetPoint("LEFT", 0, 0)
        placeholderText:SetText(placeholder)
        placeholderText:SetTextColor(unpack(self.Colors.textMuted))
        editBox.placeholder = placeholderText
        
        editBox:SetScript("OnTextChanged", function(self)
            if self.placeholder then
                self.placeholder:SetShown(self:GetText() == "")
            end
        end)
    end
    
    -- Focus effects
    editBox:SetScript("OnEditFocusGained", function()
        HousingTheme:ApplyBackdrop(container, "input", "bgSecondary", "accentPrimary")
    end)
    
    editBox:SetScript("OnEditFocusLost", function()
        HousingTheme:ApplyBackdrop(container, "input", "bgPrimary", "borderPrimary")
    end)
    
    container.editBox = editBox
    return container
end

-- Create a section header
function HousingTheme:CreateSectionHeader(parent, text)
    local header = parent:CreateFontString(nil, "OVERLAY", self.Fonts.header)
    header:SetText(text)
    header:SetTextColor(unpack(self.Colors.accentPrimary))
    return header
end

-- Create a label
function HousingTheme:CreateLabel(parent, text, fontKey)
    local label = parent:CreateFontString(nil, "OVERLAY", self.Fonts[fontKey] or self.Fonts.normal)
    label:SetText(text or "")
    label:SetTextColor(unpack(self.Colors.textSecondary))
    return label
end

-- Create a value text (for key-value pairs)
function HousingTheme:CreateValue(parent, text, fontKey)
    local value = parent:CreateFontString(nil, "OVERLAY", self.Fonts[fontKey] or self.Fonts.normal)
    value:SetText(text or "")
    value:SetTextColor(unpack(self.Colors.textPrimary))
    return value
end

-- Create a divider line
function HousingTheme:CreateDivider(parent, width)
    local divider = parent:CreateTexture(nil, "ARTWORK")
    divider:SetSize(width or 100, 1)
    divider:SetColorTexture(unpack(self.Colors.borderPrimary))
    return divider
end

-- Create a source indicator bar (left edge of item cards)
function HousingTheme:CreateSourceBar(parent)
    local bar = parent:CreateTexture(nil, "OVERLAY")
    bar:SetWidth(4)
    bar:SetPoint("TOPLEFT", 0, 0)
    bar:SetPoint("BOTTOMLEFT", 0, 0)
    bar:SetTexture("Interface\\Buttons\\WHITE8x8")
    return bar
end

-- Set source bar color based on source type
function HousingTheme:SetSourceBarColor(bar, sourceType)
    local color
    if sourceType == "Achievement" then
        color = self.Colors.sourceAchievement
    elseif sourceType == "Quest" then
        color = self.Colors.sourceQuest
    elseif sourceType == "Drop" then
        color = self.Colors.sourceDrop
    else
        color = self.Colors.sourceVendor
    end
    bar:SetVertexColor(unpack(color))
end

-- Set faction bar color
function HousingTheme:SetFactionBarColor(bar, faction)
    local color
    if faction == "Horde" then
        color = self.Colors.factionHorde
    elseif faction == "Alliance" then
        color = self.Colors.factionAlliance
    else
        color = self.Colors.factionNeutral
    end
    bar:SetVertexColor(unpack(color))
end

-- Get quality color
function HousingTheme:GetQualityColor(quality)
    local colors = {
        [0] = self.Colors.qualityPoor,
        [1] = self.Colors.qualityCommon,
        [2] = self.Colors.qualityUncommon,
        [3] = self.Colors.qualityRare,
        [4] = self.Colors.qualityEpic,
        [5] = self.Colors.qualityLegendary,
    }
    return colors[quality] or self.Colors.qualityCommon
end

-- Create a progress bar
function HousingTheme:CreateProgressBar(parent, width, height)
    local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    container:SetSize(width or 100, height or 8)
    self:ApplyBackdrop(container, "panel", "bgPrimary", "borderPrimary")
    
    local bar = container:CreateTexture(nil, "ARTWORK")
    bar:SetPoint("TOPLEFT", 1, -1)
    bar:SetPoint("BOTTOMLEFT", 1, 1)
    bar:SetWidth(0)
    bar:SetTexture("Interface\\Buttons\\WHITE8x8")
    bar:SetVertexColor(unpack(self.Colors.accentPrimary))
    container.bar = bar
    
    function container:SetProgress(percent)
        local maxWidth = self:GetWidth() - 2
        self.bar:SetWidth(math.max(0, math.min(maxWidth, maxWidth * (percent / 100))))
    end
    
    return container
end

-- Create a filter chip/pill
function HousingTheme:CreateFilterChip(parent, text, onRemove)
    local chip = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    chip:SetHeight(22)
    self:ApplyBackdrop(chip, "button", "accentPrimary", "accentPrimary")
    chip:SetBackdropColor(0.55, 0.65, 0.90, 0.3)
    
    local label = chip:CreateFontString(nil, "OVERLAY", self.Fonts.small)
    label:SetPoint("LEFT", 8, 0)
    label:SetText(text)
    label:SetTextColor(unpack(self.Colors.textPrimary))
    chip.label = label
    
    local closeBtn = CreateFrame("Button", nil, chip)
    closeBtn:SetSize(14, 14)
    closeBtn:SetPoint("LEFT", label, "RIGHT", 4, 0)
    
    local closeText = closeBtn:CreateFontString(nil, "OVERLAY", self.Fonts.small)
    closeText:SetPoint("CENTER")
    closeText:SetText("X")
    closeText:SetTextColor(unpack(self.Colors.textSecondary))
    
    closeBtn:SetScript("OnEnter", function()
        closeText:SetTextColor(unpack(self.Colors.statusError))
    end)
    closeBtn:SetScript("OnLeave", function()
        closeText:SetTextColor(unpack(self.Colors.textSecondary))
    end)
    closeBtn:SetScript("OnClick", function()
        if onRemove then onRemove() end
    end)
    
    chip:SetWidth(label:GetStringWidth() + 30)
    chip.closeBtn = closeBtn
    
    return chip
end

-- Create icon with quality border
function HousingTheme:CreateQualityIcon(parent, size)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(size + 4, size + 4)
    
    local border = container:CreateTexture(nil, "BACKGROUND")
    border:SetAllPoints()
    border:SetTexture("Interface\\Buttons\\WHITE8x8")
    border:SetVertexColor(unpack(self.Colors.borderPrimary))
    container.border = border
    
    local icon = container:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT", 2, -2)
    icon:SetPoint("BOTTOMRIGHT", -2, 2)
    container.icon = icon
    
    function container:SetQuality(quality)
        local color = HousingTheme:GetQualityColor(quality)
        self.border:SetVertexColor(unpack(color))
    end
    
    function container:SetTexture(texture)
        self.icon:SetTexture(texture)
    end
    
    return container
end

--------------------------------------------------------------------------------
-- ANIMATION HELPERS
--------------------------------------------------------------------------------

HousingTheme.Animations = {}

-- Fade in animation
function HousingTheme.Animations:FadeIn(frame, duration)
    duration = duration or 0.2
    frame:SetAlpha(0)
    frame:Show()
    
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local progress = math.min(elapsed / duration, 1)
        self:SetAlpha(progress)
        if progress >= 1 then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

-- Fade out animation
function HousingTheme.Animations:FadeOut(frame, duration, onComplete)
    duration = duration or 0.2
    
    local startAlpha = frame:GetAlpha()
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        local progress = math.min(elapsed / duration, 1)
        self:SetAlpha(startAlpha * (1 - progress))
        if progress >= 1 then
            self:SetScript("OnUpdate", nil)
            self:Hide()
            if onComplete then onComplete() end
        end
    end)
end

--------------------------------------------------------------------------------
-- REGISTER GLOBAL
--------------------------------------------------------------------------------

_G["HousingTheme"] = HousingTheme

-- Initialize theme system on addon load
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "HousingVendor" then
        HousingTheme:Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

