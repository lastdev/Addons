local _,L = ...
setmetatable(L,{__index=function(L,key) return key end})

local psfj = ProtoformSynthesisFieldJournal
local minimapButton = ProtoformSynthesisFieldJournalMinimapButton
local settings

local DEBUG_MODE = false

ProtoformSynthesisFieldJournalSettings = {} -- global settings (becomes settings)

BINDING_HEADER_PROTOFORMSYNTHESISFIELDJOURNAL = L["Protoform Synthesis Field Journal"]
BINDING_NAME_PROTOFORMSYNTHESISFIELDJOURNAL_TOGGLE = L["Toggle Protoform Synthesis Field Journal"]

SLASH_PROTOFORMSYNTHESISFIELDJOURNAL1 = "/psfj"
SlashCmdList["PROTOFORMSYNTHESISFIELDJOURNAL"] = function() psfj:Toggle() end

psfj.tabProperties = {
    active = {
        highlightTopLeft = {"TOPLEFT",0,0},
        highlightBottomRight = {"BOTTOMRIGHT",-1,5},
        highlightTexCoord = {0,1,0.8125,0.9609375},
        textCenter = {"CENTER",0,1},
        textCenterDown = {"CENTER",0,-1},
        textColor = {1,1,1},
        leftTexCoord = {0,0.15625,0,0.28125},
        rightTexCoord = {0.84375,1,0,0.28125},
        midTexCoord = {0.15625,0.84375,0,0.28125},
    },
    inactive = {
        highlightTopLeft = {"TOPLEFT",0,0},
        highlightBottomRight = {"BOTTOMRIGHT",-1,12},
        highlightTexCoord = {0,1,0.8125,0.9609375},
        textCenter = {"CENTER",0,5},
        textCenterDown = {"CENTER",0,3},
        textColor = {1,0.82,0},
        leftTexCoord = {0,0.15625,0.5,0.78125},
        rightTexCoord = {0.84375,1,0.5,0.78125},
        midTexCoord = {0.15625,0.84375,0.5,0.78125},
    }
}

-- indexed by tab first (1=pets,2=mounts) and then itemID, this is the data about each craftable itemID
-- some data is generated in the PreUpdate function: itemName, moteCount, glimmerName, glimmerCount, etc
psfj.data = {
    -- [1] = pets
    {
        [189369] = {speciesID=3179,moteCost=300,glimmerID=189157,latticeID=189146}, -- Archetype of Animation
        [189380] = {speciesID=3207,moteCost=300,glimmerID=189158,latticeID=189155}, -- Archetype of Cunning
        [187795] = {speciesID=3174,moteCost=300,glimmerID=189159,latticeID=189156}, -- Archetype of Discovery
        [187713] = {speciesID=3169,moteCost=300,glimmerID=189160,latticeID=189153}, -- Archetype of Focus
        [189383] = {speciesID=3211,moteCost=300,glimmerID=189161,latticeID=189154}, -- Archetype of Malice
        [187928] = {speciesID=3197,moteCost=300,glimmerID=189162,latticeID=187634}, -- Archetype of Metamorphosis
        [187803] = {speciesID=3178,moteCost=300,glimmerID=189163,latticeID=189149}, -- Archetype of Motion
        [189375] = {speciesID=3189,moteCost=300,glimmerID=189164,latticeID=189147}, -- Archetype of Multiplicity
        [189381] = {speciesID=3201,moteCost=300,glimmerID=189165,latticeID=189152}, -- Archetype of Predation
        [189371] = {speciesID=3229,moteCost=300,glimmerID=189166,latticeID=187636}, -- Archetype of Renewal
        [189367] = {speciesID=3220,moteCost=300,glimmerID=189167,latticeID=189148}, -- Archetype of Satisfaction
        [189382] = {speciesID=3181,moteCost=300,glimmerID=189168,latticeID=187633}, -- Archetype of Serenity
        [189364] = {speciesID=3204,moteCost=300,glimmerID=189169,latticeID=189151}, -- Archetype of Survival
        [189377] = {speciesID=3233,moteCost=300,glimmerID=189170,latticeID=189145}, -- Archetype of Vigilance
        [189363] = {speciesID=3223,questID=65327,moteCost=250,glimmerID=189160,latticeID=187634}, -- Ambystan Darter
        [189365] = {speciesID=3224,questID=65332,moteCost=400,glimmerID=189163,latticeID=189151}, -- Fierce Scarabid
        [189374] = {speciesID=3232,questID=65357,moteCost=250,glimmerID=189166,latticeID=189147}, -- Leaping Leporid
        [189376] = {speciesID=3235,questID=65358,moteCost=150,glimmerID=189167,latticeID=189145}, -- Microlicid
        [189368] = {speciesID=3226,questID=65333,moteCost=350,glimmerID=189164,latticeID=189148}, -- Multichicken
        [187734] = {speciesID=3171,questID=65348,moteCost=350,glimmerID=189157,latticeID=189153}, -- Omnipotential Core
        [189373] = {speciesID=3231,questID=65354,moteCost=450,glimmerID=189159,latticeID=187636}, -- Prototickles
        [187733] = {speciesID=3170,questID=65351,moteCost=250,glimmerID=189169,latticeID=189153}, -- Resonant Echo
        [189378] = {speciesID=3222,questID=65359,moteCost=450,glimmerID=189168,latticeID=189145}, -- Shelly
        [189370] = {speciesID=3227,questID=65336,moteCost=400,glimmerID=189162,latticeID=189146}, -- Stabilized Geomental
        [189372] = {speciesID=3230,questID=65355,moteCost=400,glimmerID=189165,latticeID=187636}, -- Terror Jelly
        [187798] = {speciesID=3176,questID=65361,moteCost=350,glimmerID=189158,latticeID=189156}, -- Tunnel Vombata
        [189366] = {speciesID=3225,questID=65334,moteCost=200,glimmerID=189161,latticeID=189148}, -- Violent Poultrid
        [189379] = {speciesID=3234,questID=65360,moteCost=150,glimmerID=189170,latticeID=189155}, -- Viperid Menace
    },
    -- [2] = mounts
    {
        [187632] = {mountID=1525,questID=65401,moteCost=450,glimmerID=189174,latticeID=189156}, -- Adorned Vombata
        [187670] = {mountID=1538,questID=65385,moteCost=400,glimmerID=189179,latticeID=189145}, -- Bronze Helicid
        [187663] = {mountID=1535,questID=65396,moteCost=350,glimmerID=189179,latticeID=189154}, -- Bronzewing Vespoid
        [187665] = {mountID=1534,questID=65397,moteCost=500,glimmerID=189176,latticeID=189154}, -- Buzz
        [187630] = {mountID=1523,questID=65399,moteCost=400,glimmerID=189172,latticeID=189156}, -- Curious Crystalsniffer
        [187631] = {mountID=1524,questID=65400,moteCost=450,glimmerID=189175,latticeID=189156}, -- Darekened Vombata
        [187638] = {mountID=1526,questID=65380,moteCost=450,glimmerID=189178,latticeID=187635}, -- Deathrunner
        [187666] = {mountID=1430,questID=65381,moteCost=400,glimmerID=189180,latticeID=189150}, -- Desertwing Hunter
        [187664] = {mountID=1533,questID=65398,moteCost=450,glimmerID=189173,latticeID=189154}, -- Forged Spiteflyer
        [187677] = {mountID=1541,questID=65388,moteCost=400,glimmerID=189171,latticeID=189152}, -- Genesis Crawler
        [187683] = {mountID=1547,questID=65391,moteCost=400,glimmerID=189171,latticeID=187633}, -- Goldenplate Bufonid
        [190580] = {mountID=1580,questID=65680,moteCost=500,glimmerID=189172,latticeID=190388}, -- Heartbound Lupine
        [187679] = {mountID=1543,questID=65390,moteCost=500,glimmerID=189176,latticeID=189152}, -- Ineffable Skitterer
        [187667] = {mountID=1536,questID=65382,moteCost=350,glimmerID=189175,latticeID=189150}, -- Mawdapted Raptora
        [187639] = {mountID=1431,achievementID=15402,moteCost=400,glimmerID=189176,latticeID=187635}, -- Pale Regal Cervid
        [188809] = {mountID=1570,questID=65393,moteCost=350,glimmerID=189178,latticeID=187633}, -- Prototype Leaper
        [187668] = {mountID=1537,questID=65383,moteCost=450,glimmerID=189173,latticeID=189150}, -- Raptora Swooper
        [188810] = {mountID=1571,questID=65394,moteCost=350,glimmerID=189174,latticeID=187633}, -- Russet Bufonid
        [187672] = {mountID=1540,questID=65387,moteCost=350,glimmerID=189177,latticeID=189145}, -- Scarlet Helicid
        [187669] = {mountID=1448,questID=65384,moteCost=500,glimmerID=189172,latticeID=189145}, -- Serenade
        [187641] = {mountID=1528,questID=65379,moteCost=300,glimmerID=189175,latticeID=187635}, -- Reins of the Sundered Zerethsteed
        [187678] = {mountID=1542,questID=65389,moteCost=450,glimmerID=189177,latticeID=189152}, -- Tarachnid Creeper
        [187671] = {mountID=1539,questID=65386,moteCost=300,glimmerID=189178,latticeID=189145}, -- Unsuccessful Prototype Fleetpod
        [187660] = {mountID=1433,questID=65395,moteCost=400,glimmerID=189180,latticeID=189154}, -- Vespoid Flutterer
    },
    -- [3] = empty (placeholder for settings)
    {

    }
}

psfj.settingsList = {
    {text=L["Settings"],isHeader=true},
    {var="lockWindowPosition",text=L["Prevent this window from being moved unless Shift is held"]},
    {var="lockWindowSize",text=L["Prevent this window from being resized"]},
    {var="showReagentTooltips",text=L["Show reagent tooltips when the mouse is over a reagent"]},
    {var="showMinimapButton",text=L["Show a minimap button to summon or dismiss this window"]},
    {var="hideCollectedPets",text=L["Hide pets that have been collected in the journal"]},
    {var="hideCollectedMounts",text=L["Hide mounts that have been collected in the journal"]},
    {var="hideUnknownPetSchematics",text=L["Hide pet schematics that aren't known on this character"]},
    {var="hideUnknownMountSchematics",text=L["Hide mount schematics that aren't known on this character"]},
    {var="shareWindowPosition",text=L["Use same window size and position across all characters"]},
    {text=GAMEMENU_HELP,isHeader=true},
    {text=L["To resize this window, drag the resize grip in the lower right corner of this window."]},
    {text=L["A \124TInterface\\AddOns\\ProtoformSynthesisFieldJournal\\textures\\owned-known:0\124t beside a pet or mount name means it's been collected in the journal."]},
    {text=L["A number like [1] beside a pet or mount name is how many of those you can make."]},
    {text=GAME_VERSION_LABEL.." "..(GetAddOnMetadata("ProtoformSynthesisFieldJournal","Version") or "")},    
}

psfj.list = {} -- ordered list of itemIDs for display in the autoscrollframe

local debug_counts = {}
if DEBUG_MODE then
    debug_counts[188957] = random(3000)
end

-- indexed by itemIDs, lookup table for reagents of interest (motes, glimmers, lattices)
psfj.reagents = {[188957] = true} -- 188957 is Genesis Mote
for _,tab in ipairs(psfj.data) do
    for _,info in pairs(tab) do
        if DEBUG_MODE then -- in debug mode, give us random glimmers/lattices
            debug_counts[info.glimmerID] = random(10)>5 and random(4) or 0
            debug_counts[info.latticeID] = random(10)>5 and random(5) or 0
            if random(10)>5 then -- and make half of pets/mounts known
                info.questID = nil
                info.achievementID = nil
            end
        end
        psfj.reagents[info.glimmerID] = true
        psfj.reagents[info.latticeID] = true
    end
end

-- called from slash command and bindings.xml, summons/dismisses the window
function psfj:Toggle()
    psfj:SetShown(not psfj:IsShown())
end

-- populates the list of items and updates the list; call whenever showing the window or anything has changed
function psfj:Update()
    psfj:UpdateTabs()
    psfj.Settings:SetShown(settings.activeTab==3)
    psfj.List:SetShown(settings.activeTab~=3)
    psfj:PopulateList() -- letting it populate on tab 3 (settings) to an empty placeholder to avoid problems
    psfj.List:Update()
    if settings.activeTab==3 then
        psfj.Settings:Update()
    end
    psfj.ResizeGrip:SetShown(not settings.lockWindowSize)
end

--[[ events ]]

function psfj:PLAYER_LOGIN()

    settings = ProtoformSynthesisFieldJournalSettings

    -- adjust frame
    self.TitleText:SetText(L["Protoform Synthesis Field Journal"])
    self.TitleText:SetPoint("TOP",-6,-5)
    self:SetResizeBounds(330,196,1024,768)
    if self:GetWidth()<330 then
        self:SetWidth(330)
    end

    -- setup autoscrollframe
    local scrollFrame = self.List
    scrollFrame.template = "ProtoformSynthesisFieldJournalListTemplate"
    scrollFrame.callback = self.FillListButton
    scrollFrame.preUpdateFunc = self.GatherButtonData
    scrollFrame.dynamicButtonHeight = self.GetButtonHeight
    scrollFrame.list = self.list

    local scrollFrame = self.Settings
    scrollFrame.template = "ProtoformSynthesisFieldJournalSettingsTemplate"
    scrollFrame.callback = self.FillSettingsButton
    scrollFrame.list = self.settingsList

    -- add esc behavior: if dressupframe open, let esc go through to close it; otherwise close
    self.CloseButton:SetScript("OnKeyDown",function(self,key)
        if key==GetBindingKey("TOGGLEGAMEMENU") and not DressUpFrame:IsVisible() then
            self:SetPropagateKeyboardInput(false)
            self:Click() -- close
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- set up tabs
    if not settings.activeTab or type(settings.activeTab)~="number" or settings.activeTab < 1 or settings.activeTab > #self.PanelTabs.Tabs then
        settings.activeTab = 1 -- start with pet tab if not defined
    end
    self.PanelTabs.Tabs[settings.activeTab].isActive = true
    self.PanelTabs.PetTab.Text:SetText(L["Pets"])
    self.PanelTabs.MountTab.Text:SetText(L["Mounts"])
    self.PanelTabs.SettingsTab.Text:SetText(L["Settings"])
    self:UpdateTabs()

    -- broker launcher plugin
    local ldb = LibStub and LibStub.GetLibrary and LibStub:GetLibrary("LibDataBroker-1.1",true)
    if ldb then
        ldb:NewDataObject("ProtoformSynthesisFieldJournal",{type="launcher", icon="Interface\\Icons\\inv_progenitor_protoformsynthesis", tooltiptext=L["Protoform Synthesis Field Journal"], OnClick=psfj.Toggle}) 
    end

    minimapButton:Update()

end

-- these are only registered while window on screen and simply update the list
function psfj:BAG_UPDATE_DELAYED()
    psfj:Update()
end
psfj.QUEST_TURNED_IN = psfj.BAG_UPDATE_DELAYED
psfj.QUEST_LOG_UPDATE = psfj.BAG_UPDATE_DELAYED
psfj.PLAYERREAGENTBANKSLOTS_CHANGED = psfj.BAG_UPDATE_DELAYED

-- if a dressup modifier key goes down or up while mouse is over the list
function psfj:MODIFIER_STATE_CHANGED()
    if settings.activeTab~=3 and MouseIsOver(self.List) then
        for _,button in ipairs(self.List.ScrollFrame.Buttons) do
            if GetMouseFocus()==button then
                if IsModifiedClick("DRESSUP") then
                    ShowInspectCursor()
                else
                    ResetCursor()
                end
                return
            end
        end
    end
end

--[[ panel tabs ]]

function psfj:UpdateTabs()
    for _,tab in ipairs(self.PanelTabs.Tabs) do
        self.PanelTabs:UpdateTab(tab)
    end    
end

function psfj.PanelTabs:UpdateTab(tab)
    tab.properties = psfj.tabProperties[tab.isActive and "active" or "inactive"]
    tab.Highlight:SetPoint(unpack(tab.properties.highlightTopLeft))
    tab.Highlight:SetPoint(unpack(tab.properties.highlightBottomRight))
    tab.Highlight:SetTexCoord(unpack(tab.properties.highlightTexCoord))
    tab.Text:SetPoint(unpack(tab.properties.textCenter))
    tab.Text:SetTextColor(unpack(tab.properties.textColor))
    tab.Left:SetTexCoord(unpack(tab.properties.leftTexCoord))
    tab.Right:SetTexCoord(unpack(tab.properties.rightTexCoord))
    tab.Middle:SetTexCoord(unpack(tab.properties.midTexCoord))
end

function psfj.PanelTabs:OnClick()
    for _,tab in ipairs(psfj.PanelTabs.Tabs) do
        tab.isActive = tab==self
    end
    settings.activeTab = self:GetID()
    psfj:Update()
    psfj.List:ScrollToIndex(1) -- scroll to top when changing tabs (or even clicking tab if same tab)
end

--[[ settings ]]

function psfj:FillSettingsButton(info)
    self.Text:SetText(info.text)
    self.CheckButton:SetShown(info.var and true)
    if info.var then
        self.Text:SetTextColor(1,0.82,0)
        self.Text:SetPoint("LEFT",30,0)
        self.CheckButton:SetHitRectInsets(-2,-self:GetWidth()+28,-8,-8)
        self.CheckButton.var = info.var
        self.CheckButton:SetChecked(settings[info.var] and true)
    else
        if info.isHeader then
            self.Text:SetTextColor(0.5,0.75,1)
        else
            self.Text:SetTextColor(0.65,0.65,0.65)
        end
        self.Text:SetPoint("LEFT",6,0)
        self.CheckButton.var = nil
    end
    if GetMouseFocus()==self.CheckButton then
        self.CheckButton:GetScript("OnEnter")(self.CheckButton)
    end
end

function psfj:SettingsCheckButtonOnClick()
    if self.var then
        settings[self.var] = not settings[self.var]
        if self.var=="showMinimapButton" then
            minimapButton:Update()
        else
            psfj:Update()
        end
    end
end

--[[ list ]]

-- fills the autoscrollframe reference list with itemIDs in the order they should be displayed
function psfj:PopulateList()
    local list = psfj.list
    wipe(list)
    if psfj.data[settings.activeTab] then
        for itemID,info in pairs(psfj.data[settings.activeTab]) do
            if info.speciesID and settings.hideCollectedPets and psfj:IsInJournal(itemID) then
                -- don't add uncollected pet
            elseif info.mountID and settings.hideCollectedMounts and psfj:IsInJournal(itemID) then
                -- don't add uncollected mount
            elseif info.speciesID and settings.hideUnknownPetSchematics and psfj:IsSchematicUnknown(itemID) then
                -- don't add unknown pet schematic
            elseif info.mountID and settings.hideUnknownMountSchematics and psfj:IsSchematicUnknown(itemID) then
                -- don't add unknown mount schematic
            else
                info.isUnknown = psfj:IsSchematicUnknown(itemID)
                tinsert(list,itemID)
            end
        end
        table.sort(list,psfj.SortList)
    end
end

-- table.sort function used in PopulateList; sort known items to top then by name
function psfj.SortList(e1,e2)
    local info1 = psfj.data[settings.activeTab][e1]
    local info2 = psfj.data[settings.activeTab][e2]

    if info1 and not info2 then
        return true
    elseif not info1 and info2 then
        return false
    end

    -- sort known to top
    if info1.isUnknown and not info2.isUnknown then
        return false
    elseif not info1.isUnknown and info2.isUnknown then
        return true
    end

    -- sort by name next
    if info1.itemName and not info2.itemName then
        return true
    elseif not info1.itemName and info2.itemName then
        return false
    elseif info1.itemName~=info2.itemName then
        return info1.itemName < info2.itemName
    end

    -- if we reached here, likely the names were not cached, do a stable sort by itemID
    return e1 < e2
end

-- called from the autoscrollframe Update, this fills in each button(self) details for the given itemID
function psfj:FillListButton(itemID)
    local info = psfj.data[settings.activeTab][itemID]
    local enableMouse = settings.showReagentTooltips and true
    local isUnknown = info.isUnknown
    self.itemID = itemID
    self.speciesID = info.speciesID
    self.mountID = info.mountID
    -- for reagent tooltips
    self.MoteButton.reagentID = 188957
    self.GlimmerButton.reagentID = info.glimmerID
    self.LatticeButton.reagentID = info.latticeID
    self.MoteButton:EnableMouse(enableMouse)
    self.GlimmerButton:EnableMouse(enableMouse)
    self.LatticeButton:EnableMouse(enableMouse)
    -- fill in icon and texts
    self.Icon:SetTexture(info.icon)
    self.Name:SetText(info.nameText)
    self.MoteButton.Text:SetText(info.moteText)
    self.GlimmerButton.Icon:SetTexture(info.glimmerIcon)
    self.GlimmerButton.Text:SetText(info.glimmerText)
    self.LatticeButton.Icon:SetTexture(info.latticeIcon)
    self.LatticeButton.Text:SetText(info.latticeText)
    -- desaturate/color stuff based on whether this is a known/unknown item
    self.Icon:SetDesaturated(isUnknown)
    self.MoteButton.Icon:SetDesaturated(isUnknown)
    self.GlimmerButton.Icon:SetDesaturated(isUnknown)
    self.LatticeButton.Icon:SetDesaturated(isUnknown)
    self.MoteButton.Border:SetDesaturated(isUnknown)
    self.GlimmerButton.Border:SetDesaturated(isUnknown)
    self.LatticeButton.Border:SetDesaturated(isUnknown)
    self.Name:SetTextColor(psfj:GetButtonTextColor(isUnknown))
    self.MoteButton.Text:SetTextColor(psfj:GetButtonTextColor(isUnknown,info.moteCount,info.moteCost))
    self.GlimmerButton.Text:SetTextColor(psfj:GetButtonTextColor(isUnknown,info.glimmerCount,1))
    self.LatticeButton.Text:SetTextColor(psfj:GetButtonTextColor(isUnknown,info.latticeCount,1))
    -- resize elements based on framewidth
    self.Name:SetWidth(psfj.maxNameWidth+psfj.padding)
    if psfj.alignReagents then -- if room for reagents to be aligned, use max width
        self.MoteButton:SetWidth(psfj.maxMoteWidth+24+psfj.padding)
        self.GlimmerButton:SetWidth(psfj.maxGlimmerWidth+24+psfj.padding)
        self.LatticeButton:SetWidth(psfj.maxLatticeWidth+24+psfj.padding)
    else -- otherwise use just enough width for reagent text + icon + padding
        self.MoteButton:SetWidth(info.moteWidth+24)
        self.GlimmerButton:SetWidth(info.glimmerWidth+24)
        self.LatticeButton:SetWidth(info.latticeWidth+24)
    end
    self.MoteButton:ClearAllPoints()
    if psfj.wideMode then -- if room for reagents to list to right of name, move reagents there
        self.Icon:SetSize(18,18)
        self.IconMask:SetSize(18,18)
        self.Name:SetPoint("LEFT",26,0)
        self.MoteButton:SetPoint("LEFT",self.Name,"RIGHT",4,0)
    else -- otherwise position reagents beneath name
        self.Icon:SetSize(42,42)
        self.IconMask:SetSize(42,42)
        self.Name:SetPoint("LEFT",48,9)
        self.MoteButton:SetPoint("BOTTOMLEFT",48,7)
    end
    if GetMouseFocus()==self then
        self:GetScript("OnEnter")(self)
    end    
end

-- rather than calculate values in the FillListButton(), this gathers data for all rows
-- before the list updates, so it can set a max width for variable-width text fields
function psfj:GatherButtonData()
    local notCached = false
    local needsSorted = false
    psfj.maxNameWidth = 0
    psfj.maxMoteWidth = 0
    psfj.maxGlimmerWidth = 0
    psfj.maxLatticeWidth = 0
    local notCached = false
    -- gather data for each itemID in the data
    for itemID,info in pairs(psfj.data[settings.activeTab]) do
        -- names may not be cached (especially on cold login); names can be nil until cached
        if not info.itemName then
            info.itemName = GetItemInfo(itemID)
            if not info.itemName then
                notCached = true
            else
                needsSorted = true -- name loaded for first time, names need sorted
            end
        end
        if not info.glimmerName then
            info.glimmerName = GetItemInfo(info.glimmerID)
            if not info.glimmerName then
                notCached = true
            else
                info.glimmerName = info.glimmerName
            end
        end
        if not info.latticeName then
            info.latticeName = GetItemInfo(info.latticeID)
            if not info.latticeName then
                notCached = true
            else
                info.latticeName = info.latticeName
            end
        end
        if not info.icon then
            info.icon = select(5,GetItemInfoInstant(itemID))
        end
        if not info.glimmerIcon then
            info.glimmerIcon = select(5,GetItemInfoInstant(info.glimmerID))
        end
        if not info.latticeIcon then
            info.latticeIcon = select(5,GetItemInfoInstant(info.latticeID))
        end
        info.moteCount = psfj:GetItemCount(188957)
        info.glimmerCount = psfj:GetItemCount(info.glimmerID)
        info.latticeCount = psfj:GetItemCount(info.latticeID)

        info.numCraftable = min(floor(info.moteCount / info.moteCost),info.glimmerCount,info.latticeCount)

        -- adding a checkmark beside a pet/mount that's in the journal (but greyed out if schematic unknown)
        info.nameText = info.itemName or ""
        if info.numCraftable > 0 then
            info.nameText = info.nameText .. (info.isUnknown and "" or "\124cffe0e0e0") .. format(" [%d]",info.numCraftable)
        end
        local inJournal = psfj:IsInJournal(itemID)
        if inJournal then
            info.nameText = info.nameText .. (info.isUnknown and " \124TInterface\\AddOns\\ProtoformSynthesisFieldJournal\\textures\\owned-unknown:0\124t" or " \124TInterface\\AddOns\\ProtoformSynthesisFieldJournal\\textures\\owned-known:0\124t")
        end
        
        info.moteText = format("%d/%d ",info.moteCount,info.moteCost)
        info.glimmerText = format("%d/1 %s",info.glimmerCount,info.glimmerName or "")
        info.latticeText = format("%d/1 %s",info.latticeCount,info.latticeName or "")

        info.nameWidth = psfj:UpdateMaxWidth("maxNameWidth",info.nameText)
        info.moteWidth = psfj:UpdateMaxWidth("maxMoteWidth",info.moteText)
        info.glimmerWidth = psfj:UpdateMaxWidth("maxGlimmerWidth",info.glimmerText)
        info.latticeWidth = psfj:UpdateMaxWidth("maxLatticeWidth",info.latticeText)
    end
    -- the purpose of doing everything was to get max widths. the following notes adjustments based on that
    local frameWidth = psfj:GetWidth()
    local reagentWidth = psfj.maxMoteWidth+psfj.maxGlimmerWidth+psfj.maxLatticeWidth
    psfj.alignReagents = (frameWidth-reagentWidth)>163 -- if wide enough to let reagents have fixed width
    psfj.wideMode = (frameWidth-reagentWidth-psfj.maxNameWidth)>148 -- if wide enough to let reagents list to right of itemName
    -- padding is a small space added to widths so cells take up more space when it widens beyond minimum thresholds
    psfj.padding = max(0,psfj.wideMode and (frameWidth-psfj.maxNameWidth-reagentWidth-148)/4 or (frameWidth-reagentWidth-163)/3)
    if notCached then -- if any names are blank, come back in half a second to try again
        C_Timer.After(0.5,psfj.Update)
    elseif needsSorted then
        table.sort(psfj.list,psfj.SortList) 
    end
end

-- sets the text to a hidden and unbounded fontstring to get and record its max width
-- element can be "maxNameWidth","maxMoteWidth","maxGlimmerWidth","maxLatticeWidth"
function psfj:UpdateMaxWidth(element,text)
    if not text then
        return 0
    end
    local width
    if element=="maxNameWidth" then
        self.HiddenNameFontString:SetText(text)
        width = self.HiddenNameFontString:GetStringWidth()
        self[element] = max(self[element],width)
    else
        self.HiddenReagentFontString:SetText(text)
        width = self.HiddenReagentFontString:GetStringWidth()
        self[element] = max(self[element],width)
    end
    return width
end

-- returns r,g,b for the color of text on a button based on whether its schematic is known and has a count
function psfj:GetButtonTextColor(unknown,count,minCount)
    if unknown then -- whether a name or reagent, grey text if unknown
        return 0.5,0.5,0.5
    elseif not count then -- known but a name (no count), gold text
        return 1,0.82,0
    elseif count and minCount and count >= minCount then -- known reagent with more than 0, white text
        return 0.9,0.9,0.9
    else -- known reagent with count==0, grey text
        return 0.5,0.5,0.5
    end
end

-- dynamicButtonHeight for autoscrollframe just returns height based on wideMode
function psfj:GetButtonHeight(index)
    return psfj.wideMode and 24 or 48
end

--[[ item counts ]]

-- wrapper for GetItemCount to also include reagent and main bank
function psfj:GetItemCount(itemID)
    if DEBUG_MODE and debug_counts[itemID] then
        return debug_counts[itemID]
    else
        return GetItemCount(itemID,true,true,true)
    end
end

-- returns true if the pet or mount for the given itemID is collected in the journal
function psfj:IsInJournal(itemID)
    if psfj.data[1][itemID] then
        local speciesID = psfj.data[1][itemID].speciesID
        return speciesID and C_PetJournal.GetNumCollectedInfo(speciesID)>0
    elseif psfj.data[2][itemID] then
        local mountID = psfj.data[2][itemID].mountID
        return mountID and select(11,C_MountJournal.GetMountInfoByID(mountID))
    end
end

-- returns true if the given itemID is not a known schematic
function psfj:IsSchematicUnknown(itemID)
    for i=1,2 do
        if psfj.data[i][itemID] then
            local info = psfj.data[i][itemID]
            if info.achievementID and not select(13,GetAchievementInfo(info.achievementID)) then
                return true
            elseif info.questID and not C_QuestLog.IsQuestFlaggedCompleted(info.questID) then
                return true
            else
                return false
            end
        end
    end
end

--[[ ui script handlers ]]

function psfj:OnEvent(event,...)
    if self[event] then
        self[event](self,...)
    end
end

function psfj:OnShow()
    if settings.shareWindowPosition then
        if settings.windowXPos and settings.windowYPos then
            self:ClearAllPoints()
            self:SetPoint("BOTTOMLEFT",settings.windowXPos,settings.windowYPos)
        end
        if settings.windowWidth and settings.windowHeight then
            self:SetSize(settings.windowWidth,settings.windowHeight)
        end
    end
    self:Update(true)
    self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
    self:RegisterEvent("QUEST_TURNED_IN")
    self:RegisterEvent("QUEST_LOG_UPDATE")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")
    self:RegisterEvent("BAG_UPDATE_DELAYED")
end

function psfj:OnHide()
    self:UnregisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
    self:UnregisterEvent("QUEST_TURNED_IN")
    self:UnregisterEvent("QUEST_LOG_UPDATE")
    self:UnregisterEvent("MODIFIER_STATE_CHANGED")
    self:UnregisterEvent("BAG_UPDATE_DELAYED")
end

-- returns "ANCHOR_RIGHT" if main window is on left side of screen; "ANCHOR_LEFT" otherwise
function psfj:GetTooltipAnchor()
    local fx = psfj:GetCenter()*psfj:GetEffectiveScale()
    local ux = UIParent:GetCenter()*UIParent:GetEffectiveScale()
    return fx<ux and "ANCHOR_RIGHT" or "ANCHOR_LEFT"
end

function psfj:ListButtonOnEnter()
    self:SetBackdropBorderColor(0,0.75,1)
    if IsModifiedClick("DRESSUP") then
        ShowInspectCursor()
    else
        ResetCursor()
    end
    if self.itemID then
        GameTooltip:SetOwner(self,psfj:GetTooltipAnchor())
        GameTooltip:SetItemByID(self.itemID)
        GameTooltip:Show()
    end
end

function psfj:ListButtonOnLeave()
    self:SetBackdropBorderColor(0.3,0.3,0.3)
    ResetCursor()
    GameTooltip:Hide()
end

function psfj:ListButtonOnClick()
    if IsModifiedClick("DRESSUP") then
        if InCombatLockdown() then
            UIErrorsFrame:AddMessage(ERR_AFFECTING_COMBAT,1,0,0)
        elseif self.speciesID then
            local _,_,_,creatureID,_,_,_,_,_,_,_,displayID = C_PetJournal.GetPetInfoBySpeciesID(self.speciesID)
            DressUpBattlePet(creatureID,displayID,self.speciesID)
        elseif self.mountID then
            DressUpMount(self.mountID)
        end
    end
end

function psfj:ReagentButtonOnEnter()
    if self.reagentID then
        GameTooltip:SetOwner(self:GetParent(),psfj:GetTooltipAnchor())
        GameTooltip:SetItemByID(self.reagentID)
        if IsAddOnLoaded("Stash") and _stash and _stash.tooltips and _stash.tooltips.AddLocationsToAnyTooltip then
            _stash.tooltips:AddLocationsToAnyTooltip(GameTooltip,self.reagentID)
        end
        GameTooltip:Show()
        self.Highlight:Show()
        self:GetParent():SetBackdropBorderColor(0,0.75,1)
    end
end

function psfj:ReagentButtonOnLeave()
    GameTooltip:Hide()
    self.Highlight:Hide()
    self:GetParent():SetBackdropBorderColor(0.3,0.3,0.3)
end

function psfj:OnMouseDown()
    if not settings.lockWindowPosition or IsShiftKeyDown() then
        self:StartMoving()
    end
end

function psfj:OnMouseUp()
    self:StopMovingOrSizing()
    settings.windowXPos = self:GetLeft()
    settings.windowYPos = self:GetBottom()
    settings.windowWidth = self:GetWidth()
    settings.windowHeight = self:GetHeight()
end

--[[ minimap button ]]

function minimapButton:Update()
    local angle = settings.minimapPosition or 160
    self:SetPoint("CENTER",Minimap,"CENTER",(105*cos(angle)),(105*sin(angle)))
    self:SetShown(settings.showMinimapButton and true)
end

function minimapButton:OnEnter()
    GameTooltip:SetOwner(self,"ANCHOR_LEFT")
    GameTooltip:AddLine(L["Protoform Synthesis Field Journal"])
    GameTooltip:Show()
end

function minimapButton:OnLeave()
    GameTooltip:Hide()
end

function minimapButton:OnMouseDown()
    self.Icon:SetPoint("CENTER",-1,-2)
    self.Icon:SetVertexColor(0.65,0.65,0.65)
end

function minimapButton:OnMouseUp()
    self.Icon:SetPoint("CENTER")
    self.Icon:SetVertexColor(1,1,1)
end

function minimapButton:OnClick()
    psfj:Toggle() 
end

function minimapButton:OnDragStart()
    self:SetScript("OnUpdate",self.OnDragUpdate)
end

function minimapButton:OnDragStop()
    self:OnMouseUp()
    self:SetScript("OnUpdate",nil)
end

function minimapButton:OnDragUpdate(elapsed)
	local x,y = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	local minX,minY = Minimap:GetCenter()
    settings.minimapPosition = math.deg(math.atan2(y/scale-minY,x/scale-minX))
    self:Update()
end
