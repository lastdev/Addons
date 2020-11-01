-- enUS Localization
-- If the loading order of the files is incorrect, this will fail when trying to use AddonLocales.
-- Locales should be loaded AFTER Init and before anything that uses them.
-- So basically make sure they are all loaded together in the TOC right after Init (constants is OK too).
local _, Addon = ...
Addon:AddLocale("enUS",
{
-- Core
["ADDON_NAME"] = "Vendor",
["ADDON_LOADED"] = "is loaded. Type '/vendor help' for usage.",

-- Bindings
["BINDING_HEADER_VENDORQUICKLIST"] = "Quick Add/Remove items from the sell lists when mousing over the item",
["BINDING_NAME_VENDORALWAYSSELL"] = "Toggle Always-Sell Item",
["BINDING_DESC_VENDORALWAYSSELL"] = "Adds the item currently in the game tooltip to the Always-sell list. Removes it if it is already in the list.",
["BINDING_NAME_VENDORNEVERSELL"] = "Toggle Never-Sell Item",
["BINDING_DESC_VENDORNEVERSELL"] = "Adds the item currently in the game tooltip to the Never-sell list. Removes it if it is already in the list.",
["BINDING_NAME_VENDORRUNAUTOSELL"] = "Autosell at Merchant",
["BINDING_DESC_VENDORRUNAUTOSELL"] = "Manually trigger an autoselling run while at a merchant.",
["BINDING_NAME_VENDORRULES"] = "Toggle the Vendor Rules menu",
["BINDING_DESC_VENDORRULES"] = "Toggles the visibility of the main Vendor Rules menu.",

-- Merchant
["MERCHANT_REPAIR_FROM_GUILD_BANK"] = "Repaired all equipment from the guild bank for %s",
["MERCHANT_REPAIR_FROM_SELF"] = "Repaired all equipment for %s",
["MERCHANT_SELLING_ITEM"] = "Sold %s for %s",
["MERCHANT_WITHDRAW_ITEM"] = "Withdrawing %s to sell.",
["MERCHANT_SOLD_ITEMS"] = "Sold %s items for %s",
["MERCHANT_WITHDRAWN_ITEMS"] = "Withdrew %s items.",
["MERCHANT_SELL_LIMIT_REACHED"] = "Reached the sell limit (%s), stopping auto-sell.",
["MERCHANT_AUTO_CONFIRM_SELL_TRADE_REMOVAL"] = "Auto-accepted confirmation of making %s non-tradeable.",
["MERCHANT_SCRAP_ITEM"] = "Scrapping %s (%d/%d)",
["MERCHANT_NO_SCRAP"] = "There are no items to scrap.",
["MERCHANT_POPULATING_SCRAP"] = "Auto-populating scrapper:",
["MERCHANT_MORE_SCRAP"] = "There are more items in your inventory which could be scrapped after scrapping these close and re-open the scrapper to continue",

-- Delete
["DELETE_DELETED_ITEMS"] = "Deleted %s items.",
["DELETE_DELETING_ITEM"] = "Deleting %s",

-- Tooltip
["TOOLTIP_ADDITEM_ERROR_NOITEM"] = "Failed to add item to %s-sell list. The game tooltip is not over an item.",
["TOOLTIP_ITEM_IN_ALWAYS_SELL_LIST"] = "Vendor: Always Sell",
["TOOLTIP_ITEM_IN_NEVER_SELL_LIST"] = "Vendor: Never Sell",
["TOOLTIP_ITEM_WILL_BE_SOLD"] = "Will be sold by Vendor",
["TOOLTIP_ITEM_WILL_BE_DELETED"] = "Will be DELETED by Vendor",
["TOOLTIP_RULEMATCH_SELL"] = "Sell: %s",
["TOOLTIP_RULEMATCH_KEEP"] = "Keep: %s",

-- Options
["OPTIONS_TITLE_ADDON"] = "These settings are for configuring Vendor behavior.\n\n",
["OPTIONS_SHOW_BINDINGS"] = "Key Bindings",
["OPTIONS_OPEN_RULES"] = "Open Rules",


["OPTIONS_HEADER_REPAIR"] = "Repair",
["OPTIONS_DESC_REPAIR"] = "Whether to auto-repair, and how to pay for it.\n",
["OPTIONS_SETTINGNAME_AUTOREPAIR"] = "Auto-Repair",
["OPTIONS_SETTINGDESC_AUTOREPAIR"] = "Automatically repair when visiting a repair-capable vendor.",
["OPTIONS_SETTINGNAME_GUILDREPAIR"] = "Use Guild Bank",
["OPTIONS_SETTINGDESC_GUILDREPAIR"] = "Uses guild bank for repairs if possible.",

-- Main Config Panel (aka Selling)
["OPTIONS_HEADER_SELLING"] = "General",
["OPTIONS_DESC_SELLING"] = "What to sell at a vendor automatically. Keep rules are always processed first, then Sell rules run on items that remain. By default we have several safeguard Keep rules enabled so you don't accidentally sell something you want. Before disabling any Keep rules, you should definitely take a look at the sell rules that are enabled first.\n",
["OPTIONS_SETTINGNAME_AUTOSELL"] = "Auto-Sell",
["OPTIONS_SETTINGDESC_AUTOSELL"] = "Automatically sell items when interacting with a merchant. If this is disabled you can still manually sell by setting a hotkey.",
["OPTIONS_SETTINGNAME_BUYBACK"] = "Limit number sold to 12",
["OPTIONS_SETTINGDESC_BUYBACK"] = "Limits the number of items sold each time an autosell is triggered to 12, which is the buyback limit. This allows you to always buy back any items that were sold.",
["OPTIONS_SETTINGNAME_CONFIG"] = "Open Rule Config",
["OPTIONS_SETTINGDESC_CONFIG"] = "Shows the Rule Configuration Dialog, allowing you to toggle rules and create your own rules.",
["OPTIONS_SETTINGNAME_TOOLTIP"] = "Enable ToolTip",
["OPTIONS_SETTINGDESC_TOOLTIP"] = "Vendor will add a line to the tooltip indicating when the item will be sold. ",
["OPTIONS_SETTINGNAME_EXTRARULEINFO"] = "Extra rule information",
["OPTIONS_SETTINGDESC_EXTRARULEINFO"] = "Include information about the rule that causes the item to be sold or kept. An item may match multiple rules; this will only display the first one that matches.",
["OPTIONS_SETTINGNAME_MAXITEMS"] = "Limit number of items to sell",
["OPTIONS_SETTINGDESC_MAXITEMS"] = "Controls the maximum number items vendor will auto-sell at each visit. If you want to be able to buy-back all items sold, set this to 12.",

-- Performance Settings tab
["OPTIONS_CATEGORY_PERFORMANCE"] = "Performance",
["OPTIONS_TITLE_PERFORMANCE"] = "Vendor makes use of throttling and coroutines to avoid unresponsiveness in the interface and client disconnects. These settings control that behavior.\n\n",

["OPTIONS_HEADER_THROTTLES"] = "Throttles",
["OPTIONS_DESC_THROTTLES"] = "These values all set how many actions are taken per throttle cycle.",
["OPTIONS_SETTINGNAME_SELL_THROTTLE"] = "Items Vendored Per Cycle",
["OPTIONS_SETTINGDESC_SELL_THROTTLE"] = "This is the number of items vendored per sell cycle. Increase this if you want to sell items more in bulk, but lower this to lower the risk Blizzard will throttle you.",

["OPTIONS_HEADER_FREQUENCY"] = "Frequency",
["OPTIONS_DESC_FREQUENCY"] = "Sets how frequently a throttled task executes per second. Changing this affects all throttles.",
["OPTIONS_SETTINGNAME_CYCLE_RATE"] = "Cycle Rate",
["OPTIONS_SETTINGDESC_CYCLE_RATE"] = "Interval in seconds between attempts to sell the throttled number of items specified above. Lower is faster. Increase this to slow down sell rate if you notice throttling from Blizzard.",

-- Console Commands
["CMD_HELP_HEADER"] = "Command Reference: ",
["CMD_HELP_HELP"] = "Show this command list reference.",

["CMD_SETTINGS_HELP"] = "Open the settings in the interface options.",
["CMD_RULES_HELP"] = "Open the Sell/Keep Rules configuration panel.",
["CMD_KEYS_HELP"] = "Open keybindings. Working with blocklists is much easier with keybinds!",
["CMD_WITHDRAW_HELP"] = "Withdraws any items from you bank which vendor would sell, requires your bank to be open",
["CMD_API_HELP"] = "Prints the public API for Vendor",

["CMD_SELLITEM_HELP"] = "Adds or removes items from the sell list: sell {always||never} [itemid]",
["CMD_SELLITEM_INVALIDARG"] = "Must specify which list to which you want to query or edit an item: {always||never} [item]",
["CMD_SELLITEM_ADDED"] = "Item: %s added to the %s-sell list.",
["CMD_SELLITEM_REMOVED"] = "Item: %s removed from the %s-sell list.",

["CMD_CLEARDATA_HELP"] = "Clears data for all lists, or the list if specified. Usage: clear [always||never]",
["CMD_CLEARDATA_INVALIDARG"] = "Invalid option: %s  Usage: clear [always||never]",
["CMD_CLEARDATA_ALWAYS"] = "The always-sell list has been cleared.",
["CMD_CLEARDATA_NEVER"] = "The never-sell list has been cleared.",

["CMD_LISTDATA_HELP"] = "Prints the items for all lists, or the list if specified. Usage: list [always||never]",
["CMD_LISTDATA_INVALIDARG"] = "Invalid option: %s  Usage: clear [always||never]",
["CMD_LISTDATA_EMPTY"] = "The %s-sell list is empty.",
["CMD_LISTDATA_LISTHEADER"] = "Items in the %s-sell list:",
["CMD_LISTDATA_LISTITEM"] = "  %s - %s",
["CMD_LISTDATA_NOTINCACHE"] = "[Item not seen yet, re-run to see it]",

["CMD_AUTOSELL_MERCHANTNOTOPEN"] = "Merchant window is not open. You must be at a merchant to auto-sell.",
["CMD_AUTOSELL_INPROGRESS"] = "Already auto-selling. Please wait for completion before re-running.",
["CMD_AUTOSELL_EXECUTING"] = "Running auto-sell.",

-- API
["API_REGISTEREXTENSION_TITLE"] = "Register Extension",
["API_REGISTEREXTENSION_DOCS"] = "Registers a Vendor extension with Vendor. See CurseForge documentation for details.",
["API_EVALUATEITEM_TITLE"] = "Evaluate Item",
["API_EVALUATEITEM_DOCS"] = "Evaluates an item for selling. Input is a Tooltip + Link, Bag + Slot, or Link. Bag and Slot is best.",
["API_ADDTOALWAYSSELL_TITLE"] = "Add Tooltip Item To Always Sell List",
["API_ADDTOALWAYSSELL_DOCS"] = "Toggles the item that has a tooltip showing on or off the Always Sell list.",
["API_ADDTONEVERSELL_TITLE"] = "Add Tooltip Item To Never Sell List",
["API_ADDTONEVERSELL_DOCS"] = "Toggles the item that has a tooltip showing on or off the Never Sell list.",
["API_AUTOSELL_TITLE"] = "Run Autosell",
["API_AUTOSELL_DOCS"] = "Runs the autosell routine if at a merchant.",
["API_OPENSETTINGS_TITLE"] = "Open Settings",
["API_OPENSETTINGS_DOCS"] = "Opens the Vendor Settings page.",
["API_OPENKEYBINDINGS_TITLE"] = "Open Keybindings",
["API_OPENKEYBINDINGS_DOCS"] = "Opens the Vendor Keybindings page.",
["API_OPENRULES_TITLE"] = "Open Rules",
["API_OPENRULES_DOCS"] = "Opens the main Vendor Rules interface.",
["API_GETEVALUATIONSTATUS_TITLE"] = "Get Evaluation Status",
["API_GETEVALUATIONSTATUS_DOCS"] = "Returns current number of slots Vendor will take action, sell, delete, and their value.",
["API_GETPRICESTRING_TITLE"] = "Get Price String",
["API_GETPRICESTRING_DOCS"] = "Converts passed in integer to a color coded and icon embedded price string.",

-- Rules
["RULEUI_LABEL_ITEMLEVEL"] = "Level:",
["CONFIG_DIALOG_CAPTION"] = "Vendor Rules",
["CONFIG_DIALOG_KEEPRULES_TAB"] = "Keep Rules",
["CONFIG_DIALOG_KEEPRULES_TEXT"] = "These rules are safeguards to prevent selling things you don't want sold. All Keep Rules are checked before Sell Rules; However, anything you mark as 'Always Sell' will ignore Keep Rules.",
["CONFIG_DIALOG_SELLRULES_TAB"] = "Sell Rules",
["CONFIG_DIALOG_SELLRULES_TEXT"] = "Anything you mark as 'Never Sell' will ignore Sell Rules and always be kept.  Keep Rules are always processed before Sell Rules, so if the Sell Rule you enable doesn't seem to work check the Keep Rules to see if something is preventing it.  Right-click to view a rule. Left-click to toggle it.",
["CONFIG_DIALOG_CUSTOMRULES_TAB"] = "Custom Definitions",
["CONFIG_DIALOG_CUSTOMRULES_TEXT"] = "The custom rules you have defined (account wide) are shown below.  You can create a new one by using the button on the bottom or edit your rule by double clicking it.  Rules defined here can be enabled/disabled from the appropriate Sell/Keep rule list tab.",
["CONFIG_DIALOG_CONFIRM_DELETE_FMT1"] = "Deleting '%s' will make it unavailable to all of your characters you sure you want to delete this rule?",
["CONFIG_DIALOG_SHARE_TOOLTIP"] = "Share",
["CONFIG_DIALOG_MOVEUP_TOOLTIP"] = "Click to move the rule sooner in evaluation order",
["CONFIG_DIALOG_MOVEDOWN_TOOLTIP"] = "Click to move the rule later in the evaluation order",
["CONFIG_DIALOG_SCRAPRULES_TAB"] = "Scrap Rules",
["CONFIG_DIALOG_SCRAPRULES_TEXT"] =  "The scrap rules will be removed at Shadowlands launch.",
["CONFIG_DIALOG_LISTS_TAB"] = "Sell Lists",
["CONFIG_DIALOG_LISTS_TEXT"] = "" ..
    YELLOW_FONT_COLOR_CODE .. "Left-Click" .. FONT_COLOR_CODE_CLOSE .. " removes the item from the list.|n" ..
    YELLOW_FONT_COLOR_CODE .. "Right-Click" .. FONT_COLOR_CODE_CLOSE .. " swaps the item to the other list.|n" ..
    YELLOW_FONT_COLOR_CODE .. "Dragging an item from your bags over a list" .. FONT_COLOR_CODE_CLOSE .. " adds it to that list.",
["CONFIG_DIALOG_LISTS_ALWAYS_LABEL"] = "Always Sell:",
["CONFIG_DIALOG_LISTS_NEVER_LABEL"] = "Never Sell:",

-- Sell Rules
["SYSRULE_SELL_ALWAYSSELL"] = "Items in Always Sell List",
["SYSRULE_SELL_ALWAYSSELL_DESC"] = "Items that are in the Always Sell list are always sold. You can view the full list with '/vendor list always'",
["SYSRULE_SELL_POORITEMS"] = "Poor Items",
["SYSRULE_SELL_POORITEMS_DESC"] = "Matches all "..ITEM_QUALITY_COLORS[0].hex.."Poor"..FONT_COLOR_CODE_CLOSE.." quality items which are the majority of the junk you will pick up.",
["SYSRULE_SELL_UNCOMMONGEAR"] = "Uncommon Gear",
["SYSRULE_SELL_UNCOMMONGEAR_DESC"] = "Matches Any "..ITEM_QUALITY_COLORS[2].hex.."Uncommon"..FONT_COLOR_CODE_CLOSE.." equipment with an item level less than the specified item level.",
["SYSRULE_SELL_RAREGEAR"] = "Rare Gear",
["SYSRULE_SELL_RAREGEAR_DESC"] = "Matches Any "..ITEM_QUALITY_COLORS[3].hex.."Rare"..FONT_COLOR_CODE_CLOSE.." equipment with an item level less than the specified item level.",
["SYSRULE_SELL_EPICGEAR"] = "Epic Gear",
["SYSRULE_SELL_EPICGEAR_DESC"] = "Matches Soulbound "..ITEM_QUALITY_COLORS[4].hex.."Epic"..FONT_COLOR_CODE_CLOSE.." equipment with an item level less than the specified item level. We assume you will want to sell BoE Epics on the auction house so BoEs are excluded.",
["SYSRULE_SELL_KNOWNTOYS"] = "Known Toys",
["SYSRULE_SELL_KNOWNTOYS_DESC"] = "Matches any already-known toys that are Soulbound.",
["SYSRULE_SELL_OLDFOOD"] = "Low-Level Food",
["SYSRULE_SELL_OLDFOOD_DESC"] = "Matches Food and Drink that is 10 or more levels below you. This will cover food from previous expansions and old food while leveling.",

-- Keep Rules
["SYSRULE_KEEP_NEVERSELL"] = "Items in Never Sell List",
["SYSRULE_KEEP_NEVERSELL_DESC"] = "Items that are in the Never Sell list are never sold. You can view the full list with '/vendor list never'",
["SYSRULE_KEEP_UNSELLABLE"] = "Unsellable Items",
["SYSRULE_KEEP_UNSELLABLE_DESC"] = "These items have no value and cannot be sold to a merchant. If you don't like it, take it up with Blizzard.",
["SYSRULE_KEEP_SOULBOUNDGEAR"] = "Soulbound Gear",
["SYSRULE_KEEP_SOULBOUNDGEAR_DESC"] = "Keeps any equipment item that is "..ITEM_QUALITY_COLORS[1].hex.."Soulbound"..FONT_COLOR_CODE_CLOSE.." to you even items your class cannot wear. A good safeguard if you are unsure about some rules.",
["SYSRULE_KEEP_BINDONEQUIPGEAR"] = "Bind-on-Equip Gear",
["SYSRULE_KEEP_BINDONEQUIPGEAR_DESC"] = "Keeps any equipment item that is "..ITEM_QUALITY_COLORS[1].hex.."Binds when equipped"..FONT_COLOR_CODE_CLOSE..".",
["SYSRULE_KEEP_COMMON"] = "Common Items",
["SYSRULE_KEEP_COMMON_DESC"] = "Matches any "..ITEM_QUALITY_COLORS[1].hex.."Common"..FONT_COLOR_CODE_CLOSE.." quality item. These are typically valuable consumables or crafting materials.",
["SYSRULE_KEEP_UNKNOWNAPPEARANCE"] = "Uncollected Appearances",
["SYSRULE_KEEP_UNKNOWNAPPEARANCE_DESC"] = "Matches any gear that is an Uncollected Appearance so you don't have to worry about missing a transmog.",
["SYSRULE_KEEP_LEGENDARYANDUP"] = "Legendary or Better Items",
["SYSRULE_KEEP_LEGENDARYANDUP_DESC"] = "Always keeps any items of "..ITEM_QUALITY_COLORS[5].hex.."Legendary"..FONT_COLOR_CODE_CLOSE.." quality or higher. This includes "..ITEM_QUALITY_COLORS[5].hex.."Legendaries"..FONT_COLOR_CODE_CLOSE..", "..ITEM_QUALITY_COLORS[6].hex.."Artifacts"..FONT_COLOR_CODE_CLOSE..", "..ITEM_QUALITY_COLORS[7].hex.."Heirlooms"..FONT_COLOR_CODE_CLOSE..", and "..ITEM_QUALITY_COLORS[8].hex.."Blizzard"..FONT_COLOR_CODE_CLOSE.." items (WoW Tokens).",
["SYSRULE_KEEP_UNCOMMONGEAR"] = "Uncommon Gear|r",
["SYSRULE_KEEP_UNCOMMONGEAR_DESC"] = "Matches any "..ITEM_QUALITY_COLORS[2].hex.."Uncommon"..FONT_COLOR_CODE_CLOSE.." quality equipment. Does not include non-equipment of Uncommon quality.",
["SYSRULE_KEEP_RAREGEAR"] = "Rare Gear",
["SYSRULE_KEEP_RAREGEAR_DESC"] = "Matches any "..ITEM_QUALITY_COLORS[3].hex.."Rare"..FONT_COLOR_CODE_CLOSE.." quality equipment. Does not include non-equipment of Rare quality.",
["SYSRULE_KEEP_EPICGEAR"] = "Epic Gear",
["SYSRULE_KEEP_EPICGEAR_DESC"] = "Matches any "..ITEM_QUALITY_COLORS[4].hex.."Epic"..FONT_COLOR_CODE_CLOSE.." quality equipment. Does not include non-equipment of Epic quality.",
["SYSRULE_KEEP_EQUIPMENTSET_NAME"] = "Equipment Sets",
["SYSRULE_KEEP_EQUIPMENTSET_DESC"] = "Matches any item that is a member of an equipment set created by the built-in "..ITEM_QUALITY_COLORS[8].hex.."Blizzard"..FONT_COLOR_CODE_CLOSE.." equipment manager",

-- Tooltip Scan Overrides - Note for folks of non-English languages. If these scans don't work properly, create a new locale and override them. They have been confirmed to be correct in several languages, so probably dont need to be changed.
["TOOLTIP_SCAN_UNKNOWNAPPEARANCE"] = _G["TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN"],
["TOOLTIP_SCAN_ARTIFACTPOWER"] = _G["ARTIFACT_POWER"],
["TOOLTIP_SCAN_TOY"] = _G["TOY"],
["TOOLTIP_SCAN_ALREADYKNOWN"] = _G["ITEM_SPELL_KNOWN"],
["TOOLTIP_SCAN_CRAFTINGREAGENT"] = _G["PROFESSIONS_USED_IN_COOKING"],

-- Data Migration
["DATA_MIGRATION_SL_NOTICE"] = YELLOW_FONT_COLOR_CODE.. "Detected migration to Shadowlands! The settings for Vendor have been reset and custom rules require verification before they will be active!" ..FONT_COLOR_CODE_CLOSE,
["DATA_MIGRATION_ERROR"] = YELLOW_FONT_COLOR_CODE.. "Data migration error. Migration was detected, but no action taken. Please notify the addon authors here: https://www.curseforge.com/wow/addons/vendor/issues" ..FONT_COLOR_CODE_CLOSE,

-- Edit Rule Dialog
["EDITRULE_CAPTION"] = "Edit Rule",
["VIEWRULE_CAPTION"] = "View Rule",
["CREATE_BUTTON"] = "Create",
["EDITRULE_NAME_LABEL"] = "Name:",
["EDITRULE_NAME_HELPTEXT"] = "type the name of your rule here",
["EDITRULE_FILTER_LABEL"] = "Filter:",
["EDITRULE_FILTER_HELPTEXT"] = "click here to filter the help",
["EDITRULE_DESCR_LABEL"] = "Description:",
["EDITRULE_DESCR_HELPTEXT"] = "type the description of your rule here",
["EDITRULE_SCRIPT_LABEL"] = "Script:",
["EDITRULE_SCRIPT_HELPTEXT"] = "enter the script for your rule here, see 'Help' for a list of available functions along with relational operators: and, or, >, >=, <, <=, ==, ~=",
["EDITRULE_HELP_TAB_NAME"] = "Help",
["EDITRULE_MATCHES_TAB_NAME"] = "Matches",
["EDITRULE_MATCHES_TAB_TEXT"] = "Below you can see all of the items currently in your inventory which would be matched by this rule.",
["EDITRULE_ITEMINFO_TAB_NAME"] = "Item Info",
["EDITRULE_ITEMINFO_TAB_TEXT"] = "Drag an item into the space below to view the properties of that item. Properties with quotes (\") around them are strings, and the quotes are required for matching.",
["EDITRULE_SELLRULE_LABEL"] = "Sell Rule",
["EDITRULE_SELLRULE_TEXT"] = "A sell rule determines if Vendor will sell the item when the rule evaluates to true",
["EDITRULE_KEEPRULE_LABEL"] = "Keep Rule",
["EDITRULE_KEEPRULE_TEXT"] = "A keep rule determines if Vendor will keep the item when the rule evaluates to true",
["EDITRULE_SCRAPRULE_TEXT"] = " << Needs Text >> ",
["EDITRULE_SCRAPRULE_LABEL"] = "Scrap Rule",

["EDITRULE_UNHEALTHY_RULE"] = "Unhealthy Rule",
["EDITRULE_ERROR_RULE"] = "Validation Error",
["EDITRULE_OK_TEXT"] = "Rule Ok",
["EDITRULE_RULEOK_TEXT"] = "Your rule passed validation; check the matches tab to be sure it does what you expect.",
["EDITRULE_SCRIPT_ERROR"] = "The following error was found validating your rule:\n",
["EDITRULE_NO_MATCHES"] = "<p>This rule does not match anything in your inventory.</p>",
["EDITRULE_MATCHES_HEADER_FMT"] = "<h1>This rule matched %d items in your inventory</h1>",
["EDITRULE_RULE_SOURCE_FMT"] = "Source: %s",
["EDITRULE_MIGRATE_RULE_TITLE"] ="Verify Rule",
["EDITRULE_MIGRATE_RULE_TEXT"] ="Rule requires review before it can be used. Please verify that it matches what you expect and save.",

["RULEITEM_MIGRATE_WARNING"] = HIGHLIGHT_FONT_COLOR_CODE .. "Warning: " .. FONT_COLOR_CODE_CLOSE .. "This rule was created before an expansion itemlevel squish. For safety this rule has been disabled until it is reviewed by you. Right-click to review.",


-- ITEM PROPERTIES HELP

["HELP_NAME_HTML"] = [[
<p>The item name, as it appears in the tooltip. This is a localized string.</p>
]],
["HELP_LINK_HTML"] = [[
<p>The item link, including all color codes and the item string. This may be useful if you want to string.find specific ids in the item string.</p>
]],
["HELP_ID_HTML"] = [[
<p>The item ID, as a number.</p>
]],
["HELP_COUNT_HTML"] = [[
<p>The quantity of the item, as a number.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This will always be 1 for links to items. When we scan items in your bag it will be the actual quantity for the slot. This means if you make a rule
that sells based on quantity then the tooltip for Vendor selling it will not be accurate when mousing over an item since that uses its tootip link, not
the bag slot information. The matches tab uses items in your bag so it will be correct for what Vendor will sell.
</p>
]],
["HELP_QUALITY_HTML"] = [[
<p>The quality of the item:<br/>
<br/>0 = Poor<br/>1 = Common<br/>2 = Uncommon<br/>3 = Rare<br/>4 = Epic<br/>5 = Legendary<br/>6 = Artifact<br/>7 = Heirloom<br/>8 = Wow Token<br/>
</p>
]],
["HELP_LEVEL_HTML"] = [[
<p>The item level (iLvl) of the item.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This will be the item's effective item level if it is Equipment, otherwise it will be the base item level if it does not have an effective item level.
</p>
]],
["HELP_MINLEVEL_HTML"] = [[
<p>The required character level for equipping the item.</p>
]],
["HELP_TYPE_HTML"] = [[
<p>The name of the item's Type. This is a localized string. You can use this in conjunction with SubType to zero in on specific types of items.</p>
]],
["HELP_TYPEID_HTML"] = [[
<p>The numeric ID of the item's Type.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This is not localized so it will be portable to players using other locales. It's also faster than a string compare, so you should use this over Type() if possible.
</p>
]],
["HELP_SUBTYPE_HTML"] = [[
<p>The name of the item's SubType. This is a localized string. You can use this in conjunction with Type to zero in on specific types of items.</p>
]],
["HELP_SUBTYPEID_HTML"] = [[
<p>The numeric ID of the item's SubType.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This is not localized so it will be portable to players using other locales. It's also faster than a string compare, so you should use this over SubType() if possible.
</p>
]],
["HELP_EQUIPLOC_HTML"] = [[
<p>The equip location of this item. This will be nil if the item is not equipment.</p>
]],
["HELP_BINDTYPE_HTML"] = [[
<p>The binding behavior for the item.</p>
<p>
<br/>0 = None
<br/>1 = On Pickup
<br/>2 = On Equip
<br/>3 = On Use
<br/>4 = Quest
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This is the base behavior of the item itself, not the current bind state of the item. This does NOT accurately tell you if the item is SoulBound or Bind-on-Equip by itself.
If you want to know if an item is BoE or Soulbound, use IsBindOnEquip() and IsSoulbound()
</p>
]],
["HELP_STACKSIZE_HTML"] = [[
<p>The max stack size of this item.</p>
]],
["HELP_UNITVALUE_HTML"] = [[
<p>The vendor price in copper for one of these items.<br/><br/>
</p>
<h2>Notes:</h2>
<p>
Items with UnitValue == 0 cannot be sold to a vendor. Such items will never match any rules because you cannot possibly sell them.
</p>
]],
["HELP_NETVALUE_HTML"] = [[
<p>The vendor price in copper for this stack. This is equivalent to Count() * UnitValue()</p>
]],
["HELP_EXPANSIONPACKID_HTML"] = [[
<p>The expansion pack ID to which this item belongs.</p>
<p>
<br/>0 = Default / None (this matches many items)
<br/>1 = BC
<br/>2 = WoTLK
<br/>3 = Cata
<br/>4 = MoP
<br/>5 = WoD
<br/>6 = Legion
<br/>7 = BFA
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
Use caution when using this to identify items of previous expansions. Not every item is tagged with an expansion ID. It appears that generally only wearable equipment is tagged. Zero is the default for everything,
including many items from Expansion packs (like reagants and Dalaran Hearthstones).
We recommend that you only use this for rules involving wearable equipment. Checking ExpansionPackId() == 0 intending to match Vanilla will not do what you want, as it will include non-Vanilla things. Likewise,
ExpansionPackId() &lt; 7 will match a great many items. If you want to be safe, use this in conjunction with IsEquipment(), and have some items from Vanilla and several expansion packs to verify.
</p>
]],
["HELP_ISEQUIPMENT_HTML"] = [[
<p>True if the item is wearable equipment. This is equivalent to EquipLoc() ~= nil
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This does NOT tell you if your character can equip the item. This tells you whether the item is equippable gear.
</p>
]],
["HELP_ISSOULBOUND_HTML"] = [[
<p>True if this specific item is currently "Soulbound" to you.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
If the item's bind type is Bind-on-pickup then this will always report true, even for items you have not yet picked up if you are mousing over them. This is because the item will be Soulbound if you were to pick it up,
so we are accurately representing the resulting behavior of the item. If an item is Binds-when-equipped or on use, then IsSoulbound() will return false unless you actually have the item in your possession and we can
verify its true state.
</p>
]],
["HELP_ISBINDONEQUIP_HTML"] = [[
<p>True if this specific item is currently "Binds-when-equipped".
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
If the item's bind type is Bind-on-pickup then this will always report false, even for items you have not yet picked up if you are mousing over them. This is becuase the item cannot possibly be Binds-when-equipped. If the
item has yet to be picked up and it has a bind type of On-Equip, then we will always report it as true. If it is in your possession and Soulbound to you, then this will return false.
</p>
]],
["HELP_ISBINDONUSE_HTML"] = [[
<p>True if this specific item is currently "Binds-when-used".
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
If the item is not yet in your possession, then it will always return true if its bind type is On-Use. If it is in your possession and Soulbound to you then this will return false.
</p>
]],
["HELP_ISARTIFACTPOWER_HTML"] = [[
<p>True if this item is Artifact Power.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This is obsolete with the 8.0.1 patch, as Blizzard removed Artifact Power as an item of this type and changed them all to grey items. As such, this value will likely be removed in the future.
</p>
]],
["HELP_ISUNKNOWNAPPEARANCE_HTML"] = [[
<p>True if the item you have not yet collected this item Appearance AND the item is not Bind-on-Pickup.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This will correctly detect items which are unknown appearances (i.e. transmogs you have not yet acquired). However, if the item is BoP, it will not be treated as an Unknown Appearance. This is because the moment you pick up the
item it will become a known appearance. Therefore, it is safe to sell and this inforamtion is irrelevant. This method is used to filter on Bind-on-Equip items that are Unknown Appearances and is generally useful for preventing
you from accidentally selling them. We have a built-in Keep rule for this purpose, so generally you won't need to use this.
</p>
]],
["HELP_ISTOY_HTML"] = [[
<p>True if the item is a toy.</p>
]],
["HELP_ISCRAFTINGREAGENT_HTML"] = [[
<p>True if this specific item is a crafting reagent.
<br/><br/>
</p>
<h2>Notes:</h2>
<p>
This is determined by the tooltip text. Note that if you drag a crafting reagent to the item box in a custom rule definition to read its properties, that item may incorrectly report as "false" but it will evaluate correctly with this property.
</p>
]],
["HELP_ISALREADYKNOWN_HTML"] = [[
<p>True if the item is "Already known", such as a Toy or Recipe you have already learned.</p>
]],
["HELP_ISUSABLE_HTML"] = [[
<p>True if the item can be used, such as if it has a "Use:" effect described in its tooltip.</p>
]],


-- FUNCTION HELP

["HELP_PLAYERLEVEL"] = "Returns the current level of the player",
["HELP_PLAYERCLASS"] = "Returns the localized class name of the player. This should match any localized class names in your client, such as the tooltip.",
["HELP_ISALWAYSSELLITEM"] = "Returns the state of the item in the always sell list.  A return value of tue indicates it belongs to the list while false indicates it does not.",
["HELP_ISNEVERSELLITEM"] = "Returns the state of the item in the never sell list.  A return value of true indicates it belongs to the list false indicates it does not.",

["HELP_ITEMQUALITY_ARGS"] = "qual [, qual1..qualN]",
["HELP_ITEMQUALITY_TEXT"] = "Determines the item quality",

["HELP_ITEMISFROMEXPANSION_ARGS"] = "xpack0 [, xpack1 .. xpackN]",
["HELP_ITEMISFROMEXPANSION_TEXT"] = "For items which are marked with and expansion this will compare it against the argeuments, they can either be the numeric identifier or one of the strings shown below.",

["HELP_ITEMTYPE_ARGS"] = "type0 [, type2...typeN]",
["HELP_ITEMTYPE_TEXT"] = "Checks the item type against the string/number passed in which represents the item type",


["HELP_ISINEQUIPMENTSET_ARGS"] = "[setName0 .. setNameN]",
["HELP_ISINEQUIPMENTSET_HTML"] = "<p>Checks if the item is a memmber of a Blizzard equipment set and returns true if found." ..
               " If no arguments are provied then all of the chracters equipment sets are check, otherwise" ..
               " this checks only the specified sets.<br/><br/>" ..
               "Examples:<br/>" ..
               "Any: " .. GREEN_FONT_COLOR_CODE .. "IsInEquipmentSet()<br/>" .. FONT_COLOR_CODE_CLOSE ..
               "Specific: " .. GREEN_FONT_COLOR_CODE .. "IsInEquipmentSet(\"Tank\")</p>" .. FONT_COLOR_CODE_CLOSE,

["HELP_TOOLTIPCONTAINS_ARGS"] = "text [, side, line]",
["HELP_TOOLTIPCONTAINS_HTML"] = "<p>Checks if specified text is in the item's tooltip." ..
               " Which side of the tooltip (left or right), and a specific line to check are optional." ..
               " If no line or side is specified, the entire tooltip will be checked.<br/><br/>" ..
               "Examples:<br/>" ..
               "Anywhere: " .. GREEN_FONT_COLOR_CODE .. "TooltipContains(\"Rogue\")<br/>" .. FONT_COLOR_CODE_CLOSE ..
               "Check left side line 1: " .. GREEN_FONT_COLOR_CODE .. "TooltipContains(\"Vanq\", \"left\", 1)</p>" .. FONT_COLOR_CODE_CLOSE,


["ITEMLIST_REMOVE_FROM_SELL_FMT"] = 
    "%s has been removed from the " .. ORANGE_FONT_COLOR_CODE .. "ALWAYS" .. FONT_COLOR_CODE_CLOSE .. " sell list",
["ITEMLIST_REMOVE_FROM_KEEP_FMT"] = 
    "%s has been removed from the " .. GREEN_FONT_COLOR_CODE .. "NEVER" .. FONT_COLOR_CODE_CLOSE .. " sell list",
["ITEMLIST_ADD_TO_SELL_FMT1"] = 
    "%s has been added to then " .. ORANGE_FONT_COLOR_CODE .. "ALWAYS" .. FONT_COLOR_CODE_CLOSE .. " sell list",
["ITEMLIST_ADD_TO_KEEP_FMT1"] = 
    "%s has been added to the " .. GREEN_FONT_COLOR_CODE .. "NEVER" .. FONT_COLOR_CODE_CLOSE .. " sell list",
["ITEMLIST_MOVE_FROM_KEEP_TO_SELL_FMT"] = 
    "%s has been moved from the " .. 
    GREEN_FONT_COLOR_CODE .. "NEVER" .. FONT_COLOR_CODE_CLOSE ..
    " sell list to the " ..
    ORANGE_FONT_COLOR_CODE .. "ALWAYS" .. FONT_COLOR_CODE_CLOSE ..
    " sell list",
["ITEMLIST_REMOVE_FROM_SELL_TO_KEEP_FMT"] = 
    "%s has been moved from the " .. 
    ORANGE_FONT_COLOR_CODE .. "ALWAYS" .. FONT_COLOR_CODE_CLOSE ..
    " sell list to the " ..
    GREEN_FONT_COLOR_CODE .. "NEVER" .. FONT_COLOR_CODE_CLOSE ..
    " sell list",
["ITEMLIST_LOADING"] = "Loading...",
["ITEMLIST_INVALID_ITEM"] = RED_FONT_COLOR_CODE .. "Invalid Item" .. FONT_COLOR_CODE_CLOSE,
["ITEMLIST_INVALID_ITEM_TOOLTIP"] = "Blizzard has removed this item and it is no longer valid. Click to remove it from the list.",
["ITEMLIST_LOADING_TOOLTIP"] = "The item information is currently retrieved from the server",
["ITEMLIST_EMPTY_SELL_LIST"] = "Your always sell list is current empty you can drag and drop items into this list to add them.",
["ITEMLIST_EMPTY_KEEP_LIST"] = "Your never sell list is current empty you can drag and drop items into this list to add them.",
}) -- END OF LOCALIZATION TABLE

-- Help strings for documentation of rules. These are separate due to the multi-line strings, which doesn't play nice with tables.


