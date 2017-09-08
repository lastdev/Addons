
local tbl
do
	local _
	_, tbl = ...
end

do
	BadBoyIgnoreConfigTitle:SetText("BadBoy_Ignore v7.3.0") --packager magic, replaced with tag version
	local infoTbl = {}

	local addIgnore = CreateFrame("Frame", "BadBoy_IgnoreAdd", BadBoyConfig, "UIDropDownMenuTemplate")
	addIgnore:SetPoint("TOPLEFT", BadBoyIgnoreConfigTitle, "BOTTOMLEFT", -12, -5)
	BadBoy_IgnoreAddMiddle:SetWidth(180)
	BadBoy_IgnoreAddText:SetText(tbl.addPlayer)
	addIgnore.initialize = function()
		wipe(infoTbl)
		infoTbl.func = function(obj)
			BADBOY_IGNORE[obj.value] = true
		end
		for i=1, #tbl.names do
			infoTbl.text = tbl.names[i]
			UIDropDownMenu_AddButton(infoTbl)
		end
	end

	local removeIgnore = CreateFrame("Frame", "BadBoy_IgnoreRemove", BadBoyConfig, "UIDropDownMenuTemplate")
	removeIgnore:SetPoint("LEFT", addIgnore, "RIGHT", 180, 0)
	BadBoy_IgnoreRemoveMiddle:SetWidth(180)
	BadBoy_IgnoreRemoveText:SetText(tbl.removePlayer)
	removeIgnore.initialize = function()
		wipe(infoTbl)
		infoTbl.func = function(obj)
			BADBOY_IGNORE[obj.value] = nil
		end
		for k in next, BADBOY_IGNORE do
			infoTbl.text = k
			UIDropDownMenu_AddButton(infoTbl)
		end
	end
end

