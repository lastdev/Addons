This new library is the result of some frustrations with . . .

. . . pretty much every third party library available for WoW, and with WoW's own widgets often requiring a lot of initialization, as well as a lack of some of the more advanced widgets and functionality found in other libraries.


This set of libraries is very different from Ace3: Instead of wrapping Blizzard's own controls out of existence, which steals away much of the power you get from Blizzard's own controls, this library adds functionality to Blizzard's own controls.

================================================================================

The purpose of this library:

Make creation of new controls simple. Right now, Blizzard's own controls require a lot of initialization, which is often poorly documented. This library seeks to reduce initialization of common controls to a single command, and adds some decent defaults to most controls.

--------------------------------------------------------------------------------

NOT the purpose of this library:

Creating configuration dialogs. This library seeks to be general purpose, and not specifically for the sake of just creating configuration controls.

Redoing every control. Right now, this library is limited in scope to the needs of Reagent Restocker.

===============================================================================

Okay folks, here are the REAL principles of software engineering:

Keep It Simple and Straightforward. Not twisted, dysfunctional, convuluted, and confusing.

Model, View, Controller. Your data is in the model. Your UI is in your view. Your decisions are made in the controller. You can have more than one of each component.

Initialize, perform operations, and destroy. That's the general pattern of an object. While in a language like Lua, hooking is common, it's also messy.

Clear interfaces, clear components. Make what you're doing crystal clear in any documentation you have, and don't be afraid to say something that has been said before.