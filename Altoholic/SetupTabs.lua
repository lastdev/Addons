--[[	*** Altoholic - SetupTabs.lua ***
Written by: Teelo
The purpose of this file is to extract the code I'm adding from Thaoky's original setup.
This file is here to make the number of tabs on the Altoholic window dynamic, so that there are no longer disabled tabs when an Altoholic module is disabled, and so tabs can be added without having to mess with Altoholic.xml.
--]]

local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local tabNamesLocal = {}
local tabNamesEnglish = {}

local function CalculateNumTotalTabs()
    -- Find out how many Altoholic_NAME addons are running
    for i = 1, GetNumAddOns() do
        if string.sub(GetAddOnInfo(i), 1, #(addonName.."_")) == (addonName.."_") then
            if (GetAddOnEnableState(nil, i) ~= 0) then
                local englishTabName = string.sub(GetAddOnInfo(i), (#(addonName.."_")+1), #GetAddOnInfo(i))
                table.insert(tabNamesLocal, L[englishTabName])
                table.insert(tabNamesEnglish, englishTabName)
            end
        end 
    end
end

function addon.GetNumTotalTabs()
    if #tabNamesEnglish == 0 then
        CalculateNumTotalTabs()
    end
    return #tabNamesEnglish
end

	--[[
    Attempt to generate XML that replicates this:
    		<Button name="$parentTab1" inherits="AltoTabTemplate" id="1">
				<Anchors>
					<Anchor point="TOPLEFT" relativePoint="BOTTOMLEFT" x="15" y="11" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Summary" />
				</KeyValues>
			</Button>
            <Button name="$parentTab2" inherits="AltoTabTemplate" id="2">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab1" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Characters" />
				</KeyValues>
			</Button>
    (and so on)
--]]

local function applyDefaultTabNameSorting()
    -- Default order should be: Summary, Characters, Search, Guild, Achievements, Agenda, Grids, then any new ones made
    local defaultTabNames = {"Summary", "Characters", "Search", "Guild", "Achievements", "Agenda", "Grids"}
    local newTabNamesLocal = {}
    local newTabNamesEnglish = {}

    -- Add all the default tabs that exist
    for i = 1, #defaultTabNames do
        for j = 1, #tabNamesLocal do
            if (defaultTabNames[i] == tabNamesEnglish[j]) then
                table.insert(newTabNamesLocal, tabNamesLocal[j])
                table.insert(newTabNamesEnglish, tabNamesEnglish[j])
                table.remove(tabNamesLocal, j)
                table.remove(tabNamesEnglish, j)
                break
            end
        end
    end
    
    -- Next, add all new tabs that werent in the default list
    for i = 1, #tabNamesLocal do
        table.insert(newTabNamesLocal, tabNamesLocal[i])
        table.insert(newTabNamesEnglish, tabNamesEnglish[i])
    end
    
    tabNamesLocal = newTabNamesLocal
    tabNamesEnglish = newTabNamesEnglish
end

function addon:GetLocalTabList()
    return tabNamesLocal
end

function addon:GetEnglishTabList()
    return tabNamesEnglish
end

function addon:SetupTabs(frame)
    PanelTemplates_SetNumTabs(frame, addon.GetNumTotalTabs())
    applyDefaultTabNameSorting()
    for i = 1, addon.GetNumTotalTabs() do
        local buttonFrame = CreateFrame("Button", (frame:GetName().."Tab"..i), frame, "AltoTabTemplate")
        buttonFrame:SetID(i)
        if i == 1 then
            buttonFrame:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 15, 11)
        else
            buttonFrame:SetPoint("TOPLEFT", (frame:GetName().."Tab"..(i-1)), "TOPRIGHT", -8, 0)
        end
        buttonFrame:SetText(tabNamesLocal[i])
        buttonFrame.context = tabNamesEnglish[i]
    end
end