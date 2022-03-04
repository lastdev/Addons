--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=2,region="tw",faction=1,date="2022-03-02T06:35:15Z",currentRaid={["name"]="Sepulcher of the First Ones",["shortName"]="SFO",["bossCount"]=11},previousRaid=nil,db1={}}
local F

F = function() provider.db1["暗影之月"]={0,"Eleme","Longhan","Missun","奧蕾賽絲","斯克拉姆","晨晨法","木瓜之槌教派","紊貓貓","阿莫維亞"} end F()
F = function() provider.db1["語風"]={18,"Jins","Jinx","Jinz","井上熊彥","人在做車在震","兔美子","喵小爪","小莉露美","檸檬蜜","熊吉同學","貓小拳","貓小爪","貓廚","麥弓","黃麥子"} end F()
F = function() provider.db1["眾星之子"]={48,"龍瀚"} end F()
F = function() provider.db1["日落沼澤"]={50,"那還蠻誇張的"} end F()

F = nil
RaiderIO.AddProvider(provider)
