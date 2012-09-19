local toggled = true
local r,g,b,a = 1,0,1,1
local options = {"foo", "bar", "foobar"}
local optIndex = 1
local rangeVal, rangeVal2 = 100, 10
local inherits = {["inherittoggle"] = true}

Outfitter.MinimapDropdownTable = {
   type = "group",
   name = "group",
   desc = "group",
   args = {
      foo = {
         type = "input",
         name = "text",
         desc = "text desc",
         get = function(info) return "texting!" end,
         set = function(info, v) end
      },
      inherit = {
         type = "group",
         name = "inheritance test",
         desc = "inheritance test",
         get = function(info) ChatFrame1:AddMessage(("Got getter, getting %s (%s)"):format(tostring(info[#info]), tostring(inherits[info[#info]]))); return inherits[info[#info]] end,
         set = function(info, v) ChatFrame1:AddMessage("Got setter:" .. tostring(v)); inherits[info[#info]] = v end,
         args = {
            inherittoggle = {
               type = "toggle",
               name = "inherit toggle",
               desc = "inherit toggle"
            },
         }
      },
      exec = {
         type = "execute",
         name = "Say hi",
         desc = "Execute, says hi",
         func = function() ChatFrame1:AddMessage("Hi!") end
      },
      range = {
         type = "range",
         name = "Range slider",
         desc = "Range slider",
         min = 0,
         max = 800,
         bigStep = 50,
         get = function(info) return rangeVal end,
         set = function(info, v) rangeVal = v end,                      
      },
      range2 = {
         type = "range",
         name = "Range slider 2",
         desc = "Range slider 2",
         min = 0,
         max = 80,
         bigStep = 5,
         get = function(info) return rangeVal2 end,
         set = function(info, v) rangeVal2 = v end,                     
      },                
      toggle = {
         type = "toggle",
         name = "Toggle",
         desc = "Toggle",
         get = function() return toggled end,
         set = function(info, v) toggled = v end,
         disabled = function(info) return not toggled end
      },
      toggle3 = {
         type = "toggle",
         name = "Tristate Toggle Tristate Toggle Tristate Toggle",
         desc = "Tristate Toggle",
         tristate = true,
         get = function() return toggled end,
         set = function(info, v) toggled = v end
      },                
      select = {
         type = "select",
         name = "select",
         desc = "select desc",
         values = options,
         get = function(info) return optIndex end,
         set = function(info, v) optIndex = v end
      },
      color = {
         type = "color",
         name = "color swatch",
         desc = "color swatch desc",
         get = function(info) return r,g,b,a end,
         set = function(info, _r,_g,_b,_a) r,g,b,a = _r,_g,_b,_a end
      },
      foo3 = {
         type = "group",
         name = "group!",
         desc = "group desc",
         args = {
            toggle3 = {
               type = "toggle",
               name = "Tristate Toggle Tristate Toggle Tristate Toggle",
               desc = "Tristate Toggle",
               tristate = true,
               get = function() return toggled end,
               set = function(info, v) toggled = v end
            },  
         }
      },
      foo4 = {
         type = "group",
         name = "inline group!",
         desc = "inline group desc",
         inline = "true",
         args = {
            foo2 = {
               type = "input",
               name = "text3",
               desc = "text3 desc",
               get = function(info) return "texting!" end,
               set = function(info, v) end
            }
         },
         order = 500
      },                
      close = {
         type = "execute",
         name = "Close",
         desc = "Close this menu",
         func = function(self)  end,
         order = 1000
      }
   }
}

function Outfitter.MinimapButton_MouseDown(self)
	-- Remember where the cursor was in case the user drags
	
	local vCursorX, vCursorY = GetCursorPosition()
	
	vCursorX = vCursorX / self:GetEffectiveScale()
	vCursorY = vCursorY / self:GetEffectiveScale()
	
	OutfitterMinimapButton.CursorStartX = vCursorX
	OutfitterMinimapButton.CursorStartY = vCursorY
	
	local vCenterX, vCenterY = OutfitterMinimapButton:GetCenter()
	local vMinimapCenterX, vMinimapCenterY = Minimap:GetCenter()
	
	OutfitterMinimapButton.CenterStartX = vCenterX - vMinimapCenterX
	OutfitterMinimapButton.CenterStartY = vCenterY - vMinimapCenterY
	
	OutfitterMinimapButton.EnableFreeDrag = IsModifierKeyDown()
end

function Outfitter.MinimapButton_DragStart(self)
	Outfitter.SchedulerLib:ScheduleUniqueRepeatingTask(0, Outfitter.MinimapButton_UpdateDragPosition, self)
end

function Outfitter.MinimapButton_DragEnd(self)
	Outfitter.SchedulerLib:UnscheduleTask(Outfitter.MinimapButton_UpdateDragPosition, self)
end

function Outfitter.MinimapButton_UpdateDragPosition(self)
	-- Remember where the cursor was in case the user drags
	
	local vCursorX, vCursorY = GetCursorPosition()
	
	vCursorX = vCursorX / self:GetEffectiveScale()
	vCursorY = vCursorY / self:GetEffectiveScale()
	
	local vCursorDeltaX = vCursorX - OutfitterMinimapButton.CursorStartX
	local vCursorDeltaY = vCursorY - OutfitterMinimapButton.CursorStartY
	
	--
	
	local vCenterX = OutfitterMinimapButton.CenterStartX + vCursorDeltaX
	local vCenterY = OutfitterMinimapButton.CenterStartY + vCursorDeltaY
	
	if OutfitterMinimapButton.EnableFreeDrag then
		Outfitter.MinimapButton_SetPosition(vCenterX, vCenterY)
	else
		-- Calculate the angle and set the new position
		
		local vAngle = math.atan2(vCenterX, vCenterY)
		
		Outfitter.MinimapButton_SetPositionAngle(vAngle)
	end
end

function Outfitter:RestrictAngle(pAngle, pRestrictStart, pRestrictEnd)
	if pAngle <= pRestrictStart
	or pAngle >= pRestrictEnd then
		return pAngle
	end
	
	local vDistance = (pAngle - pRestrictStart) / (pRestrictEnd - pRestrictStart)
	
	if vDistance > 0.5 then
		return pRestrictEnd
	else
		return pRestrictStart
	end
end

function Outfitter.MinimapButton_SetPosition(pX, pY)
	gOutfitter_Settings.Options.MinimapButtonAngle = nil
	gOutfitter_Settings.Options.MinimapButtonX = pX
	gOutfitter_Settings.Options.MinimapButtonY = pY
	
	OutfitterMinimapButton:SetPoint("CENTER", Minimap, "CENTER", pX, pY)
end

function Outfitter.MinimapButton_SetPositionAngle(pAngle)
	local vAngle = pAngle
	
	-- Restrict the angle from going over the date/time icon or the zoom in/out icons
	--[[
	local vRestrictedStartAngle = nil
	local vRestrictedEndAngle = nil
	
	if GameTimeFrame:IsVisible() then
		if MinimapZoomIn:IsVisible()
		or MinimapZoomOut:IsVisible() then
			vAngle = Outfitter:RestrictAngle(vAngle, 0.4302272732931596, 2.930420793963121)
		else
			vAngle = Outfitter:RestrictAngle(vAngle, 0.4302272732931596, 1.720531504573905)
		end
		
	elseif MinimapZoomIn:IsVisible()
	or MinimapZoomOut:IsVisible() then
		vAngle = Outfitter:RestrictAngle(vAngle, 1.720531504573905, 2.930420793963121)
	end
	
	-- Restrict it from the tracking icon area
	
	vAngle = Outfitter:RestrictAngle(vAngle, -1.290357134304173, -0.4918423429923585)
	]]--
	
	--
	
	local vRadius = 80
	
	local vCenterX = math.sin(vAngle) * vRadius
	local vCenterY = math.cos(vAngle) * vRadius
	
	OutfitterMinimapButton:SetPoint("CENTER", Minimap, "CENTER", vCenterX - 1, vCenterY - 1)
	
	gOutfitter_Settings.Options.MinimapButtonAngle = vAngle
end

function Outfitter.MinimapButton_ToggleMenu(self)
	if false then
		if Outfitter.MinimapMenuFrame then
			Outfitter.MinimapMenuFrame:Hide()
			Outfitter.MinimapMenuFrame = nil
		else
			Outfitter.MinimapMenuFrame = LibStub("LibDropdown-1.0"):OpenAce3Menu(Outfitter.MinimapDropdownTable)
			Outfitter.MinimapMenuFrame:SetPoint("TOPRIGHT", self, "TOPRIGHT", -20, -20)
		end
	else
		if UIDROPDOWNMENU_OPEN_MENU == self and DropDownList1:IsShown() then
			CloseDropDownMenus()
		else
			Outfitter.MinimapDropDown_OnLoad(self)
			self.ChangedValueFunc = Outfitter.MinimapButton_ItemSelected
			ToggleDropDownMenu(nil, nil, self, self, 22, 1)
			
			-- Hack to force the menu to position correctly.  UIDropDownMenu code
			-- keeps thinking that it's off the screen and trying to reposition
			-- it, which it does very poorly
			
			Outfitter.MinimapDropDown_AdjustScreenPosition(self)
		end
	end
	PlaySound("igMainMenuOptionCheckBoxOn")
end

function Outfitter.MinimapButton_ItemSelected(pMenu, pValue)
	if type(pValue) == "table" then
		local vCategoryID = pValue.CategoryID
		local vIndex = pValue.Index
		local vOutfit = gOutfitter_Settings.Outfits[vCategoryID][vIndex]
		local vDoToggle = vCategoryID ~= "Complete"
		
		if IsModifierKeyDown() then
			Outfitter:AskSetCurrent(vOutfit)
		elseif vDoToggle
		and Outfitter:WearingOutfit(vOutfit) then
			Outfitter:RemoveOutfit(vOutfit)
		else
			Outfitter:WearOutfit(vOutfit)
		end
		
		if vDoToggle then
			return true
		end
	elseif pValue == 0 then -- Open Outfitter
		Outfitter:OpenUI()
	elseif pValue == -1 then -- Change AutoSwitch Value.
		Outfitter:SetAutoSwitch(gOutfitter_Settings.Options.DisableAutoSwitch)
		return true
	end

	return false
end

