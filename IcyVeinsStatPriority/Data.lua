local addonName, IVSP = ...
local L = IVSP.L

local data = {
    -- 250 - Death Knight: Blood -- https://www.icy-veins.com/wow/blood-death-knight-pve-tank-stat-priority
    [250] = {
        {"Item Level > Haste > Critical Strike = Mastery > Versatility"},
    },
    -- 251 - Death Knight: Frost -- https://www.icy-veins.com/wow/frost-death-knight-pve-dps-stat-priority
    [251] = {
        {"Critical Strike > Mastery > Haste > Versatility"},
    },
    -- 252 - Death Knight: Unholy -- https://www.icy-veins.com/wow/unholy-death-knight-pve-dps-stat-priority
    [252] = {
        {"Haste > Mastery > Critical Strike > Versatility", "General"},
        {"Mastery > Critical Strike > Haste > Versatility", "AoE"},
    },

    -- 577 - Demon Hunter: Havoc -- https://www.icy-veins.com/wow/havoc-demon-hunter-pve-dps-stat-priority
    [577] = {
        {"Agility > Critical Strike > Haste > Mastery > Versatility", "Single Target"},
        {"Agility > Critical Strike > Mastery > Versatility > Haste", "AoE"},
    },
    -- 581 - Demon Hunter: Vengeance -- https://www.icy-veins.com/wow/vengeance-demon-hunter-pve-tank-stat-priority
    [581] = {
        {"Agility > Haste > Versatility = Critical Strike > Mastery"},
    },

    -- 102 - Druid: Balance -- https://www.icy-veins.com/wow/balance-druid-pve-dps-stat-priority
    [102] = {
        {"Intellect > Mastery > Haste > Critical Strike > Versatility"},
    },
    -- 103 - Druid: Feral -- https://www.icy-veins.com/wow/feral-druid-pve-dps-stat-priority
    [103] = {
        {"Agility > Critical Strike > Mastery > Haste > Versatility"},
    },
    -- 104 - Druid: Guardian -- https://www.icy-veins.com/wow/guardian-druid-pve-tank-stat-priority
    [104] = {
        {"Agility > Haste > Versatility > Mastery > Critical Strike", "Survivability"},
        {"Agility > Versatility = Haste > Critical Strike = Mastery", "Damage Output"},
    },
    -- Druid: Restoration -- https://www.icy-veins.com/wow/restoration-druid-pve-healing-stat-priority
    [105] = {
        {"Intellect > Haste > Mastery > Critical Strike = Versatility", "Raid Healing"},
        {"Intellect > Mastery = Haste > Versatility > Critical Strike", "Dungeon Healing"},
        {"Intellect > Haste > Versatility > Critical Strike > Mastery", "Dungeon Damage Dealing"},
    },

    -- Evoker: Devastation -- https://www.icy-veins.com/wow/devastation-evoker-pve-dps-stat-priority
    [1467] = {
        {"Intellect > Mastery > Haste > Critical Strike > Versatility"},
    },
    -- Evoker: Preservation -- https://www.icy-veins.com/wow/preservation-evoker-pve-healing-stat-priority
    [1468] = {
        {"Intellect > Mastery > Critical Strike > Versatility > Haste", "Raiding"},
        {"Intellect > Critical Strike > Haste > Versatility > Mastery", "Mythic+"},
    },

    -- 253 - Hunter: Beast Mastery -- https://www.icy-veins.com/wow/beast-mastery-hunter-pve-dps-stat-priority
    [253] = {
        {"Haste > Critical Strike > Mastery > Versatility"},
    },
    -- 254 - Hunter: Marksmanship -- https://www.icy-veins.com/wow/marksmanship-hunter-pve-dps-stat-priority
    [254] = {
        {"Mastery > Critical Strike > Versatility > Haste"},
    },
    -- 255 - Hunter: Survival -- https://www.icy-veins.com/wow/survival-hunter-pve-dps-stat-priority
    [255] = {
        {"Haste > Critical Strike > Versatility > Mastery"},
    },

    -- 62 - Mage: Arcane -- https://www.icy-veins.com/wow/arcane-mage-pve-dps-stat-priority
    [62] = {
        {"Intellect > Critical Strike > Mastery > Versatility > Haste"},
    },
    -- 63 - Mage: Fire -- https://www.icy-veins.com/wow/fire-mage-pve-dps-stat-priority
    [63] = {
        {"Intellect > Haste > Versatility > Mastery > Critical Strike"},
    },
    -- 64 - Mage: Frost -- https://www.icy-veins.com/wow/frost-mage-pve-dps-stat-priority
    [64] = {
        {"Intellect > Mastery > Haste > Critical Strike (to 33.34%) > Versatility"},
    },

    -- 268 - Monk: Brewmaster -- https://www.icy-veins.com/wow/brewmaster-monk-pve-tank-stat-priority
    [268] = {
        {"Agility > Versatility = Mastery = Critical Strike > Haste", "Defensive"},
        {"Agility > Versatility = Critical Strike > Mastery > Haste", "Offensive"},
    },
    -- 269 - Monk: Windwalker -- https://www.icy-veins.com/wow/windwalker-monk-pve-dps-stat-priority
    [269] = {
        {"Weapon Damage > Agility > Versatility = Critical Strike > Mastery > Haste"},
    },
    -- 270 - Monk: Mistweaver -- https://www.icy-veins.com/wow/mistweaver-monk-pve-healing-stat-priority
    [270] = {
        {"Intellect > Haste > Critical Strike = Mastery > Versatility", "Raid"},
        {"Intellect > Haste > Mastery > Versatility > Critical Strike", "Mythic+"},
    },

    -- 65 - Paladin: Holy -- https://www.icy-veins.com/wow/holy-paladin-pve-healing-stat-priority
    [65] = {
        {"Intellect > Haste > Mastery > Versatility > Critical Strike", "Raid"},
        {"Intellect > Haste > Versatility > Critical Strike > Mastery", "Mythic+"},
    },
    -- 66 - Paladin: Protection -- https://www.icy-veins.com/wow/protection-paladin-pve-tank-stat-priority
    [66] = {
        {"Haste ≥ Mastery ≥ Versatility > Critical Strike", "Defensive"},
    },
    -- 70 - Paladin: Retribution -- https://www.icy-veins.com/wow/retribution-paladin-pve-dps-stat-priority
    [70] = {
        {"Strength > Mastery > Haste ≈ Critical Strike > Versatility"},
    },

    -- 256 - Priest: Discipline -- https://www.icy-veins.com/wow/discipline-priest-pve-healing-stat-priority
    [256] = {
        {"Intellect > Haste > Critical Strike > Versatility > Mastery"},
    },
    -- 257 - Priest: Holy -- https://www.icy-veins.com/wow/holy-priest-pve-healing-stat-priority
    [257] = {
        {"Intellect > Mastery = Critical Strike > Versatility > Haste", "Raids"},
        {"Intellect > Critical Strike = Haste > Versatility > Mastery", "Dungeons"},
    },
    -- 258 - Priest: Shadow -- https://www.icy-veins.com/wow/shadow-priest-pve-dps-stat-priority
    [258] = {
        {"Intellect > Haste > Mastery > Critical Strike = Versatility"},
    },

    -- 259 - Rogue: Assassination -- https://www.icy-veins.com/wow/assassination-rogue-pve-dps-stat-priority
    [259] = {
        {"Critical Strike > Mastery > Haste > Versatility"},
    },
    -- 260 - Rogue: Outlaw -- https://www.icy-veins.com/wow/outlaw-rogue-pve-dps-stat-priority
    [260] = {
        {"Versatility > Critical Strike > Mastery > Haste"},
    },
    -- 261 - Rogue: Subtlety -- https://www.icy-veins.com/wow/subtlety-rogue-pve-dps-stat-priority
    [261] = {
        {"Critical Strike > Versatility > Haste > Mastery", "Single-Target"},
        {"Critical Strike > Versatility > Mastery > Haste", "Multi-Target"},
    },

    -- 262 - Shaman: Elemental -- https://www.icy-veins.com/wow/elemental-shaman-pve-dps-stat-priority
    [262] = {
        {"Intellect > Mastery > Haste > Versatility > Critical Strike", "Single-Target"},
        {"Intellect > Haste > Critical Strike > Versatility > Mastery", "Multi-Target"},
    },
    -- 263 - Shaman: Enhancement -- https://www.icy-veins.com/wow/enhancement-shaman-pve-dps-stat-priority
    [263] = {
        {"Agility > Mastery = Haste > Versatility > Critical Strike"},
    },
    -- 264 - Shaman: Restoration -- https://www.icy-veins.com/wow/restoration-shaman-pve-healing-stat-priority
    [264] = {
        {"Intellect > Versatility = Critical Strike > Haste = Mastery"},
    },

    -- 265 - Warlock: Affliction -- https://www.icy-veins.com/wow/affliction-warlock-pve-dps-stat-priority
    [265] = {
        {"Intellect > Mastery > Haste > Critical Strike > Versatility"},
    },
    -- 266 - Warlock: Demonology -- https://www.icy-veins.com/wow/demonology-warlock-pve-dps-stat-priority
    [266] = {
        {"Intellect > Haste > Critical Strike > Mastery ≈ Versatility", "Single-Target"},
        {"Intellect > Haste > Critical Strike ≈ Mastery > Versatility", "Multi-Target"},
    },
    -- 267 - Warlock: Destruction -- https://www.icy-veins.com/wow/destruction-warlock-pve-dps-stat-priority
    [267] = {
        {"Intellect > Haste ≥ Mastery > Critical Strike > Versatility", "Without tier set"},
        {"Intellect > Haste > Critical Strike > Versatility > Mastery", "With tier set"},
    },

    -- 71 - Warrior: Arms -- https://www.icy-veins.com/wow/arms-warrior-pve-dps-stat-priority
    [71] = {
        {"Strength > Critical Strike > Haste > Mastery > Versatility"},
    },
    -- 72 - Warrior: Fury -- https://www.icy-veins.com/wow/fury-warrior-pve-dps-stat-priority
    [72] = {
        {"Strength > Haste > Mastery > Critical Strike > Versatility"},
    },
    -- 73 - Warrior: Protection -- https://www.icy-veins.com/wow/protection-warrior-pve-tank-stat-priority
    [73] = {
        {"Strength > Haste > Versatility ≥ Critical Strike > Mastery"},
    },
}

local function LocalizeSP(text)
    -- localize
    text = string.gsub(text, "Haste", STAT_HASTE)
    text = string.gsub(text, "Critical Strike", STAT_CRITICAL_STRIKE)
    text = string.gsub(text, "Mastery", STAT_MASTERY)
    text = string.gsub(text, "Versatility", STAT_VERSATILITY)
    text = string.gsub(text, "Armor", STAT_ARMOR)
    text = string.gsub(text, "Stamina", ITEM_MOD_STAMINA_SHORT)
    text = string.gsub(text, "Strength", SPEC_FRAME_PRIMARY_STAT_STRENGTH)
    text = string.gsub(text, "Agility", SPEC_FRAME_PRIMARY_STAT_AGILITY)
    text = string.gsub(text, "Intellect", SPEC_FRAME_PRIMARY_STAT_INTELLECT)
    text = string.gsub(text, "Weapon Damage", DAMAGE_TOOLTIP)
    text = string.gsub(text, "Item Level", STAT_AVERAGE_ITEM_LEVEL)
    return text
end

function IVSP:GetSPText(specID)
    if not data[specID] then
        return L["No Specialization Selected"]
    end

    local selected = IVSP_Config["selected"][specID] or 1
    local text

    if selected > #data[specID] then -- isCustom
        if IVSP_Custom[specID] and IVSP_Custom[specID][selected - #data[specID]] then
            text = IVSP_Custom[specID][selected - #data[specID]][1]
        else -- data not exists
            IVSP_Config["selected"][specID] = 1
            selected = 1
        end
    else
        text = data[specID][selected][1]
    end

    text = LocalizeSP(text)
    return text
end

function IVSP:GetSPDesc(specID)
    local desc = {}
    if data[specID] then
        for _, t in pairs(data[specID]) do
            table.insert(desc, {t[2] or L["General"]})
        end
    end
    -- load custom
    if IVSP_Custom[specID] then
        for k, t in pairs(IVSP_Custom[specID]) do
            table.insert(desc, {t[2], k})
        end
    end
    return desc
end

function IVSP:GetSP(specID)
    local sp = {}

    -- load built-in
    for _, t in pairs(data[specID]) do
        tinsert(sp, (t[2] or L["General"]) .. ": " .. LocalizeSP(t[1]))
    end

    -- load custom
    if IVSP_Custom[specID] then
        for _, t in pairs(IVSP_Custom[specID]) do
            tinsert(sp, (t[2] or L["General"]) .. ": " .. LocalizeSP(t[1]))
        end
    end

    return sp
end