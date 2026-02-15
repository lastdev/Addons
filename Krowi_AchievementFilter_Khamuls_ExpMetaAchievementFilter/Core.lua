local ADDON_NAME = ...

local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local defaults = {
  profile = {
    metaAchievementsEnabled = true,
    decorAchievementsEnabled = true,
    decorAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true
    },
    campsiteAchievementsEnabled = true,
    campsiteAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true
    },
    petAchievementsEnabled = true,
    petAchievementsSettings = {
      flattenStructure = false,
      includeChildAchievements = true,
      includePetRelatedStuff = true,
    }
  },
}

-- Dependency check
function KhamulsAchievementFilter:IsKrowiAFAvailable()
  if _G.KrowiAF then
    return true
  end

  return false
end

function KhamulsAchievementFilter:OnInitialize()
    -- Initialize AceDB
  self.db = LibStub("AceDB-3.0"):New("Khamuls_ExpMetaAchievementFilter_Settings", defaults, true)
  -- Initialize AceConfig
  if self.InitOptions then
    self:InitOptions()
  end

  self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
end

function KhamulsAchievementFilter:OnEnable()
  -- Get modules explicitly and fail fast with a clear error.
  local Utilities = self:GetModule("Utilities", true)
  if not Utilities then
    self:Print("ERROR: Module 'Utilities' is missing. Check your .toc load order and file paths.")
    return
  end
  self.Utilities = Utilities

  local Data = self:GetModule("Data", true)
  if not Data then
    self:Print("ERROR: Module 'Data' is missing. Check your .toc load order and file paths.")
    return
  end
  self.Data = Data
end

function KhamulsAchievementFilter:OnPlayerLogin()
  if not self:IsKrowiAFAvailable() then
    self:Print("Krowi's Achievement Filter Addon not loaded!")
    return
  end

  local Data = self:GetModule("Data", true)
  if Data and Data.InitSources then
      Data:InitSources()
  end

  if self.db.profile.metaAchievementsEnabled then
     KrowiAF.CategoryData.KhamulsExpansionMetaAchievementLists = self.Data:GetSource("MetaAchievements"):GetItems()
  end

  if self.db.profile.decorAchievementsEnabled then
     KrowiAF.CategoryData.KhamulsHousingDecorAchievementLists = self.Data:GetSource("DecorAchievements"):GetItems()
  end

  if self.db.profile.campsiteAchievementsEnabled then
     KrowiAF.CategoryData.KhamulsWarbandCampsiteAchievementLists = self.Data:GetSource("CampsiteAchievements"):GetItems()
  end

  if self.db.profile.petAchievementsEnabled then
     KrowiAF.CategoryData.KhamulsPetAchievementLists = self.Data:GetSource("PetAchievements"):GetItems()
  end
end
