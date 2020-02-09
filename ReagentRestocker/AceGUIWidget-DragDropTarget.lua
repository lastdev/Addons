local AceGUI = LibStub("AceGUI-3.0")

-- WoW APIs
local _G = _G
local CreateFrame, UIParent = CreateFrame, UIParent

--------------------------
-- Button		        --
--------------------------
do
	local Type = "DragDropTarget"
	local Version = 12
	
	local function OnAcquire(self)
		-- restore default values
		self:SetHeight(30)
		self:SetWidth(44)
	end
	
	local function OnRelease(self)
		self.frame:ClearAllPoints()
		self.frame:Hide()
		self:SetDisabled(false)
	end
	
	local function Button_OnClick(this, ...)
		this.obj:Fire("OnClick", ...)
		AceGUI:ClearFocus()
	end
	
	local function Button_OnReceiveDrag(this, ...)
		this.obj:Fire("OnReceiveDrag", ...)
		AceGUI:ClearFocus()
	end

	local function Button_OnMouseUp(this, ...)
		this.obj:Fire("OnMouseUp", ...)
		AceGUI:ClearFocus()
	end
	
	local function Button_OnEnter(this)
		this.obj:Fire("OnEnter")
	end
	
	local function Button_OnLeave(this)
		this.obj:Fire("OnLeave")
	end
	
	local function SetText(self, text)
		self.text:SetText(text or "")
	end
	
	local function SetDisabled(self, disabled)
		self.disabled = disabled
		if disabled then
			self.frame:Disable()
		else
			self.frame:Enable()
		end
	end
	
	local function Constructor()
		local num  = AceGUI:GetNextWidgetNum(Type)
		local name = "AceGUI30"..Type..num
		local frame = CreateFrame("Button",name,UIParent,"UIPanelButtonTemplate")
		local self = {}
		self.num = num
		self.type = Type
		self.frame = frame
		
		-- Must be from Ace? Not standard Blizzard.
		local text = frame:GetFontString()
		
		if text == nil then
			text = frame:CreateFontString();
			text:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE, MONOCHROME")
			--error("Unable to get text!");
		end
		
		self.text = text

		frame:SetScript("OnClick",Button_OnClick)
		frame:SetScript("OnEnter",Button_OnEnter)
		frame:SetScript("OnLeave",Button_OnLeave)
		frame:SetScript("OnMouseUp",Button_OnMouseUp)
		frame:SetScript("OnReceiveDrag",Button_OnReceiveDrag)

		self.SetText = SetText
		self.SetDisabled = SetDisabled
		
		frame:EnableMouse(true)

		frame:SetHeight(24)
		frame:SetWidth(30)
		--frame:SetPoint("TOP", 0, -5)
	
		self.OnRelease = OnRelease
		self.OnAcquire = OnAcquire
		
		self.frame = frame
		frame.obj = self

		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
