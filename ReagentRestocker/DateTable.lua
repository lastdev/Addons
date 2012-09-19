-- DateTable

-- Manages a table of dates that stores data.

-- Since this is a sparse and very deep table, it's best not to pollute
-- other code with these functions, hence the separate file.

-- adds data using a very specific date. This database is accurate to 1 second.
function addDate(year, month, day, hour, min, second, table, data)
	if table[year] == nil then
		table[year] = {}
	end

	if table[year][month] == nil then
		table[year][month] = {}
	end

	if table[year][month][day] == nil then
		table[year][month][day] = {}
	end
	
	if table[year][month][day][hour] == nil then
		table[year][month][day][hour] = {}
	end

	
	if table[year][month][day][hour][min] == nil then
		table[year][month][day][hour][min] = {}
	end
	
	table[year][month][day][hour][min][sec] = data

end

function addCurrent(year, month, day, hour, min, sec, table, data)
	curDate = _G.date("!*t");
	
	addDate(curDate.year, curDate.month, curDate.day, curDate.hour, curDate.min, curDate.sec, table, data);
end

-- Get an iterator representing the last good entry before the current date.
-- Lua has a VERY convenient date format for this.
function getCurrentIterator()
	iterate = _G.date("!*t");
	return getPrev(iterate);
end

-- Checks if a date exists
function validDate(table, iterator)
	if table[iterator.year][iterator.month][iterator.day][iterator.hour][iterator.min][iterator.sec] == nil
		return false
	else
		return true
	end
end

-- Find the next available time in the database.
function getNext(table, iterator)
	newIter = {}
	newIter.year = iterator.year;
	newIter.month = iterator.month;
	newIter.day = iterator.day;
	newIter.hour = iterator.hour;
	newIter.min = iterator.min;
	newIter.sec = iterator.sec;
	
	
	
	for int sec = iterator.sec+1, 60 do
		newIter.sec = sec;
		if validDate(newIter) then
			return newIter;
		end
	end

	for int min = iterator.min+1, 60 do
		newIter.min = min;
		if validDate(newIter) then
			return newIter;
		end
	end

end
