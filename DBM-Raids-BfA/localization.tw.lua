if GetLocale() ~= "zhTW" then return end
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
	addsSoon		= "滑道已開啟 - 小怪來了"
})

L:SetTimerLocalization({
	chuteTimer		= "下一次滑道(%s)"
})

L:SetOptionLocalization({
	addsSoon		= "為滑道開啟和開始小怪準備出現顯示預先警告",
	chuteTimer		= "為何時滑道開啟顯示計時器"
})

---------------------------
-- Zek'vhozj --
---------------------------
L= DBM:GetModLocalization(2169)

L:SetTimerLocalization({
	timerOrbLands	= "腐化之球落地"
})

L:SetOptionLocalization({
	timerOrbLands	 =	"為腐化之球落地顯示計時器",
	EarlyTankSwap	 =	"碎擊斬後馬上顯示換坦警告而不是等到第二個虛無鞭笞"
})

L:SetMiscLocalization({
	CThunDisc	 =	"Disc accessed. C'thun data loading.",
	YoggDisc	 =	"Disc accessed. Yogg-Saron data loading.",
	CorruptedDisc =	"Disc accessed. Corrupted data loading."
})

---------------------------
-- Vectis --
---------------------------
L= DBM:GetModLocalization(2166)

L:SetOptionLocalization({
	ShowHighestFirst3	 =	"在訊息框架中從最高層數開始排序慢性感染(而非從最低)",
	ShowOnlyParty		 =	"只顯示你隊伍中的慢性感染",
	SetIconsRegardless	 =	"無論Bigwig使用者是否為助理成員皆去標記團隊圖示(進階選項)"
})

L:SetMiscLocalization({
	BWIconMsg			 =	"DBM交給Bigwig的助理成員去標記團隊圖示避免圖示混亂，確定他們有啟用或是降級他們去開啟DBM的標記，或在維克提斯的選項中啟用覆蓋選項"
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
	timerCallofCrawgCD		= "下一次粉碎者鮮血池(%s)",
	timerCallofHexerCD 		= "下一次血咒師鮮血池(%s)",
	timerCallofCrusherCD	= "下一次克洛格鮮血池(%s)",
	timerAddIncoming		= DBM_COMMON_L.INCOMMING
})

L:SetOptionLocalization({
	timerCallofCrawgCD		= "為粉碎者鮮血池開始成形顯示計時器",
	timerCallofHexerCD 		= "為血咒師鮮血池開始成形顯示計時器",
	timerCallofCrusherCD	= "為克洛格鮮血池開始成形顯示計時器",
	timerAddIncoming		= "為小怪可被攻擊時顯示計時器",
	TauntBehavior			= "設置換坦的嘲諷模式",
	TwoHardThreeEasy		= "在英雄/傳奇下兩層換坦，其他難度三層換坦",--Default
	TwoAlways				= "無論任何難度都兩層換坦",
	ThreeAlways				= "無論任何難度都三層換坦"
})

L:SetMiscLocalization({
	Crusher			=	"納茲曼粉碎者",
	Bloodhexer		=	"納茲曼血咒師",
	Crawg			=	"嗜血克洛格"
})

------------------
-- G'huun --
------------------
L= DBM:GetModLocalization(2147)

L:SetWarningLocalization({
	warnMatrixFail		= "能量矩陣掉落"
})

L:SetOptionLocalization({
	warnMatrixFail		= "當能量矩陣掉落顯示警告"
})

L:SetMiscLocalization({
	CurrentMatrix		=	"目前矩陣:",--Mythic
	NextMatrix			=	"下次矩陣:",--Mythic
	CurrentMatrixLong	=	"目前矩陣(%s):",--Non Mythic
	NextMatrixLong		=	"下次矩陣(%s):"--Non Mythic
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("UldirTrash")

L:SetGeneralLocalization({
	name =	"奧迪爾小怪"
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
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"壁壘",
	Hand	=	"手"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"你要是這麼想找死，就應該早點來找我！",
	BwonsamdiWrath2 =	"你們遲早…都會像我臣服！",
	Bird			 =	"大鳥"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "為你沒進場也顯示換階段警告(計時器會持續顯示無論此選項是否選取)"
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
	ShowOnlySummary2	= "隱藏玩家名稱在反距離監控而且只顯示總結訊息(附近玩家數量)",
	InterruptBehavior	= "設置水元素中斷行為 (如果你是團隊隊長會覆蓋所有其他人的設定)",
	Three				= "3人輪流",--Default
	Four				= "4人輪流",
	Five				= "5人輪流",
	SetWeather			= "當開戰時自動地把天氣效果降到最低戰鬥結束後還原設定",
})

L:SetMiscLocalization({
	Port			=	"左舷側",
	Starboard		=	"右舷側",
	Freezing		=	"凍結在%s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"達薩亞洛小怪"
})

---------------------------
--  The Restless Cabal --
---------------------------
L= DBM:GetModLocalization(2328)

L:SetMiscLocalization({
	Zaxasj = "札克沙吉",
	Fathuul = "法蘇爾"
})

---------------------------
-- Uu'nat, Harbinger of the Void --
---------------------------
L= DBM:GetModLocalization(2332)

L:SetOptionLocalization({

})

L:SetMiscLocalization({

})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("CrucibleofStormsTrash")

L:SetGeneralLocalization({
	name =	"邪淵小怪"
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
	Circles =	"3秒後出圈"
})

---------------------------
-- Za'qul --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	= "札奎爾撕開了一條通往狂亂領域的通道！",
	Tear =	"撕裂"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetOptionLocalization({
	SortDesc 			= "$spell:298569的資訊框架用最高減益層數排序 (取代最低的)。",
	ShowTimeNotStacks	= "$spell:298569的資訊框架顯示剩餘時間而非層數。"
})

L:SetMiscLocalization({
	SoakOrb   =	"吸收球",
	AvoidOrb  =	"躲開球",
	GroupUp  =	"集合",
	Spread     =	"分散",
	Move	   =	"保持移動",
	DontMove =	"停止移動",
	--For Yells,
	HelpSoakMove	= "{rt3}幫忙吸收移動{rt3}",--Purple Diamond
	HelpSoakStay	= "{rt6}幫忙吸收不動{rt6}",--Blue Square
	HelpSoak		    = "{rt3}幫忙吸收{rt3}",--Purple Diamond
	HelpMove		= "{rt4}幫忙移動{rt4}",--Green Triangle
	HelpStay		    = "{rt7}幫忙不動{rt7}",--Red X
	SoloSoak 		    = "單獨吸收",
	Solo 			    = "單獨",
	--Not currently used Yells
	SoloMoving		= "單獨移動",
	SoloStay		    = "單獨不動",
	SoloSoakMove	= "單獨吸收移動",
	SoloSoakStay	= "單獨吸收不動"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"永恆宮殿小怪"
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
	InterruptBehavior	= "設置小怪的打斷方式（團長的設置將覆蓋全團）",
	Four				= "4人輪流 ",
	Five				= "5人輪流 ",--Default
	Six					= "6人輪流 ",
	NoReset				= "無盡增長 "
})

L:SetMiscLocalization({
	ObeliskSpawn	= "出現吧，暗影方尖碑！"--Only as backup, in case the NPC target check stops working
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
	OnlyParentBondMoves		= "只有當你是帶電者時才顯示電鍊連結的特別警告"
})

L:SetMiscLocalization({
	Furthest	= "最遠的目標",
	Closest		= "最近的目標"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "僅設置一次圖示，除非一個淤泥死亡，否則不刷新標記圖示",
	InterruptBehavior	= "設置脈動之血的打斷方式（團長的設置將覆蓋全團）",
	Two					= "2人輪流 ",--Default
	Three				= "3人輪流 ",
	Four				= "4人輪流 ",
	Five				= "5人輪流 "
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
	InterruptBehavior	= "設置心志破壞的打斷方式（團長的設置將覆蓋全團）",
	Four				= "4人輪流 ",
	Five				= "5人輪流 ",--Default
	Six					= "6人輪流 ",
	NoReset				= "無盡增長 ",
	ArrowOnGlare		= "為 $spell:317874 顯示左/右方向箭頭",
	HideDead			= "在非傳奇難度隱藏資訊框架中死亡的玩家"
})

L:SetMiscLocalization({
	ExitMind		= "離開精神世界",
	Gate			= "心門"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"奈奧羅薩小怪"
})
