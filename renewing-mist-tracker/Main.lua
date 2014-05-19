_G.RenewingMistTracker = {}
local remTracker = _G.RenewingMistTracker
remTracker.SpellIDs = {
	["Renewing Mist"] = {id = 119611},
	["Thunder Focus Tea"] = {id =116680},
	["Uplift"] = {id =116670},
	["Mana Tea"] = {id =123761} 
}

function remTracker:GetLocalSpellNameFromID( id )
	if not id then
		return nil
	end
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo( id )
	return name
end

function remTracker:GetSpellID( spell_name )
	if not spell_name then
		return nil
	end
	if not remTracker.SpellIDs[ spell_name ] then
		return nil
	end
	if not remTracker.SpellIDs[ spell_name ].name then
		-- Load the name, this should pick up the proper local name
		remTracker.SpellIDs[ spell_name ].name = remTracker:GetLocalSpellNameFromID( remTracker.SpellIDs[ spell_name ].id )
	end
	return remTracker.SpellIDs[ spell_name ].id
end

function remTracker:GetLocalSpellName( spell_name )
	if not spell_name then
		return nil
	end
	if not remTracker.SpellIDs[ spell_name ] then
		return nil
	end
	if not remTracker.SpellIDs[ spell_name ].name then
		-- Load the name, this should pick up the proper local name
		remTracker.SpellIDs[ spell_name ].name = remTracker:GetLocalSpellNameFromID( remTracker.SpellIDs[ spell_name ].id )
	end
	return remTracker.SpellIDs[ spell_name ].name
end
local myFrame = CreateFrame("frame", "RenewingMistTracker")

--Register Events
myFrame:RegisterEvent("PLAYER_LOGIN")
myFrame:RegisterEvent("ADDON_LOADED")
myFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
myFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local myData = {
	player={},
	players={},
	statusBars = {},
	renewing_mist_targets = {},
	renewing_mist_heals = {},
	current_rem_targets = 0,
	targets_under_80pct = 0
}
local Helpers = {}


-- Functions Section

local ordered_rem_targets = {}
local sort_units_by_rem_time = function( a, b )
	-- if not a or not a["Renewing Mist"] or not a["Renewing Mist"].expiration_time then
	-- 	return false
	-- else if not b or not b["Renewing Mist"] or not b["Renewing Mist"].expiration_time then
	-- 	return true
	-- end
	if ReMTrackerDB and ReMTrackerDB.sort and ReMTrackerDB.sort == 'desc' then
		return a[remTracker:GetSpellID( "Renewing Mist" )].expiration_time > b[remTracker:GetSpellID( "Renewing Mist" )].expiration_time
	else
		return a[remTracker:GetSpellID( "Renewing Mist" )].expiration_time < b[remTracker:GetSpellID( "Renewing Mist" )].expiration_time
	end
end

function remTracker:updateStatusBars()
	myData.current_rem_targets = 0
	myData.targets_under_80pct = 0
	myData.shortest_duration = 0
	myData.lowest_hp_pct = 100
	myData.avg_hp_pct = 100
	myData.hasRemTarget = false

	-- Clean up our old ordered targets table
	for i = 1, #ordered_rem_targets, 1 do
		table.remove( ordered_rem_targets, 1 )
	end
	-- Count our current targets
	local total_hp_pct = 0
	for k,v in pairs(remTracker.data.units) do
		if v[remTracker:GetSpellID( "Renewing Mist" )] and v[remTracker:GetSpellID( "Renewing Mist" )].duration and v[remTracker:GetSpellID( "Renewing Mist" )].duration > 0 and v[remTracker:GetSpellID( "Renewing Mist" )].expiration_time > GetTime() then
			myData.hasRemTarget = true
			myData.current_rem_targets = myData.current_rem_targets + 1
			if v.pct_hp then
				total_hp_pct = total_hp_pct + v.pct_hp
				if v.pct_hp < myData.lowest_hp_pct then
					myData.lowest_hp_pct = v.pct_hp
				end
				if v.pct_hp < 80 then
					myData.targets_under_80pct = myData.targets_under_80pct + 1
				end
			end
			table.insert( ordered_rem_targets, v )
		end
	end

	myData.avg_hp_pct = ( total_hp_pct / #ordered_rem_targets )
	-- Sort the ordered rem targets array
	table.sort( ordered_rem_targets, sort_units_by_rem_time )
	
	-- Save our shortest duration, and set it on the comapct frame
	if ReMTrackerDB.mode == "compact" and #ordered_rem_targets > 0 then
		remTracker.ui.compact_parent_frame.rem_count_text:SetText( #ordered_rem_targets )
		local remaining_time = ordered_rem_targets[1][remTracker:GetSpellID( "Renewing Mist" )].expiration_time - GetTime()
		if remaining_time < 0 then
			remaining_time = 0
		end
		remTracker.ui.compact_parent_frame.rem_time_text:SetText(string.format("%4.1f", remaining_time) .. "s" )
		myData.shortest_duration = remaining_time
		
		if myData.lowest_hp_pct < 50 then
			remTracker.ui.compact_parent_frame.lowest_hp_text:SetTextColor(1 , 0, 0)
		else
			remTracker.ui.compact_parent_frame.lowest_hp_text:SetTextColor(0 , 1, 0)
		end
		remTracker.ui.compact_parent_frame.lowest_hp_text:SetText( math.floor( myData.lowest_hp_pct ) .. "%" )

		if myData.avg_hp_pct < 75 then
			remTracker.ui.compact_parent_frame.avg_hp_text:SetTextColor(1 , 0, 0)
		else
			remTracker.ui.compact_parent_frame.avg_hp_text:SetTextColor(0 , 1, 0)
		end
		remTracker.ui.compact_parent_frame.avg_hp_text:SetText( math.floor( myData.avg_hp_pct ) .. "%" )
		
		remTracker.ui.compact_parent_frame.avg_hp_icon:Show()
		remTracker.ui.compact_parent_frame.avg_hp_icon:SetDrawLayer("OVERLAY", 7)
	else
		remTracker.ui.compact_parent_frame.avg_hp_icon:Hide()
		remTracker.ui.compact_parent_frame.rem_count_text:SetText( "" )
		remTracker.ui.compact_parent_frame.rem_time_text:SetText( "" )
		remTracker.ui.compact_parent_frame.lowest_hp_text:SetText( "" )
		remTracker.ui.compact_parent_frame.avg_hp_text:SetText( "" )
	end
	
	
	if #myData.statusBars < myData.current_rem_targets then
		remTracker:createStatusBars( myData.current_rem_targets - #myData.statusBars)
	end
	-- Hide and show the correct number of bars
	for i = 1, #myData.statusBars, 1 do
		if i <= myData.current_rem_targets then
			myData.statusBars[i]:Show()
		else
			myData.statusBars[i]:Hide()
		end
	end
	
	-- Add new renewing mist targets
	local status_bar_index = 1
	for k,v in ipairs(ordered_rem_targets) do
		local guid = v.guid
		--Set up the unit name on the bar.
		myData.statusBars[ status_bar_index ].playerName = v.name
		myData.statusBars[ status_bar_index ].value:SetText( v.name )
		local class_color = RAID_CLASS_COLORS[v.class_name]
		local remaining_time = v[remTracker:GetSpellID( "Renewing Mist" )].expiration_time - GetTime()
		if remaining_time < 0 then
			remaining_time = 0
		end
		if class_color then
			myData.statusBars[ status_bar_index ].value:SetTextColor(class_color.r, class_color.g, class_color.b)
		end
		myData.statusBars[ status_bar_index ].value2:SetText(string.format("%4.1f", remaining_time) .. "s" )
		--Set the current health percentage
		if v.pct_hp then
			myData.statusBars[ status_bar_index ].health_pct:SetText( string.format("%4.1f", v.pct_hp ) .. "%" )
			local health_level = ( v.pct_hp - 35 )
			if health_level < 0 then
				health_level = 0
			elseif health_level > 65 then
				health_level = 65
			end
			local health_green = health_level / 65.0
			local health_red = 1 - health_green
			myData.statusBars[ status_bar_index ].health_pct:SetTextColor(health_red ,  health_green, 0)
		else
			myData.statusBars[ status_bar_index ].health_pct:SetText( "0.00%" )
		end
		if ReMTrackerDB and ReMTrackerDB.hide_health_pct then
			myData.statusBars[ status_bar_index ].health_pct:SetText( "" )
		end
		
		if v[remTracker:GetSpellID( "Renewing Mist" )].last_heal then
			if v[remTracker:GetSpellID( "Renewing Mist" )].last_heal.at > GetTime() - 1.2 then
				local heal_string = Helpers:ReadableNumber(v[remTracker:GetSpellID( "Renewing Mist" )].last_heal.effective, 2) .. " ( O: ".. Helpers:ReadableNumber(v[remTracker:GetSpellID( "Renewing Mist" )].last_heal.over, 2) .. " )"
				myData.statusBars[ status_bar_index ].heal_amt:SetText( heal_string )
				local fade = 1
				-- Are we fading in?  Fade in for .6 sec
				if v[remTracker:GetSpellID( "Renewing Mist" )].last_heal.at > GetTime() - 0.6 then
					local delta_time = v[remTracker:GetSpellID( "Renewing Mist" )].last_heal.at - ( GetTime() - 1.2 )
					fade = math.sin( ( delta_time / 0.6)  * ( math.pi / 2 ) )
				end
				myData.statusBars[ status_bar_index ].heal_amt:SetTextColor(0, 1, 0, fade)
			else
				myData.statusBars[ status_bar_index ].heal_amt:SetText( "" )
				myData.statusBars[ status_bar_index ].heal_amt:SetTextColor(0, 1, 0, 0)
			end
		end
		--Set the progressbar state
		myData.statusBars[ status_bar_index ]:SetMinMaxValues(0, v[remTracker:GetSpellID( "Renewing Mist" )].duration)
		myData.statusBars[ status_bar_index ]:SetValue( remaining_time )
		-- Increment the status bar index for the next iteration
		status_bar_index = status_bar_index + 1
	end
end

function remTracker:createStatusBars( cnt )
	for i = 1, cnt, 1 do
		local yOffset = #myData.statusBars * 26 + 20
		-- Create the bar
	 	local bar = remTracker.ui:CreateProgressBar( "rem_bar" .. #myData.statusBars, remTracker.ui.parent_frame )
		bar:SetPoint("TOPLEFT", 3, -3 - yOffset)
		bar:SetPoint("TOPRIGHT", -3, -3 - yOffset)
		bar:SetHeight(24)
		bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		bar:GetStatusBarTexture():SetHorizTile(false)
		bar:GetStatusBarTexture():SetVertTile(false)
		bar:SetStatusBarColor(0.5, 1, 0.831)
		bar:EnableMouse(true)

		bar.value = bar:CreateFontString(nil, "OVERLAY")
		bar.value:SetPoint("TOPLEFT", bar, "TOPLEFT", 4, 0)
		bar.value:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
		bar.value:SetJustifyH("LEFT")
		bar.value:SetShadowOffset(1, -1)
		bar.value:SetTextColor(0, 1, 0)
		-- Initialize the text with an empty string
		bar.value:SetText( "" )
		
		-- Do we have the player name for this bar?
		bar.value2 = bar:CreateFontString(nil, "OVERLAY")
		bar.value2:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 4, 0)
		bar.value2:SetFont("Fonts\\FRIZQT__.TTF", 8, "OUTLINE")
		bar.value2:SetJustifyH("LEFT")
		bar.value2:SetShadowOffset(1, -1)
		bar.value2:SetTextColor(0, 1, 0)
		-- Initialize the text with an empty string
		bar.value2:SetText( "" )
		
		bar.health_pct = bar:CreateFontString(nil, "OVERLAY")
		bar.health_pct:SetPoint("RIGHT", bar, "RIGHT", 4, 0)
		bar.health_pct:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
		bar.health_pct:SetJustifyH("RIGHT")
		bar.health_pct:SetShadowOffset(1, -1)
		bar.health_pct:SetTextColor(1, 0, 0)
		-- Initialize the text with an empty string
		bar.health_pct:SetText( "" )
		
		bar.heal_amt = bar:CreateFontString(nil, "OVERLAY")
		bar.heal_amt:SetPoint("BOTTOM", bar, "BOTTOM", 0, 0)
		bar.heal_amt:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
		bar.heal_amt:SetJustifyH("CENTER")
		bar.heal_amt:SetShadowOffset(1, -1)
		bar.heal_amt:SetTextColor(0, 1, 0, 0)
		-- Initialize the text with an empty string
		bar.heal_amt:SetText( "" )
		
		-- Hide it so that we don't show empty bars.
		bar:Hide()
		-- Save it to our status bars table
		table.insert( myData.statusBars, bar )
	end
end

function remTracker:playerLogin()
	myFrame:SetScript("OnUpdate", remTracker.OnUpdate )
	-- Load our player into our data module
	remTracker.data:LoadUnitInfo("PLAYER")
	myData.player.guid = UnitGUID("PLAYER")
	myData.player.name = UnitName("PLAYER")
	myData.player.spec = GetSpecialization()
	-- Add ourselves to the database of seen players
	remTracker:CacheUserInfoForUnitID( "PLAYER" )
	
	remTracker:RegisterIndicators()
	
	DEFAULT_CHAT_FRAME:AddMessage( "Renewing Mist Tracker Loaded", 0.5, 1, 0.831 )
end


function remTracker:AnimateFrame( frame, elapsed )
	if frame.shouldHide and frame.shouldHide() then
		frame:Hide()
		return
	end
	remTracker:BlinkFrame( frame, elapsed )
	remTracker:BounceAnimateFrame(frame, elapsed )
end

function remTracker:BlinkFrame( frame, elapsed )
	if frame.shouldBlink and frame.shouldBlink() then
		local animation_time = frame.blinkAanimationTime or 0
		animation_time = animation_time + elapsed
		frame.blinkAanimationTime = animation_time
		-- Make sure the icon is visable if it is not on cooldown.
		local animation_step = math.sin( (math.fmod( animation_time, 1.5 ) / 1.5 ) * math.pi )
	
		frame:SetVertexColor(1, 1, animation_step);
	else
		frame:SetVertexColor(1, 1, 1);
	end
end

function remTracker:OnUpdate(elapsed)
	-- If we are not in healing spec exit this function
	if not remTracker:IsHealingSpec() then
			return
	end
	
	--Update our mana percentage
	local mana = UnitPower("PLAYER", SPELL_POWER_MANA)
	local max_mana = UnitPowerMax("Player",SPELL_POWER_MANA)
	
	if not max_mana or max_mana < 1 or not mana or mana < 1 then
		myData.player.mana_pct = 0
	else
		myData.player.mana_pct = (mana/max_mana) * 100
	end

	-- It is possible that our Uplift will show 1 frame longer than it should... oh well.
	myData.hasRemTarget = false
	local members = GetNumGroupMembers()
	local grp_type = "party"
	if IsInRaid() then
		grp_type = "raid"
	end
	-- Check self
	remTracker.data:QuerySpellInfoForUnit( remTracker:GetSpellID( "Renewing Mist" ), "PLAYER" )
	remTracker.data:UpdateUnitHealth( "PLAYER" )
	
	if members then
		for i = 1, members, 1 do
			local unit_id = grp_type .. i
			remTracker.data:LoadUnitInfo( unit_id )
			remTracker.data:QuerySpellInfoForUnit( remTracker:GetSpellID( "Renewing Mist" ), unit_id )
			remTracker.data:UpdateUnitHealth( unit_id )
		end
	end
	remTracker:updateStatusBars()
	
	remTracker.ui:Animate( elapsed )
end

function remTracker:IsHealingSpec()
	return ( myData.player.spec == 2 )
end

function remTracker:QueryGlyphs()
	local glyphs = {}
	for i = 1, 6, 1 do
		local glyph_data = {}
		local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(i)
		glyph_data.enabled = enabled
		glyph_data.glyph_type = glyphType
		glyph_data.tooltip_index = glyphTooltipIndex
		glyph_data.icon = icon
		glyph_data.spell_id = glyphSpell
		table.insert( glyphs, glyph_data )
	end
	myData.player.glyphs = glyphs
end

function remTracker:HasGlyph( spell_id )
	if not myData.player.glyphs then
		return false
	end
	if #myData.player.glyphs < 1 then
		return false
	end
	for k,v in pairs(myData.player.glyphs) do
		if v.spell_id and v.spell_id == spell_id then
			return true
		end
	end
	return false
end

--This will look nice in the code than remTracker:HasGlyph( 123763 ) 

function remTracker:HasManaTeaGlyph()
	return remTracker:HasGlyph( 123763 )
end

function remTracker:CacheUserInfoForUnitID( unit_id )
end

function remTracker:CombatLogEvent(...)
	-- If it is not from us, ignore it.
	if select(4,...) ~= myData.player.guid then
		return
	end
	if select(2,...) == "SPELL_PERIODIC_HEAL" then
		-- Change to spell id.
		if select(12,...) == remTracker:GetSpellID( "Renewing Mist" ) then
		 	local seen_at = GetTime()
			local dest_guid = select(8,...)
			local amount = select(15,...)
			local over = select(16,...)
			local effective = amount - over
			remTracker.data:UpdateRenewingMistTick( seen_at, dest_guid, amount, over, effective)
		end
	end
end


function remTracker:RegisterIndicators()
	local true_fn = function() return true end
	local frame = remTracker.ui.parent_frame
	
	-- Create the texture
	local renewing_mist = remTracker.ui:CreateSpellTexture( frame, { "TOPLEFT", frame, "TOPLEFT", 0, 32 }, 32, 32, remTracker:GetSpellID( "Renewing Mist" ) )
	local thunder_focus_tea = remTracker.ui:CreateSpellTexture( frame, { "TOPLEFT", frame, "TOPLEFT", 34, 32 }, 32, 32, remTracker:GetSpellID( "Thunder Focus Tea" ) )
	local uplift = remTracker.ui:CreateSpellTexture( frame, { "TOPLEFT", frame, "TOPLEFT", 68, 32 }, 32, 32, remTracker:GetSpellID( "Uplift" ) )
	local mana_tea = remTracker.ui:CreateSpellTexture( frame, { "TOPLEFT", frame, "TOPLEFT", 170, 32 }, 32, 32, remTracker:GetSpellID( "Mana Tea" ) )
	
	--Create the clicks
	-- ReM

	local renewing_mist_cast = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	renewing_mist_cast:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 35 ) 
	renewing_mist_cast:SetSize(32, 35)
	renewing_mist_cast:SetAttribute( "type", "spell" )
	renewing_mist_cast:SetAttribute( "spell", remTracker:GetLocalSpellName( "Renewing Mist" ) )
	--TFT
	local thunder_focus_tea_cast = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	thunder_focus_tea_cast:SetPoint( "TOPLEFT", frame, "TOPLEFT", 34, 35 ) 
	thunder_focus_tea_cast:SetSize(32, 35)
	thunder_focus_tea_cast:SetAttribute( "type", "spell" )
	thunder_focus_tea_cast:SetAttribute( "spell", remTracker:GetLocalSpellName( "Thunder Focus Tea" ) )
	
	local uplift_cast = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	uplift_cast:SetPoint( "TOPLEFT", frame, "TOPLEFT", 68, 35 ) 
	uplift_cast:SetSize(32, 35)
	uplift_cast:SetAttribute( "type", "spell" )
	uplift_cast:SetAttribute( "spell", remTracker:GetLocalSpellName( "Uplift" ) )
	
	local mana_tea_cast = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
	mana_tea_cast:SetPoint( "TOPLEFT", frame, "TOPLEFT", 170, 35 ) 
	mana_tea_cast:SetSize(32, 35)
	mana_tea_cast:SetAttribute( "type", "spell" )
	mana_tea_cast:SetAttribute( "spell", remTracker:GetLocalSpellName( "Mana Tea" ) )

	--Setup all of the indicaors to bounce
	remTracker.ui:Bounce( renewing_mist, 0.75, 7, true_fn )
	remTracker.ui:Bounce( thunder_focus_tea, 0.75, 7, true_fn )
	remTracker.ui:Bounce( uplift, 0.75, 7, true_fn )
	remTracker.ui:Bounce( mana_tea, 0.75, 7, true_fn )
	
	-- Save the protected frames to the ui table
	if not remTracker.ui.protected_frames then
		remTracker.ui.protected_frames = {}
	end
	
	remTracker.ui.protected_frames.renewing_mist_cast = renewing_mist_cast
	remTracker.ui.protected_frames.thunder_focus_tea_cast = thunder_focus_tea_cast
	remTracker.ui.protected_frames.uplift_cast = uplift_cast
	remTracker.ui.protected_frames.mana_tea_cast = mana_tea_cast
	--Set up the grow for cooldowns
	remTracker.ui:SetCooldownGrow( renewing_mist  )
	remTracker.ui:SetCooldownGrow( thunder_focus_tea  )
	remTracker.ui:SetCooldownGrow( mana_tea  )
	
	--Set up the blink for our indicators
	local thunder_focus_tea_blink = function()
			if myData.current_rem_targets > 5 then
				return true
			else
				return false
			end
	end
	remTracker.ui:Blink( thunder_focus_tea, 1.5, thunder_focus_tea_blink )
	
	local uplift_blink = function()
		if myData.targets_under_80pct > 2 then
			return true
		else
			return false
		end
	end
	remTracker.ui:Blink( uplift, 1.5, uplift_blink )
	
	local mana_tea_blink = function()
		if not myData.player.mana_pct or myData.player.mana_pct > 50 then
			return false
		else
			return true
		end
	end
	remTracker.ui:Blink( mana_tea, 1.5, mana_tea_blink )
	
	-- Set up when to hide
	local uplift_should_hide = function()
		return myData.hasRemTarget == false
	end
	remTracker.ui:ShouldHide( uplift, uplift_should_hide )
	local mana_tea_hide = function()
		if not myData.player.mana_pct or myData.player.mana_pct > 90 then
			return true
		end
		if not remTracker:HasManaTeaGlyph() then
			return true
		end
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, value1, value2, value3 = UnitBuff("PLAYER", remTracker:GetLocalSpellName( "Mana Tea" ), nil, "PLAYER")
		if not count then
			return true
		end
		if count > 1 then
			return false
		end
		return true
	end
	remTracker.ui:ShouldHide( mana_tea, mana_tea_hide )
end

function OnEvent(self, event, ...)
	local arg1 = select(1, ...) or ""
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		remTracker:CombatLogEvent(...)
  elseif event == "PLAYER_LOGIN" then
		local localizedClass, englishClass = UnitClass("player")
		if englishClass ~= "MONK" then
			remTracker.ui:Hide()
			DEFAULT_CHAT_FRAME:AddMessage( "Renewing Mist Tracker: This character is not a monk, not loading.", 0.5, 1, 0.831 )
			return
		end
		remTracker:playerLogin()
		remTracker:QueryGlyphs()
		-- If we are not in healing spec hide the frame and exit this function
		if not remTracker:IsHealingSpec() then
				remTracker.ui:Hide()
		else
			remTracker.ui:Show()
		end
	elseif event == "ADDON_LOADED" and arg1 == "renewing-mist-tracker" then
		if not remTracker.ui_loaded then
			remTracker.ui:SetupBaseFrames()
			remTracker.ui:Hide()
			remTracker.ui_loaded = true

			if ReMTrackerDB == nil then
		   	ReMTrackerDB = {};
		  end
			if ReMTrackerDB.scale then
				remTracker.ui:Scale( ReMTrackerDB.scale )
			end
		end
	elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
		-- The spec number is passed to us, but this reads better.
		myData.player.spec = GetSpecialization()
		remTracker:QueryGlyphs()
		-- If we are not in healing spec hide the frame and exit this function
		if not remTracker:IsHealingSpec() then
				remTracker.ui:Hide()
		else
			remTracker.ui:Show()
		end
  end
end

myFrame:SetScript("OnEvent", OnEvent)

-- Helper functions

function Helpers:ReadableNumber(num, places)
    local ret
    local placeValue = ("%%.%df"):format(places or 0)
    if not num then
        return 0
    elseif num >= 1000000000000 then
        ret = placeValue:format(num / 1000000000000) .. " Tril" -- trillion
    elseif num >= 1000000000 then
        ret = placeValue:format(num / 1000000000) .. " Bil" -- billion
    elseif num >= 1000000 then
        ret = placeValue:format(num / 1000000) .. " Mil" -- million
    elseif num >= 1000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = num -- hundreds
    end
    return ret
end

