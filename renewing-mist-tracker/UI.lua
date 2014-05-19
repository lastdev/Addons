local RenewingMistTracker = _G.RenewingMistTracker
local ui = {
	animated_objects = {},
	progress_bars = {}
}

RenewingMistTracker.ui = ui

function ui:Hide()
	if ui.parent_frame then
		ui.parent_frame:Hide()
	end
	if ui.compact_parent_frame then
		ui.compact_parent_frame:Hide()
	end
	ui.frame_hidden = true
end

function ui:Show()
	if not ReMTrackerDB.mode then
		ReMTrackerDB.mode = "standard"
	end
	if ReMTrackerDB.mode == "compact" then
		if ui.compact_parent_frame then
			ui.compact_parent_frame:Show()
		end
	else
		if ui.parent_frame then
			ui.parent_frame:Show()
		end
	end
	ui.frame_hidden = false
end

function ui:Scale( value )
	if not value or value < 0.1 then
		ui.parent_frame:SetScale( 1 )
		ui.compact_parent_frame:SetScale( 1 )
	else
		ui.parent_frame:SetScale( value )
		ui.compact_parent_frame:SetScale( value )
		ReMTrackerDB.scale = value
	end
end

function ui:ToggleCompact()
	if ReMTrackerDB.mode == "compact" then
		ReMTrackerDB.mode = "standard"
		ui.parent_frame:Show()
		ui.compact_parent_frame:Hide()
	else
		ReMTrackerDB.mode = "compact"
		ui.parent_frame:Hide()
		ui.compact_parent_frame:Show()
	end
end

function ui:SetPosition( x, y )
	ui.parent_frame:SetPoint("BOTTOMLEFT", UIParent, x,  y)
end

function ui:SetupBaseFrames(  )
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
------  Big Frame
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
	local frame = CreateFrame("Frame", "ReMTracker", UIParent)
	-- Orient our UI Frame
	frame:SetSize(204, 20)
	frame:SetPoint("CENTER", UIParent )
	frame:SetBackdrop({
	    bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
	    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12,
	    insets = { left = 3, right = 3, top = 3, bottom = 3, },
	})
	
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen( true )
	frame:RegisterForDrag("LeftButton")
	frame:SetUserPlaced(true)
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:Hide()
	
	-- Create the title text
	frame.titleText = frame:CreateFontString(nil, "OVERLAY")
	frame.titleText:SetPoint("CENTER", frame, "CENTER", 1, 1)
	frame.titleText:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	frame.titleText:SetJustifyH("LEFT")
	frame.titleText:SetShadowOffset(1, -1)
	frame.titleText:SetTextColor(0, 1, 0)
	frame.titleText:SetText( "Renewing Mist Tracker" )
	
	-- Create the lock button
	frame.dragLock = CreateFrame("Button", nil, frame)
	frame.dragLock:SetPoint("RIGHT", frame, "RIGHT", -3, 0)
	frame.dragLock:SetWidth(16)
	frame.dragLock:SetHeight(16)
	frame.dragLock:SetBackdropColor(1,1,1,1)

	-- Create the texture for the button
	frame.dragLock.texture = frame.dragLock:CreateTexture()
	frame.dragLock.texture:SetPoint("CENTER", frame.dragLock,"CENTER", 0, 0)
	frame.dragLock.texture:SetTexture("Interface\\BUTTONS\\CancelButton-Highlight")
	frame.dragLock.texture:SetWidth(24)
	frame.dragLock.texture:SetHeight(24)
	
	frame.dragLock.toggleDragable = function()
		if not ui.parent_frame.drag_disabled then
			frame.dragLock.texture:SetTexture("Interface\\BUTTONS\\CancelButton-Up")
			frame.drag_disabled = true
			if frame:HasScript("OnDragStart") then
				frame:SetScript("OnDragStart", nil)
			end
		else
			frame.dragLock.texture:SetTexture("Interface\\BUTTONS\\CancelButton-Highlight")
			frame.drag_disabled = false
			frame:SetScript("OnDragStart", frame.StartMoving)
		end
	end
	frame.dragLock:SetScript("OnClick", frame.dragLock.toggleDragable)
	frame.dragLock:Show()
	frame:Show()
	
	ui.parent_frame = frame
	
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
------  Compact Frame
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
	local compact = CreateFrame("Frame", "ReMTrackerCompact", UIParent)
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo( RenewingMistTracker:GetSpellID( "Renewing Mist" ) )
	-- Orient our UI Frame
	compact:SetSize(96, 46)
	compact:SetPoint("CENTER", UIParent )
	compact:SetMovable(true)
	compact:EnableMouse(true)
	compact:SetClampedToScreen( true )
	compact:RegisterForDrag("LeftButton")
	compact:SetUserPlaced(true)
	compact:SetScript("OnDragStart", frame.StartMoving)
	compact:SetScript("OnDragStop", frame.StopMovingOrSizing)
	compact:Hide()
	
	compact.bg_texture = ui:CreateSpellTexture( compact, { "TOPLEFT", compact, "TOPLEFT", 0, 0 }, 96, 46, RenewingMistTracker:GetSpellID( "Renewing Mist" ) )
	compact.bg_texture:SetDrawLayer("BACKGROUND")
	compact.bg_texture:SetVertexColor( 0.25, 0.25, 0.25)
	
	-- ReM Count
	local text = compact:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", compact, "CENTER", -24, 10)
	text:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
	text:SetJustifyH("CENTER")
	text:SetShadowOffset(1, -1)
	text:SetTextColor(0, 1, 0)
	-- Initialize the text with an empty string
	text:SetText( "" )
	compact.rem_count_text = text
	
	-- ReM Time
	local text = compact:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", compact, "CENTER", -24, -10)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	text:SetJustifyH("LEFT")
	text:SetShadowOffset(1, -1)
	text:SetTextColor(0, 1, 0)
	-- Initialize the text with an empty string
	text:SetText( "" )
	compact.rem_time_text = text
	
	-- Lowest HP
	local text = compact:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", compact, "CENTER", 28, 10)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	text:SetJustifyH("RIGHT")
	text:SetShadowOffset(1, -1)
	text:SetTextColor(0, 1, 0)
	-- Initialize the text with an empty string
	text:SetText( "" )	
	compact.lowest_hp_text = text
	
	-- Avg HP
	local text = compact:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", compact, "CENTER", 28, -10)
	text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	text:SetJustifyH("RIGHT")
	text:SetShadowOffset(1, -1)
	text:SetTextColor(0, 1, 0)
	-- Initialize the text with an empty string
	text:SetText( "" )	
	compact.avg_hp_text = text
	
		
	local texture = compact:CreateTexture()
	texture:SetPoint( "CENTER", compact, "CENTER", 4, -10)
	texture:SetTexture( "Interface\\FriendsFrame\\UI-Toast-ChatInviteIcon" )
	texture:SetDrawLayer("OVERLAY")
	texture:SetWidth( 16 )
	texture:SetHeight( 16 )
	texture:Hide()
	compact.avg_hp_icon = texture

	ui.compact_parent_frame = compact
end

function ui:CreateProgressBar( name, frame )
	local bar = CreateFrame("StatusBar", nil, frame)
	if name then
		ui.progress_bars[ name ] = bar
	else
		table.insert( ui.progress_bars, bar )
	end
	return bar
end

function ui:CreateTexture( frame, position, icon, w, h )
	if not icon or not w or not h then
		return
	end
	local texture = frame:CreateTexture()

	texture:SetPoint( position[1], frame, position[3], position[4], position[5] )
	texture:SetTexture( string.lower( icon ) )
	texture:SetWidth( w )
	texture.max_width = w
	texture:SetHeight( h )
	texture.max_height = h
	texture:Show()
	texture.anchor_point = position
	
	return texture
end

function ui:CreateSpellTexture( frame, position, w, h, spell )
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo( spell )
	local texture = ui:CreateTexture( frame, position, icon, w, h )
	texture.spell_name = name
	
	return texture
end

function ui:AddToAnimationGroup( obj )
	for k,v in pairs(ui.animated_objects) do
		if v == obj then
			return obj
		end
	end
	table.insert(ui.animated_objects, obj)
end

function ui:Blink( obj, blink_time, should_blink_fn )
	obj.blink_time = blink_time
	obj.blink = should_blink_fn
	
	ui:AddToAnimationGroup( obj )
	return obj
end

function ui:Bounce( obj, bounce_time, h, should_bounce_fn )
	obj.bounce_time = bounce_time
	obj.bounce_height = h
	obj.bounce = should_bounce_fn
	
	ui:AddToAnimationGroup( obj )
	return obj
end

function ui:Grow( obj, grow_pct_fn )
	obj.grow_height = h
	obj.grow = grow_pct_fn
	
	ui:AddToAnimationGroup( obj )
	return obj
end

function ui:SetCooldownGrow( obj )
	-- No spell, no go
	if not obj.spell_name then
		return obj
	end
	
	-- Build the function to calculate the percent done of the cd.
	local spell_grow_fn = function()
		local start, duration, enable = GetSpellCooldown(obj.spell_name)

		-- If we have a duration it is on cooldown.
		if duration and duration > 1.0 then
			local remaining_time = start + duration - GetTime()
			local pct_done = 1.0 - remaining_time / duration
			return pct_done
		end
		return nil
	end
	
	ui:Grow( obj, spell_grow_fn )

	return obj
end

function ui:ShouldHide( obj, should_hide_fn )
	obj.should_hide = should_hide_fn
	
	ui:AddToAnimationGroup( obj )
	return obj
end

function ui:DoGrowAnimation( obj )
	if not obj.grow then
		return
	end
	local pct_done = obj.grow()
	
	if pct_done <= 0.01 then
		obj:Hide()
	else
		obj:Show()
		-- We are not doing our normal animation so zero that out
		obj.animationTime = 0
		obj:SetPoint(obj.anchor_point[1], obj.anchor_point[2],obj.anchor_point[3], obj.anchor_point[4], obj.anchor_point[5]  * pct_done )
		obj:SetHeight(obj.max_height * pct_done)
		obj:SetTexCoord(0, 1 , 0, pct_done )
	end
end

function ui:DoBounceAnimation( obj )
	-- Make sure the icon is visable if it is not on cooldown.
	obj:Show()
	obj:SetHeight( obj.max_height )
	obj:SetTexCoord(0, 1 , 0, 1 )
	local animation_step = math.sin( (math.fmod( obj.animation_time, obj.bounce_time ) / obj.bounce_time ) * math.pi )

	obj:SetPoint(obj.anchor_point[1], obj.anchor_point[2],obj.anchor_point[3], obj.anchor_point[4], obj.anchor_point[5]  + ( obj.bounce_height * animation_step ) )
end

function ui:DoBlink( obj )
	if obj.blink and obj.blink() then
		-- Make sure the icon is visable if it is not on cooldown.
		local animation_step = math.sin( (math.fmod( obj.animation_time, obj.blink_time ) / obj.blink_time ) * math.pi )
	
		obj:SetVertexColor(1, 1, animation_step);
	else
		obj:SetVertexColor(1, 1, 1);
	end	
end

function ui:DoSpellDesaturate( obj )
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo( obj.spell_name )
	if powerType then
		local playerPower = UnitPower( "PLAYER", powerType )
		if playerPower < powerCost then
			obj:SetDesaturated(true)
		else
			obj:SetDesaturated(false)
		end
	end
end

function ui:Animate( elapsed )
	for k,v in pairs(ui.animated_objects) do
		-- Do we need to hide?
		if v.should_hide and v.should_hide() == true then
			v:Hide()
		else
			if not v.animation_time then
				v.animation_time = 0
			else
				v.animation_time = v.animation_time + elapsed
			end
			-- See of we have a growing CD animation
			if v.grow and v.grow() then
				if v.animation_state ~= 'grow' then
					v.animation_state = 'grow'
					v.animation_time = 0
				end

				ui:DoGrowAnimation(v)
			elseif v.bounce and v.bounce() then
				if v.animation_state ~= 'bounce' then
					v.animation_state = 'bounce'
					v.animation_time = 0
				end
				ui:DoBounceAnimation(v)
			end
		
			--Do animations that should be run all the time
			ui:DoBlink( v )
			-- Do spell special checks
			if v.spell_name then
				ui:DoSpellDesaturate( v )
			end
		end
	end
end