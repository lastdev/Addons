local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for TWW
addon.Achievements.TWW = {}
addon.Achievements.TWWMetaAchievementId = 41201

function InitializeTWW()

    local ACM_41555 = { -- All That Khaz
        GetAchievementName(41555),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40430,
            40702,
            20596,
            40762,
            41169,
            40307
        }
    }

    local ACM_40231 = { -- The War Within Pathfinder
        GetAchievementName(40231),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            20118,
            19560,
            20598,
            19559,
            40790
        }
    }

    local Glory_of_the_Delver_list = {
        40537,
        40506,
        40445,
        40453,
        40454,
        40538,
        42193
    }

    -- check if My New  Nemesis is already completed
    if IsAchievementCompleted(41530) then 
        table.insert(Glory_of_the_Delver_list, 41530)
    end

    -- check if My First Nemesis is already completed
    if IsAchievementCompleted(40103) then 
        table.insert(Glory_of_the_Delver_list, 40103)
    end

    local ACM_40438 = { -- Glory of the Delver
        GetAchievementName(40438),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        Glory_of_the_Delver_list
    }

    local ACM_41586 = { -- Going Goblin Mode
        GetAchievementName(41586),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41216,
            41217,
            40948,
            41588,
            41589,
            41708
        }
    }

    local ACM_60889 = { -- Unraveled and Persevering
        GetAchievementName(60889),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            42761,
            42741,
            42740,
            41979,
            42729,
            42742,
            60890
        }
    }

    local ACM_41186 = { -- Slate of the Union
        GetAchievementName(41186),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40435,
            40434,
            40606,
            40859,
            40860,
            40504
        }
    }

    local ACM_41187 = { -- Rage Aside the Machine
        GetAchievementName(41187),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40837,
            40724,
            40662,
            40585,
            40628,
            40473,
            40475
        }
    }

    local ACM_41188 = { -- Crystal Chronicled
        GetAchievementName(41188),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40851,
            40848,
            40625,
            40151,
            40622,
            40308,
            40311,
            40618,
            40313,
            40150
        }
    }

    local ACM_41189 = { -- Azj the World Turns
        GetAchievementName(41189),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            40840,
            40828,
            40634,
            40633,
            40869,
            40624,
            40542,
            40629
        }
    }

    local ACM_41133 = { -- Isle Remember You
        GetAchievementName(41133),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41045,
            41042,
            41043,
            41046,
            41131,
            41050
        }
    }

    local ACM_41201 = { -- You Xal Not Pass
        GetAchievementName(41201),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_41186, -- Slate of the Union
        ACM_41187, -- Rage Aside the Machine
        ACM_41188, -- Crystal Chronicled
        ACM_41189, -- Azj the World Turns
        ACM_41133, -- Isle Remember You
        {
            41186,
            41187,
            41188,
            41189,
            41133
        }
    }

    local ACMList = { -- Worldsoul-Searching
        "TWW - Worldsoul-Searching",
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_41555,
        ACM_41201,
        ACM_40231,
        ACM_40438,
        ACM_41586,
        ACM_60889,
        {
            40244,
            41222,
            41598,
            41555,
            41201,
            40231,
            40438,
            41586,
            41997,
            60889
        }

    }

    addon.Achievements.TWW = ACMList
end