-- Grab AddOn info, place into its own environment. ----------------------------
local addonName, addonTable = ...;

local oldEnv = getfenv();

setfenv(1,addonTable);

if ReagentRestockerDB == nil or ReagentRestockerDB.Options == nil or ReagentRestockerDB.Options.Debug == nil then
	debugRR = false;
end

addonTable.debugRR = debugRR;

errToPrint = "\n";
addonTable.errToPrint = errToPrint;

-- Recursive print for tables
local function rprint(depth, ...)
--	if debug==false then
--		error("Debug print called when not debugging! Please report this error.");
--	end
	local colorize = "|cFFFF5555"
	
	local temp = "";
	if depth > 5 then return end;
	spaces = "";
	for x=0,depth*3 do
	 spaces = spaces.." ";
	end

	if ... == nil then
		dprint("nil");
	end
	
	for i,v in pairs ({...}) do
--     print (i,v)
--  	printer:JPrint(v);
	if type(v) == "table" then
		if _G.getmetatable(i) == nil then
			print(spaces .. colorize .. "(no metatable)");
		else
			print(spaces .. colorize .. "(metatable: "..getmetatable(i)..")");
		end
		if(type(i)=="string") then
			print(spaces .. colorize .. "[\""..i.."\"]={");
		else
			print(spaces ..colorize .. "["..i.."]={");
		end
		for x, y in pairs (v) do
			-- Don't recurse global!
			if x == "_G" then
				print(spaces .. colorize .. "_G");
				return
			end
--			if x == "package" then
--				printer:JPrintln(spaces.." (package)");
--				return
--			end
			if type(y)=="table" or type(y)=="function" then
				if type(x)=="string" then
					rprint(depth+1,spaces .. "\""..x.."\"=",y,spaces..",");
				else
					rprint(depth+1,spaces .. x.."=",y,spaces..",");
				end
			elseif type(y)=="boolean" then
				if y==true then
					print(colorize .. spaces .. "\"" .. x .. "\"=" .. "true (type: boolean)")
				else
					print(colorize .. spaces .. "\"" .. x .. "\"=" .. "false (type: boolean)")
				end
			elseif type(y)=="userdata" then
				print(colorize .. spaces .. x .. " is userdata.")
			else
				if type(x)=="string" then
					rprint(depth+1,spaces .. "\""..x.."\"="..y.." (type: "..type(y).."),");
				else
					rprint(depth+1,spaces .. x.."="..y.." (type: "..type(y).."),");
				end
			end
		end
		print(spaces .. colorize .. "}");
	elseif type(v) == "string" then
		print(colorize .. v);
	elseif type(v) == "number" then
		print(colorize .. v);
	elseif type(v) == "boolean" then
		print(colorize .. v);
	else
		print(colorize .. "type: "..type(v));
     end
   end
   --print();
end

function addToError(...)
	for i,v in pairs ({...}) do
		if type(v) == "table" then
			errToPrint = errToPrint .. "(table begin) " .. i .. "\n";
			for i2,v2 in pairs(v) do
				if (type(v2) == "string") or (type(v2) == "number") then
					errToPrint = errToPrint .. "  " .. i2 .. "=" ..v2.."\n";
				elseif (type(v2) == "boolean") then
					if v2==true then
						errToPrint = errToPrint .. "  " .. i2 .. "=" .."true\n"
					else
						errToPrint = errToPrint .. "  " .. i2 .. "=" .."false\n"
					end
				else
					errToPrint = errToPrint .. "  " .. i2 .. "=" ..type(v2).."\n";
				end
			end
			errToPrint = errToPrint .. "(table end)\n"
		elseif (type(v) == "string") or (type(v) == "number") or (type(v) == "boolean") then
			errToPrint = errToPrint .. "  " .. i .. "=" .. v .. "\n";
		else
			errToPrint = errToPrint .. "  " .. i .. "=" .. type(v).."\n";
		end
	end
end

-- Debug print
function dprint(...)
	if debugRR then
		if rprint ~= nil then
			rprint(4,...);
			if  addToError ~= nil then
				addToError(...);
			end
		else
			print(...);
		end
	end
end

--Debug print and error
function derror(...)
	addToError(...);
	error(errToPrint);
end

local oldErr = nil;

function try(func, errFunc)
	oldErr = error; 
	if errFunc == nil then
		errFunc = function() end
	end
	
	error = errFunc;
	func();
	error = oldErr;
end

function throw(err)
	oldErr(err)
end

function getMem(text)
	--print(addonName)
	UpdateAddOnMemoryUsage()
	memUse = GetAddOnMemoryUsage(addonName)
	print(text .. memUse)
end


addonTable.rprint = rprint;
addonTable.addToError = addToError;
addonTable.derror = derror;
addonTable.dprint = dprint;
addonTable.try = try;
addonTable.throw = throw;
addonTable.getMem = getMem;

dprint("Debug.lua loaded (Sandbox.lua should be loaded as well)");

