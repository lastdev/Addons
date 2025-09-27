local myname, ns = ...

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HL = LibStub("AceAddon-3.0"):NewAddon(myname, "AceEvent-3.0")
ns.HL = HL

local next = next
local GameTooltip = GameTooltip
local WorldMapTooltip = WorldMapTooltip
local HandyNotes = HandyNotes

-- Retrieve and set map icons
local function work_out_texture(point)
    if not default_texture then
		local info = C_Texture.GetAtlasInfo("VignetteLoot")
        default_texture = {
            icon = info.file,
            tCoordLeft = info.leftTexCoord,
            tCoordRight = info.rightTexCoord,
            tCoordTop = info.topTexCoord,
            tCoordBottom = info.bottomTexCoord,
        }
    end
    return default_texture
end
local get_point_info = function(point)
    if point then
        local icon = work_out_texture(point)
        local category = "treasure"
        return label, icon, category, point.quest, point.faction
    end
end
local get_point_info_by_coord = function(uiMapID, coord)
    return get_point_info(ns.points[uiMapID] and ns.points[uiMapID][coord])
end

-- Create tooltip structure
local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        if point.label then
            tooltip:AddLine(point.label)
        elseif point.item then
            if ns.db.tooltip_item or IsLeftShiftKeyDown() then
                tooltip:SetHyperlink(("item:%d"):format(point.item))
            else
                local link = select(2, GetItemInfo(point.item))
                tooltip:AddLine(link)
            end
        end
        if point.note then
            tooltip:AddLine(point.note, 255, 255, 255, true)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, uiMapID, coord)
    return handle_tooltip(tooltip, ns.points[uiMapID] and ns.points[uiMapID][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(uiMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, uiMapID, coord)
end

local function createWaypoint(button, uiMapID, coord)
    if TomTom then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uiMapID, x, y, {
            title = get_point_info_by_coord(uiMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        wipe(info)
		if TomTom then
			if (level == 1) then
				-- Create the title of the menu
				info.isTitle      = 1
				info.text         = "HandyNotes - " .. myname:gsub("HandyNotes_", "")
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, level)
				wipe(info)

				
				-- Waypoint menu item
				info.text = "Create waypoint"
				info.notCheckable = 1
				info.func = createWaypoint
				info.arg1 = currentZone
				info.arg2 = currentCoord
				UIDropDownMenu_AddButton(info, level)
				wipe(info)

			-- Close menu item
				info.text         = "Close"
				info.func         = closeAllDropdowns
				info.notCheckable = 1
				UIDropDownMenu_AddButton(info, level)
				wipe(info)
			end
		end
    end
    local HL_Dropdown = CreateFrame("Frame", myname.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, uiMapID, coord)
        if button == "RightButton" and not down then
			currentZone = uiMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(uiMapID, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value then
                local label, icon = get_point_info(value)
                return state, nil, icon, ns.db.icon_scale, ns.db.icon_alpha
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes2(uiMapID, minimap)
        return iter, ns.points[uiMapID], nil
    end
end

---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New(myname.."DB", ns.defaults)
    ns.db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB(myname:gsub("HandyNotes_", ""), HLHandler, ns.options)
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", myname:gsub("HandyNotes_", ""))
end