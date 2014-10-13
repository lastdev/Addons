
-- Rapid Panel Functions
local CreateQuickSlider = TidyPlatesHubRapidPanel.CreateQuickSlider
local CreateQuickCheckbutton = TidyPlatesHubRapidPanel.CreateQuickCheckbutton
local SetSliderMechanics = TidyPlatesHubRapidPanel.SetSliderMechanics
local CreateQuickEditbox = TidyPlatesHubRapidPanel.CreateQuickEditbox
local CreateQuickColorbox = TidyPlatesHubRapidPanel.CreateQuickColorbox
local CreateQuickDropdown = TidyPlatesHubRapidPanel.CreateQuickDropdown
local CreateQuickHeadingLabel = TidyPlatesHubRapidPanel.CreateQuickHeadingLabel
local CreateQuickItemLabel = TidyPlatesHubRapidPanel.CreateQuickItemLabel
local OnMouseWheelScrollFrame = TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame
local CreateInterfacePanel = TidyPlatesHubRapidPanel.CreateInterfacePanel

-- Modes
local ThemeList = TidyPlatesHubModes.ThemeList
local StyleModes = TidyPlatesHubModes.StyleModes
local TextModes = TidyPlatesHubModes.TextModes
local RangeModes = TidyPlatesHubModes.RangeModes
local AuraWidgetModes = TidyPlatesHubModes.AuraWidgetModes
local DebuffStyles = TidyPlatesHubModes.DebuffStyles
local EnemyOpacityModes = TidyPlatesHubModes.EnemyOpacityModes
local FriendlyOpacityModes = TidyPlatesHubModes.FriendlyOpacityModes
local ScaleModes = TidyPlatesHubModes.ScaleModes
local FriendlyBarModes = TidyPlatesHubModes.FriendlyBarModes
local EnemyBarModes = TidyPlatesHubModes.EnemyBarModes
--local WarningGlowModes = TidyPlatesHubModes.WarningGlowModes
local ThreatWidgetModes = TidyPlatesHubModes.ThreatWidgetModes
local NameColorModes = TidyPlatesHubModes.NameColorModes
local TextPlateFieldModes = TidyPlatesHubModes.TextPlateFieldModes
local ArtStyles = TidyPlatesHubModes.ArtStyles
local ArtModes = TidyPlatesHubModes.ArtModes
local ThreatModes = TidyPlatesHubModes.ThreatModes
local CustomTextModes = TidyPlatesHubModes.CustomTextModes
local BasicTextModes = TidyPlatesHubModes.BasicTextModes

------------------------------------------------------------------
-- Generate Panel
------------------------------------------------------------------
local function CreateInterfacePanelWidgets(panel)
	local objectName = panel.objectName
	local AlignmentColumn = panel.AlignmentColumn
	local OffsetColumnB = 200						-- 240
	local F = nil									-- Cache for anchoring


--[[
------------------------------------------------------------------------------------------------------------------------
NOTES:

1. Aura Widget Enhancements
	- Cooldowns
	- Abilities
	- Dispellables
	- Mixed Sizes

2. New Settings Lists

3. Name Text Pre/Suff

4. Core Fade/In Animations

Likely Conditions/Settings
Health Bar
- Class Colors in BGs
- Threat Colors in Instances

Warning, Healer Icon, Animated?


Mouseover Highlight colors on Name
Target Color Name
Name Text Prefix and Suffix   <- Name ->

Plate Show, Fade In Animation
------------------------------------------------------------------------------------------------------------------------
--]]

	--[[
	Friendly Unit Bar Coloring					Enemy Unit Bar Coloring
		- Reaction								- Threat
		- Health								- Reaction
		- Class									- Health
												- Raid Icon * Remove * Add to a checkbox
												- Class

		- Raid Icon Coloring should be an overrride setting, rather than a complete package

		How can we remove the Warning Glow option?


		Under Health
			- Enable Low Health Border Glow

		Under ____
			- Enable Enemy Healer Warning Glow

		PVP Category?


		Need to update, EnableWatchers()

	--]]

	------------------------------
    -- Text
	------------------------------
<<<<<<< HEAD
    -- Health Bars
	------------------------------

    panel.HealthBarLabel, F = CreateQuickHeadingLabel(nil, "Health Bar View", AlignmentColumn, F, 0, 5)

    -- Enemy
	panel.ColorEnemyBarMode, F =  CreateQuickDropdown(objectName.."ColorEnemyBarMode", "Enemy Bar Color:", EnemyBarModes, 1, AlignmentColumn, F)
	panel.ColorEnemyNameMode, F =  CreateQuickDropdown(objectName.."ColorEnemyNameMode", "Enemy Name Color:", NameColorModes, 1, AlignmentColumn, F)
	panel.ColorEnemyStatusTextMode, F =  CreateQuickDropdown(objectName.."ColorEnemyStatusTextMode", "Enemy Status Text:", TextModes, 1, AlignmentColumn, F )
	--panel.ColorEnemyStatusTextModeCenter, F =  CreateQuickDropdown(objectName.."ColorEnemyStatusTextModeCenter", "", BasicTextModes, 1, AlignmentColumn, F, 0, -14 )
	--panel.ColorEnemyStatusTextModeRight, F =  CreateQuickDropdown(objectName.."ColorEnemyStatusTextModeRight", "", BasicTextModes, 1, AlignmentColumn, F, 0, -14 )

	-- Friendly
	panel.ColorFriendlyBarMode, F =  CreateQuickDropdown(objectName.."ColorFriendlyBarMode", "Friendly Bar Color:", FriendlyBarModes, 1, AlignmentColumn, panel.HealthBarLabel, OffsetColumnB)
	panel.ColorFriendlyNameMode, F =  CreateQuickDropdown(objectName.."ColorFriendlyNameMode", "Friendly Name Color:", NameColorModes, 1, AlignmentColumn, F, OffsetColumnB)
	panel.ColorFriendlyStatusTextMode, F =  CreateQuickDropdown(objectName.."ColorFriendlyStatusTextMode", "Friendly Status Text:", TextModes, 1, AlignmentColumn, F, OffsetColumnB)
	--panel.ColorFriendlyStatusTextModeCenter, F =  CreateQuickDropdown(objectName.."ColorFriendlyStatusTextModeCenter", "", BasicTextModes, 1, AlignmentColumn, F, OffsetColumnB, -14)
	--panel.ColorFriendlyStatusTextModeRight, F =  CreateQuickDropdown(objectName.."ColorFriendlyStatusTextModeRight", "", BasicTextModes, 1, AlignmentColumn, F, OffsetColumnB, -14)

	-- Other
	panel.TextShowLevel, F = CreateQuickCheckbutton(objectName.."TextShowLevel", "Show Level", AlignmentColumn, F, 0, 2)
	panel.TextUseBlizzardFont, F = CreateQuickCheckbutton(objectName.."TextUseBlizzardFont", "Use Default Blizzard Font", AlignmentColumn, F, 0)
    panel.TextShowOnlyOnTargets, F = CreateQuickCheckbutton(objectName.."TextShowOnlyOnTargets", "Show Status Text on Target & Mouseover", AlignmentColumn, F, 0)
    panel.TextShowOnlyOnActive, F = CreateQuickCheckbutton(objectName.."TextShowOnlyOnActive", "Show Status Text on Active/Damaged Units", AlignmentColumn, F, 0)

=======
--[[

	Friendly Unit Name Coloring					Enemy Unit Name Coloring
		- Reaction								- Threat
		- Health								- Reaction
		- Class									- Health
												- Raid Icon
												- Class

		- Elite/Significance

	Custom Text Field
	*Field 1				*Field 2				* Field 3
		- Target, Approx Health, Total and Current, Mana/Power, Arena Number, etc.

		None
		Percent Health
		Exact Health
		Rounded Health
		Health Deficit
		Health Total & Percent
		Target Of
		Level
		Arena ID
		Power

	Enable Level Text
	Alt Font
	Show Optional Text on Target/Mouseover

	------
	NOTES:
	Name text highlight color
	Yellow when the name is white
	Brighter/White when the name is a color
--]]

	--[[
	Bar Modes:
	By Threat + By Class (Default)
	* Make it so it can be out-of-box, automatic

	Friendly By Class
	--]]


	------------------------------
	-- Trivial Units
	------------------------------
	--Trivial Mob Scale



	------------------------------
    -- Health Bars
	------------------------------

    panel.HealthBarLabel = CreateQuickHeadingLabel(nil, "Health Bar View", AlignmentColumn, nil, 0, 5)

    -- Enemy
	panel.ColorEnemyBarMode =  CreateQuickDropdown(objectName.."ColorEnemyBarMode", "Enemy Bar Color:", EnemyBarModes, 1, AlignmentColumn, panel.HealthBarLabel)
	panel.ColorEnemyNameMode =  CreateQuickDropdown(objectName.."ColorEnemyNameMode", "Enemy Name Color:", NameColorModes, 1, AlignmentColumn, panel.ColorEnemyBarMode)
	panel.ColorEnemyStatusTextMode =  CreateQuickDropdown(objectName.."ColorEnemyStatusTextMode", "Enemy Status Text:", TextModes, 1, AlignmentColumn, panel.ColorEnemyNameMode)

	-- Friendly
	panel.ColorFriendlyBarMode =  CreateQuickDropdown(objectName.."ColorFriendlyBarMode", "Friendly Bar Color:", FriendlyBarModes, 1, AlignmentColumn, panel.HealthBarLabel, OffsetColumnB)
	panel.ColorFriendlyNameMode =  CreateQuickDropdown(objectName.."ColorFriendlyNameMode", "Friendly Name Color:", NameColorModes, 1, AlignmentColumn, panel.ColorFriendlyBarMode, OffsetColumnB)
	panel.ColorFriendlyStatusTextMode =  CreateQuickDropdown(objectName.."ColorFriendlyStatusTextMode", "Friendly Status Text:", TextModes, 1, AlignmentColumn, panel.ColorFriendlyNameMode, OffsetColumnB)

	-- Other
	panel.TextShowLevel = CreateQuickCheckbutton(objectName.."TextShowLevel", "Show Level", AlignmentColumn, panel.ColorFriendlyStatusTextMode, 0)
	panel.TextUseBlizzardFont = CreateQuickCheckbutton(objectName.."TextUseBlizzardFont", "Use Default Blizzard Font", AlignmentColumn, panel.TextShowLevel, 0)
    panel.TextShowOnlyOnTargets = CreateQuickCheckbutton(objectName.."TextShowOnlyOnTargets", "Only Show Status Text on Target & Mouseover", AlignmentColumn, panel.TextUseBlizzardFont, 0)


	------------------------------
	-- Headline View
	------------------------------
	panel.StyleLabel = CreateQuickHeadingLabel(nil, "Headline View", AlignmentColumn, panel.TextShowOnlyOnTargets, 0, 5)
	panel.StyleEnemyMode =  CreateQuickDropdown(objectName.."StyleEnemyMode", "Enemy Nameplates:", StyleModes, 1, AlignmentColumn, panel.StyleLabel, 0, 2)
	panel.StyleFriendlyMode =  CreateQuickDropdown(objectName.."StyleFriendlyMode", "Friendly Nameplates:", StyleModes, 1, AlignmentColumn, panel.StyleLabel, OffsetColumnB, 2)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	panel.HeadlineEnemyColor = CreateQuickDropdown(objectName.."HeadlineEnemyColor", "Enemy Headline Color:", NameColorModes, 1, AlignmentColumn, panel.StyleEnemyMode)	-- |cffee9900Text-Only Style
	panel.HeadlineFriendlyColor = CreateQuickDropdown(objectName.."HeadlineFriendlyColor", "Friendly Headline Color:", NameColorModes, 1, AlignmentColumn, panel.StyleFriendlyMode, OffsetColumnB)	-- |cffee9900Text-Only Style

	panel.TextPlateFieldMode =  CreateQuickDropdown(objectName.."TextPlateFieldMode", "Status Text Field:", TextPlateFieldModes, 1, AlignmentColumn, panel.HeadlineEnemyColor )	-- |cffee9900Text-Only Style


	------------------------------
	-- Aura (Buff and Debuff) Widget
	------------------------------
<<<<<<< HEAD
	panel.StyleLabel = CreateQuickHeadingLabel(nil, "Headline View", AlignmentColumn, F, 0, 5)
	panel.StyleEnemyMode =  CreateQuickDropdown(objectName.."StyleEnemyMode", "Enemy Headline Mode:", StyleModes, 1, AlignmentColumn, panel.StyleLabel, 0, 2)
	panel.StyleFriendlyMode =  CreateQuickDropdown(objectName.."StyleFriendlyMode", "Friendly Headline Mode:", StyleModes, 1, AlignmentColumn, panel.StyleLabel, OffsetColumnB, 2)

	panel.HeadlineEnemyColor = CreateQuickDropdown(objectName.."HeadlineEnemyColor", "Enemy Headline Color:", NameColorModes, 1, AlignmentColumn, panel.StyleEnemyMode)	-- |cffee9900Text-Only Style
	panel.HeadlineFriendlyColor = CreateQuickDropdown(objectName.."HeadlineFriendlyColor", "Friendly Headline Color:", NameColorModes, 1, AlignmentColumn, panel.StyleFriendlyMode, OffsetColumnB)	-- |cffee9900Text-Only Style

	panel.TextPlateFieldMode =  CreateQuickDropdown(objectName.."TextPlateFieldMode", "Status Text Field:", TextPlateFieldModes, 1, AlignmentColumn, panel.HeadlineEnemyColor )	-- |cffee9900Text-Only Style


	------------------------------
	-- Aura (Buff and Debuff) Widget
	------------------------------
	panel.DebuffsLabel = CreateQuickHeadingLabel(nil, "Buffs & Debuffs", AlignmentColumn, panel.TextPlateFieldMode, 0, 5)
	panel.WidgetsDebuff = CreateQuickCheckbutton(objectName.."WidgetsDebuff", "Enable Aura Widget", AlignmentColumn, panel.DebuffsLabel)

	--panel.WidgetsAuraMode =  CreateQuickDropdown(objectName.."WidgetsAuraMode", "Filter Mode:", AuraWidgetModes, 1, AlignmentColumn, panel.WidgetsDebuffStyle, 16)		-- used to be WidgetsDebuffMode

	panel.WidgetsMyDebuff = CreateQuickCheckbutton(objectName.."WidgetsMyDebuff", "Include My Debuffs", AlignmentColumn, panel.WidgetsDebuff, 16)
	panel.WidgetsMyBuff = CreateQuickCheckbutton(objectName.."WidgetsMyBuff", "Include My Buffs", AlignmentColumn, panel.WidgetsMyDebuff, 16)

	panel.WidgetsDebuffListLabel = CreateQuickItemLabel(nil, "Additional Auras:", AlignmentColumn, panel.WidgetsMyBuff, 16)
	panel.WidgetsDebuffTrackList = CreateQuickEditbox(objectName.."WidgetsDebuffTrackList", AlignmentColumn, panel.WidgetsDebuffListLabel, 16)

	panel.WidgetsDebuffStyle =  CreateQuickDropdown(objectName.."WidgetsDebuffStyle", "Icon Style:", DebuffStyles, 1, AlignmentColumn, panel.WidgetsDebuffTrackList, 16)

	panel.WidgetAuraTrackDispelFriendly = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDispelFriendly", "Include Dispellable Debuffs on Friendly Units", AlignmentColumn, panel.WidgetsDebuffStyle, 16, 4)
	panel.WidgetAuraTrackCurse = CreateQuickCheckbutton(objectName.."WidgetAuraTrackCurse", "Curse", AlignmentColumn, panel.WidgetAuraTrackDispelFriendly, 16+16, -2)
	panel.WidgetAuraTrackDisease = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDisease", "Disease", AlignmentColumn, panel.WidgetAuraTrackCurse, 16+16, -2)
	panel.WidgetAuraTrackMagic = CreateQuickCheckbutton(objectName.."WidgetAuraTrackMagic", "Magic", AlignmentColumn, panel.WidgetAuraTrackDisease, 16+16, -2)
	panel.WidgetAuraTrackPoison = CreateQuickCheckbutton(objectName.."WidgetAuraTrackPoison", "Poison", AlignmentColumn, panel.WidgetAuraTrackMagic, 16+16, -2)

=======
	panel.DebuffsLabel = CreateQuickHeadingLabel(nil, "Buffs & Debuffs", AlignmentColumn, panel.TextPlateFieldMode, 0, 5)
	panel.WidgetsDebuff = CreateQuickCheckbutton(objectName.."WidgetsDebuff", "Show Aura Timers", AlignmentColumn, panel.DebuffsLabel)
	panel.WidgetsDebuffStyle =  CreateQuickDropdown(objectName.."WidgetsDebuffStyle", "Icon Style:", DebuffStyles, 1, AlignmentColumn, panel.WidgetsDebuff, 16)
	panel.WidgetsAuraMode =  CreateQuickDropdown(objectName.."WidgetsAuraMode", "Filter Mode:", AuraWidgetModes, 1, AlignmentColumn, panel.WidgetsDebuffStyle, 16)		-- used to be WidgetsDebuffMode
	panel.WidgetsDebuffListLabel = CreateQuickItemLabel(nil, "Aura List:", AlignmentColumn, panel.WidgetsAuraMode, 16)
	panel.WidgetsDebuffTrackList = CreateQuickEditbox(objectName.."WidgetsDebuffTrackList", AlignmentColumn, panel.WidgetsDebuffListLabel, 16)

	panel.WidgetAuraTrackDispelFriendly = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDispelFriendly", "Track Dispellable Debuffs on Friendly Units", AlignmentColumn, panel.WidgetsDebuffTrackList, 0, 4)
	panel.WidgetAuraTrackCurse = CreateQuickCheckbutton(objectName.."WidgetAuraTrackCurse", "Curse", AlignmentColumn, panel.WidgetAuraTrackDispelFriendly, 16, -2)
	panel.WidgetAuraTrackDisease = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDisease", "Disease", AlignmentColumn, panel.WidgetAuraTrackCurse, 16, -2)
	panel.WidgetAuraTrackMagic = CreateQuickCheckbutton(objectName.."WidgetAuraTrackMagic", "Magic", AlignmentColumn, panel.WidgetAuraTrackDisease, 16, -2)
	panel.WidgetAuraTrackPoison = CreateQuickCheckbutton(objectName.."WidgetAuraTrackPoison", "Poison", AlignmentColumn, panel.WidgetAuraTrackMagic, 16, -2)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	------------------------------
	-- Debuff Help Tip
	panel.DebuffHelpTip = CreateQuickItemLabel(nil, "Tip: |cffCCCCCCAuras should be listed with the exact name, or a spell ID number. "..
<<<<<<< HEAD
		"You can use the prefixes, 'My' or 'All', to distinguish personal damage spells from global crowd control spells. The prefix 'Not' "..
		"may be used to blacklist an aura.  Auras at the top of the list will get displayed before lower ones.", AlignmentColumn, panel.WidgetsDebuffListLabel, 225+40) -- 210, 275, )
	panel.DebuffHelpTip:SetHeight(150)
=======
		"You can use the prefixes, 'My' or 'All', to distinguish personal damage spells from global crowd control spells. "..
		"Auras at the top of the list will get displayed before lower ones.", AlignmentColumn, panel.WidgetsDebuffListLabel, 225+40) -- 210, 275, )
	panel.DebuffHelpTip:SetHeight(128)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	panel.DebuffHelpTip:SetWidth(200)
	panel.DebuffHelpTip.Text:SetJustifyV("TOP")

	-- Expand Options
	-- Filtering mode: Show raid targets, show only my target

	------------------------------
	--Opacity
	------------------------------
<<<<<<< HEAD
	panel.OpacityLabel, F = CreateQuickHeadingLabel(nil, "Opacity", AlignmentColumn, panel.WidgetAuraTrackPoison, 0, 5)
	panel.EnemyAlphaSpotlightMode =  CreateQuickDropdown(objectName.."EnemyAlphaSpotlightMode", "Enemy Spotlight Mode:", EnemyOpacityModes, 1, AlignmentColumn, F)
	panel.FriendlyAlphaSpotlightMode, F =  CreateQuickDropdown(objectName.."FriendlySpotlightMode", "Friendly Spotlight Mode:", FriendlyOpacityModes, 1, AlignmentColumn, F, OffsetColumnB)

	panel.OpacitySpotlight = CreateQuickSlider(objectName.."OpacitySpotlight", "Spotlight Opacity:", AlignmentColumn, F, 0, 2)
	panel.OpacityTarget = CreateQuickSlider(objectName.."OpacityTarget", "Current Target Opacity:", AlignmentColumn, panel.OpacitySpotlight, 0, 2)
=======
	panel.OpacityLabel = CreateQuickHeadingLabel(nil, "Opacity", AlignmentColumn, panel.WidgetAuraTrackPoison, 0, 5)
	panel.OpacityTarget = CreateQuickSlider(objectName.."OpacityTarget", "Current Target Opacity:", AlignmentColumn, panel.OpacityLabel, 0, 2)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	panel.OpacityNonTarget = CreateQuickSlider(objectName.."OpacityNonTarget", "Non-Target Opacity:", AlignmentColumn, panel.OpacityTarget, 0, 2)

	panel.OpacitySpotlightSpell = CreateQuickCheckbutton(objectName.."OpacitySpotlightSpell", "Spotlight Casting Units", AlignmentColumn, panel.OpacityNonTarget, 0)
	panel.OpacitySpotlightMouseover = CreateQuickCheckbutton(objectName.."OpacitySpotlightMouseover", "Spotlight Mouseover", AlignmentColumn, panel.OpacitySpotlightSpell, 0)
	panel.OpacitySpotlightRaidMarked = CreateQuickCheckbutton(objectName.."OpacitySpotlightRaidMarked", "Spotlight Raid Marked", AlignmentColumn, panel.OpacitySpotlightMouseover, 0)

	panel.OpacityFullNoTarget = CreateQuickCheckbutton(objectName.."OpacityFullNoTarget", "Use Target Opacity When No Target Exists", AlignmentColumn, panel.OpacitySpotlightRaidMarked, 0)

	------------------------------
	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel(nil, "Scale", AlignmentColumn, panel.OpacityFullNoTarget, 0, 5)
	panel.ScaleStandard = CreateQuickSlider(objectName.."ScaleStandard", "Normal Scale:", AlignmentColumn, panel.ScaleLabel, 0, 2)
	panel.ScaleSpotlightMode =  CreateQuickDropdown(objectName.."ScaleSpotlightMode", "Scale Spotlight Mode:", ScaleModes, 1, AlignmentColumn, panel.ScaleStandard)
	panel.ScaleSpotlight = CreateQuickSlider(objectName.."ScaleSpotlight", "Spotlight Scale:", AlignmentColumn, panel.ScaleSpotlightMode, 0, 2)
	panel.ScaleIgnoreNeutralUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNeutralUnits", "Ignore Neutral Units", AlignmentColumn, panel.ScaleSpotlight, 16)
	panel.ScaleIgnoreNonEliteUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNonEliteUnits", "Ignore Non-Elite Units", AlignmentColumn, panel.ScaleIgnoreNeutralUnits, 16)
	panel.ScaleIgnoreInactive= CreateQuickCheckbutton(objectName.."ScaleIgnoreInactive", "Ignore Inactive Units", AlignmentColumn, panel.ScaleIgnoreNonEliteUnits, 16)
	panel.ScaleMiniMobs= CreateQuickCheckbutton(objectName.."ScaleMiniMobs", "Auto-Scale Mini/Trivial Mobs", AlignmentColumn, panel.ScaleIgnoreInactive, 0)
	panel.ScaleCastingSpotlight, F = CreateQuickCheckbutton(objectName.."ScaleCastingSpotlight", "Spotlight Casting Units", AlignmentColumn, panel.ScaleMiniMobs, 0)
	panel.ScaleTargetSpotlight, F = CreateQuickCheckbutton(objectName.."ScaleTargetSpotlight", "Spotlight Target Units", AlignmentColumn, F, 0)


	-- panel.ScaleTrivialMobsMultiplier =
	-- Downscale Trivial Mobs  (70%)

	------------------------------
	-- Trivial Mobs
	------------------------------
	-- Scale Multiplier
	-- Override Target Settings
	-- Ignore Threat
	--

	-- Hiding Mobs vs Filtering Mobs

	------------------------------
    -- Unit Search Spotlight/Searchlight
	------------------------------

	--[[
	panel.UnitSpotlightLabel = CreateQuickHeadingLabel(nil, "Unit Spotlight", AlignmentColumn, panel.ScaleCastingSpotlight, 0, 5)

	-- Column 1
	panel.UnitSpotlightOpacity = CreateQuickSlider(objectName.."UnitSpotlightOpacity", "Spotlight Opacity:", AlignmentColumn, panel.UnitSpotlightLabel, 0, 2)
	panel.UnitSpotlightScale = CreateQuickSlider(objectName.."UnitSpotlightScale", "Spotlight Scale:", AlignmentColumn, panel.UnitSpotlightOpacity, 0, 2)
	panel.UnitSpotlightColorLabel = CreateQuickItemLabel(nil, "Spotlight Color:", AlignmentColumn, panel.UnitSpotlightScale, 0, 0)
	panel.UnitSpotlightColor = CreateQuickColorbox(objectName.."UnitSpotlightColor", "Bar & Glow Color", AlignmentColumn, panel.UnitSpotlightColorLabel , 6, 2)

	panel.UnitSpotlightListLabel = CreateQuickItemLabel(nil, "Unit Name:", AlignmentColumn, panel.UnitSpotlightColor, 0, 4)
	panel.UnitSpotlightList = CreateQuickEditbox(objectName.."UnitSpotlightList", AlignmentColumn, panel.UnitSpotlightListLabel, 0)

	-- Boss NPC units

	-- Column 2
	panel.UnitSpotlightOpacityEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightOpacityEnable", "Enable Opacity", AlignmentColumn, panel.UnitSpotlightListLabel, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightScaleEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightScaleEnable", "Enable Scale", AlignmentColumn, panel.UnitSpotlightOpacityEnable, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightBarEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightBarEnable", "Enable Bar Color", AlignmentColumn, panel.UnitSpotlightScaleEnable, 8+OffsetColumnB)
	panel.UnitSpotlightGlowEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightGlowEnable", "Enable Glow Color", AlignmentColumn, panel.UnitSpotlightBarEnable, 8+OffsetColumnB)

	--]]

	------------------------------
	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel(nil, "Scale", AlignmentColumn, panel.OpacityFullNoTarget, 0, 5)
	panel.ScaleStandard = CreateQuickSlider(objectName.."ScaleStandard", "Normal Scale:", AlignmentColumn, panel.ScaleLabel, 0, 2)
	panel.ScaleSpotlightMode =  CreateQuickDropdown(objectName.."ScaleSpotlightMode", "Scale Spotlight Mode:", ScaleModes, 1, AlignmentColumn, panel.ScaleStandard)
	panel.ScaleSpotlight = CreateQuickSlider(objectName.."ScaleSpotlight", "Spotlight Scale:", AlignmentColumn, panel.ScaleSpotlightMode, 0, 2)
	panel.ScaleIgnoreNeutralUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNeutralUnits", "Ignore Neutral Units", AlignmentColumn, panel.ScaleSpotlight, 16)
	panel.ScaleIgnoreNonEliteUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNonEliteUnits", "Ignore Non-Elite Units", AlignmentColumn, panel.ScaleIgnoreNeutralUnits, 16)
	panel.ScaleIgnoreInactive= CreateQuickCheckbutton(objectName.."ScaleIgnoreInactive", "Ignore Inactive Units", AlignmentColumn, panel.ScaleIgnoreNonEliteUnits, 16)
	panel.ScaleMiniMobs= CreateQuickCheckbutton(objectName.."ScaleMiniMobs", "Auto-Scale Mini/Trivial Mobs", AlignmentColumn, panel.ScaleIgnoreInactive, 0)
	panel.ScaleCastingSpotlight= CreateQuickCheckbutton(objectName.."ScaleCastingSpotlight", "Bring Casting Units to Spotlight Scale", AlignmentColumn, panel.ScaleMiniMobs, 0)
	-- panel.ScaleTrivialMobsMultiplier =
	-- Downscale Trivial Mobs  (70%)

	------------------------------
	-- Trivial Mobs
	------------------------------
	-- Scale Multiplier
	-- Override Target Settings
	-- Ignore Threat
	--

	-- Hiding Mobs vs Filtering Mobs

	------------------------------
    -- Unit Search Spotlight/Searchlight
	------------------------------

	--[[
	panel.UnitSpotlightLabel = CreateQuickHeadingLabel(nil, "Unit Spotlight", AlignmentColumn, panel.ScaleCastingSpotlight, 0, 5)

	-- Column 1
	panel.UnitSpotlightOpacity = CreateQuickSlider(objectName.."UnitSpotlightOpacity", "Spotlight Opacity:", AlignmentColumn, panel.UnitSpotlightLabel, 0, 2)
	panel.UnitSpotlightScale = CreateQuickSlider(objectName.."UnitSpotlightScale", "Spotlight Scale:", AlignmentColumn, panel.UnitSpotlightOpacity, 0, 2)
	panel.UnitSpotlightColorLabel = CreateQuickItemLabel(nil, "Spotlight Color:", AlignmentColumn, panel.UnitSpotlightScale, 0, 0)
	panel.UnitSpotlightColor = CreateQuickColorbox(objectName.."UnitSpotlightColor", "Bar & Glow Color", AlignmentColumn, panel.UnitSpotlightColorLabel , 6, 2)

	panel.UnitSpotlightListLabel = CreateQuickItemLabel(nil, "Unit Name:", AlignmentColumn, panel.UnitSpotlightColor, 0, 4)
	panel.UnitSpotlightList = CreateQuickEditbox(objectName.."UnitSpotlightList", AlignmentColumn, panel.UnitSpotlightListLabel, 0)

	-- Boss NPC units

	-- Column 2
	panel.UnitSpotlightOpacityEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightOpacityEnable", "Enable Opacity", AlignmentColumn, panel.UnitSpotlightListLabel, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightScaleEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightScaleEnable", "Enable Scale", AlignmentColumn, panel.UnitSpotlightOpacityEnable, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightBarEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightBarEnable", "Enable Bar Color", AlignmentColumn, panel.UnitSpotlightScaleEnable, 8+OffsetColumnB)
	panel.UnitSpotlightGlowEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightGlowEnable", "Enable Glow Color", AlignmentColumn, panel.UnitSpotlightBarEnable, 8+OffsetColumnB)

	--]]

	------------------------------
	-- Filter
	--------------------------------
<<<<<<< HEAD
	panel.FilterLabel = CreateQuickHeadingLabel(nil, "Unit Filter", AlignmentColumn, F, 0, 5)
=======
	panel.FilterLabel = CreateQuickHeadingLabel(nil, "Unit Filter", AlignmentColumn, panel.ScaleCastingSpotlight, 0, 5)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	panel.OpacityFiltered = CreateQuickSlider(objectName.."OpacityFiltered", "Filtered Unit Opacity:", AlignmentColumn, panel.FilterLabel, 0, 2)
	panel.ScaleFiltered = CreateQuickSlider(objectName.."ScaleFiltered", "Filtered Unit Scale:", AlignmentColumn, panel.OpacityFiltered, 0, 2)
	panel.FilterScaleLock = CreateQuickCheckbutton(objectName.."FilterScaleLock", "Override Target Scale", AlignmentColumn, panel.ScaleFiltered, 16)

	panel.OpacityFilterNeutralUnits = CreateQuickCheckbutton(objectName.."OpacityFilterNeutralUnits", "Filter Neutral Units", AlignmentColumn, panel.FilterScaleLock, 8, 4)
	panel.OpacityFilterNonElite = CreateQuickCheckbutton(objectName.."OpacityFilterNonElite", "Filter Non-Elite", AlignmentColumn, panel.OpacityFilterNeutralUnits, 8)
	panel.OpacityFilterNPC = CreateQuickCheckbutton(objectName.."OpacityFilterNPC", "Filter NPC", AlignmentColumn, panel.OpacityFilterNonElite, 8)
	panel.OpacityFilterFriendlyNPC = CreateQuickCheckbutton(objectName.."OpacityFilterFriendlyNPC", "Filter Friendly NPC", AlignmentColumn, panel.OpacityFilterNPC, 8)

    panel.OpacityFilterPlayers = CreateQuickCheckbutton(objectName.."OpacityFilterPlayers", "Filter Players", AlignmentColumn, panel.FilterScaleLock, OffsetColumnB, 4)
	panel.OpacityFilterInactive = CreateQuickCheckbutton(objectName.."OpacityFilterInactive", "Filter Inactive", AlignmentColumn, panel.OpacityFilterPlayers, OffsetColumnB)
	panel.OpacityFilterMini = CreateQuickCheckbutton(objectName.."OpacityFilterMini", "Filter Mini-Mobs", AlignmentColumn, panel.OpacityFilterInactive, OffsetColumnB)

	panel.OpacityCustomFilterLabel = CreateQuickItemLabel(nil, "Filter By Unit Name:", AlignmentColumn, panel.OpacityFilterFriendlyNPC, 8, 4)
	panel.OpacityFilterList = CreateQuickEditbox(objectName.."OpacityFilterList", AlignmentColumn, panel.OpacityCustomFilterLabel, 8)


    ------------------------------
	-- Reaction
	------------------------------
<<<<<<< HEAD
	-- Health Bar Color
    panel.ReactionLabel = CreateQuickHeadingLabel(nil, "Reaction", AlignmentColumn, panel.OpacityFilterList, 0, 5)
=======

        panel.ReactionLabel = CreateQuickHeadingLabel(nil, "Reaction", AlignmentColumn, panel.OpacityFilterList, 0, 5)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	panel.ReactionColorLabel = CreateQuickItemLabel(nil, "Health Bar Color:", AlignmentColumn, panel.ReactionLabel, 0, 2)
	panel.ColorFriendlyNPC = CreateQuickColorbox(objectName.."ColorFriendlyNPC", "Friendly NPC", AlignmentColumn, panel.ReactionColorLabel , 16)
	panel.ColorFriendlyPlayer = CreateQuickColorbox(objectName.."ColorFriendlyPlayer", "Friendly Player", AlignmentColumn, panel.ColorFriendlyNPC , 16)
	panel.ColorNeutral= CreateQuickColorbox(objectName.."ColorNeutral", "Neutral", AlignmentColumn, panel.ColorFriendlyPlayer , 16)
	panel.ColorHostileNPC = CreateQuickColorbox(objectName.."ColorHostileNPC", "Hostile NPC", AlignmentColumn, panel.ColorNeutral , 16)
	panel.ColorHostilePlayer = CreateQuickColorbox(objectName.."ColorHostilePlayer", "Hostile Player", AlignmentColumn, panel.ColorHostileNPC , 16)
	panel.ColorGuildMember = CreateQuickColorbox(objectName.."ColorGuildMember", "Guild Member", AlignmentColumn, panel.ColorHostilePlayer , 16)
<<<<<<< HEAD
    -- Text Color
=======
    -- Column 2
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
    panel.TextReactionColorLabel = CreateQuickItemLabel(nil, "Text Color:", AlignmentColumn, panel.ReactionLabel, OffsetColumnB )
	panel.TextColorFriendlyNPC = CreateQuickColorbox(objectName.."TextColorFriendlyNPC", "Friendly NPC", AlignmentColumn, panel.ReactionColorLabel , OffsetColumnB + 16)
	panel.TextColorFriendlyPlayer = CreateQuickColorbox(objectName.."TextColorFriendlyPlayer", "Friendly Player", AlignmentColumn, panel.TextColorFriendlyNPC , OffsetColumnB + 16)
	panel.TextColorNeutral= CreateQuickColorbox(objectName.."TextColorNeutral", "Neutral", AlignmentColumn, panel.TextColorFriendlyPlayer , OffsetColumnB + 16)
	panel.TextColorHostileNPC = CreateQuickColorbox(objectName.."TextColorHostileNPC", "Hostile NPC", AlignmentColumn, panel.TextColorNeutral , OffsetColumnB + 16)
	panel.TextColorHostilePlayer = CreateQuickColorbox(objectName.."TextColorHostilePlayer", "Hostile Player", AlignmentColumn, panel.TextColorHostileNPC , OffsetColumnB + 16)
	panel.TextColorGuildMember = CreateQuickColorbox(objectName.."TextColorGuildMember", "Guild Member", AlignmentColumn, panel.TextColorHostilePlayer , OffsetColumnB + 16)
	-- Other
	panel.OtherColorLabel = CreateQuickItemLabel(nil, "Other Colors:", AlignmentColumn, panel.ColorGuildMember, 0, 2)
	panel.ColorTapped = CreateQuickColorbox(objectName.."ColorTapped", "Tapped Unit", AlignmentColumn, panel.OtherColorLabel , 16)
	--panel.ColorTotem = CreateQuickColorbox(objectName.."ColorTotem", "Totem", AlignmentColumn, panel.ColorTapped , 16)

	------------------------------
	-- Threat
	------------------------------
    -- Column 1
<<<<<<< HEAD
	panel.ThreatLabel = CreateQuickHeadingLabel(nil, "Threat", AlignmentColumn, panel.ColorTapped, 0, 5)
	panel.ThreatMode =  CreateQuickDropdown(objectName.."ThreatMode", "Threat Mode:", ThreatModes, 1, AlignmentColumn, panel.ThreatLabel, 0, 2)
	panel.ThreatGlowEnable = CreateQuickCheckbutton(objectName.."ThreatGlowEnable", "Enable Warning Glow", AlignmentColumn, panel.ThreatMode,0)
=======
	panel.ThreatLabel = CreateQuickHeadingLabel(nil, "Threat", AlignmentColumn, panel.ColorGuildMember, 0, 5)
	panel.ThreatMode =  CreateQuickDropdown(objectName.."ThreatMode", "Threat Mode:", ThreatModes, 1, AlignmentColumn, panel.ThreatLabel, 0, 2)
	panel.ThreatGlowEnable = CreateQuickCheckbutton(objectName.."ThreatGlowEnable", "Enable Border Glow", AlignmentColumn, panel.ThreatMode,0)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	panel.ColorThreatColorLabels = CreateQuickItemLabel(nil, "Threat Colors:", AlignmentColumn, panel.ThreatGlowEnable, 0, 2)
	panel.ColorAttackingMe = CreateQuickColorbox(objectName.."ColorAttackingMe", "Warning", AlignmentColumn, panel.ColorThreatColorLabels , 16)
	panel.ColorAggroTransition = CreateQuickColorbox(objectName.."ColorAggroTransition", "Transition", AlignmentColumn, panel.ColorAttackingMe , 16)
	panel.ColorAttackingOthers = CreateQuickColorbox(objectName.."ColorAttackingOthers", "Safe", AlignmentColumn, panel.ColorAggroTransition, 16)

	--[[
	-- Warning Border Glow
	--]]

    -- Column 2
	panel.ColorEnableOffTank = CreateQuickCheckbutton(objectName.."ColorEnableOffTank", "Highlight Mobs Tanked by other Tanks", AlignmentColumn, panel.ThreatLabel, OffsetColumnB)
	panel.ColorAttackingOtherTank = CreateQuickColorbox(objectName.."ColorAttackingOtherTank", "Attacking another Tank", AlignmentColumn, panel.ColorEnableOffTank , 16+OffsetColumnB)

	panel.ColorShowPartyAggro = CreateQuickCheckbutton(objectName.."ColorShowPartyAggro", "Highlight Group Members holding Aggro", AlignmentColumn, panel.ColorAttackingOtherTank, OffsetColumnB)
	panel.ColorPartyAggro = CreateQuickColorbox(objectName.."ColorPartyAggro", "Group Member Aggro", AlignmentColumn, panel.ColorShowPartyAggro , 14+OffsetColumnB)
	panel.ColorPartyAggroBar = CreateQuickCheckbutton(objectName.."ColorPartyAggroBar", "Health Bar Color", AlignmentColumn, panel.ColorPartyAggro, 16+OffsetColumnB)
	panel.ColorPartyAggroGlow = CreateQuickCheckbutton(objectName.."ColorPartyAggroGlow", "Border/Warning Glow", AlignmentColumn, panel.ColorPartyAggroBar, 16+OffsetColumnB)
	panel.ColorPartyAggroText = CreateQuickCheckbutton(objectName.."ColorPartyAggroText", "Name Text Color", AlignmentColumn, panel.ColorPartyAggroGlow, 16+OffsetColumnB)

	------------------------------
	-- Health
	------------------------------
	panel.HealthLabel = CreateQuickHeadingLabel(nil, "Health", AlignmentColumn, panel.ColorPartyAggroText, 0, 5)
	panel.HighHealthThreshold = CreateQuickSlider(objectName.."HighHealthThreshold", "High Health Threshold:", AlignmentColumn, panel.HealthLabel, 0, 2)
	panel.LowHealthThreshold =  CreateQuickSlider(objectName.."LowHealthThreshold", "Low Health Threshold:", AlignmentColumn, panel.HighHealthThreshold, 0, 2)
	panel.HealthColorLabels = CreateQuickItemLabel(nil, "Health Colors:", AlignmentColumn, panel.LowHealthThreshold, 0)
	panel.ColorHighHealth = CreateQuickColorbox(objectName.."ColorHighHealth", "High Health", AlignmentColumn, panel.HealthColorLabels , 16)
	panel.ColorMediumHealth = CreateQuickColorbox(objectName.."ColorMediumHealth", "Medium Health", AlignmentColumn, panel.ColorHighHealth , 16)
	panel.ColorLowHealth, F = CreateQuickColorbox(objectName.."ColorLowHealth", "Low Health", AlignmentColumn, panel.ColorMediumHealth , 16)
	-- [ ]  Highlight Enemy Healers

<<<<<<< HEAD
=======
	--[[
			[ ]  Highlight Enemy Healers
	--]]
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	------------------------------
    -- Cast Bars
	------------------------------
<<<<<<< HEAD
    panel.SpellCastLabel, F = CreateQuickHeadingLabel(nil, "Cast Bars", AlignmentColumn, F, 0, 5)
    panel.SpellCastEnableFriendly, F = CreateQuickCheckbutton(objectName.."SpellCastEnableFriendly", "Show Friendly Cast Bars", AlignmentColumn, F)
	panel.SpellCastColorLabel, F = CreateQuickItemLabel(nil, "Cast Bar Colors:", AlignmentColumn, F, 0, 2)
	panel.ColorNormalSpellCast, F = CreateQuickColorbox(objectName.."ColorNormalSpellCast", "Normal", AlignmentColumn, F , 16)
	panel.ColorUnIntpellCast, F = CreateQuickColorbox(objectName.."ColorUnIntpellCast", "Un-interruptible", AlignmentColumn, F , 16)

	--[[
	------------------------------
	-- Text
	------------------------------
	panel.StatusTextLabel, F = CreateQuickHeadingLabel(nil, "Status Text", AlignmentColumn, F, 0, 5)

	panel.StatusTextLeft, F =  CreateQuickDropdown(objectName.."StatusTextLeft", "Custom Text Program:", CustomTextModes, 1, AlignmentColumn, F, 0, 0)
	panel.StatusTextLeftColor = CreateQuickCheckbutton(objectName.."StatusTextLeftColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextLeftBracket = CreateQuickCheckbutton(objectName.."StatusTextLeftBracket", "Bracket", AlignmentColumn, F, 300, -16)

	panel.StatusTextCenter, F =  CreateQuickDropdown(objectName.."StatusTextCenter", "", CustomTextModes, 1, AlignmentColumn, F, 0, -11)
	panel.StatusTextCenterColor = CreateQuickCheckbutton(objectName.."StatusTextCenterColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextCenterBracket = CreateQuickCheckbutton(objectName.."StatusTextCenterBracket", "Bracket", AlignmentColumn, F, 300, -16)

	panel.StatusTextRight, F =  CreateQuickDropdown(objectName.."StatusTextRight", "", CustomTextModes, 1, AlignmentColumn, F, 0, -11)
	panel.StatusTextRightColor = CreateQuickCheckbutton(objectName.."StatusTextRightColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextRightBracket = CreateQuickCheckbutton(objectName.."StatusTextRightBracket", "Bracket", AlignmentColumn, F, 300, -16)
=======
	--[[
	Enable Friendly Cast Bars
	Enable Enemy Cast Bars
	Interuptable Color
	Un-Interuptable Color

	(Uninteruptable Cast Art)
	--]]

    panel.SpellCastLabel = CreateQuickHeadingLabel(nil, "Spell Casting", AlignmentColumn, panel.ColorLowHealth, 0, 5)
    panel.SpellCastEnableFriendly = CreateQuickCheckbutton(objectName.."SpellCastEnableFriendly", "Show Friendly Cast Bars", AlignmentColumn, panel.SpellCastLabel)
	panel.SpellCastColorLabel = CreateQuickItemLabel(nil, "Cast Bar Colors:", AlignmentColumn, panel.SpellCastEnableFriendly, 0, 2)
	panel.ColorNormalSpellCast = CreateQuickColorbox(objectName.."ColorNormalSpellCast", "Normal", AlignmentColumn, panel.SpellCastColorLabel , 16)
	panel.ColorUnIntpellCast = CreateQuickColorbox(objectName.."ColorUnIntpellCast", "Un-interruptible", AlignmentColumn, panel.ColorNormalSpellCast , 16)

>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23


	------------------------------
	--Widgets
	------------------------------
<<<<<<< HEAD
	panel.WidgetsLabel, F = CreateQuickHeadingLabel(nil, "Other Widgets", AlignmentColumn, F, 0, 5)
=======
	panel.WidgetsLabel = CreateQuickHeadingLabel(nil, "Other Widgets", AlignmentColumn, panel.ColorUnIntpellCast, 0, 5)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	panel.WidgetTargetHighlight = CreateQuickCheckbutton(objectName.."WidgetTargetHighlight", "Show Target Highlight", AlignmentColumn, panel.WidgetsLabel)
	panel.WidgetEliteIndicator = CreateQuickCheckbutton(objectName.."WidgetEliteIndicator", "Show Elite Icon", AlignmentColumn, panel.WidgetTargetHighlight)
	panel.ClassEnemyIcon = CreateQuickCheckbutton(objectName.."ClassEnemyIcon", "Show Enemy Class Art", AlignmentColumn, panel.WidgetEliteIndicator)
	panel.ClassPartyIcon = CreateQuickCheckbutton(objectName.."ClassPartyIcon", "Show Friendly Class Art", AlignmentColumn, panel.ClassEnemyIcon)
	panel.WidgetsTotemIcon = CreateQuickCheckbutton(objectName.."WidgetsTotemIcon", "Show Totem Art", AlignmentColumn, panel.ClassPartyIcon)
	panel.WidgetsComboPoints = CreateQuickCheckbutton(objectName.."WidgetsComboPoints", "Show Combo Points", AlignmentColumn, panel.WidgetsTotemIcon)

	panel.WidgetsEnableExternal = CreateQuickCheckbutton(objectName.."WidgetsEnableExternal", "Enable External Widgets", AlignmentColumn, panel.WidgetsComboPoints)

	panel.WidgetsThreatIndicator, F = CreateQuickCheckbutton(objectName.."WidgetsThreatIndicator", "Show Tug-o-Threat Indicator", AlignmentColumn, panel.WidgetsLabel, OffsetColumnB)
	--panel.WidgetsThreatIndicatorMode =  CreateQuickDropdown(objectName.."WidgetsThreatIndicatorMode", "Threat Indicator:", ThreatWidgetModes, 1, AlignmentColumn, panel.WidgetsThreatIndicator, OffsetColumnB+16)
	panel.WidgetsRangeIndicator = CreateQuickCheckbutton(objectName.."WidgetsRangeIndicator", "Show Party Range Warning", AlignmentColumn, F, OffsetColumnB)
	panel.WidgetsRangeMode =  CreateQuickDropdown(objectName.."WidgetsRangeMode", "Range:", RangeModes, 1, AlignmentColumn, panel.WidgetsRangeIndicator, OffsetColumnB+16)

	------------------------------
	-- Advanced
	------------------------------
	panel.AdvancedLabel = CreateQuickHeadingLabel(nil, "Advanced", AlignmentColumn, panel.WidgetsEnableExternal, 0, 5)
	panel.AdvancedEnableUnitCache = CreateQuickCheckbutton(objectName.."AdvancedEnableUnitCache", "Enable Class & Title Caching ", AlignmentColumn, panel.AdvancedLabel)
	panel.FrameVerticalPosition = CreateQuickSlider(objectName.."FrameVerticalPosition", "Vertical Position of Artwork: (May cause targeting problems)", AlignmentColumn, panel.AdvancedEnableUnitCache, 0, 4)

	--panel.AdvancedCustomCodeLabel = CreateQuickItemLabel(nil, "Custom Theme Code:", AlignmentColumn, panel.FrameVerticalPosition, 0, 4)
	--panel.AdvancedCustomCodeTextbox = CreateQuickEditbox(objectName.."AdvancedCustomCodeTextbox", AlignmentColumn, panel.AdvancedHealthTextLabel, 8)


<<<<<<< HEAD
	--[[
	theme.Default.name.size = 18
	--]]
	local ClearCacheButton = CreateFrame("Button", objectName.."ClearCacheButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	ClearCacheButton:SetPoint("TOPLEFT", panel.FrameVerticalPosition, "BOTTOMLEFT",-6, -18)
	--ClearCacheButton:SetPoint("TOPLEFT", panel.AdvancedCustomCodeTextbox, "BOTTOMLEFT",-6, -18)
	ClearCacheButton:SetWidth(300)
	ClearCacheButton:SetText("Clear Cache")
	ClearCacheButton:SetScript("OnClick", function()
			local count = 0
			for index, obj in pairs(TidyPlatesWidgetData) do
				if type(obj) == 'table' then
					for subIndex in pairs(obj) do
						count = count + 1
						TidyPlatesWidgetData[index][subIndex] = nil
					end
				end
			end
			print("Tidy Plates Hub: Cleared", count, "entries from cache.")
		end)

	local BlizzOptionsButton = CreateFrame("Button", objectName.."BlizzButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	BlizzOptionsButton:SetPoint("TOPLEFT", ClearCacheButton, "BOTTOMLEFT", 0, -16)
=======
	--loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
	--[[
	--function(theme)

	theme.Default.name.size = 18
	--]]

	local BlizzOptionsButton = CreateFrame("Button", objectName.."BlizzButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	BlizzOptionsButton:SetPoint("TOPLEFT", panel.FrameVerticalPosition, "BOTTOMLEFT",-6, -18)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
	--BlizzOptionsButton:SetPoint("TOPLEFT", panel.AdvancedCustomCodeTextbox, "BOTTOMLEFT",-6, -18)
	BlizzOptionsButton:SetWidth(300)
	BlizzOptionsButton:SetText("Blizzard Nameplate Motion & Visibility...")
	BlizzOptionsButton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"]) end)


	------------------------------
	-- Set Sizes and Mechanics
	------------------------------
	panel.MainFrame:SetHeight(2800)

	-- Edit Box Widths
	--panel.AdvancedCustomCodeTextbox:SetWidth(300)
	panel.OpacityFilterList:SetWidth(200)
	panel.WidgetsDebuffTrackList:SetWidth(200)


	-- Slider Ranges
	--SetSliderMechanics(panel.UnitSpotlightOpacity, 1, 0, 1, .01)
	--SetSliderMechanics(panel.UnitSpotlightScale, 1, .1, 2.5, .01)

	SetSliderMechanics(panel.OpacityTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityNonTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacitySpotlight, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityFiltered, 1, 0, 1, .01)

<<<<<<< HEAD
	SetSliderMechanics(panel.ScaleFiltered, 1, .5, 2.2, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .5, 2.2, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .5, 2.2, .01)
=======
	SetSliderMechanics(panel.ScaleFiltered, 1, .1, 2.5, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .1, 2.5, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .1, 2.5, .01)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	SetSliderMechanics(panel.FrameVerticalPosition, .5, 0, 1, .02)

	SetSliderMechanics(panel.HighHealthThreshold, .7, .5, 1, .01)
	SetSliderMechanics(panel.LowHealthThreshold, .3, 0, .5, .01)

	-- "RefreshSettings" is called; A) When PLAYER_ENTERING_WORLD is called, and; B) When changes are made to settings

	local ConvertStringToTable = TidyPlatesHubHelpers.ConvertStringToTable
	local ConvertDebuffListTable = TidyPlatesHubHelpers.ConvertDebuffListTable
	local CallForStyleUpdate = TidyPlatesHubHelpers.CallForStyleUpdate

	function panel.RefreshSettings(LocalVars)
		CallForStyleUpdate()
		-- Convert Debuff Filter Strings
		ConvertDebuffListTable(LocalVars.WidgetsDebuffTrackList, LocalVars.WidgetsDebuffLookup, LocalVars.WidgetsDebuffPriority)
		-- Convert Unit Filter Strings
		ConvertStringToTable(LocalVars.OpacityFilterList, LocalVars.OpacityFilterLookup)
		ConvertStringToTable(LocalVars.UnitSpotlightList, LocalVars.UnitSpotlightLookup)
<<<<<<< HEAD

		-- Convert Custom Code...  (Testing)

		-- local func, err = loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
		-- if func == nil and err then print(panel.name, "|r CUSTOM SCRIPT ERROR", err)
		-- elseif func then LocalVars.CustomHealthFunction = func()	end

=======
		-- Convert Custom Code...  (Testing)
		--local func, err = loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
		--if func == nil and err then print(panel.name, "|r CUSTOM SCRIPT ERROR", err)
		--elseif func then LocalVars.CustomHealthFunction = func()	end
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

	end
end

--local function OnLogin()
	-- Init
	--InitializeTidyPlatesHubModes()

	-- Create Instances of Panels
	local TankPanel = CreateInterfacePanel( "HubPanelSettingsTank", "Tidy Plates Hub: |cFF3782D1Tank", nil )
	CreateInterfacePanelWidgets(TankPanel)
	InterfaceOptions_AddCategory(TankPanel)
	function ShowTidyPlatesHubTankPanel() TidyPlatesUtility.OpenInterfacePanel(TankPanel) end

	local DamagePanel = CreateInterfacePanel( "HubPanelSettingsDamage", "Tidy Plates Hub: |cFFFF1100Damage", nil )
	CreateInterfacePanelWidgets(DamagePanel)
	InterfaceOptions_AddCategory(DamagePanel)
	function ShowTidyPlatesHubDamagePanel() TidyPlatesUtility.OpenInterfacePanel(DamagePanel) end
--end

--local HubHandler = CreateFrame("Frame")
--HubHandler:SetScript("OnEvent", OnLogin)
--HubHandler:RegisterEvent("PLAYER_LOGIN")





--[[
local GladiatorPanel = CreateInterfacePanel( "HubPanelSettingsGladiator", "Tidy Plates Hub: |cFFAA6600Gladiator", nil )
CreateInterfacePanelWidgets(GladiatorPanel)
function ShowTidyPlatesHubGladiatorPanel() InterfaceOptionsFrame_OpenToCategory(GladiatorPanel) end
--]]
--[[

-- Testing

/run print(HubDamageConfigFrame:GetParent())
/run HubDamageConfigFrame:SetParent(UIParent); HubDamageConfigFrame:SetPoint("TOPLEFT")

HubDamageConfigFrame = DamagePanel

local HealerPanel = CreateInterfacePanel( "HubPanelSettingsHealer", "Tidy Plates Hub: |cFF44DD55Healer", nil )
CreateInterfacePanelWidgets(HealerPanel)
function ShowTidyPlatesHubHealerPanel() InterfaceOptionsFrame_OpenToCategory(HealerPanel) end
--]]

