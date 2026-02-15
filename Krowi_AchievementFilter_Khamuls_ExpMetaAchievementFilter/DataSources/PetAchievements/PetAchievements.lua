local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Data = Addon:GetModule("Data")

---@type KAF_DataSource
local Source = {
  Name = "PetAchievements",
  Items = {},
}

function Source:Init(ctx)
  self.Items = {
    971,
    {
        ctx.L["Khamul's Battle Pet Achievement List"],
        GetCrossExpansionPetAchievements(),
        GetClassicPetAchievements(),
        GetTBCPetAchievements(),
        GetWotLKPetAchievements(),
        GetCataPetAchievements(),
        GetMoPPetAchievements(),
        GetWoDPetAchievements(),
        GetLegionPetAchievements(),
        GetBfaPetAchievements(),
        GetSLPetAchievements(),
        GetDFPetAchievements(),
        GetTWWPetAchievements(),
        GetMNPetAchievements(),
        GetFeatsOfStrengthAndLegacyPetAchievements(),
        GetPlayerVsPlayerPetAchievements(),
    }
  }
end

function Source:Rebuild()
  self.Items = {
    971,
    {
        self.ctx.L["Khamul's Battle Pet Achievement List"],
        GetCrossExpansionPetAchievements(),
        GetClassicPetAchievements(),
        GetTBCPetAchievements(),
        GetWotLKPetAchievements(),
        GetCataPetAchievements(),
        GetMoPPetAchievements(),
        GetWoDPetAchievements(),
        GetLegionPetAchievements(),
        GetBfaPetAchievements(),
        GetSLPetAchievements(),
        GetDFPetAchievements(),
        GetTWWPetAchievements(),
        GetMNPetAchievements(),
        GetFeatsOfStrengthAndLegacyPetAchievements(),
        GetPlayerVsPlayerPetAchievements(),
    }
  }
end

function Source:GetItems()
  return self.Items
end

Data:RegisterSource(Source)
