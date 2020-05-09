--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 -
	Sanex @ EU-Arathor / ahak @ Curseforge
----------------------------------------------------------------------------]]--
local ADDON_NAME, n = ...

local _G = _G
local L = {}
n.L = L

local LOCALE = GetLocale()
do -- enUS / enGB
	-- Data.lua
	L.DefaultScaleName_Default = "Default"
	L.DefaultScaleName_Defensive = "Defensive"
	L.DefaultScaleName_Offensive = "Offensive"

	-- UI.lua
	L.ScaleWeightEditor_Title = "%s Scale Weight Editor" -- %s = ADDON_NAME

	-- Core.lua
	L.ScalesList_CustomGroupName = "Custom Scales"
	L.ScalesList_DefaultGroupName = "Default Scales"
	L.ScalesList_CreateImportText = "Create New / Import"

	L.ScaleName_Unnamed = "Unnamed"
	L.ScaleName_Unknown = "Unknown"

	L.ExportPopup_Title = "Export Scale"
	L.ExportPopup_Desc = "Exporting scale %1$s\nPress %2$sCtrl+C%3$s to copy the string and %4$sCtrl+V%5$s to paste it somewhere" -- %1$s = scaleName, rest are color codes

	L.ImportPopup_Title = "Import Scale"
	L.ImportPopup_Desc = "Importing scale from string\nPress %1$sCtrl+V%2$s to paste string to the editbox and press %3$s" -- %1$s and %2$s are color codes and %3$s = _G.ACCEPT
	L.ImportPopup_Error_OldStringRetry = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
	L.ImportPopup_Error_OldStringVersion = "ERROR: \"Import string\" -version is too old or malformed import string!"
	L.ImportPopup_Error_MalformedString = "ERROR: Malformed import string!"
	L.ImportPopup_UpdatedScale = "Updated existing scale \"%s\"" -- %s = scaleName
	L.ImportPopup_CreatedNewScale = "Imported new scale \"%s\"" -- %s = scaleName

	L.MassImportPopup_Title = "Mass Import Scales"
	L.MassImportPopup_Desc = "Importing multiple scales at once from string\nPress %1$sCtrl+V%2$s to paste string to the editbox and press %3$s" -- %1$s and %2$s are color codes and %3$s = _G.ACCEPT

	L.CreatePopup_Title = "Create Scale"
	L.CreatePopup_Desc = "Creating new scale. Select class and specialization from dropdown and then enter name for the new scale and press %1$s" -- %s = _G.ACCEPT
	L.CreatePopup_Error_UnknownError = "ERROR: Something went wrong creating new scale \"%s\"!" -- %s = scaleName
	L.CreatePopup_Error_CreatedNewScale = "Created new scale \"%s\"" -- %s = scaleName

	L.RenamePopup_Title = "Rename Scale"
	L.RenamePopup_Desc = "Renaming scale %1$s\nEnter new name to the editbox and press %2$s" -- %1$s = old (current) scaleName, %2$s = _G.ACCEPT
	L.RenamePopup_RenamedScale = "Renamed scale \"%1$s\" to \"%2$s\"" -- %1$s = old scaleName, %2$s = new scaleName

	L.DeletePopup_Title = "Delete Scale"
	L.DeletePopup_Desc = "Deleting scale %1$s\nPress %2$s to confirm.\nAll characters using this scale for their specialization will be reverted back to Default scale." -- %1$s = scaleName, %2$s = _G.ACCEPT
	L.DeletePopup_Warning = " ! This action is permanent and cannot be reversed ! "
	L.DeletePopup_DeletedScale = "Deleted scale \"%s\"" -- %s = scaleName
	L.DeletePopup_DeletedDefaultScale = "Deleted scale was in use, reverting back to Default-option for your class and specialization!"

	L.WeightEditor_VersionText = "Version %s" -- %s = version
	L.WeightEditor_CreateNewText = "Create New"
	L.WeightEditor_ImportText = "Import"
	L.WeightEditor_MassImportText = "Mass Import"
	L.WeightEditor_EnableScaleText = "Use this Scale"
	L.WeightEditor_ExportText = "Export"
	L.WeightEditor_RenameText = "Rename"
	L.WeightEditor_DeleteText = "Delete"
	L.WeightEditor_TooltipText = "Show in Tooltips"
	L.WeightEditor_ModeToEssences = "Change to Essences"
	L.WeightEditor_ModeToTraits = "Change to Traits"
	L.WeightEditor_TimestampText_Created = "Created %s" -- %s DD.MM.YYYY
	L.WeightEditor_TimestampText_Imported = "Imported %s" -- %s DD.MM.YYYY
	L.WeightEditor_TimestampText_Updated = "Updated %s" -- %s DD.MM.YYYY
	L.WeightEditor_CurrentScale = "Current scale: %s" -- %s current scaleName
	L.WeightEditor_Major = "Major"
	L.WeightEditor_Minor = "Minor"

	L.PowersTitles_Class = "Class Powers"
	L.PowersTitles_Defensive = "Defensive Powers"
	L.PowersTitles_Role = "Role Powers"
	L.PowersTitles_Zone = "Raid and Zone Powers"
	L.PowersTitles_Profession = "Profession Powers"
	L.PowersTitles_PvP = "PvP Powers"

	L.PowersScoreString = "Current score: %1$s/%2$s\nMaximum score: %3$s\nAzerite level: %4$d/%5$d" -- %1$s = currentScore, %2$s = currentPotential, %3$s = maximumScore, %4$d = currentLevel, %5$d = maxLevel
	L.ItemToolTip_AzeriteLevel = "Azerite level: %1$d / %2$d" -- %1$d = currentLevel, %2$d = maxLevel
	L.ItemToolTip_Legend = "Current score / Current potential / Maximum score"

	L.Config_SettingsAddonExplanation = "This addon calculates \"Current score\", \"Current potential\" and \"Maximum score\" for Azerite gear based on your selected scale's weights."
	L.Config_SettingsScoreExplanation = "\"Current score\" is the sum of the currently selected Azerite powers in the item.\n\"Current potential\" is the sum of the highest weighted Azerite powers from each tier you have access to in the item.\n\"Maximum score\" is the sum of the highest weighted Azerite powers from each tier, including the locked ones, in the item."
	L.Config_SettingsSavedPerChar = "All these settings here are saved per character.\nCustom scales are shared between all characters."

	L.Config_Enable_Traits = "Azerite Traits"
	L.Config_Enable_Traits_Desc = "Enable %s for Azerite Empowered items." -- %s = ADDON_NAME
	L.Config_Enable_Essences = "Azerite Essences"
	L.Config_Enable_Essences_Desc = "Enable %s for Azerite Essences." -- %s = ADDON_NAME

	L.Config_Scales_Title = "Scales list"
	--L.Config_Scales_Desc = "Following settings only affects the list of Default scales. All Custom scales will be always listed to every class."
	L.Config_Scales_OwnClassDefaultsOnly = "List own class Default-scales only"
	L.Config_Scales_OwnClassDefaultsOnly_Desc = "List Default-scales for your own class only, instead of listing all of them."
	L.Config_Scales_OwnClassCustomsOnly = "List own class Custom-scales only"
	L.Config_Scales_OwnClassCustomsOnly_Desc = "List Custom-scales for your own class only, instead of listing all of them."

	L.Config_Importing_Title = "Importing"
	L.Config_Importing_ImportingCanUpdate = "Importing can update existing scales"
	L.Config_Importing_ImportingCanUpdate_Desc = "When importing scale with same name, class and specialization as pre-existing scale, existing scale will be updated with the new weights instead of creating new scale."
	L.Config_Importing_ImportingCanUpdate_Desc_Clarification = "There can be multiple scales with same name as long as they are for different specializations or classes."

	L.Config_WeightEditor_Title = "Scales weight editor"
	L.Config_WeightEditor_Desc = "Following settings only affects the powers shown in the scale weight editor. Even if you disable them, all and any Azerite powers will be still scored if they have weight set to them in the active scale."
	L.Config_WeightEditor_ShowDefensive = "Show Defensive powers"
	L.Config_WeightEditor_ShowDefensive_Desc = "Show common and class specific Defensive powers in the scale weight editor."
	L.Config_WeightEditor_ShowRole = "Show Role specific powers"
	L.Config_WeightEditor_ShowRole_Desc = "Show Role specific powers in the scale weight editor."
	L.Config_WeightEditor_ShowRolesOnlyForOwnSpec = "Show Role specific powers only for my own specializations role"
	L.Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc = "Show common and current specialization related specific Role specific powers in the scale weight editor. Enabling this setting e.g. hides healer only specific powers from damagers and tanks etc."
	L.Config_WeightEditor_ShowZone = "Show Zone specific powers"
	L.Config_WeightEditor_ShowZone_Desc = "Show Zone specific powers in the scale weight editor. These powers can only appear in items acquired in particular zones related to the power."
	L.Config_WeightEditor_ShowZone_Desc_Proc = "Zone specific powers can activate/proc everywhere, but raid powers have secondary effect which will activate only while inside their related raid instance (e.g. Uldir powers secondary effect will only proc while inside Uldir raid instance).\nRaid powers are marked with an asterisk (*) next to their name in the scale weight editor."
	L.Config_WeightEditor_ShowProfession = "Show Profession specific powers"
	L.Config_WeightEditor_ShowProfession_Desc = "Show Profession specific powers in the scale weight editor. These powers can only appear in items created with professions. Currently, these can only appear in Engineering headgear."
	L.Config_WeightEditor_ShowPvP = "Show PvP specific powers"
	L.Config_WeightEditor_ShowPvP_Desc = "Show PvP specific powers in the scale weight editor. You'll only see your own factions powers, but changes made to them will be mirrored to both factions."
	L.Config_WeightEditor_ShowPvP_Desc_Import = "When Exporting, the resulting export-string will only include your own factions pvp powers, but they are interchangeable with opposing factions pvp-powerIDs.\nWhen Importing import-string with pvp powers only from one faction, powers will get their weights mirrored to both factions on Import."

	L.Config_Score_Title = "Score"
	L.Config_Score_AddItemLevelToScore = "Add itemlevel to all scores"
	L.Config_Score_AddItemLevelToScore_Desc = "Add Azerite items itemlevel to all current score, current potential and maximum score calculations."
	L.Config_Score_ScaleByAzeriteEmpowered = "Scale itemlevel score by the weight of %s in the scale" -- %s Name of Azerite Empowered, returned by _G.GetSpellInfo(263978)
	L.Config_Score_ScaleByAzeriteEmpowered_Desc = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score." -- %s Name of Azerite Empowered, returned by _G.GetSpellInfo(263978)
	L.Config_Score_AddPrimaryStatToScore = "Add primary stat to all scores"
	L.Config_Score_AddPrimaryStatToScore_Desc = "Add Azerite items amount of primary stat (%s/%s/%s) to all current score, current potential and maximum score calculations." -- %s, %s, %s = _G.ITEM_MOD_AGILITY_SHORT, _G.ITEM_MOD_INTELLECT_SHORT, _G.ITEM_MOD_STRENGTH_SHORT
	L.Config_Score_RelativeScore = "Show relative values in tooltips instead of absolute values"
	L.Config_Score_RelativeScore_Desc = "Instead of showing absolute values of scales in tooltips, calculate the relative value compared to currently equipped items and show them in percentages."
	L.Config_Score_ShowOnlyUpgrades = "Show tooltips only for upgrades"
	L.Config_Score_ShowOnlyUpgrades_Desc = "Show scales values in tooltips only if it is an upgrade compared to currently equipped item. This works only with relative values enabled."
	L.Config_Score_ShowTooltipLegend = "Show legend in tooltips"
	L.Config_Score_ShowTooltipLegend_Desc = "Show reminder for \"Current score / Current potential / Maximum score\" in tooltips."
	L.Config_Score_OutlineScores = "Outline Scores"
	L.Config_Score_OutlineScores_Desc = "Draw small outline around the score-numbers on Azerite traits/essences to make it easier to read the numbers on light trait/essence icons."
	L.Config_Score_PreferBiSMajor = "Prefer best major essence"
	L.Config_Score_PreferBiSMajor_Desc = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."

	L.Slash_Command = "/azerite" -- If you need localized slash-command, this doesn't replace the existing /azerite
	L.Slash_RemindConfig = "Check ESC -> Interface -> AddOns -> %s for settings." -- %s = ADDON_NAME
	L.Slash_Error_Unkown = "ERROR: Something went wrong!"

	L.Debug_CopyToBugReport = "COPY & PASTE the text above to your bug report if you think it is relevant."
end

if LOCALE == "deDE" then -- Sinusquell (39), Tiggi2702 (5), Vivan (2), pas06 (2), Cytoph (1), imna1975 (17), Aurielqt (6)
L["Config_Enable_Essences"] = "Azerit Essenz"
L["Config_Enable_Essences_Desc"] = "Aktiviere %s für Azerit Essenzen"
L["Config_Enable_Traits"] = "Azerit Fähigkeiten"
L["Config_Enable_Traits_Desc"] = "Aktiviere %s für Azerit verstärke Gegenstände"
L["Config_Importing_ImportingCanUpdate"] = "Beim Importieren können vorhandene Skalierungen aktualisiert werden."
L["Config_Importing_ImportingCanUpdate_Desc"] = "Wenn Sie eine Skalierung mit demselben Namen, derselben Klasse und Spezialisierung wie eine bereits vorhandene Skalierung importieren, wird die vorhandene Skalierung mit den neuen Gewichtungen aktualisiert, anstatt eine neue Skalierung zu erstellen. "
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "Es kann mehrere Skalierungen mit demselben Namen geben, solange sie für verschiedene Spezialisierungen oder Klassen gelten. "
L["Config_Importing_Title"] = "Importieren "
L["Config_Scales_OwnClassCustomsOnly"] = "Listet benutzerdefinierte Skalierungen nur für die eigene Klasse"
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "Zeige benutzerdefinierte Skalierungen nur für deine eigene Klasse, statt alle aufzulisten."
L["Config_Scales_OwnClassDefaultsOnly"] = "Zeige nur Standardskalierung für die eigene Klasse."
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "Zeige nur Standardskalierungen für die eigene Klasse anstelle von allen anderen."
L["Config_Scales_Title"] = "Skalierungsliste "
L["Config_Score_AddItemLevelToScore"] = "Füge Gegenstandsstufe zu allen Wertungen hinzu"
L["Config_Score_AddItemLevelToScore_Desc"] = "Fügt allen Berechnungen der aktuellen Punktzahl, des aktuellen Potenzials und der maximalen Punktzahl die Elementstufe der azeritischen Gegenstände hinzu."
L["Config_Score_AddPrimaryStatToScore"] = "Füge allen Wertungen den Primärstatus hinzu"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Füge Azerit Gegenständen den primären Wert (%s/%s/%s) zu dem derzeitigen Wert hinzu. Derzeitiges Potential und maximale Werteberechnung."
L["Config_Score_OutlineScores"] = "Werteumrandung"
L["Config_Score_OutlineScores_Desc"] = "Zeige eine schmale Umrandung für die Werte der Azerit Fähigkeiten/Essenzen, um sie einfacher bei hellen Fähigkeiten/Essenzen Icons zu sehen."
L["Config_Score_PreferBiSMajor"] = "Empfehle beste Hauptessenz"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
L["Config_Score_RelativeScore"] = "Zeigt relative Werte in Tooltips anstelle von absoluten Werten an"
L["Config_Score_RelativeScore_Desc"] = "Statt absolute Werte in Tooltips anzuzeigen, berechne die relativen Werte verglichen zum aktuell ausgerüsteten Gegenstand und zeige sie in Prozent an."
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered"] = "Scale itemlevel score by the weight of %s in the scale"
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score."
L["Config_Score_ShowOnlyUpgrades"] = "Zeige Tooltip Information nur bei Upgrades an"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Zeige Skalierungswerte nur in Tooltips wenn es eine Aufwertung zum aktuell ausgerüsteten Gegenstand ist. Dies funktioniert nur wenn relative Werte aktiviert sind."
L["Config_Score_ShowTooltipLegend"] = "Zeige eine Legende in Tooltips an"
L["Config_Score_ShowTooltipLegend_Desc"] = "Zeige eine Erinnerung für \"Aktuellen Punktestand / Aktuelles Potenzial / Maximaler Punktestand\" in Tooltips."
L["Config_Score_Title"] = "Punkte"
L["Config_SettingsAddonExplanation"] = "Dieses Addon berechnet \"Aktuelle Punktzahl\", \"Aktuelles Potenzial\" und \"Maximale Punktzahl\" für Azerite-Ausrüstung basierend auf den von Ihnen ausgewählte skaliert Gewichtung."
L["Config_SettingsSavedPerChar"] = [=[Alle Einstellungen sind für den Charakter gespeichert. 
Benutzerdefinierte Einstellungen werden geteilt zwischen allen Charaktern.]=]
L["Config_SettingsScoreExplanation"] = [=["Aktuelle Bewertung" ist die Summe der aktuell ausgewählten Azerite-Kräfte in dem Element.
"Aktuelles Potential" ist die Summe der am höchsten gewichteten Azerite-Kräfte aus jeder Ebene, auf die Sie im Element zugreifen können.
"Maximale Punktzahl" ist die Summe der höchsten gewichteten Azerite-Kräfte aus jeder Schicht, einschließlich der gesperrten, in dem Element.]=]
L["Config_WeightEditor_Desc"] = "Die folgenden Einstellungen wirken sich nur auf die im Editor angezeigten Fähigkeiten aus. Selbst wenn du sie deaktivierst, werden alle Azeritermächtigungen immer noch gewertet, wenn sie auf der aktiven Skala Werte haben."
L["Config_WeightEditor_ShowDefensive"] = "Zeige defensive Fähigkeiten"
L["Config_WeightEditor_ShowDefensive_Desc"] = "Zeige gemeinsame und klassenspezifische Defensivfähigkeiten im Editor."
L["Config_WeightEditor_ShowProfession"] = "Zeige berufsspezifische Fähigkeiten "
--[[Translation missing --]]
L["Config_WeightEditor_ShowProfession_Desc"] = "Show Profession specific powers in the scale weight editor. These powers can only appear in items created with professions. Currently, these can only appear in Engineering headgear."
L["Config_WeightEditor_ShowPvP"] = "Zeige PVP spezifische Fähigkeiten "
L["Config_WeightEditor_ShowPvP_Desc"] = "Zeigt PvP-spezifische Fähigkeiten im Skala Gewicht Editor an. Du siehst nur die Fähigkeiten deiner eigenen Fraktionen, aber die an ihnen vorgenommenen Änderungen werden auf beide Fraktionen gespiegelt."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[When Exporting, the resulting export-string will only include your own factions pvp powers, but they are interchangeable with opposing factions pvp-powerIDs.
When Importing import-string with pvp powers only from one faction, powers will get their weights mirrored to both factions on Import.]=]
L["Config_WeightEditor_ShowRole"] = "Rollenspezifische Fähigkeiten anzeigen"
L["Config_WeightEditor_ShowRole_Desc"] = "Zeigt Rollenspezifische Fähigkeiten im Skala Gewicht Editor an."
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Rollenspezifische Fähigkeiten nur für meine eigene Spezialisierungsrolle anzeigen"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Show common and current specialization related specific Role specific powers in the scale weight editor. Enabling this setting e.g. hides healer only specific powers from damagers and tanks etc."
L["Config_WeightEditor_ShowZone"] = "Zonenspezifische Fähigkeiten anzeigen"
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc"] = "Show Zone specific powers in the scale weight editor. These powers can only appear in items acquired in particular zones related to the power."
L["Config_WeightEditor_ShowZone_Desc_Proc"] = "Zonenspezifische Kräfte können / proc überall aktivieren, aber Schlachtzugsmächte haben einen sekundären Effekt, der nur aktiviert wird, wenn sie sich innerhalb ihrer zugehörigen Schlachtzugsinstanz befinden (z. B. wird der sekundäre Effekt von Uldir-Kräften nur in der Uldir-Schlachtzugsinstanz ausgeführt). Die Schlachtzugskraft ist im Skala Gewicht Editor mit einem Stern (*) neben ihrem Namen gekennzeichnet."
--[[Translation missing --]]
L["Config_WeightEditor_Title"] = "Scales weight editor"
L["CreatePopup_Desc"] = "Erstelle neue Skalierung. Wähle deine Klasse und Spezialisierung aus der Liste und vergebe einen Namen für die Skalierung. Zur Bestätigung drücke %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "Skalierung \"%s\" erfolgreich erstellt"
--[[Translation missing --]]
L["CreatePopup_Error_UnknownError"] = "ERROR: Something went wrong creating new scale \"%s\"!"
L["CreatePopup_Title"] = "Erstelle Skalierung"
L["Debug_CopyToBugReport"] = "Kopiere den obrigen Text in deine Fehlermeldung, wenn du denkst es ist relevant."
L["DefaultScaleName_Default"] = "Standard"
L["DefaultScaleName_Defensive"] = "Defensive"
L["DefaultScaleName_Offensive"] = "Offensive"
L["DeletePopup_DeletedDefaultScale"] = "Die gelöschte Skala wurde verwendet, sodass Sie für Ihre Klasse und Ihre Spezialisierung wieder auf die Default-Option zurückgreifen können!"
L["DeletePopup_DeletedScale"] = "Gelöschte Skala \"%s\""
L["DeletePopup_Desc"] = "Um Skalierung%1$s zu löschen drücke %2$s zur bestätigung. Alle Charactere die diese Skalierung, für ihre Spezialiserung, benutzt haben werden auf die Basisskalierung zurück gesetzt."
L["DeletePopup_Title"] = "Skala löschen"
L["DeletePopup_Warning"] = "! Diese Aktion ist dauerhaft und kann nicht rückgängig gemacht werden !"
L["ExportPopup_Desc"] = [=[Um die Skalierung %1$s zu exportieren, drücke %2$sSTRG-C%3$s um sie zu kopieren und %4$sSTRG+V%5$s um sie wieder einzufügen.
]=]
L["ExportPopup_Title"] = "Skala exportieren"
L["ImportPopup_CreatedNewScale"] = "Importiere neue Skalierung \"%s\""
--[[Translation missing --]]
L["ImportPopup_Desc"] = [=[Importing scale from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
L["ImportPopup_Error_MalformedString"] = "ERROR: Fehlerhafter Import-String!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
L["ImportPopup_Error_OldStringVersion"] = "ERROR: \"Import-String\" -Version ist zu alt oder fehlerhafter Import-String!"
L["ImportPopup_Title"] = "Importiere Skalierung"
L["ImportPopup_UpdatedScale"] = "Skalierung \"%s\" wurde aktualisiert"
L["ItemToolTip_AzeriteLevel"] = "Azeritlevel: %1$d / %2$d"
L["ItemToolTip_Legend"] = "Aktuelle Wertung / Aktuelles Potenzial / Maximale Wertung"
--[[Translation missing --]]
L["MassImportPopup_Desc"] = [=[Importing multiple scales at once from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["MassImportPopup_Title"] = "Mass Import Scales"
L["PowersScoreString"] = "Aktuelle Wertung: %1$s/%2$s Maximale Wertung: %3$s Azeritlevel: %4$d/%5$d"
L["PowersTitles_Class"] = "Klassentalente"
L["PowersTitles_Defensive"] = "Defensivtalente"
L["PowersTitles_Profession"] = "Berufstalente"
L["PowersTitles_PvP"] = "PVPtalente"
L["PowersTitles_Role"] = "Spezialisierungstalente"
L["PowersTitles_Zone"] = "Schlatzugs und Zonen Fähigkeiten"
L["RenamePopup_Desc"] = "Benenne Skalierung %1$s um, Trage neuen Namen in das Editierfeld ein und drücke %2$s"
L["RenamePopup_RenamedScale"] = "Skalierung umbenennen von \"%1$s\" zu \"%2$s\""
L["RenamePopup_Title"] = "Skalierung umbenennen"
L["ScaleName_Unknown"] = "Unbekannt"
L["ScaleName_Unnamed"] = "Unbenannt"
L["ScalesList_CreateImportText"] = "Erstelle Neu / Importieren"
L["ScalesList_CustomGroupName"] = "Benutzerdefinierte Skalierung"
L["ScalesList_DefaultGroupName"] = "Standardskalierungen"
L["ScaleWeightEditor_Title"] = "%s Skala Gewicht Editor"
L["Slash_Command"] = "/azerite"
L["Slash_Error_Unkown"] = "FEHLER: Etwas ist schief gelaufen!"
L["Slash_RemindConfig"] = "Siehe ESC -> Interface -> Addons -> %s für weitere Einstellungen."
L["WeightEditor_CreateNewText"] = "Neu erstellen"
L["WeightEditor_CurrentScale"] = "Aktuelle Skalierung: %s"
L["WeightEditor_DeleteText"] = "Löschen"
L["WeightEditor_EnableScaleText"] = "Benutze diese Skalierung"
L["WeightEditor_ExportText"] = "Exportieren"
L["WeightEditor_ImportText"] = "Importieren"
--[[Translation missing --]]
L["WeightEditor_Major"] = "Major"
--[[Translation missing --]]
L["WeightEditor_MassImportText"] = "Mass Import"
L["WeightEditor_Minor"] = "Geringer"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
L["WeightEditor_RenameText"] = "Umbenennen"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Created"] = "Created %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Imported"] = "Imported %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Updated"] = "Updated %s"
L["WeightEditor_TooltipText"] = "Angezeigt im Tooltip"
L["WeightEditor_VersionText"] = "Version %s"


elseif LOCALE == "esES" then -- isaracho (4)
L["Config_Enable_Essences"] = "Esencias de Azerita "
L["Config_Enable_Essences_Desc"] = "Activa %s para las Esencias de Azerita."
L["Config_Enable_Traits"] = "Rasgos de Azerita"
L["Config_Enable_Traits_Desc"] = "Activa %s para los objetos potenciados con Azerita."
L["Config_Importing_ImportingCanUpdate"] = "Importar puede causar que cambien las escalas actuales"
L["Config_Importing_ImportingCanUpdate_Desc"] = "Cunado importes una escala con el mismo nombre, clase y especialización que una existente, la escala existente será actualizada con los nuevos valores en lugar de crear una nueva escala. "
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "Puede haber múltiples escalas con el mismo nombre mientras sean para diferentes especializaciones o clases. "
L["Config_Importing_Title"] = "Importando"
L["Config_Scales_OwnClassCustomsOnly"] = "Mostrar solo tus escalas personalizadas "
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "Mostrar solo tus escalas personalizadas para la clase activa, en lugar de enumerarlas todas."
L["Config_Scales_OwnClassDefaultsOnly"] = "Mostrar solo las propias escalas predeterminadas de clase"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "Mostrar solo las propias escalas predeterminadas de tu propia clase, en lugar de enumerarlas todas."
L["Config_Scales_Title"] = "Lista de escalas "
L["Config_Score_AddItemLevelToScore"] = "Añade itemlevel a todas las puntuaciones"
L["Config_Score_AddItemLevelToScore_Desc"] = "Añade el nivel de objeto de Azerita a todos los cálculos de puntuación actual, potencial actual y puntuación máxima."
L["Config_Score_AddPrimaryStatToScore"] = "Añadir estadísticas primarias a todas las puntuaciones"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Añade la cantidad de objetos de Azerite de estadística primaria (%s/%s/%s) a todos los cálculos de puntuación actual, potencial actual y puntuación máxima."
L["Config_Score_OutlineScores"] = "Bordear puntuaciones"
L["Config_Score_OutlineScores_Desc"] = "Dibuja un borde alrededor de los números de puntaje en los rasgos/esencias de Azerita para que sea más fácil leer los números en los iconos de rasgo/esencia muy claros."
L["Config_Score_PreferBiSMajor"] = "Preferir la mejor esencia principal"
L["Config_Score_PreferBiSMajor_Desc"] = "Escoge siempre la esencia principal de mayor puntuación, incluso cuando a veces podría obtener una mejor puntuación general al no seleccionar la mejor esencia principal. Cuando esta configuración está desactivada, el addon calculará diferentes combinaciones de puntaje y elegirá la mejor puntuación general."
L["Config_Score_RelativeScore"] = "Mostrar en la descripción emergente los valores relativos en lugar de valores absolutos"
L["Config_Score_RelativeScore_Desc"] = "En lugar de mostrar valores absolutos de escalas en la descripción emergente, calcula el valor relativo en comparación con lo equipado actualmente y lo muestra en porcentajes."
L["Config_Score_ScaleByAzeriteEmpowered"] = "Escalar la puntuación del nivel de objeto por el peso de %s en la escala"
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "Al agregar el nivel de objeto a las puntuaciones, usa el peso de %s en la escala para calcular el valor de +1 nivel de objeto en lugar de usar +1 nivel de objeto = +1 en la puntuación."
L["Config_Score_ShowOnlyUpgrades"] = "Mostrar descripción emergente solo para mejoras"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Mostrar valores de escalas en la descripción emergente solo si se trata de una actualización en comparación con el objeto equipado actualmente. Esto funciona solo si los valores relativos están habilitados."
L["Config_Score_ShowTooltipLegend"] = "Mostrar leyenda en la descripción emergente"
L["Config_Score_ShowTooltipLegend_Desc"] = "Mostrar recordatorio para \"Puntuación actual / Potencial actual / Puntuación máxima\" en la descripción emergente."
L["Config_Score_Title"] = "Puntuación"
L["Config_SettingsAddonExplanation"] = "Este addon calcula la \"puntuación actual\", el \"potencial actual\" y la \"puntuación máxima\" para el equipo de Azerita en función de los pesos de la escala seleccionada."
L["Config_SettingsSavedPerChar"] = "Todos estos ajustes se guardan por personaje. Las escalas personalizadas se comparten entre todos los personajes."
L["Config_SettingsScoreExplanation"] = "\"Puntuación actual\" es la suma de los poderes de Azerita actualmente seleccionados en el objeto. El \"Potencial actual\" es la suma de los poderes de Azerita con mayor ponderación de cada nivel al que se tiene acceso en el objeto. La\"Puntuación máxima\" es la suma de los poderes de Azerita con más ponderación de cada nivel, incluidos los bloqueados."
L["Config_WeightEditor_Desc"] = "La siguiente configuración solo afecta a las potencias que se muestran en el editor de pesos. Incluso si los desactivas, todos los poderes de Azerita se puntuarán si tienen un peso establecido en la escala activa."
L["Config_WeightEditor_ShowDefensive"] = "Mostrar poderes defensivos"
L["Config_WeightEditor_ShowDefensive_Desc"] = "Muestra los poderes defensivos comunes y específicos de clase en el editor de pesos."
L["Config_WeightEditor_ShowProfession"] = "Mostrar poderes específicos de la profesión"
L["Config_WeightEditor_ShowProfession_Desc"] = "Muestra los poderes específicos de la profesión en el editor de pesos. Estos poderes solo pueden aparecer en elementos creados con profesiones. Actualmente, solo disponible en objetos para la cabeza de Ingeniería."
L["Config_WeightEditor_ShowPvP"] = "Mostrar poderes específicos de JcJ"
L["Config_WeightEditor_ShowPvP_Desc"] = "Muestra los poderes específicos de PvP en el editor de pesos. Solo verás los poderes de tus propias facciones, pero los cambios que se realicen en ellas se reflejarán en ambas facciones."
L["Config_WeightEditor_ShowPvP_Desc_Import"] = "Al exportar, la cadena de texto solo incluirá los poderes JcJ de tu facción, pero son intercambiables con los \"pvp-powerID\" de facciones opuestas. Al importar cadenas de texto con poderes JcJ solo de una facción, los poderes reflejarán sus pesos en ambas facciones al importar."
L["Config_WeightEditor_ShowRole"] = "Mostrar poderes específicos de especialización"
L["Config_WeightEditor_ShowRole_Desc"] = "Mostrar poderes específicos de especialización en el editor de pesos"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Mostrar poderes específicos de rol solo para mi propia especialización"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Muestra los poderes comunes y actuales de la especialización y rol activa en el editor de pesos. Habilitar esta configuración, por ejemplo, oculta los poderes específicos de los DPS y tanques, a los sanadores, etc..."
L["Config_WeightEditor_ShowZone"] = "Mostrar poderes específicos de las zonas"
L["Config_WeightEditor_ShowZone_Desc"] = "Muestra los poderes específicos de zona en el editor de pesos. Estos poderes solo pueden aparecer en objetos adquiridos en ciertas zonas relacionadas con el poder."
L["Config_WeightEditor_ShowZone_Desc_Proc"] = "Los poderes específicos de zona pueden activarse en todas partes, pero los poderes de banda tienen un efecto secundario que se activará solo dentro de su instancia correspondiente (por ejemplo, el efecto secundario de poderes de Uldir solo se activará dentro de la banda de Uldir). Los poderes de banda están marcados con un asterisco (*) al lado de su nombre en el editor de pesos."
L["Config_WeightEditor_Title"] = "Editor de pesos para escalas"
L["CreatePopup_Desc"] = "Creando nueva escala. Selecciona la clase y la especialización en menú desplegable, luego introduce el nombre para la nueva escala y presione %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "Nueva escala \"%s\" creada"
L["CreatePopup_Error_UnknownError"] = "ERROR: ¡Algo ha ido mal al crear la nueva escala \"%s\"!"
L["CreatePopup_Title"] = "Crear escala"
L["Debug_CopyToBugReport"] = "COPIA Y PEGA el texto encima del informe de errores si crees que es relevante."
L["DefaultScaleName_Default"] = "Por defecto"
L["DefaultScaleName_Defensive"] = "Defensivo"
L["DefaultScaleName_Offensive"] = "Ofensivo"
L["DeletePopup_DeletedDefaultScale"] = "La escala eliminada estaba en uso, se volverá a la opción predeterminada para su clase y especialización."
L["DeletePopup_DeletedScale"] = "Borrar escala \"%s\""
L["DeletePopup_Desc"] = "Borrando escala %1$s Pulsa %2$s para confirmar. Todos los personajes que utilicen esta escala para su especialización serán revertidos a la escala por defecto."
L["DeletePopup_Title"] = "Borrar escala"
L["DeletePopup_Warning"] = "¡Esta acción es permanente y no se puede revertir!"
L["ExportPopup_Desc"] = "Exportando escala %1$s Pulsa %2$sCtrl+C%3$s para copiar el texto y %4$sCtrl+V%5$s para pegarlo donde quieras"
L["ExportPopup_Title"] = "Exportar escala"
L["ImportPopup_CreatedNewScale"] = "Importar nueva escala \"%s\" "
L["ImportPopup_Desc"] = "Importar escala desde texto Pulsa %1$sCtrl+V%2$s para pegar el texto en el cuadro de texto y pulsa %3$s"
L["ImportPopup_Error_MalformedString"] = "ERROR: ¡Texto de importación mal formado!"
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Se esta utilizando una versión antigua o con formato incorrecto del texto de importación, ¡Se intentará importar igualmente como una nueva escala!"
L["ImportPopup_Error_OldStringVersion"] = "ERROR: ¡Se esta utilizando una versión muy antigua o con formato incorrecto del texto de importación! "
L["ImportPopup_Title"] = "Importar escala"
L["ImportPopup_UpdatedScale"] = "Actualizar escala existente \"%s\" "
L["ItemToolTip_AzeriteLevel"] = "Nivel de Azerita: %1$d / %2$d"
L["ItemToolTip_Legend"] = "Puntuación actual / Potencial actual / Puntuación máxima"
L["MassImportPopup_Desc"] = "Importar múltiples escalas a la vez desde texto Pulsa %1$sCtrl+V%2$s para pegar el texto en el cuadro de texto y pulsa %3$s"
L["MassImportPopup_Title"] = "Importar escalas en masa"
L["PowersScoreString"] = "Puntuación actual: %1$s/%2$s Puntuación máxima: %3$s Nivel de Azerita: %4$d/%5$d"
L["PowersTitles_Class"] = "Poderes de clase"
L["PowersTitles_Defensive"] = "Poderes defensivos"
L["PowersTitles_Profession"] = "Poderes de profesión"
L["PowersTitles_PvP"] = "Poderes JcJ"
L["PowersTitles_Role"] = "Poderes de rol"
L["PowersTitles_Zone"] = "Poderes de bandas y zonas"
L["RenamePopup_Desc"] = "Renombrar escala %1$s Introduce el nuevo nombre y pulsa %2$s"
L["RenamePopup_RenamedScale"] = "Escala renombrada de \"%1$s\" a \"%2$s\""
L["RenamePopup_Title"] = "Renombrar escala"
L["ScaleName_Unknown"] = "Desconocido"
L["ScaleName_Unnamed"] = "Sin nombrar"
L["ScalesList_CreateImportText"] = "Crear nueva / Importar"
L["ScalesList_CustomGroupName"] = "Escalas personalizadas"
L["ScalesList_DefaultGroupName"] = "Escalas por defecto"
L["ScaleWeightEditor_Title"] = "%s: Editor de pesos para escalas"
L["Slash_Command"] = "/azerita"
L["Slash_Error_Unkown"] = "ERROR: ¡Algo ha salido mal!"
L["Slash_RemindConfig"] = [=[Accede a ESC -> Interfaz -> AddOns -> %s para configurar.

]=]
L["WeightEditor_CreateNewText"] = "Crear nuevo"
L["WeightEditor_CurrentScale"] = "Escala actual: %s"
L["WeightEditor_DeleteText"] = "Borrar"
L["WeightEditor_EnableScaleText"] = "Usar esta escala"
L["WeightEditor_ExportText"] = "Exportar"
L["WeightEditor_ImportText"] = "Importar"
L["WeightEditor_Major"] = "Mayor"
L["WeightEditor_MassImportText"] = "Importar en masa"
L["WeightEditor_Minor"] = "Menor"
L["WeightEditor_ModeToEssences"] = "Cambiar a esencias"
L["WeightEditor_ModeToTraits"] = "Cambiar a rasgos "
L["WeightEditor_RenameText"] = "Renombrar"
L["WeightEditor_TimestampText_Created"] = "Creado %s"
L["WeightEditor_TimestampText_Imported"] = "Importado %s"
L["WeightEditor_TimestampText_Updated"] = "Actualizado %s"
L["WeightEditor_TooltipText"] = "Mostrar en descripción emergente"
L["WeightEditor_VersionText"] = "Versión %s"


elseif LOCALE == "esMX" then
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate"] = "Importing can update existing scales"
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate_Desc"] = "When importing scale with same name, class and specialization as pre-existing scale, existing scale will be updated with the new weights instead of creating new scale."
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "There can be multiple scales with same name as long as they are for different specializations or classes."
--[[Translation missing --]]
L["Config_Importing_Title"] = "Importing"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly"] = "List own class Custom-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "List Custom-scales for your own class only, instead of listing all of them."
--[[Translation missing --]]
L["Config_Scales_OwnClassDefaultsOnly"] = "List own class Default-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "List Default-scales for your own class only, instead of listing all of them."
--[[Translation missing --]]
L["Config_Scales_Title"] = "Scales list"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore"] = "Add itemlevel to all scores"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore_Desc"] = "Add Azerite items itemlevel to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore"] = "Add primary stat to all scores"
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Add Azerite items amount of primary stat (%s/%s/%s) to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_OutlineScores"] = "Outline Scores"
--[[Translation missing --]]
L["Config_Score_OutlineScores_Desc"] = "Draw small outline around the score-numbers on Azerite traits/essences to make it easier to read the numbers on light trait/essence icons."
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor"] = "Prefer best major essence"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
--[[Translation missing --]]
L["Config_Score_RelativeScore"] = "Show relative values in tooltips instead of absolute values"
--[[Translation missing --]]
L["Config_Score_RelativeScore_Desc"] = "Instead of showing absolute values of scales in tooltips, calculate the relative value compared to currently equipped items and show them in percentages."
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered"] = "Scale itemlevel score by the weight of %s in the scale"
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score."
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades"] = "Show tooltips only for upgrades"
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Show scales values in tooltips only if it is an upgrade compared to currently equipped item. This works only with relative values enabled."
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend"] = "Show legend in tooltips"
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend_Desc"] = "Show reminder for \"Current score / Current potential / Maximum score\" in tooltips."
--[[Translation missing --]]
L["Config_Score_Title"] = "Score"
--[[Translation missing --]]
L["Config_SettingsAddonExplanation"] = "This addon calculates \"Current score\", \"Current potential\" and \"Maximum score\" for Azerite gear based on your selected scale's weights."
--[[Translation missing --]]
L["Config_SettingsSavedPerChar"] = [=[All these settings here are saved per character.
Custom scales are shared between all characters.]=]
--[[Translation missing --]]
L["Config_SettingsScoreExplanation"] = [=["Current score" is the sum of the currently selected Azerite powers in the item.
"Current potential" is the sum of the highest weighted Azerite powers from each tier you have access to in the item.
"Maximum score" is the sum of the highest weighted Azerite powers from each tier, including the locked ones, in the item.]=]
--[[Translation missing --]]
L["Config_WeightEditor_Desc"] = "Following settings only affects the powers shown in the scale weight editor. Even if you disable them, all and any Azerite powers will be still scored if they have weight set to them in the active scale."
--[[Translation missing --]]
L["Config_WeightEditor_ShowDefensive"] = "Show Defensive powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowDefensive_Desc"] = "Show common and class specific Defensive powers in the scale weight editor."
--[[Translation missing --]]
L["Config_WeightEditor_ShowProfession"] = "Show Profession specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowProfession_Desc"] = "Show Profession specific powers in the scale weight editor. These powers can only appear in items created with professions. Currently, these can only appear in Engineering headgear."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP"] = "Show PvP specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc"] = "Show PvP specific powers in the scale weight editor. You'll only see your own factions powers, but changes made to them will be mirrored to both factions."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[When Exporting, the resulting export-string will only include your own factions pvp powers, but they are interchangeable with opposing factions pvp-powerIDs.
When Importing import-string with pvp powers only from one faction, powers will get their weights mirrored to both factions on Import.]=]
--[[Translation missing --]]
L["Config_WeightEditor_ShowRole"] = "Show Role specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRole_Desc"] = "Show Role specific powers in the scale weight editor."
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Show Role specific powers only for my own specializations role"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Show common and current specialization related specific Role specific powers in the scale weight editor. Enabling this setting e.g. hides healer only specific powers from damagers and tanks etc."
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone"] = "Show Zone specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc"] = "Show Zone specific powers in the scale weight editor. These powers can only appear in items acquired in particular zones related to the power."
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[Zone specific powers can activate/proc everywhere, but raid powers have secondary effect which will activate only while inside their related raid instance (e.g. Uldir powers secondary effect will only proc while inside Uldir raid instance).
Raid powers are marked with an asterisk (*) next to their name in the scale weight editor.]=]
--[[Translation missing --]]
L["Config_WeightEditor_Title"] = "Scales weight editor"
--[[Translation missing --]]
L["CreatePopup_Desc"] = "Creating new scale. Select class and specialization from dropdown and then enter name for the new scale and press %1$s"
--[[Translation missing --]]
L["CreatePopup_Error_CreatedNewScale"] = "Created new scale \"%s\""
--[[Translation missing --]]
L["CreatePopup_Error_UnknownError"] = "ERROR: Something went wrong creating new scale \"%s\"!"
--[[Translation missing --]]
L["CreatePopup_Title"] = "Create Scale"
--[[Translation missing --]]
L["Debug_CopyToBugReport"] = "COPY & PASTE the text above to your bug report if you think it is relevant."
--[[Translation missing --]]
L["DefaultScaleName_Default"] = "Default"
--[[Translation missing --]]
L["DefaultScaleName_Defensive"] = "Defensive"
--[[Translation missing --]]
L["DefaultScaleName_Offensive"] = "Offensive"
--[[Translation missing --]]
L["DeletePopup_DeletedDefaultScale"] = "Deleted scale was in use, reverting back to Default-option for your class and specialization!"
--[[Translation missing --]]
L["DeletePopup_DeletedScale"] = "Deleted scale \"%s\""
--[[Translation missing --]]
L["DeletePopup_Desc"] = [=[Deleting scale %1$s
Press %2$s to confirm.
All characters using this scale for their specialization will be reverted back to Default scale.]=]
--[[Translation missing --]]
L["DeletePopup_Title"] = "Delete Scale"
--[[Translation missing --]]
L["DeletePopup_Warning"] = " ! This action is permanent and cannot be reversed ! "
--[[Translation missing --]]
L["ExportPopup_Desc"] = [=[Exporting scale %1$s
Press %2$sCtrl+C%3$s to copy the string and %4$sCtrl+V%5$s to paste it somewhere]=]
--[[Translation missing --]]
L["ExportPopup_Title"] = "Export Scale"
--[[Translation missing --]]
L["ImportPopup_CreatedNewScale"] = "Imported new scale \"%s\""
--[[Translation missing --]]
L["ImportPopup_Desc"] = [=[Importing scale from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["ImportPopup_Error_MalformedString"] = "ERROR: Malformed import string!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringVersion"] = "ERROR: \"Import string\" -version is too old or malformed import string!"
--[[Translation missing --]]
L["ImportPopup_Title"] = "Import Scale"
--[[Translation missing --]]
L["ImportPopup_UpdatedScale"] = "Updated existing scale \"%s\""
--[[Translation missing --]]
L["ItemToolTip_AzeriteLevel"] = "Azerite level: %1$d / %2$d"
--[[Translation missing --]]
L["ItemToolTip_Legend"] = "Current score / Current potential / Maximum score"
--[[Translation missing --]]
L["MassImportPopup_Desc"] = [=[Importing multiple scales at once from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["MassImportPopup_Title"] = "Mass Import Scales"
--[[Translation missing --]]
L["PowersScoreString"] = [=[Current score: %1$s/%2$s
Maximum score: %3$s
Azerite level: %4$d/%5$d]=]
--[[Translation missing --]]
L["PowersTitles_Class"] = "Class Powers"
--[[Translation missing --]]
L["PowersTitles_Defensive"] = "Defensive Powers"
--[[Translation missing --]]
L["PowersTitles_Profession"] = "Profession Powers"
--[[Translation missing --]]
L["PowersTitles_PvP"] = "PvP Powers"
--[[Translation missing --]]
L["PowersTitles_Role"] = "Role Powers"
--[[Translation missing --]]
L["PowersTitles_Zone"] = "Raid and Zone Powers"
--[[Translation missing --]]
L["RenamePopup_Desc"] = [=[Renaming scale %1$s
Enter new name to the editbox and press %2$s]=]
--[[Translation missing --]]
L["RenamePopup_RenamedScale"] = "Renamed scale \"%1$s\" to \"%2$s\""
--[[Translation missing --]]
L["RenamePopup_Title"] = "Rename Scale"
--[[Translation missing --]]
L["ScaleName_Unknown"] = "Unknown"
--[[Translation missing --]]
L["ScaleName_Unnamed"] = "Unnamed"
--[[Translation missing --]]
L["ScalesList_CreateImportText"] = "Create New / Import"
--[[Translation missing --]]
L["ScalesList_CustomGroupName"] = "Custom Scales"
--[[Translation missing --]]
L["ScalesList_DefaultGroupName"] = "Default Scales"
--[[Translation missing --]]
L["ScaleWeightEditor_Title"] = "%s Scale Weight Editor"
--[[Translation missing --]]
L["Slash_Command"] = "/azerite"
--[[Translation missing --]]
L["Slash_Error_Unkown"] = "ERROR: Something went wrong!"
--[[Translation missing --]]
L["Slash_RemindConfig"] = "Check ESC -> Interface -> AddOns -> %s for settings."
--[[Translation missing --]]
L["WeightEditor_CreateNewText"] = "Create New"
--[[Translation missing --]]
L["WeightEditor_CurrentScale"] = "Current scale: %s"
--[[Translation missing --]]
L["WeightEditor_DeleteText"] = "Delete"
--[[Translation missing --]]
L["WeightEditor_EnableScaleText"] = "Use this Scale"
--[[Translation missing --]]
L["WeightEditor_ExportText"] = "Export"
--[[Translation missing --]]
L["WeightEditor_ImportText"] = "Import"
--[[Translation missing --]]
L["WeightEditor_Major"] = "Major"
--[[Translation missing --]]
L["WeightEditor_MassImportText"] = "Mass Import"
--[[Translation missing --]]
L["WeightEditor_Minor"] = "Minor"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
--[[Translation missing --]]
L["WeightEditor_RenameText"] = "Rename"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Created"] = "Created %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Imported"] = "Imported %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Updated"] = "Updated %s"
--[[Translation missing --]]
L["WeightEditor_TooltipText"] = "Show in Tooltips"
--[[Translation missing --]]
L["WeightEditor_VersionText"] = "Version %s"


elseif LOCALE == "frFR" then -- tthegarde (19), Marechoux (9), follower4jas (1)
L["Config_Enable_Essences"] = "Essences d'azérites"
L["Config_Enable_Essences_Desc"] = "Active %s par essences d'azérites"
L["Config_Enable_Traits"] = "Trait d'azérite"
L["Config_Enable_Traits_Desc"] = "Active %s pour les objets dotés d'azérites"
L["Config_Importing_ImportingCanUpdate"] = "L'importation pourra mettre à jour les coefficients existants."
L["Config_Importing_ImportingCanUpdate_Desc"] = "Quand vous importez les coefficients avec les mêmes nom, classe et spécialisation qu'un coefficient prédéfini, celui-ci sera mise à jour avec les nouveaux coefficients au lieu qu'un nouveau coefficient soit créée."
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "Il peut y avoir plusieurs coefficients avec le même nom tant qu'elles sont pour des classes ou spécialisations différentes."
L["Config_Importing_Title"] = "Import"
L["Config_Scales_OwnClassCustomsOnly"] = "Uniquement pour lister ses propres coefficients de classe "
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "Répertorie uniquement les coefficients de votre propre classe, à la place de toutes les énumérer."
L["Config_Scales_OwnClassDefaultsOnly"] = "N'afficher que les coefficients par défaut de votre classe"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "Cache les coefficients par défaut qui ne correspondent pas à votre classe au lieu de toutes les afficher."
L["Config_Scales_Title"] = "Liste des coefficients"
L["Config_Score_AddItemLevelToScore"] = "Ajouter le niveau d'objet à tous les scores"
L["Config_Score_AddItemLevelToScore_Desc"] = "Ajouter le niveau d'objet des objets azéritiques au calcul des scores actuels, potentiels et maximaux."
L["Config_Score_AddPrimaryStatToScore"] = "Ajouter la statistique principale à tous les scores"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Ajoute le montant de la statistique principale de l'objet azérique (%s/%s/%s) à tous les scores actuels, potentiels ainsi qu'au score maximum."
L["Config_Score_OutlineScores"] = "Scores de configuration"
L["Config_Score_OutlineScores_Desc"] = "Tracez un petit contour autour des coefficients sur les traits/essences azéritiques pour faciliter la lecture des valeurs sur les icônes de traits/essences de moindre valeur."
L["Config_Score_PreferBiSMajor"] = "La meilleur essence préféré"
L["Config_Score_PreferBiSMajor_Desc"] = [=[
Choisissez toujours l'essence principale la mieux notée, même si parfois vous pouvez obtenir un meilleur score global en ne sélectionnant pas la meilleure essence majeure. 
Lorsque ce paramètre est désactivé, l'addon calcule quelques combinaisons de score différentes et sélectionne le meilleur score global.]=]
L["Config_Score_RelativeScore"] = "Afficher des valeurs relatives dans les infobulles à la place des valeurs absolues"
L["Config_Score_RelativeScore_Desc"] = "À la place de montrer la valeur absolue des échelles dans les infobulles, calculer la valeur relative comparée aux objets actuellement équipés et les montrer en pourcentage."
L["Config_Score_ScaleByAzeriteEmpowered"] = "Graduation du score du niveau de l'objet par le poids de %s dans le classement"
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "Lors de l'ajout du niveau de l'objet aux scores, le poids %s est utilisé à l'échelonnement pour calculer la valeur de +1 niveau d'objet au lieu d'utiliser +1 niveau de l'objet = score +1."
L["Config_Score_ShowOnlyUpgrades"] = "N'afficher les infobulles que pour les améliorations"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Afficher les valeurs d'échelonnement dans les infobulles uniquement s'il s'agit d'une mise à niveau par rapport à l'objet actuellement équipé. Cela ne fonctionne qu'avec les valeurs relatives activées."
L["Config_Score_ShowTooltipLegend"] = "Afficher la légende dans l'infobulle"
L["Config_Score_ShowTooltipLegend_Desc"] = "Afficher le rappel des \"Score actuel / potentiel / maximal\" dans l'infobulle."
L["Config_Score_Title"] = "Score"
L["Config_SettingsAddonExplanation"] = "Cette addon calcule le \"score courant\", le \"score potentiel\" et le \"score maximum\" pour les équipements d'azérite basé sur votre écart type sélectionné."
L["Config_SettingsSavedPerChar"] = [=[Tous ces réglages sont sauvegardés par personnage.
Les échelles personnalisées sont partagées entre tous vos personnages.]=]
L["Config_SettingsScoreExplanation"] = [=[Le "score courant" est la somme des scores des traits d'azérites sélectionnés dans l'objet.
Le "score potentiel" est la somme des plus haut scores des traits d'azérites pour chaque niveau que vous avez accès dans l'objet.
Le "score maximum" est la somme de tous les plus haut scores d'azérites pour chaque niveau, verrouillés inclus, dans l'objet.]=]
L["Config_WeightEditor_Desc"] = "Les réglages suivants ne concernent que les traits affichés dans l'éditeur d'échelle. Même si vous les désactivez, chaque trait d'Azérite sera quand même évalué si il a une valeur associée dans l'échelle active."
L["Config_WeightEditor_ShowDefensive"] = "Afficher les traits Défensifs"
L["Config_WeightEditor_ShowDefensive_Desc"] = "Affiche les traits Défensifs communs et spécifiques à une classe dans l'éditeur d'échelle."
L["Config_WeightEditor_ShowProfession"] = "Afficher les traits de Profession"
L["Config_WeightEditor_ShowProfession_Desc"] = "Affiche les traits de Profession dans l'éditeur d'échelle. Ces traits n'apparaissent que sur les objets produits par des professions. A l'heure actuelle, ils n'apparaissent que sur les casques d’ingénierie."
L["Config_WeightEditor_ShowPvP"] = "Afficher les traits JcJ"
L["Config_WeightEditor_ShowPvP_Desc"] = "Affiche les traits JcJ dans l'éditeur d'échelle. Vous ne verrez que les traits concernant votre propre faction, mais les changements de valeurs affecteront les traits des deux factions."
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[Lors d'un Export, la chaîne de texte n’inclura que les traits de votre propre faction, mais ils sont interchangeables avec les traits JcJ de la faction opposée.
Lors d'un Import, la valeur des traits JcJ sera appliquée aux deux factions.]=]
L["Config_WeightEditor_ShowRole"] = "Afficher les traits de Rôle"
L["Config_WeightEditor_ShowRole_Desc"] = "Affiche les traits de Rôle dans l'éditeur d'échelle."
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Affiche les traits de Rôle uniquement pour votre spécialisation"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Affiche les pouvoirs communs et spécifiques relatif à votre rôle spécifique dans l'éditeur de score. Active cette option pour cacher les pouvoirs spécifiques du soigneur seulement par exemple de ceux du tank ou du DPS, etc."
L["Config_WeightEditor_ShowZone"] = "Affiche les pouvoirs spécifique à la zone."
L["Config_WeightEditor_ShowZone_Desc"] = "Affiche les pouvoirs spécifiques à la zone dans l'éditeur de mesure de poids. Ces pouvoirs ne peuvent qu'apparaître dans les objets acquis dans des zones particulières liées au pouvoir."
L["Config_WeightEditor_ShowZone_Desc_Proc"] = "Les pouvoirs spécifiques à une zone peuvent être activés / déclenchés partout, mais les pouvoirs de raid ont un effet secondaire qui ne s'activera que dans leur instance de raid associée (par exemple l'effet secondaire des pouvoirs de la zone d'Uldir ne se déclenchera qu'à l'intérieur de l'instance du raid d'Uldir). Les pouvoirs de raid sont marqués d'un astérisque (*) à côté de leur nom dans l'éditeur d'échelle de mesure."
L["Config_WeightEditor_Title"] = "Editeur d'échelle de mesures"
L["CreatePopup_Desc"] = "Création d'une nouvelle échelle. Sélectionné la classe et la spécialisation depuis le menu déroulant et entré le nom pour la nouvelle échelle and appuyer sur %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "Créer une nouvelle échelle \"%s\""
L["CreatePopup_Error_UnknownError"] = "ERREUR: Une erreur s'est produite lors de la création de la nouvelle échelle \"%s\" !"
L["CreatePopup_Title"] = "Créer un échelle"
L["Debug_CopyToBugReport"] = "COPIER/COLLER le texte ci-dessus à votre rapport d'erreur si vous pensez qu'il est pertinent."
L["DefaultScaleName_Default"] = "Défaut"
L["DefaultScaleName_Defensive"] = "Défensif"
L["DefaultScaleName_Offensive"] = "Offensif"
L["DeletePopup_DeletedDefaultScale"] = "L'échelle supprimée était en cours d'utilisation, retour à l'option par défaut pour votre classe et votre spécialisation!"
L["DeletePopup_DeletedScale"] = "Supprimer l'échelle \"%s\""
L["DeletePopup_Desc"] = "Suppression de l'échelle %1$s Appuyez sur %2$s pour confirmer. Tous les personnages utilisant cette échelle pour leur spécialisation retourneront à l'échelle par défaut."
L["DeletePopup_Title"] = "Suppression de l'échelle"
L["DeletePopup_Warning"] = "! Cette action est permanente et ne peut pas être annulée !"
L["ExportPopup_Desc"] = "Exporté l'échelle %1$s Appuyer sur %2$s Ctrl+C %3$s pour copier la phrase et %4$s Ctrl+V %5$s pour la coller ailleurs"
L["ExportPopup_Title"] = "Exporter l'échelle"
L["ImportPopup_CreatedNewScale"] = "Importer la nouvelle échelle \"%s\""
L["ImportPopup_Desc"] = "Importé l'échelle de la phrase Appuyer sur %1$s Ctrl+V %2$s pour coller la phrase dans la boite d'édition et appuyer sur %3$s"
L["ImportPopup_Error_MalformedString"] = "ERREUR: Chaîne d'importation mal formulée"
L["ImportPopup_Error_OldStringRetry"] = "ERREUR: Une ancienne ou une mauvaise version de la \"chaîne importée\" est utilisé, essayer quand même de l'importer comme nouvelle échelle !"
L["ImportPopup_Error_OldStringVersion"] = "ERREUR: La version de la \"chaîne importée\" est plus ancienne ou mauvaise que la chaîne importée !"
L["ImportPopup_Title"] = "Importer l'échelle"
L["ImportPopup_UpdatedScale"] = "Mise à jour de l'échelle \"%s\""
L["ItemToolTip_AzeriteLevel"] = "Niveau d'azérite: %1$d / %2$d"
L["ItemToolTip_Legend"] = "Score actuel / Potentiel actuel / Score maximum"
L["MassImportPopup_Desc"] = "Importation de plusieurs échelles à la fois depuis une chaîne Appuyer sur %1$s Ctrl+V %2$s pour coller la chaîne dans la boîte d'édition et appuyer sur %3$s"
L["MassImportPopup_Title"] = "Importation d'échelles en nombre"
L["PowersScoreString"] = "Score courant: %1$s/%2$s Score maximum: %3$s Niveau d'azérite: %4$s/%5$d"
L["PowersTitles_Class"] = "Pouvoirs de classe"
L["PowersTitles_Defensive"] = "Pouvoirs Défensifs"
L["PowersTitles_Profession"] = "Pouvoirs de métiers"
L["PowersTitles_PvP"] = "Pouvoirs PvP"
L["PowersTitles_Role"] = "Pouvoirs de rôles"
L["PowersTitles_Zone"] = "Pouvoirs de raid et de zone"
L["RenamePopup_Desc"] = "Renommage de l'échelle %1$s Entrer le nouveau nom de l'échelle dans la boîte d'édition et appuyer sur %2$s"
L["RenamePopup_RenamedScale"] = "Renommage de l'échelle \"%1$s\" en \"%2$s\""
L["RenamePopup_Title"] = "Renommer l'échelle"
L["ScaleName_Unknown"] = "Nom inconnu"
L["ScaleName_Unnamed"] = "Sans nom"
L["ScalesList_CreateImportText"] = "Créer Nouveau / Importer"
L["ScalesList_CustomGroupName"] = "Échelles usuelles"
L["ScalesList_DefaultGroupName"] = "Echelle par défaut"
L["ScaleWeightEditor_Title"] = "%s Éditeur d'échelle de mesure"
L["Slash_Command"] = "/azérite"
L["Slash_Error_Unkown"] = "ERREUR: Une erreur est survenue !"
L["Slash_RemindConfig"] = "Aller dans ESC -> Interface -> AddOns -> %s pour les options."
L["WeightEditor_CreateNewText"] = "Créer un nouveau"
L["WeightEditor_CurrentScale"] = "Echelle courante: %s"
L["WeightEditor_DeleteText"] = "Supprimer"
L["WeightEditor_EnableScaleText"] = "Utiliser cette échelle"
L["WeightEditor_ExportText"] = "Exporter"
L["WeightEditor_ImportText"] = "Importer"
L["WeightEditor_Major"] = "Majeur"
L["WeightEditor_MassImportText"] = "Importation en nombre"
L["WeightEditor_Minor"] = "Mineur"
L["WeightEditor_ModeToEssences"] = "Changement en essences"
L["WeightEditor_ModeToTraits"] = "Changement en traits"
L["WeightEditor_RenameText"] = "Renommer"
L["WeightEditor_TimestampText_Created"] = "Créé le %s"
L["WeightEditor_TimestampText_Imported"] = "Importé le %s"
L["WeightEditor_TimestampText_Updated"] = "Mise à jour le %s"
L["WeightEditor_TooltipText"] = "Afficher dans les info-bulles"
L["WeightEditor_VersionText"] = "Version %s"


elseif LOCALE == "itIT" then
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate"] = "Importing can update existing scales"
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate_Desc"] = "When importing scale with same name, class and specialization as pre-existing scale, existing scale will be updated with the new weights instead of creating new scale."
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "There can be multiple scales with same name as long as they are for different specializations or classes."
--[[Translation missing --]]
L["Config_Importing_Title"] = "Importing"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly"] = "List own class Custom-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "List Custom-scales for your own class only, instead of listing all of them."
--[[Translation missing --]]
L["Config_Scales_OwnClassDefaultsOnly"] = "List own class Default-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "List Default-scales for your own class only, instead of listing all of them."
--[[Translation missing --]]
L["Config_Scales_Title"] = "Scales list"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore"] = "Add itemlevel to all scores"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore_Desc"] = "Add Azerite items itemlevel to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore"] = "Add primary stat to all scores"
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Add Azerite items amount of primary stat (%s/%s/%s) to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_OutlineScores"] = "Outline Scores"
--[[Translation missing --]]
L["Config_Score_OutlineScores_Desc"] = "Draw small outline around the score-numbers on Azerite traits/essences to make it easier to read the numbers on light trait/essence icons."
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor"] = "Prefer best major essence"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
--[[Translation missing --]]
L["Config_Score_RelativeScore"] = "Show relative values in tooltips instead of absolute values"
--[[Translation missing --]]
L["Config_Score_RelativeScore_Desc"] = "Instead of showing absolute values of scales in tooltips, calculate the relative value compared to currently equipped items and show them in percentages."
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered"] = "Scale itemlevel score by the weight of %s in the scale"
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score."
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades"] = "Show tooltips only for upgrades"
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Show scales values in tooltips only if it is an upgrade compared to currently equipped item. This works only with relative values enabled."
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend"] = "Show legend in tooltips"
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend_Desc"] = "Show reminder for \"Current score / Current potential / Maximum score\" in tooltips."
--[[Translation missing --]]
L["Config_Score_Title"] = "Score"
--[[Translation missing --]]
L["Config_SettingsAddonExplanation"] = "This addon calculates \"Current score\", \"Current potential\" and \"Maximum score\" for Azerite gear based on your selected scale's weights."
--[[Translation missing --]]
L["Config_SettingsSavedPerChar"] = [=[All these settings here are saved per character.
Custom scales are shared between all characters.]=]
--[[Translation missing --]]
L["Config_SettingsScoreExplanation"] = [=["Current score" is the sum of the currently selected Azerite powers in the item.
"Current potential" is the sum of the highest weighted Azerite powers from each tier you have access to in the item.
"Maximum score" is the sum of the highest weighted Azerite powers from each tier, including the locked ones, in the item.]=]
--[[Translation missing --]]
L["Config_WeightEditor_Desc"] = "Following settings only affects the powers shown in the scale weight editor. Even if you disable them, all and any Azerite powers will be still scored if they have weight set to them in the active scale."
--[[Translation missing --]]
L["Config_WeightEditor_ShowDefensive"] = "Show Defensive powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowDefensive_Desc"] = "Show common and class specific Defensive powers in the scale weight editor."
--[[Translation missing --]]
L["Config_WeightEditor_ShowProfession"] = "Show Profession specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowProfession_Desc"] = "Show Profession specific powers in the scale weight editor. These powers can only appear in items created with professions. Currently, these can only appear in Engineering headgear."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP"] = "Show PvP specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc"] = "Show PvP specific powers in the scale weight editor. You'll only see your own factions powers, but changes made to them will be mirrored to both factions."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[When Exporting, the resulting export-string will only include your own factions pvp powers, but they are interchangeable with opposing factions pvp-powerIDs.
When Importing import-string with pvp powers only from one faction, powers will get their weights mirrored to both factions on Import.]=]
--[[Translation missing --]]
L["Config_WeightEditor_ShowRole"] = "Show Role specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRole_Desc"] = "Show Role specific powers in the scale weight editor."
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Show Role specific powers only for my own specializations role"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Show common and current specialization related specific Role specific powers in the scale weight editor. Enabling this setting e.g. hides healer only specific powers from damagers and tanks etc."
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone"] = "Show Zone specific powers"
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc"] = "Show Zone specific powers in the scale weight editor. These powers can only appear in items acquired in particular zones related to the power."
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[Zone specific powers can activate/proc everywhere, but raid powers have secondary effect which will activate only while inside their related raid instance (e.g. Uldir powers secondary effect will only proc while inside Uldir raid instance).
Raid powers are marked with an asterisk (*) next to their name in the scale weight editor.]=]
--[[Translation missing --]]
L["Config_WeightEditor_Title"] = "Scales weight editor"
--[[Translation missing --]]
L["CreatePopup_Desc"] = "Creating new scale. Select class and specialization from dropdown and then enter name for the new scale and press %1$s"
--[[Translation missing --]]
L["CreatePopup_Error_CreatedNewScale"] = "Created new scale \"%s\""
--[[Translation missing --]]
L["CreatePopup_Error_UnknownError"] = "ERROR: Something went wrong creating new scale \"%s\"!"
--[[Translation missing --]]
L["CreatePopup_Title"] = "Create Scale"
--[[Translation missing --]]
L["Debug_CopyToBugReport"] = "COPY & PASTE the text above to your bug report if you think it is relevant."
--[[Translation missing --]]
L["DefaultScaleName_Default"] = "Default"
--[[Translation missing --]]
L["DefaultScaleName_Defensive"] = "Defensive"
--[[Translation missing --]]
L["DefaultScaleName_Offensive"] = "Offensive"
--[[Translation missing --]]
L["DeletePopup_DeletedDefaultScale"] = "Deleted scale was in use, reverting back to Default-option for your class and specialization!"
--[[Translation missing --]]
L["DeletePopup_DeletedScale"] = "Deleted scale \"%s\""
--[[Translation missing --]]
L["DeletePopup_Desc"] = [=[Deleting scale %1$s
Press %2$s to confirm.
All characters using this scale for their specialization will be reverted back to Default scale.]=]
--[[Translation missing --]]
L["DeletePopup_Title"] = "Delete Scale"
--[[Translation missing --]]
L["DeletePopup_Warning"] = " ! This action is permanent and cannot be reversed ! "
--[[Translation missing --]]
L["ExportPopup_Desc"] = [=[Exporting scale %1$s
Press %2$sCtrl+C%3$s to copy the string and %4$sCtrl+V%5$s to paste it somewhere]=]
--[[Translation missing --]]
L["ExportPopup_Title"] = "Export Scale"
--[[Translation missing --]]
L["ImportPopup_CreatedNewScale"] = "Imported new scale \"%s\""
--[[Translation missing --]]
L["ImportPopup_Desc"] = [=[Importing scale from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["ImportPopup_Error_MalformedString"] = "ERROR: Malformed import string!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringVersion"] = "ERROR: \"Import string\" -version is too old or malformed import string!"
--[[Translation missing --]]
L["ImportPopup_Title"] = "Import Scale"
--[[Translation missing --]]
L["ImportPopup_UpdatedScale"] = "Updated existing scale \"%s\""
--[[Translation missing --]]
L["ItemToolTip_AzeriteLevel"] = "Azerite level: %1$d / %2$d"
--[[Translation missing --]]
L["ItemToolTip_Legend"] = "Current score / Current potential / Maximum score"
--[[Translation missing --]]
L["MassImportPopup_Desc"] = [=[Importing multiple scales at once from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["MassImportPopup_Title"] = "Mass Import Scales"
--[[Translation missing --]]
L["PowersScoreString"] = [=[Current score: %1$s/%2$s
Maximum score: %3$s
Azerite level: %4$d/%5$d]=]
--[[Translation missing --]]
L["PowersTitles_Class"] = "Class Powers"
--[[Translation missing --]]
L["PowersTitles_Defensive"] = "Defensive Powers"
--[[Translation missing --]]
L["PowersTitles_Profession"] = "Profession Powers"
--[[Translation missing --]]
L["PowersTitles_PvP"] = "PvP Powers"
--[[Translation missing --]]
L["PowersTitles_Role"] = "Role Powers"
--[[Translation missing --]]
L["PowersTitles_Zone"] = "Raid and Zone Powers"
--[[Translation missing --]]
L["RenamePopup_Desc"] = [=[Renaming scale %1$s
Enter new name to the editbox and press %2$s]=]
--[[Translation missing --]]
L["RenamePopup_RenamedScale"] = "Renamed scale \"%1$s\" to \"%2$s\""
--[[Translation missing --]]
L["RenamePopup_Title"] = "Rename Scale"
--[[Translation missing --]]
L["ScaleName_Unknown"] = "Unknown"
--[[Translation missing --]]
L["ScaleName_Unnamed"] = "Unnamed"
--[[Translation missing --]]
L["ScalesList_CreateImportText"] = "Create New / Import"
--[[Translation missing --]]
L["ScalesList_CustomGroupName"] = "Custom Scales"
--[[Translation missing --]]
L["ScalesList_DefaultGroupName"] = "Default Scales"
--[[Translation missing --]]
L["ScaleWeightEditor_Title"] = "%s Scale Weight Editor"
--[[Translation missing --]]
L["Slash_Command"] = "/azerite"
--[[Translation missing --]]
L["Slash_Error_Unkown"] = "ERROR: Something went wrong!"
--[[Translation missing --]]
L["Slash_RemindConfig"] = "Check ESC -> Interface -> AddOns -> %s for settings."
--[[Translation missing --]]
L["WeightEditor_CreateNewText"] = "Create New"
--[[Translation missing --]]
L["WeightEditor_CurrentScale"] = "Current scale: %s"
--[[Translation missing --]]
L["WeightEditor_DeleteText"] = "Delete"
--[[Translation missing --]]
L["WeightEditor_EnableScaleText"] = "Use this Scale"
--[[Translation missing --]]
L["WeightEditor_ExportText"] = "Export"
--[[Translation missing --]]
L["WeightEditor_ImportText"] = "Import"
--[[Translation missing --]]
L["WeightEditor_Major"] = "Major"
--[[Translation missing --]]
L["WeightEditor_MassImportText"] = "Mass Import"
--[[Translation missing --]]
L["WeightEditor_Minor"] = "Minor"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
--[[Translation missing --]]
L["WeightEditor_RenameText"] = "Rename"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Created"] = "Created %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Imported"] = "Imported %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Updated"] = "Updated %s"
--[[Translation missing --]]
L["WeightEditor_TooltipText"] = "Show in Tooltips"
--[[Translation missing --]]
L["WeightEditor_VersionText"] = "Version %s"


elseif LOCALE == "koKR" then -- Killberos (52)
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
L["Config_Importing_ImportingCanUpdate"] = "불러오기로 현재 값을 갱신합니다"
L["Config_Importing_ImportingCanUpdate_Desc"] = "같은 이름으로 값을 불러올경우, 이미 존재하는 직업과 전문화 값들은 새로운 값으로 만들어 지는 대신에, 갱신 될것 입니다."
--[[Translation missing --]]
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "There can be multiple scales with same name as long as they are for different specializations or classes."
L["Config_Importing_Title"] = "불러오기"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly"] = "List own class Custom-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "List Custom-scales for your own class only, instead of listing all of them."
L["Config_Scales_OwnClassDefaultsOnly"] = "자신 직업의 기본값만 표시"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "모든 직업들의 기본값을 표시하는 대신에, 자신 직업에만 해당되는 기본값을 표시합니다."
L["Config_Scales_Title"] = "값 목록"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore"] = "Add itemlevel to all scores"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore_Desc"] = "Add Azerite items itemlevel to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore"] = "Add primary stat to all scores"
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Add Azerite items amount of primary stat (%s/%s/%s) to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_OutlineScores"] = "Outline Scores"
--[[Translation missing --]]
L["Config_Score_OutlineScores_Desc"] = "Draw small outline around the score-numbers on Azerite traits/essences to make it easier to read the numbers on light trait/essence icons."
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor"] = "Prefer best major essence"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
--[[Translation missing --]]
L["Config_Score_RelativeScore"] = "Show relative values in tooltips instead of absolute values"
--[[Translation missing --]]
L["Config_Score_RelativeScore_Desc"] = "Instead of showing absolute values of scales in tooltips, calculate the relative value compared to currently equipped items and show them in percentages."
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered"] = "Scale itemlevel score by the weight of %s in the scale"
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score."
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades"] = "Show tooltips only for upgrades"
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Show scales values in tooltips only if it is an upgrade compared to currently equipped item. This works only with relative values enabled."
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend"] = "Show legend in tooltips"
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend_Desc"] = "Show reminder for \"Current score / Current potential / Maximum score\" in tooltips."
--[[Translation missing --]]
L["Config_Score_Title"] = "Score"
--[[Translation missing --]]
L["Config_SettingsAddonExplanation"] = "This addon calculates \"Current score\", \"Current potential\" and \"Maximum score\" for Azerite gear based on your selected scale's weights."
L["Config_SettingsSavedPerChar"] = [=[이 곳에 모든 설정은 캐릭터별로 저장됩니다.
사용자 값은 모든 캐릭터에게 공유됩니다.]=]
--[[Translation missing --]]
L["Config_SettingsScoreExplanation"] = [=["Current score" is the sum of the currently selected Azerite powers in the item.
"Current potential" is the sum of the highest weighted Azerite powers from each tier you have access to in the item.
"Maximum score" is the sum of the highest weighted Azerite powers from each tier, including the locked ones, in the item.]=]
--[[Translation missing --]]
L["Config_WeightEditor_Desc"] = "Following settings only affects the powers shown in the scale weight editor. Even if you disable them, all and any Azerite powers will be still scored if they have weight set to them in the active scale."
L["Config_WeightEditor_ShowDefensive"] = "방어적 능력들 표시 "
--[[Translation missing --]]
L["Config_WeightEditor_ShowDefensive_Desc"] = "Show common and class specific Defensive powers in the scale weight editor."
L["Config_WeightEditor_ShowProfession"] = "특정 전문 능력들 표시"
L["Config_WeightEditor_ShowProfession_Desc"] = [=[가중치 편집기 안에 있는 특정 전문 능력들을 표시합니다. 
이 능력들은 전문기술로 만들어진 아이템에서만 나타납니다. 현재 기계공학 머리부위에서만
나타납니다.]=]
L["Config_WeightEditor_ShowPvP"] = "PvP 전용 능력 보기"
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc"] = "Show PvP specific powers in the scale weight editor. You'll only see your own factions powers, but changes made to them will be mirrored to both factions."
--[[Translation missing --]]
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[When Exporting, the resulting export-string will only include your own factions pvp powers, but they are interchangeable with opposing factions pvp-powerIDs.
When Importing import-string with pvp powers only from one faction, powers will get their weights mirrored to both factions on Import.]=]
L["Config_WeightEditor_ShowRole"] = "직업별 능력들 표시"
L["Config_WeightEditor_ShowRole_Desc"] = "가중치 편집기 안에 있는 직업별 능력들을 표시합니다."
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Show Role specific powers only for my own specializations role"
--[[Translation missing --]]
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Show common and current specialization related specific Role specific powers in the scale weight editor. Enabling this setting e.g. hides healer only specific powers from damagers and tanks etc."
L["Config_WeightEditor_ShowZone"] = "특정 지역 능력"
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc"] = "Show Zone specific powers in the scale weight editor. These powers can only appear in items acquired in particular zones related to the power."
--[[Translation missing --]]
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[Zone specific powers can activate/proc everywhere, but raid powers have secondary effect which will activate only while inside their related raid instance (e.g. Uldir powers secondary effect will only proc while inside Uldir raid instance).
Raid powers are marked with an asterisk (*) next to their name in the scale weight editor.]=]
L["Config_WeightEditor_Title"] = "가중치 편집기"
--[[Translation missing --]]
L["CreatePopup_Desc"] = "Creating new scale. Select class and specialization from dropdown and then enter name for the new scale and press %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "만들어진 새로운 값 \"%s\""
--[[Translation missing --]]
L["CreatePopup_Error_UnknownError"] = "ERROR: Something went wrong creating new scale \"%s\"!"
L["CreatePopup_Title"] = "값 만들기"
--[[Translation missing --]]
L["Debug_CopyToBugReport"] = "COPY & PASTE the text above to your bug report if you think it is relevant."
L["DefaultScaleName_Default"] = "기본적"
L["DefaultScaleName_Defensive"] = "방어적"
L["DefaultScaleName_Offensive"] = "공격적"
--[[Translation missing --]]
L["DeletePopup_DeletedDefaultScale"] = "Deleted scale was in use, reverting back to Default-option for your class and specialization!"
L["DeletePopup_DeletedScale"] = "\"%s\"  값이 삭제 되었습니다."
--[[Translation missing --]]
L["DeletePopup_Desc"] = [=[Deleting scale %1$s
Press %2$s to confirm.
All characters using this scale for their specialization will be reverted back to Default scale.]=]
L["DeletePopup_Title"] = "값 삭제하기 "
--[[Translation missing --]]
L["DeletePopup_Warning"] = " ! This action is permanent and cannot be reversed ! "
--[[Translation missing --]]
L["ExportPopup_Desc"] = [=[Exporting scale %1$s
Press %2$sCtrl+C%3$s to copy the string and %4$sCtrl+V%5$s to paste it somewhere]=]
L["ExportPopup_Title"] = "값 내보내기"
L["ImportPopup_CreatedNewScale"] = "\"%s\" 새로운 값이 입력되었습니다. "
--[[Translation missing --]]
L["ImportPopup_Desc"] = [=[Importing scale from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
L["ImportPopup_Error_MalformedString"] = "에러: 형식에 맞지 않아 불러올 수 없습니다!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
--[[Translation missing --]]
L["ImportPopup_Error_OldStringVersion"] = "ERROR: \"Import string\" -version is too old or malformed import string!"
L["ImportPopup_Title"] = "값 불러오기 "
L["ImportPopup_UpdatedScale"] = "\"%s\" 현재 값이 갱신 되었습니다."
L["ItemToolTip_AzeriteLevel"] = "아제라이트 레벨: %1$d / %2$d "
--[[Translation missing --]]
L["ItemToolTip_Legend"] = "Current score / Current potential / Maximum score"
--[[Translation missing --]]
L["MassImportPopup_Desc"] = [=[Importing multiple scales at once from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["MassImportPopup_Title"] = "Mass Import Scales"
L["PowersScoreString"] = [=[현재 점수: %1$s/%2$s
최고 점수: %3$s
아제라이트 레벨: %4$d/%5$d]=]
L["PowersTitles_Class"] = "직업 능력들"
L["PowersTitles_Defensive"] = "방어적 능력들"
L["PowersTitles_Profession"] = "전문기술 능력들"
L["PowersTitles_PvP"] = "PvP 능력들"
--[[Translation missing --]]
L["PowersTitles_Role"] = "Role Powers"
L["PowersTitles_Zone"] = "레이드와 지역 능력들 "
--[[Translation missing --]]
L["RenamePopup_Desc"] = [=[Renaming scale %1$s
Enter new name to the editbox and press %2$s]=]
L["RenamePopup_RenamedScale"] = "\"%1$s\" 에서 \"%2$s\" 으로 값 이름이 변경되었습니다."
L["RenamePopup_Title"] = "값 이름바꾸기 "
L["ScaleName_Unknown"] = "알수없음 "
L["ScaleName_Unnamed"] = "이름없음"
L["ScalesList_CreateImportText"] = "새로만들기 / 불러오기"
L["ScalesList_CustomGroupName"] = "사용자값들"
L["ScalesList_DefaultGroupName"] = "기본값들 "
L["ScaleWeightEditor_Title"] = "%s 가중치 편집기 "
L["Slash_Command"] = "/아제라이트 "
L["Slash_Error_Unkown"] = "에러: 무언가 잘못되었습니다! "
--[[Translation missing --]]
L["Slash_RemindConfig"] = "Check ESC -> Interface -> AddOns -> %s for settings."
L["WeightEditor_CreateNewText"] = "새로 만들기  "
L["WeightEditor_CurrentScale"] = "현재 값: %s "
L["WeightEditor_DeleteText"] = "삭제 "
L["WeightEditor_EnableScaleText"] = "이 값을 사용 "
L["WeightEditor_ExportText"] = "내보내기"
L["WeightEditor_ImportText"] = "불러오기 "
--[[Translation missing --]]
L["WeightEditor_Major"] = "Major"
--[[Translation missing --]]
L["WeightEditor_MassImportText"] = "Mass Import"
--[[Translation missing --]]
L["WeightEditor_Minor"] = "Minor"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
L["WeightEditor_RenameText"] = "이름 바꾸기 "
--[[Translation missing --]]
L["WeightEditor_TimestampText_Created"] = "Created %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Imported"] = "Imported %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Updated"] = "Updated %s"
L["WeightEditor_TooltipText"] = "툴팁에 표시하기 "
L["WeightEditor_VersionText"] = "버전 %s "


elseif LOCALE == "ptBR" then -- mariogusman (73)
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
L["Config_Importing_ImportingCanUpdate"] = "Importar pode atualizar pesos já existentes"
L["Config_Importing_ImportingCanUpdate_Desc"] = "Ao importar pesos com o mesmo nome, a configuração existente será atualizada com os novos pesos em vez de criar uma nova."
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "Você pode ter vários pesos com o mesmo nome, desde que sejam para diferentes especializações ou classes."
L["Config_Importing_Title"] = "Importando "
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly"] = "List own class Custom-scales only"
--[[Translation missing --]]
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "List Custom-scales for your own class only, instead of listing all of them."
L["Config_Scales_OwnClassDefaultsOnly"] = "Listar apenas os Pesos Padrão da sua classe"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "Lista apenas os Pesos Padrão da sua classe, ao invés de listar todos."
L["Config_Scales_Title"] = "Lista de Pesos"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore"] = "Add itemlevel to all scores"
--[[Translation missing --]]
L["Config_Score_AddItemLevelToScore_Desc"] = "Add Azerite items itemlevel to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore"] = "Add primary stat to all scores"
--[[Translation missing --]]
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Add Azerite items amount of primary stat (%s/%s/%s) to all current score, current potential and maximum score calculations."
--[[Translation missing --]]
L["Config_Score_OutlineScores"] = "Outline Scores"
--[[Translation missing --]]
L["Config_Score_OutlineScores_Desc"] = "Draw small outline around the score-numbers on Azerite traits/essences to make it easier to read the numbers on light trait/essence icons."
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor"] = "Prefer best major essence"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
--[[Translation missing --]]
L["Config_Score_RelativeScore"] = "Show relative values in tooltips instead of absolute values"
--[[Translation missing --]]
L["Config_Score_RelativeScore_Desc"] = "Instead of showing absolute values of scales in tooltips, calculate the relative value compared to currently equipped items and show them in percentages."
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered"] = "Scale itemlevel score by the weight of %s in the scale"
--[[Translation missing --]]
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "When adding itemlevel to the scores, use the weight of %s of the scale to calculate value of +1 itemlevel instead of using +1 itemlevel = +1 score."
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades"] = "Show tooltips only for upgrades"
--[[Translation missing --]]
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Show scales values in tooltips only if it is an upgrade compared to currently equipped item. This works only with relative values enabled."
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend"] = "Show legend in tooltips"
--[[Translation missing --]]
L["Config_Score_ShowTooltipLegend_Desc"] = "Show reminder for \"Current score / Current potential / Maximum score\" in tooltips."
--[[Translation missing --]]
L["Config_Score_Title"] = "Score"
--[[Translation missing --]]
L["Config_SettingsAddonExplanation"] = "This addon calculates \"Current score\", \"Current potential\" and \"Maximum score\" for Azerite gear based on your selected scale's weights."
L["Config_SettingsSavedPerChar"] = [=[Todas as configurações aqui são salvas individualmente por personagem.
Pesos personalizadas são compartilhados entre todos os personagens.]=]
--[[Translation missing --]]
L["Config_SettingsScoreExplanation"] = [=["Current score" is the sum of the currently selected Azerite powers in the item.
"Current potential" is the sum of the highest weighted Azerite powers from each tier you have access to in the item.
"Maximum score" is the sum of the highest weighted Azerite powers from each tier, including the locked ones, in the item.]=]
L["Config_WeightEditor_Desc"] = "As configurações a seguir afetam apenas os poderes mostrados no editor de pesos. Mesmo se você desativá-los, todos os poderes de Azerita ainda serão marcados se tiverem peso definido para eles na escala ativa."
L["Config_WeightEditor_ShowDefensive"] = "Mostrar poderes defensivos"
L["Config_WeightEditor_ShowDefensive_Desc"] = "Mostrar poderes defensivos genéricos e específicos da classe no editor de pesos de escala"
L["Config_WeightEditor_ShowProfession"] = "Mostrar poderes específicos de profissão"
L["Config_WeightEditor_ShowProfession_Desc"] = "Mostrar poderes específicos de profissão no editor de pesos. Esses poderes só podem aparecer em itens criados com profissões. Por hora, estes só podem aparecer nos Capacetes criados com Engenharia."
L["Config_WeightEditor_ShowPvP"] = "Mostrar poderes específicos de JxJ (PvP)"
L["Config_WeightEditor_ShowPvP_Desc"] = "Mostra poderes específicos de JxJ (PvP) no editor de pesos. Você só verá os poderes da sua própria facção, mas as mudanças feitas a estes pesos serão refletidas para ambas as facções."
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[Ao exportar, a Linha de Expostação incluirá apenas os poderes JxJ (PvP) de sua próprias facção, mas eles são alternaveis com os pvp-powerIDs da facção oposta.
Ao importar uma configuração com poderes JxJ(PvP) de uma das facções, os poderes terão seus pesos espelhados para ambas as facções.]=]
L["Config_WeightEditor_ShowRole"] = "Mostrar poderes específicos de Função"
L["Config_WeightEditor_ShowRole_Desc"] = "Mostrar poderes específicos de função no editor de pesos."
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Mostrar poderes específicos de função apenas para minha própria especialização"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Mostrar poderes específicos da especialização atual no editor de pesos. Ativando esta opção, por exemplo, esconderá pesos e poderes específicos para Curandeiros(Healers) caso você seja um Tank ou DPS."
L["Config_WeightEditor_ShowZone"] = "Mostrar poderes específicos da zona"
L["Config_WeightEditor_ShowZone_Desc"] = "Mostrar poderes específicos da Zona no editor de pesos. Esses poderes só podem aparecer em itens adquiridos em zonas específicas relacionadas ao poder."
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[Poderes específicos da zonas normais podem ativar/procar em todos os lugares, mas os poderes de Raid só serão ativados enquanto você estiver dentro de Raid relacionada (por exemplo, os poderes Uldir somente serão ativados dentro da raid Uldir).
Poderes específicos de Raid estão marcados com um asterisco (*) ao lado do nome no editor de pesos.]=]
L["Config_WeightEditor_Title"] = "Editor de pesos"
L["CreatePopup_Desc"] = "Criando nova configuração. Selecione a Classe e Especialização no menu e então digite o nome da nova configuração e pressione %1$s."
L["CreatePopup_Error_CreatedNewScale"] = "Nova configuração \"%s\" criada!"
L["CreatePopup_Error_UnknownError"] = "ERRO:  Algo de errado aconteceu ao criar a configuração \"%s\"!"
L["CreatePopup_Title"] = "Criar configuração"
--[[Translation missing --]]
L["Debug_CopyToBugReport"] = "COPY & PASTE the text above to your bug report if you think it is relevant."
L["DefaultScaleName_Default"] = "Padrão"
L["DefaultScaleName_Defensive"] = "Defensivos"
L["DefaultScaleName_Offensive"] = "Ofensivos"
L["DeletePopup_DeletedDefaultScale"] = "A Configuração excluída estava em uso, portanto a configuração Padrão foi ativada para sua classe e especialização!"
L["DeletePopup_DeletedScale"] = "Excluir configuração \"%s\"."
L["DeletePopup_Desc"] = [=[Excluindo configuração %1$s!
Pressione %2$s para confirmar.
Todos os personagens utilizando esta configuração para suas especializações terão seus pesos revertidos para a configuração Padrão.]=]
L["DeletePopup_Title"] = "Excluir configuração"
L["DeletePopup_Warning"] = "! Esta ação é permanente e NÃO pode ser revertida !"
L["ExportPopup_Desc"] = [=[Exportando configuração %1$s!
Pressione %2$sCtrl+C%3$s para copiar a Linha de Código e %4$sCtrl+V%5$s para colá-a em outro lugar.]=]
L["ExportPopup_Title"] = "Exportar configuração"
L["ImportPopup_CreatedNewScale"] = "Nova configuração \"%s\" importada."
L["ImportPopup_Desc"] = [=[Importando configuração à partir do código...
Pressione %1$sCtrl+V%2$s para colar o código na caixa de edição e pressione %3$s.]=]
L["ImportPopup_Error_MalformedString"] = "ERRO: Código de importação errado ou imcompleto."
--[[Translation missing --]]
L["ImportPopup_Error_OldStringRetry"] = "ERROR: Old or malformed \"Import string\" -version is used, trying to import it anyway as a new scale!"
L["ImportPopup_Error_OldStringVersion"] = "ERRO: \"Código de Importação\" -Versão muito antiga ou com problemas no código!"
L["ImportPopup_Title"] = "Importar configuração"
L["ImportPopup_UpdatedScale"] = "Escala existente \"%s\" atualizada"
L["ItemToolTip_AzeriteLevel"] = "Nível de Azerita: %1$d / %2$d"
--[[Translation missing --]]
L["ItemToolTip_Legend"] = "Current score / Current potential / Maximum score"
--[[Translation missing --]]
L["MassImportPopup_Desc"] = [=[Importing multiple scales at once from string
Press %1$sCtrl+V%2$s to paste string to the editbox and press %3$s]=]
--[[Translation missing --]]
L["MassImportPopup_Title"] = "Mass Import Scales"
L["PowersScoreString"] = [=[Pontuação Atual: %1$s/%2$s
Pontuação Máxima: %3$s
Nível de Azerita: %4$d/%5$d]=]
L["PowersTitles_Class"] = "Poderes de Classe"
L["PowersTitles_Defensive"] = "Poderes Defensivos"
L["PowersTitles_Profession"] = "Poderes de Profissão"
L["PowersTitles_PvP"] = "Poderes de JxJ(PvP)"
L["PowersTitles_Role"] = "Poderes de Função"
L["PowersTitles_Zone"] = "Poderes de Zona e Raid"
L["RenamePopup_Desc"] = [=[Renomeando configuração %1$s
Insira um novo nome na caixa de texto e precione %2$s]=]
L["RenamePopup_RenamedScale"] = "Configuração renomeada de \"%1$s\" para \"%2$s\""
L["RenamePopup_Title"] = "Renomear configuração"
L["ScaleName_Unknown"] = "Desconhecido"
L["ScaleName_Unnamed"] = "Sem nome"
L["ScalesList_CreateImportText"] = "Criar Nova ou Importar"
L["ScalesList_CustomGroupName"] = "Pesos Personalizados"
L["ScalesList_DefaultGroupName"] = "Pesos Padrão"
L["ScaleWeightEditor_Title"] = "%s Editor de Pesos"
L["Slash_Command"] = "/azerite"
L["Slash_Error_Unkown"] = "ERRO: Algo de errado aconteceu!"
L["Slash_RemindConfig"] = "Vá até ESC -> Interface -> AddOns -> %s para ver as configurações."
L["WeightEditor_CreateNewText"] = "Criar Novo"
L["WeightEditor_CurrentScale"] = "Configuração atual: %s"
L["WeightEditor_DeleteText"] = "Deletar"
L["WeightEditor_EnableScaleText"] = "Usar esta configuração"
L["WeightEditor_ExportText"] = "Exoprtar"
L["WeightEditor_ImportText"] = "Importar"
--[[Translation missing --]]
L["WeightEditor_Major"] = "Major"
--[[Translation missing --]]
L["WeightEditor_MassImportText"] = "Mass Import"
--[[Translation missing --]]
L["WeightEditor_Minor"] = "Minor"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
L["WeightEditor_RenameText"] = "Renomear"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Created"] = "Created %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Imported"] = "Imported %s"
--[[Translation missing --]]
L["WeightEditor_TimestampText_Updated"] = "Updated %s"
L["WeightEditor_TooltipText"] = "Mostrar na descrição dos itens"
L["WeightEditor_VersionText"] = "Versão %s"


elseif LOCALE == "ruRU" then -- dartraiden (78), Hubbotu (18), rtim0905 (0), Wolfeg (1), lorientalas (1)
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
L["Config_Importing_ImportingCanUpdate"] = "Обновлять уже существующие наборы при импорте"
L["Config_Importing_ImportingCanUpdate_Desc"] = "При импорте набора, совпадающего с существующим по имени, классу и специализации, вместо создания нового набора будет обновлён уже существующий набор."
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "Допустимы наборы с одинаковыми названиями, если они предназначены для разных специализаций или классов."
L["Config_Importing_Title"] = "Импорт"
L["Config_Scales_OwnClassCustomsOnly"] = "Показывать собственные наборы, предназначанные лишь для моего класса"
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "Показывать не все собственные наборы, а только подходящие для вашего класса."
L["Config_Scales_OwnClassDefaultsOnly"] = "Показывать наборы по умолчанию, предназначенные лишь для моего класса"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "Показывать не все наборы по умолчанию, а только подходящие для вашего класса."
L["Config_Scales_Title"] = "Список наборов"
L["Config_Score_AddItemLevelToScore"] = "Добавить уровень предмета ко всем рейтингам"
L["Config_Score_AddItemLevelToScore_Desc"] = "Добавить уровень азеритового предмета к текущему, потенциальному и максимальному рейтингам."
L["Config_Score_AddPrimaryStatToScore"] = "Добавить основную характеристику ко всем рейтингам"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "Добавить количество основных характеристик (%s/%s/%s) азеритового предмета к текущему, потенциальному и максимальному рейтингам."
L["Config_Score_OutlineScores"] = "Контур рейтингов"
L["Config_Score_OutlineScores_Desc"] = "Обвести числовые рейтинги азеритовых талантов/сущностей небольшим контуром, чтобы они читались проще на фоне светлых значков."
L["Config_Score_PreferBiSMajor"] = "Предпочитать самую мощную эссенцию"
L["Config_Score_PreferBiSMajor_Desc"] = "Всегда выбирать максимально мощную мажорную эссенцию (BiS), даже если вы можете получить больше очков не выбирая данную эссенцию. Когда эта настройка отключена аддон будет высчитывать несколько разных комбинаций и выбирать лучшую."
L["Config_Score_RelativeScore"] = "Показывать в подсказке относительные значения вместо абсолютных"
L["Config_Score_RelativeScore_Desc"] = "Вместо абсолютных значений вычислять относительные (по сравнению с надетыми предметами) значения и показывать их в процентах."
L["Config_Score_ScaleByAzeriteEmpowered"] = "Масштабировать прибавляемый уровень предмета с помощью ценности %s"
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "При добавлении уровня предметов к рейтингу, использовать ценность %s для вычисления прибавляемого значения, вместо того, чтобы просто прибавлять уровень предмета к рейтингу."
L["Config_Score_ShowOnlyUpgrades"] = "Показывать подсказки только для улучшений"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "Показывать значения в подсказках только в том случае, если они превышают те, что имеются у надетого предмета. Эта настройка будет работать, только если включён показ относительные значений."
L["Config_Score_ShowTooltipLegend"] = "Показывать легенду в подсказках"
L["Config_Score_ShowTooltipLegend_Desc"] = "Показывать в подсказках слова \"Текущий рейтинг / потенциальный рейтинг / максимальный рейтинг\" над соответствующими числами."
L["Config_Score_Title"] = "Рейтинг"
L["Config_SettingsAddonExplanation"] = "Модификация высчитывает \"текущий\", \"потенциальный\" и \"максимальный\" рейтинги азеритовых предметов, исходя из ценности азеритовых талантов."
L["Config_SettingsSavedPerChar"] = [=[Все эти настройки сохраняются отдельно для каждого персонажа.
Созданные вами наборы являются общими для всех персонажей.]=]
L["Config_SettingsScoreExplanation"] = [=["Текущий рейтинг" — сумма азеритовых талантов предмета, задействованных в настоящий момент.
"Потенциальный рейтинг" — сумма азеритовых талантов предмета, наилучших в каждом тире и доступных в настоящий момент.
"Максимальный рейтинг" — сумма азеритовых талантов предмета, наилучших в каждом тире, включая те, что ещё не разблокированы.]=]
L["Config_WeightEditor_Desc"] = "Следующие настройки влияют лишь на показ талантов в редакторе наборов. Даже если вы отключите их, ценность азеритовых талантов будет учтена, если она у них указана."
L["Config_WeightEditor_ShowDefensive"] = "Показывать защитные таланты"
L["Config_WeightEditor_ShowDefensive_Desc"] = "Показывать в редакторе наборов общие и специфичные для класса защитные таланты."
L["Config_WeightEditor_ShowProfession"] = "Показывать таланты, специфичные для профессий"
L["Config_WeightEditor_ShowProfession_Desc"] = "Показывать в редакторе наборов таланты, специфичные для профессий. Эти таланты присутствуют только у предметов, созданных с помощью профессий. В настоящий момент они присутствуют только у головных уборов, созданных инженерами."
L["Config_WeightEditor_ShowPvP"] = "Показывать таланты, специфичные для PvP"
L["Config_WeightEditor_ShowPvP_Desc"] = "Показывать в редакторе наборов таланты, специфичные для PvP. Будут видны лишь таланты вашей фракции, но внесённые изменения применяются к обеим фракциям."
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[Экспортируемая строка содержит только PvP-таланты вашей фракции, но они соответствуют по ID PvP-талантам вражеской фракции.
При импорте строки, содержащей PvP-таланты лишь одной фракции, аналогичные таланты противоположной фракции получат такую же ценность.]=]
L["Config_WeightEditor_ShowRole"] = "Показывать таланты, специфичные для роли"
L["Config_WeightEditor_ShowRole_Desc"] = "Показывать в редакторе наборов таланты, специфичные для роли."
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "Показывать таланты, подходящие только для моей специализации"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "Показывать в редакторе наборов общие и специфичные для текущей специализации ролевые таланты. Включение этой настройки, например, скрывает таланты лекарей от бойцов и танков."
L["Config_WeightEditor_ShowZone"] = "Показывать таланты, специфичные для локаций"
L["Config_WeightEditor_ShowZone_Desc"] = "Показывать в редакторе наборов таланты, специфичные для локаций. Эти таланты присутствуют только у предметов, добытых в определённой локации, связанной с талантом."
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[Обычные таланты работают и срабатывают везде, но рейдовые таланты работают только внутри связанных с ними рейдов (например, таланты Ульдира срабатывают только внутри Ульдира).
В редакторе наборов рейдовые таланты отмечены звёздочкой (*).]=]
L["Config_WeightEditor_Title"] = "Редактор наборов"
L["CreatePopup_Desc"] = "Создание нового набора. Выберите класс и специализацию из выпадающего меню, введите название набора, а затем нажмите %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "Создан новый набор \"%s\""
L["CreatePopup_Error_UnknownError"] = "ОШИБКА: при создании нового набора \"%s\" что-то пошло не так!"
L["CreatePopup_Title"] = "Создать набор"
L["Debug_CopyToBugReport"] = "Скопируйте и вставьте текст выше в ваш отчет об ошибке, если вы считаете, что это актуально."
L["DefaultScaleName_Default"] = "По умолчанию"
L["DefaultScaleName_Defensive"] = "Защита"
L["DefaultScaleName_Offensive"] = "Атака"
L["DeletePopup_DeletedDefaultScale"] = "Удалённый набор использовался, поэтому возвращаю обратно набор по умолчанию для вашего класса и специализации!"
L["DeletePopup_DeletedScale"] = "Удалён набор \"%s\""
L["DeletePopup_Desc"] = [=[Удаление набора %1$s
Нажмите %2$s для подтверждения.
Все персонажи, которые использовали этот набор, вернутся к набору по умолчанию.]=]
L["DeletePopup_Title"] = "Удалить набор"
L["DeletePopup_Warning"] = "Это действие невозможно отменить!"
L["ExportPopup_Desc"] = [=[Экспорт набора %1$s
Нажмите %2$sCtrl+C%3$s, чтобы скопировать строку и %4$sCtrl+V%5$s, чтобы куда-нибудь её вставить]=]
L["ExportPopup_Title"] = "Экспортировать набор"
L["ImportPopup_CreatedNewScale"] = "Импортирован новый набор \"%s\""
L["ImportPopup_Desc"] = [=[Импорт набора из строки
Нажмите %1$sCtrl+V%2$s, чтобы вставить строку в поле ввода, а затем нажмите %3$s]=]
L["ImportPopup_Error_MalformedString"] = "ОШИБКА: импортируемая строка некорректна!"
L["ImportPopup_Error_OldStringRetry"] = "ОШИБКА: импортируемая строка некорректна или импортируется из старой версии, пытаюсь импортировать её в качестве нового набора!"
L["ImportPopup_Error_OldStringVersion"] = "ОШИБКА: импортируемая строка некорректна или импортируется из старой версии!"
L["ImportPopup_Title"] = "Импортировать набор"
L["ImportPopup_UpdatedScale"] = "Обновлён существующий набор \"%s\""
L["ItemToolTip_AzeriteLevel"] = "Уровень Сердца Азерот: %1$d / %2$d"
L["ItemToolTip_Legend"] = "Текущий рейтинг / потенциальный рейтинг / максимальный рейтинг"
L["MassImportPopup_Desc"] = [=[Импорт нескольких наборов из строки
Нажмите %1$sCtrl+V%2$s, чтобы вставить строку в поле ввода, а затем нажмите %3$s]=]
L["MassImportPopup_Title"] = "Импортировать несколько наборов"
L["PowersScoreString"] = [=[Текущий рейтинг: %1$s/%2$s
Максимальный рейтинг: %3$s
Уровень Сердца Азерот: %4$d/%5$d]=]
L["PowersTitles_Class"] = "Классовые таланты"
L["PowersTitles_Defensive"] = "Защитные таланты"
L["PowersTitles_Profession"] = "Таланты профессий"
L["PowersTitles_PvP"] = "PvP-таланты"
L["PowersTitles_Role"] = "Ролевые таланты"
L["PowersTitles_Zone"] = "Таланты рейдов и локаций"
L["RenamePopup_Desc"] = [=[Переименование набора %1$s
Введите новое название в поле ввода и нажмите %2$s]=]
L["RenamePopup_RenamedScale"] = "Набор \"%1$s\" переименован в \"%2$s\""
L["RenamePopup_Title"] = "Переименовать набор"
L["ScaleName_Unknown"] = "Неизвестный"
L["ScaleName_Unnamed"] = "Без названия"
L["ScalesList_CreateImportText"] = "Создать / Импортировать"
L["ScalesList_CustomGroupName"] = "Ваши наборы"
L["ScalesList_DefaultGroupName"] = "Наборы по умолчанию"
L["ScaleWeightEditor_Title"] = "Редактор набора %s"
L["Slash_Command"] = "/azerite"
L["Slash_Error_Unkown"] = "ОШИБКА: что-то пошло не так!"
L["Slash_RemindConfig"] = "Настройки в Esc → Интерфейс → Модификации →%s."
L["WeightEditor_CreateNewText"] = "Создать новый"
L["WeightEditor_CurrentScale"] = "Текущий набор: %s"
L["WeightEditor_DeleteText"] = "Удалить"
L["WeightEditor_EnableScaleText"] = "Использовать этот"
L["WeightEditor_ExportText"] = "Экспортировать"
L["WeightEditor_ImportText"] = "Импортировать"
L["WeightEditor_Major"] = "Макс."
L["WeightEditor_MassImportText"] = "Импортировать несколько"
L["WeightEditor_Minor"] = "Мин."
L["WeightEditor_ModeToEssences"] = "Изменить на сущности"
L["WeightEditor_ModeToTraits"] = "Изменить на Силу Азерита"
L["WeightEditor_RenameText"] = "Переименовать"
L["WeightEditor_TimestampText_Created"] = "Создан %s"
L["WeightEditor_TimestampText_Imported"] = "Импортирован %s"
L["WeightEditor_TimestampText_Updated"] = "Обновлён %s"
L["WeightEditor_TooltipText"] = "Показывать в подсказке"
L["WeightEditor_VersionText"] = "Версия %s"


elseif LOCALE == "zhCN" then -- plok245 (27), riggzh (29), xlfd2008 (33)
--[[Translation missing --]]
L["Config_Enable_Essences"] = "Azerite Essences"
--[[Translation missing --]]
L["Config_Enable_Essences_Desc"] = "Enable %s for Azerite Essences."
--[[Translation missing --]]
L["Config_Enable_Traits"] = "Azerite Traits"
--[[Translation missing --]]
L["Config_Enable_Traits_Desc"] = "Enable %s for Azerite Empowered items."
L["Config_Importing_ImportingCanUpdate"] = "允许导入覆盖现有配置"
L["Config_Importing_ImportingCanUpdate_Desc"] = "当导入配置名称相同并且职业专精一致时，将覆盖现有配置，而不是新建配置。"
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "可以有多个同名配置，只要它们用于不同的专精或职业。"
L["Config_Importing_Title"] = "导入"
L["Config_Scales_OwnClassCustomsOnly"] = "只显示自己职业的自定义配置"
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "只显示自己职业的自定义配置，而不是显示所有配置。"
L["Config_Scales_OwnClassDefaultsOnly"] = "只显示自己职业的默认配置"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "只显示您自己职业的默认配置，而不是显示所有的默认配置。"
L["Config_Scales_Title"] = "配置列表"
L["Config_Score_AddItemLevelToScore"] = "将物品等级计入所有分数中"
L["Config_Score_AddItemLevelToScore_Desc"] = "将艾泽里特护甲的物品等级计入到所有当前已选分数、当前可选最高分和全部解锁最高分的计算中。"
L["Config_Score_AddPrimaryStatToScore"] = "将主属性计入到所有分数中"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "将艾泽里特护甲的主属性值(%s/%s/%s)计入所有当前已选分数、当前可选最高分和全部解锁最高分的计算中。"
L["Config_Score_OutlineScores"] = "给分数描边"
L["Config_Score_OutlineScores_Desc"] = "给艾泽里特特质/精华图标上的分数描绘边框，从而更轻松地阅读艾泽里特特质/精华图标上的数字。"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor"] = "Prefer best major essence"
--[[Translation missing --]]
L["Config_Score_PreferBiSMajor_Desc"] = "Always pick the highest scored major essence even when sometimes you could get better overall score by not selecting the best major essence. When this setting is disabled, the addon will calculate few different score combinations and will pick the best overall score."
L["Config_Score_RelativeScore"] = "在鼠标提示中显示相对值而不是绝对值"
L["Config_Score_RelativeScore_Desc"] = "不在鼠标提示中显示权值的绝对值，而是计算与当前装备相比的相对值，并以百分比显示。"
L["Config_Score_ScaleByAzeriteEmpowered"] = "按％s的权值计算物品等级分数"
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "将物品等级计入分数中时，使用“艾泽里特强化”的权值来计算+1物品等级的分数，而不是按照“1物品等级=1分”来计算。"
L["Config_Score_ShowOnlyUpgrades"] = "只显示有提升的鼠标提示"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "只有在与当前装备的物品相比有提升时，才显示鼠标提示中的权值。 仅适用于启用了相对值。"
L["Config_Score_ShowTooltipLegend"] = "在鼠标提示中显示详细说明"
L["Config_Score_ShowTooltipLegend_Desc"] = "在鼠标提示中显示“当前已选分数/当前可选最高分/全部解锁最高分”。"
L["Config_Score_Title"] = "分数"
L["Config_SettingsAddonExplanation"] = "此插件根据您选择的特质权重来计算艾泽里特护甲的“当前已选分数”，“当前可选最高分”和“全部解锁最高分”。"
L["Config_SettingsSavedPerChar"] = [=[此处所有设置都是每个角色分开保存。
自定义配置则为所有角色共享。]=]
L["Config_SettingsScoreExplanation"] = [=[“当前已选分数”是该艾泽里特护甲中当前选择特质的分数之和。
“当前可选最高分”是该艾泽里特护甲已解锁层中特质最高分数之和。
“全部解锁最高分”是该艾泽里特护甲每一层中特质最高分数之和，包括未解锁的。]=]
L["Config_WeightEditor_Desc"] = [=[以下设置只适用于显示在配置权值编辑器的特质。
即使你禁用了它们，如果它们在启用配置中设置了权值，所有的艾泽里特特质仍会计算分数。]=]
L["Config_WeightEditor_ShowDefensive"] = "显示防御性特质"
L["Config_WeightEditor_ShowDefensive_Desc"] = "在配置权值编辑器中显示通用与职业特定的防御性特质。"
L["Config_WeightEditor_ShowProfession"] = "显示专业技能专有特质"
L["Config_WeightEditor_ShowProfession_Desc"] = "在配置权值编辑器中显示专业技能专有特质。这些特质只会出现在专业技能制造的装备中。目前只有工程头。"
L["Config_WeightEditor_ShowPvP"] = "显示PvP专有特质"
L["Config_WeightEditor_ShowPvP_Desc"] = "在配置权值编辑器中显示PvP专有特质。你只会看到自己的阵营特质，但对它们进行更改会应用到双方阵营特质。"
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[当导出生成的字符串时，只包含你自己阵营的PvP特质，但它们可以与对立阵营PvP特质ID互换。
当导入一个具有PvP特质的字符串时，权值会镜像导入到双方阵营特质中。]=]
L["Config_WeightEditor_ShowRole"] = "显示角色专有特质"
L["Config_WeightEditor_ShowRole_Desc"] = "在配置权值编辑器中显示角色专有特质。"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "只显示自己专精职责的角色专有特质"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "在配置权值编辑器中显示通用与当前专精相关的角色专有特质。启用此设置的话，例如治疗专有特质将会在DPS与坦克上隐藏等。"
L["Config_WeightEditor_ShowZone"] = "显示区域专有特质"
L["Config_WeightEditor_ShowZone_Desc"] = "在配置权值编辑器中显示区域专有特质。这些特质只会出现在与特质相关的特定区域中获得的装备上。"
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[普通特质可以在任何地方生效，但团本特质的部分效果只能在相应的团本内生效（例如：奥迪尔特质的[重组阵列]效果只能在奥迪尔内生效）
团本特质将在配置权值编辑器的名称旁标有星号（*）]=]
L["Config_WeightEditor_Title"] = "配置权值编辑器"
L["CreatePopup_Desc"] = "创建新配置。请从下拉列表中选择职业和天赋，然后输入新配置的名称并点击%1$s"
L["CreatePopup_Error_CreatedNewScale"] = "创建新配置“%s”"
L["CreatePopup_Error_UnknownError"] = "错误：无法创建新配置“%s”"
L["CreatePopup_Title"] = "添加配置"
L["Debug_CopyToBugReport"] = "如果您认为以上文本与bug有关联，请复制并粘贴到bug回报中。"
L["DefaultScaleName_Default"] = "默认"
L["DefaultScaleName_Defensive"] = "防御"
L["DefaultScaleName_Offensive"] = "输出"
L["DeletePopup_DeletedDefaultScale"] = "删除的配置正在使用中，现已恢复为您职业和专精的默认选项！"
L["DeletePopup_DeletedScale"] = "删除配置“%s”"
L["DeletePopup_Desc"] = [=[正在删除配置“%1$s”
点击%2$s确认
所有使用此配置的职业和专精将恢复默认]=]
L["DeletePopup_Title"] = "删除配置"
L["DeletePopup_Warning"] = "！这项操作是永久的且不可恢复！"
L["ExportPopup_Desc"] = [=[导出配置%1$s
点击%2$sCtrl+C%3$s复制字符串，%4$sCtrl+V%5$s在其他地方粘贴]=]
L["ExportPopup_Title"] = "导出配置"
L["ImportPopup_CreatedNewScale"] = "导入新配置“%s”"
L["ImportPopup_Desc"] = [=[正在从字符串导入配置
按下 %1$sCtrl+V%2$s 来粘贴字符串到编辑框并点击 %3$s]=]
L["ImportPopup_Error_MalformedString"] = "错误：导入的字符串格式错误"
L["ImportPopup_Error_OldStringRetry"] = "错误：旧版或格式错误的“导入字符串”-版本已使用，尝试将其作为新配置导入！"
L["ImportPopup_Error_OldStringVersion"] = "错误：\"导入字符串\" -版本太旧或是导入字符串格式错误！"
L["ImportPopup_Title"] = "导入配置"
L["ImportPopup_UpdatedScale"] = "更新现有的配置 \"%s\""
L["ItemToolTip_AzeriteLevel"] = "艾泽里特等级: %1$d / %2$d"
L["ItemToolTip_Legend"] = "当前已选分数/当前可选最高分/全部解锁最高分"
L["MassImportPopup_Desc"] = [=[从字符串一次导入多个配置
在输入框中按下 %1$sCtrl+V%2$s 粘贴字符串并按下 %3$s]=]
L["MassImportPopup_Title"] = "批量导入配置"
L["PowersScoreString"] = [=[当前已选分数: %1$s/%2$s
全部解锁最高分: %3$s
艾泽里特等级: %4$d/%5$d]=]
L["PowersTitles_Class"] = "职业特质"
L["PowersTitles_Defensive"] = "防御性特质"
L["PowersTitles_Profession"] = "专业技能特质"
L["PowersTitles_PvP"] = "PvP特质"
L["PowersTitles_Role"] = "角色特质"
L["PowersTitles_Zone"] = "团本与区域特质"
L["RenamePopup_Desc"] = [=[正在重命名配置 %1$s
在编辑框中输入新名称并按下 %2$s]=]
L["RenamePopup_RenamedScale"] = "已重命名配置 \"%1$s\" 为 \"%2$s\""
L["RenamePopup_Title"] = "重命名配置"
L["ScaleName_Unknown"] = "未知"
L["ScaleName_Unnamed"] = "未命名"
L["ScalesList_CreateImportText"] = "新建/导入"
L["ScalesList_CustomGroupName"] = "自定义配置"
L["ScalesList_DefaultGroupName"] = "默认配置"
L["ScaleWeightEditor_Title"] = "%s 配置权值编辑器"
L["Slash_Command"] = "/azerite"
L["Slash_Error_Unkown"] = "错误：出现一些错误！"
L["Slash_RemindConfig"] = "到 ESC -> 界面 -> 插件 -> %s 来设置"
L["WeightEditor_CreateNewText"] = "新建"
L["WeightEditor_CurrentScale"] = "当前配置：%s"
L["WeightEditor_DeleteText"] = "删除"
L["WeightEditor_EnableScaleText"] = "启用配置"
L["WeightEditor_ExportText"] = "导出"
L["WeightEditor_ImportText"] = "导入"
L["WeightEditor_Major"] = "主要"
L["WeightEditor_MassImportText"] = "批量导入"
L["WeightEditor_Minor"] = "次要"
--[[Translation missing --]]
L["WeightEditor_ModeToEssences"] = "Change to Essences"
--[[Translation missing --]]
L["WeightEditor_ModeToTraits"] = "Change to Traits"
L["WeightEditor_RenameText"] = "重命名"
L["WeightEditor_TimestampText_Created"] = "创建于 %s"
L["WeightEditor_TimestampText_Imported"] = "导入于 %s"
L["WeightEditor_TimestampText_Updated"] = "更新于 %s"
L["WeightEditor_TooltipText"] = "在鼠标提示中显示"
L["WeightEditor_VersionText"] = "版本 %s"


elseif LOCALE == "zhTW" then -- BNSSNB (96), Sinusquell (1)
L["Config_Enable_Essences"] = "艾澤萊精華"
L["Config_Enable_Essences_Desc"] = "啟用 %s 的艾澤萊精華。"
L["Config_Enable_Traits"] = "艾澤萊特質"
L["Config_Enable_Traits_Desc"] = "啟用 %s 的艾澤萊增強物品。"
L["Config_Importing_ImportingCanUpdate"] = "導入可以更新現有比例"
L["Config_Importing_ImportingCanUpdate_Desc"] = "當導入具有相同名稱，職業和專精的比例作為預先存在的比例時，現有比例將使用新權值更新，而不是建立新比例。"
L["Config_Importing_ImportingCanUpdate_Desc_Clarification"] = "可以有多個具有相同名稱的比例，只要它們用於不同的專精或職業。"
L["Config_Importing_Title"] = "導入"
L["Config_Scales_OwnClassCustomsOnly"] = "只列出自身職業的自定義比重"
L["Config_Scales_OwnClassCustomsOnly_Desc"] = "只為你自身的職業列出自定義比重，而非列出所有比重。"
L["Config_Scales_OwnClassDefaultsOnly"] = "只列出自己職業的預設比例"
L["Config_Scales_OwnClassDefaultsOnly_Desc"] = "只列出你自己職業的預設比例，而非列出所有。"
L["Config_Scales_Title"] = "比例清單"
L["Config_Score_AddItemLevelToScore"] = "添加物品等級到所有分數"
L["Config_Score_AddItemLevelToScore_Desc"] = "添加艾澤萊護甲的物品等級到所有當前分數，當前潛力與最高分數計算。"
L["Config_Score_AddPrimaryStatToScore"] = "主屬性計入所有分數"
L["Config_Score_AddPrimaryStatToScore_Desc"] = "將艾澤萊護甲的主屬性值(%s/%s/%s)計算加入當前分數，當前潛力以及最大分數。"
L["Config_Score_OutlineScores"] = "分數描邊"
L["Config_Score_OutlineScores_Desc"] = "在艾澤萊特質/精華上圍繞分數描繪邊框，以便能更輕鬆的閱讀光亮特質/精華圖示上的數字。"
L["Config_Score_PreferBiSMajor"] = "首選最佳主精華"
L["Config_Score_PreferBiSMajor_Desc"] = "總是選擇得分最高的主要精華，即使有時你可以通過不選擇最好的主要精華來獲得更好的總分。禁用此設置後，插件將計算出幾種不同的分數組合，並選擇最佳的總體分數。"
L["Config_Score_RelativeScore"] = "在工具提示中顯示相對值而不是絕對值"
L["Config_Score_RelativeScore_Desc"] = "不是在工具提示中顯示比例的絕對值，而是計算與當前裝備物品相比的相對值，並以百分比顯示差異。"
L["Config_Score_ScaleByAzeriteEmpowered"] = "按比例中的％s權值縮放物品等級計分"
L["Config_Score_ScaleByAzeriteEmpowered_Desc"] = "將物品等級計入到分數時，使用比例的％s的權值來計算+1物品等級的值，而不是使用+1物品等級 = +1分數。"
L["Config_Score_ShowOnlyUpgrades"] = "只顯示有升級的工具提示"
L["Config_Score_ShowOnlyUpgrades_Desc"] = "只有在與當前裝備的物品相比是升級時，才顯示工具提示中的比例值。 這僅適用於啟用了相對值。"
L["Config_Score_ShowTooltipLegend"] = "在工具提示中顯示詳細說明"
L["Config_Score_ShowTooltipLegend_Desc"] = "在工具提示中顯示\"當前分數 / 當前潛力 / 最大分數\"的提醒。"
L["Config_Score_Title"] = "分數"
L["Config_SettingsAddonExplanation"] = "此插件根據你選擇的特質比重計算艾澤萊護甲的\"當前分數\"，\"當前潛力\"以及\"最大分數\"。"
L["Config_SettingsSavedPerChar"] = [=[這裡所有設置都是每個角色分開儲存。
自訂比例則為所有角色共享。]=]
L["Config_SettingsScoreExplanation"] = [=["當前分數" 是當前物品所選的艾澤萊晶岩之力分數總計。
"當前潛力" 是當前物品所可能選擇的最高艾澤萊晶岩之力分數總計。
"最大分數" 是每個物品中最高比重艾澤萊晶岩之力的總計，包含尚未開鎖的。]=]
L["Config_WeightEditor_Desc"] = [=[以下設置只適用於顯示在比例權值編輯器的特質。
即使你停用了它們，如果它們在啟用比例中設置了權值，所有的艾澤萊特質仍會計算分數。]=]
L["Config_WeightEditor_ShowDefensive"] = "顯示防禦性特質"
L["Config_WeightEditor_ShowDefensive_Desc"] = "在比例權值編輯器中顯示通用與職業特定的防禦性特質。"
L["Config_WeightEditor_ShowProfession"] = "顯示專業技能專有特質"
L["Config_WeightEditor_ShowProfession_Desc"] = "在比例權值編輯器中顯示專業技能專有特質。這些特質只會出現在專業技能製作物品中。目前只有出現在工程學頭部裝備。"
L["Config_WeightEditor_ShowPvP"] = "顯示PvP專有特質"
L["Config_WeightEditor_ShowPvP_Desc"] = "在比例權值編輯器中顯示PvP專有特質。你只會看到自己的陣營特質，但對它們做的變動會反映到雙方陣營。"
L["Config_WeightEditor_ShowPvP_Desc_Import"] = [=[當導出生成的字串時，只包含你自己陣營的PvP特質，但它們可以與對立的陣營pvp-powerID互換。
當從一個陣營導入具有pvp特質的字串時，特質會將其權值鏡像導入到雙方陣營。]=]
L["Config_WeightEditor_ShowRole"] = "顯示角色類型專有特質"
L["Config_WeightEditor_ShowRole_Desc"] = "在比例權值編輯器中顯示角色類型專有特質。"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec"] = "只顯示我自己專精職責的角色類型專有特質"
L["Config_WeightEditor_ShowRolesOnlyForOwnSpec_Desc"] = "在比例權值編輯器中顯示共通與當前專精相關的角色類型專有特質。啟用此設置的話像是治療專有專精將會在傷害與坦克上隱藏等等。"
L["Config_WeightEditor_ShowZone"] = "顯示區域專有特質"
L["Config_WeightEditor_ShowZone_Desc"] = "在比例權值編輯器中顯示區域專有特質。這些特質只會出現在與特質相關特定區域中獲得的物品上。"
L["Config_WeightEditor_ShowZone_Desc_Proc"] = [=[正常區域專有特質可以在任何地方啟動/觸發，但團隊特質只會在與它們相關的團隊副本中進行(例如：奧杜爾特質只會在奧杜爾團隊副本中觸發)。
團隊特質在比例權值編輯器中的名稱旁標有星號(*)。]=]
L["Config_WeightEditor_Title"] = "比例權值編輯器"
L["CreatePopup_Desc"] = "建立新的比例。從下拉選單選擇職業與專精並輸入新比例的名稱然後按下 %1$s"
L["CreatePopup_Error_CreatedNewScale"] = "已建立新比例 \"%s\""
L["CreatePopup_Error_UnknownError"] = "錯誤：建立新比例“％s”出了點問題！"
L["CreatePopup_Title"] = "建立比例"
L["Debug_CopyToBugReport"] = "如果你覺得這有相關請 複製&貼上 文字到錯誤回報中。"
L["DefaultScaleName_Default"] = "預設"
L["DefaultScaleName_Defensive"] = "防禦性"
L["DefaultScaleName_Offensive"] = "攻擊性"
L["DeletePopup_DeletedDefaultScale"] = "刪除的比例正在使用中，恢復為您的職業和專精的預設選項！"
L["DeletePopup_DeletedScale"] = "已刪除比例 \"%s\""
L["DeletePopup_Desc"] = [=[正刪除比例 %1$s
按下 %2$s 以確認。
所有使用此專精比例的角色將恢復為預設比例。]=]
L["DeletePopup_Title"] = "刪除比例"
L["DeletePopup_Warning"] = "！ 這個動作是永久性的，無法逆轉！"
L["ExportPopup_Desc"] = [=[正導出比例 %1$s
按下 %2$sCtrl+C%3$s 來複製字串並且 %4$sCtrl+V%5$s 來貼上到某處]=]
L["ExportPopup_Title"] = "導出比例"
L["ImportPopup_CreatedNewScale"] = "導入新的比例 \"%s\""
L["ImportPopup_Desc"] = [=[正從字串導入比例
按下 %1$sCtrl+V%2$s 來貼上字串到編輯框並按下 %3$s]=]
L["ImportPopup_Error_MalformedString"] = "錯誤：導入的字串格式錯誤"
L["ImportPopup_Error_OldStringRetry"] = "錯誤：舊的或格式錯誤的\"匯入字串\" -版本已經使用，嘗試將其匯入為新的比重！"
L["ImportPopup_Error_OldStringVersion"] = "錯誤：\"導入字串\" -版本太舊或是導入字串格式錯誤！"
L["ImportPopup_Title"] = "導入比例"
L["ImportPopup_UpdatedScale"] = "更新現有的比例 \"%s\""
L["ItemToolTip_AzeriteLevel"] = "艾澤萊等級: %1$d / %2$d"
L["ItemToolTip_Legend"] = "當前分數 / 當前潛力 / 最大分數"
L["MassImportPopup_Desc"] = [=[從字串一次匯入多重比重
按下 %1$sCtrl+V%2$s 在輸入框貼上字串並按下 %3$s]=]
L["MassImportPopup_Title"] = "批量匯入比重"
L["PowersScoreString"] = [=[當前分數: %1$s/%2$s
最大分數: %3$s
艾澤萊等級: %4$d/%5$d]=]
L["PowersTitles_Class"] = "職業特質"
L["PowersTitles_Defensive"] = "防禦性特質"
L["PowersTitles_Profession"] = "專業技能特質"
L["PowersTitles_PvP"] = "PvP特質"
L["PowersTitles_Role"] = "角色類型特質"
L["PowersTitles_Zone"] = "團隊與區域特質"
L["RenamePopup_Desc"] = [=[正重新命名比例 %1$s
在編輯框中輸入新名稱並按下 %2$s]=]
L["RenamePopup_RenamedScale"] = "已重命名比例 \"%1$s\" 為 \"%2$s\""
L["RenamePopup_Title"] = "重命名比例"
L["ScaleName_Unknown"] = "未知"
L["ScaleName_Unnamed"] = "未命名"
L["ScalesList_CreateImportText"] = "建立新的 / 導入"
L["ScalesList_CustomGroupName"] = "自訂比例"
L["ScalesList_DefaultGroupName"] = "預設比例"
L["ScaleWeightEditor_Title"] = "%s 比例權值編輯器"
L["Slash_Command"] = "/azerite"
L["Slash_Error_Unkown"] = "錯誤：出了些問題了！"
L["Slash_RemindConfig"] = "到ESC -> 介面 -> 插件 -> %s來設置"
L["WeightEditor_CreateNewText"] = "建立新的"
L["WeightEditor_CurrentScale"] = "當前比例: %s"
L["WeightEditor_DeleteText"] = "刪除"
L["WeightEditor_EnableScaleText"] = "使用此比例"
L["WeightEditor_ExportText"] = "導出"
L["WeightEditor_ImportText"] = "導入"
L["WeightEditor_Major"] = "主要"
L["WeightEditor_MassImportText"] = "批量匯入"
L["WeightEditor_Minor"] = "次要"
L["WeightEditor_ModeToEssences"] = "切換到精華"
L["WeightEditor_ModeToTraits"] = "切換到特質"
L["WeightEditor_RenameText"] = "重命名"
L["WeightEditor_TimestampText_Created"] = "建立於%s"
L["WeightEditor_TimestampText_Imported"] = "匯入於%s"
L["WeightEditor_TimestampText_Updated"] = "更新於%s"
L["WeightEditor_TooltipText"] = "在提示中顯示"
L["WeightEditor_VersionText"] = "版本 %s"


end

--#EOF