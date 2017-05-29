-----------
-- Addon --
-----------
local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end


---------------
-- Libraries --
---------------
local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")
local SER = LibStub("AceSerializer-3.0")


-------------
-- Options --
-------------
-- Reasonably safe import
local function importProfile(_, value)
  local isValid, importProfile = SER:Deserialize(value)
  if isValid then
    for key, setting in pairs(DS.db) do
      if type(setting) == "table" then
        if importProfile[key] then
          for k, v in pairs(importProfile[key]) do
            setting[k] = v
          end
        end
      else
        DS.db[key] = importProfile[key]
      end
    end
    
    print(L["Doom Shards: Profile import completed"])
    
    DS:Build()
  end
end

local function exportImportOptions()
  return {
    order = 7,
    type = "group",
    name = L["Export/Import"],
    childGroups = "select",
    cmdHidden  = true,
    args = {
      export = {
        order = 1,
        name = L["Export"],
        desc = L["Copy string for later import"],
        type = "input",
        multiline = 13,
        width = "full",
        get = function()
          return SER:Serialize(DS.db)
        end
      },
      import = {
        order = 2,
        name = L["Import"],
        desc = L["Paste import string here"],
        type = "input",
        multiline = 13,
        width = "full",
        set = importProfile,
        confirm = true,
        confirmText = L["Really import profile?"],
        validate = function(info, value)
          local isValid, err = SER:Deserialize(value)
          local isTable = type(import) ~= "table"
          if isValid and not isTable then
            err = L["not a table"]
          end
          return (isValid and isTable) or (L["Failed to import profile: "]..err)
        end,
      }
    }
  }
end

DS:AddDisplayOptions("exportImport", exportImportOptions, {})
