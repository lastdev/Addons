local E, L, C = select(2, ...):unpack()

if E.isClassic then E.changelog = [=[
v1.14.4.2773
	Fixed incorrect sorting when a unit dies or resurrects on ver.2772
	Added option to change icon texture for 'Trinket, Main Hand, Consumables' spell type.

]=]
elseif E.isBCC then E.changelog = [=[
v2.5.4.2722
	Fixed sync for cross realm group members

]=]
elseif E.isWOTLKC then E.changelog = [=[
v3.4.3.2773
	Added season 8 Wrathful Gladiator's set bonuses
	Fixed incorrect sorting when a unit dies or resurrects on ver.2772
	Added option to change icon texture for 'Trinket, Main Hand, Consumables' spell type.

]=]
else E.changelog = [=[
v10.2.0.2773
	Fixed incorrect sorting when a unit dies or resurrects on ver.2772
	Added Dreamwalker's Healing Potion, Potion of Withering Dream, Potion of Withering Vitality (merged).
	Added option to change icon texture for 'Trinket, Main Hand, Consumables' spell type.
	Cell support update (test func removed)

]=]
end

E.changelog = E.changelog .. "\n\n|cff808080Full list of changes can be found in the CHANGELOG file"
