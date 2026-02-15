local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config

--#region Constants

--#endregion

--- A list with all Delves displayed in the EncounterJournal.
---@class (exact) DelvesListFrame : DelvesListXml
DelveCompanion_DelvesListFrameMixin = {}

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:UpdateKeysWidget()
    local keyCurrInfo = C_CurrencyInfo.GetCurrencyInfo(Config.BOUNTIFUL_KEY_CURRENCY_CODE)
    if not keyCurrInfo then
        self.KeysWidget:Hide()
        return
    end

    self.KeysWidget:SetLabelText(keyCurrInfo.quantity)
    self.KeysWidget:Show()

    self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:Refresh()
    ---@type EJTierData
    local tierData = GetEJTierData(EJ_GetCurrentTier())

    do
        local bgAtlasId = tierData.backgroundAtlas
        self.Background:SetAtlas(bgAtlasId, true)
    end

    DelveCompanion:UpdateDelvesData(tierData.expansionLevel)
    self:ListDelves(tierData.expansionLevel)

    self:UpdateKeysWidget()
    self.DelveOBotWidget:SetShown(tierData.expansionLevel == LE_EXPANSION_WAR_WITHIN) -- Delve-O-Bot 7001 works for TWW Delves only.

    do
        -- TODO: What will happen after TWW S3? Modifiers are active in the latest expansion Delves.

        self.ModifiersContainer.AffixWidget:SetFrameInfo(
            DelveCompanion.Definitions.CodeType.Spell,
            Config.AFFIXES.NEMESIS[tierData.expansionLevel])
        self.ModifiersContainer:SetShown(true)
        -- self.ModifiersContainer:SetShown(tierData.expansionLevel == LE_EXPANSION_LEVEL_CURRENT)
    end
end

---@param self DelvesListFrame
---@param expansionLevel number
function DelveCompanion_DelvesListFrameMixin:ListDelves(expansionLevel)
    local dataProvider = CreateDataProvider()

    for _, mapID in pairs(Config.DELVE_MAPS[expansionLevel]) do
        local areaName = C_Map.GetMapInfo(mapID).name
        dataProvider:Insert({ areaName = areaName })

        for _, delveData in pairs(DelveCompanion.Variables.delvesData[expansionLevel]) do
            local delveConfig = delveData.config
            local parentMapID = C_Map.GetMapInfo(delveConfig.uiMapID).parentMapID

            if parentMapID == mapID then
                dataProvider:Insert(delveData)
            end
        end
    end

    self.DelvesList:Show() -- Scrollbox children will not have resolvable rects unless the scrollbox is shown first
    self.DelvesList:SetDataProvider(dataProvider)
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnLoad()
    -- Logger.Log("DelvesList OnLoad start")

    self.Title:SetText(_G["DELVES_LABEL"])

    self.KeysWidget:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, Config.BOUNTIFUL_KEY_CURRENCY_CODE)

    do
        self.ModifiersContainer.ModifiersLabel:SetText(_G["MODIFIERS_COLON"])
        self.ModifiersContainer.AffixWidget.Icon:SetPoint("CENTER", -1, 1)
        self.ModifiersContainer:Layout()
    end

    do
        local topPadding = 5
        local bottomPadding = 8
        local leftPadding = 0
        local rightPadding = 0
        local horizSpacing = 15
        local vertSpacing = 10
        local view = CreateScrollBoxListSequenceView(
            topPadding, bottomPadding,
            leftPadding, rightPadding,
            horizSpacing, vertSpacing)

        --- Setup Map header.
        ---@param frame DelvesMapHeader
        local function DelveMapHeaderInitializer(frame, elementData)
            frame:Init(elementData.areaName)
        end

        --- Setup Delve instance element.
        ---@param frame DelveListElement
        ---@param delveData DelveData
        local function DelveListElementInitializer(frame, delveData)
            frame:Init(delveData)
        end

        local function DelvesListFactory(factory, elementData)
            if elementData.areaName then
                factory("DelveCompanionDelveMapHeaderTemplate", DelveMapHeaderInitializer)
            else
                factory("DelveCompanionDelveListElementTemplate", DelveListElementInitializer)
            end
        end

        view:SetElementFactory(DelvesListFactory)
        ScrollUtil.InitScrollBoxListWithScrollBar(self.DelvesList, self.ScrollBar, view)
    end
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnEvent(event, ...)
    self:UpdateKeysWidget()
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnShow()
    -- Logger.Log("DelvesList OnShow start")
    self:Refresh()
end

---@param self DelvesListFrame
function DelveCompanion_DelvesListFrameMixin:OnHide()
    --Logger.Log("DelvesList OnHide start")
    self:UnregisterEvent("CURRENCY_DISPLAY_UPDATE")
end

--#region Xml annotations

---@class ModifiersContainerXml : HorizontalLayoutFrame
---@field ModifiersLabel FontString
---@field AffixWidget CustomActionWidget

--- `DelveCompanionDelvesListFrameTemplate`
---@class DelvesListXml : Frame
---@field Background Texture
---@field Title FontString
---@field KeysWidget CustomActionWidget
---@field DelveOBotWidget DelveOBotWidget
---@field ModifiersContainer ModifiersContainerXml
---@field DelvesList Frame
---@field ScrollBar EventFrame
--#endregion
