local MVC = LibStub("LibMVC-1.0")

MVC:Service("AddonFactory.Classes", function() 
	-- Simple implementation of OOP, supports multiple levels of inheritance

	local classes = {}

--[[
Example of usage:

local oop = MVC:GetService("AddonFactory.Classes")

oop:Create("Vehicle", {
	Init = function(self, make, model, year)
		self.make = make
		self.model = model
	end,
	
	Print = function(self)
		print("Make: " .. self.make)
		print("Model: " .. self.model)
	end,

})

oop:Create("Car", {
	__inherits = "Vehicle",
	
	Init = function(self, make, model, year)
		self.Vehicle.Init(self, make, model)
		self.year = year
	end,
	
	Print = function(self)
		self.Vehicle.Print(self)
		print("Year: " .. self.year)
	end,

})

oop:Create("Truck", {
	__inherits = "Car",
	
	Init = function(self, make, model, year, capacity)
		self.Car.Init(self, make, model, year)
		self.capacity = capacity
	end,
	
	Print = function(self)
		self.Car.Print(self)
		print("Capacity: " .. self.capacity)
	end,

})


local car1 = oop:New("Car", "Toyota", "Corolla", 2020)
car1:Print()

local car2 = oop:New("Car", "Audi", "Q4 e-Tron", 2024)
car2:Print()

local truck = oop:New("Truck", "Ford", "F-150", 2021, "5 tons")
truck:Print()

--]]

	return {
		-- Create the definition of a new class
		Create = function(self, name, definition)
			if classes[name] then
				print("AddonFactory: Class already defined: " .. name)
				return
			end
						
			local class = definition or {}
			local base = class.__inherits
			local baseClass = base and classes[base]
						
			-- Set the base class, if provided
			if baseClass then
				-- Apply inheritance
				-- Use this:
				setmetatable(class, baseClass)
				
				-- Not this:
				-- setmetatable(class, {__index = baseClass})
				-- See explanation below, when doing this, it's not possible to go from the highest derived class to the base using metatables
				
				-- This allows for self.Vehicle.xxx, important for multiple inheritance
				-- This works, but allows only self.Base.Func(self, ....)
				-- The reason is that with self.Base:Func(....), then the self received in Func is the self of self.Base, and not of 'self'
				-- Note that this only matters for methods that are defined at multiple levels, this syntax is necessary to distinguish them
				class[base] = baseClass
			end
			
			class.__index = class

			-- Create a new instance
			function class:New(...)
				local instance = setmetatable({}, self)
				
				-- Constructor function
				if instance.Init then
					instance:Init(...)
				end
				
				return instance
			end
			
			-- Register our new class
			classes[name] = class

			return class
		end,

		New = function(self, name, ...)
			if classes[name] then
				return classes[name]:New(...)
			end
		end,
		
		Destroy = function(self, name)
			-- Destroy a class definition
			classes[name] = nil
		end,

	}
end)

--[[
Simple example of inheritance

Base = {}
Base.__index = Base

function Base:Display()
end

Derived = {}
Derived.__index = Derived		-- __index comes back to itself, not to the base !

-- mark this line, this basically sets the inheritance
setmetatable(Derived, Base)		

function Derived:Display()
end

--]]
