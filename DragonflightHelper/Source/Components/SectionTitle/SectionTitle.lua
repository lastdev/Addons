DFH_SectionTitleMixin = {}

function DFH_SectionTitleMixin:OnLoad()
  if self.title == nil then
    self.title = ""
  end

  self:SetTitle(self.title)
end

function DFH_SectionTitleMixin:SetTitle(title)
  self.title = title

  self.Title:SetText(self.title)
end
