-- Translations missing or inaccurate? Visit http://wow.curseforge.com/addons/fatality/localization/ to see if you can help!
if GetLocale() ~= "zhCN" then return end

local L = Fatality_Locales

-- Welcome Messages
L.welcome1 = "感谢您将插件升级至最新版本~！"
L.welcome2 = "今后您可以通过输入 /fatality 或 /fat 来开启此菜单并配置各个角色的设置"
L.welcome3 = "|cffff0000[注意]|r 每个角色只显示一次该信息"

-- Addon
L.addon_enabled = "|cff00ff00开启|r"
L.addon_disabled = "|cffff0000关闭|r"

-- Damage
L.damage_overkill = "过量伤害: %s"
L.damage_resist = "抵抗: %s"
L.damage_absorb = "吸收: %s"
L.damage_block = "格挡: %s"

-- Error Messages
L.error_report = "(%s)由于超过最大255个字符限制而无法发送通告，要修正该问题，输入|cffff9900/fatality|r并调整对应的设置，或者设置 |cfffdcf00'通告频道'为自己|r。"
L.error_options = "|cffFF9933Fatality_Options|r 无法加载."

-- Configuration: Title
L.config_promoted = "权限"
L.config_lfr = "随机团队"
L.config_raid = "团队"
L.config_party = "小队"
L.config_overkill = "过量伤害"
L.config_resist = "抵抗"
L.config_absorb = "吸收"
L.config_block = "格挡"
L.config_icons = "团队图标"
L.config_school = "属性"
L.config_source = "来源"
L.config_short = "缩写"
L.config_limit10 = "通告上限（10人）"
L.config_limit25 = "通告上限（25人）"
L.config_history = "事件历史"
L.config_threshold = "伤害下限"
L.config_output_raid = "通告频道（团队副本"
L.config_output_party = "通告频道（小队副本）"

-- Configuration: Description
L.config_promoted_desc = "拥有权限才发布信息 ["..RAID_LEADER.."/"..RAID_ASSISTANT.."]"
L.config_lfr_desc = "在随机团队中启用"
L.config_raid_desc = "在团队副本中启用"
L.config_party_desc = "在小队副本中启用"
L.config_overkill_desc = "显示过量伤害"
L.config_resist_desc = "显示被抵抗伤害"
L.config_absorb_desc = "显示被吸收伤害"
L.config_block_desc = "显示被格挡伤害"
L.config_icons_desc = "显示团队图标"
L.config_school_desc = "显示伤害属性"
L.config_source_desc = "显示谁造成的伤害"
L.config_short_desc = "简写数字 [9431 = 9.4k]"
L.config_limit_desc = "每次战斗进程中最多通告多少次死亡事件？"
L.config_history_desc = "对每位成员报告多少次伤害事件？"
L.config_threshold_desc = "可记录的最小伤害数值？"
L.config_channel_default = "<频道名称>"
L.config_whisper_default = "<角色名称>"