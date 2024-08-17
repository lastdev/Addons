--fazer o scroll na vertical ter um thumb maior
--adicionar uma lupa no scroll do "zoom'
--implementar no details o nome do boss e o tempo de luta

--spells_cast_timeline is saving within the combatObject

do
	local Details = Details
	if (not Details) then
		print ("Details! Not Found.")
		return
	end

	local _
	local detailsFramework = _G.DetailsFramework

	local UnitGUID = _G.UnitGUID
	local GetTime = _G.GetTime
	local tremove = _G.tremove
	local tinsert = _G.tinsert
	local UnitBuff = _G.UnitBuff
	local UnitIsPlayer = _G.UnitIsPlayer
	local UnitInParty = _G.UnitInParty
	local UnitInRaid = _G.UnitInRaid
	local UnitIsUnit = _G.UnitIsUnit
	local abs = _G.abs
	local wipe = _G.wipe
	local unpack = _G.unpack

	local GetSpellInfo = Details.GetSpellInfo

	--minimal details version required to run this plugin
	local MINIMAL_DETAILS_VERSION_REQUIRED = 136
	local CASTLOG_VERSION = "v2.1.0"

	local CONST_COOLDOWN_TYPE_OFFENSIVE = 1
	local CONST_COOLDOWN_TYPE_DEFENSIVE_PERSONAL = 2
	local CONST_COOLDOWN_TYPE_DEFENSIVE_TARGET = 3
	local CONST_COOLDOWN_TYPE_DEFENSIVE_RAID = 4

	--create a plugin object
	local castLog = Details:NewPluginObject("Details_CastLog", _G.DETAILSPLUGIN_ALWAYSENABLED)
	--set the description
	castLog:SetPluginDescription("Show a time line of casts of players")

	--spells cache
	local spellCache = {}
	local auraCache = {}

	--when receiving an event from details, handle it here
	local onDetailsEvent = function(event, ...)
		if (event == "COMBAT_PLAYER_ENTER") then
			castLog.OnCombatStart(...)

		elseif (event == "COMBAT_PLAYER_LEAVE") then
			castLog.OnCombatEnd()

		elseif (event == "PLUGIN_DISABLED") then
			--plugin has been disabled at the details options panel

		elseif (event == "PLUGIN_ENABLED") then
			--plugin has been enabled at the details options panel

		elseif (event == "DETAILS_DATA_SEGMENTREMOVED") then
			--old segment got deleted by the segment limit

		elseif (event == "DETAILS_DATA_RESET") then
			--combat data got wiped

		end
	end

	function castLog.GetActorObjectFromGUID(combat, GUID)
		local damageActors = combat[1]._ActorTable
		for i = 1, #damageActors do
			local actor = damageActors[i]
			if (actor.serial == GUID) then
				return actor
			end
		end

		local healingActors = combat[2]._ActorTable
		for i = 1, #healingActors do
			local actor = healingActors[i]
			if (actor.serial == GUID) then
				return actor
			end
		end
	end

	function castLog.InstallTab()
		local tabName = "CastTimeline"
		local tabNameLoc = "Cast Log"

		local canShowTab = function(tabOBject, playerObject)
			local combat = Details:GetCombatFromBreakdownWindow()
			if (combat) then
				if (combat.spells_cast_timeline[playerObject.serial]) then
					return true
				end
			end
			return false
		end

		local fillTab = function(tab, playerObject, combat)
			function castLog.UpdateTimelineFrame()
				if (castLog.db.only_players_attack_cooldowns or castLog.db.only_players_defensive_cooldowns) then

					local combatTime = combat:GetCombatTime() --seconds elapsed
					local combatStartTime = combat:GetStartTime() --gettime

					local onlyShowAttackCDs = castLog.db.only_players_attack_cooldowns
					local onlyShowDefensiveCDs = castLog.db.only_players_defensive_cooldowns
					local castData = combat.spells_cast_timeline or {} --uses GUID has key

					local ignoredSpells = castLog.db.ignored_spells
					local ignoredSpellForAllClasses = ignoredSpells.ALL

					local playerData = {} --playerData[GUID] = {{time, 10, 0, 0 spellId}, {time, 10, 0, 0 spellId}, {time, 10, 0, 0 spellId}, {time, 10, 0, 0 spellId}}

					--iterate among all players and build a list of cooldown usage of offensive or defensive cooldowns
					for playerGUID, castTable in pairs(castData) do
						local actorObject = castLog.GetActorObjectFromGUID(combat, playerGUID)
						if (actorObject) then
							local playerClass = actorObject:Class()
							local ignoredSpellsForClass = ignoredSpells[playerClass]

							local thisPlayerData = {}
							playerData[playerGUID] = thisPlayerData

							--castTable is a indexed table with {time, spellId, target}
							for i = 1, #castTable do
								local castEvent = castTable[i]
								local atTime = castEvent[1]
								local spellId = castEvent[2]
								local payload = castEvent[3]

								--check if the spell isn't ignored
								if (not ignoredSpellsForClass[spellId] and not ignoredSpellForAllClasses[spellId]) then
									--get the cooldown type
									local cdType = LIB_OPEN_RAID_COOLDOWNS_INFO[spellId] and LIB_OPEN_RAID_COOLDOWNS_INFO[spellId].type
									if (cdType) then
										if (onlyShowAttackCDs and cdType == CONST_COOLDOWN_TYPE_OFFENSIVE) then
											thisPlayerData[#thisPlayerData+1] = {atTime - combatStartTime, 10, 0, 0, spellId, ["payload"] = payload} --has 5 indexes, the 5th is the spellId

										elseif (onlyShowDefensiveCDs and (cdType == CONST_COOLDOWN_TYPE_DEFENSIVE_PERSONAL or cdType == CONST_COOLDOWN_TYPE_DEFENSIVE_TARGET or cdType == CONST_COOLDOWN_TYPE_DEFENSIVE_RAID)) then
											thisPlayerData[#thisPlayerData+1] = {atTime - combatStartTime, 10, 0, 0, spellId, ["payload"] = payload} --has 5 indexes, the 5th is the spellId
										end
									end
								end
							end
						end
					end

					local scrollData = {
						length = combatTime,
						defaultColor = {1, 1, 1, 1},
						useIconOnBlocks = true,
						lines = {},
					}

					local resultTable = {}

					for playerGUID, playerCooldownUsage in pairs(playerData) do
						local actorObject = castLog.GetActorObjectFromGUID(combat, playerGUID)
						if (actorObject) then
							local useAlpha = false
							local specTexture, left, right, top, bottom = Details:GetSpecIcon(actorObject.spec, useAlpha)

							specTexture = specTexture or ""
							left = left or 0
							right = right or 1
							top = top or 0
							bottom = bottom or 1

							local playerNameNoRealm = actorObject:GetOnlyName() or "no player"

							local role = Details.specToRole[actorObject.spec] or "NONE"
							local roleId = 0

							if (castLog.db.only_players_attack_cooldowns) then
								roleId = role == "DAMAGER" and 1 or role == "HEALER" and 2 or role == "TANK" and 3 or "NONE" and 0

							elseif (castLog.db.only_players_defensive_cooldowns) then
								roleId = role == "DAMAGER" and 3 or role == "HEALER" and 2 or role == "TANK" and 1 or "NONE" and 0
							end

							roleId = roleId + (string.byte(playerNameNoRealm, 1) + (string.byte(playerNameNoRealm, 2)) / 4) / 1000

							--[1] icon [2] GUID [3] player name [4] cooldown usage [5] role
							resultTable[#resultTable+1] = {{specTexture, left, right, top, bottom}, playerGUID, playerNameNoRealm, playerCooldownUsage, role, roleId}
						end
					end

					table.sort(resultTable, function(t1, t2) return t1[6] < t2[6] end)

					for i, resultData in ipairs(resultTable) do
						--doing the sort thing and after add the tables inthe the scrollData
						--create the line information for this player
						local playerTable = {
							isPlayer = true,
							text = resultData[3],
							icon = resultData[1][1],
							coords = {resultData[1][2], resultData[1][3], resultData[1][4], resultData[1][5]},
							timeline = resultData[4],
						}

						--add a new line to the timeline frame
						tinsert(scrollData.lines, playerTable)
					end

					tab.frame.timeLineFrame:SetData(scrollData)
					local minValue = tab.frame.timeLineFrame.scaleSlider:GetMinMaxValues()
					tab.frame.timeLineFrame.scaleSlider:SetValue(minValue)

					local ignoreSpell = function(self)
						return Details:Msg("Can't ignore this unit.")
					end

					local allLines = tab.frame.timeLineFrame.lines
					for i = 1, #allLines do
						local lineHeader = allLines[i].lineHeader

						if (not lineHeader.ignoreButtton) then
							local ignoreButtton = detailsFramework:CreateButton(lineHeader, ignoreSpell, 20, 20, "X", _, _, _, _, _, _, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"), detailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE"))
							lineHeader.ignoreButtton = ignoreButtton
							ignoreButtton:SetPoint("right", lineHeader, "right", -2, 0)
							ignoreButtton:SetBackdropColor(.1, .1, .1, .7)
							ignoreButtton.onleave_backdrop = {.1, .1, .1, .7}
							ignoreButtton.onenter_backdrop = {.3, .3, .3, .7}
							ignoreButtton:SetBackdropBorderColor(0, 0, 0, 0)
							ignoreButtton.onenter_backdrop_border_color = {0, 0, 0, 0}
							ignoreButtton.onleave_backdrop_border_color = {0, 0, 0, 0}
						else
							lineHeader.ignoreButtton:SetClickFunction(ignoreSpell)
						end

						lineHeader.ignoreButtton:SetAlpha(0.2)
					end

				else
					--get the player cast data
					local castData = combat.spells_cast_timeline[playerObject and playerObject.serial]
					--if there at least one event?
					if (castData and castData[1]) then
						local spellData = {}

						local firstAbilityUsedTime = castData[1][1] --gettime
						local combatTime = combat:GetCombatTime() --seconds elapsed
						local combatStartTime = combat:GetStartTime() --gettime
						local combatEndTime = combat:GetEndTime() --gettime

						castLog.currentPlayerClass = playerObject.classe

						local auraData = combat.aura_timeline[playerObject and playerObject.serial]

						--if the button to show only auras are pressed
						local onlyShowAuras = castLog.db.only_auras
						local onlyShowCooldowns = castLog.db.only_cooldowns

						--cast data
						for i = 1, #castData do
							local cast = castData[i]
							local atTime = cast[1] --when it was casted
							local spellId = cast[2] --the spellId of the spell
							local payload = cast[3] --contains the spell target

							local hasCooldownType = LIB_OPEN_RAID_COOLDOWNS_INFO[spellId] and LIB_OPEN_RAID_COOLDOWNS_INFO[spellId].type

							if (not onlyShowCooldowns or hasCooldownType) then
								local auraTimers = auraData[spellId]
								if (auraTimers) then
									auraTimers = auraTimers.data
									local foundAuraTimer = false

									for o = 1, #auraTimers do
										local auraTimer = auraTimers[o]

										if (detailsFramework:IsNearlyEqual(auraTimer[1], atTime, 0.650)) then --when it was applyed, using 650ms as latency compensation
											foundAuraTimer = true

											local auraActivationData = auraTimer
											local applied = auraActivationData[1]
											local wentOff = auraActivationData[2]
											local duration = wentOff - applied

											spellData[spellId] = spellData[spellId] or {}
											tinsert(spellData[spellId], {applied - combatStartTime, 10, duration, duration, ["payload"] = payload}) --has 4 indexes
											break
										end
									end

									--if this event does not have a duration (if the event has a duration, it has an aura applied)
									if (not foundAuraTimer) then
										--if not showing only auras this event can be shown
										if (not onlyShowAuras) then
											spellData[spellId] = spellData[spellId] or {}
											tinsert(spellData[spellId], {atTime - combatStartTime, 1, ["payload"] = payload}) --has 2 indexes
										end
									end
								else
									if (not onlyShowAuras) then
										spellData[spellId] = spellData[spellId] or {}
										tinsert(spellData[spellId], {atTime - combatStartTime, 1, ["payload"] = payload}) --has 2 indexes
									end
								end
							end
						end

						local scrollData = {
							length = combatTime,
							defaultColor = {1, 1, 1, 1},
							useIconOnBlocks = true,
							lines = {},
						}

						do
							local ignoredSpells = castLog.db.ignored_spells
							local playerClass = castLog.currentPlayerClass
							local ignoredSpellsForClass = ignoredSpells[playerClass]
							local ignoredSpellForAllClasses = ignoredSpells.ALL

							for spellId, spellTimers in pairs(spellData) do
								--check if the spell isn't ignored
								if (not ignoredSpellsForClass[spellId] and not ignoredSpellForAllClasses[spellId]) then
									local spellName, rank, spellIcon = GetSpellInfo(spellId)

									local spellTable = {
										text = spellName,
										icon = spellIcon,
										spellId = spellId,
										timeline = spellTimers, --each table inside has the .payload
									}
									tinsert(scrollData.lines, spellTable)
								end
							end
						end

						tab.frame.timeLineFrame:SetData(scrollData)
						local minValue = tab.frame.timeLineFrame.scaleSlider:GetMinMaxValues()
						tab.frame.timeLineFrame.scaleSlider:SetValue(minValue)

						local ignoreSpell = function(self)
							local spellId = self:GetParent():GetParent().spellId
							if (spellId) then
								local ignoredSpells = castLog.db.ignored_spells
								local classTable = ignoredSpells[castLog.currentPlayerClass]

								if (classTable) then
									classTable[spellId] = true
									tab.frame.OpenOptions(1, true)
									castLog.UpdateTimelineFrame()
								else
									detailsFramework:Msg("this actor does not have a class.")
								end
							else
								detailsFramework:Msg("spellId not found for this button.")
							end
						end

						local allLines = tab.frame.timeLineFrame.lines
						for i = 1, #allLines do
							local lineHeader = allLines[i].lineHeader

							if (not lineHeader.ignoreButtton) then
								local ignoreButtton = detailsFramework:CreateButton(lineHeader, ignoreSpell, 20, 20, "X", _, _, _, _, _, _, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"), detailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE"))
								lineHeader.ignoreButtton = ignoreButtton
								ignoreButtton:SetPoint("right", lineHeader, "right", -2, 0)
								ignoreButtton:SetBackdropColor(.1, .1, .1, .7)
								ignoreButtton.onleave_backdrop = {.1, .1, .1, .7}
								ignoreButtton.onenter_backdrop = {.3, .3, .3, .7}
								ignoreButtton:SetBackdropBorderColor(0, 0, 0, 0)
								ignoreButtton.onenter_backdrop_border_color = {0, 0, 0, 0}
								ignoreButtton.onleave_backdrop_border_color = {0, 0, 0, 0}
							else
								lineHeader.ignoreButtton:SetClickFunction(ignoreSpell)
							end

							lineHeader.ignoreButtton:SetAlpha(1)
						end
					else
						--this player has no timeline data to show
						--clear the timeline frame, or unselect it and show the overall spells breakdown
						print("there's no data for player", playerObject and playerObject.nome)
					end
				end

				castLog.UpdateShowButtons()
			end

			castLog.UpdateTimelineFrame()
		end

		local onCreatedTab = function(tab, frame)
			frame:SetBackdrop(nil)
			local gameCooltip = _G.GameCooltip

			local timeLineFrame = detailsFramework:CreateTimeLineFrame(frame, "$parentTimeLine", { --general options
				width = 900, height = 465,

				backdrop_color = {1, 1, 1, .1}, --line backdrop
				backdrop_color_highlight = {1, 1, 1, .3},

				slider_backdrop_color = {.2, .2, .2, 0.3},
				slider_backdrop_border_color = {0.2, 0.2, 0.2, .3},

				on_enter = function(self)
					self:SetBackdropColor(unpack(self.backdrop_color_highlight))
				end,

				on_leave = function(self)
					if (self.dataIndex % 2 == 1) then
						self:SetBackdropColor(1, 1, 1, 0)
					else
						self:SetBackdropColor(1, 1, 1, .1)
					end
				end,

				header_on_enter = function(lineHeader)
					local line = lineHeader:GetParent()
					local spellId = line.spellId
					if (spellId) then
						GameTooltip:SetOwner(lineHeader, "ANCHOR_TOPLEFT")
						GameTooltip:SetSpellByID(spellId)
						GameTooltip:Show()
						lineHeader:SetBackdropColor(unpack(line.backdrop_color_highlight))
					end
				end,

				header_on_leave = function(lineHeader)
					GameTooltip:Hide()
					local line = lineHeader:GetParent()
					if (line.dataIndex % 2 == 1) then
						line:SetBackdropColor(1, 1, 1, 0)
						lineHeader:SetBackdropColor(1, 1, 1, 0)
					else
						line:SetBackdropColor(1, 1, 1, .1)
						lineHeader:SetBackdropColor(1, 1, 1, .1)
					end
				end,

				--on entering a spell icon
				block_on_enter = function(self)
					local info = self.info
					local spellName, rank, spellIcon = GetSpellInfo(info.spellId)
					local castAtTime = info.time < -0.2 and "-" .. detailsFramework:IntegerToTimer(abs(info.time)) or detailsFramework:IntegerToTimer(abs(info.time))
					gameCooltip:Reset()
					gameCooltip:SetOwner(self)
					gameCooltip:SetOption("TextSize", 10)
					gameCooltip:AddLine(spellName, castAtTime)
					gameCooltip:AddIcon(spellIcon, 1, 1, 16, 16, .1, .9, .1, .9)

					if (info.duration) then
						gameCooltip:AddLine("Duration:", detailsFramework:IntegerToTimer(info.duration))
					end
					if (info.payload and type(info.payload) == "string" and info.payload ~= "") then
						gameCooltip:AddLine("Target:", info.payload)
					end

					--gameCooltip:AddLine("SpellId:", info.spellId)
					gameCooltip:Show()

					self.icon:SetBlendMode("ADD")
				end,

				block_on_leave = function(self)
					gameCooltip:Hide()
					self.icon:SetBlendMode("BLEND")
				end,
			},

			{ --timeline frame options
				draw_line_color = {1, 1, 1, 0.03},
			})

			local verticalSliderText = timeLineFrame.verticalSlider:CreateFontString(nil, "artwork", "GameFontNormal")
				verticalSliderText:SetPoint("center", timeLineFrame.verticalSlider, "center", 7, 0)
				verticalSliderText:SetText("shift + scroll")
				detailsFramework:SetFontColor(verticalSliderText, "gray")
				verticalSliderText:SetAlpha(0.5)

				local makeVerticalAnimHub = detailsFramework:CreateAnimationHub(verticalSliderText)
				local rotationAnimation = detailsFramework:CreateAnimation(makeVerticalAnimHub, "rotation", 1, 0, 270)
				rotationAnimation:SetEndDelay(99999999)
				rotationAnimation:SetSmoothProgress(1)
				makeVerticalAnimHub:Play()
				makeVerticalAnimHub:Pause()

			local horizontalSliderText = timeLineFrame.horizontalSlider:CreateFontString(nil, "artwork", "GameFontNormal")
				horizontalSliderText:SetPoint("center", timeLineFrame.horizontalSlider, "center", 0, 0)
				horizontalSliderText:SetText("scroll")
				detailsFramework:SetFontColor(horizontalSliderText, "gray")
				horizontalSliderText:SetAlpha(0.5)

			local scaleSliderText = timeLineFrame.scaleSlider:CreateFontString(nil, "artwork", "GameFontNormal")
				scaleSliderText:SetPoint("center", timeLineFrame.scaleSlider, "center", 0, 0)
				scaleSliderText:SetText("ctrl + scroll")
				detailsFramework:SetFontColor(scaleSliderText, "gray")
				scaleSliderText:SetAlpha(0.5)

			local scrollText = detailsFramework:CreateLabel(timeLineFrame.horizontalSlider, "scroll", 10, {.5, .5, .5, .5})
				scrollText:SetPoint("right", timeLineFrame.horizontalSlider, "right", -2, 0)

			local zoomText = detailsFramework:CreateLabel(timeLineFrame.scaleSlider, "zoom", 10, {.5, .5, .5, .5})
				zoomText:SetPoint("right", timeLineFrame.scaleSlider, "right", -2, 0)

			timeLineFrame:SetPoint("topleft", frame, "topleft", 0, 0)
			frame.timeLineFrame = timeLineFrame

			timeLineFrame.__background:SetAlpha(.8)

			function castLog.UpdateShowButtons()
				--the timeline is refreshed at creation and these buttons does not exists at that point
				if (not frame.showOnlyCooldownsButton) then
					return
				end

				--reset
				frame.showOnlyCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				frame.showOnlyAurasButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				frame.showPlayersAttackCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				frame.showPlayersDefenseCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")

				if (castLog.db.only_cooldowns) then
					frame.showOnlyCooldownsButton:SetTemplate("DETAILS_TAB_BUTTONSELECTED_TEMPLATE")

				elseif (castLog.db.only_auras) then
					frame.showOnlyAurasButton:SetTemplate("DETAILS_TAB_BUTTONSELECTED_TEMPLATE")

				elseif (castLog.db.only_players_attack_cooldowns) then
					frame.showPlayersAttackCooldownsButton:SetTemplate("DETAILS_TAB_BUTTONSELECTED_TEMPLATE")

				elseif (castLog.db.only_players_defensive_cooldowns) then
					frame.showPlayersDefenseCooldownsButton:SetTemplate("DETAILS_TAB_BUTTONSELECTED_TEMPLATE")
				end

				local width = 120
				local height = 20
				frame.showOnlyCooldownsButton:SetSize(width, height)
				frame.showOnlyAurasButton:SetSize(width, height)
				frame.showPlayersAttackCooldownsButton:SetSize(width + 40, height)
				frame.showPlayersDefenseCooldownsButton:SetSize(width + 40, height)
			end

			--reset zoom button

			--ignored spells button
			local openOptions = function(sectionId, mustShow)
				if (not frame.optionsFrame) then
					local breakdownWindow = Details:GetBreakdownWindow()

					local optionsFrame = CreateFrame("frame", "$parentOptionsFrame", breakdownWindow, "BackdropTemplate")
					optionsFrame:SetWidth(200)
					optionsFrame:SetPoint("topleft", breakdownWindow, "topright", 0, 0)
					optionsFrame:SetPoint("bottomleft", breakdownWindow, "bottomright", 0, 0)
					frame.optionsFrame = optionsFrame

					--> create ignored spell frame
						local ignoredSpellFrame = CreateFrame("frame", "$parentIgnoredSpellsFrame", optionsFrame, "BackdropTemplate")
						ignoredSpellFrame:SetAllPoints()
						ignoredSpellFrame:Hide()
						optionsFrame.ignoredSpellFrame = ignoredSpellFrame

						--label in the bottom of the window saying 'ignored spells'
						local ignoredSpellLabel = detailsFramework:CreateLabel(ignoredSpellFrame, "ignored spells", 11, "white")
						ignoredSpellLabel:SetPoint("bottom-bottom", 0, 5)

						local refreshSpellsIgnoredScroll = function(self, data, offset, totalLines)
							local listOfIgnoredSpells = {}

							--get all spells for all classes and show in the panel
							local ignoredSpells = castLog.db.ignored_spells
							local playerClass = castLog.currentPlayerClass
							local ignoredSpellsForClass = ignoredSpells[playerClass]

							if (ignoredSpellsForClass) then
								for spellId in pairs(ignoredSpellsForClass) do
									listOfIgnoredSpells[#listOfIgnoredSpells+1] = spellId
								end

								for className, ignoredSpellsOfClass in pairs(ignoredSpells) do
									if (className ~= playerClass and className ~= "ALL") then
										for spellId in pairs(ignoredSpellsOfClass) do
											listOfIgnoredSpells[#listOfIgnoredSpells+1] = spellId
										end
									end
								end
							else
								for className, ignoredSpells in pairs(ignoredSpells) do
									if  (className ~= "ALL") then
										for spellId in pairs(ignoredSpells) do
											listOfIgnoredSpells[#listOfIgnoredSpells+1] = spellId
										end
									end
								end
							end

							local spellList = {}
							for index = 1, #listOfIgnoredSpells do
								local spellId = listOfIgnoredSpells[index]
								local spellName, rank, spellIcon = GetSpellInfo(spellId)
								if (spellName) then
									spellList[#spellList+1] = {spellName, spellIcon, spellId}
								end
							end

							for i = 1, totalLines do
								local index = i + offset
								local thisData = spellList[index]
								if (thisData) then
									local line = self:GetLine(i)
									local spellName, spellIcon, spellId = thisData[1], thisData[2], thisData[3]
									line.spellName:SetText(spellName)
									line.spellIcon:SetTexture(spellIcon)
									line.spellIcon:SetTexCoord(.1, .9, .1, .9)
									line.spellIdLabel:SetText(spellId)
									line.spellId = spellId
								end
							end
						end

						local spellsSelectionAmoutLines = 27
						local spellsSelectionLinesHeight = 20
						local scrollbox_line_backdrop_color = {0, 0, 0, 0.5}
						local scrollbox_line_backdrop_color_hightlight = {.4, .4, .4, 0.6}
						local scrollbox_line_backdrop_color_selected = {.7, .7, .7, 0.8}

						local spellsIgnoredScroll = detailsFramework:CreateScrollBox(ignoredSpellFrame, "$parentScroll", refreshSpellsIgnoredScroll, {}, ignoredSpellFrame:GetWidth() - 2, ignoredSpellFrame:GetHeight(), spellsSelectionAmoutLines, spellsSelectionLinesHeight)
						ignoredSpellFrame.spellsIgnoredScroll = spellsIgnoredScroll
						detailsFramework:ReskinSlider(spellsIgnoredScroll)
						spellsIgnoredScroll:SetPoint("topleft", ignoredSpellFrame, "topleft", 0, 0)
						spellsIgnoredScroll:SetPoint("bottomright", ignoredSpellFrame, "bottomright", -22, 0)

						local onEnterLine = function(self)
							self:SetBackdropColor(unpack(scrollbox_line_backdrop_color_hightlight))
						end

						local onLeaveLine = function(self)
							self:SetBackdropColor(unpack(scrollbox_line_backdrop_color))
						end

						local removeIgnoredSpell = function(self)
							local parent = self:GetParent()
							local spellId = parent.spellId

							if (not spellId) then
								return
							end

							local ignoredSpells = castLog.db.ignored_spells
							local classTable = ignoredSpells[castLog.currentPlayerClass]
							if (classTable) then
								classTable[spellId] = nil
								spellsIgnoredScroll:Refresh()
								castLog.UpdateTimelineFrame()
							else
								detailsFramework:Msg("this actor does not have a class.")
							end
						end

						--create scroll lines
						local createIgnoredSpellLine = function(self, index)
							local line = CreateFrame("button", "$parentLine" .. index, self, "BackdropTemplate")
							line:SetPoint("topleft", self, "topleft", 0, -((index - 1) * (spellsSelectionLinesHeight + 1)) - 1)
							line:SetSize(self:GetWidth(), spellsSelectionLinesHeight)

							line:RegisterForClicks("LeftButtonDown", "RightButtonDown")
							detailsFramework:ApplyStandardBackdrop(line)

							line:SetScript("OnEnter", onEnterLine)
							line:SetScript("OnLeave", onLeaveLine)

							line.index = index

							--spell icon
							local spellIcon = line:CreateTexture("$parentIcon", "overlay")
							spellIcon:SetSize(spellsSelectionLinesHeight-2, spellsSelectionLinesHeight-2)
							spellIcon:SetPoint("left", line, "left", 2, 0)
							line.spellIcon = spellIcon

							local spellName = line:CreateFontString(nil, "overlay", "GameFontNormal")
							spellName:SetPoint("left", spellIcon, "right", 3, 0)
							detailsFramework:SetFontSize(spellName, 10)

							local removeButton = detailsFramework:CreateButton(line, removeIgnoredSpell, 20, 20, "X", _, _, _, _, _, _, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"), detailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE"))
							removeButton:SetPoint("right", line, "right", -2, 0)

							local spellIdLabel = line:CreateFontString(nil, "overlay", "GameFontNormal")
							spellIdLabel:SetPoint("right", removeButton.widget, "left", -2, 0)
							detailsFramework:SetFontSize(spellIdLabel, 6)
							detailsFramework:SetFontColor(spellIdLabel, "gray")
							spellIdLabel:SetAlpha(.6)

							line.spellIcon = spellIcon
							line.spellName = spellName
							line.removeButton = removeButton
							line.spellIdLabel = spellIdLabel

							return line
						end

						--create the scrollbox lines
						for i = 1, spellsSelectionAmoutLines do
							spellsIgnoredScroll:CreateLine(createIgnoredSpellLine, i)
						end


					--> create merged spell frame
						local mergedSpellFrame = CreateFrame("frame", "$parentMergedSpellsFrame", optionsFrame, "BackdropTemplate")
						mergedSpellFrame:SetAllPoints()
						mergedSpellFrame:Hide()
						optionsFrame.mergedSpellFrame = mergedSpellFrame

						local refreshSpellsMergedScroll = function(self, data, offset, totalLines)
							local mergedSpells = castLog.db.merged_spells
							local classTable = mergedSpells[castLog.currentPlayerClass]
							if (not classTable) then
								return
							end

							local spellList = {}
							for spellId in pairs(classTable) do
								local spellName, rank, spellIcon = GetSpellInfo(spellId)
								if (spellName) then
									spellList[#spellList+1] = {spellName, spellIcon, spellId}
								end
							end

							table.sort(spellList, Details.Sort1)

							for i = 1, totalLines do
								local index = i + offset
								local thisData = spellList[index]
								if (thisData) then
									local line = self:GetLine(i)
									local spellName, spellIcon, spellId = thisData[1], thisData[2], thisData[3]
									line.spellName:SetText(spellName)
									line.spellIcon:SetTexture(spellIcon)
									line.spellIcon:SetTexCoord(.1, .9, .1, .9)
									line.spellId = spellId
								end
							end
						end

						local spellsMergedScroll = detailsFramework:CreateScrollBox(mergedSpellFrame, "$parentScroll", refreshSpellsMergedScroll, {}, mergedSpellFrame:GetWidth() - 2, mergedSpellFrame:GetHeight(), spellsSelectionAmoutLines, spellsSelectionLinesHeight)
						spellsMergedScroll.spellsMergedScroll = spellsMergedScroll
						detailsFramework:ReskinSlider(spellsMergedScroll)
						spellsMergedScroll:SetAllPoints()
						spellsMergedScroll:SetPoint("topleft", frame, "topleft", 0, -40)
						spellsMergedScroll:SetPoint("bottomright", frame, "bottomright", -22, 0)

						local onEnterLineMerged = function(self)
							self:SetBackdropColor(unpack(scrollbox_line_backdrop_color_hightlight))
						end

						local onLeaveLineMerged = function(self)
							self:SetBackdropColor(unpack(scrollbox_line_backdrop_color))
						end

						local removeMergedSpell = function(self)
							local spellId = self.spellId
							local meergedSpells = castLog.db.merged_spells

							local classTable = meergedSpells[castLog.currentPlayerClass]
							if (classTable) then
								classTable[spellId] = nil
								spellsMergedScroll:Refresh()
							else
								detailsFramework:Msg("this actor does not have a class.")
							end
						end

						--create scroll lines
						local createSpellMergedLine = function(self, index)
							local line = CreateFrame("button", "$parentLine" .. index, self, "BackdropTemplate")
							line:SetPoint("topleft", self, "topleft", 0, -((index - 1) * (spellsSelectionLinesHeight + 1)) - 1)
							line:SetSize(self:GetWidth(), spellsSelectionLinesHeight)

							line:RegisterForClicks("LeftButtonDown", "RightButtonDown")
							detailsFramework:ApplyStandardBackdrop(line)

							line:SetScript("OnEnter", onEnterLineMerged)
							line:SetScript("OnLeave", onLeaveLineMerged)

							line.index = index

							--spell icon
							local spellIcon = line:CreateTexture("$parentIcon", "overlay")
							spellIcon:SetSize(spellsSelectionLinesHeight, spellsSelectionLinesHeight)
							line.spellIcon = spellIcon

							local spellName = line:CreateFontString(nil, "overlay", "GameFontNormal")
							spellName:SetPoint("left", spellIcon, "right", 3, 0)
							detailsFramework:SetFontSize(spellName, 11)

							local removeButton = detailsFramework:CreateButton(line, removeMergedSpell, 20, 20, "X", _, _, _, _, _, _, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"), detailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE"))
							removeButton:SetPoint("right", self, "right", -2, 0)

							line.spellIcon = spellIcon
							line.spellName = spellName
							line.removeButton = removeButton

							return line
						end

						--create the scrollbox lines
						for i = 1, spellsSelectionAmoutLines do
							spellsMergedScroll:CreateLine(createSpellMergedLine, i)
						end
				end

				if (mustShow) then
					if (sectionId == 1) then
						frame.optionsFrame.ignoredSpellFrame:Show()
						frame.optionsFrame.mergedSpellFrame:Hide()
						frame.optionsFrame.ignoredSpellFrame.spellsIgnoredScroll:Refresh()

					elseif (sectionId == 2) then
						frame.optionsFrame.mergedSpellFrame:Show()
						frame.optionsFrame.ignoredSpellFrame:Hide()
					end

					return
				end

				if (frame.optionsFrame.ignoredSpellFrame:IsShown()) then
					if (sectionId == 1) then
						frame.optionsFrame.ignoredSpellFrame:Hide()
						frame.optionsFrame.mergedSpellFrame:Hide()
						return
					end
				end

				if (frame.optionsFrame.mergedSpellFrame:IsShown()) then
					if (sectionId == 2) then
						frame.optionsFrame.ignoredSpellFrame:Hide()
						frame.optionsFrame.mergedSpellFrame:Hide()
						return
					end
				end

				frame.optionsFrame.ignoredSpellFrame:Hide()
				frame.optionsFrame.mergedSpellFrame:Hide()

				if (sectionId == 1) then
					frame.optionsFrame.ignoredSpellFrame:Show()
					frame.optionsFrame.ignoredSpellFrame.spellsIgnoredScroll:Refresh()

				elseif (sectionId == 2) then
					frame.optionsFrame.mergedSpellFrame:Show()

				end

				castLog.UpdateShowButtons()
			end

			frame.OpenOptions = openOptions

			local ignoredSpellsButton = detailsFramework:CreateButton(frame, function() openOptions(1) end, 120, 20, "Ignored Spells", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
				ignoredSpellsButton:SetPoint("bottomleft", frame, "bottomleft", 0, 0)
				ignoredSpellsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				ignoredSpellsButton:SetIcon([[Interface\GLUES\LOGIN\Glues-CheckBox-Check]])
				ignoredSpellsButton:SetSize(120, 18)

			local mergedSpellsButton = detailsFramework:CreateButton(frame, function() openOptions(2) end, 90, 20, "Merge Spells", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
				mergedSpellsButton:SetPoint("left", ignoredSpellsButton, "right", 5, 0)
				mergedSpellsButton:Hide()

			--show only cooldowns
			local showOnlyCooldownsButton_Func = function()
				castLog.db.only_auras = false
				castLog.db.only_cooldowns = not castLog.db.only_cooldowns
				castLog.db.only_players_attack_cooldowns = false
				castLog.db.only_players_defensive_cooldowns = false
				castLog.UpdateTimelineFrame()
			end
			local showOnlyCooldownsButton = detailsFramework:CreateButton(frame, showOnlyCooldownsButton_Func, 120, 20, "Only Cooldowns", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
				showOnlyCooldownsButton:SetPoint("left", ignoredSpellsButton, "right", 2, 0)
				showOnlyCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				showOnlyCooldownsButton:SetIcon([[Interface\AddOns\Details\images\spec_icons_normal_alpha]], nil, nil, nil, {256/512, 320/512, 128/512, 192/512})
				frame.showOnlyCooldownsButton = showOnlyCooldownsButton

			--show only auras
			local showOnlyAurasButton_Func = function()
				castLog.db.only_auras = not castLog.db.only_auras
				castLog.db.only_cooldowns = false
				castLog.db.only_players_attack_cooldowns = false
				castLog.db.only_players_defensive_cooldowns = false
				castLog.UpdateTimelineFrame()
			end
			local showOnlyAurasButton = detailsFramework:CreateButton(frame, showOnlyAurasButton_Func, 120, 20, "Only Auras", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
				showOnlyAurasButton:SetPoint("left", showOnlyCooldownsButton, "right", 2, 0)
				showOnlyAurasButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				showOnlyAurasButton:SetIcon([[Interface\AddOns\Details\images\spec_icons_normal_alpha]], nil, nil, nil, {320/512, 384/512, 128/512, 192/512})
				frame.showOnlyAurasButton = showOnlyAurasButton

			--players attack cooldowns usage
			local showPlayersAttackCooldownsButton_Func = function()
				castLog.db.only_auras = false
				castLog.db.only_cooldowns = false
				castLog.db.only_players_attack_cooldowns = not castLog.db.only_players_attack_cooldowns
				castLog.db.only_players_defensive_cooldowns = false
				castLog.UpdateTimelineFrame()
			end
			local showPlayersAttackCooldownsButton = detailsFramework:CreateButton(frame, showPlayersAttackCooldownsButton_Func, 120, 20, "Raid Attack Cooldowns", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
				showPlayersAttackCooldownsButton:SetPoint("left", showOnlyAurasButton, "right", 2, 0)
				showPlayersAttackCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
				showPlayersAttackCooldownsButton:SetIcon([[Interface\AddOns\Details\images\spec_icons_normal_alpha]], nil, nil, nil, {256/512, 320/512, 256/512, 320/512})
				frame.showPlayersAttackCooldownsButton = showPlayersAttackCooldownsButton

			--players defensive cooldowns usage
			local showPlayersDefensiveCooldownsButton_Func = function()
				castLog.db.only_auras = false
				castLog.db.only_cooldowns = false
				castLog.db.only_players_attack_cooldowns = false
				castLog.db.only_players_defensive_cooldowns = not castLog.db.only_players_defensive_cooldowns
				castLog.UpdateTimelineFrame()
			end
			local showPlayersDefenseCooldownsButton = detailsFramework:CreateButton(frame, showPlayersDefensiveCooldownsButton_Func, 120, 20, "Raid Defensive Cooldowns", nil, nil, nil, nil, nil, nil, detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE"))
			showPlayersDefenseCooldownsButton:SetPoint("left", showPlayersAttackCooldownsButton, "right", 2, 0)
			showPlayersDefenseCooldownsButton:SetTemplate("DETAILS_TAB_BUTTON_TEMPLATE")
			showPlayersDefenseCooldownsButton:SetIcon([[Interface\AddOns\Details\images\spec_icons_normal_alpha]], nil, nil, nil, {64/512, 128/512, 256/512, 320/512})
			frame.showPlayersDefenseCooldownsButton = showPlayersDefenseCooldownsButton
		end

		local iconSettings = {
			texture = [[Interface\BUTTONS\UI-GuildButton-OfficerNote-Disabled]],
			coords = {0, 1, 0, 1},
			width = 16,
			height = 16,
		}

		Details:CreatePlayerDetailsTab(tabName, tabNameLoc, canShowTab, fillTab, nil, onCreatedTab, iconSettings)
	end

	--runs on each member in the group
	function castLog.BuildPlayerList(unitId, combatObject)
		local GUID = UnitGUID(unitId)
		combatObject.spells_cast_timeline[GUID] = {}
		combatObject.aura_timeline[GUID] = {}
	end

	--runs on each member in the group
	--these are stored spells when out of combat to show pre-casts before a pull
	function castLog.CacheTransfer(unitId, combatObject, spellCache, auraCache)
		local GUID = UnitGUID(unitId)
		local cachedCastTable = spellCache[GUID]
		local combatCastTable = combatObject.spells_cast_timeline[GUID]

		if (cachedCastTable and combatCastTable) then
			local cutOffTime = GetTime() - 5
			for i = #cachedCastTable, 1, -1 do
				if (cachedCastTable [i][1] < cutOffTime) then
					tremove(cachedCastTable, i)
				end
			end

			for i = 1, #cachedCastTable do
				tinsert(combatCastTable, cachedCastTable[i])
			end

			table.wipe(cachedCastTable)
		end

		--

		local cachedAuraTable = auraCache[GUID]
		local combatAuraTable = combatObject.aura_timeline[GUID]

		if (cachedAuraTable and combatAuraTable) then
			for spellId, appliedAt in pairs(cachedAuraTable) do
				--check if the aura is still up
				local auraUp
				for i = 1, 40 do
					local name, texture, count, debuffType, duration, expirationTime, caster, canStealOrPurge, nameplateShowPersonal, auraSpellId = UnitBuff(unitId, i)
					if (not name) then
						break
					elseif (spellId == auraSpellId) then
						auraUp = true
						break
					end
				end

				if (auraUp) then
					combatAuraTable[spellId] = {
						enabled = true,
						appliedAt = appliedAt,
						data = {},
						spellId = spellId,
						auraType = "BUFF",
					}
				end
			end

			table.wipe(cachedAuraTable)
		end
	end

	function castLog.OnCombatStart(combatObject)
		--start
		castLog.inCombat = true
		castLog.currentCombat =  combatObject
		--built the table
		detailsFramework:GroupIterator(castLog.BuildPlayerList, combatObject)
		--precasts
		detailsFramework:GroupIterator(castLog.CacheTransfer, combatObject, spellCache, auraCache)
		--wipe sent cache
		wipe(castLog.sentSpellCache)

		castLog.UpdateSpellCache()
		castLog.combatLogReader:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

		castLog.UpdateSpellCache()
	end

	function castLog.OnCombatEnd()
		--finish
		castLog.inCombat = false

		--close aura timers
		if (castLog.currentCombat) then
			castLog.currentCombat.aura_timeline = castLog.currentCombat.aura_timeline or {}
			for GUID, playerAuraTable in pairs(castLog.currentCombat.aura_timeline) do
				for spellId, auraTable in pairs(playerAuraTable) do
					if (auraTable.enabled) then
						auraTable.enabled = false
						auraTable.amountUp = 0
						tinsert(auraTable.data, {auraTable.appliedAt, GetTime()}) --when it was applied and when it went off
					end
				end
			end
		end

		wipe(castLog.sentSpellCache)
		castLog.combatLogReader:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		castLog.UpdateSpellCache()
	end

	local isUnitInTheGroup = function(unitId)
		if (unitId) then
			if (UnitInRaid(unitId)) then
				return true

			elseif (UnitInParty(unitId)) then
				return true

			elseif (UnitIsUnit(unitId, "player")) then
				return true
			end
		end
	end

	function castLog:OnEvent(self, event, ...)
		if (event == "ADDON_LOADED") then
			local addonName = select(1, ...)
			if (addonName == "Details_CastLog") then

				--every plugin must have a OnDetailsEvent function
				function castLog:OnDetailsEvent(event, ...)
					return onDetailsEvent(event, ...)
				end

				local default_options = {
					ignored_spells = {
						["DEMONHUNTER"] = {
						},
						["HUNTER"] = {
						},
						["WARRIOR"] = {
						},
						["ROGUE"] = {
						},
						["MAGE"] = {
						},
						["DRUID"] = {
						},
						["MONK"] = {
						},
						["DEATHKNIGHT"] = {
						},
						["PRIEST"] = {
						},
						["WARLOCK"] = {
						},
						["PALADIN"] = {
						},
						["SHAMAN"] = {
						},
						["EVOKER"] = {
						},
						["ALL"] = {
							[324748] = true, --celestial guidance (enchant)
							[196711] = true, --remorseless winter
							[75] = true, --auto shot
							[201428] = true, --annihilation
							[227518] = true, --annihilation
							[272790] = true, --Frenzy
							[228597] = true, --frostbolt
							[147193] = true, --shadowy apparition
							[341263] = true, --shadowy apparition
						},
					},

					merged_spells = {
						["DEMONHUNTER"] = {
							[222031] = 199547, --chaos strike
							[201453] = 191427, --metamorphosis
							[213243] = 213241, --felblade
							[232893] = 213241, --felblade
						},
						["HUNTER"] = {
							[308495] = 308491, --resonating arrow
							[308498] = 308491, --resonating arrow
						},
						["WARRIOR"] = {
							[184367] = 201363, --rampage
							[184709] = 201363,
							[199667] = 44949, --whirlwind
							[190411] = 44949,
							[85739] = 44949,
							[317488] = 317485, --condemn
							[126664] = 100, --charge
							[227847] = 50622, --bladestorm
							[147833] = 3411, --intervene
							[316531] = 3411, --intervene
							[52174] = 6544, --heroic leap
						},
						["ROGUE"] = {
							[199672] = 1943, --rupture
							[185313] = 185422, --shadow dance
						},
						["MAGE"] = {
							[7268] = 5143, --arcane missiles
						},
						["DRUID"] = {

						},
						["MONK"] = {
							[148187] = 116847, --rushing jade wing
							[124503] = 124506, --gift of the ox
						},
						["DEATHKNIGHT"] = {

						},
						["PRIEST"] = {
							[33076] = 41635, --prayer of mending
						},
						["WARLOCK"] = {
							[146739] = 172, --corruption
						},
						["PALADIN"] = {

						},
						["SHAMAN"] = {

						},

						["EVOKER"] = {

						},
					},

					user_blacklisted_spells = {},

					only_cooldowns = false,
					only_auras = false,
					only_players_attack_cooldowns = false,
					only_players_defensive_cooldowns = false,
				}

				--install: install -> if successful installed; saveddata -> a table saved inside details db, used to save small amount of data like configs
				local install, saveddata = Details:InstallPlugin("RAID",
				"Cast Log",
				"Interface\\Icons\\Ability_Warrior_BattleShout",
				castLog,
				"DETAILS_PLUGIN_CAST_LOG",
				MINIMAL_DETAILS_VERSION_REQUIRED,
				"Terciob",
				CASTLOG_VERSION,
				default_options)

				if (type(install) == "table" and install.error) then
					print(install.error)
				end

				--flush db
				--table.wipe(castLog.db)

				--registering details events we need
				Details:RegisterEvent(castLog, "COMBAT_PLAYER_ENTER") --when details creates a new segment, not necessary the player entering in combat.
				Details:RegisterEvent(castLog, "COMBAT_PLAYER_LEAVE") --when details finishs a segment, not necessary the player leaving the combat.
				Details:RegisterEvent(castLog, "DETAILS_DATA_RESET") --details combat data has been wiped

				castLog.sentSpellCache = {}
				castLog.InstallTab()

				--this plugin does not show in lists of plugins
				castLog.NoMenu = true

				--combatlog parser
				local combatLogReader = CreateFrame("frame")
				local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
				castLog.combatLogReader = combatLogReader

				--cache
				local ignoredSpellsClass -- = {}
				local ignoredSpellsAll -- = {}
				local mergedSpells -- = {}

				function castLog.UpdateSpellCache()
					local _, playerClass = UnitClass("player")
					castLog.currentPlayerClass = playerClass
					ignoredSpellsClass = castLog.db.ignored_spells[playerClass]
					ignoredSpellsAll = castLog.db.ignored_spells.ALL
					mergedSpells = castLog.db.merged_spells
				end

				local eventFunc = {
					["SPELL_AURA_APPLIED"] = function(timew, token, hidding, sourceSerial, sourceName, sourceFlag, sourceFlag2, targetSerial, targetName, targetFlag, targetFlag2, spellId, spellName, spellType, amount, overKill, school, resisted, blocked, absorbed, isCritical)
						local GUID = sourceSerial
						if (castLog.inCombat) then
							local playerAuraTable = castLog.currentCombat.aura_timeline[GUID]
							if (playerAuraTable) then

								--check the options for ignored or marged spells
								if (ignoredSpellsClass[spellId]) then
									return
								elseif (ignoredSpellsAll[spellId]) then
									return
								end
								spellId = mergedSpells[spellId] or spellId

								local auraTable = playerAuraTable[spellId]
								if (not auraTable) then
									playerAuraTable [spellId] = {
										enabled = true,
										amountUp = 1,
										appliedAt = GetTime(),
										data = {},
										spellId = spellId,
										--auraType = "BUFF",
									}
									auraTable = playerAuraTable [spellId]
								else
									if (not auraTable.enabled) then
										auraTable.enabled = true
										auraTable.amountUp = 1
										auraTable.appliedAt = GetTime()
									else
										auraTable.amountUp = auraTable.amountUp + 1
									end
								end
							end
						else
							--not in combat
						end
					end,

					["SPELL_AURA_REMOVED"] = function(timew, token, hidding, sourceSerial, sourceName, sourceFlag, sourceFlag2, targetSerial, targetName, targetFlag, targetFlag2, spellId, spellName, spellType, amount, overKill, school, resisted, blocked, absorbed, isCritical)
						local GUID = sourceSerial
						if (castLog.inCombat) then
							local playerAuraTable = castLog.currentCombat.aura_timeline and castLog.currentCombat.aura_timeline[GUID]
							if (playerAuraTable) then

								--check the options for ignored or marged spells
								if (ignoredSpellsClass[spellId]) then
									return
								elseif (ignoredSpellsAll[spellId]) then
									return
								end
								spellId = mergedSpells[spellId] or spellId

								local auraTable = playerAuraTable[spellId]
								if (auraTable) then
									if (auraTable.enabled) then
										auraTable.amountUp = auraTable.amountUp - 1
										if (auraTable.amountUp <= 0) then
											auraTable.enabled = false
											tinsert(auraTable.data, {auraTable.appliedAt, GetTime()}) --when it was applied and when it went off
										end
									end
								end
							end
						end
					end,

					["SPELL_CAST_SUCCESS"] = function(timew, token, hidding, sourceSerial, sourceName, sourceFlag, sourceFlag2, targetSerial, targetName, targetFlag, targetFlag2, spellId, spellName, spellType, amount, overKill, school, resisted, blocked, absorbed, isCritical)
						--local unitId, castGUID, spellId = ...
						--local castSent = castLog.sentSpellCache[castGUID]
						--if (not castSent) then
							--return --if ending here, it won't register for other players since self doesn't receive spell cast sent
						--end
						--castLog.sentSpellCache[castGUID] = nil

						local target = targetName
						local caster = sourceName
						--local spellId = spellId

						local isUnitInGroup = isUnitInTheGroup(sourceName)

						if (caster and spellId and isUnitInGroup) then --need to check if this is passing
							local GUID = sourceSerial
							if (GUID) then
								--check the options for ignored or marged spells
								if (ignoredSpellsClass[spellId]) then
									return
								elseif (ignoredSpellsAll[spellId]) then
									return
								end
								spellId = mergedSpells[spellId] or spellId

								if (castLog.inCombat) then
									local playerCastTable = castLog.currentCombat.spells_cast_timeline[GUID]
									if (playerCastTable) then
										tinsert(playerCastTable, {GetTime(), spellId, target})
									end
								else
									local playerCastTable = spellCache[GUID]

									if (not playerCastTable) then
										spellCache[GUID] = {}
										playerCastTable = spellCache[GUID]
									else
										local cutOffTime = GetTime() - 5
										for i = #playerCastTable, 1, -1 do
											if (playerCastTable [i][1] < cutOffTime) then
												tremove(playerCastTable, i)
											end
										end
									end

									tinsert(playerCastTable, {GetTime(), spellId, target})
								end
							end
						end
					end,
				}

				local unitCache = {}
				local bitBand = bit.band
				local OBJECT_TYPE_PLAYER =	0x00000400
				local Ambiguate = Ambiguate

				combatLogReader:SetScript("OnEvent", function(self)
					local timew, token, hidding, sourceSerial, sourceName, sourceFlags, sourceFlag2, targetSerial, targetName, targetFlags, targetFlag2, spellId, spellName, spellType, amount, overKill, school, resisted, blocked, absorbed, isCritical = CombatLogGetCurrentEventInfo()

					if (sourceName) then
						if (unitCache[sourceName]) then
							sourceName = unitCache[sourceName]
						else
							--detect if this is player by reading the flags
							if (bitBand(sourceFlags, OBJECT_TYPE_PLAYER) ~= 0) then
								sourceName = Ambiguate(sourceName, "none")
								unitCache[sourceName] = sourceName
							else
								unitCache[sourceName] = sourceName
							end
						end
					end

					if (targetName) then
						if (unitCache[targetName]) then
							targetName = unitCache[targetName]
						else
							--detect if this is player by reading the flags
							if (bitBand(targetFlags, OBJECT_TYPE_PLAYER) ~= 0) then
								targetName = Ambiguate(targetName, "none")
								unitCache[targetName] = targetName
							else
								unitCache[targetName] = targetName
							end
						end
					end

					local func = eventFunc[token]
					if (func) then
						--check if the event is from the player or from the group
						if (sourceName and spellId and isUnitInTheGroup(sourceName)) then --need to check this point if it is passing if others
							func(timew, token, hidding, sourceSerial, sourceName, sourceFlags, sourceFlag2, targetSerial, targetName, targetFlags, targetFlag2, spellId, spellName, spellType, amount, overKill, school, resisted, blocked, absorbed, isCritical)
						end
					end
				end)
			end
		end
	end
end
