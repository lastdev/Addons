local function OnEnter(tooltip)
	tooltip:SetText("Server Hop", 1, 1, 1);
	tooltip:AddLine(HOPADDON_TOGGLE, nil, nil, nil, 1);
	if hopAddon.var.hosting then
		tooltip:AddLine(" ")
		tooltip:AddLine(SERVERHOP_YOUREHOSTING)
	end
	tooltip:Show();
end

local function OnClick(self, button, down)
	if button == "RightButton" then
		-- add a good menu here
		-- like hosting, host list, searching for favs, hopping, options
	else
		if hopAddon:IsShown() then
			hopAddon:Hide()
		else
			hopAddon:Show()
		end
	end

	PlaySound("igMainMenuOptionCheckBoxOn")		
end


local minimapData = LibStub("LibDataBroker-1.1"):NewDataObject("ServerHopMinimapButton",{
	type = "launcher",
	text = "Server Hop",
	icon = "Interface\\Icons\\Achievement_General_StayClassy",
	OnClick =  OnClick,
	OnTooltipShow = OnEnter
})

local init = false

function hopAddon_MiniMapInit()
	hopAddon.minimap:Register("ServerHop", minimapData, hopAddon.var.minimapDB.global.minimap)
	
end

function hopAddon_MiniMapAnim()
	local holder = hopAddon.minimap.objects["ServerHop"]

	holder.Waitdot2 = holder:CreateTexture("Waitdot2","ARTWORK",nil,7)
	holder.Waitdot2:SetPoint("CENTER",0,0)
	holder.Waitdot2:SetAtlas("groupfinder-waitdot")
	holder.Waitdot2:SetSize(16,16)
	holder.Waitdot2:SetVertexColor(1,1,1,0)

	holder.Waitdot1 = holder:CreateTexture("Waitdot2","ARTWORK",nil,7)
	holder.Waitdot1:SetPoint("CENTER",-8,0)
	holder.Waitdot1:SetAtlas("groupfinder-waitdot")
	holder.Waitdot1:SetSize(10,10)
	holder.Waitdot1:SetVertexColor(1,1,1,0)

	holder.Waitdot3 = holder:CreateTexture("Waitdot2","ARTWORK",nil,7)
	holder.Waitdot3:SetPoint("CENTER",8,0)
	holder.Waitdot3:SetAtlas("groupfinder-waitdot")
	holder.Waitdot3:SetSize(10,10)
	holder.Waitdot3:SetVertexColor(1,1,1,0)

	holder.anim = holder:CreateAnimationGroup("HostingMinimap")
	holder.anim:SetLooping("REPEAT")

	SH_AddAlphaAnimation(holder.anim,"Waitdot1",0,0,1,1,1)
	SH_AddAlphaAnimation(holder.anim,"Waitdot2",0,0,1,1,1)
	SH_AddAlphaAnimation(holder.anim,"Waitdot3",0,0,1,1,1)
	SH_AddTranslationAnimation(holder.anim,"Waitdot1",0.15,0.15,1,0,4)
	SH_AddTranslationAnimation(holder.anim,"Waitdot1",0,0.15,2,0,-4)
	SH_AddTranslationAnimation(holder.anim,"Waitdot2",0.15,0.15,3,0,4)
	SH_AddTranslationAnimation(holder.anim,"Waitdot2",0,0.15,4,0,-4)
	SH_AddTranslationAnimation(holder.anim,"Waitdot3",0.15,0.15,5,0,4)
	SH_AddTranslationAnimation(holder.anim,"Waitdot3",0,0.15,6,0,-4)
end
