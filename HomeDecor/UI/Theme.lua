local ADDON, NS = ...

NS.UI = NS.UI or {}

NS.UI.Theme = {
  colors = {
    bg          = { 0.045, 0.045, 0.05, 1 },
    header      = { 0.075, 0.075, 0.085, 1 },
    panel       = { 0.095, 0.095, 0.11, 1 },
    row         = { 0.13, 0.13, 0.15, 1 },
    hover       = { 0.17, 0.17, 0.20, 1 },
    border      = { 0.24, 0.24, 0.28, 1 },

    accent      = { 0.90, 0.72, 0.18, 1 },
    accentSoft  = { 0.90, 0.72, 0.18, 0.28 },
    accentBright= { 1, 0.95, 0.6, 1 },
    accentDark  = { 0.28, 0.24, 0.10, 1 },

    text        = { 0.92, 0.92, 0.92, 1 },
    textMuted   = { 0.65, 0.65, 0.68, 1 },
    placeholder = { 0.52, 0.52, 0.55, 1 },

    success     = { 0.30, 0.80, 0.40, 1 },
    successDark = { 0.18, 0.50, 0.24, 1 },
    warning     = { 0.85, 0.55, 0.22, 1 },
    danger      = { 0.80, 0.28, 0.28, 1 },

    rowBG       = { 0.05, 0.07, 0.09, 0.55 },
    counterBG   = { 0.05, 0.08, 0.12, 0.85 },
    progressBG  = { 0.04, 0.04, 0.05, 0.95 },
    iconBG      = { 0.08, 0.08, 0.10, 0.8 },

    grayDark    = { 0.18, 0.18, 0.20, 1 },
    grayLight   = { 0.45, 0.45, 0.48, 1 },
  },

  textures = {
    Logo = "Interface\\AddOns\\HomeDecor\\Media\\UI\\logo.tga",

    ButtonNormal   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\button_normal.tga",
    ButtonHover    = "Interface\\AddOns\\HomeDecor\\Media\\UI\\button_hover.tga",
    ButtonPushed   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\button_pushed.tga",
    ButtonDisabled = "Interface\\AddOns\\HomeDecor\\Media\\UI\\button_disabled.tga",

    TabNormal   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\tab_normal.tga",
    TabHover    = "Interface\\AddOns\\HomeDecor\\Media\\UI\\tab_hover.tga",
    TabPushed   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\tab_pushed.tga",
    TabDisabled = "Interface\\AddOns\\HomeDecor\\Media\\UI\\tab_disabled.tga",

    ScrollTrack = "Interface\\AddOns\\HomeDecor\\Media\\UI\\scroll_track.tga",
    ScrollThumb = "Interface\\AddOns\\HomeDecor\\Media\\UI\\scroll_thumb.tga",

    ScrollArrowUp   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\scroll_arrow_up.tga",
    ScrollArrowDown = "Interface\\AddOns\\HomeDecor\\Media\\UI\\scroll_arrow_down.tga",
    DropdownBox     = "Interface\\AddOns\\HomeDecor\\Media\\UI\\dropdown_box.tga",
    DropdownArrow   = "Interface\\AddOns\\HomeDecor\\Media\\UI\\dropdown_arrow.tga",
  },
}

return NS.UI.Theme
