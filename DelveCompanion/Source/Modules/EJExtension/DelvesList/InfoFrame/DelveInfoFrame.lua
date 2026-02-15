local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

--#region Constants

--#endregion

---@class DelvesInfoFrame : DelvesInfoFrameXml
---@field data DelveData
---@field abilitiesPool table
DelveCompanion_DelveInfoFrameMixin = {}

---@param self DelvesInfoFrame
function DelveCompanion_DelveInfoFrameMixin:Setup()
    if self.data == nil then
        return
    end

    local data = self.data

    self.LeftPage.DelveBg:SetAtlas(data.config.atlasBgID)
end

---@param self DelvesInfoFrame
function DelveCompanion_DelveInfoFrameMixin:OnLoad()
    -- Logger.Log("DelveInfoFrame OnLoad start")

    do
        local page = self.LeftPage
        page.StoryButton:SetText(".Walkthrough")
        page.EnemyButton:SetText(".Enemies")
    end

    do
        local page = self.RightPage
        -- self.abilitiesPool = CreateFramePool("BUTTON", page.AbilitiesScroll.Content,
        --     "DelveCompanionEncounterInfoTemplate")

        local ScrollView = CreateScrollBoxListTreeListView()

        ScrollUtil.InitScrollBoxListWithScrollBar(page.AbilitiesScrollBox, page.AbilitiesScrollBar, ScrollView)
    end
end

---@param self DelvesInfoFrame
function DelveCompanion_DelveInfoFrameMixin:OnShow()
    -- Logger.Log("DelveInfoFrame OnShow start")

    local DataProvider = CreateTreeDataProvider()
    ScrollView:SetDataProvider(DataProvider)

    local spellsList = {
        1213854,
        1217371
    }

    for i = 1, #spellsList, 1 do
        Logger.Log("Creating a spell %d", spellsList[i])
        ---@type Frame
        -- local ab = self.abilitiesPool:Acquire()
        local ab = CreateFrame("Frame", nil, self.RightPage.AbilitiesScroll.Content,
            "DelveCompanionEncounterInfoTemplate")

        ab:SetSize(320, 25)
        ab:ClearAllPoints()
        ab:SetPoint("TOP")

        ab.HeaderButton.ExpandedIcon:SetText("-")
        ab.Description:SetWidth(ab:GetWidth() - 25)

        local spell = Spell:CreateFromSpellID(spellsList[i])
        spell:ContinueOnSpellLoad(function()
            ab.HeaderButton.Title:SetText(spell:GetSpellName())
            ---@diagnostic disable-next-line: undefined-field
            ab.HeaderButton.AbilityIcon:SetTexture(spell:GetSpellTexture())
            ab.Description:SetText(spell:GetSpellDescription():gsub("|cffffffff(.-)|r", "%1"))
        end)
    end
end

---@param self DelvesInfoFrame
function DelveCompanion_DelveInfoFrameMixin:OnHide()
    -- Logger.Log("DelveInfoFrame OnHide start")

    self.abilitiesPool:ReleaseAll()
end

--#region Xml annotations

---@class DelvesInfoFrameLeftPageXml : Frame
---@field Shadow Texture
---@field DelveBg Texture
---@field Title FontString
---@field StoryButton Button
---@field EnemyButton Button

---@class DelvesInfoFrameRightPageXml : Frame

--- `DelveCompanionDelveInfoFrameTemplate`
---@class DelvesInfoFrameXml : Frame
---@field Bg Texture
---@field LeftPage DelvesInfoFrameLeftPageXml
---@field RightPage DelvesInfoFrameRightPageXml
--#endregion
