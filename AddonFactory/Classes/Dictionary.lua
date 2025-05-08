--[[ Class : Dictionary

Purpose : The name says it all, this turns an external table into a dictionary, to offer some extension methods

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert, TableSort = table.insert, table.sort

oop:Create("Dictionary", {
	Init = function(self, data)
		-- Call : 
		--		oop:New("Dictionary")
		--		oop:New("Dictionary", {})	==> not really required, it's the default
		--		oop:New("Dictionary", someExternalTable)
		
		self.data = data or {}
	end,
	
	Get = function(self, key)
		return self.data[key]
	end,
		
	Add = function(self, key, value)
		self.data[key] = value
	end,
	
	Remove = function(self, key)
		self.data[key] = nil
	end,
	
	Toggle = function(self, key)
		self.data[key] = not self.data[key]
	end,

	Clear = function(self)
		wipe(self.data)
	end,
	
	Count = function(self)
		local count = 0
		
		for _, _ in pairs(self.data) do
			count = count + 1
		end
		
		return count
	end,
	
	Keys = function(self)
		local array = {}
		
		for k, _ in pairs(self.data) do
			-- insert every key
			TableInsert(array, k)
		end
		
		return array
	end,
	
	Values = function(self)
		local array = {}
		
		for _, v in pairs(self.data) do
			-- insert every value
			TableInsert(array, v)
		end
		
		return array
	end,
	
	SortedKeys = function(self, sortCallback)
		local array = self:Keys()
		
		-- Sort alphabetically by default if sortCallback is nil
		TableSort(array, sortCallback)
		
		return array
	end,
	
	SortedValues = function(self, sortCallback)
		local array = self:Values()
		
		-- Sort alphabetically by default if sortCallback is nil
		TableSort(array, sortCallback)
		
		return array
	end,
	
	ContainsKey = function(self, key)
		return self.data[key] ~= nil
	end,
	
	TryGetValue = function(self, key)
		-- Call : 
		--		local success, value = dict:TryGetValue("b")
		--		print(success, value) -- Output: false, nil
		
		if self.data[key] then
			return true, self.data[key] 
		end
		
		return false, nil 
	end,
	
	ContainsValue = function(self, value)
		for _, v in pairs(self.data) do 
			if v == value then return true end 
		end
		return false 
	end,
	
	ToTable = function(self) 
		return self.data
	end,
	
	ForEach = function(self, func) 
		for key, value in pairs(self.data) do
			func(key, value)
		end
	end,

	-- This function is useful to temporarily attach one dictionary to a given table,
	-- or to use the object on multiple tables without instanciating multiple objects.
	-- ex: you need to execute a :Count() on many tables
	-- => just attach them on the fly, do the count, and proceed with the next table.
	AttachTo = function(self, data)
		self.data = data
	end,

	--  To do : Clone

})
