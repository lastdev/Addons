--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="tw",faction=1,date="2022-03-02T06:37:00Z",numCharacters=21634,db1={}}
local F

F = function() provider.db1["語風"]={0,"Gnomeblood","Gnomebrew","最初的心願","那芙"} end F()
F = function() provider.db1["眾星之子"]={8,"Gnomefaker"} end F()
F = function() provider.db1["暗影之月"]={10,"Acinduction","Virgil","冬瓜茶","娜雅妮","拾九","流砂"} end F()

F = nil
RaiderIO.AddProvider(provider)
