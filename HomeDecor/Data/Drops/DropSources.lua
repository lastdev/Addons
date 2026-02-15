local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Drops = NS.Data.Drops or {}

NS.Data.DropSources = NS.Data.DropSources or {}

local function AddMob(decorID, name)
  if not decorID or not name or name == "" then return end
  local t = NS.Data.DropSources[decorID]
  if not t then
    t = {}
    NS.Data.DropSources[decorID] = t
  end
  for _, v in ipairs(t) do
    if v == name then return end
  end
  t[#t+1] = name
end

local function IsLeaf(v)
  return type(v) == "table" and v.decorID ~= nil
end

local function NormalizeDropNode(node)
  if type(node) ~= "table" then return end

  if node[1] ~= nil then
    local seen = {}
    local out = {}

    for _, v in ipairs(node) do
      if IsLeaf(v) then
        local did = v.decorID

        local src = v.source
        local mob = (src and (src.npc or src.mob or src.name)) or v.npc or v.mob
        if mob then
          AddMob(did, mob)
        end

        if not seen[did] then
          seen[did] = v
          out[#out+1] = v
        else

          local cur = seen[did]
          if (cur.title == nil or cur.title == "") and v.title and v.title ~= "" then
            seen[did] = v
            out[#out] = v
          end
          if (cur.decorType == nil or cur.decorType == "") and v.decorType and v.decorType ~= "" then
            cur.decorType = v.decorType
          end
        end
      elseif type(v) == "table" then
        NormalizeDropNode(v)
        out[#out+1] = v
      else
        out[#out+1] = v
      end
    end

    if #out > 0 then
      for i = 1, math.max(#node, #out) do
        node[i] = out[i]
      end
    end
    return
  end

  for _, v in pairs(node) do
    NormalizeDropNode(v)
  end
end

local function SortLists()
  for _, list in pairs(NS.Data.DropSources) do
    if type(list) == "table" then
      table.sort(list, function(a,b) return tostring(a) < tostring(b) end)
    end
  end
end

local function Build()
  NormalizeDropNode(NS.Data.Drops)
  SortLists()
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
  if name ~= ADDON then return end
  if C_Timer and C_Timer.After then
    C_Timer.After(0, Build)
  else
    Build()
  end
end)
