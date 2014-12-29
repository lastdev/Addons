local addonName = "Altoholic"
local addon = _G[addonName]

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local INFO_REALM_LINE = 0
local INFO_CHARACTER_LINE = 1
local INFO_TOTAL_LINE = 2

local WHITE		= "|cFFFFFFFF"
local GREEN		= "|cFF00FF00"
local YELLOW	= "|cFFFFFF00"
local GREY		= "|cFF808080"

-- http://wow.gamepedia.com/Quality
local RARITY_GREEN = "|cFF1EFF00"
local RARITY_BLUE = "|cFF0070DD"
local RARITY_PURPLE = "|cFFA335EE"
local RARITY_ORANGE = "|cFFFF8000"

local ICON_FACTION_HORDE = "Interface\\Icons\\INV_BannerPVP_01"
local ICON_FACTION_ALLIANCE = "Interface\\Icons\\INV_BannerPVP_02"
local CURRENCY_ID_CONQUEST = 390
local CURRENCY_ID_HONOR = 392
local CURRENCY_ID_JUSTICE = 395
local CURRENCY_ID_VALOR = 396
local CURRENCY_ID_APEXIS = 823
local CURRENCY_ID_GARRISON = 824
local CURRENCY_ID_SOTF = 994		-- Seals of Tempered Fate (WoD)

addon.GarrisonFollowers = {}

local ns = addon.GarrisonFollowers		-- ns = namespace
local Characters = addon.Characters

function ns:Update()
	local VisibleLines = 14
	local frame = "AltoholicFrameGarrisonFollowers"
	local entry = frame.."Entry"
	
	local DS = DataStore
	
	local offset = FauxScrollFrame_GetOffset( _G[ frame.."ScrollFrame" ] );
	local DisplayedCount = 0
	local VisibleCount = 0
	local DrawRealm
	local i=1
	
	for _, line in pairs(Characters:GetView()) do
		local lineType = Characters:GetLineType(line)
		
		if (offset > 0) or (DisplayedCount >= VisibleLines) then		-- if the line will not be visible
			if lineType == INFO_REALM_LINE then								-- then keep track of counters
				if Characters:GetField(line, "isCollapsed") == false then
					DrawRealm = true
				else
					DrawRealm = false
				end
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			elseif DrawRealm then
				VisibleCount = VisibleCount + 1
				offset = offset - 1		-- no further control, nevermind if it goes negative
			end
		else		-- line will be displayed
			if lineType == INFO_REALM_LINE then
				local _, realm, account = Characters:GetInfo(line)
				
				if Characters:GetField(line, "isCollapsed") == false then
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); 
					DrawRealm = true
				else
					_G[ entry..i.."Collapse" ]:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					DrawRealm = false
				end
				_G[entry..i.."Collapse"]:Show()
				_G[entry..i.."Name"]:SetWidth(300)
				_G[entry..i.."Name"]:SetPoint("TOPLEFT", 25, 0)
				_G[entry..i.."NameNormalText"]:SetWidth(300)
				if account == "Default" then	-- saved as default, display as localized.
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s|r)", realm, WHITE, GREEN, L["Default"]))
				else
					local last = addon:GetLastAccountSharingInfo(realm, account)
					_G[entry..i.."NameNormalText"]:SetText(format("%s (%s".. L["Account"]..": %s%s %s%s|r)", realm, WHITE, GREEN, account, YELLOW, last or ""))
				end				
				_G[entry..i.."Level"]:SetText("")
				
				_G[entry..i.."Stat1NormalText"]:SetText("")
				_G[entry..i.."Stat2NormalText"]:SetText("")
				_G[entry..i.."Stat3NormalText"]:SetText("")
				_G[entry..i.."Stat4NormalText"]:SetText("")
				_G[entry..i.."Stat5NormalText"]:SetText("")
				_G[entry..i.."Stat6NormalText"]:SetText("")
				_G[entry..i.."Stat7NormalText"]:SetText("")
				
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			elseif DrawRealm then
				if (lineType == INFO_CHARACTER_LINE) then
					local character = DS:GetCharacter( Characters:GetInfo(line) )
					
					local icon
					if DS:GetCharacterFaction(character) == "Alliance" then
						icon = addon:TextureToFontstring(ICON_FACTION_ALLIANCE, 18, 18) .. " "
					else
						icon = addon:TextureToFontstring(ICON_FACTION_HORDE, 18, 18) .. " "
					end
					
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(170)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 10, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(170)
					_G[entry..i.."NameNormalText"]:SetText(icon .. format("%s (%s)", DS:GetColoredCharacterName(character), DS:GetCharacterClass(character)))
					_G[entry..i.."Level"]:SetText(GREEN .. DS:GetCharacterLevel(character))
				
					local amount = DataStore:GetNumFollowers(character) or 0
					local color = (amount == 0) and GREY or WHITE
					_G[entry..i.."Stat1NormalText"]:SetText(format("%s%s", color, amount))
					
					amount = DataStore:GetNumFollowersAtLevel100(character) or 0
					color = (amount == 0) and GREY or WHITE
					_G[entry..i.."Stat2NormalText"]:SetText(format("%s%s", color, amount))

					amount = DataStore:GetNumRareFollowers(character) or 0
					color = (amount == 0) and GREY or RARITY_BLUE
					_G[entry..i.."Stat3NormalText"]:SetText(format("%s%s", color, amount))

					amount = DataStore:GetNumEpicFollowers(character) or 0
					color = (amount == 0) and GREY or RARITY_PURPLE
					_G[entry..i.."Stat4NormalText"]:SetText(format("%s%s", color, amount))

					amount = DataStore:GetNumFollowersAtiLevel615(character) or 0
					color = (amount == 0) and GREY or RARITY_GREEN
					_G[entry..i.."Stat5NormalText"]:SetText(format("%s%s", color, amount))

					amount = DataStore:GetNumFollowersAtiLevel630(character) or 0
					color = (amount == 0) and GREY or RARITY_BLUE
					_G[entry..i.."Stat6NormalText"]:SetText(format("%s%s", color, amount))

					amount = DataStore:GetNumFollowersAtiLevel645(character) or 0
					color = (amount == 0) and GREY or RARITY_PURPLE
					_G[entry..i.."Stat7NormalText"]:SetText(format("%s%s", color, amount))

				elseif (lineType == INFO_TOTAL_LINE) then
					_G[entry..i.."Collapse"]:Hide()
					_G[entry..i.."Name"]:SetWidth(200)
					_G[entry..i.."Name"]:SetPoint("TOPLEFT", 15, 0)
					_G[entry..i.."NameNormalText"]:SetWidth(200)
					_G[entry..i.."NameNormalText"]:SetText(L["Totals"])
					_G[entry..i.."Level"]:SetText(Characters:GetField(line, "level"))
					_G[entry..i.."Stat1NormalText"]:SetText("")
					_G[entry..i.."Stat2NormalText"]:SetText("")
					_G[entry..i.."Stat3NormalText"]:SetText("")
					_G[entry..i.."Stat4NormalText"]:SetText("")
					_G[entry..i.."Stat5NormalText"]:SetText("")
					_G[entry..i.."Stat6NormalText"]:SetText("")
					_G[entry..i.."Stat7NormalText"]:SetText("")
				end
				_G[ entry..i ]:SetID(line)
				_G[ entry..i ]:Show()
				i = i + 1
				VisibleCount = VisibleCount + 1
				DisplayedCount = DisplayedCount + 1
			end
		end
	end
	
	while i <= VisibleLines do
		_G[ entry..i ]:SetID(0)
		_G[ entry..i ]:Hide()
		i = i + 1
	end

	FauxScrollFrame_Update( _G[ frame.."ScrollFrame" ], VisibleCount, VisibleLines, 18);
end	
