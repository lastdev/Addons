local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Data = Addon:GetModule("Data")

---@type KAF_DataSource
local Source = {
  Name = "DecorAchievements",
  Items = {},
}

function Source:Init(ctx)
  self.Items = {
    971,
    {
        ctx.L["Khamul's House Decor Achievement List"],
        GetHousingClassic(),
        GetHousingWotLk(),
        GetHousingMoP(),
        GetHousingWoD(),
        GetHousingLegion(),
        GetHousingBfA(),
        GetHousingSL(),
        GetHousingDF(),
        GetHousingTWW(),
        GetHousingMN(),
        GetHousingPvP()
    }
  }
end

function Source:Rebuild()
  self.Items = {
    971,
    {
        self.ctx.L["Khamul's House Decor Achievement List"],
        GetHousingClassic(),
        GetHousingWotLk(),
        GetHousingMoP(),
        GetHousingWoD(),
        GetHousingLegion(),
        GetHousingBfA(),
        GetHousingSL(),
        GetHousingDF(),
        GetHousingTWW(),
        GetHousingMN(),
        GetHousingPvP()
    }
  }
end

function Source:GetItems()
  return self.Items
end

Data:RegisterSource(Source)
