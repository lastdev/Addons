local SkillIds = DFH_Constants.SkillIds
local MapIds = DFH_Constants.MapIds

DFH_Constants.ProfessionQuests.WeeklyDrops = {
  title = "Weekly Mob Drops",
  [SkillIds.Alchemy] = {
    {
      questId = 70511,
      item = 198964,
      waypoint = {
        map = MapIds.WakingShore,
        x = 52.2 / 100,
        y = 56.2 / 100,
        options = {
          title = "Encroaching Downpour (Elementious Splinter)" }
      },
    },
    {
      questId = 70504,
      item = 198963,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 17.78 / 100,
        y = 39.22 / 100,
        options = {
          title = "Brakenhide Rotflinger (Decaying Phlegm)" }
      }
    },
  },
  [SkillIds.Leatherworking] = {
    {
      questId = 70522,
      item = 198975,
      waypoint = {
        map = MapIds.WakingShore,
        x = 80 / 100,
        y = 24 / 100,
        options = {
          title = "Primal Proto-Drakes (Ossified Hide)" }
      },
    },
    {
      questId = 70523,
      item = 198976,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 15.72 / 100,
        y = 25.89 / 100,
        options = {
          title = "Vorquin (Exceedingly Soft Skin)" }
      }
    },
  },
  [SkillIds.Tailoring] = {
    {
      questId = 70524,
      item = 198977,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 84 / 100,
        y = 56 / 100,
        options = { title = "Farm Spot (Ohn'ahran Weave)" }
      }
    },
    {
      questId = 70525,
      item = 198978,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 33.84 / 100,
        y = 47.22 / 100,
        options = {
          title = "Gnolls (Stupidly Effective Stitchery)" }
      },
    },
  },
  [SkillIds.Jewelcrafting] = {
    {
      questId = 70521,
      item = 198974,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 45 / 100,
        y = 55.4 / 100,
        options = {
          title = "Rebel Bruisers (Elegantly Engraved Embellishment)" }
      },
    },
    {
      questId = 70520,
      item = 198973,
      waypoint = {
        map = MapIds.WakingShore,
        x = 52.3 / 100,
        y = 32.5 / 100,
        options = { title = "Crushing Elementals (Icandescent Curio)" }
      }
    },
  },
  [SkillIds.Blacksmithing] = {
    {
      questId = 70513,
      item = 198966,
      waypoint = {
        map = MapIds.WakingShore,
        x = 37.8 / 100,
        y = 73.0 / 100,
        options = { title = "Blazing Manifestation (Molten Globule)" }
      },
    },
    {
      questId = 70512,
      item = 198965,
      waypoint = {
        map = MapIds.WakingShore,
        x = 46.25 / 100,
        y = 37.26 / 100,
        options = {
          title = "Crushing Elemental (Primeval Earth Fragment)" }
      }
    },
  },
  [SkillIds.Engineering] = {
    {
      questId = 70516,
      item = 198969,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 57.0 / 100,
        y = 59.2 / 100,
        options = { title = "Titan Defense Matrix (Keeper's Mark)" }
      },
    },
    {
      questId = 70517,
      item = 198970,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 45.8 / 100,
        y = 58.2 / 100,
        options = {
          title = "Rebel Bruiser (Infinitely Attachable Pair o' Docks)" }
      }
    },
  },
  [SkillIds.Inscription] = {
    {
      questId = 70518,
      item = 198971,
      waypoint = {
        map = MapIds.WakingShore,
        x = 37.2 / 100,
        y = 63.4 / 100,
        options = {
          title = "Qalashi Necksnapper (Curious Djaradin Rune)" }
      },
    },
    {
      questId = 70519,
      item = 198972,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 66.4 / 100,
        y = 59.4 / 100,
        options = {
          title = "Arcane Manipulators (Draconic Glamour)" }
      }
    },
  },
  [SkillIds.Enchanting] = {
    {
      questId = 70514,
      item = 198967,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 39.2 / 100,
        y = 64.0 / 100,
        options = {
          title = "Mana Wyrmling, Stabilized Elementals (Primordial Aether)" }
      },
    },
    {
      questId = 70515,
      item = 198968,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 53.2 / 100,
        y = 65.6 / 100,
        options = { title = "Earthshaker Marauder (Primalist Charm)" }
      }
    },

  },
}
