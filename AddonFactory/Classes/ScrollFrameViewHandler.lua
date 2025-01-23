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
	Init = function(self, scrollFrame, view)
		self.scrollFrame = scrollFrame
		self.view = view
		
		-- Automatically get the row height from the first row in the scrollframe
		self.rowHeight = scrollFrame:GetRow(1):GetHeight()
	end,
	
	SetView = function(self, view)
		self.view = view
	end,
	
	Update = function(self, isResizing, onRowUpdate)
		local scrollFrame = self.scrollFrame
		local numRows = scrollFrame.numRows
		local offset = scrollFrame:GetOffset()
		local viewSize = #self.view

		-- This handles the resize
		local maxDisplayedRows = math.floor(scrollFrame:GetHeight() / self.rowHeight)
		-- print(format("Scroll height: %d", scrollFrame:GetHeight()))
		-- print(format("frame height: %d, width: %d", frame:GetHeight(), frame:GetWidth()))
		-- print(maxDisplayedRows)

		-- Loop on all rows of the scrollframe
		for rowIndex = 1, numRows do
			local rowFrame = scrollFrame:GetRow(rowIndex)
			local line = rowIndex + offset
			
			-- If the line is visible ..
			if line <= viewSize and (rowIndex <= maxDisplayedRows) then
				if not (isResizing and rowFrame:IsVisible()) then
					onRowUpdate(rowFrame, line)
				end
				
				rowFrame:Show()
			else
				rowFrame:Hide()
			end
		end

		scrollFrame:Update(viewSize, maxDisplayedRows)
		
		return maxDisplayedRows
	end,
})
