-- Generic "frame"

-- This is a generic frame with a border. Meant to be placed inside a dialog,
-- not meant to be used standalone (although there is no code preventing it).

-- For now, just copied from dialog

local addonName, addonTable = ...;
--local GUI = LibStub("AceGUI-3.0");

local oldEnv = getfenv();
setfenv(1,addonTable);

-- List of items.

-- Yup, it's a constructor.
function Cobra.CreateFrame()
	local frame = _G.CreateFrame("Frame", "test", UIParent);
	
	frame.items = {}
	frame.items.length = 0;

	-- Get the children of the frame and resize it to fit.

	frame:SetWidth(400)
	frame:SetHeight(400)
	
	-- Looks weird, but GetChildren() returns a vararg, and I want it as a list.
	children = {frame:GetChildren()}
	
	-- Figure out what size the dialog needs to be.
	for key, value in pairs(children) do
		y_min = 768;
		x_min = 
	end
	
	frame:SetBackdrop({
		bgFile=[[Interface\DialogFrame\UI-DialogBox-Background]],
		edgeFile=[[Interface\DialogFrame\UI-DialogBox-Border]],
		tile="true",
		tileSize=32,
		edgeSize=32,
		insets = 
		{
			left=11,
			right=12,
			top=12,
			bottom=11
		}
	})
	
	-- Hook frame's hide and show methods in order to add an IsHidden method.
	frame.oldHide = frame.Hide;
	frame.oldShow = frame.Show;
	frame.merchantHidden = true;
	
	frame.Hide = function(self,...)
		self:oldHide(...);
		self.merchantHidden = true;
	end
	
	frame.Show = function(self,...)
		self:oldShow(...);
		self.merchantHidden = false;
	end
	
	frame:SetBackdropColor(0.75,0.75,0.75)
	frame:SetBackdropBorderColor(1,1,1)
	frame:SetFrameStrata("DIALOG")
	--frame:SetFrameStrata("BACKGROUND")
	frame:SetPoint("CENTER",0,0)
	--frame:Show()
	frame:Hide()
	
	frame.IsHidden = function(self)
		if self.merchantHidden ~= nil then
			return self.merchantHidden;
		else
			-- It's hidden at first.
			self.merchantHidden = true;
			return true;
		end
	end
	
	-- The whole reason we used IsHidden.
	frame.ToggleHide = function(self)
		if self:IsHidden(self) then
			self:Show()
		else
			self:Hide()
		end
	end
	
	-- add item to list
	function frame.addItem(text, icon, onclick)
		items[items.length+1].text = text;
		items[items.length+1].icon = icon;
		items[items.length+1].onclick = onclick;
		return items.length+1;
	end
	
	return frame;
end





