local SkillIds = DFH_Constants.SkillIds
local MapIds = DFH_Constants.MapIds

DFH_Constants.ProfessionQuests.ProfessionMasters = {
  title = "Profession Master",
  [SkillIds.Alchemy] = {
    {
      questId = 70247,
      waypoint = { map = MapIds.WakingShore, x = 60.92 / 100, y = 75.84 / 100, options = { title = "Grigori Vialtry" } }
    },
  },
  [SkillIds.Blacksmithing] = {
    {
      questId = 70250,
      waypoint = { map = MapIds.WakingShore, x = 43.32 / 100, y = 66.60 / 100, options = { title = "Grekka Anvilsmash" } }
    },
  },
  [SkillIds.Enchanting] = {
    {
      questId = 70260,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 62.42 / 100,
        y = 18.70 / 100,
        options = { title = "Shalasar Glimmerdusk" }
      }
    },
  },
  [SkillIds.Engineering] = {
    {
      questId = 70252,
      waypoint = { map = MapIds.AzureSpan, x = 17.8 / 100, y = 21.7 / 100, options = { title = "Frizz Buzzcrank" } }
    },
  },
  [SkillIds.Herbalism] = {
    {
      questId = 70253,
      waypoint = { map = MapIds.OhnAhranPlains, x = 58.42 / 100, y = 50.04 / 100, options = { title = "Hua Greenpaw" } }
    },
  },
  [SkillIds.Inscription] = {
    {
      questId = 70254,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 40.24 / 100,
        y = 64.3 / 100,
        options = { title = "Lydiara Whisperfeather" }
      }
    },
  },
  [SkillIds.Jewelcrafting] = {
    {
      questId = 70255,
      waypoint = { map = MapIds.AzureSpan, x = 46.23 / 100, y = 40.84 / 100, options = { title = "Pluutar" } }
    },
  },
  [SkillIds.Leatherworking] = {
    {
      questId = 70256,
      waypoint = { map = MapIds.OhnAhranPlains, x = 82.45 / 100, y = 50.67 / 100, options = { title = "Erden" } }
    },
  },
  [SkillIds.Mining] = {
    {
      questId = 70258,
      waypoint = { map = MapIds.Thaldraszus, x = 61.42 / 100, y = 76.95 / 100, options = { title = "Bridgette Holdug" } }
    },
  },
  [SkillIds.Skinning] = {
    {
      questId = 70259,
      waypoint = { map = MapIds.WakingShore, x = 73.34 / 100, y = 69.72 / 100, options = { title = "Zenzi" } }
    },
  },
  [SkillIds.Tailoring] = {
    {
      questId = 70260,
      waypoint = { map = MapIds.Valdrakken, x = 27.96 / 100, y = 45.79 / 100, options = { title = "Elysa Raywinder" } }
    },
  },
}
