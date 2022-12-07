---
--- @file
--- Handles custom pins (pois and paths) on map.
---

local NAME, this = ...

local API = this.API
local HandyNotes = this.HandyNotes

-- Create our pin mixin.
local PinMixin = API:createFromMixins(API.MapCanvasPinMixin)

-- We need to assign our pin mixin to global template, or Blizzard_MapCanvas doesn't know, what to use.
_G[NAME .. 'PinMixin'] = PinMixin

---
--- This event is fired, when our pin mixin is loaded.
---
function PinMixin:OnLoad()
  -- We need to change frame level, because with default one, icons are not seen.
  self:UseFrameLevelType('PIN_FRAME_LEVEL_AREA_POI')
end

---
--- This method is called when we are adding new points in our data provider.
---
--- @see DataProviderMixin:RefreshAllData()
---
--- @param coord
---   Coordinates for specific poi or path.
--- @param prevCoord
---   Coordinates for previous point in path si we can join them.
---
function PinMixin:OnAcquired(coord, prevCoord)
  -- Translate coordinates for map.
  local pointX, pointY = HandyNotes:getXY(coord)

  -- Single POI.
  if (not prevCoord) then
    -- Create texture for our point.
    local texture = self.texture
    texture:SetAtlas('CGuy_AOIFollowsCamera')
    texture:SetTexCoord(0, 1, 0, 1)
    texture:SetVertexColor(1, 1, 1, 1)
    -- Set size.
    self:SetSize(12, 12)
    -- Position poi on map.
    self:SetPosition(pointX, pointY)
  end

  -- Path.
  if (prevCoord) then
    -- Translate second coordinates for map.
    local pointX2, pointY2 = HandyNotes:getXY(prevCoord)
    -- Get with and height for map window.
    local width = self:GetParent():GetWidth()
    local height = self:GetParent():GetHeight()

    -- Good old elementary school math.

    -- Calculate length of each side of a rectangle and multiply it by window (map)
    -- width and height to get proper result.
    local sideA = (pointX2 - pointX) * width
    local sideB = (pointY2 - pointY) * height
    -- Get middle point for each side.
    local middleA = (pointX + pointX2) / 2
    local middleB = (pointY + pointY2) / 2
    -- Calculate diagonal of a rectangle. This is length between of our line.
    local length = math.sqrt(sideA ^ 2 + sideB ^ 2)

    -- College math.

    -- Calculate the angle in radians with arctan2 function.
    local angle = math.atan2(sideB, sideA)

    -- Create texture for our point.
    local texture = self.texture
    -- @todo change to something more appealing, temporary value.
    texture:SetAtlas('CGuy_AOIFollowsCamera')
    texture:SetTexCoord(0, 1, 0, 1)
    texture:SetVertexColor(1, 1, 1, 1)
    -- Set size and scale.
    self:SetSize(length, 2)
    -- Angle must be negative to change direction of rotation.
    texture:SetRotation(-angle)
    self:ApplyCurrentScale()
    -- Position poi on map.
    self:SetPosition(middleA, middleB)
  end
end
