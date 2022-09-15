--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="tw",date="2022-09-11T07:02:55Z",numCharacters=16420,db={}}
local F

F = function() provider.db["暗影之月"]={0,"Spades"} end F()

F = nil
RaiderIO.AddProvider(provider)
