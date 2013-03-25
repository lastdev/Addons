Reforgenator = LibStub("AceAddon-3.0"):NewAddon("Reforgenator", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Reforgenator", false)
local RI = LibStub("LibReforgingInfo-1.0")
local version = "2.4"

-- There isn't really a "spirit" combat rating, but it will simplify
-- some things if we pretend there is one
local CR_SPIRIT = 99

-- and likewise there isn't an EP combat rating
local CR_EP = 100
convert = nil

local function table_print(tt, indent, done)
    done = done or {}
    indent = indent or 0
    if type(tt) == "table" then
        local sb = {}
        for key,value in pairs(tt) do
            table.insert(sb, string.rep(" ", indent)) -- indent it
            if type(value) == "table" and not done[value] then
                done[value] = true
                table.insert(sb, "{");
                table.insert(sb, table_print(value, indent + 2, done))
                table.insert(sb, string.rep(" ", indent)) -- indent it
                table.insert(sb, "},\n");
            elseif "number" == type(key) then
                table.insert(sb, string.format("\"%s\",\n", tostring(value)))
            else
                table.insert(sb, string.format("%s=\"%s\",\n", tostring(key), tostring(value)))
            end
        end
        return table.concat(sb)
    else
        return tt
    end
end

local function to_string(tbl)
    if "nil" == type(tbl) then
        return tostring(nil)
    elseif "table" == type(tbl) then
        return table_print(tbl)
    elseif "string" == type(tbl) then
        return tbl
    else
        return tostring(tbl)
    end
end

local function stringSplit(str, pat)
    local aRecord = {}

    if str:len() > 0 then
        local nField = 1 nStart = 1
        local nFirst, nLast = str:find(pat, nStart, false)
        while nFirst do
            aRecord[nField] = str:sub(nStart, nFirst - 1)
            nField = nField + 1
            nStart = nLast + 1
            nFirst, nLast = str:find(pat, nStart, false)
        end
        aRecord[nField] = str:sub(nStart)
    end

    return aRecord
end

local function Set(list)
    local set = {}
    for _,l in ipairs(list) do set[tostring(l)] = true end
    return set
end

function Invert(list)
    local invertedList = {}
    for k,v in ipairs(list) do
        invertedList[v] = k
    end
    return invertedList
end

ReforgeModel = {}

function ReforgeModel:new()
    local result = 
	{
        ak = '',
        class = '',
        statWeights = {},
        reforgeOrder = {}
    }
    setmetatable(result, self)
    self.__index = self

    return result
end

function Reforgenator:OnEnable()
    self:Print("v" .. version .. " loaded")
end

local options = 
{
    type = 'group',
    name = "Reforgenator",
    handler = Reforgenator,
    desc = "Calculate what to reforge",
    args = 
	{
        useMinimap = 
		{
            name = "Use minimap button",
            desc = "Show a button on the minimap",
            type = "toggle",
            set = function(info, val)
                Reforgenator:Debug("### useMinimap")
                Reforgenator:Debug("### val=" .. to_string(val))
                if val then
                    Reforgenator.db.profile.minimap.hide = false
                    Reforgenator.minimapIcon:Show("Reforgenator")
                else
                    Reforgenator.db.profile.minimap.hide = true
                    Reforgenator.minimapIcon:Hide("Reforgenator")
                end
            end,
            get = function(info)
                return not Reforgenator.db.profile.minimap.hide
            end,
        },
        verbose = 
		{
            name = "Verbose reforging",
            desc = "Emit detail information during reforging to chat window",
            type = "toggle",
            set = function(info, val)
                Reforgenator.db.profile.verbose.emit = val
            end,
            get = function(info)
                return Reforgenator.db.profile.verbose.emit
            end,
        },
		Money = 
		{
            name = "Reforging Cost",
            desc = "Provide details on the cost of Reforging",
            type = "toggle",
            set = function(info, val)
                Reforgenator.db.profile.verbose.money = val
            end,
            get = function(info)
				return Reforgenator.db.profile.verbose.money
            end,
        },
    },
}

local nextAvailableSequence = 1
local modelOptions = 
{
    type = 'group',
    args = {},
}

local builtInModelOptions = 
{
    type = 'group',
    args = {},
}

local createName = ''
local className = ''
local sourceName = ''
local addOptions = 
{
    type = 'group',
    name = 'Add new model',
    handler = Reforgenator,
    desc = 'Add new model',
    args = {}
}

local defaults = 
{
    profile = 
	{
        minimap = 
		{
            hide = false,
        },
        verbose = 
		{
            emit = false,
        },
		Money =
		{
			hide = false,
		},
    },
    global = 
	{
        nextModelID = 1,
    }
}

local help_options = 
{
    type = 'group',
    name = 'Help',
    args = 
	{
        header = 
		{
            type = 'header',
            name = 'Help',
        },
        help = 
		{
            type = 'description',
            name = [=[|cffffd200What do all the caps mean?
|r
|cffffd200MeleeHitCap|r: the melee hit cap, normally 7.5% but is affected by various modifiers.
|cffffd200SpellHitCap|r: the spell hit cap, normally 15% but is affected by various modifiers.
|cffffd200DWHitCap|r: the dual-wield hit cap, normally 26.5% but is affected by various modifiers.
|cffffd200RangedHitCap|r: the ranged hit cap, normally 7.5% but is affected by various modifiers.
|cffffd200ExpertiseSoftCap|r: the expertise soft cap where dodge is pushed off the attack table. Normally 26 but is affected by various modifiers.
|cffffd200ExpertiseHardCap|r: the expertise hard cap where parry is pushed off the attack table. Currently 7.5 for 5.0.4
|cffffd200MaximumPossible|r: reforge to get as much of this stat as is possible.
|cffffd2001SecGCD|r: the value of haste rating necessary to reduce the GCD to one second.
|cffffd200Fixed|r: Reforge up to or down to the value. You can enter a set of numbers separated by commas. If there are several numbers that means you want to reforge to just hit one of them. It will reforge to reach and just exceed the largest number in the field that it can.
|cffffd200Maintain|r: don't reforge this stat up or down, but don't reforge it away to satisfy later rules.

|cffffd200
Give me an example of the 'fixed' rule
|r
Okay. Haste affects DOTs now by shortening the space between ticks. When the ticks are close enough that 50% of another tick fits in the spell duration, the game adds another whole tick. This means there are plateaus for haste where a tiny bit more haste adds a whole tick, so that's where you want to get your haste up to.

According to Elitist Jerks, a destruction warlock in a raid environment will get a whole tick of 'Immolate' added when his haste is at 157, 781, 1406, and 2030. So ideally you'd get your haste to at least one of those numbers, but haste past one of those numbers that doesn't get to the next one is "wasted" and could be spent somewhere else.

This is what the "fixed" cap is intended to do. If you provide one number, like "781", then it reforges the stat up or down to get as close to that number as it can. If you provide a list of numbers, like "157, 781, 1406, 2030" then it reforges to get the stat as close to one of the numbers on the list, and will choose the largest number it can get to, and will always be at or above the number.

|cffffd200
What's the difference between 'fixed' and 'maintain'?
|r
"Maintain" means to leave this stat alone. "Fixed" means to reforge the stat up or down to get to some value.

|cffffd200
How does the order of rules matter?
|r
The addon applies the rules in order. Whichever stat appears in the first rule is most important, and it will reforge other stats to get it if needed. Then it goes to the next rule. So if you want to keep whatever you currently have of a stat, choose 'maintain'. If you want a specific value of the stat, then choose 'fixed'.

So "Hit rating: SpellHitCap, Crit rating: maintain" will be willing to reforge crit to get up to the hit cap, but "Crit rating: maintain, Hit rating: spellHitCap" wouldn't change your crit even if you're under the hit cap.

|cffffd200
What if I need more rules?
|r
At the moment, you can't have more than six rules. If you really need more rules, open a ticket on the CurseForge page.

|cffffd200
What if I need a different kind of rule, like reforging dodge and parry to the same rating?
|r
If you need another rule and have a link to a theorycrafting post, open a ticket on the CurseForge page with the link.
]=],
        }
    }
}

local profileOptions = 
{
    name = "Profiles",
    type = "group",
    childGroups = "tab",
    args = {},
}

function Reforgenator:ModelEditorPanel_OnLoad(panel)
    self:Debug("### ModelEditorPanel_OnLoad")
end

function Reforgenator:OnInitialize()
    self:Debug("### OnInitialize")

    Reforgenator.db = LibStub("AceDB-3.0"):New("ReforgenatorDB", defaults, "Default")

    Reforgenator:InitializeConstants()
    Reforgenator:LoadDefaultModels()
    Reforgenator:InitializeModelOptions()
    Reforgenator:InitializeAddOptions()

    local AC = LibStub('AceConfig-3.0')
    local ACD = LibStub('AceConfigDialog-3.0')

    AC:RegisterOptionsTable("Reforgenator", options)
    Reforgenator.optionsFrame = ACD:AddToBlizOptions("Reforgenator", "Reforgenator")

    AC:RegisterOptionsTable('Reforgenator help', help_options)
    ACD:AddToBlizOptions('Reforgenator help', 'Help', 'Reforgenator')

    AC:RegisterOptionsTable('Reforgenator Add', addOptions)
    ACD:AddToBlizOptions('Reforgenator Add', 'New model', 'Reforgenator')

    AC:RegisterOptionsTable("Reforgenator Models", modelOptions)
    ACD:AddToBlizOptions("Reforgenator Models", "Models", "Reforgenator")

    AC:RegisterOptionsTable('Reforgenator built-in models', builtInModelOptions)
    ACD:AddToBlizOptions('Reforgenator built-in models', 'Built-in models', 'Reforgenator')

    local broker = LibStub:GetLibrary("LibDataBroker-1.1", true)
    local ldbButton = broker:NewDataObject("Reforgenator", --This goes From here************
	{
        type = "launcher",
        icon = "Interface\\Icons\\INV_Misc_EngGizmos_06",
        text = "Reforgenator",
        OnClick = function(frame, button)
            if button == "RightButton" then
                InterfaceOptionsFrame_OpenToCategory(Reforgenator.optionsFrame)
            else
                Reforgenator:ShowState()
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("Reforgenator |cff00ff00(v" .. version .. ")|r");
            tooltip:AddLine("|cffffff00" .. "left-click to figure out what to reforge")
            tooltip:AddLine("|cffffff00" .. "right-click to configure")
        end
    })														-- To here********************
	
    Reforgenator.minimapIcon = LibStub("LibDBIcon-1.0")
    Reforgenator.minimapIcon:Register("Reforgenator", ldbButton, Reforgenator.db.profile.minimap)

    self:Debug("### minimap.hide=" .. (to_string(Reforgenator.db.profile.minimap.hide or "nil")))
    if Reforgenator.db.profile.minimap.hide then
        Reforgenator.minimapIcon:Hide("Reforgenator")
    else
        Reforgenator.minimapIcon:Show("Reforgenator")
    end

    self:RegisterChatCommand("reforgenator", "ShowState")

    tinsert(UISpecialFrames, "ReforgenatorPanel")
end

function Reforgenator:InitializeConstants()
    Reforgenator.constants = {}
    local c = Reforgenator.constants

    c.INVENTORY_SLOTS = 
	{
        "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot",
        "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot",
        "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot",
        "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot",
        
    }

    c.ORDERED_ITEM_STATS = 
	{
        [1] = "ITEM_MOD_CRIT_RATING_SHORT",
        [2] = "ITEM_MOD_DODGE_RATING_SHORT",
        [3] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
        [4] = "ITEM_MOD_HASTE_RATING_SHORT",
        [5] = "ITEM_MOD_HIT_RATING_SHORT",
        [6] = "ITEM_MOD_MASTERY_RATING_SHORT",
        [7] = "ITEM_MOD_PARRY_RATING_SHORT",
        [8] = "ITEM_MOD_SPIRIT_SHORT",
    }

    c.ITEM_STATS = Set(c.ORDERED_ITEM_STATS)

    c.STAT_CAPS = 
	{
        ["MeleeHitCap"] = function(m) return Reforgenator:CalculateMeleeHitCap(m) end,
        ["SpellHitCap"] = function(m) return Reforgenator:CalculateSpellHitCap(m) end,
        ["DWHitCap"] = function(m) return Reforgenator:CalculateDWMeleeHitCap(m) end,
        ["RangedHitCap"] = function(m) return Reforgenator:CalculateRangedHitCap(m) end,
        ["ExpertiseSoftCap"] = function(m) return Reforgenator:CalculateExpertiseSoftCap(m) end,
        ["ExpertiseHardCap"] = function(m) return Reforgenator:CalculateExpertiseHardCap(m) end,
        ["MaximumPossible"] = function(m) return Reforgenator:CalculateMaximumValue(m) end,
        ["1SecGCD"] = function(m) return Reforgenator:HasteTo1SecGCD(m) end,
        ["Fixed"] = function(m, a) return a end,
        ["Maintain"] = function(m) return nil end,
        ["23.34% Crit"] = function(m) return Reforgenator:CalculateFrostSoftCritCap(m) end,
        ["15% Haste"] = function(m) return Reforgenator:CalculateFireSoftHasteCap(m) end,
        ["12.5% Haste"] = function(m) return Reforgenator:CalculateHolySoftHasteCap(m) end,
    }

    c.RATING_NAMES = 
	{
        [CR_CRIT_MELEE] = "Melee Crit Rating",
        [CR_CRIT_RANGED] = "Ranged Crit Rating",
        [CR_CRIT_SPELL] = "Spell Crit Rating",
        [CR_DODGE] = "Dodge Rating",
        [CR_EXPERTISE] = "Expertise Rating",
        [CR_HASTE_MELEE] = "Melee Haste Rating",
        [CR_HASTE_RANGED] = "Ranged Haste Rating",
        [CR_HASTE_SPELL] = "Spell Haste Rating",
        [CR_HIT_MELEE] = "Melee Hit Rating",
        [CR_HIT_RANGED] = "Ranged Hit Rating",
        [CR_HIT_SPELL] = "Spell Hit Rating",
        [CR_MASTERY] = "Mastery Rating",
        [CR_PARRY] = "Parry Rating",
        [CR_SPIRIT] = "Spirit",
        -- [CR_EP] = "Equivalency Points",
    }

    --
    -- These are up to date as of 10/12 for MoP
	-- [0] = Vanilla [1] = BC [2] = Wrath [3] = Cata  [4] MOP
	-- Returns value based on Game version from GetExpansionLevel()
    local HIT_RATING_CONVERSIONS = 
	{
        [0] = 9.37931,
        [1] = 14.7905,
        [2] = 30.7548,
        [3] = 120.109,
		[4] = 340,						
    }
    local SPELL_HIT_RATING_CONVERSIONS = 
	{
        [0] = 8,
        [1] = 12.6154,
        [2] = 26.232,
        [3] = 102.446,
		[4] = 340,						
    }
    local EXP_RATING_CONVERSIONS = 
	{
        [0] = 2.34483,
        [1] = 3.69761,
        [2] = 7.68869,
        [3] = 30.0272,
		[4] = 340,						
    }
    local HASTE_RATING_CONVERSIONS = 
	{
        [0] = 10,
        [1] = 15.7692,
        [2] = 32.79,
        [3] = 128.05701,
		[4] = 425,						
    }
    local MASTERY_RATING_CONVERSIONS = 
	{
        [0] = 14,
        [1] = 22.0769,
        [2] = 45.906,
        [3] = 179.28,
		[4] = 600,						
    }

    local CRIT_RATING_CONVERSIONS = 
	{
        [0] = 14,
        [1] = 22.0769,
        [2] = 45.906,
        [3] = 179.28,
		[4] = 700,						
    }

    local PARRY_RATING_CONVERSIONS = 
	{
        [0] = 13.8,
        [1] = 21.76154,
        [2] = 45.25019,
        [3] = 176.7189,
		[4] = 1035,						
    }

    local DODGE_RATING_CONVERSIONS = 
	{
        [0] = 13.8,
        [1] = 21.76154,
        [2] = 45.25019,
        [3] = 176.7189,
		[4] = 1035,						
    }

    local gameVersion = GetExpansionLevel()
    c.RATING_CONVERSIONS = 
	{
        meleeHit = HIT_RATING_CONVERSIONS[gameVersion],
        spellHit = SPELL_HIT_RATING_CONVERSIONS[gameVersion],
        expertise = EXP_RATING_CONVERSIONS[gameVersion],
        haste = HASTE_RATING_CONVERSIONS[gameVersion],
        mastery = MASTERY_RATING_CONVERSIONS[gameVersion],
        crit = CRIT_RATING_CONVERSIONS[gameVersion],

        ["ITEM_MOD_PARRY_RATING_SHORT"] = PARRY_RATING_CONVERSIONS[gameVersion],
        ["ITEM_MOD_DODGE_RATING_SHORT"] = DODGE_RATING_CONVERSIONS[gameVersion],
    }

    c.REFORGING_TARGET_LEVELS = 
	{
        [1] = "Reforge for heroics",
        [2] = "Reforge for raiding",
        [3] = "Reforge for PvP",
    }

    c.MELEE_HIT_CAP_BY_TARGET_LEVEL = 
	{
        [1] = 6,
        [2] = 7.5,												
        [3] = 3,
    }

    c.DW_HIT_CAP_BY_TARGET_LEVEL = 
	{
        [1] = 25,
        [2] = 26.5,
        [3] = 22,
    }

    c.EXP_SOFT_CAP_BY_TARGET_LEVEL = 
	{
        [1] = 6,
        [2] = 7.5,
        [3] = 3,
    }

    c.EXP_HARD_CAP_BY_TARGET_LEVEL = 
	{
        [1] = 6,
        [2] = 15,
        [3] = 3,
    }

    c.SPELL_HIT_CAP_BY_TARGET_LEVEL = 
	{
        [1] = 12,
        [2] = 15,												
        [3] = 6,
    }

    c.AVOIDANCE_K = 
	{
        ["WARRIOR"] = 0.9560,
        ["PALADIN"] = 0.9560,
        ["DEATHKNIGHT"] = 0.9560,
        ["DRUID"] = 0.9720,
    }

    c.AVOIDANCE_C = 
	{
        ["ITEM_MOD_PARRY_RATING_SHORT"] = 
		{
            ["WARRIOR"] = 0.01523660,
            ["PALADIN"] = 0.01523660,
            ["DEATHKNIGHT"] = 0.01523660,
        },

        ["ITEM_MOD_DODGE_RATING_SHORT"] = 
		{
            ["WARRIOR"] = 0.01523660,
            ["PALADIN"] = 0.01523660,
            ["DEATHKNIGHT"] = 0.01523660,
            ["DRUID"] = 0.008555,
        },
    }

end

function Reforgenator:MigrateOldModels()
    local models = Reforgenator.db.global.models

    -- build a plausible statWeights for models without them (user-defined)
    for k,v in pairs(models) do
        if not v.statWeights then
            v.statWeights = {}
            for ik,iv in pairs(v.statRank) do
                v.statWeights[ik] = 100 - (iv * 10)
            end
        end

        v.statRank = nil
    end

    -- Change old "ITEM_MOD_HIT_RATING_SHORT" models into shiny new CR_HIT_MELEE models
    for k,v in pairs(models) do
        -- guess model type
        local modelType = 1
        if v.useSpellHit then
            modelType = 3
            v.useSpellHit = nil
        end

        local map = 
		{
            ["ITEM_MOD_HIT_RATING_SHORT"] = CR_HIT_MELEE,
            ["ITEM_MOD_CRIT_RATING_SHORT"] = CR_CRIT_MELEE,
            ["ITEM_MOD_HASTE_RATING_SHORT"] = CR_HASTE_MELEE,
            ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = CR_EXPERTISE,
            ["ITEM_MOD_DODGE_RATING_SHORT"] = CR_DODGE,
            ["ITEM_MOD_PARRY_RATING_SHORT"] = CR_PARRY,
            ["ITEM_MOD_MASTERY_RATING_SHORT"] = CR_MASTERY,
            ["ITEM_MOD_SPIRIT_SHORT"] = CR_HIT_SPELL,
        }

        for _, iv in ipairs(v.reforgeOrder) do
            if iv.rating == "ITEM_MOD_HIT_RATING_SHORT" then
                if iv.cap == "MeleeHitCap" then
                    iv.rating = CR_HIT_MELEE
                    modelType = 1
                elseif iv.cap == "RangedHitCap" then
                    iv.rating = CR_HIT_RANGED
                    modelType = 2
                elseif iv.cap == "SpellHitCap" then
                    iv.rating = CR_HIT_SPELL
                    modelType = 3
                end
            end
        end

        if modelType == 2 then
            map["ITEM_MOD_HIT_RATING_SHORT"] = CR_HIT_RANGED
            map["ITEM_MOD_CRIT_RATING_SHORT"] = CR_CRIT_RANGED
            map["ITEM_MOD_HASTE_RATING_SHORT"] = CR_HASTE_RANGED
        elseif modelType == 3 then
            map["ITEM_MOD_HIT_RATING_SHORT"] = CR_HIT_SPELL
            map["ITEM_MOD_CRIT_RATING_SHORT"] = CR_CRIT_SPELL
            map["ITEM_MOD_HASTE_RATING_SHORT"] = CR_HASTE_SPELL
        end

        for _, iv in ipairs(v.reforgeOrder) do
            if map[iv.rating] then
                iv.rating = map[iv.rating]
            end
        end
    end
end

function Reforgenator:InitializeModelOptions()
    local db = Reforgenator.db
    local models = db.global.models
    local key = nil
    local n = 1

    if not db.char.useSandbox or type(db.char.useSandbox) ~= "table" then
        db.char.useSandbox = {}
    end

    if not db.char.targetLevelSelection or type(db.char.targetLevelSelection) ~= "table" then
        db.char.targetLevelSelection = {}
    end

    self:MigrateOldModels()

    -- User-defined models
    for k,v in pairs(models) do
        if not v.readOnly then
            key = string.format('model_%03d', nextAvailableSequence)
            nextAvailableSequence = nextAvailableSequence + 1

            modelOptions.args[key] = self:ModelToModelOption(k, v)
        end
    end

    -- Built-in models
    n = 1
    for k,v in pairs(models) do
        if v.readOnly then
            key = string.format('model_%03d', n)
            n = n + 1

            builtInModelOptions.args[key] = self:ModelToModelOption(k, v)
        end
    end
end

function Reforgenator:ModelToModelOption(modelName, model)
    local c = Reforgenator.constants

    local option = 
	{
        type = 'group',
        name = modelName,
        handler = Reforgenator,
        args = {},
    }

    local seq = 1

    option.args['class'] = 
	{
        type = 'select',
        name = 'Class',
        desc = 'Class this model applies to',
        order = seq,
        values = 
		{
            ["WARRIOR"] = 'Warrior',
            ["DEATHKNIGHT"] = 'Death knight',
            ["PALADIN"] = 'Paladin',
            ["PRIEST"] = 'Priest',
            ["SHAMAN"] = 'Shaman',
            ["DRUID"] = 'Druid',
            ["ROGUE"] = 'Rogue',
            ["MAGE"] = 'Mage',
            ["WARLOCK"] = 'Warlock',
            ["HUNTER"] = 'Hunter',
			["MONK"] = 'Monk',
        },
        get = function() return model.class end,
        set = function(info, key)
            if model.readOnly then
                return
            end

            model.class = key
            model.PerCharacterOptions = {}
        end,
    }
    seq = seq + 1

    option.args["weightHeader"] = {
        type = 'header',
        name = 'Stat Weights',
        order = seq,
    }
    seq = seq + 1

    for _,v in ipairs(c.ORDERED_ITEM_STATS) do
        option.args['weight' .. v] = {
            type = 'input',
            name = to_string(_G[v]),
            desc = 'The weight or value per point of ' .. _G[v],
            order = seq,
            get = function()
                if not model.statWeights[v] then
                    return nil
                end

                return to_string(model.statWeights[v])
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                if not model.statWeights then
                    model.statWeights = {}
                end

                model.statWeights[v] = tonumber(key or '0')
            end,
        }
        seq = seq + 1
    end

    option.args['pawnImportHeader'] = {
	type = 'header',
	name = 'Import Pawn scale',
	order = seq,
    }
    seq = seq + 1

    option.args['pawnImport'] = {
	type = 'input',
	name = 'Pawn import',
	desc = 'Paste a Pawn string here to set weights',
	order = seq,
	get = function() return '' end,
	set = function(info, key)
	    if model.readOnly then
		return
	    end

	    self:Debug("### new pawnImport=" .. to_string(key))

	    local function PawnParseScaleTag(ScaleTag)
		local Pos, _, Version, Name, ValuesString = strfind(ScaleTag, "^%s*%(%s*Pawn%s*:%s*v(%d+)%s*:%s*\"([^\"]+)\"%s*:%s*(.+)%s*%)%s*$")
		Version = tonumber(Version)
		if (not Pos) or (not Version) or (not Name) or (Name == "") or (not ValuesString) or (ValuesString == "") then return end
		if Version > 1 then return end
	
		local Values = {}
		local function SplitStatValuePair(Pair)
		    local Pos, _, Stat, Value = strfind(Pair, "^%s*([%a%d]+)%s*=%s*(%-?[%d%.]+)%s*,$")
		    Value = tonumber(Value)
		    if Pos and Stat and (Stat ~= "") and Value then 
			Values[Stat] = Value
		    end
		end
		gsub(ValuesString .. ",", "[^,]*,", SplitStatValuePair)
	
		return Name, Values
	    end

	    local name, values = PawnParseScaleTag(key)
	    self:Debug("### pawn.name=" .. to_string(name) .. ", values=" .. to_string(values))
	    if not name then
		return
	    end

	    local pawnMap = 
		{
		["CritRating"] = "ITEM_MOD_CRIT_RATING_SHORT",
		["DodgeRating"] = "ITEM_MOD_DODGE_RATING_SHORT",
		["ExpertiseRating"] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
		["HitRating"] = "ITEM_MOD_HIT_RATING_SHORT",
		["HasteRating"] = "ITEM_MOD_HASTE_RATING_SHORT",
		["MasteryRating"] = "ITEM_MOD_MASTERY_RATING_SHORT",
		["ParryRating"] = "ITEM_MOD_PARRY_RATING_SHORT",
		["Spirit"] = "ITEM_MOD_SPIRIT_SHORT",
	    }
	    for k,v in pairs(values) do
		self:Debug("### k="..to_string(k)..", v="..to_string(v))
		local stat = pawnMap[k]
		self:Debug("### stat="..to_string(stat))
		if stat then
		    local f = option.args['weight' .. stat]
		    self:Debug("### f=" .. to_string(f))
		    if f then
			f.set(nil, v)
		    end
		end
	    end
	end,
    }

    for i=1,6 do
        option.args["h" .. i] = 
		{
            type = 'header',
            name = 'Rule #' .. i,
            order = seq,
        }
        seq = seq + 1

        option.args['rating' .. i] = 
		{
            type = 'select',
            name = 'Rating',
            desc = 'Reforge to get this rating to the specified cap',
            order = seq,
            values = {},
            get = function()
                return model.reforgeOrder[i] and model.reforgeOrder[i].rating or nil
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                if not model.reforgeOrder[i] then
                    model.reforgeOrder[i] = {}
                end

                if key == 0 then
                    model.reforgeOrder[i] = {}
                else 
                    model.reforgeOrder[i].rating = key
					if convert == 1 then
						option.args['preferSpirit' .. i].hidden = key ~= CR_HIT_SPELL
						option.args['preferExpertise' .. i].hidden = key ~= CR_HIT_SPELL
					end
                end
            end,
        }
        seq = seq + 1

        local arr = option.args['rating' .. i].values
        arr[0] = ""
        for k2,v2 in pairs(c.RATING_NAMES) do
            arr[k2] = v2
        end

        option.args['cap' .. i] = 
		{
            type = 'select',
            name = 'Cap',
            desc = "Desired value for the stat we're currently reforging",
            order = seq,
            get = function()
                return model.reforgeOrder[i] and model.reforgeOrder[i].cap or nil
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                if not model.reforgeOrder[i] then
                    model.reforgeOrder[i] = {}
                end

                model.reforgeOrder[i].cap = key
                option.args['userdata' .. i].hidden = key ~= "Fixed";
            end,
            values = {}
        }
        seq = seq + 1

        arr = option.args['cap' .. i].values
        arr[""] = ""
        for k2,v2 in pairs(c.STAT_CAPS) do
            arr[k2] = k2
        end

        option.args['userdata' .. i] = 
		{
            type = 'input',
            name = 'Values',
            desc = 'Value, or list of values, to reforge to',
            order = seq,
            hidden = not (model.reforgeOrder[i] and model.reforgeOrder[i].cap == "Fixed"),
            get = function()
                if not model.reforgeOrder[i] then
                    return nil
                end

                self:Debug("### userdata=" .. to_string(model.reforgeOrder[i].userdata))
                if type(model.reforgeOrder[i].userdata) == "table" then
                    return table.concat(model.reforgeOrder[i].userdata, ', ')
                elseif model.reforgeOrder[i].userdata then
                    return to_string(model.reforgeOrder[i].userdata)
                else
                    return nil
                end
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                self:Debug("### new userdata=" .. to_string(key))

                if not key then
                    model.reforgeOrder[i].userdata = nil
                else
                    t = stringSplit(strtrim(key), ',%s*')
                    self:Debug("### parsed new userdata=" .. to_string(t))
                    if #t == 1 then
                        model.reforgeOrder[i].userdata = math.floor(tonumber(t[1]))
                    else
                        local result = {}
                        for k,v in ipairs(t) do result[#result + 1] = math.floor(tonumber(v)) end
                        model.reforgeOrder[i].userdata = result
                    end
                end
            end,
        }
        seq = seq + 1

        option.args['hard' .. i] = 
		{
            type = 'toggle',
            name = 'Force greater than?',
            desc = 'Check this to force the addon to go over the cap rather than closest to the cap',
            order = seq,
            get = function()
                if not model.reforgeOrder[i] then
                    return nil
                end

                return model.reforgeOrder[i].mustBeOver
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                model.reforgeOrder[i].mustBeOver = key
            end,
        }
        seq = seq + 1

        option.args['preferSpirit' .. i] = 
		{
            type = 'toggle',
            name = 'Prefer spirit?',
            desc = 'Check this to specify you prefer spirit for spell hit if possible',
            order = seq,
            hidden = not (model.reforgeOrder[i] and model.reforgeOrder[i].rating == CR_HIT_SPELL),
            get = function()
                if not model.reforgeOrder[i] then
                    return nil
                end

                return model.reforgeOrder[i].preferSpirit
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                model.reforgeOrder[i].preferSpirit = key
            end,
        }
        seq = seq + 1
		
		option.args['preferExpertise' .. i] = 
		{
            type = 'toggle',
            name = 'Prefer Expertise?',
            desc = 'Check this to specify you prefer Expertise for spell hit if possible',
            order = seq,
            hidden = not (model.reforgeOrder[i] and model.reforgeOrder[i].rating == CR_HIT_SPELL),
            get = function()
                if not model.reforgeOrder[i] then
                    return nil
                end

                return model.reforgeOrder[i].preferExpertise
            end,
            set = function(info, key)
                if model.readOnly then
                    return
                end

                model.reforgeOrder[i].preferExpertise = key
            end,
        }
        seq = seq + 1
    end

    option.args.notesHeader = 
	{
        type = 'header',
        name = 'Notes',
        order = seq,
    }
    seq = seq + 1

    option.args.notes = 
	{
        type = 'input',
        multiline = true,
        name = 'Notes',
        desc = 'Any notes to be displayed in a tooltip on the reforge window',
        order = seq,
        get = function()
            return model.notes
        end,
        set = function(info, key)
            if model.readOnly then
                return
            end

            model.notes = key
        end,
    }
    seq = seq + 1

    if not model.readOnly then
        option.args.maintHeader = 
		{
            type = 'header',
            name = 'Maintenance',
            order = seq,
        }
        seq = seq + 1

        option.args.deleteButton = 
		{
            type = 'execute',
            name = 'Delete',
            desc = 'Delete this model',
            order = seq,
            func = function()
                Reforgenator.db.global.models[modelName] = nil
                for k,v in pairs(modelOptions.args) do
                    if v.type == 'group' and v.name == modelName then
                        modelOptions.args[k] = nil
                        break
                    end
                end
            end,
        }
        seq = seq + 1
    end

    return option
end

function Reforgenator:InitializeAddOptions()
    local name, nameEN = UnitClass("player")
    className = nameEN

    addOptions.args = 
	{
        name = 
		{
            order = 1,
            type = 'input',
            name = 'Model name',
            desc = 'Name of the new model',
            get = function() return createName end,
            set = function(info, val) createName = strtrim(val) end,
            validate = function(info, val)
                local nm = strtrim(val)
                if nm == '' then
                    Reforgenator:MessageBox('Please enter a name')
                    return 'No name given'
                end
                if Reforgenator.db.global.models[nm] then
                    Reforgenator:MessageBox('There is already a model with that name')
                    return 'There is already a model with that name'
                end
                return true
            end
        },
        emptyGroup = 
		{
            order = 2,
            type = 'group',
            name = 'Empty model',
            desc = 'Create a new empty model',
            args = 
			{
                class = 
				{
                    order = 1,
                    type = 'select',
                    name = 'Class',
                    desc = 'Class the model applies to',
                    values = 
					{
                        ["WARRIOR"] = 'Warrior',
                        ["DEATHKNIGHT"] = 'Death knight',
                        ["PALADIN"] = 'Paladin',
                        ["PRIEST"] = 'Priest',
                        ["SHAMAN"] = 'Shaman',
                        ["DRUID"] = 'Druid',
                        ["ROGUE"] = 'Rogue',
                        ["MAGE"] = 'Mage',
                        ["WARLOCK"] = 'Warlock',
                        ["HUNTER"] = 'Hunter',
						["MONK"] = 'Monk',
                    },
                    get = function() return className end,
                    set = function(info, key) className = key end,
                },
                doEet = 
				{
                    order = 2,
                    type = 'execute',
                    name = 'Create model',
                    desc = 'Create the new empty model',
                    func = function()
                        if createName == '' or strtrim(createName) == '' then
                            Reforgenator:MessageBox('Please enter a name for the new model')
                            return
                        end

                        Reforgenator:Debug("### new empty model named [" .. createName .. "] for class [" .. className .. "]")
                        local model = ReforgeModel:new()
                        model.class = className
                        Reforgenator:LoadModel(model, createName)
                        local opt = Reforgenator:ModelToModelOption(createName, model)
                        local key = string.format('model_%03d', nextAvailableSequence)
                        opt.order = nextAvailableSequence
                        modelOptions.args[key] = opt
                        nextAvailableSequence = nextAvailableSequence + 1

                        createName = ''
                    end,
                },
            },
        },
        copyGroup = 
		{
            order = 3,
            type = 'group',
            name = 'Copy existing model',
            desc = 'Copy an existing model',
            args = 
			{
                source = 
				{
                    order = 1,
                    type = 'select',
                    name = 'Source',
                    desc = 'Name of the model to copy',
                    values = {},
                    get = function() return sourceName end,
                    set = function(info, key) sourceName = key end,
                },
                doEet = 
				{
                    order = 2,
                    type = 'execute',
                    name = 'Create model',
                    desc = 'Make a copy of the existing model',
                    func = function()
                        Reforgenator:Debug("### new model named [" .. createName .. "] copied from [" .. sourceName .. "]")

                        local model = Reforgenator:deepCopy(Reforgenator.db.global.models[sourceName])
                        model.class = className
                        model.readOnly = nil
                        model.ak = nil
                        Reforgenator:LoadModel(model, createName)
                        local opt = Reforgenator:ModelToModelOption(createName, model)
                        local key = string.format('model_%03d', nextAvailableSequence)
                        opt.order = nextAvailableSequence
                        modelOptions.args[key] = opt
                        nextAvailableSequence = nextAvailableSequence + 1

                        createName = ''
                    end,
                },
            },
        },
    }

    local models = Reforgenator.db.global.models
    local values = addOptions.args.copyGroup.args.source.values
    for k,v in pairs(models) do
        if sourceName == '' then
            sourceName = k
        end

        values[k] = k
    end

end

function Reforgenator:MessageFrame_OnLoad(widget)
end

function Reforgenator:OnClick(widget, button, ...)
    self:Debug("### OnClick")
    self:Debug("widget.ID=" .. widget:GetID())

    GameTooltip:Hide()
    PickupInventoryItem(widget:GetID())
end

function Reforgenator:OnDragStart(widget, button, ...)
    self:Debug("### OnDragStart")
    self:Debug("widget.ID=" .. widget:GetID())

    GameTooltip:Hide()
    PickupInventoryItem(widget:GetID())
end

function Reforgenator:OnEnter(widget)
    self:Debug("### OnEnter")
    self:Debug("### widget.ID=" .. widget:GetID())

    if widget:GetID() ~= 0 then
        GameTooltip:SetOwner(widget, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(GetInventoryItemLink("player", widget:GetID()))
        GameTooltip:Show()
    end
end

function Reforgenator:OnCheckbox(widget)
    self:Debug("### OnCheckbox")
    self:Debug("### widget.ID=" .. widget:GetID())

    local id = widget:GetID()
    table.remove(self.changes, id)
    self:UpdateWindow()
end

function Reforgenator:UpdateWindow()
    FauxScrollFrame_Update(ReforgeListScrollFrame, #self.changes, 4, 41)

    for i=1,4 do
        local linePlusOffset = i + FauxScrollFrame_GetOffset(ReforgeListScrollFrame)
        if linePlusOffset <= #self.changes then
            self:UpdateWindowItem(i, self.changes[linePlusOffset])
        else
            self:UpdateWindowItem(i, nil)
        end
    end

    if not ReforgenatorPanel:IsVisible() then
        ReforgenatorPanel:Show()
    end
end

function Reforgenator:UpdateWindowItem(index, itemDescriptor)
    self:Debug("### UpdateWindowItem")

    if not itemDescriptor then
        _G["ReforgenatorPanel_Item" .. index]:Hide()
        _G["ReforgenatorPanel_Item" .. index .. "Checked"]:Hide()
        return
    end

    local texture = select(10, GetItemInfo(itemDescriptor.itemLink))
    _G["ReforgenatorPanel_Item" .. index .. "IconTexture"]:SetTexture(texture)
    _G["ReforgenatorPanel_Item" .. index]:SetID(itemDescriptor.slotInfo)
    _G["ReforgenatorPanel_Item" .. index .. "Checked"]:SetChecked(nil)

    local msg = ''
    if itemDescriptor.reforgedFrom then
        msg = "- " .. _G[itemDescriptor.reforgedFrom] .. "\n"
               .. "+ " .. _G[itemDescriptor.reforgedTo]
    else
        msg = "reset"
    end
    _G["ReforgenatorPanel_Item" .. index .. "Name"]:SetText(msg)

    _G["ReforgenatorPanel_Item" .. index]:Show()
    _G["ReforgenatorPanel_Item" .. index .. "Checked"]:Show()
end

function Reforgenator:OnEnterNote(widget)
    GameTooltip:ClearLines()
    GameTooltip:SetOwner(widget, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:SetMinimumWidth(300)

    GameTooltip:AddLine("Notes", 1, 1, 1, 1)

    local models = Reforgenator.db.global.models
    local name = UIDropDownMenu_GetText(ReforgenatorPanel_ModelSelection)
    if models[name] and models[name].notes then
        GameTooltip:AddLine(models[name].notes, nil, nil, nil, 1)
    end

    GameTooltip:Show()
end

function Reforgenator:OnLeaveNote(widget)
    GameTooltip:Hide()
end

function Reforgenator:ModelSelection_OnLoad()
    self:Debug("### ModelSelection_OnLoad")
end

function Reforgenator:ModelEditorScrollbar_Update()
    self:Debug("### ModelEditorScrollbar_Update")

    local sb = ReforgenatorModelBrowseScrollFrame
    local models = Reforgenator.db.global.models

    local keys = {}
    for k,v in pairs(models) do
        keys[#keys + 1] = k
    end
    table.sort(keys)

    FauxScrollFrame_Update(sb, #keys, 6, 16)

    for line=1,6 do
        local button = _G["ModelEditorNameButton" .. line]
        local buttonText = _G["ModelEditorNameButton" .. line .. "Name"]
        local linePlusOffset = line + FauxScrollFrame_GetOffset(sb)
        if linePlusOffset < #keys then
            buttonText:SetText(keys[linePlusOffset])
            if Reforgenator.selectedModelName and Reforgenator.selectedModelName == keys[linePlusOffset] then
                button:LockHighlight()
            else
                button:UnlockHighlight()
            end
            button:Show()
        else
            button:Hide()
        end
    end
end

function Reforgenator:GetPlayerKey()
    return GetUnitName("player") .. "-" .. GetRealmName() .. "/" .. GetActiveSpecGroup(false, false)
end

function Reforgenator:ModelSelection_OnInitialize()
    self:Debug("### ModelSelection_OnInitialize")

    local db = Reforgenator.db

    local class = select(2, UnitClass("player"))
    local key = self:GetPlayerKey()

    local function clearPlayerFromModels()
        for k,v in pairs(db.global.models) do
            if v.PerCharacterOptions[key] then
                v.PerCharacterOptions[key] = nil
            end
        end
    end

    local displayOrder = {}
    for k,v in pairs(db.global.models) do
        if v.class == class then
            displayOrder[#displayOrder + 1] = k
        end
    end
    table.sort(displayOrder)
    self:Debug("### displayOrder=" .. to_string(displayOrder))

    local info = UIDropDownMenu_CreateInfo()
    for _,k in ipairs(displayOrder) do
        info.text = k
        info.func = function(self)
            Reforgenator:Debug("### chose " .. self.value)
            clearPlayerFromModels()
            db.global.models[self.value].PerCharacterOptions[key] = true
            UIDropDownMenu_SetSelectedName(ReforgenatorPanel_ModelSelection, self.value)
            Reforgenator:ShowState()
        end
        info.checked = nil
        UIDropDownMenu_AddButton(info)
    end
end

function Reforgenator:ModelSelection_OnShow()
    local db = Reforgenator.db
    local func = function() Reforgenator:ModelSelection_OnInitialize() end
    UIDropDownMenu_Initialize(ReforgenatorPanel_ModelSelection, func)
    UIDropDownMenu_SetWidth(ReforgenatorPanel_ModelSelection, 230)

    UIDropDownMenu_ClearAll(ReforgenatorPanel_ModelSelection)

    local key = self:GetPlayerKey()
    for k,v in pairs(db.global.models) do
        if v.PerCharacterOptions[key] then
            UIDropDownMenu_SetSelectedName(ReforgenatorPanel_ModelSelection, k)
        end
    end
end

function Reforgenator:SandboxSelection_OnLoad()
    self:Debug("### SandboxSelection_OnLoad")
end

function Reforgenator:SandboxSelection_OnInitialize()
    self:Debug("### SandboxSelection_OnInitialize")

    local info = UIDropDownMenu_CreateInfo()
    info.text = "Leave reforged items alone"
    info.func = function(self)
        local talentGroup = GetActiveSpecGroup(false, false)
        Reforgenator.db.char.useSandbox[talentGroup] = nil
        UIDropDownMenu_SetSelectedName(ReforgenatorPanel_SandboxSelection, self.value)
        Reforgenator:ShowState()
    end
    info.id = 1
    info.checked = nil
    UIDropDownMenu_AddButton(info)

    info.text = "Consider reforging anything"
    info.func = function(self)
        local talentGroup = GetActiveSpecGroup(false, false)
        Reforgenator.db.char.useSandbox[talentGroup] = true
        UIDropDownMenu_SetSelectedName(ReforgenatorPanel_SandboxSelection, self.value)
        Reforgenator:ShowState()
    end
    info.id = 2
    info.checked = nil
    UIDropDownMenu_AddButton(info)
end

function Reforgenator:SandboxSelection_OnShow()
    self:Debug("### SandboxSelection_OnShow")

    local db = Reforgenator.db
    local func = function() Reforgenator:SandboxSelection_OnInitialize() end
    UIDropDownMenu_Initialize(ReforgenatorPanel_SandboxSelection, func)
    UIDropDownMenu_SetWidth(ReforgenatorPanel_SandboxSelection, 230)

    local talentGroup = GetActiveSpecGroup(false, false)
    if db.char.useSandbox[talentGroup] then
        UIDropDownMenu_SetSelectedID(ReforgenatorPanel_SandboxSelection, 2)
    else
        UIDropDownMenu_SetSelectedID(ReforgenatorPanel_SandboxSelection, 1)
    end
end

function Reforgenator:TargetLevelSelection_OnLoad()
    self:Debug("### TargetLevelSelection_OnLoad")
end

function Reforgenator:TargetLevelSelection_OnInitialize()
    self:Debug("### TargetLevelSelection_OnInitialize")

    local info = UIDropDownMenu_CreateInfo()

    local c = Reforgenator.constants

    for k,v in ipairs(c.REFORGING_TARGET_LEVELS) do
        info.text = v
        info.func = function(self)
            local talentGroup = GetActiveSpecGroup(false, false)
            Reforgenator.db.char.targetLevelSelection[talentGroup] = k
            UIDropDownMenu_SetSelectedName(ReforgenatorPanel_TargetLevelSelection, self.value)
            Reforgenator:ShowState()
        end
        info.id = k
        info.checked = nil
        UIDropDownMenu_AddButton(info)
    end
end

function Reforgenator:TargetLevelSelection_OnShow()
    self:Debug("### TargetLevelSelection_OnShow")

    local db = Reforgenator.db
    local func = function() Reforgenator:TargetLevelSelection_OnInitialize() end
    UIDropDownMenu_Initialize(ReforgenatorPanel_TargetLevelSelection, func)
    UIDropDownMenu_SetWidth(ReforgenatorPanel_TargetLevelSelection, 230)

    local talentGroup = GetActiveSpecGroup(false, false)
    local selected = Reforgenator.db.char.targetLevelSelection
    UIDropDownMenu_SetSelectedID(ReforgenatorPanel_TargetLevelSelection, selected[talentGroup] or 2)
end

function Reforgenator:ClearExplanation()
    Reforgenator.explanation = ''
end

function Reforgenator:Explain(...)
    local msg = string.join(", ", ...)
    self:Debug(msg)

    Reforgenator.explanation = (Reforgenator.explanation or '') .. "\n" .. msg
end

function Reforgenator:Warning(...)
    local msg = string.join(", ", ...)
    self:Print(msg)

    self:Explain(...)
end

function Reforgenator:ShowExplanation()
    if Reforgenator.db.profile.verbose.emit and Reforgenator.explanation then
        for line in Reforgenator.explanation:gmatch("[^\r\n]+") do
            self:Print(line)
            if line:find("End Reforge Model") then
                break
            end
        end
    end
end

local debugFrame = tekDebug and tekDebug:GetFrame("Reforgenator")

function Reforgenator:Debug(...)
    if debugFrame then
        debugFrame:AddMessage(string.join(", ", ...))
    end
end

function Reforgenator:Dump(name, t)
    if type(t) == "table" then
        for k,v in next, t do
            self:Debug(name .. "[" .. k .. "]=" .. to_string(v))
        end
    else
        self:Debug(name .. "=" .. to_string(t))
    end
end

function Reforgenator:deepCopy(o)
    local lut = {}
    local function _copy(o)
        if type(o) ~= "table" then
            return o
        elseif lut[o] then
            return lut[o]
        end
        local result = {}
        lut[o] = result
        for k,v in pairs(o) do
            result[_copy(k)] = _copy(v)
        end
        return setmetatable(result, getmetatable(o))
    end

    return _copy(o)
end

function Reforgenator:removeIf(l, pred)
local result = {}
  for _,v in ipairs(l) do
    if not pred(v) then table.insert(result, v) end
  end
  return result
end

local SolutionContext = {}

function SolutionContext:new()
    local result = {
        items = {},
        changes = {},
        excessRating = {}
    }
    setmetatable(result, self)
    self.__index = self
    return result
end

local PlayerModel = {}

function PlayerModel:new()
    local c = Reforgenator.constants
    local result = {
        className = "",
        primaryTab = 0,
        race = "",
        statEffectMap = {
            ["ITEM_MOD_CRIT_RATING_SHORT"] = 
			{
                CR_CRIT_MELEE, CR_CRIT_RANGED, CR_CRIT_SPELL,
            },
            ["ITEM_MOD_DODGE_RATING_SHORT"] = 
			{
                CR_DODGE,
            },
            ["ITEM_MOD_EXPERTISE_RATING_SHORT"] = 
			{
                CR_EXPERTISE,
            },
            ["ITEM_MOD_HASTE_RATING_SHORT"] = 
			{
                CR_HASTE_MELEE, CR_HASTE_RANGED, CR_HASTE_SPELL,
            },
            ["ITEM_MOD_HIT_RATING_SHORT"] = 
			{
                CR_HIT_MELEE, CR_HIT_RANGED, CR_HIT_SPELL,
            },
            ["ITEM_MOD_MASTERY_RATING_SHORT"] = 
			{
                CR_MASTERY,
            },
            ["ITEM_MOD_PARRY_RATING_SHORT"] = 
			{
                CR_PARRY,
            },
            ["ITEM_MOD_SPIRIT_SHORT"] = 
			{
                CR_SPIRIT,
            },
        },
        playerStats = { },
    }

    setmetatable(result, self)
    self.__index = self
    return result
end

function PlayerModel:UpdateStats(minusStat, plusStat, delta)
    for _,v in ipairs(self.statEffectMap[minusStat]) do
        if minusStat == "ITEM_MOD_SPIRIT" and v == CR_HIT_SPELL and self.spiritHitConversionRate then
            self.playerStats[v] = self.playerStats[v] - math.floor(delta * self.spiritHitConversionRate)
        elseif minusStat == "ITEM_MOD_EXPERTISE" and v == CR_HIT_SPELL and self.expHitConversionRate then
            self.playerStats[v] = self.playerStats[v] - math.floor(delta * self.expHitConversionRate)
		else 
            self.playerStats[v] = self.playerStats[v] - delta
        end
    end

    for _,v in ipairs(self.statEffectMap[plusStat]) do
        if plusStat == "ITEM_MOD_SPIRIT" and v == CR_HIT_SPELL and self.spiritHitConversionRate then
            self.playerStats[v] = self.playerStats[v] + math.floor(delta * self.spiritHitConversionRate)
        elseif plusStat == "ITEM_MOD_EXPERTISE" and v == CR_HIT_SPELL and self.expHitConversionRate then
            self.playerStats[v] = self.playerStats[v] + math.floor(delta * self.expHitConversionRate)
		else
            self.playerStats[v] = self.playerStats[v] + delta
        end
    end
end

function PlayerModel:isFuryWarrior()
    return self.className == "WARRIOR" and self.primaryTab == 2
end

function PlayerModel:isBloodDK()
    return self.className == "DEATHKNIGHT" and self.primaryTab == 1
end

function PlayerModel:isFrostDK()
    return self.className == "DEATHKNIGHT" and self.primaryTab == 2
end

function PlayerModel:isEnhShaman()
    return self.className == "SHAMAN" and self.primaryTab == 2
end

function Reforgenator:GetPlayerModel()
    local playerModel = PlayerModel:new()

    local function getPrimaryTab()
	
		currentSpec = GetSpecialization()
		currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"
		print("Your current spec:", currentSpecName)
		print("Your current spec tab:", currentSpec)
			
        local primary = 
		{
			tab = currentSpec,
            points = 0,
            role = ' '
			
        }
		--local currentSpecName = currentSpec and select(2, GetSpecializationInfo(currentSpec)) or "None"	
      --  for i=1,GetNumSpecializations() do												--5.04 API change GetNumTalentTabs ? GetNumSpecializations
      --      local _, _, _, _, points,  role = GetSpecializationInfo(i)		--5.04 API change GetTalentTabInfo ? GetSpecializationInfo
      --      if points > primary.points then
      --          primary = 
	--			{
    --                tab = i,
      --              points = points,
      --              role = role
      --          }
      --      end
      --  end

        return primary.tab
    end

    local function getMainHandWeaponType()
        local mainHandWeaponType = ''
        local mainHandLink = GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot"))
        if mainHandLink then
            local _, _, _, _, _, itemType, itemSubType = GetItemInfo(mainHandLink)
            self:Debug("itemType=" .. itemType .. ", itemSubType=" .. itemSubType)
            mainHandWeaponType = itemSubType
        else
            self:Warning("Warning: no main-hand weapon found")
        end
        return mainHandWeaponType
    end

    playerModel.className = select(2, UnitClass("player"))
    playerModel.primaryTab = getPrimaryTab()
    playerModel.race = select(2, UnitRace("player"))
    playerModel.mainHandWeaponType = getMainHandWeaponType()
    playerModel.talentGroup = GetActiveSpecGroup(false, false)

    self:Explain("level=" .. UnitLevel("player"))
    self:Explain("className=" .. playerModel.className)
    self:Explain("primaryTab=" .. to_string(playerModel.primaryTab))
    self:Explain("race=" .. playerModel.race)
    self:Explain("mainHandWeaponType=" .. playerModel.mainHandWeaponType)

    local interestingRatings = 
	{
        CR_HIT_MELEE, CR_HIT_RANGED, CR_HIT_SPELL,
        CR_EXPERTISE, CR_MASTERY, CR_DODGE, CR_PARRY,
        CR_CRIT_MELEE, CR_CRIT_RANGED, CR_CRIT_SPELL,
        CR_HASTE_MELEE, CR_HASTE_RANGED, CR_HASTE_SPELL,
    }
    for _,v in ipairs(interestingRatings) do
        playerModel.playerStats[v] = GetCombatRating(v)
    end

    -- there isn't a "spirit" combat rating, but it's still interesting
    playerModel.playerStats[CR_SPIRIT] = UnitStat("player", 5)

    -- aaaaaand we just made this one up for funsies
    playerModel.playerStats[CR_EP] = 0

    -- Calculate spirit/hit conversion
    -- Priest get 50/100 from Twisted Faith
    -- Shaman get 33/66/100 from Elemental Precision
    -- Pallies get 50/100 from Enlightened Judgement
    -- Druids get 50/100 from Balance of Power
    playerModel.spiritHitConversionRate = nil
	playerModel.expHitConversionRate = nil
	
		
    if playerModel.className == "DRUID" then
		playerModel.spiritHitConversionRate = 1
		Convert = 1
		currentSpec = GetSpecialization()
		 if currentSpec == 1 then
			playerModel.expHitConversionRate= 1
		end	
        
    end
	
	if playerModel.className == "MAGE" then
        playerModel.expHitConversionRate = 1
		Convert = 1
    end
	
	if playerModel.className == "MONK" then
		currentSpec = GetSpecialization()
		 if currentSpec == 2 then
			playerModel.spiritHitConversionRate = 1
			playerModel.expHitConversionRate= 1
			Convert = 1
		end	
    end
	
	if playerModel.className == "PALADIN" then
		currentSpec = GetSpecialization()
		 if currentSpec == 1 then
			playerModel.expHitConversionRate= 1
			Convert = 1
		end
    end
	
    if playerModel.className == "PRIEST" then
        playerModel.expHitConversionRate = 1
		if currentSpec == 3 then
			playerModel.spiritHitConversionRate= 1
			Convert = 1
		end
    end

    if playerModel.className == "SHAMAN" then
       playerModel.spiritHitConversionRate = 1
	   Convert = 1
    end

 	if playerModel.className == "WARLOCK" then
        playerModel.expHitConversionRate = 1
		Convert = 1
    end   

    self:Explain("spiritHitConversionRate=" .. to_string(playerModel.spiritHitConversionRate))
    if playerModel.spiritHitConversionRate then
        playerModel.statEffectMap["ITEM_MOD_SPIRIT_SHORT"] = {
            CR_SPIRIT, CR_HIT_SPELL
        }
    end
	
	self:Explain("expHitConversionRate=" .. to_string(playerModel.expHitConversionRate))
    if playerModel.expHitConversionRate then
        playerModel.statEffectMap["ITEM_MOD_EXPERTISE_RATING_SHORT"] = {
            CR_EXPERTISE, CR_HIT_SPELL, CR_HIT_MELEE, CR_HIT_RANGED
        }
    end

	
    return playerModel
end

function Reforgenator:CalculateHitMods(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.meleeHit

    local reduction = 0

    -- Mods to hit: Draenei get 1% bonus
    if playerModel.race == "Draenei" then
        self:Explain("1% to hit for being Draenei")
        reduction = reduction + K
    end
--[[
    -- Fury warriors get 3% bonus from Precision
    if playerModel:isFuryWarrior() then
        self:Explain("3% to hit for being Fury warrior due to Precision")
        reduction = reduction + (3 * K)
   end
]]
    -- Rogues get varying amounts based on Precision talent        ***** uses GetTalentInfo which changed in 5.04
   -- if playerModel.className == "ROGUE" then
   ----     local pointsInPrecision = select(5, GetTalentInfo(2, 3))
   --     self:Explain((2 * pointsInPrecision) .. "% to hit for being Rogue with Precision talent")
   --     reduction = reduction + (K * 2 * pointsInPrecision)
   -- end

    -- Frost DKs get varying amounts if they're DW and have Nerves of Cold Steel   ***** uses GetTalentInfo which changed in 5.04
   -- if playerModel.className == "DEATHKNIGHT" and playerModel.mainHandWeaponType:sub(1, 10) ~= "Two-handed" then
   --     local pointsInNoCS = select(5, GetTalentInfo(2, 3))
   --     self:Explain((pointsInNoCS) .. "% to hit for being DW DK with Nerves of Cold Steel talent")
   --     reduction = reduction + (K * pointsInNoCS)
   -- end

    self:Explain("hit rating modification = " .. reduction)
    return reduction

end

function Reforgenator:CalculateMeleeHitCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.meleeHit
    local db = Reforgenator.db
    local cap = c.MELEE_HIT_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local hitCap = (cap * K)
    self:Explain("hit cap = " .. hitCap)

    local targetHitRating = math.ceil(hitCap - self:CalculateHitMods(playerModel))
    self:Explain("calculated target hit rating = " .. targetHitRating)

    return targetHitRating
end

function Reforgenator:CalculateDWMeleeHitCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.meleeHit
    local db = Reforgenator.db
    local cap = c.DW_HIT_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local hitCap = (cap * K)
    self:Explain("DW hit cap = " .. hitCap)

    local targetHitRating = math.ceil(hitCap - self:CalculateHitMods(playerModel))
    self:Explain("calculated target hit rating = " .. targetHitRating)

    return targetHitRating
end

function Reforgenator:CalculateRangedHitCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.meleeHit
    local db = Reforgenator.db
    local cap = c.MELEE_HIT_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local hitCap = (cap * K)
    self:Explain("ranged hit cap = " .. hitCap)

    -- Mods to hit: Draenei get 1% bonus
    if playerModel.race == "Draenei" then
        self:Explain("1% to hit for being Draenei")
        hitCap = hitCap - K
    end

    hitCap = math.ceil(hitCap)
    self:Explain("calculated target ranged hit rating = " .. hitCap)

    return hitCap
end

function Reforgenator:CalculateSpellHitCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.spellHit
    local db = Reforgenator.db
    local cap = c.SPELL_HIT_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local hitCap = (cap * K)
    self:Explain("base spell hit rating = " .. hitCap)

    -- Mods to hit: Draenei get 1% bonus
    if playerModel.race == "Draenei" then
        self:Explain("1% to hit for being Draenei")
        hitCap = hitCap - (K)
    end

    -- Rogues get varying amounts based on Precision talent
   -- if playerModel.className == "ROGUE" then
   --     local pointsInPrecision = select(5, GetTalentInfo(2, 3))
   --     self:Explain((2 * pointsInPrecision) .. "% to hit for being Rogue with Precision talent")
   --     hitCap = hitCap - (K * 2 * pointsInPrecision)
   -- end

    -- Death Knights get 9% spell hit from Runic Focus
    if playerModel.className == "DEATHKNIGHT" then
        self:Explain("9% to hit for being Death Knight")
        hitCap = hitCap - K * 9
    end

    hitCap = math.ceil(hitCap)
    self:Explain("calculated target spell hit rating = " .. hitCap)

    return hitCap
end

function Reforgenator:ExpertiseMods(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.expertise

    --   DKs get +6 expertise from "veteran of the third war"
    --   Orcs get +3 for axes and fist weapons
    --   Dwarves get +3 for maces
    --   Humans get +3 for swords and maces
    --   Gnomes get +3 for daggers and 1H swords
    --   Paladins with "Seal of Truth" glyphed get +10 expertise
    --   Enh shamans get +4 for each point in Unleashed Rage
    local reduction = 0;

    if playerModel:isBloodDK() then
        self:Explain("+6 expertise for being blood DK")
        reduction = reduction + (6 * K)
    end

    if playerModel.className == "PALADIN" then
        local hasGlyph = nil
        for i=1,GetNumGlyphSockets() do
            local _, _, _, glyphSpellID = GetGlyphSocketInfo(i)
            self:Debug("glyph socket " .. i .. " has " .. (glyphSpellID or "nil"))
            if glyphSpellID and glyphSpellID == 56416 then
                hasGlyph = true
            end
        end

        if hasGlyph then
            self:Explain("+10 expertise for being Paladin with Glyph of Seal of Truth")
            reduction = reduction + (10 * K)
        end
    end

    if playerModel.race == "Orc" then
        if playerModel.mainHandWeaponType == "One-Handed Axes"
                or playerModel.mainHandWeaponType == "Two-Handed Axes"
                or playerModel.mainHandWeaponType == "Fist Weapons" then
            self:Explain("+1 expertise for being Orc with axe or fist")
            reduction = reduction + (1 * K)
        end
    elseif playerModel.race == "Dwarf" then
        if playerModel.mainHandWeaponType == "One-Handed Maces"
                or playerModel.mainHandWeaponType == "Two-Handed Maces" then
            self:Explain("+1 expertise for being Dwarf with mace")
            reduction = reduction + (1 * K)
        end
    elseif playerModel.race == "Human" then
        if playerModel.mainHandWeaponType == "One-Handed Swords"
                or playerModel.mainHandWeaponType == "Two-Handed Swords"
                or playerModel.mainHandWeaponType == "One-Handed Maces"
                or playerModel.mainHandWeaponType == "Two-Handed Maces" then
            self:Explain("+1 expertise for being Human with sword or mace")
            reduction = reduction + (1 * K)
        end
    elseif playerModel.race == "Gnome" then
        if playerModel.mainHandWeaponType == "One-Handed Swords"
                or playerModel.mainHandWeaponType == "Daggers" then
            self:Explain("+1 expertise for being Gnome with dagger or 1H sword")
            reduction = reduction + (1 * K)
        end
    end

  --  if playerModel.className == "SHAMAN" then
  --      local pointsInUnleashedRage = select(5, GetTalentInfo(2, 16))
  --      self:Explain("+" .. (4 * pointsInUnleashedRage) .. "expertise for being Shaman with Unleashed Rage talent")
  --      reduction = reduction + (4 * pointsInUnleashedRage * K)
  --  end

    self:Explain("expertise rating modification = " .. reduction)
    return reduction
end

function Reforgenator:CalculateExpertiseSoftCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.expertise
    local db = Reforgenator.db
    local cap = c.EXP_SOFT_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local expertiseCap = (cap * K)
    self:Explain("base expertise rating required = " .. expertiseCap)

    expertiseCap = math.ceil(expertiseCap - self:ExpertiseMods(playerModel))
    self:Explain("target expertise rating = " .. expertiseCap)
    return expertiseCap
end

function Reforgenator:CalculateExpertiseHardCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.expertise
    local db = Reforgenator.db
    local cap = c.EXP_HARD_CAP_BY_TARGET_LEVEL[db.char.targetLevelSelection[playerModel.talentGroup] or 2]

    local expertiseCap = (cap * K)
    self:Explain("base expertise rating required = " .. expertiseCap)

    expertiseCap = math.ceil(expertiseCap - self:ExpertiseMods(playerModel))
    self:Explain("target expertise rating = " .. expertiseCap)
    return expertiseCap
end

function Reforgenator:HasteTo1SecGCD(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.haste

    local hasteCap = (50 * K)
    self:Explain("base haste rating required = " .. hasteCap)

    local reduction = 0

   --- if playerModel.className == "PRIEST" then
   --     local pointsInDarkness = select(5, GetTalentInfo(3, 1))
   --     self:Explain((pointsInDarkness) .. "% spell haste for being Priest with Darkenss talent")
   --     reduction = reduction + (pointsInDarkness * K)
    --end

    --if playerModel.className == "DRUID" then
    --    local moonkinForm = select(5, GetTalentInfo(1, 8))
    --    self:Explain((5 * moonkinForm) .. "% spell haste for being Druid with moonkin form")
    --    reduction = reduction + (moonkinForm * 5 * K)
   -- end

    if playerModel.race == "Goblin" then
        self:Explain("1% haste for being a Goblin")
        reduction = reduction + (K)
    end

    local targetHasteRating = math.ceil(hasteCap - reduction)
    self:Explain("target haste rating = " .. targetHasteRating)
    return targetHasteRating
end

function Reforgenator:CalculateMaximumValue(playerModel)
    return 9999
end

function Reforgenator:CalculateFrostSoftCritCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.crit

    local critCap = (23.34 * K)
    self:Explain("base crit rating required = " .. critCap)

    local reduction = 0

   -- if playerModel.className == "MAGE" then
    --    local pointsInPiercingIce = select(5, GetTalentInfo(3, 2))
    --    self:Explain((pointsInPiercingIce) .. "% to crit for being Mage with Piercing Ice talent")
   --     reduction = reduction + (K * pointsInPiercingIce)
  --  end

    critCap = math.ceil(critCap - reduction)

    self:Explain("calculated target crit rating = " .. critCap)
    return critCap
end

function Reforgenator:CalculateFireSoftHasteCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.haste

    local hasteCap = (15 * K)

    local reduction = 0

   -- if playerModel.className == "MAGE" then
   --     local pointsInNP = select(5, GetTalentInfo(1, 3))
   --     self:Explain((pointsInNP) .. "% to haste for being Mage with Netherwind Presence talent")
  --      reduction = reduction + (K * pointsInNP)
   -- end

    hasteCap = math.ceil(hasteCap - reduction)

    self:Explain("calculated target haste rating = " .. hasteCap)

    return hasteCap
end

function Reforgenator:CalculateHolySoftHasteCap(playerModel)
    local c = Reforgenator.constants
    local K = c.RATING_CONVERSIONS.haste

    local hasteCap = (12.5 * K)

    local reduction = 0

    hasteCap = math.ceil(hasteCap - reduction)

    self:Explain("calculated target haste rating = " .. hasteCap)

    return hasteCap
end

function Reforgenator:LoadDefaultModels()
    local models = Reforgenator.db.global.models
    if models ~= nil then
        local cull = {}
        for k,v in pairs(models) do
            if k:find('^built%-in: ') or v.readOnly then
                cull[#cull + 1] = k
            end
        end
        for _,v in ipairs(cull) do
            models[v] = nil
        end

        Reforgenator.db.global.models = models
    end

    self:LoadModel(self:BloodDKModel(), 'DK, blood', 'DEATHKNIGHT/1', 'DEATHKNIGHT')
    self:LoadModel(self:TwoHandFrostDKModel(), 'DK, 2H frost', '2HFrost', 'DEATHKNIGHT')
    self:LoadModel(self:DWFrostDKModel(), 'DK, DW frost', 'DWFrost', 'DEATHKNIGHT')
    --self:LoadModel(self:MasterfrostDKModel(), 'DK, Masterfrost', 'Masterfrost', 'DEATHKNIGHT')  --gone for now
    self:LoadModel(self:UnholyDKModel(), 'DK, unholy', 'DEATHKNIGHT/3', 'DEATHKNIGHT')

    self:LoadModel(self:BalanceModel(), 'Druid, Balance', 'DRUID/1', 'DRUID')
	self:LoadModel(self:FeralModel(), 'Druid, Feral', 'DRUID/2', 'DRUID')
    self:LoadModel(self:GuardianModel(), 'Druid, Guardian', 'DRUID/3', 'DRUID')
    self:LoadModel(self:ManaRestoDruidModel(), 'Druid, Mana Restoration', 'DRUID/4', 'DRUID')
    self:LoadModel(self:RestoDruidModel(), 'Druid, Restoration', 'DRUID/4', 'DRUID')
	
    self:LoadModel(self:BeastMasterHunterModel(), 'Hunter, BM', 'HUNTER/1', 'HUNTER')
    self:LoadModel(self:MarksmanshipHunterModel(), 'Hunter, MM', 'HUNTER/2', 'HUNTER')
    self:LoadModel(self:SurvivalHunterModel(), 'Hunter, SV', 'HUNTER/3', 'HUNTER')

    self:LoadModel(self:ArcaneMageModel(), 'Mage, arcane', 'MAGE/1', 'MAGE')
    self:LoadModel(self:FireMageModel(), 'Mage, fire', 'MAGE/2', 'MAGE')
    self:LoadModel(self:FrostMageModel(), 'Mage, frost', 'MAGE/3', 'MAGE')

    self:LoadModel(self:HolyPallyModel(), 'Paladin, holy', 'PALADIN/1', 'PALADIN')
    self:LoadModel(self:ProtPallyModel(), 'Paladin, protection', 'PALADIN/2', 'PALADIN')
    self:LoadModel(self:RetPallyModel(), 'Paladin, retribution', 'PALADIN/3', 'PALADIN')

    self:LoadModel(self:DiscPriestModel(), 'Priest, discipline', 'PRIEST/1', 'PRIEST')
    self:LoadModel(self:HolyPriestModel(), 'Priest, holy', 'PRIEST/2', 'PRIEST')
    self:LoadModel(self:ShadowPriestModel(), 'Priest, shadow', 'PRIEST/3', 'PRIEST')

    self:LoadModel(self:AssassinationRogueModel(), "Rogue, assassination", 'ROGUE/1', 'ROGUE')
    self:LoadModel(self:CombatRogueModel(), "Rogue, combat", 'ROGUE/2', 'ROGUE')
    self:LoadModel(self:SubtletyRogueModel(), "Rogue, subtlety", 'ROGUE/3', 'ROGUE')

    self:LoadModel(self:ElementalModel(), 'Shaman, elemental', 'SHAMAN/1', 'SHAMAN')
    self:LoadModel(self:EnhancementModel(), 'Shaman, enhancement', 'SHAMAN/2', 'SHAMAN')
    self:LoadModel(self:RestoShamanModel(), 'Shaman, restoration', 'SHAMAN/3', 'SHAMAN')

    self:LoadModel(self:AffWarlockModel(), 'Warlock, affliction', 'WARLOCK/1', 'WARLOCK')
    self:LoadModel(self:DemoWarlockModel(), 'Warlock, demonology', 'WARLOCK/2', 'WARLOCK')
    self:LoadModel(self:DestroWarlockModel(), 'Warlock, destruction', 'WARLOCK/3', 'WARLOCK')

    self:LoadModel(self:ArmsModel(), 'Warrior, arms', 'WARRIOR/1', 'WARRIOR')
    self:LoadModel(self:FuryModel(), 'Warrior, fury', 'WARRIOR/2', 'WARRIOR')
    self:LoadModel(self:SMFuryModel(), 'Warrior, single-minded fury', nil, 'WARRIOR')
    self:LoadModel(self:ProtWarriorModel(), 'Warrior, protection', 'WARRIOR/3', 'WARRIOR')
	
	self:LoadModel(self:BrewMasterMonkModel(), 'Monk, BrewMaster', 'MONK/1', 'MONK')
	self:LoadModel(self:MistWeaverMonkModel(), 'Monk, MistWeaver', 'MONK/2', 'MONK')
	self:LoadModel(self:TwoHandWindWalkerMonkModel(), 'Monk, TwoHandWindWalker', nil, 'MONK')
	self:LoadModel(self:DWWindWalkerMonkModel(), 'Monk, DWWindWalker', 'MONK/3', 'MONK')
end

function Reforgenator:LoadModel(model, modelName, ak, class)
    local m = Reforgenator.db.global.models
    if not m then
        m = {}
    end

    if not modelName then
        modelName = model.name
    end
    m[modelName] = model
    m[modelName].PerCharacterOptions = {}

    if ak then
        m[modelName].ak = ak
    end

    if class then
        m[modelName].class = class
    end

    Reforgenator.db.global.models = m
end

function Reforgenator:ExplainPlayerModel(playerModel)
    self:Explain("  melee hit = " .. playerModel.playerStats[CR_HIT_MELEE])
    self:Explain("  melee crit = " .. playerModel.playerStats[CR_CRIT_MELEE])
    self:Explain("  melee haste = " .. playerModel.playerStats[CR_HASTE_MELEE])
    self:Explain("  expertise = " .. playerModel.playerStats[CR_EXPERTISE])
    self:Explain("  ranged hit = " .. playerModel.playerStats[CR_HIT_RANGED])
    self:Explain("  ranged crit = " .. playerModel.playerStats[CR_CRIT_RANGED])
    self:Explain("  ranged haste = " .. playerModel.playerStats[CR_HASTE_RANGED])
    self:Explain("  spell hit = " .. playerModel.playerStats[CR_HIT_SPELL])
    self:Explain("  spell crit = " .. playerModel.playerStats[CR_CRIT_SPELL])
    self:Explain("  spell haste = " .. playerModel.playerStats[CR_HASTE_SPELL])
    self:Explain("  dodge = " .. playerModel.playerStats[CR_DODGE])
    self:Explain("  parry = " .. playerModel.playerStats[CR_PARRY])
    self:Explain("  mastery = ".. playerModel.playerStats[CR_MASTERY])
end


function Reforgenator:GetPlayerReforgeModel(playerModel)
    local db = Reforgenator.db

    local key = self:GetPlayerKey()
    for k,v in pairs(db.global.models) do
        if v.PerCharacterOptions[key] then
            self:Debug("using previously-selected model " .. k)
            return v
        end
    end

    local ak
    ak = playerModel.className .. "/" .. to_string(playerModel.primaryTab)
    if playerModel:isFrostDK() then
        if playerModel.mainHandWeaponType:sub(1, 10) == "Two-handed" then
            ak = '2HFrost'
        else
            ak = 'DWFrost'
        end
    end

    if not ak then
        self:MessageBox("Your class/spec isn't supported yet.")
        return nil
    end

    self:Debug("### searching for ak=" .. ak)
    for k,v in pairs(Reforgenator.db.global.models) do
        self:Debug("### model[" .. tostring(k) .. "].ak=" .. (v.ak or "nil"))
        if v.ak == ak then
            v.PerCharacterOptions[key] = true
            return v
        end
    end

    self:MessageBox("I don't know what model to suggest for you. Have you reset your talent points?")
    return nil
end

function Reforgenator:MessageBox(msg)
    SetPortraitTexture(ReforgenatorPortrait, "player")
    ReforgenatorMessageText:SetText(msg)
    ReforgenatorMessageFrame:Show()
end

function Reforgenator:ShowState()
    local c = Reforgenator.constants
    local db = Reforgenator.db
    self:Debug("in ShowState")

    self:ClearExplanation()

    self:Explain("===== Begin =====")
    local playerModel = self:GetPlayerModel()

    local model = self:GetPlayerReforgeModel(playerModel)
    if not model then
        return
    end

    local REFORGE_ID_MAP = 
	{
        [1] = "ITEM_MOD_SPIRIT_SHORT",
        [2] = "ITEM_MOD_DODGE_RATING_SHORT",
        [3] = "ITEM_MOD_PARRY_RATING_SHORT",
        [4] = "ITEM_MOD_HIT_RATING_SHORT",
        [5] = "ITEM_MOD_CRIT_RATING_SHORT",
        [6] = "ITEM_MOD_HASTE_RATING_SHORT",
        [7] = "ITEM_MOD_EXPERTISE_RATING_SHORT",
        [8] = "ITEM_MOD_MASTERY_RATING_SHORT",
    }

    self:Explain("useSandbox = " .. to_string(db.char.useSandbox))
    self:Explain("targetLevelSelection = " .. c.REFORGING_TARGET_LEVELS[db.char.targetLevelSelection[playerModel.talentGroup] or 2])

    for k,v in ipairs(model.statWeights) do
        self:Explain("statWeights[" .. _G[k] .. "]=" .. v)
    end

    -- Get the current state of the equipment
    soln = SolutionContext:new()
    for k,v in ipairs(Reforgenator.constants.INVENTORY_SLOTS) do
        local slotInfo = GetInventorySlotInfo(v)
        local itemLink = GetInventoryItemLink("player", slotInfo)
        if itemLink then
            local stats = {}
            GetItemStats(itemLink, stats)
            local entry = {}
            entry.itemLink = itemLink
            entry.slotInfo = slotInfo
            entry.itemLevel = select(4, GetItemInfo(itemLink))

            -- examine items previously reforged to see if they're still optimal
            entry.reforged = nil
            if RI:IsItemReforged(itemLink) then
                if db.char.useSandbox[playerModel.talentGroup] then
                -- mark this item sandboxed
                    local minus, plus = RI:GetReforgedStatIDs(RI:GetReforgeID(itemLink))
                    self:Debug("### undoing previous reforge, minus=" .. to_string(minus) .. ", plus=" .. to_string(plus))
                    if minus and plus then
                        entry.sandboxed = true
                        entry.oldReforgedFrom = REFORGE_ID_MAP[minus]
                        entry.oldReforgedTo = REFORGE_ID_MAP[plus]

                        -- and undo the effects of the previous reforge
                        local delta = math.floor(0.40 * stats[REFORGE_ID_MAP[minus]])
                        playerModel:UpdateStats(REFORGE_ID_MAP[plus], REFORGE_ID_MAP[minus], delta)
                    else
                    -- this shouldn't happen, but apparently it does
                    -- and I haven't been able to repro yet
                        entry.reforged = true
                        self:Explain("item " .. itemLink .. " has been reforged but unexpected data (" .. to_string(minus) .. ", " .. to_string(plus) .. ") returned from LibReforgingInfo")
                    end

                else
                    entry.reforged = true
                end
            end

            for k,v in pairs(stats) do
                if Reforgenator.constants.ITEM_STATS[k] then
                    entry[k] = v
                end
            end

            soln.items[#soln.items + 1] = entry
        end
    end

    self:Explain("Player stats as calculated before reforging:")
    self:ExplainPlayerModel(playerModel)
    self:Explain("-----")

    for _,entry in ipairs(model.reforgeOrder) do
        self:Debug("### entry.cap=" .. to_string(entry.cap))
        local f = c.STAT_CAPS[entry.cap]
        if f then
            soln = self:OptimizeSolution(playerModel, entry.rating, f(playerModel, entry.userdata),
                                        model.statWeights, entry.mustBeOver, entry.preferSpirit, entry.preferExpertise, soln)
        end
    end

    -- Go through the list and copy the changes except those that were reforged in the sandbox and wound
    -- up in the same place as they started
    local effectiveChanges = {}
    for k,v in ipairs(soln.changes) do
        self:Debug("sandboxed=" .. to_string(v.sandboxed))
        if v.sandboxed then
            self:Debug("oldReforgedFrom=" .. v.oldReforgedFrom .. ", reforgedFrom=" .. v.reforgedFrom)
            self:Debug("oldReforgedTo=" .. v.oldReforgedTo .. ", reforgedTo=" .. v.reforgedTo)
            if v.reforgedFrom ~= v.oldReforgedFrom or v.reforgedTo ~= v.oldReforgedTo then
                effectiveChanges[#effectiveChanges + 1] = v
            end
        else
            effectiveChanges[#effectiveChanges + 1] = v
        end
    end

    -- see if there is anything that was previously reforged that should be reset
    for k,v in pairs(soln.items) do
        if v.sandboxed then
            local reset = true
            for ik,iv in pairs(soln.changes) do
                if iv.itemLink == v.itemLink then
                    reset = nil
                    break
                end
            end

            if reset then
                self:Debug("### undo old reforge on " .. v.itemLink)
                effectiveChanges[#effectiveChanges + 1] = v
            end
        end
    end

    -- Populate the window with the things to change
    if #effectiveChanges == 0 then
        self:MessageBox("Reforgenator has no suggestions for your gear")
    else
        for k,v in ipairs(effectiveChanges) do
            self:Debug("changed: " .. to_string(v))
        end
    end

    self:Explain("Player stats as calculated after reforging:")
    self:ExplainPlayerModel(playerModel)
    self:Explain("-----")

    self.changes = effectiveChanges
    self:UpdateWindow()
    self:ShowExplanation()

    self:Debug("all done")
end

function Reforgenator:PotentialLossFromStat(item, stat)
    local pool = item[stat]
    local potentialLoss = math.floor(pool * 0.4)
    return potentialLoss
end

function Reforgenator:CalculateScalingFromDR(playerModel, stat)
    local c = Reforgenator.constants

    if not c.AVOIDANCE_C[stat] or not c.AVOIDANCE_C[stat][playerModel.class] then
        return 1
    end

    local one_over_c = c.AVOIDANCE_C[stat][playerModel.class]
    local k = c.AVOIDANCE_K[playerModel.class]
    local x = playerModel.stats[stat] / c.RATING_CONVERSIONS[stat]

    local one_over_x_prime = one_over_c + (k / x)

    return 1.0 / (x * one_over_x_prime)
end

function Reforgenator:GetBestReforge(playerModel, item, stat, excessRating, statWeights)
    local c = Reforgenator.constants

    if item.itemLevel < 200 then
        self:Debug("### can't reforge " .. item.itemLink .. " as it's too low level")
        return nil
    end

    if item.reforged then
        self:Debug("### can't reforge " .. item.itemLink .. " as it's already reforged")
        return nil
    end

    -- EP is a pseudo-stat that means whatever is the highest weighted stat
    -- not already on the item
    self:Debug("### stat="..to_string(stat))
    if stat == CR_EP then
        self:Debug("### reforging for EP")
        local allStats = self:deepCopy(c.ITEM_STATS)
        for k,v in pairs(item) do
            allStats[k] = nil
        end

        local bestWeight, bestStat = 0, nil
        for k,v in pairs(allStats) do
            local w = (statWeights[k] or 0) * self:CalculateScalingFromDR(playerModel, k)
            if excessRating[k] then
                w = 0
            end

            if w > bestWeight then
                bestWeight = w
                bestStat = k
            end
        end

        if not bestStat then
            self:Debug("### no stats suitable for EP")
            return nil
        end

        self:Debug("### best EP stat = " .. bestStat)
        stat = bestStat
    end

    if item[stat] then
        self:Debug("### item " .. item.itemLink .. " already has stat")
        return nil
    end

    local candidates = {}

    self:Debug("### inspecting item " .. item.itemLink)
    for k,v in pairs(item) do
        if c.ITEM_STATS[k] then
            local delta = self:PotentialLossFromStat(item, k)

            local cost = delta * (statWeights[k] or 0) * self:CalculateScalingFromDR(playerModel, k)

            local gain = delta * (statWeights[stat] or 0) * self:CalculateScalingFromDR(playerModel, stat)

            entry = 
			{
                ["stat"] = k,
                ["cost"] = cost,
                ["gain"] = gain,
                ["delta"] = delta,
            }

            -- See if this item would be affected by any of the excess rating constraints
            local usingExcessRating = nil
            local canReforge = true
            if not playerModel.statEffectMap[k] then
                self:Debug("### stat[" .. k .. "] has no presence in playerModel.statEffectMap")
            end
            if playerModel.statEffectMap[k] then
                for _,v in ipairs(playerModel.statEffectMap[k]) do
                    if excessRating[v] then
                        usingExcessRating = true
                        if delta > excessRating[v] then
                            canReforge = nil
                            break
                        end
                    end
                end
            end

            if canReforge then
                if usingExcessRating then
                    entry.cost = 0
                end

                -- don't ever reforge spirit to spell hit if there's a spirit/hit conversion
				-- don't ever reforge Expertise to hit if there is a ep/hit conversion
                if stat == "ITEM_MOD_HIT_RATING_SHORT" and k == "ITEM_MOD_SPIRIT_SHORT" and playerModel.spiritHitConversionRate then
                    self:Debug("### not reforging spirit to hit")
				elseif stat =="ITEM_MOD_HIT_RATING_SHORT" and k == "ITEM_MOD_EXPERTISE_RATING_SHORT" and playerModel.expHitConversionRate then
					self:Debug("### not reforging Expertise to hit")
                else
                    candidates[#candidates + 1] = entry
                end
            end
        end
    end
    self:Debug("### candidates=" .. to_string(candidates))

    if #candidates == 0 then
        self:Debug("### can't reforge " .. item.itemLink .. " as it has no reforgable attributes")
        return nil
    end

    table.sort(candidates, function(a, b)
        local delta_ep_a = a.gain - a.cost
        local delta_ep_b = b.gain - b.cost
        return delta_ep_a > delta_ep_b or (delta_ep_a == delta_ep_b and a.delta > b.delta)
    end)

    self:Debug("### " .. candidates[1].stat .. " is best reforgable stat")

    return 
	{
        item = item,
        reforgeFrom = candidates[1].stat,
        reforgeTo = stat,
        delta = candidates[1].delta
    }
end

function Reforgenator:ReforgeItem(playerModel, suggestion, excessRating)
    local result = {}
    local st = suggestion.reforgeTo
    local sf = suggestion.reforgeFrom

    for k,v in pairs(suggestion.item) do
        result[k] = v
    end
    result.reforged = true
    result.reforgedFrom = sf
    result.reforgedTo = st

    result[st] = suggestion.delta
    result[sf] = result[sf] - suggestion.delta

    playerModel:UpdateStats(sf, st, suggestion.delta)

    if playerModel.statEffectMap[sf] then
        for _,v in ipairs(playerModel.statEffectMap[sf]) do
            if excessRating[v] then
                local delta = suggestion.delta
                if sf == "ITEM_MOD_SPIRIT_SHORT"
                        and v == CR_HIT_SPELL
                        and playerModel.spiritHitConversionRate then
                    delta = math.floor(delta * playerModel.spiritHitConversionRate)
                end
				if sf == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                        and v == CR_HIT_SPELL
                        and playerModel.expHitConversionRate then
                    delta = math.floor(delta * playerModel.expHitConversionRate)
                end
                excessRating[v] = excessRating[v] - delta
            end
        end
    end

    return result
end

function Reforgenator:GetBestReforgeList(playerModel, itemList, rating, excessRating, statWeights, preferSpirit, preferExpertise)
    local c = Reforgenator.constants
    local unforged = {}
    for k,v in ipairs(itemList) do
        local choices = {}

        if rating == CR_EP then
            local suggestion = self:GetBestReforge(playerModel, v, rating, excessRating, statWeights)

            if suggestion and playerModel:isEnhShaman() and rating == CR_HIT_SPELL and suggestion.reforgeTo == "ITEM_MOD_SPIRIT_SHORT" then
                suggestion = nil
            end


            if suggestion then
                if suggestion.reforgeFrom == "ITEM_MOD_HIT_RATING_SHORT" and rating == CR_HIT_SPELL then
                    self:Debug("### not reforging hit to hit via spirit")
                else
                    choices[#choices + 1] = suggestion
                end
            end
        end

        for attribute,affectedRatingList in pairs(playerModel.statEffectMap) do
            for _,iv in ipairs(affectedRatingList) do
                if iv == rating then
                    local suggestion = self:GetBestReforge(playerModel, v, attribute, excessRating, statWeights)

                    if suggestion and playerModel:isEnhShaman() and rating == CR_HIT_SPELL and suggestion.reforgeTo == "ITEM_MOD_SPIRIT_SHORT" then
                        suggestion = nil
                    end


                    if suggestion then
                        if suggestion.reforgeFrom == "ITEM_MOD_HIT_RATING_SHORT" and rating == CR_HIT_SPELL then
                            self:Debug("### not reforging hit to hit via spirit")
                        else
                            choices[#choices + 1] = suggestion
                        end
                    end
                end
            end
        end

        if #choices > 0 then
            -- figure out which one of these is better based on the size of the expected gain
            table.sort(choices, function(a,b)
                local a_delta = a.delta
                if rating == CR_HIT_SPELL
                        and a.reforgeTo == "ITEM_MOD_SPIRIT_SHORT"
                        and playerModel.spiritHitConversionRate then
                    a_delta = math.floor(a_delta * playerModel.spiritHitConversionRate)
                end

                local b_delta = b.delta
                if rating == CR_HIT_SPELL
                        and b.reforgeTo == "ITEM_MOD_SPIRIT_SHORT"
                        and playerModel.spiritHitConversionRate then
                    b_delta = math.floor(b_delta * playerModel.spiritHitConversionRate)
                end

                if a_delta > b_delta then
                    return true
                end

                if a_delta < b_delta then
                    return nil
                end

                return (preferSpirit and a.reforgeTo == "ITEM_MOD_SPIRIT_SHORT") or (not preferSpirit and a.reforgeTo == "ITEM_MOD_HIT_RATING_SHORT")
            end)
			
			table.sort(choices, function(c,d)
                local c_delta = c.delta
                if rating == CR_HIT_SPELL
                        and c.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                        and playerModel.expHitConversionRate then
                    c_delta = math.floor(c_delta * playerModel.expHitConversionRate)
                end

                local d_delta = d.delta
                if rating == CR_HIT_SPELL
                        and d.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                        and playerModel.expHitConversionRate then
                    d_delta = math.floor(d_delta * playerModel.expHitConversionRate)
                end

                if c_delta > d_delta then
                    return true
                end

                if c_delta < d_delta then
                    return nil
                end

                return (preferExpertise and c.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT") or (not preferExpertise and c.reforgeTo == "ITEM_MOD_HIT_RATING_SHORT")
            end)

            self:Debug("### sorted choices are " .. to_string(choices))

            unforged[#unforged + 1] = choices[1]
        end
    end

    table.sort(unforged, function(a, b) return a.delta > b.delta end)
	table.sort(unforged, function(c, d) return c.delta > d.delta end)
	
    return unforged
end

function Reforgenator:OptimizeSolution(playerModel, rating, desiredValue, statWeights, mustBeOver, preferSpirit, preferExpertise, ancestor)
    local c = Reforgenator.constants
    self:Explain("reforging for " .. c.RATING_NAMES[rating] .. ", starting at " .. playerModel.playerStats[rating])
    if rating == CR_HIT_SPELL then
        self:Explain("prefer spirit = " .. to_string(preferSpirit))
    end

    soln = SolutionContext:new()

    for k,v in pairs(ancestor.excessRating) do
        soln.excessRating[k] = v
    end
    for k,v in ipairs(ancestor.changes) do
        soln.changes[#soln.changes + 1] = v
    end

    -- nil desiredValue means maintain the current level
    if not desiredValue then
        self:Explain("retaining rating at current value")
        soln.excessRating[rating] = 0
        for k,v in ipairs(ancestor.items) do
            soln.items[#soln.items + 1] = v
        end
        return soln
    end

    -- already over cap?
    local overCap = nil
    local amountOverCap = nil
    if type(desiredValue) == "table" then
        local vec = self:deepCopy(desiredValue)
        table.sort(vec, function(a, b) return a > b end)
        self:Explain("maximum plateau rating is " .. vec[1])
        if playerModel.playerStats[rating] > vec[1] then
            overCap = true
            amountOverCap = playerModel.playerStats[rating] - vec[1]
        end
    else
        self:Explain("desired value is " .. desiredValue)
        if playerModel.playerStats[rating] > desiredValue then
            overCap = true
            amountOverCap = playerModel.playerStats[rating] - desiredValue
        end
    end
    if overCap then
        soln.excessRating[rating] = amountOverCap
        self:Explain("currently over cap for this rating by " .. soln.excessRating[rating])
        for k,v in ipairs(ancestor.items) do
            soln.items[#soln.items + 1] = v
        end
        return soln
    end

    -- If we are coming back to try to hit a hard cap, we might have
    -- previously said we had an excess of our now-desired rating, so
    -- clear it out
    if soln.excessRating[rating] then
        self:Debug("### zeroing out previous excess for rating")
        soln.excessRating[rating] = nil
    end

    -- "desiredValue" might be a list of break points instead of a single
    -- value. Reforge to get as far up the list as possible, but any
    -- past a break point that we can avoid reforging is a win
    if type(desiredValue) == "table" then
        vec = self:deepCopy(desiredValue)
        table.sort(vec, function(a, b) return a > b end)
        self:Debug("### vec=" .. to_string(vec))

        -- figure out what the max we can reach is. As a simplifying assumption we'll assume we don't have
        -- any excess rating anywhere
        local excess = {}
        for k,v in pairs(soln.excessRating) do
            excess[k] = 0
        end
        local itemList = self:deepCopy(ancestor.items)
        local unforged = self:GetBestReforgeList(playerModel, itemList, rating, excess, statWeights, preferSpirit, preferExpertise)
        local val = playerModel.playerStats[rating]
        for k,v in ipairs(unforged) do
            local delta = v.delta
            if rating == CR_HIT_SPELL
                    and v.reforgeTo == "ITEM_MOD_SPIRIT_SHORT"
                    and playerModel.spiritHitConversionRate then
                delta = math.floor(delta * playerModel.spiritHitConversionRate)
				
			elseif rating == CR_HIT_SPELL
                    and v.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                    and playerModel.expHitConversionRate then
                delta = math.floor(delta * playerModel.expHitConversionRate)
            end

            val = val + delta
        end
        self:Debug("### assume max reforged =" .. val)

        while vec[1] and vec[1] > val do
            self:Debug("### is it bigger than " .. vec[1] .. "?")
            table.remove(vec, 1)
        end

        if not vec[1] then
            self:Debug("### can't reach first breakpoint ... go for max we can reach")
            vec[1] = val
        end

        self:Debug("### pretend cap is now " .. vec[1])
        desiredValue = vec[1]
    end

    -- pass 1: reforge from biggest to smallest that will fit under the cap
    self:Debug("### rating="..to_string(rating))
    local itemList = self:deepCopy(ancestor.items)
    while true do
        local unforged = self:GetBestReforgeList(playerModel, itemList, rating, soln.excessRating, statWeights, preferSpirit, preferExpertise)
        if #unforged == 0 then
            break
        end

        local v = unforged[1]

        local delta = v.delta
            if rating == CR_HIT_SPELL then
				if v.reforgeTo == "ITEM_MOD_SPIRIT_SHORT"
                    and playerModel.spiritHitConversionRate then
						delta = math.floor(delta * playerModel.spiritHitConversionRate)
				elseif v.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                    and playerModel.expHitConversionRate then
						delta = math.floor(delta * playerModel.expHitConversionRate)
				end
			end

        -- Reforge the largest items that will fit under the cap
        if playerModel.playerStats[rating] + delta < desiredValue then
            v.item = self:ReforgeItem(playerModel, v, soln.excessRating)
            soln.changes[#soln.changes + 1] = v.item
            soln.items[#soln.items + 1] = v.item

            itemList = self:removeIf(itemList, function(a) return a.itemLink == v.item.itemLink end)
        else
            break
        end
    end
    self:Debug("### after first pass unforged=" .. to_string(itemList))

    -- pass 2: find the smallest remaining item that will just meet or exceed the cap and reforge it
    if #itemList > 0 then
        local under = math.abs(desiredValue - playerModel.playerStats[rating])
        local unforged = self:GetBestReforgeList(playerModel, itemList, rating, soln.excessRating, statWeights, preferSpirit, preferExpertise)
        for n = #unforged, 1, -1 do
            local v = unforged[n]

            local delta = v.delta
            if rating == CR_HIT_SPELL then
				if v.reforgeTo == "ITEM_MOD_SPIRIT_SHORT"
                    and playerModel.spiritHitConversionRate then
						delta = math.floor(delta * playerModel.spiritHitConversionRate)
				elseif v.reforgeTo == "ITEM_MOD_EXPERTISE_RATING_SHORT"
                    and playerModel.expHitConversionRate then
						delta = math.floor(delta * playerModel.expHitConversionRate)
				end
			end

            if playerModel.playerStats[rating] + delta >= desiredValue then
                local over = math.abs(desiredValue - (playerModel.playerStats[rating] + delta))
                if under > over or mustBeOver then
                    v.item = self:ReforgeItem(playerModel, v, soln.excessRating)
                    soln.changes[#soln.changes + 1] = v.item
                    soln.items[#soln.items + 1] = v.item
                    itemList = self:removeIf(itemList, function(a) return a.itemLink == v.item.itemLink end)
                end
                break
            end
        end
    end
    self:Debug("### after second pass unforged=" .. to_string(itemList))

    self:Explain("ending up at " .. playerModel.playerStats[rating])

    for k,v in ipairs(itemList) do
        soln.items[#soln.items + 1] = v
    end

    -- And now we don't have any excess of this rating
    if not soln.excessRating then
        soln.excessRating = {}
    end
    soln.excessRating[rating] = 0

    self:Explain("-----")
    return soln
end
