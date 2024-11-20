local L = LibStub("AceLocale-3.0"):GetLocale("VaultButton", false)
VaultButton = {}
VaultButton.mainFrame = CreateFrame("Frame", "VaultButtonFrame", UIParent)

local _

local function printOperation(operation, command, description)
    print("|cffeded5f" .. operation .. " |cffed5f5f" .. command .. " |r- |cffeda55f".. description .. "|r")
end

local function openVaultUI()
	C_AddOns.LoadAddOn("Blizzard_WeeklyRewards");
	WeeklyRewardsFrame:SetShown(not WeeklyRewardsFrame:IsShown());
end

local function ToggleMinimapButton()

	if VaultButton.ldbIcon then

		VaultButtonDB.MinimapButton.hide = not VaultButtonDB.MinimapButton.hide

		if VaultButtonDB.MinimapButton.hide then
			VaultButton.ldbIcon:Hide("VaultButton")
		else
			VaultButton.ldbIcon:Show("VaultButton")
		end
	end
end

local AceGUI = LibStub("AceGUI-3.0")

local function OnEvent(self, event, arg1, arg2, arg3, ...)
	if event == "ADDON_LOADED" and arg1 == "VaultButton" then
		if VaultButtonDB == nil then
			VaultButtonDB = {}
    	end
    	if VaultButtonDB.MinimapButton == nil then
    		VaultButtonDB.MinimapButton = {hide = false,}
    	end
		
    	VaultButton.mainFrame:UnregisterEvent("ADDON_LOADED")

    	if VaultButton.DataBroker then
			VaultButton.DataBroker:UpdateText()
		end
	
		local ldbIcon = VaultButton.DataBroker and LibStub("LibDBIcon-1.0", true)
		if ldbIcon then
			ldbIcon:Register("VaultButton", VaultButton.DataBroker, VaultButtonDB.MinimapButton)
			VaultButton.ldbIcon = ldbIcon
		end		
    end
end

SLASH_VAULTBUTTON1 = "/vb"
SLASH_VAULTBUTTON2 = "/vaultbutton"
SlashCmdList["VAULTBUTTON"] = function(msg)

	if msg == "minimap" then
		ToggleMinimapButton(ldbIcon)
	else
		print("|cffeded5f=== |cffed5f5fM|cffeda55fminimap|cffed5f5fV|cffeda55fault |cffeded5f===|r")
		printOperation("/vb", "minimap", "Toggle minimap button")
	end
end

local ldb = LibStub("LibDataBroker-1.1")

local dataBroker = ldb:NewDataObject("VaultButton",
	{type = "launcher", label = "VB", text = "", icon = 237185}
)

function dataBroker.OnClick(self, button)
	openVaultUI()
end

function dataBroker.OnTooltipShow(tt)
	tt:AddLine("VaultButton")
	tt:AddLine(L["Click to access Vault window."], 0.2, 1, 0.2, 1)
end

function dataBroker.UpdateText(self)
	self.text = ""
end


VaultButton.DataBroker = dataBroker
VaultButton.mainFrame:RegisterEvent("ADDON_LOADED")
VaultButton.mainFrame:SetScript("OnEvent", OnEvent)

SLASH_RELOADUI1 = "/rl";
SlashCmdList["RELOADUI"] = ReloadUI;
