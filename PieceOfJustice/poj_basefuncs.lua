function iif(condition, truevalue, falsevalue)
  if condition then
    return truevalue
  else
    return falsevalue
  end
end


function PoJ_Comment(text, forceshow)
  if PoJ_Vars.ShowComments or forceshow then
    PoJ_Write("|cffffa040<PoJ>|r " .. text)
  end
end


function PoJ_ColorString(color)
  return "ff" .. PoJ_ColorString_Frac2Hex(color.r, 2) .. PoJ_ColorString_Frac2Hex(color.g, 2) .. PoJ_ColorString_Frac2Hex(color.b, 2)
end


function PoJ_ColorString_Frac2Hex(frac, minlen)
  local str = format("%x", PoJ_Round(255 * frac))
  while strlen(str) < minlen do
    str = "0" .. str
  end
  return str
end


function PoJ_Debug(expr, indent, prestring)
  if PoJ_DebugMode or PoJ_Vars.DebugMode then
    if not indent then
      indent = 0
    end
    if not prestring then
      prestring = ""
    end
    local prefix = "*PoJ* " .. strrep("  ", indent)
    if type(expr) == "table" then
      PoJ_Write(prefix .. prestring .. "{")
      for id, val in pairs(expr) do
        PoJ_Debug(val, indent + 2, "[" .. id .. "] = ")
      end
      PoJ_Write(prefix .. "}")
    else
      PoJ_Write(prefix .. prestring .. tostring(expr))
    end
  end
end


function PoJ_Eval(expr)
  PoJ_EvaluationValue = 0
  RunScript("PoJ_EvaluationValue = " .. expr)
  return PoJ_EvaluationValue
end


function PoJ_FormatNumber(number)
	local len = strlen(number)
  if len > 4 then
    number = PoJ_Round(number, 2 - len)
    if len > 7 then
      return strsub(number, 1, -7) .. SECOND_NUMBER_CAP
    elseif len == 7 then
      return strsub(number, 1, 1) .. "." .. strsub(number, 2, 2) .. SECOND_NUMBER_CAP
    elseif len > 4 then
      return strsub(number, 1, -4) .. FIRST_NUMBER_CAP
    end
  end
	return number
end


function PoJ_GetGameTimeString()
  local h, m = GetGameTime()
  return format(TEXT(TIME_TWENTYFOURHOURS), h, m)
end


function PoJ_GetReturnValue(index, ...)
  local vararg = {...}
  return vararg[index]
end


function PoJ_GetTableItemList(list)
  if list then
    return list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9]
  end
end


function PoJ_GetTimeString(seconds, short)
  if seconds < 3600 then
    seconds = ceil(seconds)
    if short and seconds < 60 then
      return tostring(seconds)
    else
      local minutes = floor(seconds / 60)
      seconds = seconds - 60 * minutes
      if seconds < 10 then
        seconds = "0" .. seconds
      end
      return minutes .. ":" .. seconds
    end
  else
    local letter, number
    if seconds < 86400 then
      letter = HOUR_ONELETTER_ABBR
      number = seconds / 3600
    else
      letter = DAY_ONELETTER_ABBR
      number = seconds / 86400
    end
    number = tostring(PoJ_Round(number, 1))
    if not strfind(number, "%.%d") then
      number = number .. ".0"
    end
    return number .. " " .. strsub(letter, -1, -1)
  end
end




function PoJ_Notice(text)
  PoJ_Comment("|cff80ff80" .. POJ_STRING.OUTPUT.NOTICE .. ":|r " .. text, true)
  if PoJ_Vars.RemindSound then
    PlaySoundFile("Interface\\AddOns\\PieceOfJustice\\Sounds\\poj_remind.wav")
  end
end


function PoJ_Remind(text)
  PoJ_Comment("|cff80ff80" .. POJ_STRING.OUTPUT.REMIND .. ":|r " .. text, true)
  if PoJ_Vars.RemindSound then
    PlaySoundFile("Interface\\AddOns\\PieceOfJustice\\Sounds\\poj_remind.wav")
  end
end


function PoJ_Round(num, dec)
  local factor
  if dec then
    factor = 10^dec
  else
    factor = 1
  end
  if factor ~= 1 then
    num = num * factor
  end
  local intnum = math.floor(num)
  if num - intnum < .5 then
    num = intnum
  else
    num = intnum + 1
  end
  if factor ~= 1 then
    num = num / factor
  end
  return num
end


function PoJ_UpdateFrame_Prepare(self, updaterate)
  if not updaterate then
    updaterate = 0.5
  end
  self.LastText   = ""
  self.LastUpdate = 0
  self.UpdateRate = updaterate
end


function PoJ_UpdateFrame_Update(self, elapsed, label, textfunc)
  self.LastUpdate = self.LastUpdate + elapsed
  if self.LastUpdate > self.UpdateRate then
    local text = textfunc()
    if text ~= self.LastText then
      label:SetText(text)
      self.LastText = text
    end
    self.LastUpdate = 0
  end
end


function PoJ_VersionCheck()
  if not PoJ.VersionAlert and PoJ_Vars.NewestVersion then
    if PoJ_VersionCompare(PoJ.Version, PoJ_Vars.NewestVersion) then
      PoJ_Comment(format(POJ_STRING.OUTPUT.NEWVERSION, PoJ_Vars.NewestVersion))
      PoJ_Comment(PoJ.URL)
      PoJ.VersionAlert = true
    end
  end
end


function PoJ_VersionCompare(ver1, ver2)
  local ver1a, ver1b, ver1c, ver1s = strmatch(ver1, "(%d+)%.(%d+)%.(%d+)(%a*)")
  local ver2a, ver2b, ver2c, ver2s = strmatch(ver2, "(%d+)%.(%d+)%.(%d+)(%a*)")
  ver1a, ver1b, ver1c = tonumber(ver1a), tonumber(ver1b), tonumber(ver1c)
  ver2a, ver2b, ver2c = tonumber(ver2a), tonumber(ver2b), tonumber(ver2c)
  if ver1a < ver2a then
    return true
  elseif ver1a > ver2a then
    return false
  elseif ver1b < ver2b then
    return true
  elseif ver1b > ver2b then
    return false
  elseif ver1c < ver2c then
    return true
  elseif ver1c > ver2c then
    return false
  elseif ver1s == "" then
    return false
  elseif ver2s == "" then
    return true
  elseif ver1s < ver2s then
    return true
  else
    return false
  end
end


function PoJ_Write(expr, r, g, b)
  if expr and DEFAULT_CHAT_FRAME then
    if r and g and b then
      DEFAULT_CHAT_FRAME:AddMessage(tostring(expr), r, g, b)
    else
      DEFAULT_CHAT_FRAME:AddMessage(tostring(expr))
    end
	end		
end
