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
LSM:Register("sound", "Droplet", "Interface\\Addons\\DoomShards\\Media\\CSDroplet.mp3")


-------------
-- Options --
-------------
local function displayOptions()
  return {
    order = 4,
    type = "group",
    name = L["Sound"],
    cmdHidden = true,
    get = function(info) return DS.db.warningSound[info[#info]] end,
    set = function(info, value) DS.db.warningSound[info[#info]] = value; DS:Build() end,
    args = {
      enable = {
        order = 1,
        type = "toggle",
        name = L["Enable"],
        desc = L["Play Warning Sound when about to cap."]
      },
      soundHandle = {
        order = 2,
        type = "select",
        dialogControl = "LSM30_Sound",
        name = "",
        desc = L["File to play."],
        values = LSM:HashTable("sound")
      },
      soundInterval = {
        order = 3,
        type = "range",
        name = L["Interval"],
        desc = L["Time between warning sounds"],
        min = 0.1,
        max = 10,
        step = 0.1
      },
      spacer = {
        order = 3.5,
        type = "description",
        name = ""
      },
      instances = {
        order = 4,
        type = "multiselect",
        name = L["Instance Type"],
        get = function(info, key) return DS.db.warningSound[info[#info]][key] end,
        set = function(info, key, value) DS.db.warningSound[info[#info]][key] = value; DS:Build() end,
        values = {
          none = L["No Instance"],
          scenario = L["Scenario"],
          party = L["Dungeon"],
          raid = L["Raid"],
          arena = L["Arena"],
          pvp = L["Battleground"]
        }
      }
    }
  }
end

local defaultSettings = {
  profile = {
    enable = false,
    soundHandle = "Droplet",
    soundInterval = 2,
    timeFrame = 10,
    instances = {
      arena = true,
      none = true,
      party = true,
      pvp = true,
      raid = true,
      scenario = true
    }
  }
}

DS:AddDisplayOptions("warningSound", displayOptions, defaultSettings)
