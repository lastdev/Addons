-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

FLO_ASPECT_SPELLS = {
	["HUNTER"] = {
		{ id = 186257, duration = 12, modifier = function(x) if select(4, GetTalentInfo(3, 3, 1)) then x.duration = x.duration + 6 end end },
		{ id = 193530, duration = 10 },
		{ id = 61648, duration = 60 },
		{ id = 186289, duration = 10 },
		{ id = 186265, duration = 8 }
	}
};

