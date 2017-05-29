local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end

local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")


-------------
-- Options --
-------------
local function optionsTable()
  return {
    type = "group",
    name = "Doom Shards",
    childGroups = "tab",
    get = function(info) return DS.db[info[#info]] end,
    set = function(info, value) DS.db[info[#info]] = value; DS:Build() end,
    args = {
      header2 = {
        order = 0,
        type = "header",
        name = L["Version"].." v25"
      },
      general = {
        order = 1,
        type = "group",
        name = L["General"],
        cmdHidden = true,
        inline = true,
        args = {
          --[[scale = {
            order = 1,
            type = "range",
            name = L["Scale"],
            min = 0,
            max = 3,
            step = 0.01
          },]]--
          --[[reset = {
            order = 2,
            type = "execute",
            name = L["Reset to Defaults"],
            confirm = true,
            func = function()
              DS:ResetDB()
            end
          },]]--
          resetPosition = {
            order = 3,
            type = "execute",
            name = L["Reset Position"],
            cmdHidden = true,
            confirm  = true,
            func = function() 
              for name, module in DS:IterateModules() do
                if DS.db[name] then
                  if DS.db[name].posX then DS.db[name].posX = 0 end
                  if DS.db[name].posY then DS.db[name].posY = 0 end
                end
              end
              DS:Build()
            end
          },
          lock = {
            order = 1,
            type = "execute",
            name = L["Toggle Lock"],
            desc = L["Shows the frame and toggles it for repositioning."],
            func = function()
              if UnitAffectingCombat("player") then return end
              if not DS.locked then
                DS:Lock()
              else
                DS:Unlock()
              end
            end
          },
          testMode = {
            order = 2,
            type = "execute",
            name = L["Test Mode"],
            func = function()
              if not UnitAffectingCombat("player") then
                DS:TestMode() 
              end
            end
          }
        }
      },
    }
  }
end

DS.defaultSettings = {
  profile = {
    debug = false,
    debugSA = false
  }
}

do
  local moduleOptions = {}
  
  function DS:AddDisplayOptions(displayName, displayOptions, displayDefaults)
    moduleOptions[displayName] = displayOptions
    self.defaultSettings.profile[displayName] = displayDefaults.profile
  end
  
  
  local function createOptions()
    local optionsTable = optionsTable()
    
    for displayName, displayOptions in pairs(moduleOptions) do
      optionsTable.args[displayName] = displayOptions()
    end
    
    return optionsTable
  end

  LibStub("AceConfig-3.0"):RegisterOptionsTable("Doom Shards", createOptions)
end

local ACD = LibStub("AceConfigDialog-3.0")
ACD:AddToBlizOptions("Doom Shards")
ACD:SetDefaultSize("Doom Shards", 700, 750)

function DS:HandleChatCommand(command)
  local suffix = string.match(command, "(%w+)")

  if suffix then
    if suffix == "toggle" or suffix == "lock" or (suffix == "unlock" and self.locked) then
      if self.locked then
        self:Unlock()
      else
        self:Lock()
      end
      
    elseif suffix == "debug" then
      self.debug = not self.debug
      if self.debug then
        print("|cFF814eaaDoom Shards|r: debugging enabled")
      else
        print("|cFF814eaaDoom Shards|r: debugging disabled")
      end
      return
      
    elseif suffix == "debugSA" then
      self.debugSA = not self.debugSA
      if self.debugSA then
        print("|cFF814eaaDoom Shards|r: debugging SATimers enabled")
      else
        print("|cFF814eaaDoom Shards|r: debugging SATimers disabled")
      end
      return
      
    end
  end
  
  if ACD.OpenFrames[addons] then
    ACD:Close("Doom Shards")
  else
    ACD:Open("Doom Shards")
  end
end

DS:RegisterChatCommand("ds", "HandleChatCommand")
DS:RegisterChatCommand("doomshards", "HandleChatCommand")
