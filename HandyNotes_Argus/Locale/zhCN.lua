-- $Id: zhCN.lua 52 2017-05-14 13:29:33Z arith $

local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_Argus", "zhCN", false)

if not L then return end

if L then
L["AddOn Settings"] = "插件设定"
L["HandyNotes - Broken Shore"] = "HandyNotes - 阿古斯"
L["Hide looted mobs"] = "隐藏已击杀"
L["Hide the rare elite mobs which have been killed and looted today."] = "隐藏今日已击杀并拾取的稀有菁英怪。"
L["Icon Alpha"] = "图示透明度"
L["Icon Scale"] = "图示大小"
L["Icon settings"] = "图示设定"
L["Others"] = "其他"
L["Query from server"] = "从服务器查询"
L["Rare mobs"] = "稀有怪"
L["Reset hidden nodes"] = "重设所有被隐藏的节点"
L["Send query request to server to lookup localized names. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = "向服务器送出查询本地化名称的请求。首次查询名称时可能会显示稍慢，一旦查询到或该名称已有快取时则会立即显示。"
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "将您手动把 POI 设为隐藏的节点还原成全部都显示。"
L["Show all the other misc nodes."] = "显示所有其他杂项节点。"
L["Show note"] = "显示说明"
L["Show rare mobs' location even if any of them has not yet spawned."] = "显示稀有菁英怪的节点，即便他们还没重生。"
L["Show the entrance of specific cave or the entrance to special location."] = "显示特定洞穴的入口节点，或是会将你带去特殊位置的入口位置。"
L["Show the node's additional notes when it's available."] = "当节点有额外说明时，同时显示该说明。"
L["Shows the POIs in Broken Shore"] = "显示阿古斯的 POI 位置"
L["The alpha transparency of the icons"] = "图示的透明度"
L["The scale of the icons"] = "图示的大小"
L["These settings control the look and feel of the icon."] = "以下的设定控制了图示的外观及风格。"
L["These settings control what type of icons to be displayed."] = "以下的设定控制了哪些类型的节点要被显示。"
L["What to display"] = "哪些要被呈现"

end
