--[[ Class : SQLTable

Purpose : Create a lua table that can be used roughly like an SQL table.

Features : 
- Insert, Select, Update, Delete
- Triggers
- Stored procedures
- Joins
- Aggregations (Count, Sum, Min, Max, Average)
- Can be used in conjunctions with the class SQLTableView

Example of usage:
=================

local chars = oop:New("SQLTable", "Characters")
or
local chars = oop:New("SQLTable", "Characters", someExternalTable)

chars:Insert({id = 1, name = "Alice"})
chars:Insert({id = 2, name = "Bob"})

local selection = chars:Select(function(r) return r.id == 1 end)
local selection = chars:SelectWhere("id", 1, "city", "Paris")

for i, r in ipairs(selection) do
    print(i, r.id, r.name)
end

chars:Update(function(r) return r.id == 1 end, {name = "Alicia"})
chars:UpdateWhere("id", 1, {name = "Alicia"})

chars:Delete(function(r) return r.id == 1 end)
chars:DeleteWhere("id", 1)

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

local TableInsert, TableRemove, TableSort = table.insert, table.remove, table.sort

-- rather than test everywhere if the condition is nil or not, make an empty alternative
local optionalCondition = function() return true end


oop:Create("SQLTable", {
	Init = function(self, name, externalData)
		self.name = name
		self.data = externalData or {}	-- if we want to map this object to an external pre-existing source
	end,

	GetData = function(self)
		return self.data
	end,

	GetRow = function(self, index)
		return self.data[index]
	end,
	
	GetSize = function(self)
		return #self.data
	end,
	
	IterateRows = function(self, action, condition)
		--[[
			Call: obj:IterateRows(
							function(r) print(r.name) end, 			-- Action to execute on selected rows 
							function(r) return r.id == 1 end, 		-- Condition to select rows 
					)
		--]]
		
		condition = condition or optionalCondition
	
		for _, record in ipairs(self.data) do
			if condition(record) then
				action(record)
			end
		end
	end,
	
	Sort = function(self, ...)
		-- Call : obj:Sort("name", "asc", "age", "desc")
		-- Arguments : ... = field, asc/desc, field, asc/desc ..
		local args = {...}

		TableSort(self.data, function(a, b)
			for i = 1, #args, 2 do
				local fieldName = args[i]
				local order = args[i + 1] or "asc"
				
				if a[fieldName] ~= b[fieldName] then
					if order == "asc" then
						return a[fieldName] < b[fieldName]
					else
						return a[fieldName] > b[fieldName]
					end
				end
			end
			
			return false
		end)
	end,
	
	-- *** INSERT, SELECT, UPDATE, DELETE ***
	
	Insert = function(self, record)
		-- Call : obj:Insert({id = 2, name = "Bob"})
		TableInsert(self.data, record)
		self:ExecuteTriggers("insert", record)
	end,
	
	Select = function(self, condition)
		-- Call : obj:Select(function(r) return r.id == 1 end)
		-- Note : this is a select, condition is not optional ! If you want all data, use GetData()
		if not condition then return self:GetData() end
		
		local results = {}
		
		for _, record in ipairs(self.data) do
			if condition(record) then
				TableInsert(results, record)
			end
		end
		
		return results
	end,
	
	SelectWithIndex = function(self, condition)
		-- Call : obj:SelectWithIndex(function(r) return r.id == 1 end)
		-- Note : this is a select, condition is not optional ! If you want all data, use GetData()
		-- Same as select, but also returns the position of the matching records, useful for views
		
		local results = {}
		
		for index, record in ipairs(self.data) do
			if condition(record) then
				results[index] = record
			end
		end
		
		return results
	end,
	
	SelectWhere = function(self, ...)
		-- Call : obj:SelectWhere("id", 1, "city", "Paris")
		-- Arguments : ... = field, value, field, value .. implicitly joined by an AND.
	
		local args = {...}
		local results = {}
		
		-- Loop on all records
		for _, record in ipairs(self.data) do
			local allMatches = true
			
			-- Read parameters 2 by 2
			for i = 1, #args, 2 do
				local field = args[i]
				local value = args[i + 1]
				
				-- Field matches ?
				if record[field] ~= value then
					allMatches = false
					break
				end
			end
			
			if allMatches then
				TableInsert(results, record)
			end
		end
		
		return results
	end,

	SelectDistinct = function(self, field)
		-- Call : obj:SelectDistinct("name")
		
		local uniqueValues = {}
		local valueSet = {}

		for _, record in ipairs(self.data) do
			local value = record[field]
			
			if value and not valueSet[value] then
				valueSet[value] = true
				TableInsert(uniqueValues, value)
			end
		end

		TableSort(uniqueValues)
		return uniqueValues
	end,

	Update = function(self, condition, newRecord)
		-- Call : obj:Update( function(r) return r.id == 1 end, {name = "Alicia"})
		-- Note : this is an update, condition is not optional !
		
		for i, record in ipairs(self.data) do
			if condition(record) then
				-- Only update the fields present in newRecord
				for field, value in pairs(newRecord) do
					record[field] = value
				end
				self:ExecuteTriggers("update", record)
			end
		end
	end,

	UpdateWhere = function(self, ...)
		-- Call : obj:UpdateWhere("id", 1, {name = "Alicia"})
		-- Arguments : ... = field, value, field, value .. implicitly joined by an AND.
		-- Last argument : new record values
		
		local args = {...}
		local newRecord = TableRemove(args)
		
		for _, record in ipairs(self.data) do
			local allMatches = true
			
			-- Read parameters 2 by 2
			for i = 1, #args, 2 do
				local field = args[i]
				local value = args[i + 1]
				
				if record[field] ~= value then
					allMatches = false
					break
				end
			end
		
			if allMatches then
				for field, value in pairs(newRecord) do
					record[field] = value
				end
				self:ExecuteTriggers("update", record)
			end
		end
	end,
	
	Delete = function(self, condition)
		-- Call : obj:Delete(function(r) return r.id == 1 end)
		condition = condition or optionalCondition
		
		-- Loop from last to first, to preserve indexes
		for i = #self.data, 1, -1 do
			if condition(self.data[i]) then
				local record = TableRemove(self.data, i)
				self:ExecuteTriggers("delete", record)
			end
		end
	end,
	
	DeleteWhere = function(self, ...)
		-- Call : obj:DeleteWhere("id", 1, "city", "Paris")
		-- Arguments : ... = field, value, field, value .. implicitly joined by an AND.
		
		local args = {...}
		
		-- Loop from last to first, to preserve indexes
		for i = #self.data, 1, -1 do
			local allMatches = true
			
			-- Read parameters 2 by 2
			for j = 1, #args, 2 do
				local field = args[j]
				local value = args[j + 1]
				
				if self.data[i][field] ~= value then
					allMatches = false
					break
				end
			end

			if allMatches then
				local record = TableRemove(self.data, i)
				self:ExecuteTriggers("delete", record)
			end
		end
	end,

	-- *** INDEXES ***

	CreateIndex = function(self, field)
		-- Call : obj:CreateIndex("name")
		
		self.indexes = self.indexes or {}
		self.indexes[field] = {}
		
		local fieldIndex = self.indexes[field]
		
		for i, record in ipairs(self.data) do
			local key = record[field]			-- ex: record.name
			
			if not fieldIndex[key] then
				fieldIndex[key] = {}
			end
			
			-- index["name"] = { ..., 5 }  , we just inserted index for row 5
			TableInsert(fieldIndex[key], i)
		end
	end,
	
	UpdateIndexes = function(self, record, index)
		if not self.indexes then return end
	
		-- we just modified a record: inserted or updated, so check all known indexes for impact
		for field, indexTable in pairs(self.indexes) do
			local key = record[field]
			
			-- does the record have this field ? yes
			if key then
				-- was it indexed previously ? no
				if not indexTable[key] then
					indexTable[key] = {}
				end
				
				TableInsert(indexTable[key], index)
			end
		end
	end,
	
	SelectIndexed = function(self, field, value)
		-- Call : local selectedUsers = users:SelectIndexed("name", "Alice")
		local results = {}
		
		if self.indexes then
			local fieldIndex = self.indexes[field]
		
			if fieldIndex and fieldIndex[value] then
			
				-- Loop on all the rows which for this field, have this value
				for _, index in ipairs(fieldIndex[value]) do
					TableInsert(results, self.data[index])
				end
			end
		end
		
		return results
	end,
	
	
-- Method to update indexes, do not use yet, indexes need finalizing & testing
-- RemoveIndex = function(self, record, index)
	-- if not self.indexes then return end
	
	-- we just modified a record: updated or deleted, so check all known indexes for impact
    -- for field, indexTable in pairs(self.indexes) do
        -- local key = record[field]
		  
		  -- does the record have this field ? yes
        -- if key then
		  
			 -- for i, idx in ipairs(indexTable[key]) do
				  -- if idx == index then
						-- TableRemove(indexTable[key], i)
						-- break
				  -- end
			 -- end
        -- end
    -- end
-- end,

-- Method to update indexes
-- function Table:updateIndexes(record, index, remove)
    -- for field, index_table in pairs(self.indexes) do
        -- local key = record[field]
        -- if key then
            -- if remove then
                -- for i, idx in ipairs(index_table[key]) do
                    -- if idx == index then
                        -- TableRemove(index_table[key], i)
                        -- break
                    -- end
                -- end
            -- else
                -- if not index_table[key] then
                    -- index_table[key] = {}
                -- end
                -- TableInsert(index_table[key], index)
            -- end
        -- end
    -- end
-- end


-- UPDATE operation
-- function Table:update(condition, new_record)
    -- for i, record in ipairs(self.data) do
        -- if condition(record) then
            -- self:updateIndexes(record, i, true) -- Remove old index
            -- for key, value in pairs(new_record) do
                -- record[key] = value
            -- end
            -- self:updateIndexes(record, i, false) -- Add new index
            -- self:executeTriggers("update", record)
        -- end
    -- end
-- end


-- DELETE operation
-- function Table:delete(condition)
    -- for i = #self.data, 1, -1 do
        -- if condition(self.data[i]) then
            -- self:updateIndexes(self.data[i], i, true) -- Remove old index
            -- local record = TableRemove(self.data, i)
            -- self:executeTriggers("delete", record)
        -- end
    -- end
-- end


	
	
	
	-- *** TRIGGERS ***

	AddTrigger = function(self, event, action)
		-- Call : obj:AddTrigger("insert", function(r) print("Inserted:", r.name) end)
		
		self.triggers = self.triggers or { insert = {}, update = {}, delete = {} }
		if self.triggers[event] then
			TableInsert(self.triggers[event], action)
		else 
			print(format("SQLTable: Invalid trigger event type : %s", event))
		end
	end,
	
	ExecuteTriggers = function(self, event, record)
		-- Call : obj:ExecuteTriggers("insert", record)
		
		if self.triggers and self.triggers[event] then
			for _, action in ipairs(self.triggers[event]) do
				action(record)
			end
		end
	end,
	
	-- *** STORED PROCEDURES ***

	AddProcedure = function(self, name, procedure)
		--[[ Call :
			obj:AddProcedure("findByName", function(self, name) 
				return self:Select(function(r) return r.name == name end) 
			end)
		--]]
	
		self.procedures = self.procedures or {}
		self.procedures[name] = procedure
	end, 
	
	ExecuteProcedure = function(self, name, ...)
		-- Call : local found_users = users:ExecuteProcedure("findByName", "Alice")
	
		if self.procedures and self.procedures[name] then
			return self.procedures[name](self, ...) 
		else 
			print(format("SQLTable: Procedure %s not found!", name))
		end
	end,
	
	-- *** JOINS ***

	Join = function(self, rightTable, leftKey, rightKey)
	
--[[

local users = oop:New("SQLTable", "Users")
local orders = oop:New("SQLTable", "Orders")
local products = oop:New("SQLTable", "Products") 

-- ** Insert records **

users:Insert({id = 1, name = "Alice"})
users:Insert({id = 2, name = "Bob"})

orders:Insert({order_id = 101, user_id = 1, product_id = 1001}) 
orders:Insert({order_id = 102, user_id = 2, product_id = 1002}) 

products:Insert({product_id = 1001, product_name = "Laptop"}) 
products:Insert({product_id = 1002, product_name = "Phone"}) 

-- ** Perform joins **

local user_orders = users:Join(orders, "id", "user_id") 
local user_order_products = oop:New("SQLTable", "UserOrderProducts")
user_order_products.data = user_orders 

local final_join = user_order_products:Join(products, "product_id", "product_id") 

-- ** Print results **

for i, r in ipairs(final_join) do 
	print(i, r.id, r.name, r.order_id, r.product_id, r.product_name) 
end


--]]	
	
		local results = {}
		
		for _, left in ipairs(self.data) do
			for _, right in ipairs(rightTable.data) do
				
				-- match data from both tables
				if left[leftKey] == right[rightKey] then 
					local joinedRecord = {} 
					
					for k, v in pairs(left) do
						joinedRecord[k] = v
					end 
					
					for k, v in pairs(right) do
						joinedRecord[k] = v
					end
					
					TableInsert(results, joinedRecord)
				end 
			end
		end 
		
		return results
	end,
	
	-- *** AGGREGATIONS ***
	
	Count = function(self, condition)
		-- Call : obj:Count(function(r) return r.age > 20 end)
		condition = condition or optionalCondition
		
		local count = 0
		
		for _, record in ipairs(self.data) do
			if condition(record) then
				count = count + 1
			end
		end
		
		return count
	end,

	Sum = function(self, field, condition)
		-- Call : obj:Sum("age", function(r) return r.age > 20 end)
		condition = condition or optionalCondition
		
		local sum = 0
		
		for _, record in ipairs(self.data) do
			if condition(record) then
				sum = sum + record[field]
			end
		end
		
		return sum
	end,

	Average = function(self, field, condition)
		-- Call : obj:Average("age", function(r) return r.age > 20 end)
		condition = condition or optionalCondition
		
		local sum = 0
		local count = 0
		
		for _, record in ipairs(self.data) do
			if condition(record) then
				sum = sum + record[field]
				count = count + 1
			end
		end
		
		return count > 0 and sum / count or 0
	end,
	
	Min = function(self, field, condition)
		-- Call : obj:Min("age", function(r) return r.age > 20 end)
		condition = condition or optionalCondition
		
		local value

		for _, record in ipairs(self.data) do
			if condition(record) then
				if not value or record[field] < value then
					value = record[field]
				end
			end
		end

		return value
	end,
	
	Max = function(self, field, condition)
		-- Call : obj:Max("age", function(r) return r.age > 20 end)
		condition = condition or optionalCondition
		
		local value

		for _, record in ipairs(self.data) do
			if condition(record) then
				if not value or record[field] > value then
					value = record[field]
				end
			end
		end

		return value
	end,
	
})

