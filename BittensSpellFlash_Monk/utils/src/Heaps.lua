local u = BittensGlobalTables.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Heaps", 2) then
	return
end

-- A skew heap based on http://lua-users.org/lists/lua-l/2007-11/msg00375.html

-- "comparator" is not needed when the elements of the queue can be compared
-- with "<".  Otherwise provide it, where comparator(a, b) < 0 when "a" should
-- be above "b" in the heap.
function u.CreateHeap(comparator)
	local function meld(a, b)
	    if not (a and b) then
	        return a or b
	    elseif (comparator and comparator(a.Key, b.Key) < 0) 
	    	or (not comparator and a.Key < b.Key) then
	        
	        a.Left, a.Right = a.Right, meld(a.Left, b, comparator)
	        return a
	    else
	        b.Left, b.Right = b.Right, meld(a, b.Left, comparator)
	        return b
	    end
	end
	
	local queue
	return {
		Push = function(element)
			queue = meld(queue, { Key = element }, comparator)
		end,
		Peek = function()
			return queue and queue.Key
		end,
		Pop = function()
			if queue then
				local removed = queue.Key
				queue = meld(queue.Left, queue.Right)
				return removed
			end
		end,
		IsEmpty = function()
			return queue == nil
		end,
	}
end
