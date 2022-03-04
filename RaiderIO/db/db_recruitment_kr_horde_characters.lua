--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="kr",faction=2,date="2022-03-02T06:37:00Z",numCharacters=21634,db2={}}
local F

F = function() provider.db2["아즈샤라"]={0,"라떼뚜이","사티어","전부쿨임아님말고","철학하는법사","칼끗딜"} end F()
F = function() provider.db2["헬스크림"]={10,"냥냥펀치사냥냥꾼","바람과같다"} end F()
F = function() provider.db2["하이잘"]={14,"김짱후"} end F()

F = nil
RaiderIO.AddProvider(provider)
