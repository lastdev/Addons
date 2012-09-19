function PoJ_Notes_DeleteButtonClick()
  if PoJ_Notes.SelectedNote then
    table.remove(PoJ_Notes.Notes, PoJ_Notes.SelectedNote)
    PoJ_Notes.SelectedNote = nil
    PoJ_Notes_Update()
  end
end


function PoJ_Notes_NameButtonClick()
  PoJ_Notes_SaveNote()
  PoJ_Notes.Mode = "edit"
  local dialog = StaticPopup_Show("POJ_NOTES_TITLE")
  _G[dialog:GetName() .. "EditBox"]:SetText(PoJ_Notes.Notes[PoJ_Notes.SelectedNote].title)
end


function PoJ_Notes_NewButtonClick()
  PoJ_Notes_SaveNote()
  PoJ_Notes.Mode = "new"
  StaticPopup_Show("POJ_NOTES_TITLE")
end


function PoJ_Notes_OnHide()
  PoJ_Notes_SaveNote()
  PlaySound("igCharacterInfoClose")
end


function PoJ_Notes_OnLoad(self)
  PoJ_Notes_Title:SetText(POJ_STRING.NOTES.TITLE)
  PoJ_NotesTab1:SetText(POJ_STRING.NOTES.GENERAL)
  PoJ_NotesTab2:SetText(POJ_STRING.NOTES.CHAR)
  PanelTemplates_TabResize(PoJ_NotesTab1, 0)
  PanelTemplates_TabResize(PoJ_NotesTab2, 0)
  PoJ_NotesTab1HighlightTexture:SetWidth(PoJ_NotesTab1:GetTextWidth() + 30)
  PoJ_NotesTab2HighlightTexture:SetWidth(PoJ_NotesTab2:GetTextWidth() + 30)
  PanelTemplates_SetNumTabs(PoJ_Notes, 2)
  PanelTemplates_SetTab(PoJ_Notes, 1)
  PoJ_NotesNameButton:SetText(POJ_STRING.NOTES.NAME)
  FauxScrollFrame_SetOffset(PoJ_NotesTitleScrollFrame, 0)
  for i = 1, 8 do
    _G["PoJ_NotesTitle" .. i]:SetNormalTexture("")
    _G["PoJ_NotesTitle" .. i .. "Text"]:SetPoint("TOPLEFT", "PoJ_NotesTitle" .. i, "TOPLEFT", 3, 0)
    _G["PoJ_NotesTitle" .. i .. "Highlight"]:SetTexture("")
  end
  PoJ_NotesHighlightTexture:SetVertexColor(1, 0.82, 0)
  
  UIPanelWindows["PoJ_Notes"] = {area = "left", pushable = 5, whileDead = 1}
  
  StaticPopupDialogs["POJ_NOTES_TITLE"] = {
    text = POJ_STRING.NOTES.NAMETITLE,
    button1 = TEXT(ACCEPT),
    button2 = TEXT(CANCEL),
    hasEditBox = 1,
    maxLetters = 20,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1,
    OnAccept = function(self)
      PoJ_Notes_SetTitle(_G[self:GetName() .. "EditBox"]:GetText())
    end,
    OnShow = function(self)
      _G[self:GetName() .. "EditBox"]:SetFocus()
    end,
    OnHide = function(self)
      _G[self:GetName() .. "EditBox"]:SetText("")
    end,
    EditBoxOnEnterPressed = function(self)
      PoJ_Notes_SetTitle(_G[self:GetParent():GetName() .. "EditBox"]:GetText())
      self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
      self:GetParent():Hide()
    end
  }
  
end


function PoJ_Notes_OnShow()
  PlaySound("igCharacterInfoOpen")
  PoJ_Notes_Update()
end


function PoJ_Notes_SaveNote()
  if PoJ_Notes.NoteChanged then
    if PoJ_Notes.SelectedNote then
      PoJ_Notes.Notes[PoJ_Notes.SelectedNote].note = PoJ_NotesText:GetText()
    end
    PoJ_Notes.NoteChanged = nil
  end
end


function PoJ_Notes_SetTitle(title)
  local dofocus, dosort, doupdate
  if PoJ_Notes.Mode == "edit" then
    PoJ_Notes.Notes[PoJ_Notes.SelectedNote].title = title
    dosort = true
    doupdate = true
  elseif PoJ_Notes.Mode == "new" then
    table.insert(PoJ_Notes.Notes, { title = title, note = ""})
    PoJ_Notes.Count = PoJ_Notes.Count + 1
    PoJ_Notes.SelectedNote = PoJ_Notes.Count
    dosort = true
    doupdate = true
    dofocus = true
  end
  if dosort then
    table.sort(PoJ_Notes.Notes, PoJ_Notes_Sort)
    for i = 1, PoJ_Notes.Count do
      if PoJ_Notes.Notes[i].title == title then
        PoJ_Notes.SelectedNote = i
        break
      end
    end
    local offset = FauxScrollFrame_GetOffset(PoJ_NotesTitleScrollFrame)
    local value
    if PoJ_Notes.SelectedNote <= offset then
      value = PoJ_Notes.SelectedNote - 1
    elseif PoJ_Notes.SelectedNote > offset + 8 then
      value = PoJ_Notes.SelectedNote - 8
    end
    if value then
      PoJ_NotesTitleScrollFrameScrollBar:SetValue(16 * value)
      FauxScrollFrame_SetOffset(PoJ_NotesTitleScrollFrame, value)
    end
  end
  if doupdate then
    PoJ_Notes_Update()
  end
  if dofocus then
    PoJ_NotesText:SetFocus()
  end
end


function PoJ_Notes_Sort(a, b)
  return string.upper(a.title) < string.upper(b.title)
end


function PoJ_Notes_TabClick(self)
  local tab = self:GetID()
  local perchar
  if tab == 2 then
    perchar = true
  end
  if perchar ~= PoJ_Notes.PerChar then
    PoJ_Notes_SaveNote()
    PanelTemplates_SetTab(PoJ_Notes, tab)
    PoJ_Notes.PerChar = perchar
    PoJ_Notes.SelectedNote = nil
    PoJ_NotesText:ClearFocus()
    PoJ_NotesText:SetText("")
    PoJ_Notes_Update()
  end
end


function PoJ_Notes_TitleClick(self)
  StaticPopup_Hide("POJ_NOTES_TITLE")
  PoJ_Notes_SaveNote()
  PoJ_Notes.SelectedNote = self:GetID()
  PoJ_Notes_Update()
end


function PoJ_Notes_Update()
  if PoJ_Notes.PerChar then
    PoJ_Notes.Notes = PoJ_CVars.Notes
  else
    PoJ_Notes.Notes = PoJ_Vars.Notes
  end
  PoJ_Notes.Count = #PoJ_Notes.Notes
  PoJ_NotesHighlight:Hide()
  PoJ_NotesName:Hide()
  PoJ_NotesNameButton:Hide()
  PoJ_NotesText:SetText("")
  if PoJ_Notes.Count == 0 then
    for i = 1, 8 do
      _G["PoJ_NotesTitle" .. i]:Hide()
    end
    PoJ_NotesBackdrop:Hide()
    PoJ_NotesScrollFrame:Hide()
  else
    local notebutton, noteindex, offset
    offset = FauxScrollFrame_GetOffset(PoJ_NotesTitleScrollFrame)
    FauxScrollFrame_Update(PoJ_NotesTitleScrollFrame, PoJ_Notes.Count, 8, 16, nil, nil, nil, PoJ_NotesHighlight, 293, 316)
    for i = 1, 8 do
      noteindex = offset + i
      notebutton = _G["PoJ_NotesTitle" .. i]
      if noteindex > PoJ_Notes.Count then
        notebutton:Hide()
      else
        notebutton:SetID(noteindex)
        notebutton:SetText(PoJ_Notes.Notes[noteindex].title)
        notebutton:Show()
        if noteindex == PoJ_Notes.SelectedNote then
          PoJ_NotesHighlight:SetPoint("TOPLEFT", notebutton)
          PoJ_NotesHighlight:Show()
          notebutton:LockHighlight()
        else
          notebutton:UnlockHighlight()
        end
      end
      if PoJ_Notes.SelectedNote then
        PoJ_NotesName:SetText(PoJ_Notes.Notes[PoJ_Notes.SelectedNote].title)
        PoJ_NotesName:Show()
        PoJ_NotesNameButton:Show()
        PoJ_NotesText:ClearFocus()
        PoJ_NotesText:SetText(PoJ_Notes.Notes[PoJ_Notes.SelectedNote].note)
        PoJ_Notes.NoteChanged = nil
      end
    end
    PoJ_NotesBackdrop:Show()
    PoJ_NotesScrollFrame:Show()
  end
end
