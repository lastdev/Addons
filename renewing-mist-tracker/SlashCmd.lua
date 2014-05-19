local RenewingMistTracker = _G.RenewingMistTracker

local slash_cmd = {}
RenewingMistTracker.slash_cmd = slash_cmd
-- Setup Slash Commands
SLASH_REMTRACKER1, SLASH_REMTRACKER2 = '/rem', '/remtracker'

function SlashCmdList.REMTRACKER(msg, editbox) -- 4.
	local command, rest = msg:match("^(%S*)%s*(.-)$");
	command = string.lower( command )
	if command == "" or command == "info" or command == "help" then
		slash_cmd:DisplayHelp()
	elseif command == "scale" then
		slash_cmd:ScaleUi( rest )
	elseif command == "c" or command == "compact" then
		slash_cmd:ToggleCompact( rest )
	elseif command == "position" or command == "pos" then
		slash_cmd:PositionUi( rest )
	elseif command == "order" or command == "o" then
		slash_cmd:SetOrder( rest )
	elseif command == "health" then
		slash_cmd:HealthDisplay( rest )
	end
	
end

function slash_cmd:DisplayHelp()
	DEFAULT_CHAT_FRAME:AddMessage( "Renewing Mist Tracker Slash Commands", 0.5, 1, 0.831 )
	DEFAULT_CHAT_FRAME:AddMessage( "====================================", 1,1,1 )
	DEFAULT_CHAT_FRAME:AddMessage( "/rem, /rem info, /rem help - This Menu", 1,1,1 )
	DEFAULT_CHAT_FRAME:AddMessage( "/rem scale # - Sets the scale of the RemTracker frame", 1,1,1 )
	DEFAULT_CHAT_FRAME:AddMessage( "/rem compact - Toggles use of the compact frame", 1,1,1 )
	DEFAULT_CHAT_FRAME:AddMessage( "/rem order (asc or desc) - Sets the sort order on the full frame.", 1,1,1 )
	DEFAULT_CHAT_FRAME:AddMessage( "/rem health (off or on) - Sets the display of the health percentage on the full frame", 1,1,1 )
end

function slash_cmd:ScaleUi( rest )
	local value = tonumber( rest )
	if not value or value < 0.1 then
		DEFAULT_CHAT_FRAME:AddMessage( "Please specify a valid number for the ui scale", 1,1,1 )
		DEFAULT_CHAT_FRAME:AddMessage( "/rem scale # - Sets the scale of the RemTracker frame", 1,1,1 )
	end
	RenewingMistTracker.ui:Scale( value )
end

function slash_cmd:ToggleCompact( rest )
	RenewingMistTracker.ui:ToggleCompact()
end

function slash_cmd:PositionUi( rest )
	local x_str, y_str = rest:match("^(%S*)%s*(.-)$");
	local x = tonumber( x_str ) or 1
	local y = tonumber( y_str ) or 1
	RenewingMistTracker.ui:SetPosition( x, y )
end

function slash_cmd:SetOrder( rest )
	local order, rest = rest:match("^(%S*)%s*(.-)$");
	if ReMTrackerDB then
		if order == "ascending" or order == "asc" then
			ReMTrackerDB.sort = 'asc'
		else
			ReMTrackerDB.sort = 'desc'
		end
	end
end

function slash_cmd:HealthDisplay( rest )
	local cmd, rest = rest:match("^(%S*)%s*(.-)$");
	if ReMTrackerDB then
		if cmd == "off" then
			ReMTrackerDB.hide_health_pct = true
		else
			ReMTrackerDB.hide_health_pct = false
		end
	end
end