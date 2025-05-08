--[[ Class : ScrollFrameViewHandler

Purpose : Handles the view associated to a scroll frame.

A scroll frame may be define to display 30 rows maximum, but because it handles resizing, only 20 rows may be able to be displayed
at a certain time.

Furthermore, the view to display may contain 100 rows to display, but there is only room for 20.

This class handles the UI updates.

--]]

local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

oop:Create("ScrollFrameViewHandler", {
	Init = function(self, scrollFrame)
		self.scrollFrame = scrollFrame
		
		-- Automatically get the row height from the first row in the scrollframe
		self.rowHeight = scrollFrame:GetRow(1):GetHeight()
	end,
	
	GetLastMaxRows = function(self)
		return self.maxDisplayedRows
	end,
	
	Update = function(self, viewSize, isResizing, onRowUpdate)
		local scrollFrame = self.scrollFrame
		local numRows = scrollFrame.numRows
		local offset = scrollFrame:GetOffset()

		-- This handles the resize
		self.maxDisplayedRows = math.floor(scrollFrame:GetHeight() / self.rowHeight)
		local maxRows = self.maxDisplayedRows
		-- print(format("Scroll height: %d", scrollFrame:GetHeight()))

		-- Loop on all rows of the scrollframe
		for rowIndex = 1, numRows do
			local rowFrame = scrollFrame:GetRow(rowIndex)
			local line = rowIndex + offset
			
			-- If the line is visible ..
			if line <= viewSize and (rowIndex <= maxRows) then
				if not (isResizing and rowFrame:IsVisible()) then
					onRowUpdate(rowFrame, line)
				end
				
				rowFrame:Show()
			else
				rowFrame:Hide()
			end
		end

		scrollFrame:Update(viewSize, maxRows)
	end,
})
