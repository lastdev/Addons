--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="tw",faction=2,date="2022-05-15T07:25:38Z",numCharacters=20166,db2={}}
local F

F = function() provider.db2["冰風崗哨"]={0,"桌子君","烤雞翅"} end F()

F = nil
RaiderIO.AddProvider(provider)
