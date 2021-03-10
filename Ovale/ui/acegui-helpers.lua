local __exports = LibStub:NewLibrary("ovale/ui/acegui-helpers", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local CreateFrame = CreateFrame
local AceGUI = LibStub:GetLibrary("AceGUI-3.0", true)
__exports.Widget = __class(AceGUI.WidgetBase, {
    constructor = function(self, frame)
        self.userdata = {}
        self.events = {}
        self.base = AceGUI.WidgetBase
        self.handleFrameResize = function()
            if self.frame:GetWidth() and self.frame:GetHeight() then
                if self.OnWidthSet then
                    self.OnWidthSet(self.frame:GetWidth())
                end
                if self.OnHeightSet then
                    self.OnHeightSet(self.frame:GetHeight())
                end
            end
        end
        AceGUI.WidgetBase.constructor(self)
        self.frame = frame
        self.frame.obj = self
        self.frame:SetScript("OnSizeChanged", self.handleFrameResize)
    end,
})
__exports.WidgetContainer = __class(AceGUI.WidgetContainerBase, {
    constructor = function(self, frame)
        self.children = {}
        self.userdata = {}
        self.events = {}
        self.base = AceGUI.WidgetContainerBase
        self.width = 0
        self.height = 0
        self.handleFrameResize = function()
            if self.frame:GetWidth() and self.frame:GetHeight() then
                if self.OnWidthSet then
                    self.OnWidthSet(self.frame:GetWidth())
                end
                if self.OnHeightSet then
                    self.OnHeightSet(self.frame:GetHeight())
                end
            end
        end
        self.handleContentResize = function()
            if self.content:GetWidth() and self.content:GetHeight() then
                self.width = self.content:GetWidth()
                self.height = self.content:GetHeight()
                self:DoLayout()
            end
        end
        AceGUI.WidgetContainerBase.constructor(self)
        local content = CreateFrame("Frame", nil, frame)
        content:SetScript("OnSizeChanged", self.handleContentResize)
        frame:SetScript("OnSizeChanged", self.handleFrameResize)
        self.content = content
        self.content.obj = self
        self.frame = frame
        self.frame.obj = self
        self:SetLayout("List")
    end,
})
