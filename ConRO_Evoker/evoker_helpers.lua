local ConRO_Evoker, ids = ...;

local defaults = {

}

ConROEvoker = ConROEvoker or defaults;

local Empowered_Color = {
    blue = {r = 0.01, b = 0.37, g = 0.79};
    red = {r = 0.8, b = 0, g = 0};
    green = {r = 0.01, b = 0.37, g = 0.78};
}

function ConRO:CreateEmpoweredFrame()
	local frame = CreateFrame("Frame", "ConROEmpoweredFrame", UIParent);
		frame:SetMovable(true);
		frame:SetClampedToScreen(true);
		frame:RegisterForDrag("LeftButton");
		frame:SetScript("OnEnter", TDWOnEnter);
		frame:SetScript("OnLeave", TDWOnLeave);
		frame:SetScript("OnDragStart", function(self)
			if ConRO.db.profile._Unlock_ConRO then
				frame:StartMoving()
			end
		end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing);
		frame:EnableMouse(ConRO.db.profile._Unlock_ConRO);

		frame:SetPoint("CENTER", 0, -150);
		frame:SetSize(80, 80);
		frame:SetFrameStrata('MEDIUM');
		frame:SetFrameLevel('73');
		frame:SetAlpha(1.0);
		frame:Hide();

	local t = frame.texture;
		if not t then
			t = frame:CreateTexture("ARTWORK")
			t:SetTexture('Interface\\AddOns\\ConRO\\images\\Empowered_Surge_1');
			t:SetBlendMode('BLEND')
			local color = Empowered_Color.red;
			t:SetVertexColor(color.r, color.g, color.b);
			frame.texture = t;
		end

		t:SetAllPoints(frame)

    local ag1 = t:CreateAnimationGroup()
        t.ag1 = ag1

        t.ag1:SetLooping("REPEAT")

    local a11 = t.ag1:CreateAnimation("Rotation")
        a11:SetDegrees(-360)
        a11:SetDuration(4)
        t.ag1.a1 = a11

        t.ag1:Play()

	local fontstring = frame.font;
		if not fontstring then
			fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
			fontstring:SetText("1");
            fontstring:SetFont("Fonts\\FRIZQT__.TTF", 26,"OUTLINE")
			fontstring:SetTextColor(1, 1, 1, 1);
			fontstring:SetPoint('CENTER', frame, 'CENTER', 0, 0);
			fontstring:SetJustifyV("BOTTOM");
			frame.font = fontstring;
		end
end

ConRO:CreateEmpoweredFrame();
