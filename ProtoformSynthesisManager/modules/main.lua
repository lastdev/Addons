local AddonInfo = {...};
_G[AddonInfo[1]] = _G[AddonInfo[1]] or {};

local gridOffset = 38;
local itemFramePadding = 5;

local Frames = {};

local UpdateItemFrame = function(self)
	self.tooltipItemInfo = self.itemInfo;

	local itemTexture = self.itemInfo and self.itemInfo[10];
	if self.cost then
		local count = 0;
		if self.itemInfo then
			if self.itemInfo[13] == 5 then
				-- Mount
				local mountInfo = {C_MountJournal.GetMountInfoByID(C_MountJournal.GetMountFromItem(self.itemID) or 0)}
				if mountInfo[11] then
					count = 1;
				end
			else
				-- Pet
				local petInfo = {C_PetJournal.GetPetInfoByItemID(self.itemID)};
				count = petInfo and petInfo[13] and C_PetJournal.GetNumCollectedInfo(petInfo[13]) or 0;
			end
		end

		if count > 0 then
			self.text:SetTextColor(0, 1, 0, 1);
		elseif self.questID and not C_QuestLog.IsQuestFlaggedCompleted(self.questID) then
			itemTexture = self.questItemInfo and self.questItemInfo[10];
			self.tooltipItemInfo = self.questItemInfo;
			self.text:SetTextColor(1, 0.65, 0, 1);
		else
			self.text:SetTextColor(1, 1, 1, 1);
		end

		self.text:SetText(self.cost);
		self.text:Show();
	else
		-- Mats
		local count = C_Item.GetItemCount(self.itemID, true, false, true, true);
		if count then
			self.text:SetTextColor(1, 1, 1, 1);
			self.text:SetText(tostring(count));
			self.text:Show();
		else
			self.text:Hide();
		end
	end

	if itemTexture and itemTexture ~= self.itemTexture then
		self.itemTexture = itemTexture;
		self.texture:SetTexture(itemTexture);
	end
end

local SetItemInfo;
SetItemInfo = function(self)
	local isNeedRetry = false;

	if self.itemInfo == nil then
		local itemInfo = { C_Item.GetItemInfo(self.itemID) };
		if #itemInfo > 0 then
			self.itemInfo = itemInfo;
		else
			isNeedRetry = true;
		end
	end

	if self.questItemID and self.questItemInfo == nil then
		local questItemInfo = { C_Item.GetItemInfo(self.questItemID) };
		if #questItemInfo > 0 then
			self.questItemInfo = questItemInfo;
		else
			isNeedRetry = true;
		end
	end

	if isNeedRetry then
		C_Timer.After(
			0.1,
			function()
				SetItemInfo(self);
			end
		);
	else
		UpdateItemFrame(self);
	end
end

ProtoformSynthesisManagerItemFrame_OnShow = function(self)
	UpdateItemFrame(self);
end

ProtoformSynthesisManagerItemFrame_OnEvent = function(self)
	UpdateItemFrame(self);
end

ProtoformSynthesisManagerItemFrame_OnEnter = function(self)
	local GameTooltip = _G["GameTooltip"];
	local itemLink = self.tooltipItemInfo and self.tooltipItemInfo[2];
	if itemLink then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(itemLink);
	end
end

local DrawGridLine = function(index, relativePoint, ofsX, ofsY)
	local parent = Frames.MainFrame["GridFrame"];
	local line = parent:CreateLine(nil, "BACKGROUND");
	line:SetStartPoint("TOPLEFT", ofsX * index, ofsY * index);
	line:SetEndPoint(relativePoint, ofsX * index, ofsY * index);
	line:SetThickness(2);

	if index == 15 and ofsX ~= 0 then
		line:SetColorTexture(1, 0.65, 0, 1);
	else
		line:SetColorTexture(1, 1, 1, 1);
	end
end

local CreateMatsItemFrame = function(parent, index, itemID, relativePoint, ofsX, ofsY)
	local itemFrame = CreateFrame("Frame", nil, parent, "ProtoformSynthesisManagerItemFrameTemplate");

	itemFrame.SetParentKey = itemFrame.SetParentKey;
	itemFrame:SetParentKey("ItemFrame"..index);
	if index == 1 then
		itemFrame:SetPoint("TOPLEFT");
	else
		itemFrame:SetPoint("TOPLEFT", parent["ItemFrame"..(index - 1)], relativePoint, ofsX, ofsY);
	end

	itemFrame.itemID = itemID;

	SetItemInfo(itemFrame);
end

local CreateCollectionItemFrame = function(itemID, posX, posY, cost)
	local parent = Frames.MainFrame["CollectionItemsFrame"];
	local itemFrame = CreateFrame("Frame", nil, parent, "ProtoformSynthesisManagerItemFrameTemplate");
	itemFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", gridOffset * (posX - 1), gridOffset * (1 - posY));

	itemFrame.itemID = itemID;
	itemFrame.cost = cost;

	local questInfo = _G[AddonInfo[1]].QuestItems[itemID];
	if questInfo then
		itemFrame.questItemID = questInfo[1];
		itemFrame.questID = questInfo[2];
	end

	SetItemInfo(itemFrame);
end

local CreateMainFrame = function(parent)
	Frames.MainFrame = CreateFrame("Frame", nil, parent, "ProtoformSynthesisManagerMainFrameTemplate");

	DrawGridLine(0, "BOTTOMLEFT", gridOffset, 0);
	for index, itemID in ipairs(_G[AddonInfo[1]].UntradableMatsIDs) do
		DrawGridLine(index, "BOTTOMLEFT", gridOffset, 0);
		CreateMatsItemFrame(Frames.MainFrame["UntradableMatsFrame"], index, itemID, "TOPRIGHT", itemFramePadding, 0);
	end

	DrawGridLine(0, "TOPRIGHT", 0, -gridOffset);
	DrawGridLine(1, "TOPRIGHT", 0, -gridOffset);
	for index, itemID in ipairs(_G[AddonInfo[1]].TradableMatsIDs) do
		DrawGridLine(index + 1, "TOPRIGHT", 0, -gridOffset);
		CreateMatsItemFrame(Frames.MainFrame["TradableMatsFrame"], index, itemID, "BOTTOMLEFT", 0, -itemFramePadding);
	end

	for itemID, value in pairs(_G[AddonInfo[1]].CollectionItems) do
		CreateCollectionItemFrame(itemID, value[1], value[2], value[3]);
	end

	parent:SetScript(
		"OnShow",
		function()
			Frames.MainFrame:Hide();
		end
	);
end

ProtoformSynthesisManagerToggleButton_OnClick = function(self)
	if Frames.MainFrame == nil then
		CreateMainFrame(_G["CollectionsJournal"]);
	end

	if Frames.MainFrame:IsShown() then
		Frames.MainFrame:Hide();
	else
		Frames.MainFrame:Show();
	end
end

local SetupFuncs = {};
SetupFuncs["Blizzard_Collections"] = function(addOnName)
	local parent = MountJournal.SummonRandomFavoriteSpellFrame.Button;
	local ToggleButton = CreateFrame("Button", nil, parent, "ProtoformSynthesisManagerToggleButtonTemplate");

	local loaded, finished = C_AddOns.IsAddOnLoaded("MountJournalEnhanced");
	if loaded and finished then
		ToggleButton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -220, -1);
		ToggleButton.Text:Hide();
	else
		ToggleButton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -300, 0);
	end

	SetupFuncs[addOnName] = nil;
end

local loadFrame = CreateFrame("Frame");
loadFrame:RegisterEvent("ADDON_LOADED");
loadFrame:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "ADDON_LOADED" then
			local addOnName = ...;
			local funcs = SetupFuncs[addOnName];
			if funcs then
				funcs(addOnName);
			end
		end
	end
);
