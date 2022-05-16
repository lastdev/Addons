--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="tw",faction=1,date="2022-05-09T07:06:48Z",numCharacters=19786,lookup1={},recordSizeInBytes=2,encodingOrder={0,1,3}}
local F

-- chunk size: 36
F = function() provider.lookup1[1] = "?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29?\29" end F()

F = nil
RaiderIO.AddProvider(provider)
