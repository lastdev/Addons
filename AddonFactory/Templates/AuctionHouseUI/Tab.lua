local MVC = LibStub("LibMVC-1.0")
local oop = MVC:GetService("AddonFactory.Classes")

oop:Create("AuctionHouseUI.Tab", {
	Init = function(self, extensions)
		-- Each function passed as extension is added to self, watch for overwrites !
		for name, func in pairs(extensions) do
			self[name] = func
		end
	end,
	
	RegisterPanel = function(frame, key, panel)
		-- a simple list of all the child frames
		frame.Panels = frame.Panels or {}
		frame.Panels[key] = panel
	end,
	HideAllPanels = function(frame)
		for _, panel in pairs(frame.Panels) do
			panel:Hide()
		end
	end,
	SetCurrentPanel = function(frame, panelKey)
		frame.currentPanelKey = panelKey
		return frame:GetCurrentPanel()
	end,
	GetCurrentPanel = function(frame)
		return frame.Panels[frame.currentPanelKey]
	end,
	ShowPanel = function(frame, panelKey)
		-- default to current panel
		panelKey = panelKey or frame.currentPanelKey
		if not panelKey then return end
		
		frame:HideAllPanels()
		
		local panel = frame:SetCurrentPanel(panelKey)
		panel:Show()

		if panel.PreUpdate then panel:PreUpdate() end
		panel:Update()
	end,
	
	SetTitle = function(frame, text)
		if frame.Title then
			frame.Title:SetText(text)
		end
	end,
	SetStatus = function(frame, text)
		if frame.Status then
			frame.Status:SetText(text)
		end
	end,
	Update = function(frame)
		frame:ShowPanel()
	end,
})
