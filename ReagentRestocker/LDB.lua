--=====--
-- LDB --
--=====--

local addonName, addonTable = ...;
local oldEnv = getfenv();
setfenv(1,addonTable);


local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
local f = _G.CreateFrame("frame")
f:RegisterEvent("BAG_UPDATE");
local dataobj = nil;

-- Creates a a map icon for RR.
dbIcon = LibStub:GetLibrary("LibDBIcon-1.0", true)

addonTable.checkLow = function(self, event, ...)
	if dataobj==nil then dataobj={} end;
	for itemID, numItems in pairs(ReagentRestockerDB.Items) do
		if itemID==nil then derror("itemID == nil!") end
		if (ReagentRestocker:listType(itemID) == SHOPPING_TYPE) then
			if type(dataobj[itemID]) == "nil" then
			dataobj[itemID] = {};
				dataobj[itemID].warned = true;
			end
			if type(dataobj[itemID].warned) == "nil" then
				dataobj[itemID].warned = true;
			end
			if type(ReagentRestockerDB["Items"][itemID][LOW_WARNING])=="nil" then
				ReagentRestockerDB["Items"][itemID][LOW_WARNING] = 0;
			end
			
			--Trying to improve performance: pre-compute
			local itemCount = ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID);
			
			-- TODO: Not a complete fix.
			--if playerEnteredTime + 2 < _G.GetTime() and itemCount <  ReagentRestockerDB["Items"][itemID][LOW_WARNING] and dataobj[itemID].warned == false and ReagentRestockerDB.Options.ReagentWarning == true then
			if itemCount <  ReagentRestockerDB["Items"][itemID][LOW_WARNING] and dataobj[itemID].warned == false and ReagentRestockerDB.Options.ReagentWarning == true then
				if type(MikSBT) ~= "nil" then
					MikSBT.DisplayMessage(ReagentRestockerDB["Items"][itemID].item_name .. " is low!");
					--dprint(ReagentRestockerDB["Items"][itemID].item_name .. " is low: " .. ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID) .. " < " .. ReagentRestockerDB["Items"][itemID][LOW_WARNING]);
				else
					UIErrorsFrame:AddMessage(ReagentRestockerDB["Items"][itemID].item_name .. " is low!", nil, nil, nil, nil, 5);
					--dprint(ReagentRestockerDB["Items"][itemID].item_name .. " is low: " .. ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID) .. " < " .. ReagentRestockerDB["Items"][itemID][LOW_WARNING]);
				end
				dataobj[itemID].warned = true;
			elseif ReagentRestockerDB["Items"][itemID][LOW_WARNING] ~= nil and itemCount >  ReagentRestockerDB["Items"][itemID][LOW_WARNING] then
				dataobj[itemID].warned = false;
			end
		end
	end
end

if(ldb) then

	addonTable.updateLDB = function(self, event, ...)
		if dataobj==nil then dataobj={} end;
		
		-- Sometimes LDB is called before all variables are loaded.
		-- Ignore when that happens.
		if ReagentRestockerDB==nil then return end
		if ReagentRestocker.listType==nil then return end;
		if ReagentRestocker.safeGetItemInfo==nil then return end;
		-- Library loaded, add stuff
		--RRIcon128
		if ldb:GetDataObjectByName("Reagent Restocker") == nil then
			myLauncher = ldb:NewDataObject("Reagent Restocker", {
				type = "launcher",
				--icon = "Interface\\Icons\\INV_Alchemy_EndlessFlask_01",
				icon = "Interface\\AddOns\\ReagentRestocker\\RRIcon128",
				OnClick = function(self)
					ReagentRestockerDB.Options.UnusedNotification = false;
					ReagentRestocker:showFrame();
					--LibStub("AceConfigDialog-3.0"):Open("Reagent Restocker");
				end
				})
			
			-- Register Reagent Restocker to have a map icon, if available and enabled.
			if dbIcon then
				dbIcon:Register("Reagent Restocker", myLauncher, ReagentRestockerDB.MapTable)
				if ReagentRestockerDB.Options.MapIcon then
					dbIcon:Show("Reagent Restocker");
				else
					dbIcon:Hide("Reagent Restocker");
				end
			end
		end

		if ReagentRestockerDB.Options.SingleLDB == false then
			-- sl = how off from ideal we are . . .
			local sl = ReagentRestocker:getOffsetList(nil);
			for itemID, numItems in pairs(ReagentRestockerDB.Items) do
				if (ReagentRestocker:listType(itemID) == SHOPPING_TYPE) and sl[itemID]~=nil then

					--if sl[itemID]==nil then return end;
					if dataobj[itemID]==nil then
						local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount, iEquipLoc, iTexture = ReagentRestocker:safeGetItemInfo(itemID);
						if sName==nil then return end;
						if ReagentRestockerDB.Options.UseTextLDB and ldb:GetDataObjectByName("RR_"..sName) == nil then
							dataobj[itemID] = ldb:NewDataObject("RR_"..sName, {type = "data source", text = sName .. ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID), icon=iTexture})
						elseif ldb:GetDataObjectByName("RR_"..sName) == nil then
							dataobj[itemID] = ldb:NewDataObject("RR_"..sName, {type = "data source", text = ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID), icon=iTexture})
						end
						if dataobj[itemID]~=nil then
							if ReagentRestockerDB.Options.UseTextLDB then
								dataobj[itemID].label = "";
							else
								dataobj[itemID].label = sName;
							end
							dataobj[itemID].icon=iTexture;
							dataobj[itemID].sName=sName;
							dataobj[itemID].OnTooltipShow = function (self)
								self:AddLine(dataobj[itemID].label);
							end
							
							dataobj[itemID].OnEnter = function (self)
								GameTooltip:SetOwner(self, "ANCHOR_NONE")
								GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
								GameTooltip:ClearLines()
								dataobj[itemID].OnTooltipShow(GameTooltip)
								GameTooltip:Show()
							end
						
							dataobj[itemID].OnLeave = function (self)
								if GameTooltip then
									GameTooltip:Hide()
								end
							end
							
							
							dataobj[itemID].OnClick = function (self)
								ReagentRestockerDB.Options.UnusedNotification = false;
								ReagentRestocker:showFrame();
								--LibStub("AceConfigDialog-3.0"):Open("Reagent Restocker");
							end
						end
						
						if ReagentRestockerDB["Items"][itemID][LOW_WARNING] == nil then
							ReagentRestockerDB["Items"][itemID][LOW_WARNING] = 0;
						end
						
						if sl[itemID] >= (ReagentRestockerDB["Items"][itemID][QUANTITY_TO_STOCK] - ReagentRestockerDB["Items"][itemID][LOW_WARNING]) then
							dataobj[itemID].warned = true;
						else
							dataobj[itemID].warned = false;
						end
					end

					if sl[itemID] > 0 then
						if sl[itemID] > (ReagentRestockerDB["Items"][itemID][QUANTITY_TO_STOCK] - ReagentRestockerDB["Items"][itemID][LOW_WARNING]) then
							color = "|cFFFF7070"
						else
							color = "|cFFFFFF70"
							dataobj[itemID].warned = false;
						end
					else
						color = "|cFF70FF70"
						dataobj[itemID].warned = false;
					end
					
					if ReagentRestockerDB.Options.UseTextLDB then
						dataobj[itemID].label="";
						dataobj[itemID].text = dataobj[itemID].sName .. ": "..color..ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID);
					else
						dataobj[itemID].label=dataobj[itemID].sName;
						dataobj[itemID].text = color..ReagentRestocker:countItemInBags(getPlayerBagIDList(),itemID);
					end

				end
			end

		end
		checkLow(self, event, ...)
	end
	f:SetScript("OnEvent", addonTable.updateLDB);
	
	
	--f:SetScript("OnUpdate", function(self, elap)
	--	processQueueItem()
	--end)

--	f:SetScript("OnUpdate", function(self, elap)
--	end)
else
	-- Need to display warning even when there's no LDB.
	f:SetScript("OnEvent", addonTable.checkLow);
	
end

setfenv(1, oldEnv);
ReagentRestockerDB=addonTable.ReagentRestockerDB
