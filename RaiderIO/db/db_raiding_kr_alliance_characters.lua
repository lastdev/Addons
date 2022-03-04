--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=2,region="kr",faction=1,date="2022-03-02T06:35:15Z",currentRaid={["name"]="Sepulcher of the First Ones",["shortName"]="SFO",["bossCount"]=11},previousRaid=nil,db1={}}
local F

F = function() provider.db1["줄진"]={0,"집이다","칩이","칩이냐","칩이냐아","칩이다","칩이닷","칩이일까","칩이일껄","칩이일수도","칩이지렁","칩이지롱"} end F()
F = function() provider.db1["굴단"]={22,"슐이슐이"} end F()
F = function() provider.db1["하이잘"]={24,"꾸릉","법사후니","분위기있는검무드","블루큐라소라떼","빠삐양조","뿌뇨","손여름","시티즈스카이라인","흑임자낙엽라떼"} end F()
F = function() provider.db1["헬스크림"]={42,"격룡신","경증힙스터","공허가넘쳐흐른다","마스터아시아","아벨라나","이나벨라","중증힙스터","피사소울","피사솔"} end F()
F = function() provider.db1["아즈샤라"]={60,"파자마그녀","햄토리링"} end F()
F = function() provider.db1["불타는군단"]={64,"타래팬덩"} end F()

F = nil
RaiderIO.AddProvider(provider)
