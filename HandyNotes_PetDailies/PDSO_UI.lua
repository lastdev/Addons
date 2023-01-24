local addonName = "PetDailies"
local addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
addon.UI = addon:NewModule("UI", "AceEvent-3.0")

local AceGUI = LibStub("AceGUI-3.0")

function addon.UI:OnInitialize()
    self.active_group = false
    self:Build(false)
end

function addon.UI:Build(withDB)
    local f = AceGUI:Create("Frame")
    f:SetTitle("Pet Dailies")
    f:SetWidth(400)
    f:SetHeight(500)
    f:SetLayout("Fill")
    tinsert(UISpecialFrames, f.frame:GetName())

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Flow")
    container:SetFullWidth(true)
    container:SetFullHeight(true)
    f:AddChild(container)

    local tabs = AceGUI:Create("TabGroup")
    tabs:SetTabs({
        {text = "All", value = 1},
        {text = "Zone", value = 2 },
        {text = "Achieves", value = 3}
    })
    tabs:SetFullWidth(true)
    tabs:SetCallback("OnGroupSelected", function (container, _, group) self:SelectGroup(container, group) end)
    container:AddChild(tabs)

    self.frame = f
    self.tabs = tabs
    if (withDB) then self:Show()
    else self.frame:Hide()
    end
end

function addon.UI:ReloadScroll(group)
    if self.scroll then
        self.scroll:ReleaseChildren()
        addon:BuildData(group)
    end
end

function addon.UI:Show(group)
    if group ~= nil then
    elseif self.active_group == false then
        group = 1
    else
        group = self.active_group
    end

    self:SelectTab(group)
    self:ReloadScroll(group)
    self.frame:Show()
end

function addon.UI:SelectTab(group)
    self.tabs:SelectTab(group)
end

function addon.UI:SelectGroup(container, group)
    local ht = 500
 
    container:ReleaseChildren()
    self.active_group = group

    --self.frame.statusbar:Hide()
    --self:HideCheckButtons()
--    container:SetLayout("Flow")
    local optionscontainer = AceGUI:Create("SimpleGroup")
    optionscontainer:SetFullWidth(true)
    optionscontainer:SetHeight(ht*.3)
    optionscontainer:SetLayout("Flow")
    container:AddChild(optionscontainer)
    self.options = options
    
    local scrollcontainer = AceGUI:Create("SimpleGroup")
    scrollcontainer:SetFullWidth(true)
    scroll:SetFullHeight(true)
    scrollcontainer:SetLayout("Fill")
    container:AddChild(scrollcontainer)
    
    local scroll = AceGUI:Create("ScrollFrame")
--    scroll:SetFullHeight(true)
    scroll:SetLayout("Flow")
    scrollcontainer:AddChild(scroll)
    self.scroll = scroll
  
    addon:BuildData(group)
end

function addon.UI:AddToScroll(f)
    self.scroll:AddChild(f)
end

function addon.UI:AddToFilter(f)
    self.filter:AddChild(f)
end

function addon.UI:CreateHeading(text)
    local heading = AceGUI:Create("Heading")
    heading:SetText(text)
    heading:SetFullWidth(true)

    return heading
end

function addon.UI:CreateScrollLabel(...)
    self:AddToScroll(self:CreateLabel(...))
end
function addon.UI:CreateDefScrollLabel(...)
    self:AddToScroll(self:CreateDefLabel(...))
end

function addon.UI:CreateFilterCheckbox(...)
    self:AddToFilter(self:CreateCheckbox(...))
end

function addon.UI:CreateScrollCheckbox(...)
    self:AddToScroll(self:CreateCheckbox(...))
end

function addon.UI:CreateFilterDropdown(...)
    self:AddToFilter(self:CreateDropdown(...))
end

function addon.UI:CreateLabel(text, icon, callbacks)
    local f = AceGUI:Create("WoWMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(20, 20)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function addon.UI:CreateDefLabel(text, icon, callbacks)
    local f = AceGUI:Create("WoWMeLabel")
    f:SetHighlight("Interface\\QuestFrame\\UI-QuestTitleHighlight")
    f:SetFontObject(SystemFont_Shadow_Med1)
    f:SetPoint("Top", 10, 10)
    f:SetFullWidth(true)

    if text ~= nil then
        f:SetText(text)
    end
    if icon ~= nil then
        f:SetImage(icon)
        f:SetImageSize(20, 20)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function addon.UI:AddCallbacks(f, callbacks)
    if callbacks ~= nil then
        for i,v in pairs(callbacks) do
            f:SetCallback(i, v)
        end
    end
end

function addon.UI:CreateCheckbox(label, value, callbacks, max_lines, height, enabled)
    local f = AceGUI:Create("CheckBox")

    if label ~= nil then
        f:SetLabel(label)
    end
    if value ~= nil then
        f:SetValue(value)
    end
    if max_lines ~= nil then
        f.text:SetMaxLines(max_lines)
    end
    if height ~= nil then
        f:SetHeight(height)
    end
    if enabled ~= nil then
        f:SetDisabled(not enabled)
    end

    f:SetFullWidth(true)
    f:SetPoint("Top", 15, 15)
    self:AddCallbacks(f, callbacks)
    return f
end
    
function addon.UI:CreateButton(text)
    local f = AceGUI:Create("Button")
    f.frame:SetHeight(20)
    f:SetHeight(20)
    f:SetWidth(130)
    f:SetText(text)
    f:SetCallback("OnClick", function () WayList:Map(id) end)
    return f
end

function addon.UI:CreateScrollButton( ... )
    self:AddToScroll(self:CreateButton(...))
end

function addon.UI:CreateDropdown(label, list, value, callbacks, multiselect, order)
    local f = AceGUI:Create("Dropdown")
    f:SetLabel(label)
    f:SetList(list, order)
    if multiselect ~= nil then
        f:SetMultiselect(multiselect)
    end
    f.label:ClearAllPoints()
    f.label:SetPoint("LEFT", 10, 15)
    f.dropdown:ClearAllPoints()
    f.dropdown:SetPoint("TOPLEFT",f.frame,"TOPLEFT",-10,-15)
    f.dropdown:SetPoint("BOTTOMRIGHT",f.frame,"BOTTOMRIGHT",17,0)
    if type(value) == "table" then
        for i = 1,#value do
            f:SetValue(value[i])
            f:SetItemValue(value[i], true)
        end
    else
        f:SetValue(value)
    end

    self:AddCallbacks(f, callbacks)
    return f
end

function addon.UI:CreateScrollGroup(iscomplete, _,_,tag,i_path,_)

    local l = AceGUI:Create("InteractiveLabel")
    l:SetText(tag)
    if (iscomplete) then l:SetColor(0,153,0) else l:SetColor(255,255,0) end
    l:SetFullWidth(true)
    l:SetImage("interface\\icons\\"..i_path)
    l:SetImageSize(25,25)
    return l

end

