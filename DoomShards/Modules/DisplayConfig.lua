----------------------
-- Get addon object --
----------------------
local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end


---------------
-- Libraries --
---------------
local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")
local LSM = LibStub("LibSharedMedia-3.0")


-------------
-- Options --
-------------
local function displayOptions()
  return {
    order = 2,
    type = "group",
    name = L["Display"],
    childGroups = "select",
    cmdHidden  = true,
    get = function(info) return DS.db.display[info[#info]] end,
    set = function(info, value) DS.db.display[info[#info]] = value; DS:Build() end,
    args = {
      enable = {
        order = 1,
        type = "toggle",
        name = L["Enable"]
      },
      resource = {
        order = 3,
        type = "group",
        name = L["Soul Shard Bars"],
        args = {
          resourceEnable = {
            order = 0,
            type = "toggle",
            name = L["Enable"]
          },
          header0 = {
            order = 0.1,
            type="header",
            name=L["Dimensions"]
          },
          height = {
            order = 1,
            type = "range",
            name = function()
              if DS.db.display.orientation == "Vertical" then
                return L["Width"]
              else
                return L["Height"]
              end
            end,
            min = 1,
            max = 100,
            step = 1
          },
          width = {
            order = 2,
            type = "range",
            name = function()
              if DS.db.display.orientation == "Vertical" then
                return L["Height"]
              else
                return L["Width"]
              end
            end,
            min = 1,
            max = 100,
            step = 1
          },
          spacing = {
            order = 3,
            type = "range",
            name = L["Spacing"],
            min = 0,
            max = 100,
            step = 1
          },
          header1 = {
            order = 3.5,
            type="header",
            name=L["Shard Colors"]
          },
          color1 = {
            order = 4,
            type = "color",
            name = L["Color Shard 1"],
            hasAlpha = true,
            get = function()
              local r, b, g, a = DS.db.display.color1.r, DS.db.display.color1.b, DS.db.display.color1.g, DS.db.display.color1.a
              return r, b, g, a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.color1.r, DS.db.display.color1.b, DS.db.display.color1.g, DS.db.display.color1.a = r, b, g, a
              DS:Build()
            end
          },
          color2 = {
            order = 4.1,
            type = "color",
            name = L["Color Shard 2"],
            hasAlpha = true,
            get = function()
              local r, b, g, a = DS.db.display.color2.r, DS.db.display.color2.b, DS.db.display.color2.g, DS.db.display.color2.a
              return r, b, g, a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.color2.r, DS.db.display.color2.b, DS.db.display.color2.g, DS.db.display.color2.a = r, b, g, a
              DS:Build()
            end
          },
          color3 = {
            order = 4.2,
            type = "color",
            name = L["Color Shard 3"],
            hasAlpha = true,
            get = function()
              local r, b, g, a = DS.db.display.color3.r, DS.db.display.color3.b, DS.db.display.color3.g, DS.db.display.color3.a
              return r, b, g, a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.color3.r, DS.db.display.color3.b, DS.db.display.color3.g, DS.db.display.color3.a = r, b, g, a
              DS:Build()
            end
          },
          color4 = {
            order = 4.3,
            type = "color",
            name = L["Color Shard 4"],
            hasAlpha = true,
            get = function()
              local r, b, g, a = DS.db.display.color4.r, DS.db.display.color4.b, DS.db.display.color4.g, DS.db.display.color4.a
              return r, b, g, a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.color4.r, DS.db.display.color4.b, DS.db.display.color4.g, DS.db.display.color4.a = r, b, g, a
              DS:Build()
            end
          },
          color5 = {
            order = 4.4,
            type = "color",
            name = L["Color Shard 5"],
            hasAlpha = true,
            get = function()
              local r, b, g, a = DS.db.display.color5.r, DS.db.display.color5.b, DS.db.display.color5.g, DS.db.display.color5.a
              return r, b, g, a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.color5.r, DS.db.display.color5.b, DS.db.display.color5.g, DS.db.display.color5.a = r, b, g, a
              DS:Build()
            end
          },
          spacer2 = {
            order = 5.5,
            type="description",
            name=""
          },
          resourceCappedEnable = {
            order = 6,
            type = "toggle",
            name = L["Shard Cap Color Change"],
            desc = L["Change color of all Shards when reaching cap"]
          },
          resourceCappedColor = {
            order = 7,
            type = "color",
            name = L["Color When Shard Capped"],
            hasAlpha = true,
            get = function()
              return DS.db.display.resourceCappedColor.r, DS.db.display.resourceCappedColor.b, DS.db.display.resourceCappedColor.g, DS.db.display.resourceCappedColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.resourceCappedColor.r, DS.db.display.resourceCappedColor.b, DS.db.display.resourceCappedColor.g, DS.db.display.resourceCappedColor.a = r, b, g, a
              DS:Build()
            end,
            hidden = not DS.db.display.resourceCappedEnable
          },
          spacer3 = {
            order = 7.1,
            type="description",
            name=""
          },
          alwaysShowBorders = {
            order = 7.2,
            type = "toggle",
            name = L["Show Depleted Shards"]
          },
          emptyColor = {
            order = 7.3,
            type = "color",
            name = L["Color of Depleted Shards"],
            hasAlpha = true,
            get = function()
              return DS.db.display.emptyColor.r, DS.db.display.emptyColor.b, DS.db.display.emptyColor.g, DS.db.display.emptyColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.emptyColor.r, DS.db.display.emptyColor.b, DS.db.display.emptyColor.g, DS.db.display.emptyColor.a = r, b, g, a
              DS:Build()
            end,
            hidden = not DS.db.display.alwaysShowBorders
          },
          header3 = {
            order = 8.5,
            type="header",
            name=L["Textures"]
          },
          useTexture = {
            order = 8.6,
            type = "toggle",
            name = L["Use Texture for Shards"],
            set = function(info, val)
              DS.db.display.useTexture = val
              DS:Build()
            end
          },
          textureHandle = {
            order = 9,
            type = "select",
            dialogControl = "LSM30_Statusbar",
            name = L["Texture"],
            values = LSM:HashTable("statusbar"),
            hidden = not DS.db.display.useTexture
          },
          header4 = {
            order = 9.5,
            type="header",
            name=L["Borders"]
          },
          borderColor = {
            order = 10,
            type = "color",
            name = L["Border Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.borderColor.r, DS.db.display.borderColor.b, DS.db.display.borderColor.g, DS.db.display.borderColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.borderColor.r, DS.db.display.borderColor.b, DS.db.display.borderColor.g, DS.db.display.borderColor.a = r, b, g, a
              DS:Build()
            end
          },
          header5 = {
            order = 11.5,
            type="header",
            name=L["Visibility"]
          },
          visibilityConditionals = {
            order = 12,
            type = "input",
            name = L["Visibility Conditionals"],
            desc = L["Regulate display visibility with macro conditionals"],
            width = "double",
            set = function(info, val)
              DS.db.display.visibilityConditionals = val
              DS:Build()
            end
          },
          fadeOutDuration = {
            order = 13,
            type = "range",
            name = L["Fade Duration"],
            min = 0.1,
            max = 10,
            step = 0.1,
            hidden = not (DS.db.display.visibilityConditionals and DS.db.display.visibilityConditionals:find("fade"))
          },
        }
      },
      animations = {
        order = 10,
        type = "group",
        name = L["Animations"],
        args = {
          header6 = {
            order = 13.5,
            type="header",
            name=L["Soul Shard Bars"]
          },
          gainFlash = {
            order = 14,
            type = "toggle",
            name = L["Flash on Shard Gain"],
            set = function(info, val)
              DS.db.display.gainFlash = val
              DS:Build()
            end
          },
          spacer5 = {
            order = 14.5,
            type = "description",
            name = ""
          },
          resourceSpendIncludeHoG = {
            order = 15,
            type = "toggle",
            name = L["Add. HoG Shards"],
            desc = L["Include Doom tick indicator in Hand of Gul'dan casts. (Demonology only)"],
            set = function(info, val)
              DS.db.display.resourceSpendIncludeHoG = val
              DS:Build()
            end
          },
          spacer6 = {
            order = 15.5,
            type="description",
            name=""
          },
          resourceGainPrediction = {
            order = 16,
            type = "toggle",
            name = L["Indicate Shard Building"],
            desc = L["Show prediction for gaining shards through casts"],
            set = function(info, val)
              DS.db.display.resourceGainPrediction = val
              DS:Build()
            end
          },
          resourceGainColor = {
            order = 17,
            type = "color",
            name = L["Shard Gain Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.resourceGainColor.r, DS.db.display.resourceGainColor.b, DS.db.display.resourceGainColor.g, DS.db.display.resourceGainColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.resourceGainColor.r, DS.db.display.resourceGainColor.b, DS.db.display.resourceGainColor.g, DS.db.display.resourceGainColor.a = r, b, g, a
              DS:Build()
            end,
            hidden = not DS.db.display.resourceGainPrediction
          },
          spacer7 = {
            order = 17.5,
            type="description",
            name=""
          },
          resourceSpendPrediction = {
            order = 18,
            type = "toggle",
            name = L["Indicate Shard Spending"],
            desc = L["Show prediction for spending shards through casts"],
            set = function(info, val)
              DS.db.display.resourceSpendPrediction = val
              DS:Build()
            end
          },
          resourceSpendColor = {
            order = 19,
            type = "color",
            name = L["Shard Spend Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.resourceSpendColor.r, DS.db.display.resourceSpendColor.b, DS.db.display.resourceSpendColor.g, DS.db.display.resourceSpendColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.resourceSpendColor.r, DS.db.display.resourceSpendColor.b, DS.db.display.resourceSpendColor.g, DS.db.display.resourceSpendColor.a = r, b, g, a
              DS:Build()
            end,
            hidden = not DS.db.display.resourceSpendPrediction
          },
          header7 = {
            order = 19.5,
            type="header",
            name=L["Text"]
          },
          fontColorHoGPrediction = {
            order = 20,
            type = "color",
            name = L["Font Color for Hand of Gul'dan Prediction"],
            desc = L["Color the text will change to if doom will tick before next possible Hand of Gul'dan cast."],
            hasAlpha = true,
            get = function()
              return DS.db.display.fontColorHoGPrediction.r, DS.db.display.fontColorHoGPrediction.b, DS.db.display.fontColorHoGPrediction.g, DS.db.display.fontColorHoGPrediction.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.fontColorHoGPrediction.r, DS.db.display.fontColorHoGPrediction.b, DS.db.display.fontColorHoGPrediction.g, DS.db.display.fontColorHoGPrediction.a = r, b, g, a
              DS:Build()
            end
          },
        },
      },
      text = {
        order = 5,
        type = "group",
        name = L["Text"],
        args = {
          textEnable = {
            order = 5,
            type = "toggle",
            name = L["Enable"]
          },
          header1 = {
            order = 5.5,
            type="header",
            name=L["Font"]
          },
          fontName = {
            order = 6,
            type = "select",
            dialogControl = "LSM30_Font",
            name = L["Font"],
            values = LSM:HashTable("font")
          },
          fontSize = {
            order = 8,
            type = "range",
            name = L["Font Size"],
            min = 1,
            max = 32,
            step = 1
          },
          fontFlags = {
            order = 9,
            type = "select",
            style = "dropdown",
            name = L["Font Flags"],
            values = {
              ["None"] = L["None"],
              ["Shadow"] = L["Shadow"],
              ["OUTLINE"] = L["OUTLINE"],
              ["THICKOUTLINE"] = L["THICKOUTLINE"],
              ["MONOCHROMEOUTLINE"] = L["MONOCHROMEOUTLINE"]
            }
          },
          spacer0 = {
            order = 9.5,
            type="description",
            name=""
          },
          fontColor = {
            order = 10,
            type = "color",
            name = L["Font Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.fontColor.r, DS.db.display.fontColor.b, DS.db.display.fontColor.g, DS.db.display.fontColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.fontColor.r, DS.db.display.fontColor.b, DS.db.display.fontColor.g, DS.db.display.fontColor.a = r, b, g, a
              DS:Build()
            end
          },
          header2 = {
            order = 10.5,
            type="header",
            name=L["Functionality"]
          },
          desc = {
            order = 11,
            type = "description",
            name = L["Threshold when text begins showing first decimal place"],
          },
          remainingTimeThreshold = {
            order = 12,
            type = "range",
            name = L["Time Threshold"],
            min = 0,
            max = 10,
            step = 0.1
          },
          header3 = {
            order = 13,
            type="header",
            name=L["Offset"]
          },
          stringXOffset = {
            order = 14,
            type = "range",
            name = L["X Offset"],
            min = -1000,
            max = 1000,
            step = 1,
            get = function()
              local offset = DS.db.display.orientation == "Vertical" and -DS.db.display.stringYOffset or DS.db.display.stringXOffset
              if (DS.db.display.growthDirection == "Reversed") and (DS.db.display.orientation ~= "Vertical") then offset = -offset end
              return offset
            end,
            set = function(info, val)
              if DS.db.display.orientation == "Vertical" then
                DS.db.display.stringYOffset = -val
              else
                if DS.db.display.growthDirection == "Reversed" then val = -val end
                DS.db.display.stringXOffset = val
              end
              DS:Build()
            end
          },
          stringYOffset = {
            order = 15,
            type = "range",
            name = L["Y Offset"],
            min = -1000,
            max = 1000,
            step = 1,
            get = function()
              local offset = DS.db.display.orientation == "Vertical" and DS.db.display.stringXOffset or DS.db.display.stringYOffset
              if DS.db.display.growthDirection == "Reversed" and DS.db.display.orientation == "Vertical" then offset = -offset end
              return offset
            end,
            set = function(info, val)
              if DS.db.display.orientation == "Vertical" then
                if DS.db.display.growthDirection == "Reversed" and DS.db.display.orientation == "Vertical" then val = -val end
                DS.db.display.stringXOffset = val
              else
                DS.db.display.stringYOffset = val
              end
              DS:Build()
            end
          }
        }
      },
      statusbar = {
        order = 4,
        type = "group",
        name = L["Doom Tick Indicator Bars"],
        args = {
          statusbarEnable = {
            order = 1,
            type = "toggle",
            name = L["Enable"],
            desc = L["Enable bars for incoming Doom ticks"]
          },
          header1 = {
            order = 2,
            type="header",
            name=L["Consolidate Ticks"]
          },
          descConsolidateTicks = {
            order = 2.1,
            type = "description",
            name = L["Consolidate individual ticks to full expected shards"],
          },
          consolidateTicks = {
            order = 2.2,
            type = "toggle",
            name = L["Consolidate Ticks"]
          },
          header2 = {
            order = 3,
            type="header",
            name=L["Colors"]
          },
          statusbarColor = {
            order = 4,
            type = "color",
            name = L["Bar Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.statusbarColor.r, DS.db.display.statusbarColor.b, DS.db.display.statusbarColor.g, DS.db.display.statusbarColor.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.statusbarColor.r, DS.db.display.statusbarColor.b, DS.db.display.statusbarColor.g, DS.db.display.statusbarColor.a = r, b, g, a
              DS:Build()
            end
          },
          statusbarColorBackground = {
            order = 5,
            type = "color",
            name = L["Background Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.statusbarColorBackground.r, DS.db.display.statusbarColorBackground.b, DS.db.display.statusbarColorBackground.g, DS.db.display.statusbarColorBackground.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.statusbarColorBackground.r, DS.db.display.statusbarColorBackground.b, DS.db.display.statusbarColorBackground.g, DS.db.display.statusbarColorBackground.a = r, b, g, a
              DS:Build()
            end
          },
          header3 = {
            order = 9,
            type="header",
            name=L["Overcapping"]
          },
          statusbarCount = {
            order = 10,
            type = "range",
            name = L["Additional Doom Indicators"],
            min = 0,
            max = 20,
            step = 1
          },
          statusbarColorOverflowForeground = {
            order = 10.9,
            type = "color",
            name = L["\"Overcap Shards\" Bar Color"],
            desc = L["Color of additional indicators for overcapping with Doom ticks"],
            hasAlpha = true,
            get = function()
              return DS.db.display.statusbarColorOverflowForeground.r, DS.db.display.statusbarColorOverflowForeground.b, DS.db.display.statusbarColorOverflowForeground.g, DS.db.display.statusbarColorOverflowForeground.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.statusbarColorOverflowForeground.r, DS.db.display.statusbarColorOverflowForeground.b, DS.db.display.statusbarColorOverflowForeground.g, DS.db.display.statusbarColorOverflowForeground.a = r, b, g, a
              DS:Build()
            end
          },
          statusbarColorOverflow = {
            order = 11,
            type = "color",
            name = L["\"Overcap Shards\" Color"],
            hasAlpha = true,
            get = function()
              return DS.db.display.statusbarColorOverflow.r, DS.db.display.statusbarColorOverflow.b, DS.db.display.statusbarColorOverflow.g, DS.db.display.statusbarColorOverflow.a
            end,
            set = function(info, r, b, g, a)
              DS.db.display.statusbarColorOverflow.r, DS.db.display.statusbarColorOverflow.b, DS.db.display.statusbarColorOverflow.g, DS.db.display.statusbarColorOverflow.a = r, b, g, a
              DS:Build()
            end
          },
          header4 = {
            order = 12,
            type="header",
            name=L["Direction"]
          },
          statusbarReverse = {
            order = 13,
            type = "toggle",
            name = L["Reverse Direction"],
            desc = L["Fill indicator from right to left"]
          },
          header5 = {
            order = 14,
            type="header",
            name=L["Offset"]
          },
          statusbarXOffset = {
            order = 15,
            type = "range",
            name = L["X Offset"],
            min = -math.ceil(GetScreenWidth()),
            max = math.ceil(GetScreenWidth()),
            step = 1,
            get = function()
              local offset = DS.db.display.orientation == "Vertical" and -DS.db.display.statusbarYOffset or DS.db.display.statusbarXOffset
              if (DS.db.display.growthDirection == "Reversed") and (DS.db.display.orientation ~= "Vertical") then offset = -offset end
              return offset
            end,
            set = function(info, val)
              if DS.db.display.orientation == "Vertical" then
                DS.db.display.statusbarYOffset = -val
              else
                if DS.db.display.growthDirection == "Reversed" then val = -val end
                DS.db.display.statusbarXOffset = val
              end
              DS:Build()
            end
          },
          statusbarYOffset = {
            order = 16,
            type = "range",
            name = L["Y Offset"],
            min = -math.ceil(GetScreenHeight()),
            max = math.ceil(GetScreenHeight()),
            step = 1,
            get = function()
              local offset = DS.db.display.orientation == "Vertical" and DS.db.display.statusbarXOffset or DS.db.display.statusbarYOffset
              if DS.db.display.growthDirection == "Reversed" and DS.db.display.orientation == "Vertical" then offset = -offset end
              return offset
            end,
            set = function(info, val)
              if DS.db.display.orientation == "Vertical" then
                if DS.db.display.growthDirection == "Reversed" and DS.db.display.orientation == "Vertical" then val = -val end
                DS.db.display.statusbarXOffset = val
              else
                DS.db.display.statusbarYOffset = val
              end
              DS:Build()
            end
          },
        }
      },
      positioning = {
        order = 7,
        type = "group",
        name = L["Positioning"],
        args = {
          orientation = {
            order = 1,
            type = "select",
            style = "dropdown",
            name = L["Orientation"],
            values = {
              ["Horizontal"] = L["Horizontal"],
              ["Vertical"] = L["Vertical"]
            }
          },
          growthDirection = {
            order = 2,
            type = "select",
            name = L["Growth direction"],
            desc = L["Order in which Shards get filled in"],
            values = {
              ["Regular"] = L["Regular"],
              ["Reversed"] = L["Reversed"]
            }
          },
          header2 = {
            order = 2.5,
            type = "header",
            name = L["Anchor"]
          },
          anchor = {
            order = 3,
            type = "select",
            style = "dropdown",
            name = L["Anchor Point"],
            values = {
              ["CENTER"] = "CENTER",
              ["BOTTOM"] = "BOTTOM",
              ["TOP"] = "TOP",
              ["LEFT"] = "LEFT",
              ["RIGHT"] = "RIGHT",
              ["BOTTOMLEFT"] = "BOTTOMLEFT",
              ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
              ["TOPLEFT"] = "TOPLEFT",
              ["TOPRIGHT"] = "TOPRIGHT"
            }
          },
          anchorFrame = {
            order = 4,
            type = "input",
            name = L["Anchor Frame"],
            desc = L["Will change to UIParent when manually dragging frame."]
          },
          header3 = {
            order = 4.5,
            type = "header",
            name = L["Position"]
          },
          posX = {
            order = 5,
            type = "range",
            name = L["X Position"],
            min = -math.ceil(GetScreenWidth()),
            max = math.ceil(GetScreenWidth()),
            step = 1
          },
          posY = {
            order = 6,
            type = "range",
            name = L["Y Position"],
            min = -math.ceil(GetScreenHeight()),
            max = math.ceil(GetScreenHeight()),
            step = 1
          },
        }
      }
    }
  }
end

local defaultSettings = {
  profile = {
    enable = true,
    resourceEnable = true,
    anchor = "CENTER",
    anchorFrame = "UIParent",
    posX = 0,
    posY = 0,
    height = 8,
    width = 32,
    spacing = 1,
    color1 = {r=0.38, b=0.23, g=0.51, a=1},
    color2 = {r=0.38, b=0.23, g=0.51, a=1},
    color3 = {r=0.38, b=0.23, g=0.51, a=1},
    color4 = {r=0.38, b=0.23, g=0.51, a=1},
    color5 = {r=0.38, b=0.23, g=0.51, a=1},  -- {r=0.51, b=0.00, g=0.24, a=1}
    textEnable = true,
    fontSize = 15,
    fontName = "Friz Quadrata TT",
    fontFlags = "Shadow",
    fontColor = {r=1, b=1, g=1, a=1},
    fontColorHoGPrediction = {r=0.51, b=0.00, g=0.24, a=1},
    remainingTimeThreshold = 4,
    stringXOffset = 0,
    stringYOffset = 6,
    visibilityConditionals = "[mod:alt] [harm] [combat] show; fade",
    fadeOutDuration = 0.5,
    orientation = "Horizontal",
    growthDirection = "Regular",
    useTexture = false,
    textureHandle = "Empty",
    borderColor = {r=0, b=0, g=0, a=1},
    alwaysShowBorders = false,  -- Legacy name, toggles showing of depleted resources
    emptyColor = {r=0.06, b=0.06, g=0.06, a=1},
    statusbarEnable = true,
    statusbarColor = {r=0.33, b=0.33, g=0.33, a=0.5},
    statusbarColorBackground = {r=0.06, b=0.06, g=0.06, a=1},
    statusbarColorOverflowForeground = {r=0.33, b=0.33, g=0.33, a=0.5},
    statusbarColorOverflow = {r=0.51, b=0.00, g=0.24, a=1},
    statusbarReverse = false,
    statusbarXOffset = 0,
    statusbarYOffset = 6,
    statusbarCount = 5,
    resourceCappedEnable = true,
    resourceCappedColor = {r=0.51, b=0.00, g=0.24, a=1},
    gainFlash = true,
    resourceGainPrediction = false,
    resourceGainColor = {r=0.4, b=0.4, g=0.4, a=1},--{r=0.51, b=0.00, g=0.24, a=1},
    resourceSpendPrediction = true,
    resourceSpendColor = {r=0.4, b=0.4, g=0.4, a=1},
    resourceSpendIncludeHoG = true,
    consolidateTicks = true,
  }
}

DS:AddDisplayOptions("display", displayOptions, defaultSettings)
