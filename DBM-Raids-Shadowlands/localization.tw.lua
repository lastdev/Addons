if GetLocale() ~= "zhTW" then return end
local L

---------------------------
--  Shriekwing --
---------------------------
--L= DBM:GetModLocalization(2393)

---------------------------
--  Altimor the Huntsman --
---------------------------
--L= DBM:GetModLocalization(2429)

---------------------------
--  Hungering Destroyer --
---------------------------
L= DBM:GetModLocalization(2428)

L:SetOptionLocalization({
	SortDesc 				= "使用降序排列$spell:334755的減益層數訊息框架。",
	ShowTimeNotStacks		= "在$spell:334755上顯示剩餘時間代替層數。"
})

---------------------------
--  Artificer Xy'Mox --
---------------------------
--L= DBM:GetModLocalization(2418)

---------------------------
--  Sun King's Salvation/Kael'thas --
---------------------------
--L= DBM:GetModLocalization(2422)

---------------------------
--  Lady Inerva Darkvein --
---------------------------
L= DBM:GetModLocalization(2420)

L:SetTimerLocalization{
	timerDesiresContainer		= "慾望滿",
	timerBottledContainer		= "瓶裝滿",
	timerSinsContainer			= "罪惡滿",
	timerConcentrateContainer	= "濃縮滿"
}

L:SetOptionLocalization({
	timerContainers2			= "顯示容器填充進度和充滿剩餘時間的計時器"
})

---------------------------
--  The Council of Blood --
---------------------------
--L= DBM:GetModLocalization(2426)

---------------------------
--  Sludgefist --
---------------------------
--L= DBM:GetModLocalization(2394)

---------------------------
--  Stoneborne Generals --
---------------------------
L= DBM:GetModLocalization(2425)

L:SetOptionLocalization({
	ExperimentalTimerCorrection	= "在其他技能將法術排入佇列時自動調整計時器"
})

---------------------------
--  Sire Denathrius --
---------------------------
--L= DBM:GetModLocalization(2424)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CastleNathriaTrash")

L:SetGeneralLocalization({
	name =	"納撒亞城小怪"
})

---------------------------
--  The Tarragrue 泰拉古魯--
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "通告個人殘留物層數"
})

L:SetMiscLocalization({
	Remnant	= "殘留物"
})

---------------------------
--  The Eye of the Jailer 獄主之眼--
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "重複輕蔑與憤怒的標記喊話，直到減益消失"
})

---------------------------
--  The Nine 九魂使--
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "裂片 "--Space is intentional, leave a space to add a number after it
})

---------------------------
--  Remnant of Ner'zhul 耐祖奧的殘骸--
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain 靈魂撕裂者多瑪贊--
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal 苦痛工匠拉茲內爾--
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones 首創者的守護者--
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "為團隊設定標記行為 (如果您為團隊領隊將覆蓋團隊設定)",
	TypeOne			= "DBM預設 (近戰 > 遠程)",
	TypeTwo			= "BW預設 (依據戰鬥紀錄順序)"
})

L:SetMiscLocalization({
	Dissection	= "分解。",
	Dismantle	= "瓦解。"
})

---------------------------
--  Fatescribe Roh-Kalo 述命者羅卡洛--
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad 科爾蘇加德--
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner 希瓦娜斯．風行者--
---------------------------
--L= DBM:GetModLocalization(2441)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"統御聖所小怪"
})

---------------------------
--  Vigilant Guardian --警戒守護者
---------------------------
--L= DBM:GetModLocalization(2458)

--L:SetOptionLocalization({

--})

--L:SetMiscLocalization({

--})

---------------------------
--  Dausegne, the Fallen Oracle --墮落神諭者達奧賽恩
---------------------------
--L= DBM:GetModLocalization(2459)

---------------------------
--  Artificer Xy'mox --工藝師西莫斯
---------------------------
--L= DBM:GetModLocalization(2470)

---------------------------
--  Prototype Pantheon --原型萬神殿
---------------------------
L= DBM:GetModLocalization(2460)

L:SetOptionLocalization({
	RitualistIconSetting	= "設置儀式的圖示行為。團長的設定將覆蓋全團DBM設定",
	SetOne					= "與種子/黑夜獵人不同 (無衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t",--5-8 (Default)
	SetTwo					= "與種子/黑夜獵人配對 (如果種子與儀式同時出現則衝突) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t",-- 1-4
--	SetThree				= "與種子/黑夜獵人配對 (不衝突，但需要團隊成員安裝特殊擴展圖示來看見他們) |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"--9-12
})

L:SetMiscLocalization({
	Deathtouch		= "死亡之觸",
	Dispel			= "驅散",
	ExtendReset		= "由於您之前使用了擴展圖示，但已不再使用，因此您的儀式圖示下拉設定已被重置。"
})

---------------------------
--  Lihuvim, Principal Architect --首席設計者利胡敏
---------------------------
--L= DBM:GetModLocalization(2461)

---------------------------
--  Skolex, the Insatiable Ravener --貪婪掠食者史寇雷斯
---------------------------
--L= DBM:GetModLocalization(2465)

L:SetTimerLocalization{
	timerComboCD		= "~坦克連擊 (%d)"
}

L:SetOptionLocalization({
	timerComboCD		= "顯示坦克連擊冷卻的計時器"
})

---------------------------
--  Halondrus the Reclaimer --回收者哈隆德魯斯
---------------------------
L= DBM:GetModLocalization(2463)

L:SetMiscLocalization({
	Mote		= "微粒"
})

---------------------------
--  Anduin Wrynn --安杜因‧烏瑞恩
---------------------------
L= DBM:GetModLocalization(2469)

L:SetOptionLocalization({
	PairingBehavior			= "設置褻瀆的模組行為。 團長的設定將覆蓋全團DBM設定",
	Auto				    = "'點名你'警告自動配對玩家。聊天泡泡顯示配對者的獨特符號",
	Generic				    = "'點名你'警告不配對玩家。聊天泡泡顯示兩個減益的通用符號",--預設
	None				    = "'點名你'警告不配對玩家。也無聊天泡泡"
})

---------------------------
--  Lords of Dread --驚懼領主
---------------------------
--L= DBM:GetModLocalization(2457)

---------------------------
--  Rygelon --雷吉隆
---------------------------
--L= DBM:GetModLocalization(2467)

---------------------------
--  The Jailer --閻獄之主
---------------------------
--L= DBM:GetModLocalization(2464)

L:SetWarningLocalization({
	warnHealAzeroth		= "治療艾澤拉斯 (%s)",
	warnDispel			= "驅散 (%s)"
})

L:SetTimerLocalization{
	timerPits			= "坑洞開啟",
	timerHealAzeroth	= "治療艾澤拉斯 (%s)",
	timerDispels		= "驅散 (%s)"
}

L:SetOptionLocalization({
	timerPits			= "顯示計時器，以便在樓層坑洞打開並暴露時，您可以跳入。",
	warnHealAzeroth		= "顯示警告，在傳奇難度何時你需要治療艾澤拉斯(透由戰鬥機制)，基於Echo的策略",
	warnDispel			= "顯示警告，在傳奇難度何時你需要驅散死亡宣判，基於Echo的策略(暫譯)",
	timerHealAzeroth	= "顯示計時器，在傳奇難度何時你需要治療艾澤拉斯(透由戰鬥機制)，基於Echo的策略",
	timerDispels		= "顯示計時器，在傳奇難度何時你需要驅散死亡宣判，基於Echo的策略(暫譯)"
})

L:SetMiscLocalization({
	Pylon			= "水晶塔",
	AzerothSoak		= "艾澤拉斯分傷"--Short Text for Desolation
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SepulcherTrash")

L:SetGeneralLocalization({
	name =	"首創者聖塚小怪"
})

-----------------------
-- <<< Fated Raid Affixes >>> --
-----------------------
L = DBM:GetModLocalization("FatedAffixes")

L:SetGeneralLocalization({
	name =	"命定詞綴"
})

