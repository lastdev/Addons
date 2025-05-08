--[[ Class : Array

Purpose : The name says it all, this turns an external table into an array, to offer some extension methods

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert, TableRemove = table.insert, table.remove

oop:Create("Array", {
	Init = function(self, data)
		self.data = data or {}
	end,

	Add = function(self, value)
		TableInsert(self.data, value)
	end,

	RemoveAt = function(self, index)
		TableRemove(self.data, index)
	end,

	Get = function(self, index)
		return self.data[index]
	end,

	Set = function(self, index, value)
		self.data[index] = value
	end,

	Count = function(self)
		return #self.data
	end,

	Find = function(self, value)
		for i, v in ipairs(self.data) do
			if v == value then return i end
		end
		
		return nil
	end,

	Clear = function(self)
		wipe(self.data)
	end,

	ToTable = function(self)
		return self.data
	end,

	InsertAt = function(self, index, value)
		TableInsert(self.data, index, value)
	end,

	InsertBefore = function(self, index, value)
		self:InsertAt(index, value)
	end,

	InsertAfter = function(self, index, value)
		if index < self:Count() then
			self:InsertAt(index + 1, value)
		else
			self:Add(value)
		end
	end,
	
	ForEach = function(self, func) 
		for key, value in ipairs(self.data) do
			func(key, value)
		end
	end,
	
	-- This function is useful to temporarily attach an array object to a given table,
	-- or to use the object on multiple tables without instanciating multiple objects.
	-- ex: you need to execute a :Count() on many tables
	-- => just attach them on the fly, do the count, and proceed with the next table.
	AttachTo = function(self, data)
		self.data = data
	end,
	
	-- *** As a queue ***
	
	-- Adds an element to the end of the array.
	Enqueue = function(self, value)
		TableInsert(self.data, value)
	end,

	-- Removes and returns the first element of the array.
	Dequeue = function(self)
		return TableRemove(self.data, 1)
	end,

	-- Returns the first element without removing it.
	Peek = function(self)
		return self.data[1]
	end,	
	
	-- *** As a stack ***
	
	-- Adds an element to the top of the stack.
	Push = function(self, value)
		TableInsert(self.data, value)
	end,

	-- Removes and returns the top element of the stack.
	Pop = function(self)
		return TableRemove(self.data)
	end,

	-- Returns the top element without removing it.
	Top = function(self, offset)
		offset = offset or 0
		return self.data[#self.data + offset]
	end,
	
	ClearAbove = function(self, index)
		for i = #self.data, index + 1, -1 do
			TableRemove(self.data, i)
		end
	end,
})
