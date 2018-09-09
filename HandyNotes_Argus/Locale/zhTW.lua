-- $Id: zhTW.lua 58 2017-05-20 07:01:08Z arith $

local L = LibStub("AceLocale-3.0"):NewLocale("HandyNotes_Argus", "zhTW", false)

if not L then return end

if L then
L["AddOn Settings"] = "插件設定"
L["HandyNotes - Broken Shore"] = "HandyNotes - 阿古斯"
L["Hide looted mobs"] = "隱藏已擊殺"
L["Hide the rare elite mobs which have been killed and looted today."] = "隱藏今日已擊殺並拾取的稀有菁英怪。"
L["Icon Alpha"] = "圖示透明度"
L["Icon Scale"] = "圖示大小"
L["Icon settings"] = "圖示設定"
L["Others"] = "其他"
L["Query from server"] = "從伺服器查詢"
L["Rare mobs"] = "稀有怪"
L["Reset hidden nodes"] = "重設所有被隱藏的節點"
L["Send query request to server to lookup localized names. May be a little bit slower for the first time lookup but would be very fast once the name is found and cached."] = "向伺服器送出查詢本地化名稱的請求。首次查詢名稱時可能會顯示稍慢，一旦查詢到或該名稱已有快取時則會立即顯示。"
L["Show all nodes that you manually hid by right-clicking on them and choosing \"hide\"."] = "將您手動把 POI 設為隱藏的節點還原成全部都顯示。"
L["Show all the other misc nodes."] = "顯示所有其他雜項節點。"
L["Show coordinate"] = "顯示座標"
L["Show node's coordinate information."] = "顯示節點的座標資訊。"
L["Show note"] = "顯示說明"
L["Show rare mobs' location even if any of them has not yet spawned."] = "顯示稀有菁英怪的節點，即便他們還沒重生。"
L["Show the entrance of specific cave or the entrance to special location."] = "顯示特定洞穴的入口節點，或是會將你帶去特殊位置的入口位置。"
L["Show the node's additional notes when it's available."] = "當節點有額外說明時，同時顯示該說明。"
L["Shows the POIs in Broken Shore"] = "顯示阿古斯的 POI 位置"
L["The alpha transparency of the icons"] = "圖示的透明度"
L["The scale of the icons"] = "圖示的大小"
L["These settings control the look and feel of the icon."] = "以下的設定控制了圖示的外觀及風格。"
L["These settings control what type of icons to be displayed."] = "以下的設定控制了哪些類型的節點要被顯示。"
L["What to display"] = "哪些要被呈現"

end
