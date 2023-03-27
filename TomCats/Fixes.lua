--[[ See license.txt for license and copyright information ]]
select(2, ...).SetScope()

local CreateFrame_Orig = CreateFrame

--[[
	Fix for broken GetContentHeight() for SimpleHTML which does not retrieve the height of wrapped text
]]
local function GetContentHeight(frame)
	local top = frame:GetTop()
	local bottom = top
	for _, region in ipairs({ frame:GetRegions() }) do
		local regionTop = region:GetTop()
		local regionBottom = regionTop - region:GetStringHeight()
		if (regionBottom < bottom) then
			bottom = regionBottom
		end
	end
	return top - bottom
end

--[[
	Fix for SimpleHTML issues whereas width of its contents is not resized automatically due to missing anchors
	and unexpected need to call GetWidth() on each region which will trigger a resize
]]
function CreateFrame(frameType, name, parent, template, id)
	local frame = CreateFrame_Orig(frameType, name, parent, template, id)
	if (string.upper(frameType) == "SIMPLEHTML" and template) then
		local w, h = frame:GetSize()
		local points = { }
		for i = 1, frame:GetNumPoints() do
			table.insert(points, { frame:GetPoint(i) })
		end
		if (w == 0 or h == 0) then
			frame:SetSize(1, 1)
		end
		if (#points == 0) then
			frame:SetPoint("CENTER")
		end
		for _, region in ipairs({ frame:GetRegions() }) do
			if (region:GetNumPoints() < 2) then
				region:SetPoint("RIGHT")
			end
			region:GetWidth()
		end
		frame:ClearAllPoints()
		for _, point in ipairs(points) do
			frame:SetPoint(unpack(point))
		end
		frame.GetContentHeight = GetContentHeight
	end
	return frame
end
