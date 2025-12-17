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

Krowi_ProgressBarMixin = {};

local util = LibStub("Krowi_Util-1.0");

function Krowi_ProgressBarMixin:OnLoad()
	self.OffsetX = 4;
	self.OffsetY = 5;
end

function Krowi_ProgressBarMixin:OnSizeChanged()
	util.DelayFunction("Krowi_ProgressBar_OnSizeChanged", 0.01, self.Resize, self);
end

function Krowi_ProgressBarMixin:Resize()
	self.Background:ClearAllPoints();
	self.Background:SetPoint("TOPLEFT", self.BorderLeftTop, "BOTTOMRIGHT", -self.OffsetX, self.OffsetY);
	self.Background:SetPoint("BOTTOMRIGHT", self.BorderRightBottom, "TOPLEFT", self.OffsetX, -self.OffsetY);

	local offset = self:GetWidth() / 224;
	local barWidth = self.Background:GetWidth() + offset;
	for i, _ in next, self.Fill do
		local width = 0;
		if self.Max - self.Min > 0 then
			width = barWidth / (self.Max - self.Min) * self.Values[i];
		end
		self.Fill[i]:SetWidth(width);
		self.Fill[i]:ClearAllPoints();
		if i == 1 then
			self.Fill[i]:SetPoint("TOPLEFT", self.BorderLeftTop, "BOTTOMRIGHT", -self.OffsetX, self.OffsetY);
			self.Fill[i]:SetPoint("BOTTOMLEFT", self.BorderLeftBottom, "TOPRIGHT", -self.OffsetX, -self.OffsetY);
			if width == 0 then
				self.Fill[i]:SetPoint("RIGHT", self.BorderLeftMiddle, "RIGHT", -self.OffsetX, 0);
			end
		else
			self.Fill[i]:SetPoint("TOPLEFT", self.Fill[i - 1], "TOPRIGHT");
			self.Fill[i]:SetPoint("BOTTOMLEFT", self.Fill[i - 1], "BOTTOMRIGHT");
			if width == 0 then
				self.Fill[i]:SetPoint("RIGHT", self.Fill[i - 1]);
			end
		end

		local color = self.Colors[i];
		self.Fill[i]:SetVertexColor(color.R, color.G, color.B);
	end
end

function Krowi_ProgressBarMixin:AdjustOffsets(x, y)
	self.OffsetX = x;
	self.OffsetY = y;
end

function Krowi_ProgressBarMixin:SetMinMaxValues(min, max)
	self.Min = min;
	self.Max = max;
end

function Krowi_ProgressBarMixin:SetValues(value1, value2, value3, value4)
	self.Values = {value1, value2, value3, value4};
end

function Krowi_ProgressBarMixin:SetColors(color1, color2, color3, color4)
	local black = {R = 0, G = 0, B = 0};
	color1 = color1 or black;
	color2 = color2 or black;
	color3 = color3 or black;
	color4 = color4 or black;
	self.Colors = {color1, color2, color3, color4};
end

function Krowi_ProgressBarMixin:UpdateTextures()
	self:Resize();
end

function Krowi_ProgressBarMixin:Reset()
	self.Min = 0;
	self.Max = 0;
	self.Values = {0, 0, 0, 0};
	local black = {R = 0, G = 0, B = 0};
	self.Colors = {black, black, black, black};
end