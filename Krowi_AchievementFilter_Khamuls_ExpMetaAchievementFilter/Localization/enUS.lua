local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "enUS", true)

if not L then return end

-- Globals
L["Khamuls Collections for Krowi's Achievement Filter"] = "Khamuls Collections for Krowi's Achievement Filter"
L["Khamul's Meta-Expansion Achievement List"] = "Khamul's Meta-Mount Collection"
L["Khamul's House Decor Achievement List"] = "Khamul's Decor Collection"
L["Khamul's Campsite Achievement List"] = "Khamul's Campsite Collection"
L["Khamul's Battle Pet Achievement List"] = "Khamul's Pet Collection"

-- Special categories
L["Cross-Expansion"] = "Cross-Expansion"

-- Missing category titles
L["Hard"] = "Hard"
L["Nightmare"] = "Nightmare"

-- Tooltips
L["Tt_ACM_15035"] = "Only 4 needed to complete the Meta-Achievement"
L["Tt_UseMetaAchievementPlugin"] = "Use \"Khamul's Meta-Mount Collection\" category, to get an detailed overview for \"{1}\"."

-- Messages
L["Krowi's Achievement Filter Addon not loaded!"] = "Krowi's Achievement Filter Addon not loaded!"

-- Options
L["Show List for Expansion Meta Achievements"] = "Show the Meta-Mount collection"
L["If enabled, a list with all achievements required for expansion meta achievements will be shown"] = "If enabled, a collection with all achievements required for expansion meta-mount achievements will be shown"
L["Show List for Achievements with decors as reward"] = "Show collection for achievements with decors as reward"
L["If enabled, a list with all achievements, which have a decor as reward, will be shown"] = "If enabled, a collection with all achievements, which have a decor as reward, will be shown"
L["Show List for Achievements with warband campsites as reward"] = "Show collection for achievements with warband campsites as reward"
L["If enabled, a list with all achievements, which have a warband campsite as reward, will be shown"] = "If enabled, a collection with all achievements, which have a warband campsite as reward, will be shown"
L["Show List for Achievements with battle pets as reward"] = "Show collection for achievements with battle pets as reward"
L["If enabled, a list with all achievements, which have a battle pet as reward, will be shown"] = "If enabled, a collection with all achievements, which have a battle pet as reward, will be shown"
L["Krowi AchievementFilter status: "] = "Krowi AchievementFilter status: "
L["detected"] = "detected"
L["not detected"] = "not detected"
L["Decor Collection Settings"] = "Decor Collection Settings"
L["Meta-Mount Collection Settings"] = "Meta-Mount Collection Settings"
L["Campsite Collection Settings"] = "Campsite Collection Settings"
L["Pet Collection Settings"] = "Pet Collection Settings"
L["Flatten collection structure"] = "Flatten collection structure"
L["The collections depth will be flatten and all achievements will be displayed in the expansions category"] = "The collections depth will be flatten and all achievements will be displayed in the expansions category"
L["Include Child Achievements"] = "Include Child Achievements"
L["If an Achievement has other Achievements as requirement, they will be shown in an extra category."] = "If an Achievement has other Achievements as requirement, they will be shown in an extra category."
L["Changing any option on this page, requires a reload to take affect."] = "Changing any option on this page, requires a reload to take affect."
L["Include Battle-Pet related rewards"] = "Include Battle-Pet related rewards"
L["This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"] = "This will include Achievements with Pet-Battle rewards like daily quests unlock, costumes and toys"
