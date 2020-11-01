local addonName, shared = ...;

local addon = shared.addon;

shared.achievementData = {
  rares = {
    auto = {
      7439, -- Glorious!
      7932, -- I'm in Your Base, Killing Your Dudes
      -- 8101, -- It Was Worth Every Ritual Stone
      8103, -- Champions of Lei-Shen
      8712, -- Killing Time
      8714, -- Timeless Champion
      32640, -- Champions of the Thunder King
    },
    static = {
      -- warscouts and warbringers are not properly returned in the achievement
      -- "Zul'Again"
      [8078] = {
        {
          id = 69768,
          index = 1,
        }, {
          id = 69769,
          index = 2,
        }
      },
      -- there are two npcs named "Archiereus of Flame" and therefor the Achievement
      -- returns no proper id
      [8714] = {
        {
          id = 73174,
          index = 31,
        }, {
          id = 73666,
          index = 31,
        }
      },
      -- "It Was Worth Every Ritual Stone" for some reason returns weird assetIds
      [8101] = {
        {
          id = 69471,
          index = 1,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69633,
          index = 2,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69341,
          index = 3,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69339,
          index = 4,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69749,
          index = 5,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69767,
          index = 6,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 70080,
          index = 7,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69396,
          index = 8,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
        {
          id = 69347,
          index = 9,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
      }
    }
  },
  treasures = {
    static = {
      [7997] = { -- Riches of Pandaria
        31400,
        31396,
        31401,
        31404,
        31405,
        31408,
        31414,
        31415,
        31416,
        31418,
        31419,
        31420,
        31422,
        31423,
        31424,
        31426,
        31427,
        31428,
      }
    },
  },
}

-- "I'm in your base, killing your dudes" has faction specific NPCs
if (UnitFactionGroup('player') == 'Alliance') then
  shared.achievementData.rares.static[7932] = {
    {
      id = 68321,
      index = 1,
    },
    {
      id = 68320,
      index = 2,
    },
    {
      id = 68322,
      index = 3,
    },
  };
else
  shared.achievementData.rares.static[7932] = {
    {
      id = 68318,
      index = 1,
    },
    {
      id = 68317,
      index = 2,
    },
    {
      id = 68319,
      index = 3,
    },
  };
end
