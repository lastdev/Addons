--[[
    Armory Addon for World of Warcraft(tm).
    Revision: 572 2013-01-04T15:34:54Z
    URL: http://www.wow-neighbours.com

    License:
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License
        as published by the Free Software Foundation; either version 2
        of the License, or (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program(see GPL.txt); if not, write to the Free Software
        Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

    Note:
        This AddOn's source code is specifically designed to work with
        World of Warcraft's interpreted AddOn system.
        You have an implicit licence to use this AddOn with these facilities
        since that is it's designated purpose as per:
        http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]] 

local Armory, _ = Armory;

ArmoryStaticPopupDialogs = {};

ArmoryStaticPopupDialogs["ARMORY_DB_INCOMPATIBLE"] = {
    text = ARMORY_DB_INCOMPATIBLE,
    button1 = OKAY,
    showAlert = 1,
};

ArmoryStaticPopupDialogs["ARMORY_CHECK_MAIL_POPUP"] = {
    text = RED_FONT_COLOR_CODE..ARMORY_WARNING..": "..FONT_COLOR_CODE_CLOSE..ARMORY_CHECK_MAIL_POPUP,
    button1 = OKAY,
    showAlert = 1,
};

ArmoryStaticPopupDialogs["ARMORY_DELETE_CHARACTER"] = {
    text = ARMORY_DELETE_UNIT,
    button1 = YES,
    button2 = NO,
    OnAccept = function (self) ArmoryFrame_DeleteCharacter(self.data); end,
    OnShow = function (self)
        if ( Armory.summary and Armory.summary.locked ) then
            self:SetParent(Armory.summary);
        end
    end,
    OnHide = function (self)
        self:SetParent(UIParent);
        self.data = nil; 
    end,
    showAlert = 1,
    hideOnEscape = 1
};

ArmoryStaticPopupDialogs["ARMORY_DELETE_PET"] = {
    text = ARMORY_DELETE_UNIT,
    button1 = YES,
    button2 = NO,
    OnAccept = function (self) Armory:DeletePet(Armory:GetCurrentPet()); end,
    OnCancel = function (self) Armory.selectedPet = ArmoryPetFrame.selectedPet; end,
    OnHide = function (self) ArmoryPetFrame_Update(1); end,
    showAlert = 1,
    hideOnEscape = 1
};

function ArmoryStaticPopup_OnLoad(self)
    self:RegisterEvent("DISPLAY_SIZE_CHANGED");
end

function ArmoryStaticPopup_OnEvent(self, event, ...)
	self.maxHeightSoFar = 0;
	ArmoryStaticPopup_Resize(self, self.which);
end

function ArmoryStaticPopup_OnShow(self)
	PlaySound("igMainMenuOpen");

	local dialog = ArmoryStaticPopupDialogs[self.which];
	local OnShow = dialog.OnShow;
	
	if ( dialog.hideOnEscape ) then
	    table.insert(UISpecialFrames, "ArmoryStaticPopup");
	end

	if ( OnShow ) then
		OnShow(self, self.data);
	end
end

function ArmoryStaticPopup_OnHide(self)
	PlaySound("igMainMenuClose");
	
	local dialog = ArmoryStaticPopupDialogs[self.which];
	local OnHide = dialog.OnHide;
	local OnCancel = dialog.OnCancel;
	local noCancelOnEscape = dialog.noCancelOnEscape;

	if ( dialog.hideOnEscape ) then
	    for index, value in pairs(UISpecialFrames) do
		    if ( value == "ArmoryStaticPopup" ) then
	            table.remove(UISpecialFrames, index);
		        break;
		    end
		end
	end
	
	if ( not dialog.buttonClicked and OnCancel and not noCancelOnEscape) then
		OnCancel(self, self.data, "clicked");
	end
	if ( OnHide ) then
		OnHide(self, self.data);
	end
end

local tempButtonLocs = {};	--So we don't make a new table each time.
function ArmoryStaticPopup_Show(which, text_arg1, text_arg2, data)
	local info = ArmoryStaticPopupDialogs[which];
	if ( not info ) then
		return nil;
	end

	local dialog = ArmoryStaticPopup;

	dialog.maxHeightSoFar, dialog.maxWidthSoFar = 0, 0;
	-- Set the text of the dialog
	dialog.text:SetFormattedText(info.text, text_arg1, text_arg2);

	-- Show or hide the close button
	if ( info.closeButton ) then
		if ( info.closeButtonIsHide ) then
			dialog.closeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-HideButton-Up");
			dialog.closeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-HideButton-Down");
		else
			dialog.closeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up");
			dialog.closeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down");
		end
		dialog.closeButton:Show();
	else
		dialog.closeButton:Hide();
	end

	-- Set the miscellaneous variables for the dialog
	dialog.which = which;
	dialog.hideOnEscape = info.hideOnEscape;
	dialog.buttonClicked = nil;
	-- Clear out data
	dialog.data = data;
	
	do	-- If there is any recursion in this block, we may get errors (tempButtonLocs is static). If you have to recurse, we'll have to create a new table each time.
		assert(#tempButtonLocs == 0);	-- If this fails, we're recursing. (See the table.wipe at the end of the block)
		
		table.insert(tempButtonLocs, dialog.button1);
		table.insert(tempButtonLocs, dialog.button2);
		
		for i = #tempButtonLocs, 1, -1 do
			-- Do this stuff before we move it. (This is why we go back-to-front)
			tempButtonLocs[i]:SetText(info["button"..i]);
			tempButtonLocs[i]:Hide();
			tempButtonLocs[i]:ClearAllPoints();
			-- Now we possibly remove it.
			if ( not (info["button"..i] and (not info["DisplayButton"..i] or info["DisplayButton"..i](dialog))) ) then
				table.remove(tempButtonLocs, i);
			end
		end
		
		local numButtons = #tempButtonLocs;
		-- Save off the number of buttons.
		dialog.numButtons = numButtons;
		
        if ( numButtons == 2 ) then
			tempButtonLocs[1]:SetPoint("BOTTOMRIGHT", dialog, "BOTTOM", -6, 16);
		elseif ( numButtons == 1 ) then
			tempButtonLocs[1]:SetPoint("BOTTOM", dialog, "BOTTOM", 0, 16);
		end
		
		for i = 1, numButtons do
			if ( i > 1 ) then
				tempButtonLocs[i]:SetPoint("LEFT", tempButtonLocs[i-1], "RIGHT", 13, 0);
			end
			
			local width = tempButtonLocs[i]:GetTextWidth();
			if ( width > 110 ) then
				tempButtonLocs[i]:SetWidth(width + 20);
			else
				tempButtonLocs[i]:SetWidth(120);
			end
			tempButtonLocs[i]:Enable();
			tempButtonLocs[i]:Show();
		end
		
		table.wipe(tempButtonLocs);
	end

	-- Show or hide the alert icon
	if ( info.showAlert ) then
		dialog.icon:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew");
		dialog.icon:Show();
	else
		dialog.icon:SetTexture();
		dialog.icon:Hide();
	end

	-- Finally size and show the dialog
	ArmoryStaticPopup_Resize(dialog, which);
	dialog:Show();

	if ( info.sound ) then
		PlaySound(info.sound);
	end

	return dialog;
end

function ArmoryStaticPopup_Hide(which, data)
	local dialog = ArmoryStaticPopup;
	if ( (dialog.which == which) and (not data or (data == dialog.data)) ) then
		dialog:Hide();
	end
end

function ArmoryStaticPopup_OnClick(dialog, index)
	dialog.buttonClicked = true;
	if ( not dialog:IsShown() ) then
		return;
	end
	local which = dialog.which;
	local info = ArmoryStaticPopupDialogs[which];
	if ( not info ) then
		return;
	end
	local hide = true;
	if ( index == 1 ) then
		local OnAccept = info.OnAccept;
		if ( OnAccept ) then
			hide = not OnAccept(dialog, dialog.data, dialog.data2);
		end
	else
		local OnCancel = info.OnCancel;
		if ( OnCancel ) then
			hide = not OnCancel(dialog, dialog.data, "clicked");
		end
	end

	if ( hide and which == dialog.which ) then
		-- can dialog.which change inside one of the On* functions???
		dialog:Hide();
	end
end

function ArmoryStaticPopup_Resize(dialog, which)
	local info = ArmoryStaticPopupDialogs[which];
	if ( not info ) then
		return;
	end

	local maxHeightSoFar, maxWidthSoFar = (dialog.maxHeightSoFar or 0), (dialog.maxWidthSoFar or 0);
	local width = 320;
	
	if ( info.showAlert or info.closeButton ) then
		-- Widen
		width = 420;
	end
	if ( width > maxWidthSoFar )  then
		dialog:SetWidth(width);
		dialog.maxWidthSoFar = width;
	end
	
	local height = 32 + dialog.text:GetHeight() + 8 + dialog.button1:GetHeight();
	if ( height > maxHeightSoFar ) then
		dialog:SetHeight(height);
		dialog.maxHeightSoFar = height;
	end
end