---
--- @file
--- Handles text colorization.
---

local _, this = ...

local Text = {}

---
--- Table with predefined color values.
---
--- @var table
---   List of colors we are going to use.
---
Text.colorList = {
  ['white'] = 'ffffff',
  ['green'] = '00ff00',
  ['red'] = 'ff0000',
  ['yellow'] = 'ffff00',
  ['orange'] = 'ff6600',
}

---
--- Colorizes given text.
---
--- @param text
---   Text we want to colorize.
--- @param color
---   Color we want to use from color list.
---
--- @return string
---   Returns colorized string.
---
function Text:color(text, color)
  -- Fallback, if we miss defining color.
  if not self.colorList[color] then
    return text
  end

  return '|cff' .. self.colorList[color] .. text .. '|r'
end

---
--- Converts hex code from colorList to rgb values.
---
--- @param name
---   Color we want to use from color list.
---
--- @return number
---   Red color.
--- @return number
---   Green color.
--- @return number
---   Blue color.
---
function Text:color2rgb(name)
  local color = self.colorList[name]

  return tonumber('0x' .. color:sub(1, 2)),
         tonumber('0x' .. color:sub(3, 4)),
         tonumber('0x' .. color:sub(5, 6))
end

this.Text = Text
