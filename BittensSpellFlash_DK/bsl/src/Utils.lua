local g = BittensGlobalTables
local u = g.MakeTable("BittensUtilities", 1)
if u == nil then
	return
end

local SlashCmdList = SlashCmdList
local pairs = pairs
local select = select
local type = type

-------------------------------------------------------------- Table Management
function u.GetFromTable(outerTable, ...)
	for i = 1, select("#", ...) do
		local key = select(i, ...)
		outerTable = outerTable[key]
		if outerTable == nil then
			return nil
		end
	end
	return outerTable
end

function u.GetOrMakeTable(outerTable, ...)
	for i = 1, select("#", ...) do
		local key = select(i, ...)
		if outerTable[key] == nil then
			outerTable[key] = {}
		end
		outerTable = outerTable[key]
	end
	return outerTable
end

function u.MagicallyIncrement(table, variable)
	local val = (table[variable] or 0) + 1
	table[variable] = val
	return val
end

function u.SkipOrUpgrade(table, feature, version)
	local vName = feature .. "Version"
	if table[vName] and table[vName] >= version then
		return "Skip"
	else
		table[vName] = version
	end
end

---------------------------------------------------------------- Slash Commands
local slashHandlers, oldSlashHandlers, oldSlashHandlersVersion 
	= g.GetOrMakeTable("BittensSlashHandlers", 1)
local commandHandlers = u.GetOrMakeTable(slashHandlers, "CommandHandlers")
local subCommandHandlers = u.GetOrMakeTable(slashHandlers, "SubCommandHandlers")

local function getOrMakeSlashHandler(command)
	local handler = commandHandlers[command]
	if handler == nil then
		handler = function(userInput)
			local subCommand, rest = userInput:match("^(%S*)%s*(.-)$")
			if subCommand == nil 
				or subCommandHandlers[command][subCommand] == nil then
				
				if subCommandHandlers[command]["<no sub-command>"] then
					subCommandHandlers[command]["<no sub-command>"](userInput)
				else
					print("Possible sub-commands:")
					for sub, _ in pairs(subCommandHandlers[command]) do
						print("   ", sub)
					end
				end
			else
				subCommandHandlers[command][subCommand](rest)
			end
		end
		commandHandlers[command] = handler
	end
	return handler
end

-- "command" can actually be a table of commands, if you wish
function u.RegisterSlashCommand(command, subCommand, func)
	local allCommands
	if type(command) == "table" then
		allCommands = command
	else
		allCommands = { command }
	end
	local fullName = "BITTENS_UTILS_" .. allCommands[1]
	
	for i, command in pairs(allCommands) do
		_G["SLASH_" .. fullName .. i] = "/" .. command
	end
	
	SlashCmdList[fullName] = getOrMakeSlashHandler(command)
	
	u.GetOrMakeTable(subCommandHandlers, command)
		[subCommand or "<no sub-command>"] = func
end
