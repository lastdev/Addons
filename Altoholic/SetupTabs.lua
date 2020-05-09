--[[	*** Altoholic - SetupTabs.lua ***
Written by: Teelo
The purpose of this file is to extract the code I'm adding from Thaoky's original setup.
This file is here to make the number of tabs on the Altoholic window dynamic, so that there are no longer disabled tabs when an Altoholic module is disabled, and so tabs can be added without having to mess with Altoholic.xml.
--]]

local addonName = ...
local addon = _G[addonName]
local colors = addon.Colors

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local tabNames = {}

local function CalculateNumTotalTabs()
    -- Find out how many Altoholic_NAME addons are running
    for i = 1, GetNumAddOns() do
        if string.sub(GetAddOnInfo(i), 1, #(addonName.."_")) == (addonName.."_") then
            if (GetAddOnEnableState(nil, i) ~= 0) then
                table.insert(tabNames, string.sub(GetAddOnInfo(i), (#(addonName.."_")+1), #GetAddOnInfo(i)))
            end
        end 
    end
end

function addon.GetNumTotalTabs()
    if #tabNames == 0 then
        CalculateNumTotalTabs()
    end
    return #tabNames
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
            <Button name="$parentTab3" inherits="AltoTabTemplate" id="3" text="SEARCH">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab2" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Search" />
				</KeyValues>
			</Button>
			<Button name="$parentTab4" inherits="AltoTabTemplate" id="4" text="GUILD">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab3" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Guild" />
				</KeyValues>
			</Button>
			<Button name="$parentTab5" inherits="AltoTabTemplate" id="5" text="ACHIEVEMENT_BUTTON">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab4" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Achievements" />
				</KeyValues>
			</Button>
			<Button name="$parentTab6" inherits="AltoTabTemplate" id="6">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab5" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Agenda" />
				</KeyValues>
			</Button>
			<Button name="$parentTab7" inherits="AltoTabTemplate" id="7">
				<Anchors>
					<Anchor point="TOPLEFT" relativeTo="$parentTab6" relativePoint="TOPRIGHT" x="-8" y="0" />
				</Anchors>
				<KeyValues>
					<KeyValue key="context" value="Grids" />
				</KeyValues>
			</Button>
--]]

local function applyDefaultTabNameSorting()
    -- Default order should be: Summary, Characters, Search, Guild, Achievements, Agenda, Grids, then any new ones made
    local defaultTabNames = {"Summary", "Characters", "Search", "Guild", "Achievements", "Agenda", "Grids"}
    local newTabNames = {}

    -- Add all the default tabs that exist
    for i = 1, #defaultTabNames do
        for j = 1, #tabNames do
            if (defaultTabNames[i] == tabNames[j]) then
                table.insert(newTabNames, tabNames[j])
                table.remove(tabNames, j)
                break
            end
        end
    end
    
    -- Next, add all new tabs that werent in the default list
    for i = 1, #tabNames do
        table.insert(newTabNames, tabNames[i])
    end
    
    tabNames = newTabNames
end

function addon:GetTabList()
    return tabNames
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
        buttonFrame:SetText(tabNames[i])
        buttonFrame.context = tabNames[i]
    end
end