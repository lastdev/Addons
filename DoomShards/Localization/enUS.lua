-- Debugging
local debug = false
--[===[@debug@
--GAME_LOCALE = "koKR"
--debug = true
--@end-debug@]===]


-- Libraries
local L = LibStub("AceLocale-3.0"):NewLocale("DoomShards", "enUS", true, debug)
if not L then return end


-- Translations
L["\"Overcap Shards\" Bar Color"] = true
L["\"Overcap Shards\" Color"] = "\"Overcap Shards\" Background Color"
L["Add. HoG Shards"] = true
L["Additional Doom Indicators"] = true
L["Affliction"] = true
L["Always show borders"] = true
L["Anchor"] = true
L["Anchor Frame"] = true
L["Anchor Point"] = true
L["Animations"] = true
L["Arena"] = true
L["Background Color"] = true
L["Bar Color"] = true
L["Battleground"] = true
L["Border Color"] = true
L["Borders"] = true
L["Cancelled Test Mode"] = "|cFF814eaaDoom Shards|r: Cancelled Test Mode!"
L["Change color of all Shards when reaching cap"] = true
L["Color of additional indicators for overcapping with Doom ticks"] = true
L["Color of Depleted Shards"] = true
L["Color Shard 1"] = true
L["Color Shard 2"] = true
L["Color Shard 3"] = true
L["Color Shard 4"] = true
L["Color Shard 5"] = true
L["Color the text will change to if doom will tick before next possible Hand of Gul'dan cast."] = "Color the text will change to if prediction ends before end of the next possible filler cast (Shadow Bolt/Incinerate/2 ticks of Drain Life)."
L["Color When Shard Capped"] = true
L["Colors"] = true
L["Consolidate individual ticks to full expected shards"] = "Consolidate individual ticks into full expected shards. E.g. for Agony, which doesn't have a 100% to generate a Soul Shard on tick."
L["Consolidate Ticks"] = true
L["Copy string for later import"] = true
L["Demonology"] = true
L["Destruction"] = true
L["Dimensions"] = true
L["Direction"] = true
L["Display"] = true
L["Documentation"] = true
L["Doom Shards locked!"] = "|cFF814eaaDoom Shards|r locked!"
L["Doom Shards reset!"] = "|cFF814eaaDoom Shards|r reset!"
L["Doom Shards unlocked!"] = "|cFF814eaaDoom Shards|r unlocked!"
L["Doom Shards: Profile import completed"] = "|cFF814eaaDoom Shards|r: Profile import completed"
L["Doom Tick Indicator Bars"] = true
L["dragFrameTooltip"] = [=[|cFFcc0060Left mouse button|r to drag.
|cFFcc0060Right mouse button|r to lock.
|cFFcc0060Mouse wheel|r and |cFFcc0060shift + mouse wheel|r for fine adjustment.]=]
L["Dungeon"] = true
L["Enable"] = true
L["Enable bars for incoming Doom ticks"] = true
L["Export"] = true
L["Export/Import"] = true
L["Fade Duration"] = true
L["Failed to import profile: "] = true
L["File to play."] = true
L["Fill indicator from right to left"] = "Fill indicator from right to left."
L["Flash on Shard Gain"] = true
L["Font"] = true
L["Font Color"] = true
L["Font Color for Hand of Gul'dan Prediction"] = "Font Color for low remaining time"
L["Font Flags"] = true
L["Font Size"] = true
L["Functionality"] = true
L["General"] = true
L["Growth direction"] = true
L["Height"] = true
L["Horizontal"] = true
L["Import"] = true
L["Include Doom tick indicator in Hand of Gul'dan casts. (Demonology only)"] = true
L["Indicate Shard Building"] = true
L["Indicate Shard Spending"] = true
L["Instance Type"] = true
L["Interval"] = true
L["MONOCHROMEOUTLINE"] = true
L["No Instance"] = true
L["None"] = true
L["not a table"] = true
L["Offset"] = true
L["Order in which Shards get filled in"] = true
L["Orientation"] = true
L["OUTLINE"] = true
L["Overcapping"] = true
L["Paste import string here"] = true
L["Play Warning Sound when about to cap."] = true
L["Position"] = true
L["Positioning"] = true
L["Raid"] = true
L["Really import profile?"] = true
L["Regular"] = true
L["Regulate display visibility with macro conditionals"] = [=[
Regulate display visibility with macro conditionals
show - show display
hide - hide display
fade - fade out display
]=]
L["Reset Position"] = true
L["Reset to Defaults"] = true
L["Reverse Direction"] = true
L["Reversed"] = true
L["Scale"] = true
L["Scenario"] = true
L["Shadow"] = true
L["Shard Cap Color Change"] = "Cap Color Change"
L["Shard Colors"] = true
L["Shard Gain Color"] = true
L["Shard Spend Color"] = true
L["Show Depleted Shards"] = true
L["Show prediction for gaining shards through casts"] = true
L["Show prediction for spending shards through casts"] = true
L["Shows the frame and toggles it for repositioning."] = true
L["Soul Shard Bars"] = true
L["Sound"] = true
L["Spacing"] = true
L["Specializations"] = true
L["Starting Test Mode"] = "|cFF814eaaDoom Shards|r: Starting Test Mode"
L["Test Mode"] = true
L["Text"] = true
L["Texture"] = true
L["Textures"] = true
L["THICKOUTLINE"] = true
L["Threshold when text begins showing first decimal place"] = "Threshold when text begins showing first decimal place."
L["Time between warning sounds"] = true
L["Time Threshold"] = true
L["Toggle Lock"] = true
L["Track Agony"] = true
L["Track Doom"] = true
L["Track Shadowburn"] = true
L["Track Unstable Affliction"] = true
L["Use Texture for Shards"] = true
L["Version"] = true
L["Vertical"] = true
L["Visibility"] = true
L["Visibility Conditionals"] = true
L["WeakAuras Example Strings"] = true
L["WeakAuras Import String 1"] = true
L["WeakAuras Import String 2"] = true
L["WeakAuras Interface"] = true
L["WeakAuras String to use when \"WeakAuras\" Display is selected. Copy & paste into WeakAuras to import."] = true
L["WeakAurasDocumentation"] = [=[WeakAuras event
  DOOM_SHARDS_DISPLAY_UPDATE
    Note: Only triggers when Display is enabled. Disable parts of Display instead if you want to use this event.

DoomShards methods
  DoomShards:GetPrediction(index)
    arguments
      index (number) : index of predicted tick
    return nextTick, resourceGenerationChance
      nextTick (number) : time stamp of next tick
      resourceGenerationChance (number) : chance to generate a Soul Shard on the next tick]=]
L["Width"] = true
L["Will change to UIParent when manually dragging frame."] = true
L["X Offset"] = true
L["X Position"] = true
L["Y Offset"] = true
L["Y Position"] = true

