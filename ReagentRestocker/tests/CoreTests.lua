testRR = true

if testRR then

-- Tests for functions in core libraries

-- Grab AddOn info, place into its own environment. ----------------------------
local addonName, addonTable = ...;

local oldEnv = getfenv();

setfenv(1,addonTable);


-- Only test if we are debugging!
if debugRR == true then
dprint("Loading tests");

numTests=0
succTests=0
failTests=0

-- Load tests
tests = {
-- NOTE that dummy databases and functions may need to be created.
-- Use the standard "error" function to throw an error; the testing
-- framework will detect it.

	-- test removeItemFromList
	removeItemFromList = function()
		ReagentRestockerDB = {
			Items = {
				SAM="I AM"
			}
		}
		ReagentRestocker.synchronizeOptionsTable = function() end
		ReagentRestocker:removeItemFromList("SAM")
		if ReagentRestockerDB.Items.SAM ~= nil then
			error("Item was not removed correctly.")
		end
	end
	
	
}

-- Load core tables

core = addonTable.ReagentRestocker;

-- Check to see if we are testing all public functions

for k, v in pairs(core) do
	--dprint("Testing " .. k);
	if type(v)=="function" then
		numTests = numTests+1
		-- This is a function, it should be tested.
		if tests[k]==nil then
			dprint("FAIL: Function " .. k .. " not found.");
			failTests=failTests+1
		else
			-- run test.
			retOK, text = _G.pcall(tests[k]);
			if not retOK then
				dprint("FAIL: " .. text)
				failTests=failTests+1
			else
				succTests = succTests + 1
			end
		end
	end
end

dprint(succTests .. "/" .. numTests .. " tests succeeded.")


end -- if debugRR == true then

end -- if testRR then
