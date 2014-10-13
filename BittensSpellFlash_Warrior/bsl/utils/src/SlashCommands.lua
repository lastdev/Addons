local g = BittensGlobalTables
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Slash Commands", 2) then
	return
end

local SlashCmdList = SlashCmdList
local _G = _G
local print = print
local type = type

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
					for sub in u.Keys(subCommandHandlers[command]) do
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

-- "command" can actually be an array of commands, if you wish
function u.RegisterSlashCommand(command, subCommand, func)
	local allCommands
	if type(command) == "table" then
		allCommands = command
	else
		allCommands = { command }
	end
	local keyCommand = allCommands[1]
	local fullName = "BITTENS_UTILS_" .. keyCommand
	
	for i, command in u.Pairs(allCommands) do
		_G["SLASH_" .. fullName .. i] = "/" .. command
	end
	
	SlashCmdList[fullName] = getOrMakeSlashHandler(keyCommand)
	
	u.GetOrMakeTable(subCommandHandlers, keyCommand)
		[subCommand or "<no sub-command>"] = func
end
