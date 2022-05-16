local pfs = ProtoformSynthesis
local version = "V1.2.2"
local db = {
	["minimapPos"] = 242.1856774393399,
}

BINDING_HEADER_PROTOFORMSYNTHESIS = "Protoform Synthesis"
BINDING_NAME_PROTOFORMSYNTHESIS_TOGGLE = "Toggle Window"
HideMountCollected = false

SLASH_PROTOFORMSYNTHESIS1 = "/pfs"
SlashCmdList["PROTOFORMSYNTHESIS"] = function(imput)
		local cmd,_,_,_,_ = strsplit(' ', imput);
		HideMountCollected = false
		if (strlower(cmd) == "missing") then
				HideMountCollected = true
		end
		pfs:Toggle()
end

local sicon_unknown = 134400 		--Fragezeichen
local sicon_creatable = 618979  --graues Zahnrad
local sicon_built = 413588  		--Mount Journal (631718)
local sicon_gathering = 134331 	--Schriftrolle/Bauplan

-- indexed by itemID, this is the data about each craftable itemID
-- some data is generated in the PreUpdate function: itemName, moteCount, glimmerName, glimmerCount, etc
pfs.data = {
    [187632] = {speciesID=359232,questID=65401,moteCost=450,glimmerID=189174,latticeID=189156,mountID=1525}, -- Geschmückter Vombata
    [187630] = {speciesID=359230,questID=65378,moteCost=400,glimmerID=189172,latticeID=189156,mountID=1523}, -- Neugieriger Kristallschnüffler questID=65399
    [187631] = {speciesID=359231,questID=65400,moteCost=450,glimmerID=189175,latticeID=189156,mountID=1524}, -- Dunkler Vombata
    [190580] = {speciesID=367673,questID=65680,moteCost=500,glimmerID=189172,latticeID=190388,mountID=1580}, -- Herzgebundener Lupin
    [187670] = {speciesID=359376,questID=65385,moteCost=400,glimmerID=189179,latticeID=189145,mountID=1538}, -- Bronzener Helicid
    [187672] = {speciesID=365076,questID=65387,moteCost=350,glimmerID=189177,latticeID=189145,mountID=1540}, -- Scharlachroter Helicid
    [187669] = {speciesID=359376,questID=65384,moteCost=500,glimmerID=189172,latticeID=189145,mountID=1448}, -- Serenade
    [187671] = {speciesID=365074,questID=65386,moteCost=300,glimmerID=189178,latticeID=189145,mountID=1539}, -- Gescheiterter Flitzopodenprototyp
    [187664] = {speciesID=365049,questID=65398,moteCost=450,glimmerID=189173,latticeID=189154,mountID=1533}, -- Geschmiedeter Tückenflügler
    [187663] = {speciesID=365047,questID=65396,moteCost=350,glimmerID=189179,latticeID=189154,mountID=1535}, -- Bronzeflügelvespid
    [187665] = {speciesID=359366,questID=65397,moteCost=500,glimmerID=189176,latticeID=189154,mountID=1534}, -- Summ
    [187660] = {speciesID=365046,questID=65395,moteCost=400,glimmerID=189180,latticeID=189154,mountID=1433}, -- Vespidenflatterer
    [187638] = {speciesID=365045,questID=65380,moteCost=450,glimmerID=189178,latticeID=187635,mountID=1526}, -- Todesläufer
    [187639] = {speciesID=365040,questID=65375,moteCost=400,glimmerID=189176,latticeID=187635,mountID=1431}, -- Blasser majestätischer Cervid
    [187641] = {speciesID=365042,questID=65379,moteCost=300,glimmerID=189175,latticeID=187635,mountID=1528}, -- Gemarterter Zerethhirsch
    [187666] = {speciesID=365050,questID=65381,moteCost=400,glimmerID=189180,latticeID=189150,mountID=1430}, -- Wüstenschwingenjäger
    [187668] = {speciesID=365052,questID=65383,moteCost=450,glimmerID=189173,latticeID=189150,mountID=1537}, -- Raptorasturzflieger
    [187667] = {speciesID=365051,questID=65382,moteCost=350,glimmerID=189175,latticeID=189150,mountID=1536}, -- Schlundadaptierter Raptora
    [187677] = {speciesID=365055,questID=65388,moteCost=400,glimmerID=189171,latticeID=189152,mountID=1541}, -- Genesiskrabbler
    [187679] = {speciesID=365057,questID=65390,moteCost=500,glimmerID=189176,latticeID=189152,mountID=1543}, -- Unergründlicher Krabbler
    [187678] = {speciesID=365056,questID=65389,moteCost=450,glimmerID=189177,latticeID=189152,mountID=1542}, -- Tarachnidenkriecher
		[187683] = {speciesID=365058,questID=65391,moteCost=400,glimmerID=189171,latticeID=187633,mountID=1547}, -- Goldplattenbufonid
    [188809] = {speciesID=365062,questID=65393,moteCost=350,glimmerID=189178,latticeID=187633,mountID=1570}, -- Hüpferprototyp
    [188810] = {speciesID=365063,questID=65394,moteCost=350,glimmerID=189174,latticeID=187633,mountID=1571},  -- Rostroter Bufonid
}

pfs.list = {} -- ordered list of itemIDs for display in the autoscrollframe

-- indexed by itemIDs, lookup table for reagents of interest (motes, glimmers, lattices)
pfs.reagents = {[188957] = true} -- 188957 is Genesis Mote
for _,info in pairs(pfs.data) do
    pfs.reagents[info.glimmerID] = true
    pfs.reagents[info.latticeID] = true
end

-- indexed by itemID, the count of that itemID in the reagent bank; only reagent itemIDs are tracked
pfs.bank = {}

-- called from slash command and bindings.xml, summons/dismisses the window
function pfs:Toggle()
    pfs:SetShown(not pfs:IsShown())
end

-- populates the list of items and updates the list; call whenever showing the window or anything has changed
-- if the reagent bank has possibly changed (showing for first time, reagent bank event) set updateReagentBank
function pfs:Update(updateReagentBank)
    if updateReagentBank then
        self:UpdateReagentBank()
    end
    pfs:PopulateList()
    pfs.List:Update()
end

--[[ events ]]

function pfs:PLAYER_LOGIN()
    -- adjust frame
    local titletext = format("Protoform Synthesis for Mounts (by OlWi) - %s",version)
    self.TitleText:SetText(titletext)
    self.TitleText:SetPoint("TOP",-6,-5)
--    self:SetMinResize(710,196)
    self:SetMinResize(540,120)
    self:SetMaxResize(1024,650)

    -- setup autoscrollframe
    local scrollFrame = self.List
    scrollFrame.template = "ProtoformSynthesisListTemplate"
    scrollFrame.callback = self.FillListButton
    scrollFrame.preUpdateFunc = self.GatherButtonData
    scrollFrame.dynamicButtonHeight = self.GetButtonHeight
    scrollFrame.list = self.list

    -- add esc behavior: if dressupframe open, let esc go through to close it; otherwise close
    self.CloseButton:SetScript("OnKeyDown",function(self,key)
        if key==GetBindingKey("TOGGLEGAMEMENU") and not DressUpFrame:IsVisible() then
            self:SetPropagateKeyboardInput(false)
            self:Click() -- close
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- broker launcher plugin and default db data
    local ldb = LibStub and LibStub.GetLibrary and LibStub:GetLibrary("LibDataBroker-1.1",true)
    local LDBIcon = ldb and LibStub("LibDBIcon-1.0", true)
    if _G["ProtoformSynthesisDB"]==nil then 
    		_G["ProtoformSynthesisDB"] = db		
    end
    db = _G["ProtoformSynthesisDB"]
    pfs.db = db

    if ldb then
        local MinimapBtn = ldb:NewDataObject("ProtoformSynthesis",{
        		type="launcher",
        		icon="Interface\\Icons\\inv_progenitor_protoformsynthesis",
        		tooltiptext="Protoform Synthesis",
					  OnClick = function(self, button)
						    if button == 'LeftButton' then --ALL MOUNTS
										HideMountCollected = false
						    else	--MISSING MOUNTS
										HideMountCollected = true
						    end
						    pfs:PopulateList()
		        		pfs.Toggle()
					  end,
            OnTooltipShow = function(tt)
            	  tt:AddDoubleLine("Protoform Synthesis", "|cffffffff("..version..")|r");
            	  tt:AddLine(" ");
            	  tt:AddLine("|cff4169e1The missing mounts are ready to be made?|r");

				        for itemID,info in pairs(pfs.data) do
				        	  --construction plan learned?
										if itemID==187639 then
												local _,_,_,_,_,_,_,_,_,_,_,_,completed,_,_ = GetAchievementInfo(15402)
												if completed then
														isUnknown = false
												else
														isUnknown = true
												end
								    else -- all other mounts
								    		isUnknown = info.questID and not C_QuestLog.IsQuestFlaggedCompleted(info.questID) or false				
										end
				        	
										if info.itemName~=nil and not pfs:MountExists(info.mountID) then
								        if not isUnknown and info.moteCount >= info.moteCost and info.glimmerCount > 0 and info.latticeCount > 0 then
						            	  tt:AddDoubleLine("- "..info.itemName, "|cff32cd32YES|r", 0.9, 0.9, 0.9);  --herstellbar = green
								        else
						            	  tt:AddDoubleLine("- "..info.itemName, "|cffff0000NO |r", 0.5, 0.5, 0.5);  --fehlende Matterialien = red
										    end
	    			        end
				        end
				        
            	  tt:AddLine(" ");
	              moteText = format("%d", pfs:GetItemCount(188957))
                tt:AddLine("Number of collected Genesis Mote : "..moteText, 0.9, 0.9, 0.9)


            	  tt:AddLine(" ");
                tt:AddLine("Updating the list by opening the window.")
                tt:AddLine("|cffff8040Left Click|r to open with |cff32cd32ALL|r Mounts.")
                tt:AddLine("|cffff8040Right Click|r to open with |cff32cd32MISSING|r Mounts.")
            end,
        }) 
		    if LDBIcon then
        		LDBIcon:Register("ProtoformSynthesis", MinimapBtn, db)
		    end
    end
end

-- these are only registered while window on screen and simply update the list
function pfs:BAG_UPDATE_DELAYED()
    self:Update()
end
pfs.QUEST_TURNED_IN = pfs.BAG_UPDATE_DELAYED
pfs.QUEST_LOG_UPDATE = pfs.BAG_UPDATE_DELAYED

-- this is only registered while window on screen and updates the reagent bank while it updates the list
function pfs:PLAYERREAGENTBANKSLOTS_CHANGED()
    self:Update(true)
end

-- if a dressup modifier key goes down or up while mouse is over the list
function pfs:MODIFIER_STATE_CHANGED()
    if MouseIsOver(self.List) then
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

--[[ list ]]

-- fills the autoscrollframe reference list with itemIDs in the order they should be displayed
function pfs:PopulateList()
    local list = pfs.list
    wipe(list)
    -- no itemID is ever added or removed from the list after the first time; so only need to populate just once
    if #list==0 then
        for itemID,info in pairs(pfs.data) do
		        if info.mountID and pfs:MountExists(info.mountID) and HideMountCollected then
		            --only the missing mounts will be displayed
						else        	
		            tinsert(list,itemID)
		        end
        end
    end
    -- but we do want to sort it every time new schematics are possibly learned or names cached
    table.sort(list,pfs.SortList)
end

-- table.sort function used in PopulateList; sort by grid and then by name
function pfs.SortList(e1,e2)
    local info1 = pfs.data[e1]
    local info2 = pfs.data[e2]

    if info1 and not info2 then
        return true
    elseif not info1 and info2 then
        return false
    end

    -- sort by gitter next 
    if info1.latticeID and not info2.latticeID then
        return false
    elseif not info1.latticeID and info2.latticeID then
        return true
    elseif info1.latticeID~=info2.latticeID then
        return info1.latticeID < info2.latticeID
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
function pfs:FillListButton(itemID)
		local isUnknown, isUsable, errorText	
    local info = pfs.data[itemID]
    self.itemID = itemID
    self.speciesID = info.speciesID
    self.mountID = info.mountID

		-- at mount "Pale Regal Cervid" check if achievement is ready
		if itemID==187639 then
				local _,_,_,_,_,_,_,_,_,_,_,_,completed,_,_ = GetAchievementInfo(15402)
				if completed then
						isUnknown = false
				else
						isUnknown = true
				end
    else -- all other mounts
    		isUnknown = info.questID and not C_QuestLog.IsQuestFlaggedCompleted(info.questID) or false				
		end				

		-- determine if mount is usable
		if info.mountID ~= nil then
				local checkIndoors = false
				isUsable, errorText = C_MountJournal.GetMountUsabilityByID(info.mountID, checkIndoors)
		end

    -- fill in icon and texts
    self.Icon:SetTexture(info.icon)
    self.Name:SetText(info.itemName)
    self.MoteButton.Text:SetText(info.moteText)
    self.GlimmerButton.Icon:SetTexture(info.glimmerIcon)
    self.GlimmerButton.Text:SetText(info.glimmerText)
    self.LatticeButton.Text:SetText(info.latticeText)
    if isUsable then
        self.SIcon:SetTexture(sicon_built)
    elseif not isUnknown then
        if info.moteCount >= info.moteCost and info.glimmerCount > 0 and info.latticeCount > 0 then
        		self.SIcon:SetTexture(sicon_creatable)
        else
		        self.SIcon:SetTexture(sicon_gathering)
		    end
    else
        self.SIcon:SetTexture(sicon_unknown)
    end

    -- desaturate/color stuff based on whether this is a known/unknown item
    self.Icon:SetDesaturated(isUnknown)
    self.MoteButton.Icon:SetDesaturated(isUnknown)
    self.GlimmerButton.Icon:SetDesaturated(isUnknown)
    self.LatticeButton.Icon:SetDesaturated(isUnknown)
    self.MoteButton.Border:SetDesaturated(isUnknown)
    self.GlimmerButton.Border:SetDesaturated(isUnknown)
    self.LatticeButton.Border:SetDesaturated(isUnknown)
    self.Name:SetTextColor(pfs:GetButtonTextColor(isUnknown,false,isUsable))
    self.MoteButton.Text:SetTextColor(pfs:GetButtonTextColor(isUnknown,info.moteCount-info.moteCost+1,false))
    self.GlimmerButton.Text:SetTextColor(pfs:GetButtonTextColor(isUnknown,info.glimmerCount,false))
    self.LatticeButton.Text:SetTextColor(pfs:GetButtonTextColor(isUnknown,info.latticeCount,false))
    
    -- resize elements based on framewidth
    self.Name:SetWidth(pfs.maxNameWidth+pfs.padding)
    if pfs.alignReagents then -- if room for reagents to be aligned, use max width
        self.MoteButton:SetWidth(pfs.maxMoteWidth+24+pfs.padding)
        self.GlimmerButton:SetWidth(pfs.maxGlimmerWidth+24+pfs.padding)
        self.LatticeButton:SetWidth(pfs.maxLatticeWidth+24+pfs.padding)
    else -- otherwise use just enough width for reagent text + icon + padding
        self.MoteButton:SetWidth(info.moteWidth+24)
        self.GlimmerButton:SetWidth(info.glimmerWidth+24)
        self.LatticeButton:SetWidth(info.latticeWidth+24)
    end
    self.MoteButton:ClearAllPoints()
    if pfs.wideMode then -- if room for reagents to list to right of name, move reagents there
        self.Icon:SetSize(18,18)
        self.IconMask:SetSize(18,18)
        self.SIcon:SetSize(18,18)
        self.SIconMask:SetSize(18,18)
        self.Name:SetPoint("LEFT",26,0)
        self.MoteButton:SetPoint("LEFT",self.Name,"RIGHT",4,0)
    else -- otherwise position reagents beneath name
        self.Icon:SetSize(42,42)
        self.IconMask:SetSize(42,42)
        self.SIcon:SetSize(36,36)
        self.SIconMask:SetSize(42,42)
        self.Name:SetPoint("LEFT",48,9)
        self.MoteButton:SetPoint("BOTTOMLEFT",48,7)
    end
end

-- rather than calculate values in the FillListButton(), this gathers data for all rows
-- before the list updates, so it can set a max width for variable-width text fields
function pfs:GatherButtonData()
    local notCached = false
    local needsSorted = false
    pfs.maxNameWidth = 0
    pfs.maxMoteWidth = 0
    pfs.maxGlimmerWidth = 0
    pfs.maxLatticeWidth = 0
    local notCached = false
    -- gather data for each itemID in the data
    for itemID,info in pairs(pfs.data) do
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
            else -- strip out "Glimmer of " of glimmer name on English clients
                info.glimmerName = info.glimmerName:gsub("Glimmer of ","")
            end
        end
        if not info.latticeName then
            info.latticeName = GetItemInfo(info.latticeID)
            if not info.latticeName then
                notCached = true
            else -- strip out " Lattice" of lattice name on English clients
                info.latticeName = info.latticeName:gsub(" Lattice","")
            end
        end
        if not info.icon then
            info.icon = select(5,GetItemInfoInstant(itemID))
        end
        if not info.glimmerIcon then
		        info.glimmerIcon = select(5,GetItemInfoInstant(info.glimmerID))
        end
        info.moteCount = pfs:GetItemCount(188957)
        info.glimmerCount = pfs:GetItemCount(info.glimmerID)
        info.latticeCount = pfs:GetItemCount(info.latticeID)

        info.moteText = format("%d/%d ",info.moteCount,info.moteCost)
        info.glimmerText = format("%d/1 %s",info.glimmerCount,info.glimmerName or "")
        info.latticeText = format("%d/1 %s",info.latticeCount,info.latticeName or "")

        info.nameWidth = pfs:UpdateMaxWidth("maxNameWidth",info.itemName)
        info.moteWidth = pfs:UpdateMaxWidth("maxMoteWidth",info.moteText)
        info.glimmerWidth = pfs:UpdateMaxWidth("maxGlimmerWidth",info.glimmerText)
        info.latticeWidth = pfs:UpdateMaxWidth("maxLatticeWidth",info.latticeText)
    end
    -- the purpose of doing everything was to get max widths. the following notes adjustments based on that
    local frameWidth = pfs:GetWidth()
    local reagentWidth = pfs.maxMoteWidth+pfs.maxGlimmerWidth+pfs.maxLatticeWidth
    pfs.alignReagents = (frameWidth-reagentWidth)>163 -- if wide enough to let reagents have fixed width
    pfs.wideMode = (frameWidth-reagentWidth-pfs.maxNameWidth)>148 -- if wide enough to let reagents list to right of itemName
    -- padding is a small space added to widths so cells take up more space when it widens beyond minimum thresholds
    pfs.padding = max(0,pfs.wideMode and (frameWidth-pfs.maxNameWidth-reagentWidth-148)/4 or (frameWidth-reagentWidth-163)/3)
    if notCached then -- if any names are blank, come back in half a second to try again
        C_Timer.After(0.5,pfs.Update)
    elseif needsSorted then
        table.sort(pfs.list,pfs.SortList) 
    end
end

-- sets the text to a hidden and unbounded fontstring to get and record its max width
-- element can be "maxNameWidth","maxMoteWidth","maxGlimmerWidth","maxLatticeWidth"
function pfs:UpdateMaxWidth(element,text)
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

-- returns r,g,b for the color of text on a button based on whether it's known and has a count
function pfs:GetButtonTextColor(unknown,count,usable)
    if usable then	-- when usable/collected, green text
				return 0,1,0
    elseif unknown then -- whether a name or reagent, grey text if unknown
    		return 0.5,0.5,0.5
    elseif not count then -- known but a name (no count), gold text
      	return 1,0.82,0
    elseif count > 0 then -- known reagent with more than 0, white text
        return 0.9,0.9,0.9
    else -- known reagent with count==0, grey text
        return 0.5,0.5,0.5
    end
end

-- dynamicButtonHeight for autoscrollframe just returns height based on wideMode
function pfs:GetButtonHeight(index)
    return pfs.wideMode and 24 or 48
end

--[[ item counts ]]

-- populates pfs.bank with the count of reagents in the reagent bank
function pfs:UpdateReagentBank()
    wipe(pfs.bank)
    for i=1,GetContainerNumSlots(-3) do
        local itemID = GetContainerItemID(-3,i)
        if itemID and pfs.reagents[itemID] then -- only care if this is a known reagent
            local _,count = GetContainerItemInfo(-3,i)
            pfs.bank[itemID] = (pfs.bank[itemID] or 0) + count
        end
    end
end

-- wrapper for GetItemCount to also include reagent bank
function pfs:GetItemCount(itemID)
    local count = GetItemCount(itemID)
    if pfs.bank[itemID] then
        count = count + pfs.bank[itemID]
    end
    return count
end

-- checks if mount has already been learned
function pfs:MountExists(mountID)
    if mountID ~= nil then
        return mountID and select(11,C_MountJournal.GetMountInfoByID(mountID))
    end
end

--[[ ui script handlers ]]

function pfs:OnEvent(event,...)
    if self[event] then
        self[event](self,...)
    end
end

function pfs:OnShow()
    self:Update(true)
    self:RegisterEvent("BAG_UPDATE_DELAYED")
    self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
    self:RegisterEvent("QUEST_TURNED_IN")
    self:RegisterEvent("QUEST_LOG_UPDATE")
    self:RegisterEvent("MODIFIER_STATE_CHANGED")
end

function pfs:OnHide()
    self:UnregisterEvent("BAG_UPDATE_DELAYED")
    self:UnregisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
    self:UnregisterEvent("QUEST_TURNED_IN")
    self:UnregisterEvent("QUEST_LOG_UPDATE")
    self:UnregisterEvent("MODIFIER_STATE_CHANGED")
end

-- returns "ANCHOR_RIGHT" if main window is on left side of screen; "ANCHOR_LEFT" otherwise
function pfs:GetTooltipAnchor()
    local fx = pfs:GetCenter()*pfs:GetEffectiveScale()
    local ux = UIParent:GetCenter()*UIParent:GetEffectiveScale()
    return fx<ux and "ANCHOR_RIGHT" or "ANCHOR_LEFT"
end

function pfs:ListButtonOnEnter()
    self:SetBackdropBorderColor(0,0.75,1)
    if IsModifiedClick("DRESSUP") then
        ShowInspectCursor()
    else
        ResetCursor()
    end
    if self.itemID then
        GameTooltip:SetOwner(self,pfs:GetTooltipAnchor())
        GameTooltip:SetItemByID(self.itemID)
        GameTooltip:Show()
    end
end

function pfs:ListButtonOnLeave()
    self:SetBackdropBorderColor(0.3,0.3,0.3)
    ResetCursor()
    GameTooltip:Hide()
end

function pfs:ListButtonOnClick()
    if IsModifiedClick("DRESSUP") then
        if InCombatLockdown() then
            UIErrorsFrame:AddMessage("You are in combat",1,0,0)
        elseif self.speciesID then
            DressUpMount(self.mountID)
        end
    end
end
