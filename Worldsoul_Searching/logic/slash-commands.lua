local REGISTERED_COMMANDS = {}

function helpCommand(unknownCommand)
    if type(unknownCommand) == "boolean" and unknownCommand == true then
        print("Unknown command. Please use the following:")
    else
        print("Addon usage:")
    end

    for name, command in pairs(REGISTERED_COMMANDS) do
        print("  \\wss " .. name .. " - " .. command.description)
    end
end

function LoadSlashCommands(msg, editbox)
    if REGISTERED_COMMANDS[msg] then
        REGISTERED_COMMANDS[msg]:callback(msg, editbox)
    else
        helpCommand(true)
    end
end

function RegisterSlashCommand(eventName, callback, description)
    if not REGISTERED_COMMANDS[eventName] then
        REGISTERED_COMMANDS[eventName] = {
            callback = callback,
            description = description
        }
    end
end

RegisterSlashCommand("help", helpCommand, "Prints this helpful message")
