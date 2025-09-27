AngleurUnderlight_Translate = {}
local T = AngleurUnderlight_Translate

local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)
local colorBlu = CreateColor(0.61, 0.85, 0.92)
local colorWhite = CreateColor(1, 1, 1)
local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
local colorGrae = CreateColor(0.85, 0.85, 0.85)

T["\nset as Main Fishing Rod."] = "\nset as Main Fishing Rod."

T["\nWhen you start swimming, the " .. colorUnderlight:WrapTextInColorCode("Underlight Angler ") .. " will be " 
.. "equipped to trigger the buff.\n\nWhen you stop swimming, your main fishing rod will be re-equipped"] = "\nWhen you start swimming, the " 
.. colorUnderlight:WrapTextInColorCode("Underlight Angler ") .. " will be " 
.. "equipped to trigger the buff.\n\nWhen you stop swimming, your main fishing rod will be re-equipped"

T["No main fishing rod set"] = "No main fishing rod set"

T["\nYour " .. colorUnderlight:WrapTextInColorCode("Underlight Angler ") 
.. "will be swapped in and out to keep the buff active when you start/stop swimming.\n\n" 
.. colorYello:WrapTextInColorCode("Drag ") .. "a fishing rod here to set it as main."] = "\nYour " 
.. colorUnderlight:WrapTextInColorCode("Underlight Angler ") .. "will be swapped in and out to keep the buff active when you start/stop swimming.\n\n" 
.. colorYello:WrapTextInColorCode("Drag ") .. "a fishing rod here to set it as main."

T["Can't drag item in combat."] = "Can't drag item in combat."
T["Not an equippable item. Please drag in your main fishing rod."] = "Not an equippable item. Please drag in your main fishing rod."
T["Not a fishing rod. Please drag in your main fishing rod."] = "Not a fishing rod. Please drag in your main fishing rod."
T["Item is equippable and fishing related, but not a fishing rod. Please drag in your main fishing rod."] = "Item is equippable and fishing related, but not a fishing rod. Please drag in your main fishing rod."

T[" the draggable item slot is reserved fishing rods that are NOT the " .. colorUnderlight:WrapTextInColorCode("Underlight Angler. ") 
.. "If you would like to use the Underlight Angler as your \'Main\' fishing rod, " 
.. "you can keep the box empty."] = " the draggable item slot is reserved fishing rods that are NOT the " 
.. colorUnderlight:WrapTextInColorCode("Underlight Angler. ") .. "If you would like to use the Underlight Angler as your \'Main\' fishing rod, " 
.. "you can keep the box empty."

T["The main fishing rod not found in bags. Cannot swap."] = "The main fishing rod not found in bags. Cannot swap."
T[" to open up the configuration if you'd like to change/remove the main fishing rod."] = " to open up the configuration if you'd like to change/remove the main fishing rod."
T["Underlight Angler not found in bags. Cannot equip."] = "Underlight Angler not found in bags. Cannot equip."

T[colorWhite:WrapTextInColorCode("Get ") .. colorBlu:WrapTextInColorCode("Angleur ")
.. colorWhite:WrapTextInColorCode("for increased functionality!")] = colorWhite:WrapTextInColorCode("Get ") .. colorBlu:WrapTextInColorCode("Angleur ") 
.. colorWhite:WrapTextInColorCode("for increased functionality!")

T["to re-open this window."] = "to\nre-open this\nwindow."



T["Angleur_Underlight Config"] = "Angleur_Underlight Config"
T["Delve Mode"] = "Delve Mode"

T["Keeps the fish form active while submerged inside " .. colorDarkBlu:WrapTextInColorCode("Underwater Delves,") 
.. " allowing for infinite breath.\n\n" .."Won't be able to re-equip " 
.. "\'Main\' Fishing Rod inside the delve while active."] = "Keeps the fish form active while submerged inside " 
.. colorDarkBlu:WrapTextInColorCode("Underwater Delves,") .. " allowing for infinite breath.\n\n" 
.."Won't be able to re-equip " .. "\'Main\' Fishing Rod inside the delve while active."

T["Waterwalking"] = "Waterwalking"

T["While " .. colorBlu:WrapTextInColorCode("Angleur ") .. "is " .. colorGrae:WrapTextInColorCode("Sleeping")
.. ", won't re-equip \'Main\' Fishing Rod " .. "when you stop swimming - allowing you to waterwalk.\n\nWhen you " 
.. colorYello:WrapTextInColorCode("wake ") .. colorBlu:WrapTextInColorCode("Angleur ") 
.. "up, your \'Main\' Fishing Rod will be equipped back."] = "While " .. colorBlu:WrapTextInColorCode("Angleur ") .. "is " 
.. colorGrae:WrapTextInColorCode("Sleeping") .. ", won't re-equip \'Main\' Fishing Rod " .. "when you stop swimming - allowing you to waterwalk.\n\nWhen you " 
.. colorYello:WrapTextInColorCode("wake ") .. colorBlu:WrapTextInColorCode("Angleur ") .. "up, your \'Main\' Fishing Rod will be equipped back."

T["Disabled.\n" .. "Needs " .. colorBlu:WrapTextInColorCode("Angleur\n") 
.. "to function."] = "Disabled.\n" .. "Needs " .. colorBlu:WrapTextInColorCode("Angleur\n") 
.. "to function."


T["Remove Main Fishing Rod"] = "Remove Main Fishing Rod"

T["Open Config"] = "Open Config"