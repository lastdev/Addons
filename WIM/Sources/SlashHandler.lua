--imports
local WIM = WIM;
local _G = _G;
local string = string;
local type = type;
local table = table;

--set namespace.
setfenv(1, WIM);

local CommandList = {};
local CommandListDetails = {};
local CommandListRaw = {};

local function showCommands()
    local c = _G.DEFAULT_CHAT_FRAME;
    c:AddMessage("|cff69ccf0"..L["WIM (WoW Instant Messenger)"].."|r  |cfff58cba"..WIM.version.."|r");
    c:AddMessage("|cff69ccf0"..L["Usage"]..":|r  ".."/wim {"..string.lower(table.concat(CommandListRaw, " | ")).."}");
    for i=1, #CommandListRaw do
        local info = CommandListDetails[CommandListRaw[i]];
        info = info and ":|r "..info or "|r"
        c:AddMessage("  - |cfff58cba"..string.lower(CommandListRaw[i])..info)
    end
end

local function processCommand(cmd)
    cmd = (cmd ~= "") and cmd or "options";
    cmdList = cmdList or CommandList;

    local args;
    cmd, args = string.match(cmd, "([^%s]*)%s*(.*)");
    cmd = string.upper(cmd);

    if(CommandList[cmd]) then
       CommandList[cmd](args);
    else
        if(cmd == "WHO") then
            WIM.WhoList(args);
        else
            showCommands();
        end
    end
    if(cmd ~= "HELP") then
--        DisplayTutorial(L["WIM Slash Commands"], L["To see a list of available WIM slash commands type:"].." |cff69ccf0/wim help|r");
    end
end


-- Global function for Modules to add to WIM's slash commands.
function RegisterSlashCommand(cmd, fun, info)
    if(type(cmd) == "string" and not CommandList[cmd] and type(fun) == "function") then
        CommandList[string.upper(cmd)] = fun;
        CommandListDetails[string.upper(cmd)] = info;
        table.insert(CommandListRaw, string.upper(cmd));
        table.sort(CommandListRaw);
    end
end

-- from @TomCats to avoid tainting of slash command
local lastMessage
local function starts(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

_G.hooksecurefunc("ChatEdit_ParseText", function(editBox, send, parseIfNoSpaces)
    if (send == 0) then
		lastMessage = editBox:GetText()
	end
end)

_G.hooksecurefunc("ChatFrame_DisplayHelpTextSimple", function(frame)
	if (lastMessage and lastMessage ~= "") then
		local cmd = string.upper(lastMessage)
		if (starts(cmd, "/WIM")) then
			local count = 1
			local numMessages = frame:GetNumMessages()
			local function predicateFunction(entry)
				if (count == numMessages) then
                    if (string.match(entry, _G.HELP_TEXT_SIMPLE)) then
						return true
					end
				end
				count = count + 1
			end
			frame:RemoveMessagesByPredicate(predicateFunction)
			processCommand(cmd:gsub("^/WIM%s*", ""))
		end
	end
end)



-- _G.SlashCmdList["WIM"] = processCommand;
-- _G.SLASH_WIM1 = "/wim";

-- Register help menu
RegisterSlashCommand("help", showCommands, L["Display available slash commands."])
-- register some tools for WIM;
RegisterSlashCommand("rl", _G.ReloadUI, L["Reload User Interface."]); -- ReloadUI()
