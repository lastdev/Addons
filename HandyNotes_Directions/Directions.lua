local myname, ns = ...
local _, myfullname = C_AddOns.GetAddOnInfo(myname)


ns.CLASSIC = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE -- rolls forward
ns.CLASSICERA = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- forever vanilla

---------------------------------------------------------
-- Addon declaration
HandyNotes_Directions = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Directions","AceEvent-3.0")
local HD = HandyNotes_Directions
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_Directions", true)

local debugf = tekDebug and tekDebug:GetFrame("Directions")
local function Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
	global = {
		landmarks = {
			["*"] = {},  -- [mapID] = {[coord] = "name", [coord] = "name", [coord] = {name="name", icon="atlas"}}
		},
	},
	profile = {
		icon_scale         = 1.0,
		icon_alpha         = 1.0,
		minimap            = true,
	},
}
local landmarks

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local HandyNotes = HandyNotes

---------------------------------------------------------
-- Constants

local POI_TEXTURE_FLAG = ns.CLASSIC and 6 or 7

local function setupLandmarkIcon(texture, left, right, top, bottom)
	return {
		icon = texture,
		tCoordLeft = left,
		tCoordRight = right,
		tCoordTop = top,
		tCoordBottom = bottom,
		scale = 1,
		-- _string = CreateTextureMarkup(texture, 255, 512, 0, 0, left, right, top, bottom),
	}
end
local function setupAtlasIcon(atlas, scale, crop)
	local info = C_Texture.GetAtlasInfo(atlas)
	if not info then return end
	local icon = {
		icon = info.file,
		scale = scale or 1,
		tCoordLeft = info.leftTexCoord, tCoordRight = info.rightTexCoord, tCoordTop = info.topTexCoord, tCoordBottom = info.bottomTexCoord,
	}
	if crop then
		local xcrop = (icon.tCoordRight - icon.tCoordLeft) * crop
		local ycrop = (icon.tCoordBottom - icon.tCoordTop) * crop
		icon.tCoordRight = icon.tCoordRight - xcrop
		icon.tCoordLeft = icon.tCoordLeft + xcrop
		icon.tCoordBottom = icon.tCoordBottom - ycrop
		icon.tCoordTop = icon.tCoordTop + xcrop
	end
	-- icon._atlas = atlas
	-- icon._string = CreateAtlasMarkup(atlas)
	return icon
end

local icons = {}

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HDHandler = {}
local lastGossip, likelyIcon, currentOptions

function HDHandler:OnEnter(mapID, coord)
	local tooltip = GameTooltip
	if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end
	tooltip:SetText(landmarks[mapID][coord].name)
	tooltip:Show()
end

local function deletePin(mapID, coord)
	landmarks[mapID][coord] = nil
	HD:SendMessage("HandyNotes_NotifyUpdate", "Directions")
end

local function createWaypoint(uiMapID, coord)
	local x, y = HandyNotes:getXY(coord)
	local name = landmarks[uiMapID][coord].name
	if MapPinEnhanced and MapPinEnhanced.AddPin then
		MapPinEnhanced:AddPin{
			mapID = uiMapID,
			x = x,
			y = y,
			setTracked = true,
			title = name,
		}
	elseif TomTom then
		TomTom:AddWaypoint(uiMapID, x, y, {
			title = name,
			world = false,
			minimap = true,
		})
	elseif C_Map and C_Map.CanSetUserWaypointOnMap and C_Map.CanSetUserWaypointOnMap(uiMapID) then
		local uiMapPoint = UiMapPoint.CreateFromCoordinates(uiMapID, x, y)
		C_Map.SetUserWaypoint(uiMapPoint)
		C_SuperTrack.SetSuperTrackedUserWaypoint(true)
	end
end

function HDHandler:OnClick(button, down, mapID, coord)
	if button == "RightButton" and not down then
		if not (_G.MenuUtil and MenuUtil.CreateContextMenu) then
			return Debug("No new dropdown menus")
		end
		MenuUtil.CreateContextMenu(nil, function(owner, rootDescription)
			rootDescription:SetTag("MENU_HANDYNOTES_DIRECTIONS_CONTEXT")
			local title = rootDescription:CreateTitle(myfullname)
			title:AddInitializer(function(frame, description, menu)
				local rightTexture = frame:AttachTexture()
				rightTexture:SetSize(18, 18)
				rightTexture:SetPoint("RIGHT")
				rightTexture:SetAtlas("poi-islands-table")

				frame.fontString:SetPoint("RIGHT", rightTexture, "LEFT")

				local pad = 20
				local width = pad + frame.fontString:GetUnboundedStringWidth() + rightTexture:GetWidth()
				local height = 20
				return width, height
			end)
			rootDescription:CreateButton("Create waypoint", function(data, event) createWaypoint(mapID, coord) end)
			do
				local icon = rootDescription:CreateButton("Icon...")
				local columns = 4
				icon:SetGridMode(MenuConstants.VerticalGridDirection, columns)
				local function iconInitializer(frame, description, menu)
					local key = description:GetData()
					local texdef = icons[key]

					frame.fontString:Hide()
					local texture = frame:AttachTexture()
					texture:SetSize(20, 20)
					texture:SetPoint("CENTER")
					texture:SetTexture(texdef.icon)
					texture:SetTexCoord(texdef.tCoordLeft, texdef.tCoordRight, texdef.tCoordTop, texdef.tCoordBottom)
					if
						(key == landmarks[mapID][coord].icon)
						or (key == "default" and not landmarks[mapID][coord].icon)
					then
						local highlight = frame:AttachTexture()
						highlight:SetAllPoints()
						highlight:SetAtlas("auctionhouse-nav-button-highlight")
						-- highlight:SetPoint("CENTER")
						-- highlight:SetSize(30, 30)
						-- highlight:SetAtlas("common-roundhighlight")
						highlight:SetBlendMode("ADD")
						highlight:SetDrawLayer("BACKGROUND")
					end
					return 30, 30
				end
				local iconSelect = function(val)
					landmarks[mapID][coord].icon = val
					HD:SendMessage("HandyNotes_NotifyUpdate", "Directions")
					return MenuResponse.Close
				end
				for key, texdef in pairs(icons) do
					local b = icon:CreateButton(key, iconSelect, key)
					b:AddInitializer(iconInitializer)
				end
			end

			rootDescription:CreateButton(DELETE, function(data, event) deletePin(mapID, coord) end)
			rootDescription:CreateDivider()
			rootDescription:CreateButton(SETTINGS_TITLE, function()
				LibStub("AceConfigDialog-3.0"):Open(myname)
			end)
		end)
	end
end

function HDHandler:OnLeave(mapFile, coord)
	GameTooltip:Hide()
end

do
	-- This is a custom iterator we use to iterate over every node in a given zone
	local empty = {}
	local function iter(t, prestate)
		if not t then return nil end
		local state, value = next(t, prestate)
		while state do -- Have we reached the end of this zone?
			if value then
				Debug("iter step", state, icon, db.icon_scale, db.icon_alpha)
				local icon = type(value) == "table" and icons[value.icon] or icons.default
				return state, nil, icon, icon.scale * db.icon_scale, db.icon_alpha
			end
			state, value = next(t, state) -- Get next data
		end
		return nil, nil, nil, nil
	end
	function HDHandler:GetNodes2(mapID, minimap)
		if minimap and not db.minimap then return iter, empty end
		return iter, landmarks[mapID], nil
	end
end


---------------------------------------------------------
-- Core functions

local alreadyAdded = {}
function HD:CheckForLandmarks()
	Debug("CheckForLandmarks", lastGossip)
	if not lastGossip then return end
	local mapID = C_Map.GetBestMapForUnit('player')
	local poiID = C_GossipInfo.GetPoiForUiMapID(mapID)
	Debug("--> POI exists", mapID, poiID, alreadyAdded[poiID])
	if poiID and not alreadyAdded[lastGossip] then
		local gossipInfo = C_GossipInfo.GetPoiInfo(mapID, poiID)
		Debug("--> POI", gossipInfo and gossipInfo.name, gossipInfo and gossipInfo.textureIndex)
		if gossipInfo and gossipInfo.textureIndex == POI_TEXTURE_FLAG then
			Debug("Found POI", gossipInfo.name)
			alreadyAdded[lastGossip] = true
			likelyIcon = likelyIcon or self:LikelyIconForName(gossipInfo.name)
			self:AddLandmark(mapID, gossipInfo.position.x, gossipInfo.position.y, lastGossip, likelyIcon)
		end
	end
end

function HD:AddLandmark(mapID, x, y, name, icon)
	Debug("AddLandmark", mapID, x, y, name, icon)
	local loc = HandyNotes:getCoord(x, y)
	for coord, data in pairs(landmarks[mapID]) do
		if data and data.name and data.name:match("^"..name) then
			Debug("already a match on name", name, data.name)
			return
		end
	end
	landmarks[mapID][loc] = {name = name,}
	if icon and icons[icon] then
		landmarks[mapID][loc].icon = icon
	end
	self:SendMessage("HandyNotes_NotifyUpdate", "Directions")
	createWaypoint(mapID, loc)
end

local replacements = {
	[L["A profession trainer"]] = L["Trainer"],
	[L["Profession Trainer"]] = L["Trainer"],
	[MINIMAP_TRACKING_TRAINER_PROFESSION] = L["Trainer"], -- Profession Trainers
	[L["A class trainer"]] = L["Trainer"],
	-- [L["Class Trainer"]] = L["Trainer"],
	[MINIMAP_TRACKING_TRAINER_CLASS] = L["Trainer"], -- Class Trainer
	[L["Alliance Battlemasters"]] = FACTION_ALLIANCE,
	[L["Horde Battlemasters"]] = FACTION_HORDE,
	[L["To the east."]] = L["East"],
	[L["To the west."]] = L["West"],
	[L["The east."]] = L["East"],
	[L["The west."]] = L["West"],
}
function HD:OnGossipSelectOption(key, identifier, ...)
	Debug("OnGossipSelectOption", key, identifier, currentOptions)
	if not currentOptions then return end
	local selected
	for _, option in ipairs(currentOptions) do
		if option[key] == identifier then
			selected = option
			break
		end
	end
	if not selected then return end
	local name = selected.name
	-- could let later ones take over, but runs into problems with things like "Mailbox > Bank"
	likelyIcon = likelyIcon or self:LikelyIconForName(name, selected)
	if replacements[name] then name = replacements[name] end
	if lastGossip then
		lastGossip = lastGossip .. ': ' .. name
	else
		lastGossip = name
	end
	Debug(" -> lastGossip", lastGossip)
end

do
	-- dancing around classic-compatibility:
	local rawicons = {
		{BLACK_MARKET_AUCTION_HOUSE, "auctioneer"},
		{BUTTON_LAG_AUCTIONHOUSE, "auctioneer"},
		{CONTINENT, "portalblue"},
		{DELVES_GREAT_VAULT_LABEL, "vault"},
		{MINIMAP_TRACKING_TRAINER_CLASS, "class"},
		{MINIMAP_TRACKING_TRAINER_PROFESSION, "profession"},
		{MINIMAP_TRACKING_AUCTIONEER, "auctioneer"},
		{MINIMAP_TRACKING_BANKER, "banker"},
		{MINIMAP_TRACKING_BARBER, "barber"},
		{MINIMAP_TRACKING_BATTLEMASTER, "battlemaster"},
		{MINIMAP_TRACKING_FLIGHTMASTER, "flightmaster"},
		{MINIMAP_TRACKING_INNKEEPER, "innkeeper"},
		{MINIMAP_TRACKING_ITEM_UPGRADE_MASTER, "upgradeitem"},
		{MINIMAP_TRACKING_MAILBOX, "mailbox"},
		{MINIMAP_TRACKING_REPAIR, "repair"},
		{MINIMAP_TRACKING_STABLEMASTER, "stablemaster"},
		{MINIMAP_TRACKING_TRAINER_CLASS, "class"},
		{MINIMAP_TRACKING_TRAINER_PROFESSION, "profession"},
		{MINIMAP_TRACKING_TRANSMOGRIFIER, "transmog"},
		{MINIMAP_TRACKING_VENDOR_AMMO, "ammo"},
		{MINIMAP_TRACKING_VENDOR_FOOD, "food"},
		{MINIMAP_TRACKING_VENDOR_POISON, "poisons"},
		{MINIMAP_TRACKING_VENDOR_REAGENT, "reagents"},
		{PROFESSIONS_CRAFTING_ORDERS_TAB_NAME, "workorders"},
		{TOOLTIP_BATTLE_PET, "battlepet"},
		{TRANSMOG_SOURCE_7, "tradingpost"},
		{L["Rostrum of Transformation"], "rostrum"},
	}
	local iconMap
	local function createIconMap()
		iconMap = {}
		for _, icon in ipairs(rawicons) do
			if icon[1] and icons[icon[2]] then
				iconMap[icon[1]] = icon[2]
			else
				Debug("Skipped creating icon", icon[1], icon[2])
			end
		end
	end
	function HD:LikelyIconForName(name)
		if not iconMap then createIconMap() end
		for label, icon in pairs(iconMap) do
			-- pluralization is... inconsistent
			if name:match("^"..label) or label:match("^"..name) then
				return icon
			end
		end
	end
end

function HD:SetupIcons()
	icons.default = setupLandmarkIcon([[Interface\Minimap\POIIcons]], C_Minimap.GetPOITextureCoords(POI_TEXTURE_FLAG)) -- the cute lil' flag
	icons.ammo = setupAtlasIcon([[Ammunition]])
	icons.ancientmana = setupAtlasIcon([[AncientMana]])
	icons.auctioneer = setupAtlasIcon([[Auctioneer]])
	icons.banker = setupAtlasIcon([[Banker]])
	icons.barber = setupAtlasIcon([[Barbershop-32x32]])
	icons.battlemaster = setupAtlasIcon([[BattleMaster]])
	icons.battlepet = setupAtlasIcon([[WildBattlePetCapturable]])
	icons.chromie = setupAtlasIcon([[ChromieTime-32x32]])
	icons.class = setupAtlasIcon([[Class]])
	icons.creationcatalyst = setupAtlasIcon([[CreationCatalyst-32x32]])
	icons.crossedflags = setupAtlasIcon([[CrossedFlags]])
	icons.disenchant = setupAtlasIcon([[lootroll-toast-icon-disenchant-up]], 1.2)
	icons.door = setupAtlasIcon([[delves-bountiful]], 1.2)
	icons.fishing = setupAtlasIcon([[Fishing-Hole]])
	icons.flightmaster = setupAtlasIcon([[FlightMaster]])
	icons.food = setupAtlasIcon([[Food]])
	icons.greencross = setupAtlasIcon([[GreenCross]])
	icons.innkeeper = setupAtlasIcon([[Innkeeper]])
	icons.loreobject = setupAtlasIcon([[loreobject-32x32]])
	icons.magnify = setupAtlasIcon([[None]])
	icons.mailbox = setupAtlasIcon([[Mailbox]])
	icons.map = setupAtlasIcon([[poi-islands-table]])
	icons.poisons = setupAtlasIcon([[Poisons]])
	icons.portalblue = setupAtlasIcon([[MagePortalAlliance]], 1.3)
	icons.portalred = setupAtlasIcon([[MagePortalHorde]], 1.3)
	icons.profession = setupAtlasIcon([[Profession]], 1.2)
	icons.racing = setupAtlasIcon([[racing]])
	icons.reagents = setupAtlasIcon([[Reagents]])
	icons.repair = setupAtlasIcon([[Repair]])
	icons.rostrum = setupAtlasIcon([[dragon-rostrum]])
	icons.stablemaster = setupAtlasIcon([[StableMaster]])
	icons.town = setupAtlasIcon([[poi-town]])
	icons.tradingpost = setupAtlasIcon([[trading-post-minimap-icon]], 1.3)
	icons.transmog = setupAtlasIcon([[poi-transmogrifier]])
	icons.upgradeitem = setupAtlasIcon([[UpgradeItem-32x32]])
	icons.vault = setupAtlasIcon([[greatvault-dragonflight-32x32]], 1.3)
	icons.workorders = setupAtlasIcon([[poi-workorders]])
	-- professions:
	-- icons.alchemy = setupAtlasIcon([[Mobile-Alchemy]])
	-- icons.archeology = setupAtlasIcon([[Mobile-Archeology]])
	-- icons.blacksmithing = setupAtlasIcon([[Mobile-Blacksmithing]], 1.2)
	-- icons.cooking = setupAtlasIcon([[Mobile-Cooking]])
	-- icons.enchanting = setupAtlasIcon([[Mobile-Enchanting]])
	-- icons.engineering = setupAtlasIcon([[Mobile-Enginnering]])
	-- icons.firstaid = setupAtlasIcon([[Mobile-FirstAid]])
	-- icons.fishing = setupAtlasIcon([[Mobile-Fishing]])
	-- icons.herbalism = setupAtlasIcon([[Mobile-Herbalism]])
	-- icons.inscription = setupAtlasIcon([[Mobile-Inscription]])
	-- icons.jewelcrafting = setupAtlasIcon([[Mobile-Jewelcrafting]])
	-- icons.leatherworking = setupAtlasIcon([[Mobile-Leatherworking]])
	-- icons.mining = setupAtlasIcon([[Mobile-Mining]])
	-- icons.skinning = setupAtlasIcon([[Mobile-Skinning]])
	-- icons.tailoring = setupAtlasIcon([[Mobile-Tailoring]])
	-- icons. = setupAtlasIcon([[]])
end

function HD:GOSSIP_SHOW()
	Debug("GOSSIP_SHOW")
	currentOptions = C_GossipInfo.GetOptions()
end

function HD:GOSSIP_CLOSED()
	Debug("GOSSIP_CLOSED")
	lastGossip = nil
	likelyIcon = nil
end

---------------------------------------------------------
-- Options table
local options = {
	type = "group",
	name = "Directions",
	desc = "Directions",
	get = function(info) return db[info.arg] end,
	set = function(info, v)
		db[info.arg] = v
		HD:SendMessage("HandyNotes_NotifyUpdate", "Directions")
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon. Note that HandyNotes_Directions does not come with any precompiled data, when you ask a guard for directions, it will automatically add the data into your database.",
			type = "description",
			order = 0,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "The scale of the icons",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 10,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "The alpha transparency of the icons",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 20,
		},
		minimap = {
			type = "toggle",
			name = "Minimap",
			desc = "Show on the minimap",
			arg = "minimap",
			order = 30,
		},
	},
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling


function HD:OnInitialize()
	-- Set up our database
	self.db = LibStub("AceDB-3.0"):New("HandyNotes_DirectionsDB", defaults)
	db = self.db.profile
	landmarks = self.db.global.landmarks

	for mapid, points in pairs(landmarks) do
		for coord, point in pairs(points) do
			if type(point) == "string" then
				points[coord] = {name=point}
			end
		end
	end

	self:SetupIcons()

	-- Initialize our database with HandyNotes
	HandyNotes:RegisterPluginDB("Directions", HDHandler, options)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(myname, options)
end

local orig_SelectGossipOption
function HD:OnEnable()
	self:RegisterEvent("DYNAMIC_GOSSIP_POI_UPDATED", "CheckForLandmarks")
	self:RegisterEvent("GOSSIP_CLOSED")
	self:RegisterEvent("GOSSIP_SHOW")

	hooksecurefunc(C_GossipInfo, "SelectOption", function(...)
		HD:OnGossipSelectOption("gossipOptionID", ...)
	end)
	hooksecurefunc(C_GossipInfo, "SelectOptionByIndex", function(...)
		HD:OnGossipSelectOption("orderIndex", ...)
	end)
end
