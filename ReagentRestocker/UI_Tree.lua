local addonName, addonTable = ...;
local GUI = LibStub("AceGUI-3.0");

local oldEnv = getfenv();
setfenv(1,addonTable);

--File to encapsulate Ace3's crazy tree view UI, which is a true hinderance to good code.

local menu = {}

-- Creates a copy of the current table, so outside functions can't mess it up.
-- Note that only the table itself is copied - due to the way Lua works, the
-- values inside the table don't really need to be copied.

-- If the "table" is not a table, the value is just returned, so this can be
-- used in a generic manner.
local function copyTable(table)
	if type(table) ~= "table" then return table end;
	
	newTable = {};
	for key, value in pairs(table) do
		if type(value) == "table" then
			-- Recurse!
			newTable[key] = copyTable(value);
		else
			newTable[key] = value;
		end
	end
end

-- Recursive search for an item in a table with a specific ID.
-- Returns nil if not found.
local function getItem(ID, table)

	-- Search the current level.
	if table[ID] ~= nil then
		return table[ID];
	end
	
	-- Iterate over table, checking for recursion we can do.
	for key, value in pairs(table) do
		if type(value) == "table" then
			currentValue = getItem(ID, value);
			if currentValue ~= nil then return currentValue end;
		end
	end
	
	-- Not found, return nil.
	return nil;
end

-- Sorta like a class. Exposes functions to manipulare the tree.
local functionTable = {
	
	-- The ID can be a number or a string, and uniquely identifies each element.
	-- It's optional, and if not given, a new one will be returned.
	-- If parent in nil, then assume parent if menuItem.
	-- If item already exists, it is replaced.
	add = function (text, ID, parent)
	
		if parent == nil then parent = menuItem end;

		currentItem = getItem(ID, parent);
		
		-- Not found
		if currentItem == nil then
			-- Find a new spot
			newID = 0;
			while parent[newID] ~= nil do
				newID = newID + 1;
			end
			ID = newID;
		end
		parent[ID].text = text;
		parent[ID].value = ID;
		return copyTable(ID);
	end,
	
	getChildren = function (ID, parent)
		if parent == nil then parent = menuItem end;
		return copyTable(parent[ID]);
	end,
	
	-- finds parent in table.
	getParent = function (ID, table)
	
		if table == nil then table = menuItem end;
		
		-- Search the current level.
		if table[ID] ~= nil then
			return copyTable(table);
		end
		
		-- Iterate over table, checking for recursion we can do.
		for key, value in pairs(table) do
			if type(value) == "table" then
				currentValue = getParent(ID, value);
				if currentValue ~= nil then return copyTable(currentValue) end;
			end
		end
		
		-- Not found, return nil.
		return nil;
	end,
	
	-- Returns a copy of the item (which can be a table) based on its ID and optionally a table that has it as a parent.
	getItemTable = function (ID, table)
		if table == nil then table = menuItem end;
		return copyTable(getItem(ID, table));
	end,
	
	-- initialize
	init = function ()
		-- Check the frame - if it's nil, we need to initialize.
		if frame == nil then
		
		-- Frame for blizzard's dialog box. Needed because Blizzard will eventually
		-- clobber its parents. Duplicate ALL types of frames, in fact!
		--bFrame = GUI:Create("BlizOptionsGroup", "Reagent Restocker");
		--frame = GUI:Create("ScrollFrame", "Reagent Restocker");
		selectTree = GUI:Create("TreeGroup");
		selectTree:SetFullWidth(true);
		selectTree:SetFullHeight(true);
		selectTree:SetLayout("list");
		selectTree:SetTree(Menu);
		end
		return selectTree;
	end

}

-- Creates a new menu - returns a set of functions used for the interface.
function createNewMenu(frame)
	newMenu = {
		menuItem = {},
		frame = nil,
		bFrame = nil,
		selectTree = nil
	}
	setmetatable(newMenu, {__index = functionTable})
	frame:AddChild(newMenu.init());
	return newMenu;
end



-- The tree itself.
setfenv(1, oldEnv);
ReagentRestockerDB=addonTable.ReagentRestockerDB
