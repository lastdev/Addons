--[[ Class : FilterPipeline

Purpose : A simple pipeline to manage filters

Usage:

local pipeline = oop:New("FilterPipeline")

pipeline:Reset()	-- if necessary
	
pipeline:AddFilter(function(item) 
	-- do stuff, return true to keep the item, false otherwise
end)

pipeline:AddFilter(... more filters)
pipeline:AddFilter(... more filters)

pipeline:Run(someTable, 
	function(item) -- do stuff if the item passes filters   end,
	function(item) -- do stuff if the item fails to pass filters   end)

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert = table.insert

oop:Create("FilterPipeline", {
	Init = function(self)
		self:Reset()
	end,

	Reset = function(self)
		self.filters = {}
	end,
	
	-- Add a filter function to the pipeline
	AddFilter = function(self, func)
		TableInsert(self.filters, func)
	end,
	
	-- Run the pipeline
	-- items: table of items to iterate on (pairs/ipairs)
	-- onPass: function(item, key) called if all filters pass
	-- onFail (optional): function(item, key, failedFilterIndex)
	Run = function(self, items, onPass, onFail)
		for key, item in pairs(items) do
			local allFiltersPassed = true
			
			-- Loop on all filters
			for i, filter in ipairs(self.filters) do
			
				-- Execute the function
				if not filter(item) then
					allFiltersPassed = false
					if onFail then
						onFail(item, key, i)
					end
					break
				end
			end
		
			if allFiltersPassed then
				onPass(item, key)
			end
		end
	end,
})
