--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub, parent = KROWI_LIBMAN:NewSubmodule('GameTooltipWithProgressBar', 0)
if not sub or not parent then return end

sub.ProgressBar = parent:GetNew(GameTooltip);
local progressBar = sub.ProgressBar

hooksecurefunc(GameTooltip, 'Hide', function()
	if progressBar then
		progressBar:Hide();
	end
end);

function sub:Show(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	progressBar:SetParent(gameTooltip);
	progressBar:Reset();
	progressBar:Add(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text);
	progressBar:Show();
end

function progressBar:Add(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	GameTooltip_AddBlankLinesToTooltip(gameTooltip, 1);
	local numLines = gameTooltip:NumLines();
	if not text then
		text = '';
	end
	self:SetPoint('LEFT', gameTooltip:GetName() .. 'TextLeft' .. numLines, 'LEFT', 0, -2);
	self:SetPoint('RIGHT', gameTooltip, 'RIGHT', -9, 0);
	self:SetHeight(25);
	self.TextLeft:SetText(text);
	self:SetMinMaxValues(min, max);
	self:SetValues(value1, value2, value3, value4);
	self:SetColors(color1, color2, color3, color4);
	self:UpdateTextures();
end