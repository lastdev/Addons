-- Addon based on Ace3 addons like Bugsack, CoolGlow, SimulationCraft and many others

local _, CypherButton = ...
CypherButton = LibStub("AceAddon-3.0"):NewAddon(CypherButton, "CypherButton", "AceConsole-3.0", "AceEvent-3.0")

local GlobalProxy = { }

GlobalProxy._G = _G

setmetatable(GlobalProxy, {
	__index = function(self, key)
		local value = rawget(self,key)
		if (not value) then
			return _G[key]
		end
		return value
	end,
	__newindex = function(self, key, value)
		rawset(self, key, value)
	end
})

local C_GarrisonProxy = { }
GlobalProxy.C_Garrison = C_GarrisonProxy

setmetatable(C_GarrisonProxy, {
	__index = function(self, key)
		local value = rawget(self,key)
		if (not value) then
			return C_Garrison[key]
		end
		return value
	end,
	__newindex = function(self, key, value)
		rawset(self, key, value)
	end
})

local active = false
local hooked = false

function C_GarrisonProxy.GetCurrentGarrTalentTreeID()
	if (active) then
		return 474
	end
	return C_Garrison.GetCurrentGarrTalentTreeID()
end
local masked = false

---Minimap Broker inspired by countless ace3 addons like bugsack, simulationcraft, coolglow and others
CypherButtonLDB = LibStub("LibDataBroker-1.1"):NewDataObject("CypherButton", { 
	type = "data source", 
	text = "Cypher Research Console", 
	icon = "interface/icons/inv_prg_icon_puzzle07.blp", 
	OnClick = function()
		if (not hooked) then
			OrderHall_LoadUI()
			OrderHallTalentFrame:HookScript("OnHide", function()
				active = false
			end)
			setfenv(OrderHallTalentFrameMixin.RefreshAllData, GlobalProxy)
			setfenv(GarrisonTalentButtonMixin.OnEnter, GlobalProxy)
			hooked = true
		end
		if (OrderHallTalentFrame:IsShown()) then
			active = false
			ToggleOrderHallTalentUI();
		else
			active = true
			OrderHallTalentFrame:SetGarrisonType(111, 474);
			ToggleOrderHallTalentUI();
			OrderHallTalentFrame.portrait:SetTexture(4238797)
			if (not masked) then
				local mask = OrderHallTalentFrame:CreateMaskTexture("portraitMask", "OVERLAY")
				mask:SetAllPoints(OrderHallTalentFrame.portrait)
				mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				OrderHallTalentFrame.portrait:AddMaskTexture(mask)
			end
		end
	end,
	OnTooltipShow = function(tt)    
	tt:AddLine("Cypher Research Console")      
	tt:AddLine("Click to toggle your Cypher Research Console.") 
 end})
LibDBIcon = LibStub("LibDBIcon-1.0")

-- db implemention copied from simulationcraft
function CypherButton:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("CypherButtonDB", {
    profile = {
      minimap = {
        hide = false,
      },
      frame = {
        point = "CENTER",
        relativeFrame = nil,
        relativePoint = "CENTER",
        ofsx = 0,
        ofsy = 0,
        width = 750,
        height = 400,
      },
    },
  });
  LibDBIcon:Register("CypherButton", CypherButtonLDB, self.db.profile.minimap)
  CypherButton:RegisterChatCommand('CypherButton', 'HandleChatCommand')
end