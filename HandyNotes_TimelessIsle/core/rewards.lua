local ADDON_NAME, ns = ...

local Class = ns.Class
local L = ns.locale

-------------------------------------------------------------------------------
----------------------------------- REWARD ------------------------------------
-------------------------------------------------------------------------------

local Reward = Class('Reward')

function Reward:obtained ()
    return true
end

function Reward:render (tooltip)
    tooltip:AddLine('Render not implemented: '..tostring(self))
end

-------------------------------------------------------------------------------
--------------------------------- ACHIEVEMENT ---------------------------------
-------------------------------------------------------------------------------

-- /run print(GetAchievementCriteriaInfo(ID, NUM))

local Achievement = Class('Achievement', Reward)
local GetCriteriaInfo = GetAchievementCriteriaInfoByID

function Achievement:init ()
    -- we allow a single number, table of numbers or table of
    -- objects: {id=<number>, note=<string>}
    if type(self.criteria) == 'number' then
        self.criteria = {{id=self.criteria}}
    else
        local crittab = {}
        for i, criteria in ipairs(self.criteria) do
            if type(criteria) == 'number' then
                crittab[#crittab + 1] = {id=criteria}
            else
                crittab[#crittab + 1] = criteria
            end
        end
        self.criteria = crittab
    end
end

function Achievement:obtained ()
    if select(4, GetAchievementInfo(self.id)) then return true end
    for i, c in ipairs(self.criteria) do
        local _, _, completed = GetAchievementCriteriaInfoByID(self.id, c.id)
        if not completed then return false end
    end
    return true
end

function Achievement:render (tooltip)
    local _,name,_,completed,_,_,_,_,_,icon = GetAchievementInfo(self.id)
    tooltip:AddLine(ACHIEVEMENT_COLOR_CODE..'['..name..']|r')
    tooltip:AddTexture(icon, {margin={right=2}})
    for i, c in ipairs(self.criteria) do
        local cname,_,ccomp,qty,req = GetCriteriaInfo(self.id, c.id)
        if (cname == '') then cname = qty..'/'..req end

        local r, g, b = .6, .6, .6
        local ctext = "   • "..cname..(c.suffix or '')
        if (completed or ccomp) then
            r, g, b = 0, 1, 0
        end

        if c.note and ns.addon.db.profile.show_notes then
            tooltip:AddDoubleLine(ctext, c.note, r, g, b)
        else
            tooltip:AddLine(ctext, r, g, b)
        end
    end
end

-------------------------------------------------------------------------------
------------------------------------ ITEM -------------------------------------
-------------------------------------------------------------------------------

local Item = Class('Item', Reward)

function Item:init ()
    if not self.item then
        error('Item() reward requires an item id to be set')
    end
    self.itemLink = L["retrieving"]
    self.itemIcon = 'Interface\\Icons\\Inv_misc_questionmark'
    local item = _G.Item:CreateFromItemID(self.item)
    item:ContinueOnItemLoad(function()
        self.itemLink = item:GetItemLink()
        self.itemIcon = item:GetItemIcon()
    end)
end

function Item:obtained ()
    if self.quest then return C_QuestLog.IsComplete(self.quest) end
    return true
end

function Item:render (tooltip)
    local text = self.itemLink
    local status = ''
    if self.quest then
        local completed = C_QuestLog.IsComplete(self.quest)
        status = completed and L['(completed)'] or L['(incomplete)']
    elseif self.weekly then
        local completed = C_QuestLog.IsComplete(self.weekly)
        status = completed and L['(gweekly)'] or L['(rweekly)']
    end

    if self.note then
        text = text..' ('..self.note..')'
    end
    tooltip:AddDoubleLine(text, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------ MOUNT ------------------------------------
-------------------------------------------------------------------------------

-- /run for i,m in ipairs(C_MountJournal.GetMountIDs()) do if (C_MountJournal.GetMountInfoByID(m) == "NAME") then print(m); end end

local Mount = Class('Mount', Item)

function Mount:obtained ()
    return select(11, C_MountJournal.GetMountInfoByID(self.id))
end

function Mount:render (tooltip)
    local collected = select(11, C_MountJournal.GetMountInfoByID(self.id))
    local status = collected and L["(known)"] or L["(missing)"]
    tooltip:AddDoubleLine(self.itemLink..' ('..L["mount"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------- PET -------------------------------------
-------------------------------------------------------------------------------

-- /run print(C_PetJournal.FindPetIDByName("NAME"))

local Pet = Class('Pet', Item)

function Pet:obtained ()
    return C_PetJournal.GetNumCollectedInfo(self.id) > 0
end

function Pet:render (tooltip)
    local n, m = C_PetJournal.GetNumCollectedInfo(self.id)
    local color = (n > 0) and L["(green)"] or L["(red)"]
    local status = string.format(color, n..'/'..m)
    tooltip:AddDoubleLine(self.itemLink..' ('..L["pet"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
------------------------------------- TOY -------------------------------------
-------------------------------------------------------------------------------

local Toy = Class('Toy', Item)

function Toy:obtained ()
    return PlayerHasToy(self.item)
end

function Toy:render (tooltip)
    local collected = PlayerHasToy(self.item)
    local status = collected and L["(known)"] or L["(missing)"]
    tooltip:AddDoubleLine(self.itemLink..' ('..L["toy"]..')', status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------
---------------------------------- TRANSMOG -----------------------------------
-------------------------------------------------------------------------------

local Transmog = Class('Transmog', Item)
local CTC = C_TransmogCollection

function Transmog:obtained ()
    if CTC.PlayerHasTransmog(self.item) then return true end
    local sourceID = select(2, CTC.GetItemInfo(self.item))
    if not select(2, CTC.PlayerCanCollectSource(sourceID)) then return true end
    return false
end

function Transmog:render (tooltip)
    local collected = CTC.PlayerHasTransmog(self.item)
    local status = collected and L["(known)"] or L["(missing)"]
    if not collected then
        -- check if we can't learn this item
        local sourceID = select(2, CTC.GetItemInfo(self.item))
        if not select(2, CTC.PlayerCanCollectSource(sourceID)) then
            status = L["(unlearnable)"];
        end
    end

    local suffix = ' ('..L[self.slot]..')'
    if self.note and ns.addon.db.profile.show_notes then
        suffix = suffix..' ('..self.note..')'
    end

    tooltip:AddDoubleLine(self.itemLink..suffix, status)
    tooltip:AddTexture(self.itemIcon, {margin={right=2}})
end

-------------------------------------------------------------------------------

ns.reward = {
    Reward=Reward,
    Achievement=Achievement,
    Item=Item,
    Mount=Mount,
    Pet=Pet,
    Toy=Toy,
    Transmog=Transmog
}
