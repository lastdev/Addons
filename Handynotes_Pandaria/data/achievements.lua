local _, addon = ...;

addon.achievementData = {
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
        }, {
          id = 69769,
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
        }, {
          id = 69633,
        }, {
          id = 69341,
        }, {
          id = 69339,
        }, {
          id = 69749,
        }, {
          id = 69767,
        }, {
          id = 70080,
        }, {
          id = 69396,
        }, {
          id = 69347,
          description = 'Needs 3x Shan\'ze Ritual Stone to summon',
        },
      },
    },
  },
  treasures = {
    auto = {
      8723, -- Legend of the Past
    },
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
      },
    },
  },
}

-- "I'm in your base, killing your dudes" has faction specific NPCs
if (_G.UnitFactionGroup('player') == 'Alliance') then
  addon.achievementData.rares.static[7932] = {
    {
      id = 68321,
    }, {
      id = 68320,
    }, {
      id = 68322,
    },
  };
else
  addon.achievementData.rares.static[7932] = {
    {
      id = 68318,
    }, {
      id = 68317,
    },  {
      id = 68319,
    },
  };
end

--[[ Timerunning check returns nil if it's called before PLAYER_LOGIN, so the
     check needs to be deferred. ]]
addon.onOnce('PLAYER_LOGIN', function ()
  if (addon.isPandariaTimerunning()) then
    local achievementData = addon.achievementData;
    local timeRunningRareAchievements = {
      8533, -- Ordos (Original), Adding this to Timerunning cause it can be achieved here
      19993, -- Elusive Foes: The Jade Forest
      19994, -- Elusive Foes: Valley of the Four Winds
      19995, -- Elusive Foes: Krasarang Wilds
      19996, -- Elusive Foes: Kun-Lai Summit
      19997, -- Elusive Foes: Townlong Steppes
      19998, -- Elusive Foes: Dread Wastes
      19999, -- Elusive Foes: Landfall
      20000, -- Elusive Foes: Isle of Thunder
      20001, -- Elusive Foes: Timeless Isle
      20069, -- Elusive Foes: Vale of Eternal Blossoms
      20002, -- Powerful Enemies: Timeless Isle
      20025, -- Ordos
    };

    local timeRunningTreasureAchievements = {
      19982, -- Hidden Treasures: Timeless Isle
    };

    for _, achievement in ipairs(timeRunningRareAchievements) do
      _G.tinsert(achievementData.rares.auto, achievement);
    end

    for _, achievement in ipairs(timeRunningTreasureAchievements) do
      _G.tinsert(achievementData.treasures.auto, achievement);
    end
  end
end);
