-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------
local ADDON_NAME, ns = ...

local Class = ns.Class
local L = ns.locale

local Green = ns.status.Green
local Orange = ns.status.Orange
local Red = ns.status.Red
local White = ns.color.White

-------------------------------------------------------------------------------

local function Icon(icon) return '|T' .. icon .. ':0:0:1:-1|t ' end

-- in zhCN’s built-in font, ARHei.ttf, the glyph of U+2022 <bullet> is missing.
-- use U+00B7 <middle dot> instead.
local bullet = (GetLocale() == 'zhCN' and '·' or '•')

-------------------------------------------------------------------------------
----------------------------------- REWARD ------------------------------------
-------------------------------------------------------------------------------

local Reward = Class('Reward')

function Reward:Initialize(attrs)
    if attrs then for k, v in pairs(attrs) do self[k] = v end end
end

function Reward:IsEnabled()
    if self.display_option and not ns:GetOpt(self.display_option) then
        return false
    end

    -- Check faction
    if self.faction then
        if ns:GetOpt('ignore_faction_restrictions') then return true end
        if self.faction ~= ns.faction then return false end
    end

    -- Check class
    if self.class then
        if ns:GetOpt('ignore_class_restrictions') then return true end
        if self.class ~= ns.class then return false end
    end

    return true
end

function Reward:IsObtainable() return true end
function Reward:IsObtained() return true end

-- These functions drive the appearance of the tooltip
function Reward:GetLines() return function() end end
function Reward:GetCategoryIcon() end
function Reward:GetStatus() end
function Reward:GetText() return UNKNOWN end

function Reward:Prepare() end

function Reward:Render(tooltip)
    local text = self:GetText()
    local status = self:GetStatus()

    -- Add category icon (if registered)
    local icon = self:GetCategoryIcon()
    if text and icon then text = Icon(icon) .. text end

    -- Add indent if requested
    if self.indent then text = '   ' .. text end

    -- Render main line and optional status
    if text and status then
        tooltip:AddDoubleLine(text, status)
    elseif text then
        tooltip:AddLine(text)
    end

    -- Render follow-up lines (example: achievement criteria)
    for text, status, r, g, b in self:GetLines() do
        if text and status then
            tooltip:AddDoubleLine(text, status, r, g, b)
        elseif text then
            tooltip:AddLine(text, r, g, b)
        end
    end
end

-------------------------------------------------------------------------------
----------------------------------- SECTION -----------------------------------
-------------------------------------------------------------------------------

local Section = Class('Section', Reward)

function Section:Initialize(title) self.title = title end

function Section:IsEnabled() return true end

function Section:Prepare() ns.PrepareLinks(self.title) end

function Section:Render(tooltip)
    tooltip:AddLine(ns.RenderLinks(self.title, true) .. ':')
end

-------------------------------------------------------------------------------
----------------------------------- SPACER ------------------------------------
-------------------------------------------------------------------------------

local Spacer = Class('Spacer', Reward)

function Spacer:IsEnabled() return true end

function Spacer:Render(tooltip) tooltip:AddLine(' ') end

-------------------------------------------------------------------------------
--------------------------------- HUNTER PET ----------------------------------
-------------------------------------------------------------------------------

local HunterPet = Class('HunterPet', Reward, {type = L['hunter_pet']})

function HunterPet:GetText()
    local text = ('{npc:%d}'):format(self.id)
    return Icon(self.icon) .. ns.RenderLinks(text) .. ' (' .. self.type .. ')'
end

function HunterPet:IsObtainable() return ns.class == 'HUNTER' end

function HunterPet:GetStatus()
    local status = Orange(L['unobtainable'])
    return not self:IsObtainable() and status or nil
end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

local Achievement = Class('Achievement', Reward)

local GetCriteriaInfo = function(id, criteria)
    local results = {GetAchievementCriteriaInfoByID(id, criteria)}
    if not results[1] then
        if criteria <= GetAchievementNumCriteria(id) then
            results = {GetAchievementCriteriaInfo(id, criteria)}
        else
            ns.Error(
                'unknown achievement criteria (' .. id .. ', ' .. criteria ..
                    ')')
            return UNKNOWN
        end
    end
    return unpack(results)
end

function Achievement:Initialize(attrs)
    Reward.Initialize(self, attrs)
    self.criteria = ns.AsIDTable(self.criteria)
end

function Achievement:IsObtained()
    local _, _, _, completed, _, _, _, _, _, _, _, _, earnedByMe =
        GetAchievementInfo(self.id)
    completed = completed and (not ns:GetOpt('use_char_achieves') or earnedByMe)
    if completed then return true end
    if self.criteria then
        for i, c in ipairs(self.criteria) do
            local _, _, completed = GetCriteriaInfo(self.id, c.id)
            if not completed then return false end
        end
        return true
    end
    return false
end

function Achievement:GetText()
    local _, name, _, _, _, _, _, _, _, icon = GetAchievementInfo(self.id)
    local text = Icon(icon) .. ACHIEVEMENT_COLOR_CODE .. '[' .. name .. ']|r'
    if self.note then
        text = text .. ns.color.White('\n(' .. self.note .. ')')
    end
    return text
end

function Achievement:GetStatus()
    if not self.oneline and self.criteria then return end
    return self:IsObtained() and Green(L['completed']) or Red(L['incomplete'])
end

function Achievement:GetLines()
    local completed = self:IsObtained()
    local index = 0
    return function()
        -- ignore sub-lines if oneline is enabled or no criteria were given
        if self.oneline or not self.criteria then return end

        -- increment our criteria counter
        index = index + 1
        if index > #self.criteria then return end

        local c = self.criteria[index]
        local cname, _, ccomp, qty, req = GetCriteriaInfo(self.id, c.id)
        if (cname == '' or c.qty) then
            cname = c.suffix or cname
            cname = (completed and req .. '/' .. req or qty .. '/' .. req) ..
                        ' ' .. cname
        end

        local r, g, b = .6, .6, .6
        local ctext = '   ' .. bullet .. ' ' .. cname
        if (completed or ccomp) then r, g, b = 0, 1, 0 end

        local note, status = c.note
        if c.quest then
            if C_QuestLog.IsQuestFlaggedCompleted(c.quest) then
                status = ns.status.Green(L['defeated'])
            else
                status = ns.status.Red(L['undefeated'])
            end
            note = note and (note .. '  ' .. status) or status
        end

        return ctext, note, r, g, b
    end
end

-------------------------------------------------------------------------------
------------------------------------ BUFF -------------------------------------
-------------------------------------------------------------------------------

local Buff = Class('Buff', Reward, {type = L['buff']})

function Buff:Initialize(attrs)
    if attrs then for k, v in pairs(attrs) do self[k] = v end end
end

function Buff:GetText()
    local text = ns.RenderLinks(string.format('{spell:%d}', self.id))
    return text .. ' (' .. self.type .. ')'
end

function Buff:GetStatus()
    local stacks = self.stacks or 1
    local aura = C_UnitAuras.GetPlayerAuraBySpellID(self.id)
    if aura then
        local applications = aura.applications
        local status = applications .. '/' .. stacks
        return (applications >= stacks) and Green(status) or Red(status)
    end
    return Red('0/' .. stacks)
end

-------------------------------------------------------------------------------
----------------------------------- CURRENCY ----------------------------------
-------------------------------------------------------------------------------

local Currency = Class('Currency', Reward, {type = L['currency']})

function Currency:GetText()
    local info = C_CurrencyInfo.GetCurrencyInfo(self.id)
    local text = C_CurrencyInfo.GetCurrencyLink(self.id, 0)
    text = text .. ' (' .. self.type .. ')'
    if self.note then -- additional info
        text = text .. ' (' .. self.note .. ')'
    end
    return Icon(info.iconFileID) .. text
end

-------------------------------------------------------------------------------
---------------------------------- FOLLOWER -----------------------------------
-------------------------------------------------------------------------------

local Follower = Class('Follower', Reward)

function Follower:GetType(category)
    local types = {
        [6] = {
            ['enum'] = Enum.GarrisonFollowerType.FollowerType_6_0,
            ['locale'] = L['follower_type_follower']
        },
        [7] = {
            ['enum'] = Enum.GarrisonFollowerType.FollowerType_7_0,
            ['locale'] = L['follower_type_champion']
        },
        [8] = {
            ['enum'] = Enum.GarrisonFollowerType.FollowerType_8_0,
            ['locale'] = L['follower_type_follower']
        },
        [9] = {
            ['enum'] = Enum.GarrisonFollowerType.FollowerType_9_0,
            ['locale'] = L['follower_type_companion']
        }
    }
    return types[ns.expansion][category]
end

function Follower:GetText()
    local text = C_Garrison.GetFollowerInfo(self.id).name
    if self.icon then text = Icon(self.icon) .. text end
    text = text .. ' (' .. self:GetType('locale') .. ')'
    if self.note then
        text = text .. ' (' .. ns.RenderLinks(self.note, true) .. ')'
    end
    return text
end

function Follower:IsObtained()
    local followers = C_Garrison.GetFollowers(self:GetType('enum'))
    for i = 1, followers and #followers or 0 do
        local followerID = followers[i].followerID
        if (self.id == followerID) then return false end
    end
    return true
end

function Follower:GetStatus()
    return self:IsObtained() and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local Item = Class('Item', Reward)

local Cache = {}

function Item:Initialize(attrs)
    Reward.Initialize(self, attrs)

    if not self.item then
        error('Item() reward requires an item id to be set')
    end

    local item = Cache[self.item]
    if item then
        self.itemLink = item.link
        self.itemIcon = item.icon
    else
        self.itemLink = L['retrieving']
        self.itemIcon = 'Interface\\Icons\\Inv_misc_questionmark'
        self:CacheItem()
    end
end

function Item:CacheItem()
    local item = _G.Item:CreateFromItemID(self.item)
    if not item:IsItemEmpty() then
        item:ContinueOnItemLoad(function()
            local itemLink = item:GetItemLink()
            local itemIcon = item:GetItemIcon()
            Cache[self.item] = {link = itemLink, icon = itemIcon}
            self.itemLink = itemLink
            self.itemIcon = itemIcon
        end)
    end
end

function Item:Prepare() ns.PrepareLinks(self.note) end

function Item:IsEnabled()
    if not Reward.IsEnabled(self) then return false end
    if self.profession then return ns.PlayerHasProfession(self.profession) end
    return true
end

function Item:IsObtained()
    if self.quest then return C_QuestLog.IsQuestFlaggedCompleted(self.quest) end
    if self.quest_account then
        return C_QuestLog.IsQuestFlaggedCompletedOnAccount(self.quest_account)
    end
    if self.bag then return ns.PlayerHasItem(self.item) end
    return true
end

function Item:GetText()
    local text = self.itemLink
    if self.isCosmetic then
        local type = self.type and ', ' .. self.type or ''
        text = text .. ' (' .. L['cosmetic'] .. type .. ')'
    elseif self.type then -- mount, pet, toy, etc
        text = text .. ' (' .. self.type .. ')'
    end
    if self.count then
        text = text .. string.format(' (%sx)', BreakUpLargeNumbers(self.count))
    end
    if self.note then -- additional info
        text = text .. ' (' .. ns.RenderLinks(self.note, true) .. ')'
    end
    return Icon(self.itemIcon) .. text
end

function Item:GetStatus()
    if self.bag then
        local collected = ns.PlayerHasItem(self.item)
        return collected and Green(L['completed']) or Red(L['incomplete'])
    elseif self.status then
        return format('(%s)', self.status)
    elseif self.quest then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.quest)
        return completed and Green(L['completed']) or Red(L['incomplete'])
    elseif self.quest_account then
        local completed = C_QuestLog.IsQuestFlaggedCompletedOnAccount(
            self.quest_account)
        return completed and Green(L['completed']) or Red(L['incomplete'])
    elseif self.weekly then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.weekly)
        return completed and Green(L['weekly']) or Red(L['weekly'])
    end
end

-------------------------------------------------------------------------------
----------------------------------- HEIRLOOM ----------------------------------
-------------------------------------------------------------------------------

local Heirloom = Class('Heirloom', Item, {type = L['heirloom']})

function Heirloom:IsObtained() return C_Heirloom.PlayerHasHeirloom(self.item) end

function Heirloom:GetStatus()
    local collected = C_Heirloom.PlayerHasHeirloom(self.item)
    return collected and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
---------------------------------- MANUSCRIPT ---------------------------------
-------------------------------------------------------------------------------

local Manuscript = Class('Manuscript', Item,
    {display_option = 'show_manuscript_rewards'})

-------------------------------------------------------------------------------
------------------------------------ MOUNT ------------------------------------
-------------------------------------------------------------------------------

local Mount = Class('Mount', Item,
    {display_option = 'show_mount_rewards', type = L['mount']})

function Mount:IsObtained()
    return select(11, C_MountJournal.GetMountInfoByID(self.id))
end

function Mount:GetStatus()
    local collected = select(11, C_MountJournal.GetMountInfoByID(self.id))
    return collected and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
------------------------------------- PET -------------------------------------
-------------------------------------------------------------------------------

local Pet = Class('Pet', Item,
    {display_option = 'show_pet_rewards', type = L['pet']})

function Pet:Initialize(attrs)
    if attrs.item then
        Item.Initialize(self, attrs)
    else
        Reward.Initialize(self, attrs)
        local name, icon = C_PetJournal.GetPetInfoBySpeciesID(self.id)
        self.itemIcon = icon
        self.itemLink = ns.color.Green(name)
    end
end

function Pet:IsObtained() return C_PetJournal.GetNumCollectedInfo(self.id) > 0 end

function Pet:GetStatus()
    local n, m = C_PetJournal.GetNumCollectedInfo(self.id)
    return (n > 0) and Green(n .. '/' .. m) or Red(n .. '/' .. m)
end

-------------------------------------------------------------------------------
------------------------------------ QUEST ------------------------------------
-------------------------------------------------------------------------------

local Quest = Class('Quest', Reward)

function Quest:Initialize(attrs)
    Reward.Initialize(self, attrs)
    if type(self.id) == 'number' then self.id = {self.id} end
    C_QuestLog.GetTitleForQuestID(self.id[1]) -- fetch info from server
end

function Quest:IsObtained()
    for i, id in ipairs(self.id) do
        if not C_QuestLog.IsQuestFlaggedCompleted(id) then return false end
    end
    return true
end

function Quest:GetText()
    local name = C_QuestLog.GetTitleForQuestID(self.id[1])
    return ns.GetIconLink('quest_ay', 13) .. ' ' .. (name or UNKNOWN)
end

function Quest:GetStatus()
    if #self.id == 1 then
        local completed = C_QuestLog.IsQuestFlaggedCompleted(self.id[1])
        return completed and Green(L['completed']) or Red(L['incomplete'])
    else
        local count = 0
        for i, id in ipairs(self.id) do
            if C_QuestLog.IsQuestFlaggedCompleted(id) then
                count = count + 1
            end
        end
        local status = count .. '/' .. #self.id
        return (count == #self.id) and Green(status) or Red(status)
    end
end

-------------------------------------------------------------------------------
------------------------------------ RECIPE -----------------------------------
-------------------------------------------------------------------------------

local Recipe = Class('Recipe', Item, {
    display_option = 'show_recipe_rewards',
    type = L['recipe']
})

function Recipe:Initialize(attrs)
    Item.Initialize(self, attrs)

    if not self.profession then
        error('Recipe() reward requires a profession id to be set')
    end
end

-- Tooltip Documentation:
-- https://warcraft.wiki.gg/wiki/Patch_10.0.2/API_changes
-- https://warcraft.wiki.gg/wiki/Patch_10.1.0/API_changes
function Recipe:IsObtained()
    local info = C_TooltipInfo.GetItemByID(self.item)
    if info then
        for _, line in ipairs(info.lines) do
            if line.leftText and line.leftText == _G.ITEM_SPELL_KNOWN then
                return true
            end
        end
    end
    return false
end

function Recipe:GetStatus()
    local collected = self:IsObtained()
    local status = collected and Green(L['known']) or Red(L['missing'])

    if not collected then
        if not ns.PlayerHasProfession(self.profession) then
            status = Orange(L['unlearnable'])
        end
    end

    return status
end

-------------------------------------------------------------------------------
------------------------------------ SPELL ------------------------------------
-------------------------------------------------------------------------------

local Spell = Class('Spell', Item, {type = L['spell']})

function Spell:IsObtained() return IsSpellKnown(self.spell) end

function Spell:GetStatus()
    local collected = IsSpellKnown(self.spell)
    return collected and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
------------------------------------ TITLE ------------------------------------
-------------------------------------------------------------------------------

local Title = Class('Title', Reward, {type = L['title']})

function Title:GetText()
    local text = self.pattern
    local titleName, _ = GetTitleName(self.id)
    local title = strtrim(titleName)
    text = string.gsub(text, '{title}', title)
    local player = UnitName('player')
    text = string.gsub(text, '{player}', player)
    text = White(text)
    if self.type then text = text .. ' (' .. self.type .. ')' end
    if self.note then
        text = text .. ' (' .. ns.RenderLinks(self.note, true) .. ')'
    end
    return text
end

function Title:IsObtained() return IsTitleKnown(self.id) end

function Title:GetStatus()
    return self:IsObtained() and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
------------------------------------- TOY -------------------------------------
-------------------------------------------------------------------------------

local Toy = Class('Toy', Item,
    {display_option = 'show_toy_rewards', type = L['toy']})

function Toy:IsObtained() return PlayerHasToy(self.item) end

function Toy:GetStatus()
    local collected = PlayerHasToy(self.item)
    return collected and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
---------------------------------- APPEARANCE ---------------------------------
-------------------------------------------------------------------------------

-- Ensemble, Arsenal, Illusion

local Appearance = Class('Appearance', Item, {
    display_option = 'show_transmog_rewards',
    type = _G.APPEARANCE_LABEL
})

function Appearance:IsObtained()
    local KnownLineType = Enum.TooltipDataLineType.RestrictedSpellKnown
    local info = C_TooltipInfo.GetItemByID(self.item)
    if info then
        for _, line in ipairs(info.lines) do
            if line.type == KnownLineType then return true end
        end
    end
    return false
end
function Appearance:GetStatus()
    return self:IsObtained() and Green(L['known']) or Red(L['missing'])
end

-------------------------------------------------------------------------------
---------------------------------- TRANSMOG -----------------------------------
-------------------------------------------------------------------------------

local Transmog = Class('Transmog', Item,
    {display_option = 'show_transmog_rewards'})

local CTC = C_TransmogCollection

function Transmog:Initialize(attrs)
    Item.Initialize(self, attrs)
    if self.slot then
        self.type = self.slot -- backwards compat
    end
end

function Transmog:Prepare()
    Item.Prepare(self)
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if sourceID then CTC.PlayerCanCollectSource(sourceID) end
    C_Item.GetItemSpecInfo(self.item)
    CTC.PlayerHasTransmog(self.item)
    self.isCosmetic = C_Item.IsCosmeticItem(self.item)
end

function Transmog:IsEnabled()
    if not Item.IsEnabled(self) then return false end
    if ns:GetOpt('show_all_transmog_rewards') then return true end
    if not (self:IsLearnable() and self:IsObtainable()) then return false end
    return true
end

function Transmog:IsKnown()
    if CTC.PlayerHasTransmog(self.item) then return true end
    local appearanceID, sourceID = CTC.GetItemInfo(self.item)
    if sourceID and CTC.PlayerHasTransmogItemModifiedAppearance(sourceID) then
        return true
    end
    if appearanceID then
        for i, sourceID in ipairs(CTC.GetAllAppearanceSources(appearanceID)) do
            if CTC.PlayerHasTransmogItemModifiedAppearance(sourceID) then
                return true
            end
        end
    end
    return false
end

function Transmog:IsLearnable()
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if sourceID then
        local infoReady, canCollect = CTC.PlayerCanCollectSource(sourceID)
        if infoReady and not canCollect then return false end
    end
    return true
end

function Transmog:IsObtainable()
    if not Item.IsObtainable(self) then return false end
    -- Cosmetic cloaks do not behave well with the GetItemSpecInfo() function.
    -- They return an empty table even though you can get the item to drop.
    local _, _, _, ilvl, _, _, _, _, equipLoc = C_Item.GetItemInfo(self.item)
    if not (ilvl == 1 and equipLoc == 'INVTYPE_CLOAK' and self.isCosmetic) then
        -- Verify the item drops for any of the players specs
        local specs = C_Item.GetItemSpecInfo(self.item)
        if type(specs) == 'table' and #specs == 0 then return false end
    end
    return true
end

function Transmog:IsObtained()
    -- Check if the player knows the appearance
    if self:IsKnown() then return true end
    -- Verify the player can obtain and learn the item's appearance
    if not (self:IsObtainable() and self:IsLearnable()) then return true end
    return false
end

function Transmog:GetStatus()
    local collected = self:IsKnown()
    local status = collected and Green(L['known']) or Red(L['missing'])

    if not collected then
        if not self:IsLearnable() then
            status = Orange(L['unlearnable'])
        elseif not self:IsObtainable() then
            status = Orange(L['unobtainable'])
        end
    end

    return status
end

-------------------------------------------------------------------------------
--------------------------------- REPUTATION ----------------------------------
-------------------------------------------------------------------------------

local Reputation = Class('Reputation', Reward,
    {display_option = 'show_rep_rewards', type = L['rep']})

function Reputation:GetText()
    local text = ns.api.GetFactionInfoByID(self.id)
    if self.gain then text = ('+%d %s'):format(self.gain, text) end
    text = ns.color.LightBlue(text) .. ' (' .. self.type .. ')'
    if self.note then
        text = text .. ' (' .. ns.RenderLinks(self.note, true) .. ')'
    end
    return text
end

function Reputation:IsEnabled()
    if not Reward.IsEnabled(self) then return false end
    if self:IsObtained() and not ns:GetOpt('show_claimed_rep_rewards') then
        return false
    end

    return true
end
function Reputation:Prepare() ns.PrepareLinks(self.note) end

function Reputation:GetStatus()
    if not self.quest then return end
    return self:IsObtainable() and Red(L['unclaimed']) or Green(L['claimed'])
end

function Reputation:IsObtainable()
    if not self.quest then return true end
    if C_Reputation.IsAccountWideReputation(self.id) then
        return not C_QuestLog.IsQuestFlaggedCompletedOnAccount(self.quest)
    else
        return not C_QuestLog.IsQuestFlaggedCompleted(self.quest)
    end
end

function Reputation:IsObtained()
    if self.quest and self:IsObtainable() then return false end
    return true
end

-------------------------------------------------------------------------------

ns.reward = {
    Reward = Reward,
    Section = Section,
    Spacer = Spacer,
    Achievement = Achievement,
    Buff = Buff,
    Currency = Currency,
    Follower = Follower,
    Item = Item,
    Heirloom = Heirloom,
    HunterPet = HunterPet,
    Manuscript = Manuscript,
    Mount = Mount,
    Pet = Pet,
    Quest = Quest,
    Recipe = Recipe,
    Spell = Spell,
    Title = Title,
    Toy = Toy,
    Appearance = Appearance,
    Transmog = Transmog,
    Reputation = Reputation
}
