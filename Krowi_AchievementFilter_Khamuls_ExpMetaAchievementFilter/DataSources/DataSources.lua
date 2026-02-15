local ADDON_NAME = ...
local Addon = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

---@class KAF_DataSource
---@field Name string
---@field Items table
---@field ctx? table
---@field Init? fun(self: KAF_DataSource, ctx: table)
---@field Rebuild? fun(self: KAF_DataSource)
---@field GetItems? fun(self: KAF_DataSource): table

---@class KAF_DataModule : AceModule
---@field Sources table<string, KAF_DataSource>
local Data = Addon:NewModule("Data")

local function EnsureContext(self)
  if self.ctx then return end
  local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

  local Utilities = Addon:GetModule("Utilities", true)
  assert(Utilities, "Utilities module not loaded. Ensure Utilities.lua is listed before DataSources in the toc.")

  self.ctx = {
    Addon = Addon,
    Utilities = Utilities,
    L = L,
  }
end

function Data:OnInitialize()
    self.Sources = self.Sources or {}
end

---@param source KAF_DataSource
function Data:RegisterSource(source)
    assert(type(source) == "table", "Data:RegisterSource expects a table")
    assert(type(source.Name) == "string" and source.Name ~= "", "Source must have a Name")

    source.Items = source.Items or {}
    self.Sources = self.Sources or {}

    EnsureContext(self)

    source.ctx = self.ctx
    self.Sources[source.Name] = source
end

function Data:InitSources()
    if not self.Sources then return end
    EnsureContext(self)

    for _, source in pairs(self.Sources) do
        source.ctx = self.ctx

        if type(source.Init) == "function" and not source._initialized then
            source:Init(self.ctx)
            source._initialized = true
        end
    end
end

function Data:RebuildSource(name)
    if not self.Sources[name] then return end

    if type(self.Sources[name].Rebuild) == "function" and self.Sources[name]._initialized then
        self.Sources[name]:Rebuild()
    end
end

---@param name string
---@return KAF_DataSource
function Data:GetSource(name)
  return self.Sources[name]
end