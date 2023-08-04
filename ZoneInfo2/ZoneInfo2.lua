--[[
Name: ZoneInfo 2
Revision: $Rev: 127 $
Author: Odica; based on the ZoneInfo module of Cartographer 2 by ckknight
SVN: svn://svn.wowace.com/wow/libtourist-3-0/mainline/trunk
Description: Addon that will show levels and other information about the zone being displayed on the World Map.
License: MIT
]]

local _

local function trace(msg)
--	DEFAULT_CHAT_FRAME:AddMessage("ZI: "..msg)
end

if not ZoneInfo then
	ZoneInfo = LibStub("AceAddon-3.0"):NewAddon("ZoneInfo", "AceHook-3.0")
	local ZoneInfo, self = ZoneInfo, ZoneInfo
end

local ZoneInfoDataProvider = CreateFromMixins(MapCanvasDataProviderMixin)
local Tourist = LibStub("LibTourist-3.0")

local t = {}
local frameHeight = 0

local GAME_LOCALE = GetLocale()

local translations = {
	koKR = {
		["ZoneInfo"] = "지역 정보",
		["Transports"] = "교통",
		["Instances"] = "인스턴스",
		["Flight nodes"] = "비행 노드",
		["Fishing"] = "낚시",
		["Herbalism"] = "약초채집",
		["Mining"] = "채광",
		["Skinning"] = "무두질",
		["man"] = "명",
		["Travel advice"] = "여행 조언",
	},
	deDE = {
		["ZoneInfo"] = "Zoneninfo",
		["Transports"] = "Transporte",
		["Instances"] = "Instanzen",
		["Flight nodes"] = "Flugknoten",
		["Fishing"] = "Angeln",
		["Herbalism"] = "Kräuterkunde",
		["Mining"] = "Bergbau",
		["Skinning"] = "Kürschnerei",
		["man"] = "Spieler",
		["Travel advice"] = "Reisetipps",
	},
	frFR = {
		["ZoneInfo"] = "Infos de zone",
		["Transports"] = "Transports",
		["Instances"] = "Instances",
		["Flight nodes"] = "Nœuds de vol",
		["Fishing"] = "Pêche",
		["Herbalism"] = "Herboristerie",
		["Mining"] = "Minage",
		["Skinning"] = "Dépeçage",
		["man"] = "j",
		["Travel advice"] = "Conseils de voyage",
	},
	esES = {
		["ZoneInfo"] = "Información de la Zona",
		["Transports"] = "Transportes",
		["Instances"] = "Instancias",
		["Flight nodes"] = "Nodos de vuelo",
		["Fishing"] = "Pesca",
		["Herbalism"] = "Herboristería",
		["Mining"] = "Minería",
		["Skinning"] = "Desuello",
		["man"] = "hombres",
		["Travel advice"] = "Consejos de viaje",
	},
	esMX = {
		["ZoneInfo"] = "Información de la Zona",
		["Transports"] = "Transportes",
		["Instances"] = "Instancias",
		["Flight nodes"] = "Nodos de vuelo",
		["Fishing"] = "Pescar",
		["Herbalism"] = "Herboristería",
		["Mining"] = "Minería",
		["Skinning"] = "Desuello",
		["man"] = "hombres",
		["Travel advice"] = "Consejos de viaje",
	},
	itIT = {
		["ZoneInfo"] = "Informazioni sulla zona",
		["Transports"] = "Trasporti",
		["Instances"] = "Istanze",
		["Flight nodes"] = "Nodi di volo",
		["Fishing"] = "Pesca",
		["Herbalism"] = "Erboristeria",
		["Mining"] = "Estrazione",
		["Skinning"] = "Scuoiatura",
		["man"] = "persone",
		["Travel advice"] = "Consigli di viaggio",
	},
	ptBR = {
		["ZoneInfo"] = "Informações da zona",
		["Transports"] = "Transportes",
		["Instances"] = "Instâncias",
		["Flight nodes"] = "Nós de voo",
		["Fishing"] = "Pescaria",
		["Herbalism"] = "Herbalismo",
		["Mining"] = "Mineração",
		["Skinning"] = "Esfola",
		["man"] = "pessoas",
		["Travel advice"] = "Recomendações de viagem",
	},		
	zhTW = {
		["ZoneInfo"] = "地區資訊",
		["Transports"] = "運輸工具",
		["Instances"] = "副本",
		["Flight nodes"] = "飛行節點",
		["Fishing"] = "釣魚",
		["Herbalism"] = "草藥學",
		["Mining"] = "採礦",
		["Skinning"] = "剝皮",
		["man"] = "人",
		["Travel advice"] = "旅遊建議",
	},
	zhCN = {
		["ZoneInfo"] = "区域信息",
		["Transports"] = "运输",
		["Instances"] = "副本",
		["Flight nodes"] = "飞行节点",
		["Fishing"] = "钓鱼",
		["Herbalism"] = "草药学",
		["Mining"] = "采矿",
		["Skinning"] = "剥皮",
		["man"] = "人",
		["Travel advice"] = "旅游建议",
	},
}

local function L(tag)
	if translations[GAME_LOCALE] then
		return translations[GAME_LOCALE][tag] or tag
	else
		return tag -- English
	end
end

local function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function GetScaleValuesForText(panelSize)
	return panelSize * 0.8, panelSize * 0.5
end

local templateLoaded = false
function ZoneInfoDataProvider:SaveSettings()
	-- Save and apply settings
	ZISettings.ShowBackground = ZoneInfo_chkShowBackground:GetChecked()
	ZISettings.BackgroundOpacity = ZoneInfo_sldBackgroundOpacity:GetValue() / 100
	ZISettings.PanelSize = ZoneInfo_sldPanelSize:GetValue() / 100
	
	ZISettings.ShowFishing = ZoneInfo_chkShowFishing:GetChecked()
	ZISettings.ShowHerbalism = ZoneInfo_chkShowHerbalism:GetChecked()
	ZISettings.ShowMining = ZoneInfo_chkShowMining:GetChecked()
	ZISettings.ShowSkinning = ZoneInfo_chkShowSkinning:GetChecked()
	ZISettings.ShowBattlePets = ZoneInfo_chkShowBattlePets:GetChecked()
	ZISettings.ShowTransports = ZoneInfo_chkShowTransports:GetChecked()
	ZISettings.ShowRoadConnections = ZoneInfo_chkShowRoadConnections:GetChecked()
	ZISettings.ShowInstances = ZoneInfo_chkShowInstances:GetChecked()
	ZISettings.ShowFlightnodes = ZoneInfo_chkShowFlightnodes:GetChecked()
	ZISettings.ShowTravelAdvice = ZoneInfo_chkShowTravelAdvice:GetChecked()

	if templateLoaded == true then
		-- Apply the settings from the template that are not in the settings dialog
		ZISettings.LockMovablePanel = ZIGlobalSettings.Template.LockMovablePanel
		ZISettings.PanelPositionX = ZIGlobalSettings.Template.PanelPositionX
		ZISettings.PanelPositionY = ZIGlobalSettings.Template.PanelPositionY
		ZISettings.ShowFrame = ZIGlobalSettings.Template.ShowFrame
	end

	if ZISettings.AttachPanelToWorldMap ~= ZoneInfo_chkAttachPanelToWorldMap:GetChecked() then
		if ZoneInfo_chkAttachPanelToWorldMap:GetChecked() == true then
			-- Attach to map turned on
			ZISettings.AttachPanelToWorldMap = true
			ZoneInfoDataProvider:ResetZIPanelPosition()  -- Position in top left corner of the world map
		else
			-- Attach turned off
			ZISettings.AttachPanelToWorldMap = false
			if templateLoaded == false then
				-- Unlock
				ZISettings.LockMovablePanel = false
				-- Get and apply current position
				local _, _, _, xOfs, yOfs = ZoneInfoDataProvider.frame:GetPoint() -- Get position offsets related to the screen
				ZoneInfoDataProvider.frame:ClearAllPoints()
				ZoneInfoDataProvider.frame:SetPoint(
					"TOPLEFT",
					UIParent,
					xOfs,
					yOfs
				)
			end
		end
	end

	if templateLoaded == true and ZISettings.AttachPanelToWorldMap == false then
		-- Apply position from template
		ZoneInfoDataProvider.frame:ClearAllPoints()
		ZoneInfoDataProvider.frame:SetPoint(
			"TOPLEFT",
			UIParent,
			ZISettings.PanelPositionX,
			ZISettings.PanelPositionY
		)
	end

	if ZISettings.ShowBackground == true then
		ZoneInfoDataProvider.frame:SetBackdropColor(0,0,0,ZISettings.BackgroundOpacity)
		ZoneInfoDataProvider.frame:SetBackdropBorderColor(0,0,0,ZISettings.BackgroundOpacity)
	else
		ZoneInfoDataProvider.frame:SetBackdropColor(0,0,0,0)
		ZoneInfoDataProvider.frame:SetBackdropBorderColor(0,0,0,0)		
	end
	
	if ZISettings.ShowFrame == true then
		ZoneInfoDataProvider:OpenZIPanel()
	else
		ZoneInfoDataProvider:HideZIPanel()
	end

	if ZISettings.ShowFrame == false or ZISettings.AttachPanelToWorldMap == true then
		ZoneInfo_cmdLockMovablePanel:Hide()
	else
		ZoneInfo_cmdLockMovablePanel:Show()
	end	

	if ZISettings.LockMovablePanel == true then
		ZoneInfo_cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Locked-Up")
	else
		ZoneInfo_cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Unlocked-Up")
	end	
	ZoneInfoDataProvider.frame:SetMovable(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
	ZoneInfoDataProvider.frame:EnableMouse(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)

	local headerScale, detailsScale = GetScaleValuesForText(ZISettings.PanelSize)
	ZoneInfoDataProvider.headerText:SetScale(headerScale)
	ZoneInfoDataProvider.detailsText:SetScale(detailsScale)
	ZoneInfo_cmdShowFrame:SetScale(ZISettings.PanelSize)
	ZoneInfo_cmdLockMovablePanel:SetScale(ZISettings.PanelSize * 1.25)

	-- Reset flag
	templateLoaded = false
	DEFAULT_CHAT_FRAME:AddMessage("ZoneInfo: Settings applied and saved")
end

function ZoneInfoDataProvider:CancelChanges()
	-- Reset options UI to saved values
	ZoneInfo_chkShowBackground:SetChecked(ZISettings.ShowBackground)
	ZoneInfo_sldBackgroundOpacity:SetValue(ZISettings.BackgroundOpacity * 100)
	ZoneInfo_sldPanelSize:SetValue(ZISettings.PanelSize * 100)
	ZoneInfo_chkAttachPanelToWorldMap:SetChecked(ZISettings.AttachPanelToWorldMap)
	ZoneInfo_cmdResetZIPanelPosition:SetEnabled(not ZoneInfo_chkAttachPanelToWorldMap:GetChecked())
	ZoneInfo_chkShowFishing:SetChecked(ZISettings.ShowFishing)
	ZoneInfo_chkShowHerbalism:SetChecked(ZISettings.ShowHerbalism)
	ZoneInfo_chkShowMining:SetChecked(ZISettings.ShowMining)
	ZoneInfo_chkShowSkinning:SetChecked(ZISettings.ShowSkinning)
	ZoneInfo_chkShowBattlePets:SetChecked(ZISettings.ShowBattlePets)
	ZoneInfo_chkShowTransports:SetChecked(ZISettings.ShowTransports)
	ZoneInfo_chkShowRoadConnections:SetChecked(ZISettings.ShowRoadConnections)
	ZoneInfo_chkShowInstances:SetChecked(ZISettings.ShowInstances)
	ZoneInfo_chkShowFlightnodes:SetChecked(ZISettings.ShowFlightnodes)
	ZoneInfo_chkShowTravelAdvice:SetChecked(ZISettings.ShowTravelAdvice)
end


local function CheckZISettings(settings)
	if settings == nil then settings = {} end

	if settings.ShowBackground == nil then settings.ShowBackground = true end
	if settings.BackgroundOpacity == nil or settings.BackgroundOpacity < 0 or settings.BackgroundOpacity > 1 then settings.BackgroundOpacity = 0.5 end
	if settings.PanelSize == nil or settings.PanelSize < 0.4 or settings.PanelSize > 1.2 then settings.PanelSize = 0.8 end
	if settings.AttachPanelToWorldMap == nil then settings.AttachPanelToWorldMap = true end
	if settings.ShowFishing == nil then settings.ShowFishing = true end
	if settings.ShowHerbalism == nil then settings.ShowHerbalism = true end
	if settings.ShowMining == nil then settings.ShowMining = true end
	if settings.ShowSkinning == nil then settings.ShowSkinning = true end
	if settings.ShowBattlePets == nil then settings.ShowBattlePets = true end
	if settings.ShowTransports == nil then settings.ShowTransports = true end
	if settings.ShowRoadConnections == nil then settings.ShowRoadConnections = true end
	if settings.ShowInstances == nil then settings.ShowInstances = true end
	if settings.ShowFlightnodes == nil then settings.ShowFlightnodes = true end
	if settings.ShowTravelAdvice  == nil then settings.ShowTravelAdvice = true end

	if settings.LockMovablePanel == nil then settings.LockMovablePanel = false end
	if settings.PanelPositionX == nil then settings.PanelPositionX = 10 end
	if settings.PanelPositionY == nil then settings.PanelPositionY = -35 end
	if settings.ShowFrame == nil then settings.ShowFrame = true end
	
	return settings
end



function ZoneInfoDataProvider:SaveZITemplate()
	-- Copy settings from UI to template
	if ZIGlobalSettings.Template == nil then ZIGlobalSettings.Template = {} end
	
	ZIGlobalSettings.Template.ShowBackground = ZoneInfo_chkShowBackground:GetChecked()
	ZIGlobalSettings.Template.BackgroundOpacity = ZoneInfo_sldBackgroundOpacity:GetValue() / 100
	ZIGlobalSettings.Template.PanelSize = ZoneInfo_sldPanelSize:GetValue() / 100
	ZIGlobalSettings.Template.AttachPanelToWorldMap = ZoneInfo_chkAttachPanelToWorldMap:GetChecked()
	ZIGlobalSettings.Template.ShowFishing = ZoneInfo_chkShowFishing:GetChecked()
	ZIGlobalSettings.Template.ShowHerbalism = ZoneInfo_chkShowHerbalism:GetChecked()
	ZIGlobalSettings.Template.ShowMining = ZoneInfo_chkShowMining:GetChecked()
	ZIGlobalSettings.Template.ShowSkinning = ZoneInfo_chkShowSkinning:GetChecked()
	ZIGlobalSettings.Template.ShowBattlePets = ZoneInfo_chkShowBattlePets:GetChecked()
	ZIGlobalSettings.Template.ShowTransports = ZoneInfo_chkShowTransports:GetChecked()
	ZIGlobalSettings.Template.ShowRoadConnections = ZoneInfo_chkShowRoadConnections:GetChecked()
	ZIGlobalSettings.Template.ShowInstances = ZoneInfo_chkShowInstances:GetChecked()
	ZIGlobalSettings.Template.ShowFlightnodes = ZoneInfo_chkShowFlightnodes:GetChecked()
	ZIGlobalSettings.Template.ShowTravelAdvice = ZoneInfo_chkShowTravelAdvice:GetChecked()
	
	ZIGlobalSettings.Template.LockMovablePanel = ZISettings.LockMovablePanel
	ZIGlobalSettings.Template.PanelPositionX = ZISettings.PanelPositionX
	ZIGlobalSettings.Template.PanelPositionY = ZISettings.PanelPositionY
	ZIGlobalSettings.Template.ShowFrame = ZISettings.ShowFrame
	
	DEFAULT_CHAT_FRAME:AddMessage("ZoneInfo: Template saved")
end

function ZoneInfoDataProvider:LoadZITemplate()
	-- Copy settings from template to UI
	ZoneInfo_chkShowBackground:SetChecked(ZIGlobalSettings.Template.ShowBackground)
	ZoneInfo_sldBackgroundOpacity:SetValue(ZIGlobalSettings.Template.BackgroundOpacity * 100)
	ZoneInfo_sldPanelSize:SetValue(ZIGlobalSettings.Template.PanelSize * 100)
	ZoneInfo_chkAttachPanelToWorldMap:SetChecked(ZIGlobalSettings.Template.AttachPanelToWorldMap)
	ZoneInfo_cmdResetZIPanelPosition:SetEnabled(not ZoneInfo_chkAttachPanelToWorldMap:GetChecked())
	ZoneInfo_chkShowFishing:SetChecked(ZIGlobalSettings.Template.ShowFishing)
	ZoneInfo_chkShowHerbalism:SetChecked(ZIGlobalSettings.Template.ShowHerbalism)
	ZoneInfo_chkShowMining:SetChecked(ZIGlobalSettings.Template.ShowMining)
	ZoneInfo_chkShowSkinning:SetChecked(ZIGlobalSettings.Template.ShowSkinning)
	ZoneInfo_chkShowBattlePets:SetChecked(ZIGlobalSettings.Template.ShowBattlePets)
	ZoneInfo_chkShowTransports:SetChecked(ZIGlobalSettings.Template.ShowTransports)
	ZoneInfo_chkShowRoadConnections:SetChecked(ZIGlobalSettings.Template.ShowRoadConnections)
	ZoneInfo_chkShowInstances:SetChecked(ZIGlobalSettings.Template.ShowInstances)
	ZoneInfo_chkShowFlightnodes:SetChecked(ZIGlobalSettings.Template.ShowFlightnodes)
	ZoneInfo_chkShowTravelAdvice:SetChecked(ZIGlobalSettings.Template.ShowTravelAdvice)
	
	-- Apply non visible settings when the dialog is confirmed
	templateLoaded = true
	
	DEFAULT_CHAT_FRAME:AddMessage("ZoneInfo: Template loaded")
end







function ZoneInfo:OnInitialize()
	trace("OnInitialize")
	self.name = L("ZoneInfo")
	self.title = L("ZoneInfo")
	
	if ZIGlobalSettings == nil then ZIGlobalSettings = {} end
	ZIGlobalSettings.Template = CheckZISettings(ZIGlobalSettings.Template)
	ZISettings = CheckZISettings(ZISettings)
	
	
	-- Register a panel in the Interface Addon Options GUI
	ZoneInfo.panel = CreateFrame( "Frame", "ZoneInfoPanel", UIParent );
	ZoneInfo.panel.name = L("ZoneInfo");
	--ZoneInfo.panel.okay = function (self) ZoneInfoPanel_Close() end  -- OK button removed in 10.0.0?
	--ZoneInfo.panel.cancel = function (self) ZoneInfoPanel_Cancel() end  -- Cancel removed in 10.0.0?

	local panelBackground = ZoneInfo.panel:CreateTexture()
	panelBackground:SetAllPoints(ZoneInfo.panel)
	panelBackground:SetColorTexture(0, 0, 0, 0.5)



	-- Setting: Show Background
	local chkShowBackground = CreateFrame("CheckButton", "ZoneInfo_chkShowBackground", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowBackground:SetPoint("TOPLEFT", 20, -20)
	ZoneInfo_chkShowBackgroundText:SetText(" Show background")
	chkShowBackground.tooltip = "Displays the Zone Information on a semi-transparent background"
	chkShowBackground:SetChecked(ZISettings.ShowBackground)
	
	-- Setting: Background Opacity
	local sldBackgroundOpacity = CreateFrame("Slider", "ZoneInfo_sldBackgroundOpacity", ZoneInfo.panel, "OptionsSliderTemplate")
	sldBackgroundOpacity:SetPoint("TOPLEFT", 20, -60)
	sldBackgroundOpacity:SetOrientation('HORIZONTAL')
	sldBackgroundOpacity:SetWidth(180)
	sldBackgroundOpacity:SetHeight(20)
	ZoneInfo_sldBackgroundOpacityLow:SetText("0%")
	ZoneInfo_sldBackgroundOpacityHigh:SetText("100%")
	ZoneInfo_sldBackgroundOpacityText:SetText("Background opacity ("..tostring(round(ZISettings.BackgroundOpacity * 100, 0)).."%)" )
	sldBackgroundOpacity.tooltipText = "Adjust the opacity of the background, where 0% is transparent and 100% is solid black"
	sldBackgroundOpacity:SetMinMaxValues(0, 100)
	sldBackgroundOpacity:SetValue(ZISettings.BackgroundOpacity * 100)
	sldBackgroundOpacity:SetScript("OnValueChanged", 
		function(self, value)
			ZoneInfo_sldBackgroundOpacityText:SetText("Background opacity ("..tostring(round(value, 0)).."%)" )
		end);
		
	-- Setting: Panel Size
	local sldPanelSize = CreateFrame("Slider", "ZoneInfo_sldPanelSize", ZoneInfo.panel, "OptionsSliderTemplate")
	sldPanelSize:SetPoint("TOPLEFT", 20, -100)
	sldPanelSize:SetOrientation('HORIZONTAL')
	sldPanelSize:SetWidth(180)
	sldPanelSize:SetHeight(20)
	ZoneInfo_sldPanelSizeLow:SetText("40%")
	ZoneInfo_sldPanelSizeHigh:SetText("120%")
	ZoneInfo_sldPanelSizeText:SetText("Panel size ("..tostring(round(ZISettings.PanelSize * 100, 0)).."%)" )
	sldPanelSize.tooltipText = "Adjust the size of the ZoneInfo panel"
	sldPanelSize:SetMinMaxValues(40, 120)
	sldPanelSize:SetValue(ZISettings.PanelSize * 100)
	sldPanelSize:SetScript("OnValueChanged", 
		function(self, value)
			ZoneInfo_sldPanelSizeText:SetText("Panel size ("..tostring(round(value, 0)).."%)" )
		end);
		
		
	-- Setting: AttachPanelToWorldMap
	local chkAttachPanelToWorldMap = CreateFrame("CheckButton", "ZoneInfo_chkAttachPanelToWorldMap", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkAttachPanelToWorldMap:SetPoint("TOPLEFT", 20, -140)
	ZoneInfo_chkAttachPanelToWorldMapText:SetText(" Attach panel to World Map")
	chkAttachPanelToWorldMap.tooltip = "Uncheck to make the panel movable"
	chkAttachPanelToWorldMap:SetChecked(ZISettings.AttachPanelToWorldMap)
	chkAttachPanelToWorldMap:SetScript("OnClick", 
		function(self, value)
			ZoneInfo_cmdResetZIPanelPosition:SetEnabled(not ZoneInfo_chkAttachPanelToWorldMap:GetChecked())
		end);
		
	-- Button: Reset Position
	local cmdResetZIPanelPosition = CreateFrame("Button", "ZoneInfo_cmdResetZIPanelPosition", ZoneInfo.panel, "UIPanelButtonTemplate");
	cmdResetZIPanelPosition:SetPoint("TOPLEFT", 240, -140)
	cmdResetZIPanelPosition:SetText("Reset position")
	cmdResetZIPanelPosition.tooltipText = "Reset the penel position to the top left of the screen"
	cmdResetZIPanelPosition:SetWidth(120)
	cmdResetZIPanelPosition:SetHeight(22)
	cmdResetZIPanelPosition:SetScript("OnClick", 
		function(self, value)
			ZoneInfoDataProvider:ResetZIPanelPosition()
		end);		
	cmdResetZIPanelPosition:SetEnabled(not chkAttachPanelToWorldMap:GetChecked())
				
	-- Setting: Show BattlePets
	local chkShowBattlePets = CreateFrame("CheckButton", "ZoneInfo_chkShowBattlePets", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowBattlePets:SetPoint("TOPLEFT", 20, -180)
	ZoneInfo_chkShowBattlePetsText:SetText(" Show battle pet level")
	chkShowBattlePets.tooltip = "Displays the level of the battle pets"
	chkShowBattlePets:SetChecked(ZISettings.ShowBattlePets)

	-- Setting: Show Fishing
	local chkShowFishing = CreateFrame("CheckButton", "ZoneInfo_chkShowFishing", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowFishing:SetPoint("TOPLEFT", 20, -210)
	ZoneInfo_chkShowFishingText:SetText(" Show fishing skill")
	chkShowFishing.tooltip = "Displays the name and level of the fishing skill required for the selected zone"
	chkShowFishing:SetChecked(ZISettings.ShowFishing)

	-- Setting: Show Herbalism
	local chkShowHerbalism = CreateFrame("CheckButton", "ZoneInfo_chkShowHerbalism", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowHerbalism:SetPoint("TOPLEFT", 20, -240)
	ZoneInfo_chkShowHerbalismText:SetText(" Show herbalism skill")
	chkShowHerbalism.tooltip = "Displays the name and level of the herbalism skill required for the selected zone"
	chkShowHerbalism:SetChecked(ZISettings.ShowHerbalism)
	
	-- Setting: Show Mining
	local chkShowMining = CreateFrame("CheckButton", "ZoneInfo_chkShowMining", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowMining:SetPoint("TOPLEFT", 20, -270)
	ZoneInfo_chkShowMiningText:SetText(" Show mining skill")
	chkShowMining.tooltip = "Displays the name and level of the mining skill required for the selected zone"
	chkShowMining:SetChecked(ZISettings.ShowMining)

	-- Setting: Show Skinning
	local chkShowSkinning = CreateFrame("CheckButton", "ZoneInfo_chkShowSkinning", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowSkinning:SetPoint("TOPLEFT", 20, -300)
	ZoneInfo_chkShowSkinningText:SetText(" Show skinning skill")
	chkShowSkinning.tooltip = "Displays the name and level of the skinning skill required for the selected zone"
	chkShowSkinning:SetChecked(ZISettings.ShowSkinning)

	-- Setting: Show Transports
	local chkShowTransports = CreateFrame("CheckButton", "ZoneInfo_chkShowTransports", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowTransports:SetPoint("TOPLEFT", 20, -330)
	ZoneInfo_chkShowTransportsText:SetText(" Show transports")
	chkShowTransports.tooltip = "Displays a list of transports like boats and zeppelins"
	chkShowTransports:SetChecked(ZISettings.ShowTransports)

	-- Setting: Show Road Connections
	local chkShowRoadConnections = CreateFrame("CheckButton", "ZoneInfo_chkShowRoadConnections", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowRoadConnections:SetPoint("TOPLEFT", 20, -360)
	ZoneInfo_chkShowRoadConnectionsText:SetText(" Show road connections")
	chkShowRoadConnections.tooltip = "Displays connections with adjacent zones by road"
	chkShowRoadConnections:SetChecked(ZISettings.ShowRoadConnections)	
	
	-- Setting: Show Instances
	local chkShowInstances = CreateFrame("CheckButton", "ZoneInfo_chkShowInstances", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowInstances:SetPoint("TOPLEFT", 20, -390)
	ZoneInfo_chkShowInstancesText:SetText(" Show instances")
	chkShowInstances.tooltip = "Displays a list of instances with their level and size"
	chkShowInstances:SetChecked(ZISettings.ShowInstances)		

	-- Setting: Show Flightnodes
	local chkShowFlightnodes = CreateFrame("CheckButton", "ZoneInfo_chkShowFlightnodes", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowFlightnodes:SetPoint("TOPLEFT", 20, -420)
	ZoneInfo_chkShowFlightnodesText:SetText(" Show flight nodes")
	chkShowFlightnodes.tooltip = "Displays a list of flight nodes within the selected zone"
	chkShowFlightnodes:SetChecked(ZISettings.ShowFlightnodes)		
	
	-- Setting: Show Travel Advice
	local chkShowTravelAdvice = CreateFrame("CheckButton", "ZoneInfo_chkShowTravelAdvice", ZoneInfo.panel, "ChatConfigCheckButtonTemplate");
	chkShowTravelAdvice:SetPoint("TOPLEFT", 20, -450)
	ZoneInfo_chkShowTravelAdviceText:SetText(" Show travel advice")
	chkShowTravelAdvice.tooltip = "Suggests a travel route from your position to the selected zone using road connections and transports"
	chkShowTravelAdvice:SetChecked(ZISettings.ShowTravelAdvice)	
	
	
	-- Button: Save to template
	local cmdSaveZITemplate = CreateFrame("Button", "ZoneInfo_cmdSaveZITemplate", ZoneInfo.panel, "UIPanelButtonTemplate");
	cmdSaveZITemplate:SetPoint("TOPLEFT", 20, -490)
	cmdSaveZITemplate:SetText("Save to template")
	cmdSaveZITemplate.tooltipText = "Save the current settings to the template so they can be used for other characters"
	cmdSaveZITemplate:SetWidth(120)
	cmdSaveZITemplate:SetHeight(22)
	cmdSaveZITemplate:SetScript("OnClick", 
		function(self, value)
			ZoneInfoDataProvider:SaveZITemplate()
		end);		


	-- Button: Load from template
	local cmdLoadZITemplate = CreateFrame("Button", "ZoneInfo_cmdLoadZITemplate", ZoneInfo.panel, "UIPanelButtonTemplate");
	cmdLoadZITemplate:SetPoint("TOPLEFT", 150, -490)
	cmdLoadZITemplate:SetText("Load template")
	cmdLoadZITemplate.tooltipText = "Load the settings from the global template to apply them to this character"
	cmdLoadZITemplate:SetWidth(120)
	cmdLoadZITemplate:SetHeight(22)
	cmdLoadZITemplate:SetScript("OnClick", 
		function(self, value)
			ZoneInfoDataProvider:LoadZITemplate()
		end);		
	
	
	-- Button: Apply settings
	local cmdApplySettings = CreateFrame("Button", "ZoneInfo_cmdApplySettings", ZoneInfo.panel, "UIPanelButtonTemplate");
	cmdApplySettings:SetPoint("TOPLEFT", 20, -550)
	cmdApplySettings:SetText("Apply")
	cmdApplySettings.tooltipText = "Apply and save the settings"
	cmdApplySettings:SetWidth(120)
	cmdApplySettings:SetHeight(30)
	cmdApplySettings:SetScript("OnClick", function (self) ZoneInfoDataProvider:SaveSettings() end)

	-- Button: Cancel changes
	local cmdCancelChanges = CreateFrame("Button", "ZoneInfo_cmdCancelChanges", ZoneInfo.panel, "UIPanelButtonTemplate");
	cmdCancelChanges:SetPoint("TOPLEFT", 150, -550)
	cmdCancelChanges:SetText("Cancel")
	cmdCancelChanges.tooltipText = "Cancels any changes since the last apply and save"
	cmdCancelChanges:SetWidth(120)
	cmdCancelChanges:SetHeight(30)
	cmdCancelChanges:SetScript("OnClick", function (self) ZoneInfoDataProvider:CancelChanges() end)	
	
	
	--InterfaceOptions_AddCategory(ZoneInfo.panel);	  removed in 10.0.0, replaced by:
	local category = Settings.RegisterCanvasLayoutCategory(ZoneInfo.panel, L("ZoneInfo"))  -- seems to give a lua error the very first time it is called
	Settings.RegisterAddOnCategory(category)
end

function ZoneInfo:OnEnable()
    WorldMapFrame:AddDataProvider(ZoneInfoDataProvider)
end

function ZoneInfo:OnDisable()
    WorldMapFrame:RemoveDataProvider(ZoneInfoDataProvider)
end

function ZoneInfoDataProvider:ResetZIPanelPosition()
	if ZISettings.AttachPanelToWorldMap == true then
		ZoneInfoDataProvider.frame:SetPoint(
			"TOPLEFT",
			ZoneInfoDataProvider:GetMap():GetCanvasContainer(),
			10,
			-35
		)
	else
		ZISettings.PanelPositionX = 20
		ZISettings.PanelPositionY = -100
		ZoneInfoDataProvider.frame:SetPoint(
			"TOPLEFT",
			UIParent,
			ZISettings.PanelPositionX,
			ZISettings.PanelPositionY
		)
		if ZISettings.ShowFrame == false then
			-- Open panel if minimized
			ZoneInfoDataProvider:OpenZIPanel()
		end
		if ZISettings.LockMovablePanel == true then
			-- Unlock it
			ZISettings.LockMovablePanel = false
			ZoneInfo_cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Unlocked-Up")
		end
		
		DEFAULT_CHAT_FRAME:AddMessage("ZoneInfo 2: Panel position has been reset.")
	end
end

function ZoneInfoDataProvider:OpenZIPanel()
	ZISettings.ShowFrame = true
	ZoneInfoDataProvider.frame:SetBackdropColor(0,0,0,ZISettings.BackgroundOpacity)
	ZoneInfoDataProvider.frame:SetBackdropBorderColor(0,0,0,ZISettings.BackgroundOpacity)
	ZoneInfoDataProvider.headerText:Show()
	ZoneInfoDataProvider.detailsText:Show()
	if ZISettings.AttachPanelToWorldMap == false then
		ZoneInfo_cmdLockMovablePanel:Show()
	end
	ZoneInfoDataProvider.frame:EnableMouse(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
	ZoneInfo_cmdShowFrameText:SetText("<")
end

function ZoneInfoDataProvider:HideZIPanel()
	ZISettings.ShowFrame = false
	ZoneInfo_cmdLockMovablePanel:Hide()
	ZoneInfoDataProvider.detailsText:Hide()
	ZoneInfoDataProvider.headerText:Hide()
	ZoneInfoDataProvider.frame:SetBackdropColor(0,0,0,0)  -- transparent
	ZoneInfoDataProvider.frame:SetBackdropBorderColor(0,0,0,0)
	ZoneInfoDataProvider.frame:EnableMouse(false)
	ZoneInfo_cmdShowFrameText:SetText("ZI")
end

function ZoneInfoDataProvider:OnAdded(mapCanvas)
    MapCanvasDataProviderMixin.OnAdded(self, mapCanvas)

	if not self.frame then
		trace("Mixin:OnAdded: creating frame")
		self.frame = CreateFrame(
			"Frame",
			"ZoneInfo Panel",
			self:GetMap():GetCanvasContainer(),
			"BackdropTemplate"
		)
	end

	if ZISettings.AttachPanelToWorldMap == true then
		-- Unmovable: Anchor to World Map
		self.frame:SetPoint(
			"TOPLEFT",
			self:GetMap():GetCanvasContainer(),
			10,
			-35
		)			
	else
		-- Movable: Anchor to screen
		self.frame:SetPoint(
			"TOPLEFT",
			UIParent,
			ZISettings.PanelPositionX,
			ZISettings.PanelPositionY
		)	
	end

	self.frame:SetFrameStrata("FULLSCREEN_DIALOG")
	self.frame.dataProvider = self
	
	-- Panel repositioning 
	-- See notes at https://wowwiki.fandom.com/wiki/API_Frame_StopMovingOrSizing
	self.frame:SetMovable(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
	self.frame:EnableMouse(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
	self.frame:SetScript("OnMouseDown",
		function(self, buttonName)
			-- Handle left button clicks
			if (buttonName == "LeftButton" and ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false) then
				-- StartMoving() will de-anchor the frame from it's parent and anchor it to the screen
				-- Get the current offsets before that happens
				local _, _, _, xOfs, yOfs = ZoneInfoDataProvider.frame:GetPoint()
				ZoneInfoDataProvider.initialToFrameOffsetX = xOfs
				ZoneInfoDataProvider.initialToFrameOffsetY = yOfs
				ZoneInfoDataProvider.frame:StartMoving()
				-- Get the new offsets for the starting position of the move, need this to calculate the delta
				_, _, _, xOfs, yOfs = ZoneInfoDataProvider.frame:GetPoint()
				ZoneInfoDataProvider.initialToScreenOffsetX = xOfs
				ZoneInfoDataProvider.initialToScreenOffsetY = yOfs

			end
		end)
	self.frame:SetScript("OnMouseUp",
		function(self, buttonName)
			if (buttonName == "LeftButton" and ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false) then
				local _, _, _, finalToScreenOffsetX, finalToScreenOffsetY = ZoneInfoDataProvider.frame:GetPoint()
				ZoneInfoDataProvider.frame:StopMovingOrSizing()
				-- StopMovingOrSizing() does not restore the original anchor
				-- Remove possibly changed anchor 
				ZoneInfoDataProvider.frame:ClearAllPoints()
				-- Caculate delta
				local deltaX = finalToScreenOffsetX - ZoneInfoDataProvider.initialToScreenOffsetX
				local deltaY = finalToScreenOffsetY - ZoneInfoDataProvider.initialToScreenOffsetY
				-- Apply to initial offsets to get new offsets
				local newX = ZoneInfoDataProvider.initialToFrameOffsetX + deltaX
				local newY = ZoneInfoDataProvider.initialToFrameOffsetY + deltaY
				-- Re-anchor using new offsets
				ZoneInfoDataProvider.frame:SetPoint(
					"TOPLEFT",
					UIParent,
					newX,
					newY
				)					
				-- Store new position
				ZISettings.PanelPositionX = newX
				ZISettings.PanelPositionY = newY
			end
		end)

	-- Background
	local FRAME_BACKDROP = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileEdge = true,
		tileSize = 8,
		edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 },
	}
	self.frame:SetBackdrop(FRAME_BACKDROP)
	self.frame:SetBackdropColor(0,0,0,ZISettings.BackgroundOpacity)
	self.frame:SetBackdropBorderColor(0,0,0,ZISettings.BackgroundOpacity)

	if ZISettings.ShowBackground == false then
		self.frame:SetBackdropColor(0,0,0,0)
		self.frame:SetBackdropBorderColor(0,0,0,0)
	end
	
	-- Minimize button
	local cmdShowFrame = CreateFrame("Button", "ZoneInfo_cmdShowFrame", self.frame, "UIPanelButtonTemplate")
	cmdShowFrame:SetPoint("TOPLEFT", 0, 0)
	cmdShowFrame:SetWidth(30)
	cmdShowFrame:SetHeight(30)
	cmdShowFrame:SetScale(ZISettings.PanelSize)
	if ZISettings.ShowFrame == true then
		cmdShowFrame:SetText("<")
	else
		cmdShowFrame:SetText("ZI")
	end
	cmdShowFrame:SetScript("OnClick", 
		function(self, value)
			if ZISettings.ShowFrame == false then
				ZoneInfoDataProvider:OpenZIPanel()
			else
				ZoneInfoDataProvider:HideZIPanel()
			end
		end)

	-- Lock button
	local cmdLockMovablePanel = CreateFrame("BUTTON", "ZoneInfo_cmdLockMovablePanel", self.frame, "InsecureActionButtonTemplate") -- "SecureHandlerClickTemplate");
	cmdLockMovablePanel:SetSize(35,35)
	cmdLockMovablePanel:SetPoint("TOPLEFT", 18, 5)
	cmdLockMovablePanel:SetScale(ZISettings.PanelSize * 1.25)
	cmdLockMovablePanel:RegisterForClicks("AnyUp")
	cmdLockMovablePanel:SetPushedTexture("Interface\\BUTTONS\\LockButton-Unlocked-Down")  -- Note: there appears to be no image for Locked-Down for some reason
	cmdLockMovablePanel:SetScript("OnClick", function(self)
			ZISettings.LockMovablePanel = not ZISettings.LockMovablePanel
			ZoneInfoDataProvider.frame:SetMovable(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
			ZoneInfoDataProvider.frame:EnableMouse(ZISettings.AttachPanelToWorldMap == false and ZISettings.LockMovablePanel == false)
			if ZISettings.LockMovablePanel == true then
				  ZoneInfo_cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Locked-Up")
			else
				  ZoneInfo_cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Unlocked-Up")
			end
		end)
	if ZISettings.LockMovablePanel == true then
		  cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Locked-Up")
	else
		  cmdLockMovablePanel:SetNormalTexture("Interface\\BUTTONS\\LockButton-Unlocked-Up")
	end
	if ZISettings.ShowFrame == false or ZISettings.AttachPanelToWorldMap == true then
		cmdLockMovablePanel:Hide()
	end


	-- Texts
	local font, size = WorldMapTextFont:GetFont()
	local headerScale, detailsScale = GetScaleValuesForText(ZISettings.PanelSize)

	self.headerText = self.frame:CreateFontString(nil, "OVERLAY", "WorldMapTextFont")
	self.headerText:SetFont(font, size, "OUTLINE")
	self.headerText:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 14, -40)
	self.headerText:SetWidth(1000)
	self.headerText:SetScale(headerScale)
	self.headerText:SetJustifyH("LEFT")

	self.detailsText = self.frame:CreateFontString(nil, "OVERLAY", "WorldMapTextFont")
	self.detailsText:SetFont(font, size, "OUTLINE")
	self.detailsText:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 20, -180)
	self.detailsText:SetWidth(1000)
	self.detailsText:SetScale(detailsScale)
	self.detailsText:SetJustifyH("LEFT")
	
	self.headerText:SetText("ZoneInfo")
	self.detailsText:SetText("")
	
	if ZISettings.ShowFrame == true then
		self.frame:EnableMouse(true)
		self.frame:SetBackdropColor(0,0,0,ZISettings.BackgroundOpacity)
		self.frame:SetBackdropBorderColor(0,0,0,ZISettings.BackgroundOpacity)
		self.headerText:Show()
		self.detailsText:Show()
	else
		self.detailsText:Hide()
		self.headerText:Hide()
		self.frame:SetBackdropColor(0,0,0,0)
		self.frame:SetBackdropBorderColor(0,0,0,0)
		self.frame:EnableMouse(false)
	end
	
	self.frame:Show()
		
--	Tourist:InitializeProfessionSkills()
		
	DEFAULT_CHAT_FRAME:AddMessage("ZoneInfo 2 loaded.")

end

function ZoneInfoDataProvider:RemoveAllData()
    self.frame:Hide()
end

function ZoneInfoDataProvider:RefreshAllData(fromOnShow)
	if not self.frame then
		return
	end
	
	local playerUiMapID = C_Map.GetBestMapForUnit("player");
	local currentUiMapID = WorldMapFrame:GetMapID()
	local zoneText = Tourist:GetMapNameByIDAlt(currentUiMapID)
	local playerLevel = UnitLevel("player")

	trace("RefreshAllData: UiMapID "..tostring(currentUiMapID).." = "..tostring(zoneText).." ("..tostring(Tourist:GetType(currentUiMapID))..")")

	if currentUiMapID and (Tourist:IsZoneOrInstance(currentUiMapID) or Tourist:DoesZoneHaveInstances(currentUiMapID)) and not Tourist:IsContinent(currentUiMapID) then
		-- HEADER --------------------------------------------------------------------------------
		self.headerText:SetTextColor(Tourist:GetFactionColor(currentUiMapID))
		
		local low, high = Tourist:GetLevel(currentUiMapID)	
		local levelText = ""
		if low > 0 and high > 0 then
			levelText = Tourist:GetLevelString(currentUiMapID)
			local r, g, b = Tourist:GetLevelColor(currentUiMapID)
			levelText = string.format("|cff%02x%02x%02x[%s] |cff%02x%02x%02x(%s)|r", r * 255, g * 255, b * 255, levelText, 255, 255, 255, playerLevel)
			
			local groupSizeString = Tourist:GetInstanceGroupSizeString(currentUiMapID, true)
			if groupSizeString ~= "" then
				levelText = levelText.." "..groupSizeString.." "..L("man")
			end
		else
			levelText = string.format("|cff%02x%02x%02x(%s)|r", 255, 255, 255, playerLevel)
		end
			
		if levelText == "" then
			self.headerText:SetText(zoneText)
		else
			table.insert(t,zoneText)
			table.insert(t,levelText)
			self.headerText:SetText(table.concat(t, "\n"))
			for k in pairs(t) do
				t[k] = nil
			end
		end

		-- DETAILS --------------------------------------------------------------------------------
		self.detailsText:SetText("")

		-- Determine transport connections
		local transports = {}
		local hasTransports = false
		local roadConnections = {}
		local hasRoadConnections = false
		if ZISettings.ShowTransports or ZISettings.ShowRoadConnections or ZISettings.ShowTravelAdvice then
			for path in Tourist:IterateBorderZones(currentUiMapID, false) do
				if not Tourist:IsZoneOrInstance(path) then
					transports[path] = true
					hasTransports = true
				else 
					if Tourist:IsZone(path) then
						roadConnections[path] = true
						hasRoadConnections = true
					end
				end
			end
		end
		local hasFlightnodes = Tourist:DoesZoneHaveFlightnodes(currentUiMapID) and ZISettings.ShowFlightnodes
		local hasInstances = Tourist:DoesZoneHaveInstances(currentUiMapID) and ZISettings.ShowInstances
		local hasTravelAdvice = (playerUiMapID ~= currentUiMapID) and (hasRoadConnections or hasTransports) and ZISettings.ShowTravelAdvice

		local noTable = false
			
		-- 1) Add Battle Pet level
		local hasBattlePets = false

		if ZISettings.ShowBattlePets then
			local bpLow, bpHigh = Tourist:GetBattlePetLevel(currentUiMapID)
			hasBattlePets = (bpLow and bpHigh)
			if hasBattlePets then
				local bpLevelString = Tourist:GetBattlePetLevelString(currentUiMapID)
				--local bp_level_text = string.format("|cff%02x%02x%02x%s: |cff%02x%02x%02x[%s]|r", 255, 255, 255, L("Battle Pets"), 255, 255, 0, bpLevelString)
				local bp_level_text = string.format("|cff%02x%02x%02x%s: |cff%02x%02x%02x[%s]|r", 255, 255, 255, AUCTION_CATEGORY_BATTLE_PETS, 255, 255, 0, bpLevelString)
				
				
				table.insert(t,bp_level_text)
				
				if ZISettings.ShowFishing or ZISettings.ShowHerbalism or ZISettings.ShowMining or ZISettings.ShowSkinning or hasTransports or hasRoadConnections or hasInstances or hasFlightnodes then
					table.insert(t,"")
				end
			end
		end
		
		-- 2) Add fishing level
		if ZISettings.ShowFishing then
			local skillName, currentLevel, maxLevel, skillMod = Tourist:GetFishingSkillInfo(currentUiMapID)
			if skillName ~= "" then
				table.insert(t, string.format("|cffffffff%s:|r", L("Fishing")))
				local fishing_skill_text
				if currentLevel == 0 then -- not learned yet
					fishing_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r", 255, 0, 0, skillName) -- red
				else
					local r, g, b = Tourist:CalculateLevelColor(1, maxLevel, currentLevel)
					fishing_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d/%d]|r", 255, 255, 0, skillName, r * 255, g * 255, b * 255, currentLevel, maxLevel)			
				end
				table.insert(t,fishing_skill_text)
			else
				-- no data
				table.insert(t, string.format("|cff808080%s|r", L("Fishing")))	 -- Gray		
			end
			if ZISettings.ShowHerbalism or ZISettings.ShowMining or ZISettings.ShowSkinning or hasTransports or hasRoadConnections or hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end
		
		-- 3) Add herbalism level
		if ZISettings.ShowHerbalism then
			local skillName, currentLevel, maxLevel, skillMod = Tourist:GetHerbalismSkillInfo(currentUiMapID)
			if skillName ~= "" then
				table.insert(t, string.format("|cffffffff%s:|r", L("Herbalism")))
				local herbalism_skill_text
				if currentLevel == 0 then -- not learned yet
					herbalism_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r", 255, 0, 0, skillName) -- red
				else
					local r, g, b = Tourist:CalculateLevelColor(1, maxLevel, currentLevel)
					herbalism_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d/%d]|r", 255, 255, 0, skillName, r * 255, g * 255, b * 255, currentLevel, maxLevel)			
				end
				table.insert(t,herbalism_skill_text)
			else
				-- no data
				table.insert(t, string.format("|cff808080%s|r", L("Herbalism")))	 -- Gray		
			end
			if ZISettings.ShowMining or ZISettings.ShowSkinning or hasTransports or hasRoadConnections or hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end		
		
		-- 4) Add mining level
		if ZISettings.ShowMining then
			local skillName, currentLevel, maxLevel, skillMod = Tourist:GetMiningSkillInfo(currentUiMapID)
			if skillName ~= "" then
				table.insert(t, string.format("|cffffffff%s:|r", L("Mining")))
				local mining_skill_text
				if currentLevel == 0 then -- not learned yet
					mining_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r", 255, 0, 0, skillName) -- red
				else
					local r, g, b = Tourist:CalculateLevelColor(1, maxLevel, currentLevel)
					mining_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d/%d]|r", 255, 255, 0, skillName, r * 255, g * 255, b * 255, currentLevel, maxLevel)			
				end
				table.insert(t,mining_skill_text)
			else
				-- no data
				table.insert(t, string.format("|cff808080%s|r", L("Mining")))	 -- Gray		
			end
			if ZISettings.ShowSkinning or hasTransports or hasRoadConnections or hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end
		
		-- 5) Add skinning level
		if ZISettings.ShowSkinning then
			local skillName, currentLevel, maxLevel, skillMod = Tourist:GetSkinningSkillInfo(currentUiMapID)
			if skillName ~= "" then
				table.insert(t, string.format("|cffffffff%s:|r", L("Skinning")))
				local skinning_skill_text
				if currentLevel == 0 then -- not learned yet
					skinning_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r", 255, 0, 0, skillName) -- red
				else
					local r, g, b = Tourist:CalculateLevelColor(1, maxLevel, currentLevel)
					skinning_skill_text = "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d/%d]|r", 255, 255, 0, skillName, r * 255, g * 255, b * 255, currentLevel, maxLevel)			
				end
				table.insert(t,skinning_skill_text)
			else
				-- no data
				table.insert(t, string.format("|cff808080%s|r", L("Skinning")))	 -- Gray		
			end
			if hasTransports or hasRoadConnections or hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end		
		
		
		-- 6) Add transport connections
		if hasTransports and ZISettings.ShowTransports then
			local r, g, b
			table.insert(t, string.format("|cffffffff%s:|r", L("Transports")))
			for k, v in pairs(transports) do
				r, g, b = Tourist:GetFactionColor(k)
				table.insert(t, string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, "- "..k))
			end
			if hasRoadConnections or hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end
	
		-- 7) Add road connections
		if hasRoadConnections and ZISettings.ShowRoadConnections then
			local r, g, b
			table.insert(t, string.format("|cffffffff%s:|r", L("Road connections")))
			for k, v in pairs(roadConnections) do
				r, g, b = Tourist:GetFactionColor(k)
				table.insert(t, string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, "- "..k))
			end
			if hasInstances or hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end
		end

		-- 8) Add instances
		if hasInstances then
			table.insert(t, string.format("|cffffffff%s:|r", L("Instances")))
			for instance in Tourist:IterateZoneInstances(currentUiMapID) do
				local complex = nil
				if not Tourist:IsComplex(currentUiMapID) then
					complex = Tourist:GetComplex(instance)
				end
				local low, high = Tourist:GetLevel(instance)
				local r1, g1, b1 = Tourist:GetFactionColor(instance)
				local r2, g2, b2 = Tourist:GetLevelColor(instance)
				local groupSize = Tourist:GetInstanceGroupSize(instance)
				local groupSizeString = Tourist:GetInstanceGroupSizeString(instance, true)
				local name = instance
				if complex then
					name = complex .. " - " .. instance
				end
				if Tourist:IsBattleground(instance) then
					name = BATTLEGROUND..": " .. name
				elseif Tourist:IsArena(instance) then
					name = ARENA..": " .. name
				elseif groupSize > 5 then
					name = RAID..": " .. name
				end
				if Tourist:IsArena(instance) then
					table.insert(t, "- "..string.format("|cff%02x%02x%02x%s|r", r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255))
				else
					if low == high then
						if groupSize > 0 then
							table.insert(t, "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r " .. groupSizeString.." "..L("man"), r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, high))
						else
							table.insert(t, "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r", r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, high))
						end
					else
						if groupSize > 0 then
							table.insert(t, "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r " .. groupSizeString.." "..L("man"), r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, low, high))
						else
							table.insert(t, "- "..string.format("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r", r1 * 255, g1 * 255, b1 * 255, name, r2 * 255, g2 * 255, b2 * 255, low, high))
						end
					end
				end
			end
			
			if hasFlightnodes or hasTravelAdvice then
				table.insert(t,"")
			end		
		end
		
		-- 9) Add flight nodes
		if hasFlightnodes then
			local r, g, b
			local firstNode = true		
			for node in Tourist:IterateZoneFlightnodes(currentUiMapID) do
				if firstNode == true then
					firstNode = false
					-- only add the header if there effectively are known nodes (not all nodes defined in LT are guaranteed to be returned by WoW when LT's lookup is filled)
					table.insert(t, string.format("|cffffffff%s:|r", L("Flight nodes")))
				end
				r, g, b = Tourist:GetFlightnodeFactionColor(node.faction)
				table.insert(t, string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, "- "..node.name))
			end
			
			if hasTravelAdvice then
				table.insert(t,"")
			end		
		end

		-- 10) Add Travel advice
		if hasTravelAdvice then
			local firstStep = true
			for step in Tourist:IteratePath(playerUiMapID, currentUiMapID) do
				r, g, b = Tourist:GetFactionColor(step)
				if firstStep == true then
					-- Show the header if an advice is available
					table.insert(t, string.format("|cffffffff%s:|r", L("Travel advice")))
					table.insert(t, string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, tostring(step)))
					firstStep = false
				else
					table.insert(t, string.format("|cff%02x%02x%02x-> %s|r", r * 255, g * 255, b * 255, tostring(step)))
				end
			end
		end

		-- Show result
		self.detailsText:SetText(table.concat(t, "\n"))
		for k in pairs(t) do
			t[k] = nil
		end

	elseif not currentUiMapID then
		-- No map ID
		self.headerText:SetTextColor(1,1,1)
		self.headerText:SetText("??")
		self.detailsText:SetText("")
	else
		-- Continent, World map, Cosmic map
		self.headerText:SetTextColor(Tourist:GetFactionColor(currentUiMapID))
		self.headerText:SetText(zoneText)
		self.detailsText:SetText("")		
	end
	
	-- Set frame height and width
	local headerScale, detailsScale = GetScaleValuesForText(ZISettings.PanelSize)
	if self.detailsText:GetText() == nil then
		frameHeight = (self.headerText:GetHeight() + 45) * headerScale
	else
		frameHeight = (self.detailsText:GetHeight() + 225) * detailsScale 	
	end
	self.frame:SetHeight(frameHeight)
	self.frame:SetWidth(ZISettings.PanelSize * 500)
	if ZISettings.ShowFrame == true then
		self.frame:SetBackdropColor(0,0,0,ZISettings.BackgroundOpacity)
		self.frame:SetBackdropBorderColor(0,0,0,ZISettings.BackgroundOpacity)
	end	
	
end


