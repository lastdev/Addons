--[[
    Copyright (c) 2023 Krowi

    All Rights Reserved unless otherwise explicitly stated.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

---@diagnostic disable: undefined-global

local lib = LibStub:NewLibrary("Krowi_GameTooltipWithProgressBar-2.0", 1);

if not lib then
	return;
end

lib.ProgressBar = LibStub("Krowi_ProgressBar-2.0"):GetNew(GameTooltip);
local progressBar = lib.ProgressBar

hooksecurefunc(GameTooltip, "Hide", function()
	if progressBar then
		progressBar:Hide();
	end
end);

function lib:Show(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	progressBar:SetParent(gameTooltip);
	progressBar:Reset();
	progressBar:Add(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text);
	progressBar:Show();
end

function progressBar:Add(gameTooltip, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	GameTooltip_AddBlankLinesToTooltip(gameTooltip, 1);
	local numLines = gameTooltip:NumLines();
	if not text then
		text = "";
	end
	self:SetPoint("LEFT", gameTooltip:GetName() .. "TextLeft" .. numLines, "LEFT", 0, -2);
	self:SetPoint("RIGHT", gameTooltip, "RIGHT", -9, 0);
	self:SetHeight(25);
	self.TextLeft:SetText(text);
	self:SetMinMaxValues(min, max);
	self:SetValues(value1, value2, value3, value4);
	self:SetColors(color1, color2, color3, color4);
	self:UpdateTextures();
end