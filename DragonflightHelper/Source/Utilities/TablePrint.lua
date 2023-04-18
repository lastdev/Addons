DFH_Utilities = {}

function DFH_Utilities.dump(t, name)
  name = name or 'Unknown'

  print('*************** TABLE ' .. name .. ' *****************')
  -- print( 'Utilities.Print', debugstack( 2, 1, 0 ) )
  local print_r_cache = {}

  local function sub_print_r(t, indent)
    if (print_r_cache[tostring(t)]) then
      print(indent .. "*" .. tostring(t))
    else
      print_r_cache[tostring(t)] = true
      if (type(t) == "table") then
        for pos, val in pairs(t) do
          if (type(val) == "table") then
            print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 2))
            print(indent .. string.rep(" ", string.len(pos)) .. "}")
          elseif (type(val) == "string") then
            print(indent .. "[" .. pos .. '] => "' .. val .. '"')
          else
            print(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        print(indent .. tostring(t))
      end
    end
  end

  if (type(t) == "table") then
    print(tostring(t) .. " {")
    sub_print_r(t, "  ")
    print("}")
  else
    sub_print_r(t, "  ")
  end

  print()
end

function DFH_Utilities.error(title, ...)
  print(RED_FONT_COLOR_CODE .. "DragonflightHelper " .. title .. ": " .. FONT_COLOR_CODE_CLOSE, ...);
end

function DFH_Utilities.info(title, ...)
  print(GREEN_FONT_COLOR_CODE .. "DragonflightHelper " .. title .. ": " .. FONT_COLOR_CODE_CLOSE, ...);
end
