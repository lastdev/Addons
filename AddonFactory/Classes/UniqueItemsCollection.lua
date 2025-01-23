local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert, TableRemove = table.insert, table.remove

-- Finished, needs testing before use
oop:Create("UniqueItemsCollection", {
	Init = function(self, container)
		-- This worked fine, but if applied to a saved variable table, the metatable prevents the actual saving of data.
		-- setmetatable(container, { __index = self, __newindex = self })

		self.container = container
		self:Clear()
	end,

	-- Clear all entries
	Clear = function(self)
		local container = self.container
		
		if container then
			container.Set = container.Set or {}
			container.List = container.List or {}
			container.Count = container.Count or 0
		end
	end,
	
	GetList = function(self) return self.container.List end,
	GetPairs = function(self) return self.container.Set end,

	Add = function(self, value)
		local set = self:GetPairs()

		-- if this value is not yet referenced ..
		if not set[value] then
			-- local list = container.List
			local list = self:GetList()
			
			TableInsert(list, value)		-- ex: [1] = "Shadowlands"
			set[value] = #list				-- ["Shadowlands"] = 1
			
			-- keep track of the item count separately, the table size will not do when we remove entries
			self.container.Count = self.container.Count + 1
		end
		
		return set[value]			-- return this list's index
	end,
	
	Remove = function(self, value)
		local set = self:GetPairs()

		-- find the index from the Set
		local index = set[value]
		if index then
			TableRemove(self:GetList(), index)	-- Delete the entry from the list
			set[value] = nil							-- .. and also from the set
			
			self.container.Count = self.container.Count - 1
		end
	end,

	-- Get index from key
	GetIndex = function(self, key)
		local set = self:GetPairs()
		return set and set[key]
	end,
	
	-- Get key from index
	GetKey = function(self, index)
		local list = self:GetList()
		return list and list[index]
	end,

})
