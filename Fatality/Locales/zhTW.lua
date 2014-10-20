-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "zhTW" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "感謝你升級到最新版"
L.welcome2 = "以後你可以通過鍵入 |cffff9900/fatality|r 或者 |cffff9900/fat|r 打開菜單設定每個角色的設置."
L.welcome3 = "|cffff0000[提醒]|r 此消息對每個角色只顯示一次."

-- Addon
L.addon_enabled = "|cff00ff00啟用|r"
L.addon_disabled = "|cffff0000禁用|r"

-- Damage
L.damage_overkill = "過量傷害: %s"
L.damage_resist = "抵抗: %s"
L.damage_absorb = "吸收: %s"
L.damage_block = "格擋: %s"

-- Error Messages
L.error_report = "(%s) 通報無法發送, 因為不能超過255個字符限制. 修正此問題請輸入|cffff9900/fatality|r 調整你的相應選項. 或者你可以設置|cfffdcf00'通報頻道'到 自身|r."
L.error_options = "|cffFF9933Fatality_Options|r 無法加載."

-- Configuration: Title
L.config_promoted = "權限"
L.config_lfr = "隨機團隊"
L.config_raid = "團隊"
L.config_party = "小隊"
L.config_overkill = "過量傷害"
L.config_resist = "抵抗"
L.config_absorb = "吸收"
L.config_block = "格擋"
L.config_icons = "團隊標記"
L.config_school = "屬性"
L.config_source = "傷害來源"
L.config_short = "縮寫"
L.config_limit10 = "通報限制(10人)"
L.config_limit25 = "通報限制(25人)"
L.config_history = "事件歷史"
L.config_threshold = "傷害下限"
L.config_output_raid = "通報頻道(團隊副本)"
L.config_output_party = "通報頻道(小隊副本)"

-- Configuration: Description
L.config_promoted_desc = "僅當有["..RAID_LEADER.."/"..RAID_ASSISTANT.."]權限才發出通報"
L.config_lfr_desc = "在隨機團隊中啟用"
L.config_raid_desc = "在團隊副本中啟用"
L.config_party_desc = "在小隊副本中啟用"
L.config_overkill_desc = "包含過量傷害"
L.config_resist_desc = "包含被抵抗的傷害"
L.config_absorb_desc = "包含被吸收的傷害"
L.config_block_desc = "包含被格擋的傷害"
L.config_icons_desc = "包含團隊標記"
L.config_school_desc = "包含傷害屬性"
L.config_source_desc = "包含被誰施加的傷害"
L.config_short_desc = "簡化數字顯示 [9431 = 9.4k]"
L.config_limit_desc = "每場戰鬥中最多通報多少次死亡?"
L.config_history_desc = "每個成員要通報多少次受到的傷害事件?"
L.config_threshold_desc = "要記錄的最小傷害數值是多少?"
L.config_channel_default = "<頻道名稱>"
L.config_whisper_default = "<角色名稱>"