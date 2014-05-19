function MistWeaver_FocusFrameOnLoad()
    MwFocusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");

    MwFocusFrame:SetMovable(true); 
    MwFocusFrame:SetUserPlaced(true); 
    MwFocusFrame:SetClampedToScreen(true);
    
    MistWeaver_SetBackdrop(MwFocusFrame);
    
    MwFocusFrame:SetParent(MistWeaverFrame);
    MwFocusFrame:Show();
    
    -- unit frame
    local unitFrame = _G["MwFocusUnitFrame"];
    if (not unitFrame) then
        unitFrame = MistWeaver_CreateFrame("Frame", "MwFocusUnitFrame", MwFocusFrame, MwUnitFrameTemplate);
        unitFrame:SetPoint("TOP", MwFocusFrame, "BOTTOM", 0, 5);
        
        MistWeaver_InitUnitFrame(unitFrame);
    
        unitFrame:SetSize(100, 50);
        MwFocusUnitFrameHealth:SetWidth(100);
        
        MistWeaver_FocusFrameFocusChanged();
        unitFrame:Show();
    end
    
    MistWeaver_StartDelay(3, MistWeaver_CheckFocusFrameVisibility);
    MistWeaver_FocusFrameFocusChanged();
end

function MistWeaver_CheckFocusFrameVisibility()  
    if (MistWeaverData.SHOW_FOCUS_FRAME == 1) then
        MwFocusFrame:Show();
    else
        MwFocusFrame:Hide();
    end
    
    if (MistWeaverData.SHOW_FOCUS_FRAME_HEADER == 1) then
        MistWeaver_SetBackdrop(MwFocusFrame);
        MwFocusFrame.title:Show();
    else
        MwFocusFrame:SetBackdrop(nil);
        MwFocusFrame.title:Hide();
    end
end

function MistWeaver_InitFocusSpells()  
    MwFocusUnitFrame.unit = "focus";
    MistWeaver_RebindSpells(MwFocusUnitFrame);
    MistWeaver_RebindRaidData(MwFocusUnitFrame, "focus");
end

function MistWeaver_FocusFrameOnEvent(self, event, ...)  
    if (event == "PLAYER_FOCUS_CHANGED") then
        MistWeaver_FocusFrameFocusChanged();
    end
end

function MistWeaver_FocusFrameOnMouseDown(frame, button)
    if (button == "RightButton") then
        if (IsControlKeyDown()) then
            MwFocusFrame:StartMoving();
        end
    end
end

function MistWeaver_FocusFrameOnMouseUp(frame, button)
    MwFocusFrame:StopMovingOrSizing();
end

function MistWeaver_FocusFrameFocusChanged()
    if (MistWeaver_IsActive() and UnitExists("focus")) then
        MwFocusFrame:SetAlpha(1.0);
        MwFocusUnitFrameHealth:SetAlpha(1.0);
        MwFocusUnitFrameHealthPrediction:SetAlpha(1.0);
        MwFocusUnitFrameAggro:SetAlpha(1.0);
        MwFocusUnitFrameSoothingMist:SetAlpha(1.0);
        MwFocusUnitFrameRenewingMist:SetAlpha(1.0);
        MwFocusUnitFrameEnvelopingMist:SetAlpha(1.0); 
        MwFocusUnitFrame.art:SetAlpha(1.0); 
        
        MwFocusUnitFrameRaidDetoxFrame:SetAlpha(1.0);
        
        if (MwFocusUnitFrameRaidClassIcon) then
        	MwFocusUnitFrameRaidClassIcon:SetAlpha(1.0);
        end
    else
        MwFocusFrame:SetAlpha(0.7);
        MwFocusUnitFrameHealth:SetAlpha(0.0);
        MwFocusUnitFrameHealthPrediction:SetAlpha(0.0);
        MwFocusUnitFrameAggro:SetAlpha(0.0);
        MwFocusUnitFrameSoothingMist:SetAlpha(0.0);
        MwFocusUnitFrameRenewingMist:SetAlpha(0.0); 
        MwFocusUnitFrameEnvelopingMist:SetAlpha(0.0);  
        MwFocusUnitFrame.art:SetAlpha(0.0);
        
        MwFocusUnitFrameRaidDetoxFrame:SetAlpha(0.0);
        
        if (MwFocusUnitFrameRaidClassIcon) then
        	MwFocusUnitFrameRaidClassIcon:SetAlpha(0.0);
        end
    end
end
    
function MistWeaver_DoFocusUpdate()     
    if (UnitExists("focus") and MwFocusFrame:IsVisible()) then
        MistWeaver_UpdateUnit(MwFocusUnitFrame, "focus");
        MistWeaver_SetUnitFrameAlpha(MwFocusUnitFrame, 1.0, 0.5);
    end
end

function MistWeaver_ReloadFocusStatusBarTexture()
    if (not MwFocusUnitFrameHealth) then
        MistWeaver_StartDelay(3, MistWeaver_ReloadFocusStatusBarTexture);
        return;
    end
    
    local texture = MistWeaver_GetStatusBarTexture();
    
    MwFocusUnitFrameHealth:SetStatusBarTexture(texture);
    MwFocusUnitFrameHealthPrediction:SetStatusBarTexture(texture);
    MwFocusUnitFrameRenewingMist:SetStatusBarTexture(texture);
    MwFocusUnitFrameSoothingMist:SetStatusBarTexture(texture);
    MwFocusUnitFrameEnvelopingMist:SetStatusBarTexture(texture);
end