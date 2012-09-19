-- TIMER FUNCTIONS --

function PoJ_Timer_Add(schedtime, name, timertype, data, repeating)
  local found
  local insertpos = 1
  for i = #PoJ.TimerQueue, 1, -1 do
    if PoJ.TimerQueue[i].name == name then
      table.remove(PoJ.TimerQueue, i)
      if found then
        insertpos = insertpos - 1
      end
    elseif PoJ.TimerQueue[i].time <= schedtime and not found then
      insertpos = i + 1
      found = true
    end
  end
  if type(repeating) ~= "number" then
    repeating = nil
  end
  table.insert(PoJ.TimerQueue, insertpos, {time = schedtime, name = name, type = timertype, data = data, repeattime = repeating})
end


function PoJ_Timer_Check()
  local now = GetTime()
  while PoJ.TimerQueue[1] and PoJ.TimerQueue[1].time < now do
    local name = PoJ.TimerQueue[1].name
    local data = PoJ.TimerQueue[1].data
    local timertype = PoJ.TimerQueue[1].type
    local repeattime = PoJ.TimerQueue[1].repeattime
    table.remove(PoJ.TimerQueue, 1)
    PoJ_Timer_Do(timertype, data)
    if repeattime then
      PoJ_Timer_Add(now + repeattime, name, timertype, data, repeattime)
    end
  end
end


function PoJ_Timer_Comp_Func(data1, data2)
  return data1.func == data2.func
end


function PoJ_Timer_Exists(name)
  for _, timer in ipairs(PoJ.TimerQueue) do
    if timer.name == name then
      return true
    end
  end
end


function PoJ_Timer_Do(timertype, data)
  if timertype == "FUNCTION" then
    data.func(PoJ_GetTableItemList(data.params))
  end
end


function PoJ_Timer_Remove(timertype, compfunc, data)
  for i = #PoJ.TimerQueue, 1, -1 do
    if (not timertype or PoJ.TimerQueue[i].type == timertype) and (not compfunc or not data or compfunc(PoJ.TimerQueue[i].data, data)) then
      table.remove(PoJ.TimerQueue, i)
    end
  end
end
