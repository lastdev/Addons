local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
--local Data = KhamulsAchievementFilter:GetModule("Data", true)

function KhamulsAchievementFilter:InitOptions()
  local AceConfig = LibStub("AceConfig-3.0")
  local AceConfigDialog = LibStub("AceConfigDialog-3.0")

  local options = {
    type = "group",
    name = L["Khamuls Collections for Krowi's Achievement Filter"],
    args = {
      information = {
        type ="description",
        width = "full",
        fontSize = "medium",
        order = 0,
        name = L["Changing any option on this page, requires a reload to take affect."]
      },
      decorAchievements = {
        type = "group",
        inline = true,
        name = L["Decor Collection Settings"],
        order = 1,
        args = {
          decorAchievementsEnabled = {
            type = "toggle",
            name = L["Show List for Achievements with decors as reward"],
            desc = L["If enabled, a list with all achievements, which have a decor as reward, will be shown"],
            width = "full",
            order = 1,
            get = function()
              return KhamulsAchievementFilter.db.profile.decorAchievementsEnabled
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.decorAchievementsEnabled = value
            end,
          },
          flattenStructure = {
            type = "toggle",
            name = L["Flatten collection structure"],
            desc = L["The collections depth will be flatten and all achievements will be displayed in the expansions category"],
            width = "full",
            order = 2,
            get = function()
              return KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure = value
            end
          },
          includeChildAchievements = {
            type = "toggle",
            name = L["Include Child Achievements"],
            desc = L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."],
            width = "full",
            order = 3,
            get = function()
              return KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements = value
            end
          }
        }
      },
      campsiteAchievements = {
        type = "group",
        inline = true,
        name = L["Campsite Collection Settings"],
        order = 2,
        args = {
          campsiteAchievementsEnabled = {
            type = "toggle",
            name = L["Show List for Achievements with warband campsites as reward"],
            desc = L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"],
            width = "full",
            order = 1,
            get = function()
              return KhamulsAchievementFilter.db.profile.campsiteAchievementsEnabled
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.campsiteAchievementsEnabled = value
            end,
          },
          flattenStructure = {
            type = "toggle",
            name = L["Flatten collection structure"],
            desc = L["The collections depth will be flatten and all achievements will be displayed in the expansions category"],
            width = "full",
            order = 2,
            get = function()
              return KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.flattenStructure
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.flattenStructure = value
            end
          },
          includeChildAchievements = {
            type = "toggle",
            name = L["Include Child Achievements"],
            desc = L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."],
            width = "full",
            order = 3,
            get = function()
              return KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements = value
            end
          }
        }
      },
      metaAchievements = {
        type = "group",
        inline = true,
        name = L["Meta-Mount Collection Settings"],
        order = 3,
        args = {
          metaAchievementsEnabled = {
            type = "toggle",
            name = L["Show List for Expansion Meta Achievements"],
            desc = L["If enabled, a list with all achievements required for expansion meta achievements will be shown"],
            width = "full",
            order = 1,
            get = function()
              return KhamulsAchievementFilter.db.profile.metaAchievementsEnabled
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.metaAchievementsEnabled = value
            end,
          },
        }
      },
      petAchievements = {
        type = "group",
        inline = true,
        name = L["Pet Collection Settings"],
        order = 4,
        args = {
          petAchievementsEnabled = {
            type = "toggle",
            name = L["Show List for Achievements with battle pets as reward"],
            desc = L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"],
            width = "full",
            order = 1,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsEnabled
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsEnabled = value
            end,
          },
          flattenStructure = {
            type = "toggle",
            name = L["Flatten collection structure"],
            desc = L["The collections depth will be flatten and all achievements will be displayed in the expansions category"],
            width = "full",
            order = 2,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure = value
            end
          },
          includeChildAchievements = {
            type = "toggle",
            name = L["Include Child Achievements"],
            desc = L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."],
            width = "full",
            order = 3,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements = value
            end
          },
          includePetRelatedStuff = {
            type = "toggle",
            name = L["Include Battle-Pet related rewards"],
            desc = L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"],
            width = "full",
            order = 4,
            get = function()
              return KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff
            end,
            set = function(_, value)
              KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff = value
            end
          }
        }
      },
      krowiStatus = {
        type = "description",
        order = 5,
        name = function()
          if KhamulsAchievementFilter:IsKrowiAFAvailable() then
            return L["Krowi AchievementFilter status: "] .. L["detected"]
          end
          return L["Krowi AchievementFilter status: "] .. L["not detected"]
        end,
        width = "full",
      },
    },
  }

  AceConfig:RegisterOptionsTable(ADDON_NAME, options)

  self.optionsFrame = AceConfigDialog:AddToBlizOptions(ADDON_NAME, L["Khamuls Collections for Krowi's Achievement Filter"])
end
