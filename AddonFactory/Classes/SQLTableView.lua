--[[ Class : SQLTableView

Purpose : Create a view on a SQLTable object.

Features : 
- Insert, Select, Update, Delete
- Triggers
- Stored procedures
- Joins
- Aggregations (Count, Sum, Min, Max, Average)
- Can be used in conjunction with the class SQLTable

Example of usage:
=================

local chars = oop:New("SQLTable", "Characters")

chars:Insert({id = 1, name = "Alice"})
chars:Insert({id = 2, name = "Bob"})

local view = oop:New("SQLTableView", chars, function(r) return r.id ~= 1 end)

view:Update() 		-- when necessary

for i, r in ipairs(view:GetData()) do
    print(i, r.id, r.name)
end

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert = table.insert


oop:Create("SQLTableView", {
	Init = function(self, source, condition)
		self.source = source
		self.condition = condition
		self.pointers = {}
		
		self:Update()
	end,
	
	Update = function(self)
		wipe(self.pointers)
		
		-- Select the rows that match the condition, and save their indexes
		for i, record in pairs(self.source:SelectWithIndex(self.condition)) do
			TableInsert(self.pointers, i)
		end
	end,
	
	GetData = function(self)
		local results = {}
		
		for _, index in ipairs(self.pointers) do
			TableInsert(results, self.source:GetRow(index))
		end
		
		return results
	end,
	
	GetRow = function(self, index)
		return self.source:GetRow(self.pointers[index])
	end,
	
	GetSize = function(self)
		return #self.pointers
	end,
	
})
