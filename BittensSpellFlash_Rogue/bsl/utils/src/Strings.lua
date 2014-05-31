local u = BittensGlobalTables.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Strings", 2) then
	return
end

local L = u.Localize

local math = math
local string = string

function u.StartsWith(str, pre)
	local len = pre:len()
	return len <= str:len() and str:sub(1, len) == pre
end

function u.EndsWith(str, suf)
	local len = suf:len()
	return len <= str:len() and str:sub(-len, -1) == suf
end

-- toCondensedString(76.54,  3) => 76.5
-- toCondensedString(987654, 3) => 988K
-- toCondensedString(7654,   3) => 7.65K
-- does not work for numbers less than 1
local suffixes = { L["K"], L["M"], L["B"], L["T"] }
function u.ToCondensedString(number, significantDigits)
--print("toCondensedString", number, significantDigits)
	if number == 0 then
		return "0"
	end
	
	local index, decimals
	local magnitude = math.floor(math.log10(number))
	if magnitude >= significantDigits then
		index = math.floor(magnitude / 3)
		decimals = significantDigits - magnitude % 3 - 1
	else
		index = 0
		decimals = significantDigits - magnitude - 1
	end
	
--print("   ", magnitude, index, decimals)
	number = 
		math.floor(number / 10 ^ (index * 3 - decimals) + .5) 
			/ 10 ^ decimals
	if index > 0 then
		return number .. suffixes[index]
	else
		return number
	end
end
