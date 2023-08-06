-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2018/10/20

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
-- Taloc the Corrupted --
---------------------------
L= DBM:GetModLocalization(2168)

L:SetMiscLocalization({
	Aggro	 =	"有仇恨"
})

---------------------------
-- MOTHER --
---------------------------
--L= DBM:GetModLocalization(2167)

---------------------------
-- Fetid Devourer --
---------------------------
L= DBM:GetModLocalization(2146)

L:SetWarningLocalization({
	addsSoon		= "边门开启，准备小怪"
})

L:SetOptionLocalization({
	addsSoon		= "特殊警报：边门开启，准备小怪"
})


---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "下一个球落地 (%s)"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"计时条：下一次腐蚀之球落地",
	EarlyTankSwap	 =	"粉碎后直接提示换坦，而不是等到下一次虚空鞭笞"
})

L:SetMiscLocalization({
	CThunDisc 			= 	"检索圆盘成功。正在读取克苏恩数据。",
	YoggDisc 			= 	"检索圆盘成功。正在读取尤格-萨隆数据。",
	CorruptedDisc 		= 	"检索圆盘成功。正在读取损坏数据。"  --official
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"将信息窗中持续感染的层数从高往低显示(默认从低到高)",
	ShowOnlyParty		 =	"只显示自己小队的持续感染层数信息(得先编队)",
	SetIconsRegardless	 =	"强制设置标志，不管BW用户是否有权限(三思而后行))"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM能够和BW互通团队标识。请确保团队权限正常防止胡乱标识，或者去掉他们的权限让DBM表示。"
})

---------------
-- Mythrax the Unraveler --
---------------
--L= DBM:GetModLocalization(2194)

---------------------------
-- Zul --
---------------------------
L= DBM:GetModLocalization(2195)

L:SetTimerLocalization({
	timerCallofCrawgCD		= "下一个嗜血抱齿兽池 (%s)",
	timerCallofHexerCD 		= "下一个鲜血妖术师池 (%s)",
	timerCallofCrusherCD	= "下一个碾压者池 (%s)",
	timerAddIncoming		= DBM_COMMON_L.INCOMMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "计时条：嗜血抱齿兽池开始生成时",
	timerCallofHexerCD 		= "计时条：鲜血妖术师池开始生成时",
	timerCallofCrusherCD	= "计时条：碾压者池开始生成时",
	timerAddIncoming		= "计时条：当小怪可以进攻时",
	TauntBehavior			= "设置换坦嘲讽规则",
	TwoHardThreeEasy		= "英雄/神话模式2层换，其他模式3层换",--Default
	TwoAlways				= "总是2层换",
	ThreeAlways				= "总是3层换"
})

L:SetMiscLocalization({
	Crusher			=	"碾压者",
	Bloodhexer		=	"鲜血妖术师",
	Crawg			=	"嗜血抱齿兽"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "能量矩阵掉落"
})

L:SetOptionLocalization({
	warnMatrixFail		= "计时条：当能量矩阵掉落时"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"当前矩阵:",--Mythic
	NextMatrix			=	"下个矩阵:",--Mythic
	CurrentMatrixLong	=	"当前矩阵 (%s):",--Non Mythic
	NextMatrixLong		=	"下个矩阵 (%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"奥迪尔小怪"
})

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

--L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
--L= DBM:GetModLocalization(2325)--King Grong (Horde)

--L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

--L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Opulence (Alliance) -- 宝藏守护者
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"壁垒",
	Hand	=	"手"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"既然你们这么想死，干嘛不早点来找我？",
	BwonsamdiWrath2 =	"迟早……所有人都会臣服于我！",
	Bird			 =	"鸟"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "即使你不在对应位面也显示警告 (计时条不受影响)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
--L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary		= "隐藏反向距离监控中的玩家名字，只显示统计信息（附近有几个人）",
	InterruptBehavior	= "设置水元素打断机制（队长覆盖他人设定）",
	Three				= "3人打断（默认）",--Default
	Four				= "4人打断",
	Five				= "5人打断",
	SetWeather			= "战斗开始时自动将天气粒子设置调低，并在战斗结束后恢复"
})

L:SetMiscLocalization({
	Port			=	"左舷",
	Starboard		=	"右舷",
	Freezing		=	"%s秒后冰冻"
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"达萨罗之战小怪"
})

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "扎克萨奇",
	Fathuul = "法索乌"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({
	UnstableBehavior2	= "设置不稳定回响的大喊 (团长覆盖全团设置)",
	SetOne				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t)",
	SetTwo				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t)",--Default
	SetThree			= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFour				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t)",
	SetFive				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)",
	SetSix				= "虚空石 (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t), Trident/Ocean (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t), Tempest/Storm (|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t)"
})

L:SetMiscLocalization({
	Ocean = "深海三叉戟",
	Storm = "风暴召唤者",
	Void = "虚空石",
	Lunacy = "疯狂",
	DBMConfigMsg	= "团长将不稳定回响设置成 %s."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"风暴熔炉小怪"
})

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"3秒后出圈"
})

---------------------------
-- Herald of N'zoth --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	=	"扎库尔把你拽进了恐惧领域！",
	Tear	=	"撕裂"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "小怪狂暴"
}

L:SetOptionLocalization({
	SortDesc 				= "$spell:298569的层数计数信息窗使用从高到低显示，而不是从低到高",
	ShowTimeNotStacks		= "使用信息窗提示$spell:298569的剩余时间而不是使用层数计数器信息框显示剩代替",
	timerStageThreeBerserk	= "为3阶段小怪狂暴显示计时器"
})

L:SetMiscLocalization({
	SoakOrb =	"吸收球",
	AvoidOrb =	"躲开球",
	GroupUp =	"集合",
	Spread =	"分散",
	Move	 =	"保持移动",
	DontMove =	"停止移动",
	HelpSoakMove		= "{rt3}帮忙吸收移动{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}帮忙吸收不动{rt6}",--Blue Square
	HelpSoak			= "{rt3}帮忙吸收{rt3}",--Purple Diamond
	HelpMove			= "{rt4}帮忙移动{rt4}",--Green Triangle
	HelpStay			= "{rt7}帮忙不动{rt7}",--Red X
	SoloSoak 			= "单独吸收",
	Solo 				= "单独",
	--Not currently used Yells
	SoloMoving			= "单独移动",
	SoloStay			= "单独不动",
	SoloSoakMove		= "单独吸收移动",
	SoloSoakStay		= "单独吸收不动"
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"永恒王宫小怪"
})

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
--L= DBM:GetModLocalization(2368)

---------------------------
--  Maut --
---------------------------
--L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
--L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetOptionLocalization({
	InterruptBehavior	= "设置恐惧浪潮的打断方式（团长覆盖全团）",
	Four				= "4人轮流",--Default
	Five				= "5人轮流",
	Six					= "6人轮流",
	NoReset				= "无限增加"
})

L:SetMiscLocalization({
	ObeliskSpawn	= "暗影之碑，起来吧！"--Only as backup, in case the NPC target check stops working
})

---------------------------
--  The Hivemind --
---------------------------
--L= DBM:GetModLocalization(2372)

---------------------------
--  Shad'har the Insatiable --
---------------------------
--L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
--L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
--L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetOptionLocalization({
	OnlyParentBondMoves		= "只在自身为充能锁链的父节点时才显示特殊警告"
})

L:SetMiscLocalization({
	Furthest	= "最远目标",
	Closest		= "最近目标"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "除非一个淤泥死亡，否则不刷新标记图标",
	InterruptBehavior	= "设置脉动之血的打断方式（团长覆盖全团）",
	Two					= "2人轮流",--Default
	Three				= "3人轮流",
	Four				= "4人轮流",
	Five				= "5人轮流"
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
--L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetOptionLocalization({
	InterruptBehavior	= "设置精神腐烂的打断方式（团长覆盖全团）",
	Four				= "4人轮流",
	Five				= "5人轮流",--Default
	Six					= "6人轮流",
	NoReset				= "无限增加",
	ArrowOnGlare		= "为 $spell:317874 显示左右箭头指引方向",
	HideDead			= "非神话难度下隐藏阵亡队友的信息窗内容"
})

L:SetMiscLocalization({
	ExitMind		= "离开神思",
	Gate			= "门"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"尼奥罗萨小怪"
})
