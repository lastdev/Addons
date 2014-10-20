-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-key-bindings/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
L["Print Debugging Info"] = "Imprimir Informações de Depuração" -- Needs review
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "frFR" then -- French
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
-- L["Print Debugging Info"] = ""
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "deDE" then -- German
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
-- L["Print Debugging Info"] = ""
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "itIT" then -- Italian
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
L["Print Debugging Info"] = "Stampa informazioni di debug" -- Needs review
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
L["Toggle AoE Mode"] = "Attiva Modalità AoE" -- Needs review
L["Toggle Floating Combat Text"] = "Attiva Testo di Combattimento fluttuante" -- Needs review
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "koKR" then -- Korean
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
-- L["Print Debugging Info"] = ""
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
-- L["Print Debugging Info"] = ""
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
L["Print Debugging Info"] = "Показать Окно Ошибок" -- Needs review
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
L["Toggle AoE Mode"] = "Включить режим АоЕ" -- Needs review
L["Toggle Floating Combat Text"] = "Включить Всплывающий Текст Боя" -- Needs review
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Bitten's Debugging Options"] = "Bitten调试选项" -- Needs review
L["Bitten's SpellFlash"] = "Bitten法术闪光提示" -- Needs review
L["Print Cast Event Tag"] = "输出施放事件标签" -- Needs review
L["Print Debugging Info"] = "输出调式信息" -- Needs review
L["Print Event Tag"] = "输出事件标签" -- Needs review
L["Print Flash Tag"] = "输出闪光标签" -- Needs review
L["Print Log Event Tag"] = "输出日志事件标签" -- Needs review
L["Toggle AoE Mode"] = "切换AoE模式" -- Needs review
L["Toggle Floating Combat Text"] = "开关浮动战斗文字" -- Needs review
L["Use Blizzard Proc Animation"] = "使用暴雪触发动画" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Bitten's Debugging Options"] = ""
-- L["Bitten's SpellFlash"] = ""
-- L["Print Cast Event Tag"] = ""
-- L["Print Debugging Info"] = ""
-- L["Print Event Tag"] = ""
-- L["Print Flash Tag"] = ""
-- L["Print Log Event Tag"] = ""
-- L["Toggle AoE Mode"] = ""
-- L["Toggle Floating Combat Text"] = ""
-- L["Use Blizzard Proc Animation"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Bitten's Debugging Options"] = "Bitten除錯選項" -- Needs review
L["Bitten's SpellFlash"] = "Bitten法術閃光提示" -- Needs review
L["Print Cast Event Tag"] = "輸出施放事件標籤" -- Needs review
L["Print Debugging Info"] = "輸出除錯資訊" -- Needs review
L["Print Event Tag"] = "輸出事件標籤" -- Needs review
L["Print Flash Tag"] = "輸出閃光標籤" -- Needs review
L["Print Log Event Tag"] = "輸出日誌事件標籤" -- Needs review
L["Toggle AoE Mode"] = "切換AoE模式" -- Needs review
L["Toggle Floating Combat Text"] = "開關浮動戰鬥文字" -- Needs review
L["Use Blizzard Proc Animation"] = "使用暴雪觸發動畫" -- Needs review

end