local DS = LibStub("AceAddon-3.0"):GetAddon("Doom Shards", true)
if not DS then return end


---------------
-- Libraries --
---------------
local L = LibStub("AceLocale-3.0"):GetLocale("DoomShards")


--------------
-- Upvalues --
--------------
local exp = exp
local GetActiveSpecGroup = GetActiveSpecGroup
local GetHaste = GetHaste
local GetTime = GetTime
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local GetSpellCritChance = GetSpellCritChance
local GetSpecialization = GetSpecialization
local GetSpellInfo = GetSpellInfo
local GetTalentInfo = GetTalentInfo
local IsEquippedItem = IsEquippedItem
local sqrt = sqrt
local pairs = pairs
local rawget = rawget
local rawset = rawset
local setmetatable = setmetatable
local tonumber = tonumber
local UnitBuff = UnitBuff
local UnitGUID = UnitGUID


-------------
-- Utility --
-------------
local getHasteMod = DS.GetHasteMod
local buildHastedIntervalFunc = DS.BuildHastedIntervalFunc
local buildUnhastedIntervalFunc = DS.BuildUnhastedIntervalFunc
local pandemicFunc = DS.PandemicFunc


-----------
-- Specs --
-----------
-- Dummy Spec (used for Test Mode)
DS:AddSpecSettings(-1,
  {
  },
  {
    [-1] = {
      duration = 10,
      tickLength = 10,
      resourceChance = 1,
    }
  },
  {
    referenceSpell = 5782  -- Fear (a spell every warlock spec has)
  }
)

-- Affliction
do
  local BASE_AVERAGE_ACCUMULATOR_INCREASE = 0.16
  local BASE_AVERAGE_ACCUMULATOR_RESET_VALUE = 0.5

  DS.agonyAccumulator = BASE_AVERAGE_ACCUMULATOR_RESET_VALUE
  DS.globalNextAgony = {}
  DS.globalAppliedAgonies = {}
  local spellEnergizeFrame = CreateFrame("Frame")
  spellEnergizeFrame:Show()
  spellEnergizeFrame:SetScript("OnEvent", function(self, _, _, event, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellID)
    if event == "SPELL_ENERGIZE" and spellID == 17941 and sourceGUID == UnitGUID("player") and DS.agonyAccumulator then
      DS.agonyAccumulator = BASE_AVERAGE_ACCUMULATOR_RESET_VALUE - DS.globalNextAgony.aura.resourceChance  -- SPELL_ENERGIZE fire before respective SPELL_DAMAGE from Agony
    end
  end)

  local function setGlobalNextAgony()
    local globalNextAgonyTick
    local globalNextAgonyAura
    for aura in pairs(DS.globalAppliedAgonies) do
      local nextTick = aura.nextTick
      if not globalNextAgonyTick or nextTick < globalNextAgonyTick then
        globalNextAgonyTick = nextTick
        globalNextAgonyAura = aura
      end
    end
    DS.globalNextAgony.tick = globalNextAgonyTick
    DS.globalNextAgony.aura = globalNextAgonyAura
  end

  -- Unstable Affliction template (there are 5 different UA debuff IDs)
  local function unstableAfflictionTemplate()
    return {  -- Unstable Affliction
      durationFunc = buildHastedIntervalFunc(8),
      pandemic = 0,
      tickLengthFunc = buildHastedIntervalFunc(8),
      resourceChance = 1,
      hasInitialTick = false,
      nameIsShared = true,
      IterateTick = function(self, timeStamp)
        if timeStamp then
          local expiration = self.expiration
          local iteratedTick = timeStamp + self.tickLength
          local isLastTick = iteratedTick >= expiration
          local resourceChance = (expiration - self.nextTick) / self.duration
          return isLastTick and expiration or iteratedTick, resourceChance, isLastTick
        else
          local isLastTick = self.nextTick >= self.expiration
          return isLastTick and self.expiration or self.nextTick, self.resourceChance, isLastTick
        end
      end,
      OnRefresh = function(self)
        self:Tick()
      end,
    }
  end

  DS:AddSpecSettings(265,
    {
      [27243] = -1,  -- Seed of Corruption
      [18540] = -1,  -- Summon Doomguard
      [688] = -1,  -- Summon Imp
      [1122] = -1,  -- Summon Infernal
      [691] = -1,  -- Summon Felhunter
      [712] = -1,  -- Summon Succubus
      [697] = -1,  -- Summon Voidwalker
      [30108] = -1  -- Unstable Affliction
    },
    {
      [980] = {  -- Agony
        durationFunc = function(self)
          local duration = 18
          local FOTDS_ID = 124522  -- Fragment of the Dark Star
          if IsEquippedItem(FOTDS_ID) then
            local ilink
            if GetInventoryItemID("player", 13) == FOTDS_ID then
              ilink = GetInventoryItemLink("player", 13)
            else
              ilink = GetInventoryItemLink("player", 14)
            end
            local _, _, _, ilvl = GetItemInfo(ilink)
            duration = -1.183E-4 * ilvl*ilvl + 0.141 * ilvl - 25.336
          end
          if IsEquippedItem(132394) then  -- Hood of Eternal Disdain
            duration = duration / 1.1
          end
          duration = duration * DS.globalTimeMod
          return duration
        end,
        pandemicFunc = pandemicFunc,
        tickLengthFunc = function(self)
          local ticks = 9
          return self.duration / ticks
        end,
        resourceChanceFunc = function(self)
          return (BASE_AVERAGE_ACCUMULATOR_INCREASE / sqrt(DS.agonyCounter or 1)) / BASE_AVERAGE_ACCUMULATOR_RESET_VALUE
        end,
        refreshEvent = "SPELL_CAST_SUCCESS",
        IterateTick = function(self, timeStamp)
          if timeStamp then
            local expiration = self.expiration
            local iteratedTick = timeStamp + self.tickLength
            local isLastTick = iteratedTick >= expiration
            return isLastTick and expiration or iteratedTick, self.resourceChance, isLastTick
          else
            local nextTick = self.nextTick
            local resourceChance = (DS.globalNextAgony.aura == self) and (DS.agonyAccumulator) or (self.resourceChance)
            return nextTick, resourceChance, nextTick >= self.expiration
          end
        end,
        Refresh = function(self)
          self.expiration = DS.CalculateExpiration(self)  -- SPELL_CAST_SUCCESS triggers before aura is applied -> setExpiration can't be used
          self:OnRefresh()
        end,
        OnApply = function(self)
          if not DS.agonyCounter then
            spellEnergizeFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
          end
          DS.agonyCounter = (DS.agonyCounter or 0) + 1
          DS.globalAppliedAgonies[self] = true
          setGlobalNextAgony()
        end,
        OnTick = function(self)
          DS.agonyAccumulator = DS.agonyAccumulator + self.resourceChance
          setGlobalNextAgony()
        end,
        OnRemove = function(self)
          if DS.globalAppliedAgonies[self] then
            DS.globalAppliedAgonies[self] = nil
            DS.agonyCounter = DS.agonyCounter - 1
            if DS.agonyCounter <= 0 then
              DS.agonyCounter = nil
              spellEnergizeFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
            setGlobalNextAgony()
          end
        end
      },
      [233490] = unstableAfflictionTemplate(),
      [233496] = unstableAfflictionTemplate(),
      [233497] = unstableAfflictionTemplate(),
      [233498] = unstableAfflictionTemplate(),
      [233499] = unstableAfflictionTemplate(),
    },
    {
      referenceTime = 2  -- 2 ticks of Drain Life
    }
  )
end

-- Demonology
do
  local demonicCallingString = GetSpellInfo(205146)
  DS:AddSpecSettings(266,
    {
      [104316] = function()  -- Call Dreadstalkers  -- TODO: possibly cache and update on event
        local generates = -2
        if UnitBuff("player", demonicCallingString) then
          generates = generates + 2
        end
        if IsEquippedItem(132393) then  -- Recurrent Ritual
          generates = generates + 2
        end
        return generates
      end,
      [157695] = 1,  -- Demonbolt
      [105174] = -4,  -- Hand of Gul'dan
      [686] = 1,  -- Shadow Bolt
      [18540] = -1,  -- Summon Doomguard
      [688] = -1,  -- Summon Imp
      [1122] = -1,  -- Summon Infernal
      [30146] = -1,  -- Summon Felguard
      [691] = -1,  -- Summon Felhunter
      [712] = -1,  -- Summon Succubus
      [697] = -1,  -- Summon Voidwalker
    },
    {
      [603] = {  -- Doom
        durationFunc = function(self)
          baseDuration = 20
          local _, _, _, _, selected = GetTalentInfo(2, 1, GetActiveSpecGroup())
          if selected then
            baseDuration = baseDuration - 3
          end
          return baseDuration / getHasteMod() * DS.globalTimeMod
        end,
        pandemicFunc = pandemicFunc,
        tickLengthFunc = function(self)
          return self.duration
        end,
        resourceChance = 1,
        hasInitialTick = false,
        IterateTick = function(self, timeStamp)
          if timeStamp then
            local expiration = self.expiration
            local iteratedTick = timeStamp + self.tickLength
            local isLastTick = iteratedTick >= expiration
            local resourceChance = ((isLastTick and expiration or iteratedTick) - timeStamp) / self.duration
            return isLastTick and expiration or iteratedTick, resourceChance, isLastTick
          else
            local isLastTick = self.nextTick >= self.expiration
            return isLastTick and self.expiration or self.nextTick, self.resourceChance, isLastTick
          end
        end
      }
    },
    {
      referenceSpell = 105174  -- Shadow Bolt
    }
  )
end

-- Destruction
DS:AddSpecSettings(267,
  {
    [116858] = -2,  -- Chaos Bolt
    [5740] = -3,  -- Rain of Fire
    [18540] = -1,  -- Summon Doomguard
    [688] = -1,  -- Summon Imp
    [1122] = -1,  -- Summon Infernal
    [691] = -1,  -- Summon Felhunter
    [712] = -1,  -- Summon Succubus
    [697] = -1,  -- Summon Voidwalker
  },
  {
    --[[[348] = {  -- Immolate  -- ID 157736 for DoT
      duration = 15,
      tickLengthFunc = buildHastedIntervalFunc(3),
      resourceChanceFunc = function(self)  -- TODO: Implement artifact traits (Burning Hunger)
        return (1 + GetSpellCritChance()/100) * 0.15
      end
    },]]--
    [17877] = {   -- Shadowburn
      durationFunc = buildUnhastedIntervalFunc(5),
      pandemic = 0,
      tickLengthFunc = buildUnhastedIntervalFunc(5),
      resourceChance = 1,
      IterateTick = function(self, timeStamp)
        return self.nextTick, self.resourceChance, true
      end,
      OnRefresh = function(self)
        self:Tick()
      end
    }
  },
  {
    referenceSpell = 29722  -- Incinerate
  }
)


-------------
-- Options --
-------------
local function specializationsOptions()
  return {
    order = 3,
    type = "group",
    name = L["Specializations"],
    childGroups = "select",
    cmdHidden  = true,
    get = function(info)
      local optionName = tonumber(info[#info]) or info[#info]  -- To avoid converting to numbers in event code later on
      return DS.db.specializations[optionName]
    end,
    set = function(info, value)
      local optionName = tonumber(info[#info]) or info[#info]
      DS.db.specializations[optionName] = value;
      DS:Build()
    end,
    args = {
      headerAffliction = {
        order = 1,
        name = L["Affliction"],
        type = "header"
      },
      ["980"] = {
        order = 2,
        name = L["Track Agony"],
        type = "toggle"
      },
      ["233490"] = {
        order = 3,
        name = L["Track Unstable Affliction"],
        type = "toggle",
        set = function(info, value)  -- 5 different Unstable Affliction IDs
          DS.db.specializations[233490] = value
          DS.db.specializations[233496] = value
          DS.db.specializations[233497] = value
          DS.db.specializations[233498] = value
          DS.db.specializations[233499] = value
          DS:Build()
        end,
      },
      headerDemonology = {
        order = 10,
        name = L["Demonology"],
        type = "header"
      },
      ["603"] = {
        order = 11,
        name = L["Track Doom"],
        type = "toggle"
      },
      headerDestruction = {
        order = 20,
        name = L["Destruction"],
        type = "header"
      },
      ["17877"] = {
        order = 21,
        name = L["Track Shadowburn"],
        type = "toggle"
      },
    }
  }
end

local defaultSettings = {
  profile = {
    [980] = true,
    [233490] = true,
    [233496] = true,
    [233497] = true,
    [233498] = true,
    [233499] = true,
    [603] = true,
    [17877] = true,
  }
}

DS:AddDisplayOptions("specializations", specializationsOptions, defaultSettings)
