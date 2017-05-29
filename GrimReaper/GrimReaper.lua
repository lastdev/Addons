--[[
Name: Grim Reaper
Revision: $Rev: 107 $
Author: Zek (zeksie@googlemail.com)
Description: Combat log goodness review with health status.
]]

local L = LibStub("AceLocale-3.0"):GetLocale("GrimReaper")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local SM = LibStub("LibSharedMedia-3.0")
local db, new, del, copy, deepDel

BINDING_HEADER_GRIMREAPER		= L["TITLE"]
BINDING_NAME_GRIMREAPER_REPORT	= L["BINDING_REPORT"]
BINDING_NAME_GRIMREAPER_LOCK	= L["BINDING_LOCK"]
BINDING_NAME_GRIMREAPER_HOLD	= L["BINDING_HOLD"]

local module = LibStub("AceAddon-3.0"):NewAddon("GrimReaper", "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0")
_G.GrimReaper = module

module.version = tonumber(strmatch("$Revision: 107 $", "(%d+)")) or 0

local LDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("GrimReaper", {
	type = "launcher",
	label = L["LDBTITLE"],
	icon = "Interface\\Addons\\GrimReaper\\Images\\DeathEyes",
})

function LDB.OnClick(self, button)
	if (button == "LeftButton") then
		module:OnClick(button)
	else
		module:OpenConfig()
	end
end

function LDB.OnTooltipShow(tt)
	tt:SetText(L["TITLECOLOUR"] .. " |cFFA0A0A0r"..module.version)
	tt:AddLine(L["HINT"], 0, 1, 0)
end


local band = bit.band
local line

--[===[@debug@
local function d(...)
	ChatFrame1:AddMessage("|cFFFF0000grDBG>|r "..format(...), 1, 1, 0.5)
end
--@end-debug@]===]

do
--[===[@debug@
	local protect = {
		__newindex = function(self) error("Attempt to assign to a recycled table") end,
		__index = function(self) error("Attempt to access a recycled table") end,
	}
--@end-debug@]===]

	local next, select, pairs, type = next, select, pairs, type
	local list = setmetatable({},{__mode='k'})

	function new(...)
		local t = next(list)
		if t then
			list[t] = nil
--[===[@debug@
			setmetatable(t, nil)
			assert(not next(t))
--@end-debug@]===]
			for i = 1, select('#', ...) do
				t[i] = select(i, ...)
			end
			return t
		else
			t = {...}
			return t
		end
	end
	function del(t)
		if (t) then
			setmetatable(t, nil)

			wipe(t)
			t[''] = true
			t[''] = nil
			list[t] = true
--[===[@debug@
			assert(not next(t))
			setmetatable(t, protect)
--@end-debug@]===]
		end
	end
	function deepDel(t)
		if (t) then
			setmetatable(t, nil)

			for k,v in pairs(t) do
				if type(v) == "table" then
					deepDel(v)
				end
				t[k] = nil
			end
			t[''] = true
			t[''] = nil
			list[t] = true
--[===[@debug@
			assert(not next(t))
			setmetatable(t, protect)
--@end-debug@]===]
		end
	end
	function copy(old)
		if (not old) then
			return
		end
		local n = new()
		for k,v in pairs(old) do
			if (type(v) == "table") then
				n[k] = copy(v)
			else
				n[k] = v
			end
		end
		setmetatable(n, getmetatable(old))
		return n
	end
end

local function RGBToColourCode(rgb, b, g)
	if type(rgb) == "number" then
		return format("|cFF%02X%02X%02X", rgb * 255, g * 255, b * 255)
	elseif type(rgb) == "table" then
		return format("|cFF%02X%02X%02X", rgb.r * 255, rgb.g * 255, rgb.b * 255)
	end
end

local classColour = XPerlColourTable or setmetatable({},{
	__index = function(self, class)
		local c = RAID_CLASS_COLORS[strupper(class or "")]
		if (c) then
			c = RGBToColourCode(c)
		else
			c = "|c00808080"
		end
		self[class] = c
		return c
	end
})

local lastTime = 0
local millisecs = 0

module.offset = 0
module.needHealth = {}
module.timeWidth = 90

local basicColour = {1, 1, 1}
local healColour = {1, 1, 1}
local specialColour = {0.5, 1, 1}
local buffColour = {0, 1, 0}
local debuffColour = {1, 0, 0}
local buffColourCleanse = {1, 1, 0.5}
local debuffColourCleanse = {1, 0.5, 1}

local recent = setmetatable({}, {__mode = "k"})
local schools = {[0] = "None", [1] = SPELL_SCHOOL0_CAP, [2] = DAMAGE_SCHOOL2, [4] = DAMAGE_SCHOOL3, [8] = DAMAGE_SCHOOL4, [16] = DAMAGE_SCHOOL5, [32] = DAMAGE_SCHOOL6, [64] = DAMAGE_SCHOOL7}
local schoolColour, schoolColourHex

module.options3 = {
	type = 'group',
	order = 15,
	name = L["TITLE"],
	desc = L["Configuration"],
	handler = module,
	get = function(info) return db[info[#info]] end,
	set = function(info, value) db[info[#info]] = value end,
	args = {
		General = {
			type = 'group',
			order = 1,
			name = L["General Settings"],
			desc = L["General Settings"],
			args = {
				lock = {
					type = "toggle",
					name = L["Lock"],
					desc = L["Lock to the current unit"],
					get = function() return module.locked end,
					set = "Lock",
					disabled = function() return not module.lastUnit end,
					order = 100,
				},
				hide = {
					type = "toggle",
					name = L["Hide"],
					desc = L["Hide the grim reaper, but keep it active. You can also do this by clicking on the Grim Reaper icon"],
					set = function(info, n) db.hide = n module:DoIcon() module.cycleState = nil end,
					order = 200,
				},
				freset = {
					type = 'execute',
					name = L["Reset Filters"],
					desc = L["This will remove all custom spell filters."],
					hidden = function() return db.filter == nil end,
					func = function() db.filter = deepDel(db.filter) module:Tip() end,
					order = 250,
				},
				hover = {
					type = 'group',
					name = L["Hover"],
					desc = L["Hover options for expanding information on the reaper lines"],
					order = 300,
					guiInline = true,
					args = {
						buffTips = {
							type = "toggle",
							name = L["Buff Tips"],
							desc = L["Display buff tooltips detailing any buffs used on this line"],
							order = 20,
						},
						debuffTips = {
							type = "toggle",
							name = L["Debuff Tips"],
							desc = L["Display debuff tooltips detailing any debuffs used on this line"],
							order = 25,
						},
					},
				},
				log = {
					type = 'group',
					name = L["Log"],
					desc = L["Show this player's combat log"],
					order = 600,
					guiInline = true,
					disabled = function() return not module.lastUnit end,
					args = {
						both = {
							type = 'execute',
							name = L["Both"],
							desc = L["Show this player's combat log for all events"],
							func = function() module:ShowLog("BOTH") end,
							order = 1,
						},
						login = {
							type = 'execute',
							name = L["Incoming"],
							desc = L["Show this player's combat log for incoming events"],
							func = function() module:ShowLog("INCOMING") end,
							order = 2,
						},
						logout = {
							type = 'execute',
							name = L["Outgoing"],
							desc = L["Show this player's combat log for outgoing events"],
							func = function() module:ShowLog("OUTGOING") end,
							order = 3,
						},
					},
				},
			},
		},
		display = {
			type = 'group',
			name = L["Display"],
			desc = L["Display options"],
			order = 400,
			args = {
				include = {
					type = 'group',
					name = L["Include"],
					desc = L["What to show in the list"],
					guiInline = true,
					order = 1,
					args = {
						casts = {
							type = "toggle",
							name = L["Casts on player"],
							desc = L["Display spells cast on player"],
							set = function(k,v) db.casts = v module:MakeEventList() module:Tip() end,
							order = 1,
						},
						curesAndSteals = {
							type = "toggle",
							name = L["Cures & Steals"],
							desc = L["Show when player is cured or has buff stolen"],
							set = function(k,v) db.cures = v module:MakeEventList() module:Tip() end,
							order = 5,
						},
						buffs = {
							type = "toggle",
							name = L["Buff Gains/Losses"],
							desc = L["Display buff gains and losses"],
							order = 10,
						},
						debuffs = {
							type = "toggle",
							name = L["Debuff Gains/Losses"],
							desc = L["Display debuff gains and losses"],
							order = 11,
						},
					},
				},
				time = {
					type = 'group',
					name = L["Time"],
					desc = L["Timestamp formatting"],
					guiInline = true,
					order = 2,
					args = {
						none = {
							type = "toggle",
							name = L["None"],
							desc = L["Don't show timestamps"],
							get = function() return not db.showtime end,
							set = function(s) db.showtime = false module:Tip() end,
							order = 1,
						},
						full = {
							type = "toggle",
							name = L["Full Time"],
							desc = L["Displays full time stamps"],
							get = function() return db.showtime and not db.deltaTime end,
							set = function(s) db.showtime = true db.deltaTime = nil module.timeWidth = 90 module:Tip() end,
							order = 2,
						},
						delta = {
							type = "toggle",
							name = L["Delta Time"],
							desc = L["Display time stamps as an offset from the most recent line"],
							get = function() return db.showtime and db.deltaTime == 1 end,
							set = function(s) db.showtime = true db.deltaTime = s and 1 or nil module.timeWidth = 90 module:Tip() end,
							order = 5,
						},
						next = {
							type = "toggle",
							name = L["Delta Time Next"],
							desc = L["Display time stamps as an offset from the next line"],
							get = function() return db.showtime and db.deltaTime == 2 end,
							set = function(s) db.showtime = true db.deltaTime = s and 2 or nil module:Tip() module.timeWidth = 90 end,
							order = 6,
						},
						space = {
							type = "header",
							name = " ",
							order = 10,
						},
						timeformat = {
							type = "input",
							name = L["Time Format"],
							desc = L["Adjust the time format (Default: %X)"],
							usage = L["<format>\r%X = HH:MM:SS\r%H = HH, %M = MM, %S = SS\reg: %M:%S"],
							get = function() return db.timeformat end,
							set = function(info, f)
								if (f and f ~= "") then
									local ok, err = pcall(loadstring("date('"..f.."',time())"))
									if (ok) then
										db.timeformat = f
									else
										err = strmatch(err, ":1: (.*)")
										if (err) then
											module:Printf(L["Error: %s"], err)
											return
										end
									end
								else
									f = "%X"
								end
								module.timeWidth = 90
								module:Tip()
							end,
							order = 20,
						},
					},
				},
				dock = {
					type = 'group',
					name = L["Docking"],
					desc = L["Docking options"],
					order = 5,
					guiInline = true,
					args = {
						dockToTooltip = {
							type = "toggle",
							name = L["Enable"],
							desc = L["Enable docking to the game's default tooltip"],
							set = function(k,v) db.dockToTooltip = v module.cycleState = nil end,
							order = 1,
						},
						dockPoint = {
							type = "select",
							name = L["Dock Point"],
							desc = L["Enable docking to the game's default tooltip"],
							values = {TOPLEFT = L["TOPLEFT"], TOPRIGHT = L["TOPRIGHT"], BOTTOMLEFT = L["BOTTOMLEFT"], BOTTOMRIGHT = L["BOTTOMRIGHT"]},
							disabled = function() return not db.dockToTooltip end,
							order = 2,
						},
					},
				},
				appearance = {
					type = 'group',
					name = L["Appearance"],
					desc = L["Appearance"],
					order = 15,
					guiInline = true,
					args = {
						blizzardColours = {
							type = "toggle",
							name = L["Blizzard Colours"],
							desc = L["Use Blizzard magic school colours"],
							get = getOption,
							set = function(v,n) db.blizzardColours = n module:SetColours() module:Tip() end,
							order = 5,
						},
						bars = {
							type = "toggle",
							name = L["Health Bars"],
							desc = L["Show health bars"],
							order = 10,
						},
						barsInside = {
							type = "toggle",
							name = L["Bars Inside"],
							desc = L["Show health bars inside the frame"],
							order = 15,
						},
						barsLeft = {
							type = "toggle",
							name = L["Bars Left"],
							desc = L["Show health bars on left of frame"],
							disabled = function() return db.barsInside end,
							order = 20,
						},
						lines = {
							type = "range",
							name = L["Lines"],
							desc = L["How many lines to show"],
							order = 25,
							min = 5,
							max = 30,
							step = 1,
						},
						growDirection = {
						    type = "select",
						    name = L["Grow Direction"],
						    desc = L["Set the grow direction"],
						    values = {auto = L["Auto"], up = L["Up"], down = L["Down"]},
						    order = 30,
						},
						bartexture = {
							type = "select",
							dialogControl = 'LSM30_Statusbar',
							name = L["Bar Texture"],
							desc = L["Set the texture for the buff timer bars"],
							values = AceGUIWidgetLSMlists.statusbar,
							order = 35,
							set = function(v,n)
								db.bartexture = n
								module.bartexture = SM:Fetch("statusbar", n)
							end,
						},
						frameWidth = {
							type = "range",
							name = L["Width"],
							desc = L["Adjust the width of the Grim Reaper"],
							set = function(v,n) module:SetWidth(n) end,
							min = 150,
							max = 300,
							step = 1,
							bigStep = 10,
							order = 40,
						},
						scale = {
							type = "range",
							name = L["Scale"],
							desc = L["Adjust the scale of the Grim Reaper"],
							set = function(v,n) db.scale = n if (module.attachment) then module.attachment:SetScale(n) module.timeWidth = 90 module:Tip() end end,
							min = 0.3,
							max = 2,
							step = 0.01,
							bigStep = 0.1,
							order = 45,
						},
					},
				},
			},
		},
	}
}

AceConfig:RegisterOptionsTable("GrimReaper", module.options3)

-- GetChatColour
local function GetChatColour(name)
	local info = ChatTypeInfo[name]
	local clr = {r = 0.5, g = 0.5, b = 0.5}
	if (info) then
		clr.r = (info.r or 0.5)
		clr.g = (info.g or 0.5)
		clr.b = (info.b or 0.5)
	end
	return clr
end

-- GetChannelList
function module:GetChannelList()
	local cList = {}
	local l = {"RAID", "OFFICER", "GUILD", "PARTY", "SAY"}
	for k,v in pairs(l) do
		tinsert(cList, {display = getglobal("CHAT_MSG_"..v), channel = v, colour = GetChatColour(v)})
	end

	for i = 1,10 do
		local c, name = GetChannelName(i)
		if (name and c ~= 0) then
			tinsert(cList, {display = name, channel = "CHANNEL", index = c, colour = GetChatColour("CHANNEL"..c)})
		end
	end

	return cList
end

function module:OpenConfig(input)
	InterfaceOptionsFrame_OpenToCategory("GrimReaper")
end

-- UnitFullName
local function UnitFullName(unit)
	local n, s = UnitName(unit)
	return s and s ~= "" and format("%s-%s", n, s) or n
end

-- WasDead
function module:WasDeadOrOld(name)
	if (db.healthList) then
		local hl = db.healthList[name]
		if (hl) then
			hl = hl[#hl]
			if (not hl or hl.health == "DEAD" or hl.time < time() - 10) then
				return true
			end
		end
	end
end

local playerMask = 0x100		-- Is set properly later once Blizzard_CombatLog loads
local groupMask = 0x007			-- ditto	- 0x107

-- COMBAT_LOG_EVENT_UNFILTERED
function module:COMBAT_LOG_EVENT_UNFILTERED(e, timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	local ev = module.eventList[event]
	if (ev ~= nil) then
		if (UnitInRaid(dstName) or UnitInParty(dstName)) then	-- flags check fails if player's MC'd - band(dstFlags, groupMask) ~= 0) then
			if (ev or self:WasDeadOrOld(dstName)) then
				self.needHealth[dstName] = timestamp

				if (self.lastUnit) then
					-- was dead or old or nothing
					self:UNIT_HEALTH(nil, self.lastUnit)
					self.needHealth[dstName] = timestamp
				end
			end

			if (self.lastUnit and UnitGUID(self.lastUnit) == dstGUID) then
				if (self:OptionalFilters(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)) then
					if (self.offset == 0) then
						-- Only update if we're at the bottom
						self:Tip(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
					end

					--if (self.offset > 0 or (self.shownLines and self.shownLines < db.lines)) then
					--	self.offset = 0
					--	self:Tip()
					--end
                    --
					--self:Tip(timestamp, event, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
				end
			end
		end
	end
end

-- UNIT_HEALTH()
function module:UNIT_HEALTH(e, unit)
	local want
	-- Since we can get UNIT_HEALTH events multiple times for the same unit (party1 & raid1 for example), we filter out the surplus
	if (IsInRaid()) then
		if (strfind(unit, "^raid%d+")) then
			want = true
		end
	elseif (GetNumGroupMembers() > 0) then
		if (unit == "player" or strfind(unit, "^party%d")) then
			want = true
		end
	else
		if (unit == "player") then
			want = true
		end
	end

	if (want) then		--UnitInParty(unit) or UnitInRaid(unit) or UnitIsUnit("player", unit) or UnitIsUnit("pet", unit)) then
		local name = UnitFullName(unit)
		local ts = self.needHealth[name]
		if (ts) then
			local n, o
			local list = db.healthList[name]
			if (not list) then
				list = new()
				db.healthList[name] = list
			end

			self.needHealth[name] = nil
			o = list[#list]
			if (o and o.time == ts) then
				n = o
			else
				n = new()
				o = nil
			end

			n.dead = UnitIsDeadOrGhost(unit)
			n.health = n.dead and "DEAD" or UnitHealth(unit)
			n.healthmax = UnitHealthMax(unit)
			n.realtime = time()
			n.time = ts
--ChatFrame1:AddMessage("got health for "..date("%X", ts)..", health = "..format("%d%%", n.health / n.healthmax * 100))

			if (not o) then
				tinsert(list, n)
			end

			local cutoff = time() - 60 * 60	-- 300
			for i,a in pairs(list) do
				if (not a.time or a.time < cutoff) then
					del(tremove(list, i))
				end
			end

			if (unit == self.lastUnit) then
				self:Tip()		-- Refresh if shown
			end
		end
	end
end

-- GROUP_ROSTER_UPDATE
function module:GROUP_ROSTER_UPDATE()
	self:Validate()
end

-- Validate
function module:Validate()

	-- Clear out members of list that have left raid
	local current = new()
	if (IsInRaid()) then
		for i = 1,GetNumGroupMembers() do
			local name = GetRaidRosterInfo(i)
			if (name) then
				current[name] = true
			end
		end
	else
		current[UnitName("player")] = true
		for i = 1,GetNumGroupMembers() do
			local name = UnitFullName("party"..i)
			if (name) then
				current[name] = true
			end
		end
	end

	for name,list in pairs(db.healthList) do
		if (not current[name]) then
			deepDel(list)
			db.healthList[name] = nil
		end
	end

	del(current)
end

-- HouseCleaning
function module:HouseCleaning(cutoff)
	-- Remove any very old (probably only ever our own)
	if (not cutoff) then
		cutoff = time() - 6 * 60 * 60
	end
	for name,list in pairs(db.healthList) do
		while (true) do
			local a = list[1]
			if (a and (not a.time or a.time < cutoff)) then
				del(tremove(list, 1))
			else
				break
			end
		end
	end
end

-- SetColours
function module:SetColours()
	schoolColour = {}
	local bliz = Blizzard_CombatLog_CurrentSettings and Blizzard_CombatLog_CurrentSettings.colors
	if (bliz and bliz.schoolColoring and db and db.blizzardColours) then
		for i,c in pairs(bliz.schoolColoring) do
			schoolColour[i] = {c.r, c.g, c.b}
		end
	else
		schoolColour = {[0] = {0.5, 0.5, 0.5}, [1] = {1, 0.5, 0.5}, [2] = {1, 1, 0.5}, [4] = {1, 0, 0}, [8] = {0, 1, 0}, [16] = {0.3, 0.3, 1}, [32] = {0.5, 0, 0.5}, [64] = {0.5, 0.5, 0.5}}
	end
	schoolColour[1] = {1, 0.5, 0.5}

	schoolColourHex = {}
	for k,v in pairs(schoolColour) do
		schoolColourHex[k] = format("|cFF%02X%02X%02X", v[1] * 255, v[2] * 255, v[3] * 255)
	end
end

-- FixLastUnit()
function module:FixUnit(unit)
	if (IsInRaid()) then
		if (not strfind(unit, "^raid")) then
			for i = 1,GetNumGroupMembers() do
				if (UnitIsUnit("raid"..i, unit)) then
					return "raid"..i
				end
			end
		end
	else
		if (UnitIsUnit("player", unit)) then
			return "player"
		end

		if (GetNumGroupMembers() > 0) then
			if (not strfind(unit, "^party")) then
				for i = 1,GetNumGroupMembers() do
					if (UnitIsUnit("party"..i, unit)) then
						return "party"..i
					end
				end
			end
		end
	end

	return unit
end

-- grOnMouseWheel
local function grOnMouseWheel(self, amount)
	if (IsAltKeyDown()) then
		db.scale = max(0.2, min(2, db.scale + (0.025 * amount)))
		module.attachment:SetScale(db.scale)
		module.timeWidth = 90
		module:Tip()
	else
		local oldOffset = module.offset
		module.offset = max(0, min(1000, module.offset + amount))
		if (module.offset ~= oldOffset) then
			module:Tip()
		end
	end
end

-- grDragStart
local function grDragStart(self)
	if (not db.dockToTooltip) then
		module.attachment.anchor:StartMoving()
	end
end

-- grDragStop
local function grDragStop(self)
	module.attachment.anchor:StopMovingOrSizing()
	module:SavePosition(self.anchor)
end

-- SavePosition
function module:SavePosition(frame)
	if (frame) then
		if (not db.savedPositions) then
			db.savedPositions = {}
		end
		db.savedPositions[frame.name] = {top = frame:GetTop(), left = frame:GetLeft()}
	end
end

-- RestorePosition
function module:RestorePosition(frame)
	if (db.savedPositions) then
		local pos = db.savedPositions[frame.name]
		if (pos) then
			if (pos.left or pos.right) then
				frame:ClearAllPoints()
				frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", pos.left, pos.top)
			end
		end
	end
end

-- CreateAttachment
function module:CreateAttachment()
	local att = self:CreateMainFrame("GrimReaperFrame")
	att.frames = {}
	self.attachment = att

	att:SetScale(db.scale)
	att:SetWidth(db.frameWidth)

	att:SetScript("OnMouseUp",
		function(self, button)
			if (button == "RightButton") then
				module:ShowMenu(self)

			elseif (button == "LeftButton") then
				if (IsModifiedClick("CHATLINK")) then
					module:ChatInsert(self, "line")
				elseif (IsModifiedClick("DRESSUP")) then
					module:ChatInsert(self, "spell")
				end
			end
		end)
	att:SetScript("OnMouseWheel", grOnMouseWheel)
	att:SetScript("OnDragStart", grDragStart)
	att:SetScript("OnDragStop", grDragStop)

	GameTooltip:HookScript("OnHide",
		function(self)
			if (db.dockToTooltip) then
				module.attachment:Hide()
				module.lastUnit = nil
			end
		end)

	module.CreateAttachment = nil
	return att
end

-- ChatInsert
function module:ChatInsert(row, which)
	local a = row.a
	if (not a) then
		return
	end

	local str
	if (which == "line") then
		str = self:MakeCombatLogLine(a, true)
		--str = str:gsub("|", "||")

	elseif (which == "spell") then
		local b = a["helpId"] or a["harmId"]
		if b then
			str = GetSpellLink(b)
		end
	end

	if (str) then
		ChatEdit_InsertLink(str)
	end
end

-- CreateMainFrame
function module:CreateMainFrame(name)
	local anchor = CreateFrame("Frame", name.."Anchor", UIParent)
	anchor.name = name
	anchor:SetPoint("CENTER")
	anchor:SetWidth(1)
	anchor:SetHeight(1)
	anchor:SetMovable(true)

	module:RestorePosition(anchor)			-- Yes, GR not SELF

	local att = CreateFrame("Frame", name, anchor)
	att.anchor = anchor
	att:SetWidth(100)
	att:SetHeight(100)
	att:SetPoint("TOPLEFT")
	att:SetClampedToScreen(true)
	att:EnableMouse(true)
	att:RegisterForDrag("LeftButton")

	local bgDef = {bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 32, edgeSize = 24,
			insets = { left = 6, right = 6, top = 6, bottom = 6 }
		}
	att:SetBackdrop(bgDef)
	att:SetBackdropColor(0, 0, 0, 0.8)
	att:SetBackdropBorderColor(1, 1, 1, 1)

	att.title = att:CreateFontString(nil, "BORDER", "GameFontNormal")
	att.title:SetText(L["TITLE"])
	att.title:SetPoint("BOTTOM", att, "TOP")
	att.title:SetHeight(15)
	att.title:SetTextColor(1, 1, 1)

	return att
end

-- filterSpell
local function filterSpell(_, value)
	assert(type(value) == "number" or type(value) == "string")
	CloseDropDownMenus()

	if (not db.filter) then
		db.filter = new()
	end
	db.filter[value] = true

	-- Trim out spells that no longer exist
	for spell in pairs(db.filter) do
		if type(spell) == "number" then
			if not GetSpellInfo(spell) then
				db.filter[spell] = nil
			end
		elseif type(spell) ~= "string" then
			db.filter[spell] = nil
		end
	end

	module:Tip()
end

-- MakeSpellMenu
function module:MakeSpellMenu(frame, menu)
	local help = frame and frame.a and frame.a.helpId
	if (help) then
		local helpName = GetSpellInfo(help)

		tinsert(menu, 1, {
			text = format(L["Filter ID: %d (%s)"], help, helpName),
			func = filterSpell,
			arg1 = help,
		})

		tinsert(menu, 2, {
			text = format(L["Filter Name: %s"], helpName),
			func = filterSpell,
			arg1 = helpName,
		})
	end
end

function module:MakeChannelMenu()
	local cList = self:GetChannelList()
	local menu = {}

	for i,entry in pairs(cList) do
		tinsert(menu, {
			text = entry.display,
			colorCode = RGBToColourCode(entry.colour),
			func = function(c,n) module:SetChannelRaw(entry.channel, entry.index) CloseDropDownMenus() end,
			checked = db.channel == entry.channel and db.channelIndex == entry.index,
		})
	end

	tinsert(menu, {
		text = L["Self"],
		colorCode = "|cFFFFFFFF",
		func = function(c,n) module:SetChannelRaw("SELF", "") CloseDropDownMenus() end,
		checked = db.channel == "SELF",
	})

	tinsert(menu, {
		text = WHISPER,
		colorCode = RGBToColourCode(ChatTypeInfo.WHISPER),
		func = function(c,n) module:SetChannelRaw("SELF", "") CloseDropDownMenus() end,
		hasArrow = true,
		menuList = self:MakeWhisperMenu(),
		checked = db.channel == "WHISPER",
	})

	return menu
end

function module:MakeWhisperMenu()
	local menu = {}

	for unit in module:IterateRoster() do
		local _, class = UnitClass(unit)
		local name = UnitFullName(unit)
		if (class and name) then
			tinsert(menu, {
				text = name,
				colorCode = RGBToColourCode(RAID_CLASS_COLORS[class]),
				func = function(c,n) module:SetChannelRaw("WHISPER", name) CloseDropDownMenus() end,
				checked = db.channel == "WHISPER" and db.channelIndex == name,
			})
		end
	end
	return menu
end


-- ShowMenu
function module:ShowMenu(frame)
	if self.extraInfoTip then
		self.extraInfoTip:Hide()
	end

	if not self.dropdown then
		self.dropdown = CreateFrame("Frame", "GrimReaperDropdown", UIParent, "UIDropDownMenuTemplate")
	end

    local menu = {
    	{ 
            text = L["Lock"],
            checked = function() return module.locked end,
            func = function() module:Lock() end,
        },{
            text = L["Hide"],
            checked = function() return db.hide end,
            func = function()
                db.hide = not db.hide
                module:DoIcon()
                module.cycleState = nil
                module:Tip()
            end,
        },{
			text = L["Report"],
			notClickable = not module.lastUnit,
			hasArrow = true,
			menuList = {{
				text = L["Shown"],
				func = function() module:ReportShown() CloseDropDownMenus() end,
			},{
				text = L["Channel"],
				hasArrow = true,
				menuList = self:MakeChannelMenu(),
			}}
		},{
			text = L["Log"],
			notClickable = not module.lastUnit,
			hasArrow = true,
			menuList = {{
				text = L["Both"],
				func = function() module:ShowLog("BOTH") end,
			},{
				text = L["Incoming"],
				func = function() module:ShowLog("INCOMING") end,
			},{
				text = L["Outgoing"],
				func = function() module:ShowLog("OUTGOING") end,
			}}
		}
    }
	self:MakeSpellMenu(frame, menu)

	EasyMenu(menu, self.dropdown, "cursor", 0, 0, "MENU")
end

-- SetAttachPoint
function module:SetAttachPoint()
	local att = self.attachment
	if (not att) then
		att = self:CreateAttachment()
	end

	self.lastTip = self.lastTip or GameTooltip

	att:ClearAllPoints()
	if (db.dockToTooltip) then
		att:SetParent(self.lastTip)
		att.anchor:SetMovable(false)
		att:EnableMouseWheel(false)
		att:EnableMouse(false)

		if (db.dockPoint == "BOTTOMRIGHT") then
			att:SetPoint("BOTTOMLEFT", self.lastTip, "BOTTOMRIGHT")
		elseif (db.dockPoint == "TOPLEFT") then
			att:SetPoint("TOPRIGHT", self.lastTip, "TOPLEFT")
		elseif (db.dockPoint == "TOPRIGHT") then
			att:SetPoint("TOPLEFT", self.lastTip, "TOPRIGHT")
		else
			att:SetPoint("BOTTOMRIGHT", self.lastTip, "BOTTOMLEFT")
		end
	else
		att:SetParent(att.anchor)
		att:SetPoint("TOPLEFT", att.anchor, "TOPLEFT")
		att.anchor:SetMovable(true)
		att:EnableMouse(true)
		att:EnableMouseWheel(true)
	end
end

-- Title
function module:Title(unit)
	if (not unit) then
		unit = self.lastUnit
	end
	if (unit) then
		local unitName = UnitFullName(unit)
		local str
		if (unitName) then
			str = format("%s - %s%s%s", L["TITLE"], classColour[select(2, UnitClass(unit))], unitName, (self.locked and " |c00FF8080(L)") or "")
		else
			str = L["TITLE"]
		end
		self.attachment.title:SetText(str)
	end
end

-- ColourUnit
function module:ColourUnit(unit)
	local c = select(2, UnitClass(unit))
	if (c) then
		c = classColour[c]
		return format("%s%s|r", c, UnitFullName(unit))
	end
	return tostring(unit)
end

-- ColourUnitByName
function module:ColourUnitByName(name)
	if (name) then
		if (UnitIsPlayer(name)) then
			local c = select(2, UnitClass(name))
			c = classColour[c]
			if (not c) then
				return name
			end
			return format("%s%s|r", c, name)
		else
			if (UnitIsFriend("player", name)) then
				return format("|cFF00FF00%s|r", name)
			else
				return format("|cFFFF0000%s|r", name)
			end
		end
	end
	return "?"
end

local icon_list = {
	"{"..ICON_TAG_RAID_TARGET_STAR1.."}",
	"{"..ICON_TAG_RAID_TARGET_CIRCLE1.."}",
	"{"..ICON_TAG_RAID_TARGET_DIAMOND1.."}",
	"{"..ICON_TAG_RAID_TARGET_TRIANGLE1.."}",
	"{"..ICON_TAG_RAID_TARGET_MOON1.."}",
	"{"..ICON_TAG_RAID_TARGET_SQUARE1.."}",
	"{"..ICON_TAG_RAID_TARGET_CROSS1.."}",
	"{"..ICON_TAG_RAID_TARGET_SKULL1.."}",
}

--local x = {timestamp = 1, event = 2, srcGUID = 3, srcName = 4, srcFlags = 5, dstGUID = 6, dstName = 7, dstFlags = 8,}

-- MakeCombatLogLine
function module:MakeCombatLogLine(a, report)
	--local msg = CombatLog_OnEvent(Blizzard_CombatLog_CurrentSettings, unpack(a)) unpack() stops at nils.. -.-
	local msg = CombatLog_OnEvent(Blizzard_CombatLog_CurrentSettings, a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23])
	if (report) then
		-- Remove colour codes
		msg = msg:gsub("|c[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]", ""):gsub("|r", "")
		msg = msg:gsub("|Htimestamp.-|h(.-)|h", "%1")		-- Remove timestamp. ok, this is from my own combat log, but what are you gonna do about it :)
		msg = msg:gsub("|Hunit.-|h(.-)|h", "%1")			-- Remove units
		msg = msg:gsub("|Haction.-|h(.-)|h", "%1")			-- Remove actions
		--msg = msg:gsub("|Hspell:(%d+):.-|h%[-(.-)%]-|h", "|cff71d5ff|Hspell:%1|h[%2]|h|r")	-- Spells have to be in this format to get sent via chat
		msg = msg:gsub("|Hspell:(%d+):.-|h(.-)|h", "|cff71d5ff|Hspell:%1|h[%2]|h|r")	-- Spells have to be in this format to get sent via chat

		-- And translate icons to {} chat format
		if (self.transIcons and strfind(msg, "|T")) then
			if (COMBATLOG_ICON_RAIDTARGET1) then
				for i = 1,8 do
					msg = msg:gsub(self.transIcons[i], icon_list[i])
				end
			else
				msg = msg:gsub("|Hicon:.-:.-|h|T.-|t|h", "")
			end
		end
	end

	return msg
end

-- UnitIcon
function module:UnitIcon(flags, report)
	if (flags) then
		flags = band(flags, self.iconFlagsMask)
		local icon = self.iconFlags[flags]
		if (icon) then
			if (report) then
				return icon[2]
			else
				return icon[1]:gsub("$size", "0")
			end
		end
	end
	return ""
end

-- MakeIconFlags
function module:MakeIconFlags()
	self.iconFlags = {}
	self.iconFlagsMask = 0
	self.transIcons = {}
	for i = 1,8 do
		local mask = _G["COMBATLOG_OBJECT_RAIDTARGET"..i]
		if (mask) then
			self.iconFlagsMask = self.iconFlagsMask + mask
			self.iconFlags[mask] = {getglobal("COMBATLOG_ICON_RAIDTARGET"..i), icon_list[i]}
		end

		local str = _G["COMBATLOG_ICON_RAIDTARGET"..i]
		if (str) then
			str = str:gsub("%-", "%%-")
			self.transIcons[i] = "|Hicon:.-:.-|h"..str.."|h"
		end
	end
end

-- CreateTooltipFrame
function module:CreateTooltipFrame(number)
	if (number == 1) then
		self.spellTip = {}
	end

	local att = self.attachment
	local tip = CreateFrame("GameTooltip", "GrimReaperInfoTip"..number, module.extraInfoTip, "GameTooltipTemplate")
	self.spellTip[number] = tip

	if (self.spellTip[1] and self.spellTip[2]) then
		self.CreateTooltipFrame = nil
	end

	return module.extraInfoTip
end

-- fadeInSpellInfo
local function fadeInSpellInfo(self, elapsed)
	if (module.spellTip) then
		for i = 1,2 do
			if (module.spellTip[i] and module.spellTip[i]:IsShown()) then
				local alpha = module.spellTip[i]:GetAlpha()
				module.spellTip[i]:SetAlpha(min(1, alpha + elapsed * 2))
			end
		end
	end
end

-- CreateExtraFrame
function module:CreateExtraFrame()
	local att = self.attachment
	module.extraInfoTip = CreateFrame("GameTooltip", "GrimReaperInfoTip", att, "GameTooltipTemplate")

	module.extraInfoTip:SetScript("OnUpdate", fadeInSpellInfo)
	module.extraInfoTip:SetScript("OnShow", function(self)
		if (module.spellTip) then
			if (module.spellTip[1]) then
				module.spellTip[1]:Hide()
			end
			if (module.spellTip[2]) then
				module.spellTip[2]:Hide()
			end
		end
	end)

	module.extraInfoTip:SetScript("OnHide", function(self) self.a = nil end)

	self.CreateExtraFrame = nil
	return module.extraInfoTip
end

-- ShowLineTip
function module:ShowLineTip(msg, r, g, b)
	local tip = self.extraInfoTip
	if (not tip) then
		tip = self:CreateExtraFrame()
	end

	tip:SetOwner(self.attachment, "ANCHOR_TOP")
	tip:SetText(msg, r, g, b)
	tip:Show()

	local childPoint11, childPoint12, childPoint21, childPoint22
	tip:ClearAllPoints()
	if ((db.growDirection == "auto" and module.attachment:GetBottom() * self.attachment:GetScale() > 130) or db.growDirection == "up") then
		if (module.attachment:GetLeft() * self.attachment:GetScale() > 500) then
			childPoint11 = "TOPRIGHT"
			childPoint12 = "BOTTOMRIGHT"
			childPoint21 = "TOPRIGHT"
			childPoint22 = "TOPLEFT"
		else
			childPoint11 = "TOPLEFT"
			childPoint12 = "BOTTOMLEFT"
			childPoint21 = "TOPLEFT"
			childPoint22 = "TOPRIGHT"
		end
	elseif ((db.growDirection == "auto" and module.attachment:GetBottom() * self.attachment:GetScale() <= 130) or db.growDirection == "down") then
		if (module.attachment:GetLeft() * self.attachment:GetScale() > 500) then
			childPoint11 = "BOTTOMRIGHT"
			childPoint12 = "TOPRIGHT"
			childPoint21 = "TOPLEFT"
			childPoint22 = "TOPRIGHT"
		else
			childPoint11 = "BOTTOMLEFT"
			childPoint12 = "TOPLEFT"
			childPoint21 = "TOPRIGHT"
			childPoint22 = "TOPLEFT"
		end
	end

	tip:SetPoint(childPoint11, self.attachment, childPoint12)
	
	return childPoint11, childPoint12, childPoint21, childPoint22
end

-- grShowExtraInfo
local function grShowExtraInfo(self)
	local msg = module:MakeCombatLogLine(self.a)
	if (msg) then
		local childPoint11, childPoint12, childPoint21, childPoint22 = module:ShowLineTip(msg, 1, 1, 1)

		local event = self.a[2]
		for i = 1,2 do
			local spellId, school
			if (self.a.harmId and self.a.helpId) then
				spellId = i == 1 and self.a.helpId or i == 2 and self.a.harmId
				school = i == 1 and self.a.helpSchool or i == 2 and self.a.harmSchool
			else
				if (i == 1) then
					spellId = self.a.helpId or self.a.harmId
					school = self.a.helpSchool or self.a.harmSchool
				else
					break
				end
			end

			if (spellId and ((harm and db.debuffTips) or (not harm and db.buffTips))) then
				if (not module.spellTip or not module.spellTip[i]) then
					module:CreateTooltipFrame(i)
				end

				module.spellTip[i]:SetOwner(self, "ANCHOR_TOP")
				module.spellTip[i]:SetHyperlink(format("spell:%d", spellId))

				local line1 = getglobal(module.spellTip[i]:GetName().."TextLeft1")
				if (line1 and school) then
					school = schoolColour[school]
					if (school) then
						line1:SetTextColor(unpack(school))
					end
				end

				module.spellTip[i]:Show()
				module.spellTip[i]:ClearAllPoints()
				if (i == 1) then
					module.spellTip[i]:SetPoint(childPoint11, module.extraInfoTip, childPoint12)
				else
					module.spellTip[i]:SetPoint(childPoint21, module.spellTip[1], childPoint22)
				end
				module.spellTip[i]:SetAlpha(0)
			else
				if (module.spellTip and module.spellTip[i]) then
					module.spellTip[i]:Hide()
				end
			end
		end
	end
end

-- grHideExtraInfo
local function grHideExtraInfo(self)
	if (module.extraInfoTip) then
		module.extraInfoTip:Hide()
	end
end

-- SetWidth
function module:SetWidth(w)
	db.frameWidth = w

	local att = self.attachment
	att:SetWidth(w)

	att.title:SetWidth(w)

	self:Tip()
end

-- CreateAttachmentLine
function module:CreateAttachmentLine(i)
	local att = self.attachment
	local frame = CreateFrame("Frame", "GrimReaper_Attachment"..i, att)
	att.frames[i] = frame
	frame.a = new()

	if (i == 1) then
		frame:SetPoint("BOTTOMRIGHT", att, "BOTTOMRIGHT", -6, 10)
		frame:SetPoint("TOPLEFT", att, "BOTTOMLEFT", 6, 25)
	else
		frame:SetPoint("BOTTOMRIGHT", att.frames[i - 1], "TOPRIGHT")
		frame:SetPoint("TOPLEFT", att.frames[i - 1], "TOPLEFT", 0, 15)
	end

	frame:SetWidth(db.frameWidth - 10)

	frame.text = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	frame.text:SetJustifyH("RIGHT")
	frame.text:SetPoint("RIGHT")		-- SetAllPoints(frame)
	frame.text:SetHeight(15)

	frame.time = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	frame.time:SetJustifyH("RIGHT")		--"LEFT")
	frame.time:SetPoint("LEFT")
	frame.time:SetHeight(15)
	frame.time:SetTextColor(1, 1, 0.5)

	frame.highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	frame.highlight:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	frame.highlight:SetBlendMode("ADD")
	frame.highlight:SetTexCoord(0.25, 0.75, 0.25, 0.75)
	frame.highlight:SetAlpha(0.3)
	frame.highlight:SetAllPoints(true)

	frame:EnableMouse(true)
	frame:SetScript("OnMouseWheel", function(self,amount) grOnMouseWheel(module.attachment,amount) end)
	frame:SetScript("OnEnter", grShowExtraInfo)
	frame:SetScript("OnLeave", grHideExtraInfo)
	frame:SetScript("OnDragStart", function(self) grDragStart(module.attachment) end)
	frame:SetScript("OnDragStop", function(self) grDragStop(module.attachment) end)
	frame:SetScript("OnMouseUp", att:GetScript("OnMouseUp"))

	frame:RegisterForDrag("LeftButton")

	--frame.UpdateTooltip = grShowExtraInfo

	return frame
end

-- HealthBar
function module:HealthBar(line, health, healthmax, guess)
	local att = self.attachment
	local frame = att.frames[line]
	if (db.bars) then
		if (not frame.texture) then
			frame.texture = frame:CreateTexture(nil, "BORDER")
			frame.texture:SetWidth(1)
			frame.texture:SetHeight(15)

			frame.healthText = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
			frame.healthText:SetWidth(90)
			frame.healthText:SetTextColor(1, 1, 1)
		end

		local barTex = self.bartexture

		frame.texture:SetTexture(barTex)

		frame.texture:ClearAllPoints()
		frame.healthText:ClearAllPoints()
		if (db.barsInside) then
			frame.texture:SetPoint("RIGHT", frame, "RIGHT")
			frame.healthText:Hide()
		else
			if (db.barsLeft) then
				frame.texture:SetPoint("RIGHT", frame, "LEFT", -4, 0)
				frame.healthText:SetJustifyH("RIGHT")
				frame.healthText:SetPoint("RIGHT", frame, "LEFT", -7, 1)
			else
				frame.texture:SetPoint("LEFT", frame, "RIGHT", 4, 0)
				frame.healthText:SetJustifyH("LEFT")
				frame.healthText:SetPoint("LEFT", frame, "RIGHT", 7, 1)
			end
			frame.healthText:Show()
		end
		frame.texture:Show()

		if (health == "DEAD") then
			frame.healthText:SetText(DEAD)
			frame.texture:SetWidth(1)
			frame.texture:SetVertexColor(1, 0, 0)
			frame.health = "DEAD"

		elseif (health) then
			local percentage = health / healthmax
			local perc = percentage * 100
			if (guess) then
				if (db.barsLeft) then
					frame.healthText:SetFormattedText("* %d%%", perc)
				else
					frame.healthText:SetFormattedText("%d%% *", perc)
				end
			else
				frame.healthText:SetFormattedText("%d%%", perc)
			end
			if (db.barsInside) then
				frame.texture:SetWidth((db.frameWidth - 12) * percentage)
			else
				frame.texture:SetWidth(min(100, max(1, perc)))
			end
			frame.health = perc

			local r, g, b
			if (percentage < 0.5) then
				r = 1
				g = 2*percentage
				b = 0
			else
				g = 1
				r = 2*(1 - percentage)
				b = 0
			end

			if (r >= 0 and g >= 0 and b >= 0 and r <= 1 and g <= 1 and b <= 1) then
				frame.texture:SetVertexColor(r, g, b)
			end
		end
	else
		if (frame and frame.texture) then
			frame.texture:Hide()
			frame.healthText:Hide()
			frame.health = nil
		end
	end
end

-- Save/Load filters
local noSaveFilter
local function grCombatLogAddFilter(...)
	if (not noSaveFilter) then
		if (not module.savedState) then
			module.savedState = new()
		end
		tinsert(module.savedState, new(...))
	end
end

local function grCombatLogResetFilter()
	if (not noSaveFilter) then
		module.savedState = deepDel(module.savedState)
	end
end

hooksecurefunc("CombatLogResetFilter", grCombatLogResetFilter)
hooksecurefunc("CombatLogAddFilter", grCombatLogAddFilter)

function module:CombatLogSaveFilter()
	local a = self.savedState
	self.savedState = nil
	return a
end

function module:CombatLogLoadFilter(restore)
	if (restore) then
		noSaveFilter = true
		CombatLogResetFilter()
		for k,v in ipairs(restore) do
			CombatLogAddFilter(v[1], v[2], v[3])
		end
		deepDel(self.savedState)
		self.savedState = restore
		noSaveFilter = nil
	end
end

-- ShuffleListUpward
function module:ShuffleListUpward(timestamp)
	local shown = 0
	local att = self.attachment

	if (#att.frames < db.lines) then
		self:CreateAttachmentLine(#att.frames + 1)
	end

	if (#att.frames > 1) then
		local bottom = att.frames[1]
		local lines = #att.frames
		local removed = tremove(att.frames, lines)
		tinsert(att.frames, 1, removed)

		removed:ClearAllPoints()
		bottom:ClearAllPoints()

		removed:SetPoint("BOTTOMRIGHT", att, "BOTTOMRIGHT", -6, 10)
		removed:SetPoint("TOPLEFT", att, "BOTTOMLEFT", 6, 25)

		bottom:SetPoint("BOTTOMRIGHT", removed, "TOPRIGHT")
		bottom:SetPoint("TOPLEFT", removed, "TOPLEFT", 0, 15)

		for i,frame in ipairs(att.frames) do
			if (frame:IsShown()) then
				shown = i - 1
			end
		end
	else
		shown = 0
	end

	if (shown > 0 and db.showtime) then
		if (db.deltaTime == 1) then
			for i = 2,#att.frames do
				local frame = att.frames[i]
				frame.time:SetText(self:MakeDeltaTime(timestamp - frame.a[1], true))
				frame.time:SetJustifyH("RIGHT")
				frame.time:SetWidth(self.timeWidth)
			end
		elseif (db.deltaTime == 2) then
			local frame = att.frames[2]
			frame.time:SetText(self:MakeDeltaTime(timestamp - frame.a[1], true))
			frame.time:SetJustifyH("RIGHT")
			frame.time:SetWidth(self.timeWidth)
		end
	end

	if (att.frames[1]) then
		att.frames[1].text:SetText("")
		att.frames[1].time:SetText("")
	end

	return shown
end

-- GetModifier
local function GetModifier(frame, critical, glancing, crushing)
	frame.a.critical = critical
	frame.a.glancing = glancing
	frame.a.crushing = crushing
end

-- AddAmount
local function AddAmount(ftext, amount, resisted, blocked, absorbed, crushing, school, spellSchool)
	if (resisted or blocked or absorbed) then
		local prefix = format("%s%s%s", resisted and "r" or "", blocked and "b" or "", absorbed and "a" or "")
		local r = (resisted or 0) + (blocked or 0) + (absorbed or 0)
		local percentResist = 100 - (amount / (amount + r) * 100)
		if (crushing) then
			ftext:SetFormattedText("|cFF80FFFF(%s%d%%)|r %s -%d", prefix, percentResist, L["CRUSHING"], amount)
		else
			ftext:SetFormattedText("|cFF80FFFF(%s%d%%)|r -%d", prefix, percentResist, amount)
		end
	else
		if (crushing) then
			ftext:SetFormattedText("%s -%d", L["CRUSHING"], amount)
		else
			ftext:SetFormattedText("-%d", amount)
		end
	end
	ftext:SetTextColor(unpack(schoolColour[school or spellSchool or 0] or basicColour))
end

-- SWING_DAMAGE
function module:SWING_DAMAGE(frame, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	frame.a.amount = amount - overkill
	AddAmount(frame.text, amount, resisted, blocked, absorbed, crushing, school)
	GetModifier(frame, critical, glancing, crushing)
end

function module:SWING_MISSED(frame, missType)
	frame.text:SetText(getglobal(missType) or tostring(missType))
	frame.text:SetTextColor(unpack(specialColour))
end

function module:SPELL_DAMAGE(frame, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	frame.a.amount = amount - overkill
	AddAmount(frame.text, amount, resisted, blocked, absorbed, crushing, school, spellSchool)
	GetModifier(frame, critical, glancing, crushing)
	frame.a.spellName = spellName
	frame.a.harmId = spellId
	frame.a.harmSchool = spellSchool
end

function module:SPELL_MISSED(frame, spellId, spellName, spellSchool, missType, amountMissed, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	local miss = _G["ACTION_SPELL_MISSED_"..missType]
	if (not miss) then
		if (absorbed) then
			miss = ACTION_SPELL_MISSED_ABSORB
		elseif (blocked) then
			miss = ACTION_SPELL_MISSED_BLOCK
		elseif (resisted) then
			miss = ACTION_SPELL_MISSED_RESISTED
		else
			miss = ACTION_SPELL_MISSED_MISS
		end
	end

	frame.text:SetText(miss)
	frame.text:SetTextColor(unpack(specialColour))
	frame.a.spellName = spellName
	frame.a.harmId = spellId
	frame.a.harmSchool = spellSchool
end

function module:SPELL_HEAL(frame, spellId, spellName, spellSchool, amount, overhealing, absorbed, critical)
	frame.a.amount = amount - overhealing
	frame.text:SetFormattedText("+%d", amount)
	frame.text:SetTextColor(unpack(healColour))
	GetModifier(frame, critical, glancing, crushing)
	frame.a.spellName = spellName
	frame.a.helpId = spellId
	frame.a.helpSchool = spellSchool
end

function module:SPELL_AURA_DISPELLED(frame, spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType)
	local srcFlags = frame.a[6]
	local srcName = frame.a[5]
	local srcGUID = frame.a[4]
	local c
	if (band(srcFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) and srcName and UnitGUID(srcName) == srcGUID) then
		c = select(2, UnitClass(srcName))
		if (c) then
			frame.text:SetFormattedText("%s%s|r %s", classColour[c], srcName:sub(1, 8), spellName)
		end
	end
	if (not c) then
		frame.text:SetFormattedText("%s", spellName)
	end
	frame.a.helpId = spellId
	frame.a.helpSchool = spellSchool
	frame.a.harmId = extraSpellId
	frame.a.harmSchool = extraSpellSchool
end

function module:SPELL_AURA_APPLIED(frame, spellId, spellName, spellSchool, auraType)
	local event = frame.a[2]
	frame.text:SetFormattedText("%s%s", event == "SPELL_AURA_APPLIED" and "++" or "--", spellName)
	local colour
	if (auraType == "BUFF") then
		colour = buffColour
		frame.a.helpId = spellId
		frame.a.helpSchool = spellSchool
	else
		colour = debuffColour
		frame.a.harmId = spellId
		frame.a.harmSchool = spellSchool
	end
	frame.a.spellName = spellName
	frame.text:SetTextColor(unpack(colour))
end

function module:SPELL_INSTAKILL(frame)
	frame.text:SetText("Kill")
end

function module:SPELL_CAST_SUCCESS(frame, spellId, spellName, spellSchool)
	frame.text:SetFormattedText("*%s*", spellName)
	frame.a.helpId = spellId
	frame.a.helpSchool = spellSchool
	frame.a.spellName = spellName
end

function module:DAMAGE_SHIELD(frame, spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	frame.a.amount = amount - overkill
	frame.text:SetFormattedText("DS -%d", amount)
	GetModifier(frame, critical, glancing, crushing)
	frame.a.harmId = spellId
	frame.a.harmSchool = spellSchool
end

function module:ENVIRONMENTAL_DAMAGE(frame, environmentalType, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	local spellName = _G["ACTION_ENVIRONMENTAL_DAMAGE_"..environmentalType]
	if (resisted or blocked or absorbed) then
		local prefix = format("%s%s%s", resisted and "r" or "", blocked and "b" or "", absorbed and "a" or "")
		local r = (resisted or 0) + (blocked or 0) + (absorbed or 0)
		local percentResist = 100 - (amount / (amount + r) * 100)
		frame.text:SetFormattedText("|cFF80FFFF(%s%d%%)|r %s -%d", prefix, percentResist, spellName, amount)
	else
		frame.text:SetFormattedText("%s -%d", spellName or "Env", amount)
	end
	frame.text:SetTextColor(unpack(schoolColour[school or 0] or basicColour))
end

module.RANGE_DAMAGE = module.SPELL_DAMAGE
module.RANGE_MISSED = module.SPELL_MISSED
module.SPELL_PERIODIC_DAMAGE = module.SPELL_DAMAGE
module.SPELL_PERIODIC_MISSED = module.SPELL_MISSED
module.SPELL_PERIODIC_HEAL = module.SPELL_HEAL
module.SPELL_AURA_STOLEN = module.SPELL_AURA_DISPELLED
module.SPELL_AURA_REMOVED = module.SPELL_AURA_APPLIED

function module:AddLine(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	line = line + 1
	local att = self.attachment
	local frame = att.frames[line]
	if (not frame) then
		frame = self:CreateAttachmentLine(line)
	end

	--local color, missType
	--local spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing, overkill, overhealing

	local ftext = frame.text
	frame.a = del(frame.a)
	frame.a = new(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)

	local f = self[event]
	if (f) then
		f(self, frame, ...)
	end

	if (frame.a.critical or frame.a.crushing) then
		frame.bold = true
		frame.text:SetFontObject("GameFontNormalLarge")
	else
		frame.bold = nil
		frame.text:SetFontObject("GameFontNormal")
	end

	-- frame.text:SetTextColor(unpack(color))

	if (db.showtime) then
		local time = format("%s|cFFC0FFC0.%03d", date(db.timeformat, timestamp), timestamp * 1000 % 1000)

		frame.time:SetJustifyH("LEFT")
		frame.time:SetWidth(db.frameWidth)
		frame.time:Show()

		if (line == 1 and self.offset == 0) then
			local test
			if (strlen(time) < 17) then	-- We need at least "-00.000" characters (exluding the |c colour code)
				test = "-00.000"
			else
				test = time
			end
			frame.time:SetText(test)
			local w = frame.time:GetStringWidth()
			if (not self.timeWidth or w > self.timeWidth) then
				self.timeWidth = w
			end
		end

		frame.time:SetText(time)
		frame.time:SetWidth(self.timeWidth)
		frame.time:SetJustifyH("RIGHT")

		if (db.deltaTime and (self.offset > 0 or line > 1)) then
			frame.time:SetWidth(self.timeWidth)
			frame.time:SetJustifyH("RIGHT")
			local t
			if (db.deltaTime == 1) then
				t = timestamp - self.startTimeDelta
			else
				local nextFrame = att.frames[line - 1]
				if (nextFrame) then
					local prevTime = nextFrame.a[1]
					t = timestamp - prevTime
				else
					t = timestamp - self.startTimeDelta
				end
			end
			frame.time:SetText(self:MakeDeltaTime(t, true))
		end

		frame.text:SetWidth(db.frameWidth - 12 - self.timeWidth)
	else
		frame.time:Hide()
		frame.text:SetWidth(db.frameWidth - 12)
	end

	frame:Show()

	if (module.extraInfoTip and module.extraInfoTip:IsOwned(frame)) then
		grShowExtraInfo(frame)
	end
end

-- MakeDeltaTime
function module:MakeDeltaTime(t, coloured)
	t = abs(t)
	local colour = coloured and "|cFFC0FFC0" or ""
	if (t < 60) then
		return format("-%d%s.%03d", t, colour, t * 1000 % 1000)
	elseif (t < 3600) then
		return format("-%s%s.%03d", date("%M:%S", t):gsub("^0([0-9])", "%1"), colour, t * 1000 % 1000)
	else
		return format("-%s%s.%03d", date("%H:%M:%S", t):gsub("^0([0-9])", "%1"), colour, t * 1000 % 1000)
	end
end

-- FinalizeLines
function module:FinalizeLines()
	local att = self.attachment
	for i = line + 1,#att.frames do
		local frame = att.frames[i]
		if (frame) then
			frame:Hide()
		end
	end
end

-- UpdateAmount
function module:UpdateHealth(line, health, healthmax)
	local att = self.attachment
	local frame = att.frames[line]
	local a = frame.a
	local event = a[2]
	local amount = a.amount

	if (amount and health ~= "DEAD") then
		amount = amount - (a.overhealing or 0)
		if (strfind(event, "DAMAGE")) then
			health = max(0, min(healthmax, health - a.amount))
		else
			health = max(0, min(healthmax, health + a.amount))
		end
	end

	return health, healthmax
end

-- DoHealth
function module:DoHealth()
	local att = self.attachment
	local healthList = db.healthList[self.lastName]
	if (healthList) then
		local startTime, startLine
		for i = #att.frames,1,-1 do
			local frame = att.frames[i]
			if (frame:IsShown()) then
				startTime = frame.a[1]
				startLine = i
				break
			end
		end
		local endTime
		if (att.frames[1]) then
			endTime = att.frames[1].a[1]
		end

		if (startTime and endTime) then
			local entry, entryNo, guess

			-- Find health update for this time
			for i = 1,#healthList do
				local e = healthList[i]
				if (e and e.time == startTime) then
					entry = e
					entryNo = i
					break
				end
			end
			if (not entry) then
				-- See if we can find an entry that spans the top list item
				for i = #healthList,2,-1 do
					local e = healthList[i]
					if (e.time > startTime) then
						local nextEntry = healthList[i - 1]
						if (nextEntry and nextEntry.time < startTime) then
							entry = nextEntry
							entryNo = i - 1
							guess = true
							break
						end
					end
				end
				if (not entry) then
					local e = healthList[#healthList]
					if (e and e.time < startTime) then
						-- Just use the last one we have
						entry = e
						entryNo = #healthList
						guess = true
					end
				end
			end
			if (not entry) then
				-- Health list starts late, so find how far down the list we need to begin
				entryNo = 1
				entry = healthList[1]
				while (entry and startTime and startTime ~= entry.time) do
					local nextLine = att.frames[startLine - 1]
					if (nextLine and nextLine.a and nextLine.a[1] > entry.time and entry.time > startTime) then
						break
					end
					startLine = startLine - 1
					startTime = att.frames[startLine] and att.frames[startLine].a[1]
				end
				if (not startTime) then
					entryNo, entry = nil, nil
				end
			end

			if (entry and entryNo) then
				local health, healthmax = entry.health, entry.healthmax

				if (startTime <= endTime) then
					for j = #att.frames,startLine + 1,-1 do
						local frame = att.frames[j]
						if (frame.texture) then
							frame.health = nil
							frame.texture:Hide()
							frame.healthText:Hide()
						end
					end

					for j = startLine,1,-1 do
						local frame = att.frames[j]

						while (true) do
							local entry2 = healthList[entryNo + 1]
							if (entry2 and entry2.time <= frame.a[1]) then
								entry = entry2
								entryNo = entryNo + 1
								health, healthmax = entry.health, entry.healthmax
								guess = nil
							else
								break
							end
						end

						if (guess) then
							if (j < startLine) then
								health, healthmax = self:UpdateHealth(j, health, healthmax)
							end
						end

						self:HealthBar(j, health, healthmax, guess)

						guess = true
					end
					return
				end
			end
		end
	end

	for i,frame in pairs(att.frames) do
		if (frame.texture) then
			frame.texture:Hide()
			frame.healthText:Hide()
			frame.health = nil
		end
	end
end

-- OptionalFilters
function module:OptionalFilters(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	if (event == "SPELL_ENERGIZE") then
		return false			-- Never want this
	end

	if (event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_APPLIED") then
		local spellId, spellName, school, auraType = ...
		if (auraType == "BUFF") then
			if (db.buffs) then
				if (db.filter) then
					if (db.filter[spellId] or db.filter[spellName]) then
						return false
					end
				end
			else
				return false
			end

		elseif (auraType == "DEBUFF") then
			return db.debuffs
		end

	end

	return true
end

-- DoLines
function module:DoLines()
	local unitName = self.lastName
	line = 0
	self.startTimeDelta = nil
	self.prevLineStamp = nil
	self.timeSpanStart = nil
	self.timeSpanEnd = nil
	self.firstTimeStamp = nil

	local gotValid = 0
	while (true) do
		local color
		local timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags = CombatLogGetCurrentEntry()
		if (dstName == unitName) then
			if (self:OptionalFilters(CombatLogGetCurrentEntry())) then
				if (not self.firstTimeStamp) then
					self.firstTimeStamp = timestamp
				end
				if (not self.startTimeDelta) then
					self.startTimeDelta = timestamp
				end

				gotValid = gotValid + 1

				if (gotValid == self.offset) then
					self.prevLineStamp = timestamp
				end

				if (gotValid > self.offset) then
					if (not self.timeSpanEnd) then
						self.timeSpanEnd = timestamp
					end

					self:AddLine(CombatLogGetCurrentEntry())
					if (line >= db.lines) then
						self.timeSpanStart = timestamp
						break
					end
				end
			end
		end

		if (not CombatLogAdvanceEntry(-1)) then
			self.oldestTimeStamp = timestamp
			-- Hit top
			if (self.offset > 0) then
				self.offset = self.offset - 1
				return true, gotValid
			end
			break
		end
	end
	return false, gotValid
end

-- CreateScroll
function module:CreateScroll()
	local att = self.attachment
	att.scroll = att:CreateTexture(nil, "OVERLAY")
	att.scroll:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	att.scroll:Hide()
	att.scroll:SetWidth(3)
	att.scroll:SetVertexColor(0, 0.9, 0.9)
end

-- DoScroll
function module:DoScroll()
	local att = self.attachment

	if (db.dockToTooltip) then
		if (att.scroll) then
			att.scroll:Hide()
		end
		return
	end

	if (not att.scroll) then
		self:CreateScroll()
	end

	-- Get time span of log so we can position the scroll bar
	CombatLogSetCurrentEntry(0)
	local timestampEnd = CombatLogGetCurrentEntry()		-- self.firstTimeStamp
	CombatLogSetCurrentEntry(1)
	local timestampStart = CombatLogGetCurrentEntry()
	local timeSpan = timestampEnd and (timestampEnd - timestampStart)

	self:HouseCleaning(timestampStart)

	if (timestampEnd and self.timeSpanStart and self.timeSpanEnd) then
		local windowTimeSpan = self.timeSpanEnd - self.timeSpanStart
		local targetWindowHeight = 15 * min(line, db.lines)

		local t = timestampStart
		timestampStart = timestampStart - t
		timestampEnd = timestampEnd - t
		self.timeSpanStart = self.timeSpanStart - t
		self.timeSpanEnd = self.timeSpanEnd - t

		local barSize = windowTimeSpan / timeSpan * targetWindowHeight
		local offsetTop = self.timeSpanStart / timestampStart * targetWindowHeight
		local offsetBottom = self.timeSpanEnd / timestampEnd * targetWindowHeight

		att.scroll:ClearAllPoints()
		att.scroll:SetHeight(barSize)
		if (db.barsLeft) then
			att.scroll:SetPoint("BOTTOMLEFT", att, "BOTTOMRIGHT", 0, targetWindowHeight - offsetBottom + 8)
		else
			att.scroll:SetPoint("BOTTOMRIGHT", att, "BOTTOMLEFT", -0, targetWindowHeight - offsetBottom + 8)
		end

		att.scroll:Show()
	else
		att.scroll:Hide()
	end

	if (self.offset > 0) then
		local se = att.scrollEnd
		if (not se) then
			se = self:CreateScrollEnd()
		end
		att.scrollEnd:Show()

	elseif (att.scrollEnd) then
		att.scrollEnd:Hide()
	end
end

-- CreateScrollEnd
function module:CreateScrollEnd()
	local att = self.attachment
	local se = CreateFrame("Button", nil, att)

	se:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Up")
	se:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Down")
	se:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Disabled")
	se:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	se:SetWidth(32)
	se:SetHeight(32)

	se:SetScript("OnClick",
		function(self)
			module.offset = 0
			module:Tip()
		end
	)

	se:SetPoint("TOPRIGHT", att, "BOTTOMRIGHT", 2, 4)

	att.scrollEnd = se
	return se
end

-- Tip
--function module:Tip(unit, tooltip)
function module:Tip(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	local prevUnit = self.lastUnit
	local unit, tooltip
	if (type(timestamp) == "number") then
		-- 1 single new event
	else
		unit, tooltip = timestamp, event
		timestamp, event = nil, nil
	end

	local att = self.attachment
	if (not db or not db.enabled or db.hide) then
		if (att) then
			att:Hide()
		end
		return
	end

	if (not unit) then
		unit = self.lastUnit
		tooltip = self.lastTip
	else
		if (self.locked) then
			return
		end
	end
	self.lastTip = tooltip or GameTooltip

	if (not unit) then
		return
	end
	--local mask = (UnitIsUnit(unit, "player") and 1) or (UnitInParty(unit) and 2) or (UnitInRaid(unit) and 4)
	local mask = (UnitIsUnit(unit, "player") and COMBATLOG_OBJECT_AFFILIATION_MINE) or ((IsInRaid() and UnitInRaid(unit)) and COMBATLOG_OBJECT_AFFILIATION_PARTY+COMBATLOG_OBJECT_AFFILIATION_RAID) or (UnitInParty(unit) and COMBATLOG_OBJECT_AFFILIATION_PARTY)
	if (not mask) then
		return
	end

	if (not att) then
		att = self:CreateAttachment()
	end
	self:SetAttachPoint()

	if (self.emptyText) then
		self.emptyText:Hide()
	end

	local oldShownLines = self.shownLines
	line = 0

	if (timestamp and self.offset == 0) then
		local shown = self:ShuffleListUpward(timestamp)
		self:AddLine(timestamp, event, _, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)

		line = shown + 1
		self:DoHealth()
	else
		if (CombatLogUpdateFrame and CombatLogUpdateFrame.refiltering and CombatLogQuickButtonFrame_CustomProgressBar) then
			if (not self:IsHooked(CombatLogQuickButtonFrame_CustomProgressBar, "OnHide")) then
				self:HookScript(CombatLogQuickButtonFrame_CustomProgressBar, "OnHide",
					function(self)
						module:Tip()
						module:Unhook(CombatLogQuickButtonFrame_CustomProgressBar, "OnHide")
					end)
			end
			return
		end

		local oldFilter = self:CombatLogSaveFilter()

		unit = self:FixUnit(unit)
		local unitName = UnitFullName(unit)
		self.lastName = unitName
		local changed
		if (unit ~= self.lastUnit) then
			self.lastUnit = unit
			changed = true
		end

		local preCount = CombatLogGetNumEntries()
		noSaveFilter = true
		CombatLogResetFilter()
		--CombatLogAddFilter(self.eventString, nil, mask + 0x10 + 0x100 + 0x400)
		CombatLogAddFilter(self.eventString, nil, mask + COMBATLOG_OBJECT_REACTION_FRIENDLY + COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_TYPE_PLAYER)
		noSaveFilter = nil

		local valid = CombatLogSetCurrentEntry(0)
		local count = CombatLogGetNumEntries()

		if (valid and count > 0) then
			local hitTop, gotLines = self:DoLines()
			if (hitTop) then
				if (self.oldestTimeStamp) then
					self:HouseCleaning(self.oldestTimeStamp)
				end
				CombatLogSetCurrentEntry(0)

				-- Need to redo because we hit the top
				hitTop, gotLines = self:DoLines()
				if (gotLines == 0) then
					self:NothingToShow()
				end
			end

			if (gotLines > 0) then
				self:FinalizeLines()
				self:DoHealth()
				self:DoScroll()
			else
				self:NothingToShow()
			end
		else
			if (db.dockToTooltip) then
				att:Hide()
				self:CombatLogLoadFilter(oldFilter)
				return

			elseif (not self.shownLines) then
				self:NothingToShow()
				return

			else
				self:CombatLogLoadFilter(oldFilter)
				self.lastUnit = prevUnit
				return
			end
		end

		self:Title()
		self:CombatLogLoadFilter(oldFilter)
	end

	self.shownLines = min(line, db.lines)
	att:SetHeight(15 * max(1, self.shownLines) + 17)
	att.anchor:SetHeight(15 * max(1, self.shownLines) + 17)
	att:Show()
end

-- NothingToShow
function module:NothingToShow()
	local att = self.attachment
	if (att.scroll) then
		att.scroll:Hide()
	end

	if (db.dockToTooltip) then
		att:Hide()
	else
		-- Show blank reaper
		self:Title()

		for k,v in pairs(att.frames) do
			v:Hide()
		end

		if (not self.emptyText) then
			self.emptyText = att:CreateFontString(nil, "ARTWORK", "GameFontNormal")
			self.emptyText:SetAllPoints(att)
			self.emptyText:SetTextColor(0.5, 0.5, 0.5)
			self.emptyText:SetText(L["NOINFO"])
		end
		self.emptyText:Show()

		att:SetHeight(42)
		att.anchor:SetHeight(42)
		att:Show()
		line = 1
	end

	self.shownLines = 0
	att:SetHeight(15 + 17)
	att.anchor:SetHeight(15 + 17)
end

do
	-- 10 messages in 1 sec
	-- 15 msgs in 15 sec

	local throttleLimitSmall = 8				-- 10
	local throttleLimitLarge = 14				-- 15
	local window

	-- onUpdateOuputThrottle
	local function onUpdateOuputThrottle(self, elapsed)
		if (module.outputQueue) then
			if (not window) then
				window = new()
			end

			local smallTime = GetTime() - 1
			local largeTime = GetTime() - 15
			local purgeTime = GetTime() - 30
			-- Purge stuff older than 3 sec
			while (#window > 0 and window[1] < purgeTime) do
				tremove(window, 1)
			end

			local sentInWindowSmall, sentInWindowLarge = 0, 0
			for i,t in ipairs(window) do
				if (t >= largeTime) then
					sentInWindowLarge = sentInWindowLarge + 1
				end
				if (t >= smallTime) then
					sentInWindowSmall = sentInWindowSmall + 1
				end
			end

			if (sentInWindowSmall >= throttleLimitSmall) then
				return
			elseif (sentInWindowLarge >= throttleLimitLarge) then
				return
			end

			local e = tremove(module.outputQueue, 1)
			if (e) then
				SendChatMessage(e.msg, e.channel, nil, e.index)
				tinsert(window, GetTime())
				del(e)

				if (not next(module.outputQueue)) then
					module.outputQueue = del(module.outputQueue)
				end
			end
		else
			window = del(window)
			self:SetScript("OnUpdate", nil)
		end
	end

	-- OutputThrottle
	local function OutputThrottle(channel, channelIndex, ...)
		if (not self.outputQueue) then
			self.outputQueue = new()
		end
		local n = new()
		n.channel = channel
		n.index = channelIndex
		n.msg = format(...)
		tinsert(self.outputQueue, n)

		if (not self.outputFrame) then
			self.outputFrame = CreateFrame("Frame")
		end
		self.outputFrame:SetScript("OnUpdate", onUpdateOuputThrottle)
	end

	-- Output
	function module:Output(...)
		local channel = db.channel
		if (channel == "RAID" and not IsInRaid()) then
			channel = "PARTY"
		end
		if (channel == "PARTY" and GetNumGroupMembers() == 0) then
			return
		end
		if (channel == "CHANNEL" and GetChannelName(db.channelIndex) == 0) then
			return
		end
		if (channel == "SELF") then
			DEFAULT_CHAT_FRAME:AddMessage(format(...))
		else
			if (_G.ChatThrottleLib) then
				OutputThrottle, onUpdateOuputThrottle = nil, nil
				_G.ChatThrottleLib:SendChatMessage("BULK", "GrimReaper", format(...), channel, nil, db.channelIndex)
			elseif (OutputThrottle) then
				OutputThrottle(...)
			end

			--SendChatMessage(format(...), channel, nil, db.channelIndex)
		end
	end
end

-- SetChannel
function module:SetChannelRaw(chan, ind)
	db.channel = chan
	db.channelIndex = ind
end

-- SetChannel
function module:SetChannel(chan)
	local oldChannel = db.channel
	if (chan) then
		db.channel = strupper(chan)

		if (tonumber(db.channel) and tonumber(db.channel) > 0) then
			if (GetChannelName(db.channelIndex) > 0) then
				db.channelIndex = tonumber(db.channel)
				db.channel = "CHANNEL"
			else
				db.channel = oldChannel
				self:Print(REAPER_CHANNEL_INVALID)
				return
			end

		elseif (not (db.channel == "RAID" or db.channel == "PARTY" or db.channel == "GUILD" or db.channel == "SAY" or db.channel == "BATTLEGROUND" or db.channel == "YELL" or db.channel == "OFFICER")) then
			local c = db.channel
			db.channelIndex = db.channel
			db.channel = "WHISPER"
			for i = 1,10 do
				local used, name = GetChannelName(i)
				if (name) then
					if (strlower(name) == strlower(c)) then
						db.channelIndex = name
						db.channel = "CHANNEL"
						break
					end
				end
			end
		end
	end

	if (not db.channel) then
		db.channel = "RAID"
	end

	self:Printf(REAPER_CHANNEL, self:GetChannelDisplay())
end

-- GetChannelDisplay
function module:GetChannelDisplay()
	local c, ret
	if (db.channel == "WHISPER") then
		local color
		for unit in module:IterateRoster() do
			if (strlower(UnitName(unit)) == strlower(db.channelIndex)) then
				color = classColour[select(2, UnitClass(unit))]
				break
			end
		end

		ret = (getglobal(db.channel) or db.channel).." "..(color or "")..db.channelIndex.."|r"

	elseif (db.channel == "CHANNEL") then
		local id, name = GetChannelName(db.channelIndex)
		if (name) then
			local t = ChatTypeInfo["CHANNEL"..db.channelIndex]
			if (t) then
				c = {r = t.r, g = t.g, b = t.b}
			end
			ret = name
		end
	else
		ret = getglobal("CHAT_MSG_"..(db.channel or "RAID")) or db.channel or "RAID"
	end

	if (not ret) then
		ret = "RAID"
	end

	if (not c) then
		if (ChatTypeInfo[db.channel]) then
			local t = ChatTypeInfo[db.channel]
			if (t) then
				c = {r = t.r, g = t.g, b = t.b}
			end
		end
	end

	if (c) then
		ret = format("|c00%02X%02X%02X%s|r", c.r * 255, c.g * 255, c.b * 255, ret)
	end

	return ret
end

-- Report
function module:ReportShown()
	local att = self.attachment
	if (not att or not self.lastUnit) then
		return
	end

	local unitName = UnitFullName(self.lastUnit)
	self:Output(L["REPORTTITLE"], unitName)

	local lastTime = att.frames and att.frames[1] and att.frames[1].a and att.frames[1].a[1]

	local start = #att.frames
	if (start > 12) then
		start = 12
	end
	for i = start,1,-1 do
		local frame = att.frames[i]
		if (frame and frame:IsShown()) then
			local a = frame.a
			local time, msg, health
			local suffix = ""

			if (i == 1) then
				time = format("%s.%03d>", date(db.timeformat, a[1]), a[1] * 1000 % 1000)
			else
				local t
				if (db.deltaTime == 2) then
					local f = att.frames[i - 1]
					local nextTimeStamp = f and f.a and f.a[1]
					if (nextTimeStamp) then
						t = a[1] - nextTimeStamp
					else
						t = a[1] - lastTime
					end
				else
					t = a[1] - lastTime
				end
				local temp = self:MakeDeltaTime(t)..">"
		        time = strrep(" ", 21 - (strlen(temp) * 3 / 2))..temp
			end

			msg = frame.text:GetText()
			msg = msg:gsub("|c[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]", "")
			msg = msg:gsub("|r", "")

			if (a.event == "SPELL_HEAL" or a.event == "SPELL_PERIODIC_HEAL") then
				suffix = L["Heal"]
			else
				if (a.harmSchool and a.harmSchool > 1) then
					suffix = schools[a.harmSchool]
				end
			end
			local modifier = a.crushing and "CRUSHING" or a.critical and "CRITICAL" or a.glancing and "GLANCING"
				
			if (modifier) then
				local Mod = getglobal(format("TEXT_MODE_A_STRING_RESULT_%s%s", modifier, a.spellName and "_SPELL" or ""))
				if (Mod) then
					suffix = format("%s %s", suffix, Mod)
				end
			end

			health = frame.health

			if (health) then
				if (health == "DEAD") then
					local dead = format("_____%s_____", DEAD)
					health = strsub(dead, strlen(dead) / 2 - 4, strlen(dead) / 2 + 5)
				else
					local c = health / 10
					health = strrep("#", c)..strrep("_", 10 - c)
				end
			else
				health = strrep("_", 10)
			end

			local icon = self:UnitIcon(a[7], true)			-- .srcRaidFlags
			self:Output("%s %s %s %s%s", health, time, msg, suffix or "", icon or "")
		end
	end

	return
end

-- Lock
function module:Lock()
	self.cycleState = nil
	if (self.lastUnit or self.locked) then
		self.locked = not self.locked
		if (self.locked) then
			self:Printf(L["LOCKED"], self:ColourUnit(self.lastUnit))
		end
		self:Tip()
	end
end

-- ADDON_LOADED
function module:ADDON_LOADED(e, addon)
	if (strfind(addon, "CombatLog")) then
		playerMask = COMBATLOG_OBJECT_CONTROL_PLAYER
		groupMask = COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_RAID -- + COMBATLOG_OBJECT_CONTROL_PLAYER
		self:SetColours()
		self:MakeIconFlags()
		self.combatLogStuffGot = true

		self:UnregisterEvent("ADDON_LOADED")
	end
end

-- ShowLog
function module:ShowLog(which)
	CloseDropDownMenus()
	if (self.lastUnit and UnitExists(self.lastUnit)) then
		Blizzard_CombatLog_UnitMenuClick(which, UnitFullName(self.lastUnit), UnitGUID(self.lastUnit))
	end
end

-- OnClick
function module:OnClick()
	db.hide = not db.hide
	self.cycleState = nil
	self:Tip()
	self:DoIcon()
end

-- DoIcon
function module:DoIcon()
	if (db.hide) then
		LDB.icon = "Interface\\Addons\\GrimReaper\\Images\\Death"
	else
		LDB.icon = "Interface\\Addons\\GrimReaper\\Images\\DeathEyes"
	end
end

-- MakeEventList
function module:MakeEventList()
	-- Event list: true signifies damage/heal events which we'll want to check UNIT_HEALTH for on next update
	self.eventList = {
		SWING_DAMAGE = true, SWING_MISSED = false,
		RANGE_DAMAGE = true, RANGE_MISSED = false,
		SPELL_PERIODIC_DAMAGE = true, SPELL_PERIODIC_MISSED = false,
		SPELL_HEAL = true, SPELL_PERIODIC_HEAL = true,
		SPELL_DAMAGE = true, SPELL_MISSED = false,
		DAMAGE_SHIELD = true,
		ENVIRONMENTAL_DAMAGE = true,
		SPELL_AURA_REMOVED = false, SPELL_AURA_APPLIED = false,
		SPELL_INSTAKILL = false
	}

	if (db.curesAndSteals) then
		module.eventList.SPELL_AURA_DISPELLED = false
		module.eventList.SPELL_AURA_STOLEN = false
	end

	if (db.casts) then
		module.eventList.SPELL_CAST_SUCCESS = false
	end

	local temp = new()
	for e in pairs(self.eventList) do
		tinsert(temp, e)
	end
	self.eventString = table.concat(temp, ",")
	del(temp)
end

-- ShowCombatLog
function module:ShowCombatLog()
	local unit = UIDROPDOWNMENU_INIT_MENU.name
	if (unit) then
		if (not UnitInRaid(unit) and not UnitInParty(unit)) then
			if (UnitFullName("target") == unit) then
				unit = "target"
			elseif (UnitFullName("focus") == unit) then
				unit = "focus"
			end
		end

		local guid = UnitGUID(unit)
		if (guid) then
			Blizzard_CombatLog_UnitMenuClick("BOTH", UnitFullName(unit), guid)
		end
	end
end

-- UnitPopup_ShowMenu()
local function UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
	if (UIDROPDOWNMENU_MENU_LEVEL > 1) then
		return
	end

	local addCLOption
	if (which == "RAID_TARGET_ICON" or which == "TARGET") then
		--if (not DropDownList1Button1:IsShown()) then
		--	DropDownList1Button1:SetText(UIDROPDOWNMENU_INIT_MENU.name)
		--	DropDownList1Button1:Show()
		--	DropDownList1Button1:Disable()
		--end

		DropDownList1.numButtons = max(0, DropDownList1.numButtons - 1)

		--if (GetNumGroupMembers() > 0) then
		--	local info = UIDropDownMenu_CreateInfo()
		--	info.text = RAID_TARGET_ICON
		--	info.dist = 0
		--	info.value = "RAID_TARGET_ICON"
		--	info.hasArrow = 1
		--	info.notCheckable = 1
		--	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		--end
		
		addCLOption = true

	elseif (which == "RAID" or which == "PLAYER" or which == "PARTY" or which == "SELF" or which == "RAID_PLAYER") then
		DropDownList1.numButtons = max(0, DropDownList1.numButtons - 1)
		addCLOption = true
	end
	
	if (addCLOption) then
		local info = UIDropDownMenu_CreateInfo()
		info.text = "|cFF80FF80"..COMBAT_LOG
		info.dist = 0
		info.func = module.ShowCombatLog
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

		info = UIDropDownMenu_CreateInfo()
		info.text = CANCEL
		info.owner = which
		info.dist = 0
		info.func = UnitPopup_OnClick
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
	end
end

-- CombatLogMenus
function module:CombatLogMenus()
	hooksecurefunc("UnitPopup_ShowMenu", UnitPopup_ShowMenu)
	self.CombatLogMenus  = nil
end

-- Hold (Keybinding function)
function module:Hold(keystate)
	if (not db.dockToTooltip) then
		if (db.hide or self.cycleState) then
			local tip
			if (db.hide and keystate == "down") then
				db.hide = nil
				self.cycleState = 1
				if (UnitInParty("mouseover") or UnitInRaid("mouseover")) then
					self.lastUnit = "mouseover"
				elseif (not self.lastUnit) then
					self.lastUnit = "player"
				end
				module:Tip()
				tip = L["Select the player to view, then release the hold key"]
			
			elseif (self.cycleState == 1 and keystate == "up") then
				self.locked = true
				self:Tip()
				self.cycleState = 2
				tip = L["Press the Hold key once more to hide Grim Reaper"]

			elseif (self.cycleState == 2) then
				self.locked = nil
				db.hide = true
				if (self.attachment) then
					self.attachment:Hide()
				end
				if (module.extraInfoTip) then
					module.extraInfoTip:Hide()
				end
			end

			if (tip and self.attachment) then
				module:ShowLineTip(tip)
			end
		end
	end
end

do
	local function iter(t)
		local key = t.id
		local ret
		if (t.mode == "raid") then
			if (key > t.r) then
				del(t)
				return nil
			end
			ret = "raid"..key
		else
			if (key > t.p) then
				del(t)
				return nil
			end
			ret = key == 0 and "player" or "party"..key
		end
		t.id = key + 1
		return ret
	end

	-- IterateRoster
	function module:IterateRoster()
		local t = new()
		if (IsInRaid()) then
			t.mode = "raid"
			t.id = 1
			t.r = GetNumGroupMembers()
		else
			t.mode = "party"
			t.id = 0
			t.p = GetNumGroupMembers()
		end
		return iter, t
	end
end

-- SetupOptions
function module:SetupOptions()
	self.optionsFrames = {}
	-- setup options table
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("GrimReaper", self.options3)

	self.optionsFrames.GrimReaper = AceConfigDialog:AddToBlizOptions("GrimReaper", nil, nil, "General")
	self.optionsFrames.Display = AceConfigDialog:AddToBlizOptions("GrimReaper", L["Display"], "GrimReaper", "display")
	self:RegisterModuleOptions("Profile", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db), L["Profile"])
	self:RegisterChatCommand("grim", "OpenConfig")

	self.SetupOptions = nil
	self.RegisterModuleOptions = nil
end

-- RegisterModuleOptions
function module:RegisterModuleOptions(name, optionTbl, displayName)
	self.options3.args[name] = (type(optionTbl) == "function") and optionTbl() or optionTbl
	self.optionsFrames[name] = AceConfigDialog:AddToBlizOptions("GrimReaper", displayName, "GrimReaper", name)
	-- Add ordering data to the option table generated by AceDBOptions-3.0
	self.options3.args[name].order = -2
end

function module:OnProfileChanged()
	db = database.profile
	self.cycleState = nil
	self:Tip()
	self:DoIcon()
end

-- OnInitialize
function module:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GrimReaperDB", nil, "Default")
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")

	self.db:RegisterDefaults({
		profile = {
			dockToTooltip	= false,
			scale			= 0.6,
			lines			= 15,
			bars			= true,
			barsInside		= false,
			barsLeft		= true,
			enabled			= true,
			dockPoint		= "BOTTOMLEFT",
			healthList		= {},
			frameWidth		= 200,
			blizzardColours	= true,
			buffs			= true,
			debuffs			= true,
			channel			= "RAID",
			bartexture		= "BantoBar",
			buffTips		= false,
			debuffTips		= true,
			casts			= false,
			curesAndSteals	= true,
			showtime		= true,
			timeformat		= "%X",
			growDirection	= "auto",
		}
	})
	db = self.db.profile
	
	self:SetColours()

	hooksecurefunc(GameTooltip, "SetUnit",
		function(self, unit)
			if (module:IsEnabled()) then
				module:Tip(unit, self)
			end
		end)
		
	self:CombatLogMenus()

	self.OnInitialize = nil
end

local function errorhandler(err)
	return geterrorhandler()(err)
end


-- OnEnable
function module:OnEnable()
	self.bartexture = SM:Fetch("statusbar", db.bartexture)

	local events = {"GROUP_ROSTER_UPDATE", "UNIT_HEALTH", "COMBAT_LOG_EVENT_UNFILTERED"}
	for i,e in pairs(events) do
		self:RegisterEvent(e)
	end
	if (not self.combatLogStuffGot) then
		self:RegisterEvent("ADDON_LOADED")
	end

	self:MakeEventList()
	self:SetColours()
	self:MakeIconFlags()
	self:Tip()

	self:DoIcon()
	self:SetupOptions()
end

-- OnDisable
function module:OnDisable()
	self.eventString = nil
	self.iconFlags = nil
	self.bartexture = nil
	schoolColour = nil
	schoolColourHex = nil
end
