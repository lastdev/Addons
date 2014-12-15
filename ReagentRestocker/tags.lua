-- Tagging system - experimental

-- In "for" loops, "i"=index, "v"=value

-- Grab AddOn info, place into its own environment. ----------------------------
local addonName, addonTable = ...;

--if addonTable==nil then
--   -- Probably inside the WowLua editor
--   addonTable={};
--end

--local oldEnv = getfenv();
setfenv(1,addonTable);

-- Checks tags table for sanity, creates/deletes stuff if necesarry.
function checkTags()
	dprint("Checking tags.");
	if ReagentRestockerDB == nil then
		derror("No database to add tags to.");
	end
	
	if ReagentRestockerDB.Tags == nil then
		ReagentRestockerDB.Tags = {}
	end
	
	-- Unintentional source of data corruption found . . .
	for tag, v in pairs(ReagentRestockerDB.Tags) do
		if type(ReagentRestockerDB.Tags[tag]) == "number" then
			local temp = ReagentRestockerDB.Tags[tag];
			ReagentRestockerDB.Tags[tag] = {}
			ReagentRestockerDB.Tags[tag][temp] = temp;
		end
	end
	
end

-- Fixes some tag issues. Longer than checkTags, shouldn't be used frequently.
function fixTags()
	for k, v in pairs(ReagentRestockerDB.Items) do
		for k2, v2 in pairs(ReagentRestockerDB.Tags) do
			if ReagentRestockerDB.Tags[k2][k]~=nil and (ReagentRestockerDB.Items[k].tags == nil or ReagentRestockerDB.Items[k].tags[k2]==nil) then
				if ReagentRestockerDB.Items[k].tags == nil then
					ReagentRestockerDB.Items[k].tags = {}
				end
				ReagentRestockerDB.Items[k].tags[k2]=true
			end
		end
	end
end

-- Tags are in a hierarchy, with the top level being "system" tags.

-- Adds empty tag to tag table
function newTag(name)
	checkTags();
	ReagentRestockerDB.Tags[name] = {};
end

-- Assigns tag to object - adds to tag table if necessary
function tagObject(tag, objectID)
	if ReagentRestockerDB.Items[objectID]==nil then
		derror("objectID nil!");
	end
	
	if tag==nil then
		derror("tag nil!");
	end

	checkTags();

	-- Add object to tag's list of known objects
	if type(tag)=="string" or type(tag)=="number" then
		if ReagentRestockerDB.Tags[tag] == nil then ReagentRestockerDB.Tags[tag]={} end
		ReagentRestockerDB.Tags[tag][objectID] = objectID;
	else
		derror("Tags cannot be of type " .. type(tag) .. "!");
	end
	
	if type(objectID)~="string" and type(objectID)~="number" then
		derror("objectID cannot be of type " .. type(objectID) .. "!");
	end
	
	--ReagentRestockerDB.Items[objectID].tags = {}

	
	-- Add tag to object
	if type(ReagentRestockerDB.Items[objectID].tags) == "nil" then
		ReagentRestockerDB.Items[objectID].tags = {}
	end

	ReagentRestockerDB.Items[objectID].tags[tag]=true;
end

-- Removes tag from object, if the tag exists. Does NOT remove the tag from the tag database.
function untagObject(tag, objectID)
	dprint("Trying to remove " .. tag .. " from " .. objectID);
	if objectID == nil then
		derror("objectID cannot be nil.");
	end
	
	checkTags();
	
	if ReagentRestockerDB.Tags[tag]==nil then
		-- The specified tag doesn't exist.
		dprint("Tag " .. tag .. " doesn't seem to exist.");
		return;
	end
	
	if type(ReagentRestockerDB.Tags[tag][objectID]) ~= "nil" then
		ReagentRestockerDB.Tags[tag][objectID] = nil;
	end
   
	if type(ReagentRestockerDB.Items[objectID].tags[tag]) ~= "nil" then
		ReagentRestockerDB.Items[objectID].tags[tag] = nil;
	end
end

-- Removes tag from tag database - has the effect of removing it from all objects
function removeTag(name)
	-- Iterate through objects, removing the tag
	for i, v in pairs(ReagentRestockerDB.Items) do
		if ReagentRestockerDB.Items[i].tags[name] ~= nil then
			ReagentRestockerDB.Items[i].tags[name] = nil;
		end
	end
	
	-- Remove the tag from the tag database
	ReagentRestockerDB.Tags[name] = nil;
	
end

-- Removes all tags from the object.
function removeAllTags(object)
	if ReagentRestockerDB.Items[object] == nil then
		error("Attempt to remove tags from an object that doesn't exist.")
	end
	if ReagentRestockerDB.Items[object].tags ~= nil then
		for i, v in pairs(ReagentRestockerDB.Items[object].tags) do
			untagObject(i, object);
		end
	end
end

-- Renames tag, which also renames it on all objects
function renameTag(old, new)
	-- Iterate through objects, renaming the tag
	for i, v in pairs(ReagentRestockerDB.Items) do
		if ReagentRestockerDB.Items[i].tags[old] ~= nil then
			ReagentRestockerDB.Items[i].tags[new] = ReagentRestockerDB.Items[i].tags[old];
			ReagentRestockerDB.Items[i].tags[old] = nil;
		end
	end

	-- Rename the tag in the tag database
	ReagentRestockerDB.Tags[new] = ReagentRestockerDB.Tags[old];
	ReagentRestockerDB.Tags[old] = nil;
end

-- Gets tags from the object
function getTags(objectID)
	return ReagentRestockerDB.Items[objectID].tags;
end

-- Returns true if an object has a particular tag, false otherwise.
function hasTag(objectID, tag)
	if ReagentRestockerDB.Items[objectID].tags == nil then
		return false;
	end
	if ReagentRestockerDB.Items[objectID].tags[tag] ~= nil then
		return true;
	else
		return false;
	end
end


-- Recursive print helper function
function rTagPrint(tags)
	for i, v in pairs(tags) do
		if type(v)=="table" then
			return i .. ":\n" .. rTagPrint(v)
		elseif type(v)=="number" or type(v)=="string" then
			return i .. "=" .. v;
		else
			derror("Tags cannot be of type " .. type(v) .. "!");
			return "ERROR!";
		end
	end
	return "";
end

-- Prints all known tags using debug print
function printTags()

	-- No tags table
	if type(ReagentRestockerDB.Tags)=="nil" then
		return;
	end
	
	for i,v in pairs(ReagentRestockerDB.Tags) do
		if type(v)=="table" then
			dprint(i .. " " .. rTagPrint(v))
		elseif type(v)=="number" or type(v)=="string" then
			dprint(i .. "=" .. v);
		else
			derror("Tags cannot be of type " .. type(v) .. "!");
		end
	end
end

-- Get all objects with a certain tag
-- Returns a list of IDs
function getAllObjsWithTag(tag)
	return ReagentRestockerDB.Tags[tag]
end


function tagsInit()
	dprint("Init tags.");
	printTags()
end

--addonTable.ReagentRestockerDB=ReagentRestockerDB
--addonTable.RRGlobal=RRGlobal

--setfenv(1, oldEnv);

