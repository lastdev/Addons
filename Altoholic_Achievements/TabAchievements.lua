local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local ICON_NOT_STARTED = "Interface\\RaidFrame\\ReadyCheck-NotReady" 
local ICON_PARTIAL = "Interface\\RaidFrame\\ReadyCheck-Waiting"
local ICON_COMPLETED = "Interface\\RaidFrame\\ReadyCheck-Ready" 

local tab		-- small shortcut to easily address the frame (set in OnBind)
local cat = DataStore.Enum.AchievementCategories

local currentPanelKey = "Achievements"
local currentPage
local MAX_PAGES = 12	-- good for 144 alts, should be enough, 1 page per class is even possible

addon:Controller("AltoholicUI.TabAchievements", {
	OnBind = function(frame)
		tab = frame
		
		currentPage = 1
		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))
	
		frame.SelectRealm:RegisterClassEvent("RealmChanged", function(self, account, realm) 
				frame.ClassIcons:Update(account, realm, 1)	-- page 1 when changing realm
				frame.Status:SetText("")
				frame:Update()
			end)
			
		frame.SelectRealm:RegisterClassEvent("DropDownInitialized", function(self) 
				self:AddTitle()
				self:AddTitle(format("%s%s", colors.gold, L["Not started"]), ICON_NOT_STARTED)
				self:AddTitle(format("%s%s", colors.gold, L["Started"]), ICON_PARTIAL)
				self:AddTitle(format("%s%s", colors.gold, COMPLETE), ICON_COMPLETED)
			end)
			
		frame.ClassIcons.OnCharacterChanged = function(self)
				local account, realm = frame.SelectRealm:GetCurrentRealm()
				self:Update(account, realm, currentPage)
				frame:Update()
			end
	
		addon:RegisterEvent("ACHIEVEMENT_EARNED", function(event, id)
			if id then frame:Update() end
		end)
		
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		frame.ClassIcons:Update(account, realm, currentPage)		
		
	end,
	RegisterPanel = function(frame, key, panel)
		-- a simple list of all the child frames
		frame.Panels = frame.Panels or {}
		frame.Panels[key] = panel
	end,
	HideAllPanels = function(frame)
		for _, panel in pairs(frame.Panels) do
			panel:Hide()
		end
	end,
	ShowPanel = function(frame, panelKey)
		if not panelKey then return end
		
		currentPanelKey = panelKey
		
		frame:HideAllPanels()
		
		local panel = frame.Panels[currentPanelKey]
		
		panel:Show()
		if panel.PreUpdate then
			panel:PreUpdate()
		end
		panel:Update()
	end,
	SetStatus = function(frame, text)
		frame.Status:SetText(text)
	end,
	SetCategory = function(frame, categoryID)
		local panel = frame.Panels[currentPanelKey]
		panel:SetCategory(categoryID)
	end,
	Update = function(frame)
		frame:ShowPanel(currentPanelKey)
	end,
	
	-- ** Pagination **
	GoToPreviousPage = function(frame)
		frame:SetPage(currentPage - 1)
	end,
	GoToNextPage = function(frame)
		frame:SetPage(currentPage + 1)
	end,
	GetPage = function(frame)
		return currentPage
	end,
	SetPage = function(frame, pageNum)
		currentPage = pageNum

		-- fix minimum page number
		currentPage = (currentPage < 1) and 1 or currentPage
		
		if currentPage == 1 then
			frame.PrevPage:Disable()
		else
			frame.PrevPage:Enable()
		end
		
		-- fix maximum page number
		currentPage = (currentPage > MAX_PAGES) and MAX_PAGES or currentPage
		
		if currentPage == MAX_PAGES then
			frame.NextPage:Disable()
		else
			frame.NextPage:Enable()
		end
		
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		frame.ClassIcons:Update(account, realm, currentPage)
		frame.PageNumber:SetText(format(MERCHANT_PAGE_NUMBER, currentPage, MAX_PAGES))	
		frame:Update()
	end,
	GetRealm = function(frame)
		local account, realm = frame.SelectRealm:GetCurrentRealm()
		return realm, account
	end,
})

local function categoriesList_OnClick(categoryData)
	tab:SetCategory(categoryData.id)
	tab:Update()
end

addon:Controller("AltoholicUI.TabAchievementsCategoriesList", {
	OnBind = function(frame)
		local categories = {
			{ text = GetCategoryInfo(cat.Character), id = cat.Character, subMenu = {
				{ text = LEVEL, id = cat.CharacterLevel },
				{ text = MONEY, id = cat.CharacterMoney },
				{ text = L["Riding"], id = cat.CharacterRiding },
			}},
			{ text = GetCategoryInfo(cat.Quests), id = cat.Quests, subMenu = {
				{ text = format("%s%s", colors.cyan, "Zones"), subMenu = {
					{ id = cat.QuestsEasternKingdoms },
					{ id = cat.QuestsKalimdor },
					{ id = cat.QuestsOutland },
					{ id = cat.QuestsNorthrend },
					{ id = cat.QuestsCataclysm },
					{ id = cat.QuestsPandaria },
					{ id = cat.QuestsDraenor },
					{ id = cat.QuestsLegion },
					{ id = cat.QuestsBfA },
					{ id = cat.QuestsShadowlands },
				}},
				{ text = TRACKER_FILTER_COMPLETED_QUESTS, id = cat.QuestsCompleted },
				{ text = L["Daily Quests"], id = cat.QuestsDaily },
				{ text = TRACKER_HEADER_WORLD_QUESTS , id = cat.QuestsWorld },
				{ text = L["Dungeon Quests"], id = cat.QuestsDungeon },
			}},
			{ text = GetCategoryInfo(cat.Exploration), id = cat.Exploration, subMenu = {
				{ text = format("%s%s", colors.cyan, "Zones"), subMenu = {
					{ id = cat.ExplorationEasternKingdoms },
					{ id = cat.ExplorationKalimdor },
					{ id = cat.ExplorationOutland },
					{ id = cat.ExplorationNorthrend },
					{ id = cat.ExplorationCataclysm },
					{ id = cat.ExplorationPandaria },
					{ id = cat.ExplorationDraenor },
					{ id = cat.ExplorationLegion },
					{ id = cat.ExplorationBfA },
					{ id = cat.ExplorationShadowlands },
				}},
				{ text = L["Explorer"], id = cat.ExplorationExplorer },
			}},
			{ text = GetCategoryInfo(cat.PvP), id = cat.PvP, subMenu = {
				{ text = format("%s%s", colors.cyan, "Battlegrounds"), subMenu = {
					{ id = cat.PvPWarsongGulch },
					{ id = cat.PvPArathi },
					{ id = cat.PvPEyeOfTheStorm },
					{ id = cat.PvPAlteracValley },
					{ id = cat.PvPAshran },
					{ id = cat.PvPIsleOfConquest },
					{ id = cat.PvPWintergrasp },
					{ id = cat.PvPBattleForGilneas },
					{ id = cat.PvPTwinPeaks },
					{ id = cat.PvPSilvershardMines },
					{ id = cat.PvPTempleOfKotmogu },
					{ id = cat.PvPSeethingShore },
					{ id = cat.PvPDeepwindGorge },
				}},
				{ text = L["Battleground"], id = cat.PvPBattleground },
				{ text = L["Honor"], id = cat.PvPHonor },
				{ text = L["Honorable Kills"], id = cat.PvPHonorableKills },
				{ id = cat.PvPRatedBattleground },
				{ id = cat.PvPArena },
				{ text = L["Kills"], id = cat.PvPKills },
			}},
			{ text = L["Dungeons"], subMenu = {
				{ text = format("%s%s", colors.cyan, "Expansions"), subMenu = {
					{ text = EXPANSION_NAME0, id = cat.DungeonsClassic },
					{ text = EXPANSION_NAME1, id = cat.DungeonsBurningCrusade },
					{ text = EXPANSION_NAME2, id = cat.DungeonsLichKing },
					{ text = EXPANSION_NAME3, id = cat.DungeonsCataclysm },
					{ text = EXPANSION_NAME4, id = cat.DungeonsPandaria },
					{ text = EXPANSION_NAME5, id = cat.DungeonsDraenor },
					{ text = EXPANSION_NAME6, id = cat.DungeonsLegion },
					{ text = EXPANSION_NAME7, id = cat.DungeonsBfA },
					{ text = EXPANSION_NAME8, id = cat.DungeonsShadowlands },
				}},
				{ text = "Dungeon Hero", id = cat.DungeonHero },
				{ text = "Hero's Glory", id = cat.DungeonGloryHero },
				{ text = OTHER, id = cat.DungeonsOther },
				-- by exp
			}},
			{ text = L["Raids"], subMenu = {
				{ text = format("%s%s", colors.cyan, "Expansions"), subMenu = {
					{ text = EXPANSION_NAME0, id = cat.RaidsClassic },
					{ text = EXPANSION_NAME1, id = cat.RaidsBurningCrusade },
					{ text = EXPANSION_NAME2, id = cat.RaidsLichKing },
					{ text = EXPANSION_NAME3, id = cat.RaidsCataclysm },
					{ text = EXPANSION_NAME4, id = cat.RaidsPandaria },
					{ text = EXPANSION_NAME5, id = cat.RaidsDraenor },
					{ text = EXPANSION_NAME6, id = cat.RaidsLegion },
					{ text = EXPANSION_NAME7, id = cat.RaidsBfA },
					{ text = EXPANSION_NAME8, id = cat.RaidsShadowlands },
				}},
				{ text = "Raider's Glory", id = cat.DungeonGloryRaider },
				-- by exp
			}},
			{ id = cat.Professions, subMenu = {
				{ id = cat.ProfessionsCooking, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsCookingLevel },
					{ text = L["Learn"], id = cat.ProfessionsCookingLearn },
					{ text = L["Cook"], id = cat.ProfessionsCookingCook },
					{ text = L["Daily Quests"], id = cat.ProfessionsCookingDailyQuests },
				}},
				{ id = cat.ProfessionsFishing, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsFishingLevel },
					{ text = L["Fish up"], id = cat.ProfessionsFishingFishUp },
					{ text = L["Catch"], id = cat.ProfessionsFishingCatch },
					{ text = L["Daily Quests"], id = cat.ProfessionsFishingDailyQuests },
				}},
				{ id = cat.ProfessionsArchaeology, subMenu = {
					{ text = LEVEL, id = cat.ProfessionsArchaeologyLevel },
					{ text = L["Find"], id = cat.ProfessionsArchaeologyFind },
					{ text = EXPANSION_NAME3, id = cat.ProfessionsArchaeologyCataclysm },
					{ text = EXPANSION_NAME4, id = cat.ProfessionsArchaeologyPandaria },
					{ text = format("%s  %s", colors.yellow, L["Collector"]), id = cat.ProfessionsArchaeologyCollector },
					{ text = EXPANSION_NAME5, id = cat.ProfessionsArchaeologyDraenor },
					{ text = EXPANSION_NAME6, id = cat.ProfessionsArchaeologyLegion },
					{ text = EXPANSION_NAME7, id = cat.ProfessionsArchaeologyBfA },
				}},
			}},
			{ id = cat.Reputations, subMenu = {
				{ text = FACTION_STANDING_LABEL8, id = cat.ReputationsExalted },
				{ text = L["Allied Races"], id = cat.ReputationsAlliedRaces },
				{ text = L["Heritage"], id = cat.ReputationsHeritage },
				{ text = format("%s%s", colors.cyan, "Expansions"), subMenu = {
					{ text = EXPANSION_NAME0, id = cat.ReputationsClassic },
					{ text = EXPANSION_NAME1, id = cat.ReputationsBurningCrusade },
					{ text = EXPANSION_NAME2, id = cat.ReputationsLichKing },
					{ text = EXPANSION_NAME3, id = cat.ReputationsCataclysm },
					{ text = EXPANSION_NAME4, id = cat.ReputationsPandaria },
					{ text = EXPANSION_NAME5, id = cat.ReputationsDraenor },
					{ text = EXPANSION_NAME6, id = cat.ReputationsLegion },
					{ text = EXPANSION_NAME7, id = cat.ReputationsBfA },
					{ text = EXPANSION_NAME8, id = cat.ReputationsShadowlands },
				}},
			}},
			{ id = cat.WorldEvents, subMenu = {
				{ id = cat.WorldEventsLunarFestival },
				{ id = cat.WorldEventsLoveIsInTheAir },
				{ id = cat.WorldEventsNoblegarden },
				{ id = cat.WorldEventsChildrensWeek },
				{ id = cat.WorldEventsMidSummer, subMenu = {
					{ text = L["Desecrate"], id = cat.WorldEventsMidSummerDesecrate },
					{ text = L["Flame Keeper"], id = cat.WorldEventsMidSummerKeepers },
					{ text = L["Flame Warden"], id = cat.WorldEventsMidSummerWardens },
				}},
				{ id = cat.WorldEventsBrewfest },
				{ id = cat.WorldEventsHallowsEnd, subMenu = {
					{ text = L["Tricks and Treats"], id = cat.WorldEventsHallowsEndTricks },
				}},
				{ id = cat.WorldEventsPilgrimsBounty },
				{ id = cat.WorldEventsWinterveil },
				{ id = cat.WorldEventsDarkmoon, subMenu = {
					{ text = L["The Real Race"], id = cat.WorldEventsDarkmoonRealRace },
					{ text = L["The Real Big Race"], id = cat.WorldEventsDarkmoonRealBigRace },
				}},
				{ id = cat.WorldEventsBrawlersGuild },
			}},
			{ id = cat.PetBattles, subMenu = {
				{ id = cat.PetBattlesCollect, subMenu = {
					{ text = ITEM_UNIQUE, id = cat.PetBattlesCollectUnique },
					{ text = select(2, GetAchievementInfo(7934)), id = cat.PetBattlesCollectLeashes },
					{ text = L["Safari"], id = cat.PetBattlesCollectSafari },
				}},
				{ id = cat.PetBattlesBattle, subMenu = {
					{ text = L["Wins"], id = cat.PetBattlesBattleWins },
					{ text = PVP, id = cat.PetBattlesBattlePvP },
					{ text = EXPANSION_NAME6, id = cat.PetBattlesBattleLegion },
					{ text = format("%s  %s", colors.yellow, GetRealZoneText(1669)), id = cat.PetBattlesBattleArgus },
					{ text = EXPANSION_NAME7, id = cat.PetBattlesBattleBfA },
					{ text = EXPANSION_NAME8, id = cat.PetBattlesBattleShadowlands },
				}},
				{ id = cat.PetBattlesLevel },
			}},
			{ id = cat.Collections, subMenu = {
				{ id = cat.CollectionsToyBox },
				{ id = cat.CollectionsMounts },
				{ id = cat.CollectionsAppearances, subMenu = {
					{ text = L["Raids"], id = cat.CollectionsAppearancesRaids },
					{ text = PVP, id = cat.CollectionsAppearancesPvP },
				}},
			}},
			{ id = cat.ExpansionFeatures, subMenu = {
				{ id = cat.ExpansionFeaturesArgentTournament },
				{ id = cat.ExpansionFeaturesTolBarad },
				{ id = cat.ExpansionFeaturesPandariaScenarios },
				{ id = cat.ExpansionFeaturesProvingGrounds, subMenu = {
					{ text = DAMAGE, id = cat.ExpansionFeaturesProvingGroundsDamage },
					{ text = HEALER, id = cat.ExpansionFeaturesProvingGroundsHealer },
					{ text = TANK, id = cat.ExpansionFeaturesProvingGroundsTank },
				}},
				{ id = cat.ExpansionFeaturesDraenorGarrisons },
				{ id = cat.ExpansionFeaturesLegionClassHall },
				{ id = cat.ExpansionFeaturesIslandExpeditions },
				{ id = cat.ExpansionFeaturesWarEffort },
				{ id = cat.ExpansionFeaturesHeartOfAzeroth },
				{ id = cat.ExpansionFeaturesVisionsOfNzoth },
				{ id = cat.ExpansionFeaturesTorghast, subMenu = {
					{ text = L["Twisting Corridors"], id = cat.ExpansionFeaturesTorghastCorridors },
					{ text = L["Flawless Runs"], id = cat.ExpansionFeaturesTorghastFlawless },
					{ text = L["Phantasma"], id = cat.ExpansionFeaturesTorghastPhantasma },
				}},
				{ id = cat.ExpansionFeaturesCovenantSanctums, subMenu = {
					{ text = C_Covenants.GetCovenantData(1).name, id = cat.ExpansionFeaturesCovenantSanctumsKyrian },
					{ text = C_Covenants.GetCovenantData(2).name, id = cat.ExpansionFeaturesCovenantSanctumsVenthyr },
					{ text = C_Covenants.GetCovenantData(3).name, id = cat.ExpansionFeaturesCovenantSanctumsNightFae },
					{ text = C_Covenants.GetCovenantData(4).name, id = cat.ExpansionFeaturesCovenantSanctumsNecrolords },
					{ text = COVENANT_MISSIONS_TITLE, id = cat.ExpansionFeaturesCovenantSanctumsAdventures },
				}},
			}},
			{ id = cat.FeatsOfStrength, subMenu = {
				{ id = cat.FeatsOfStrengthMounts, subMenu = {
					{ text = GetCategoryInfo(cat.PvPArena), id = cat.FeatsOfStrengthMountsArena },
					{ text = RAF_BUTTON_TOOLTIP_TITLE , id = cat.FeatsOfStrengthMountsRaF },
				}},
				{ id = cat.FeatsOfStrengthDungeons, subMenu = {
					{ text = CHALLENGE_MODE, id = cat.FeatsOfStrengthDungeonsChallenge },
					{ text = EXPANSION_NAME7, id = cat.FeatsOfStrengthDungeonsBfA },
					{ text = EXPANSION_NAME8, id = cat.FeatsOfStrengthDungeonsShadowlands },
				}},
				{ id = cat.FeatsOfStrengthRaids, subMenu = {
					{ text = L["Ahead of the Curve"], id = cat.FeatsOfStrengthRaidsAhead },
					{ text = L["Cutting Edge"], id = cat.FeatsOfStrengthRaidsCuttingEdge },
				}},
				{ id = cat.FeatsOfStrengthPvP, subMenu = {
					{ text = EXPANSION_NAME5, id = cat.FeatsOfStrengthPvPDraenor },
					{ text = EXPANSION_NAME6, id = cat.FeatsOfStrengthPvPLegion },
					{ text = EXPANSION_NAME7, id = cat.FeatsOfStrengthPvPBfA },
					{ text = EXPANSION_NAME8, id = cat.FeatsOfStrengthPvPShadowlands },
					{ text = GetCategoryInfo(cat.PvPRatedBattleground), id = cat.FeatsOfStrengthPvPRatedBG },
					
					-- Unchained Combatant / Vicious Saddle
					{ text = select(2, GetAchievementInfo(14967)), id = cat.FeatsOfStrengthPvPUnchained },
				}},
				{ id = cat.FeatsOfStrengthReputation },
				{ id = cat.FeatsOfStrengthEvents, subMenu = {
					{ text = GetCategoryInfo(cat.WorldEventsWinterveil), id = cat.FeatsOfStrengthEventsWinterveil },
					{ text = L["Anniversary"], id = cat.FeatsOfStrengthEventsAnniversary },
				}},
				{ id = cat.FeatsOfStrengthPromotions, subMenu = {
					{ text = L["BlizzCon"], id = cat.FeatsOfStrengthPromotionsBlizzCon },
					{ text = L["Collector's Edition"], id = cat.FeatsOfStrengthPromotionsCollector },
				}},
				{ text = L["Realm First"], id = cat.FeatsOfStrengthRealmFirst },
			}},
		}
		
		-- Initialize categories (auto-fill .text & .callback)
		frame:IterateCategories(categories, function(category) 
			if not category.text and category.id then
				-- if no text has been set, get one from the id
				category.text = GetCategoryInfo(category.id)
			end
			
			-- set the onClick callback
			category.callback = categoriesList_OnClick
		end)
	
		frame:SetCategories(categories)
	end,
})