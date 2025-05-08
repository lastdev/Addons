local MVC = LibStub("LibMVC-1.0")

MVC:Service("AddonFactory.Colors", { "AddonFactory.Classes", function(oop)

	oop:Create("Color", {
		Init = function(self, name, defaultHexValue, currentHexValue)
			self.name = name
			self.defaultHexValue = defaultHexValue
			self.currentHexValue = currentHexValue or defaultHexValue
		end,
		
		GetHexColorMarkup = function(self)
			-- return |cff 00FF00
			return format("|cff%s", self.currentHexValue)
		end,
		
		GetRGB = function(self)
			local hex = self.currentHexValue
			return ExtractColorValueFromHex(hex, 1), ExtractColorValueFromHex(hex, 3), ExtractColorValueFromHex(hex, 5)
		end,
		
		ShowPicker = function(self, onUpdate)
		
			-- links : 
			-- https://www.townlong-yak.com/framexml/56110/Blizzard_FrameXML/ColorPickerFrame.xml
			-- https://www.townlong-yak.com/framexml/56110/Blizzard_FrameXML/ColorPickerFrame.lua
			-- https://www.townlong-yak.com/framexml/56110/Blizzard_SharedXML/Color.lua
			-- https://www.townlong-yak.com/framexml/56110/Blizzard_SharedXML/ColorUtil.lua		
		
			-- Prepare to show the game's color picker
			local hex = self.currentHexValue
			self.oldHexValue = self.currentHexValue
			
			-- Get the rgb values
			local info = { r = ExtractColorValueFromHex(hex, 1), g = ExtractColorValueFromHex(hex, 3), b = ExtractColorValueFromHex(hex, 5) }

			-- This function is called back by the picker when the color changes
			info.swatchFunc = function()
				local r, g, b = ColorPickerFrame:GetColorRGB()
				self.currentHexValue = CreateColor(r, g, b):GenerateHexColorNoAlpha()
				
				onUpdate(self)
			end

			-- This function is called back if the user cancels the operation
			info.cancelFunc = function()
				-- restore old value
				self.currentHexValue = self.oldHexValue
				self.oldHexValue = nil
				
				onUpdate(self)
			end
			
			ColorPickerFrame:SetupColorPickerAndShow(info)
		end,
		
	})

	local colorList = oop:New("SQLTable")

	return {
		Register = function(colorName, defaultHexValue, currentHexValue)
			-- Call : service.Register("brackets", "ff9900", "00ffaa")
			return colorList:Insert(oop:New("Color", colorName, defaultHexValue, currentHexValue))
		end,
		
		Get = function(colorName)
			local result = colorList:SelectWhere("name", colorName)
			return result and result[1]
		end,
	}
	
end})
