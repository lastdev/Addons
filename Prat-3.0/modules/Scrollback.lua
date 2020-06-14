---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2018  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------


Prat:AddModuleExtension(function()
  local function dbg(...) end

  --[===[@debug@
  function dbg(...) Prat:PrintLiteral(...) end

  --@end-debug@]===]


  local module = Prat.Addon:GetModule("History", true)
  if not module then return end

  local PL = module.PL


  module.pluginopts["GlobalPatterns"] = {
    scrollbackhistheader = {
      name = PL["Scrollback Options"],
      type = "header",
      order = 124,
    },
    scrollback = {
      type = "toggle",
      name = PL["Scrollback"],
      desc = PL["Store the chat lines between sessions"],
      order = 125
    },
    scrollbackduration = {
      name = PL.scrollbackduration_name,
      desc = PL.scrollbackduration_desc,
      type = "range",
      order = 126,
      min = 0,
      max = 168,
      step = 1,
      bigStep = 24,
      disabled = function() return not module.db.profile.scrollback end
    },
    removespam = {
      name = PL.removespam_name,
      desc = PL.removespam_desc,
      type = "toggle",
      order = 127,
      disabled = function() return not module.db.profile.scrollback end
    }
  }

  local orgOME = module.OnModuleEnable
  function module:OnModuleEnable(...)
    orgOME(self, ...)

    Prat3HighCPUPerCharDB = Prat3HighCPUPerCharDB
    Prat3HighCPUPerCharDB = Prat3HighCPUPerCharDB or {}

    Prat3HighCPUPerCharDB.scrollback = Prat3HighCPUPerCharDB.scrollback or {}

    self.scrollback = Prat3HighCPUPerCharDB.scrollback

    if self.db.profile.scrollback then
      self:RestoreLastSession()

      for k, v in pairs(Prat.HookedFrames) do
        self.scrollback[k] = v.historyBuffer
      end
    end

    Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
  end

  function module:OnValueChanged(info, b)
    if self.db.profile.scrollback then
      for k, v in pairs(Prat.HookedFrames) do
        if not v.isTemporary then
          self.scrollback[k] = v.historyBuffer
        else
          self.scrollback[k] = nil
        end
      end
    end
  end

  function module:Prat_FramesUpdated(_, name, chatFrame)
    if self.db.profile.scrollback and not chatFrame.isTemporary then
      self.scrollback[name] = chatFrame.historyBuffer
    end
  end

  function module:GetEntryAtIndex(scrollback, index)
    if index > 0 and index <= #scrollback.elements then
      local globalIndex = scrollback.headIndex - index + 1;
      local elementIndex = (globalIndex - 1) % scrollback.maxElements + 1
      return scrollback.elements[elementIndex];
    end
  end

  local function isRealChatMessage(message)
    return message.extraData and message.extraData.n == #message.extraData
  end

   function getBattlettagLookupTable()
    local lookup = {}
    local numBNet = BNGetNumFriends();
    for i = 1, numBNet do
      if C_BattleNet and C_BattleNet.GetFriendAccountInfo then
        local accountInfo = C_BattleNet.GetFriendAccountInfo(i);
        if accountInfo then
          lookup[accountInfo.battleTag] = accountInfo
        end
      else
        local bnetAccountID, accountName, battleTag = BNGetFriendInfo(i)
        local accountInfo = { bnetAccountID = bnetAccountID, accountName = accountName }
        lookup[battleTag] = accountInfo
      end
    end

    return lookup
  end

  local battleTagLookup

  local function getBNPlayerLink(name, linkDisplayText, bnetIDAccount, lineID, chatType, chatTarget, battleTag)
    return Prat.FormatLink("BNplayer", linkDisplayText, name, bnetIDAccount, lineID or 0, chatType, chatTarget, battleTag);
  end

  local function updateBnet(data, display)
    battleTagLookup = battleTagLookup or getBattlettagLookupTable()

    local name, bnetIDAccount, _, chatType, chatTarget, battleTag = strsplit(":", data)

    if battleTag then
      local info = battleTagLookup[battleTag]
      if info then
        name, bnetIDAccount = info.accountName, info.bnetAccountID
        display = display:gsub(PL.bnet_removed, name)
        chatTarget = chatTarget:gsub(PL.bnet_removed, name)
      end
    end

    return getBNPlayerLink(name, display, bnetIDAccount, 0, chatType, chatTarget, battleTag)
  end

  function module:RestoreLastSession()
    local now, maxTime = GetTime(), self.db.profile.scrollbackduration * 60 * 60
    for frame, scrollback in pairs(self.scrollback) do
      local f = _G[frame]
      if scrollback.elements and scrollback.headIndex and scrollback.maxElements and frame ~= "ChatFrame2" then
        if f and #scrollback.elements then
          local timeShown = false
          for i = 1, #scrollback.elements do
            local line = self:GetEntryAtIndex(scrollback, i)
            if line and line.message and (not self.db.profile.removespam or isRealChatMessage(line)) then
              if maxTime > 0 and (now - line.timestamp) <= maxTime then
                if not timeShown then
                  f:BackFillMessage(PL.divider)

                  f:BackFillMessage(format(TIME_DAYHOURMINUTESECOND,
                    ChatFrame_TimeBreakDown(now - line.timestamp)))
                  timeShown = true
                end

                line.message = line.message:gsub("|K.-|k", PL.bnet_removed)
                line.message = line.message:gsub([[|HBNplayer:(.-)|h(.-)|h]], updateBnet)
                f.historyBuffer:PushBack(line)
              end
            end
          end
        end
      end
    end
  end
end)