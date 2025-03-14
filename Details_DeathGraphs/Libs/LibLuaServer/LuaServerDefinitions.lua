
--uiobject: is an object that represents a UI element, such as a frame, a texture, or a button. UIObjects are the base class for all UI elements in the WoW API.
--3D World: is an object which is placed behind|below all UI elements, cannot be parent of any object, in the 3D World object is where the game world is rendered
--size: corresponds to the height and height of an object, it is measure in pixels, must be bigger than zero.
--scale: the size of an object is multiplied by this value, it is measure in percentage, must be between 0.65 and 2.40.
--alpha: corresponds to the transparency of an object, the bigger is the value less transparent is the object, it is measure in percentage, must be between 0 and 1, zero is fully transparent and one is fully opaque.
--controller: abstract term to define who's in control of an entity, can be the server or a player.
--npc: an entity shown in the 3d world with a name and a health bar, can be friendly or hostile, can be interacted with, always controlled by the server.
--player: is an entity that represents a player character, the controller is always player.
--pet: represents a npc controlled by the server and can accept commands from the player.
--guadians: represents a npc, the server has the possess of the controller, don't accept commands like pets, helps attacking the enemies of the npc or player.
--role: is a string that represents the role of a unit, such as tank, healer, or damage dealer. only players can have a role.

---@alias role
---| "TANK"
---| "HEALER"
---| "DAMAGER"
---| "NONE"

---@alias anchorpoint
---| "topleft"
---| "topright"
---| "bottomleft"
---| "bottomright"
---| "top"
---| "bottom"
---| "left"
---| "right"
---| "center"

---@alias framestrata
---| "background"
---| "low"
---| "medium"
---| "high"
---| "dialog"
---| "fullscreen"
---| "fullscreen_dialog"
---| "tooltip"
---| "BACKGROUND"
---| "LOW"
---| "MEDIUM"
---| "HIGH"
---| "DIALOG"
---| "FULLSCREEN"
---| "FULLSCREEN_DIALOG"
---| "TOOLTIP"

---@alias sizingpoint
---| "top"
---| "topright"
---| "right"
---| "bottomright"
---| "bottom"
---| "bottomleft"
---| "left"
---| "topleft"

---@alias drawlayer
---| "background"
---| "border"
---| "artwork"
---| "overlay"
---| "highlight"

---@alias buttontype
---| "AnyUp"
---| "AnyDown"
---| "LeftButtonDown"
---| "LeftButtonUp"
---| "MiddleButtonUp"
---| "MiddleButtonDown"
---| "RightButtonDown"
---| "RightButtonUp"
---| "Button4Up"
---| "Button4Down"
---| "Button5Up"
---| "Button5Down"

---@alias justifyh
---| "left"
---| "right"
---| "center"

---@alias justifyv
---| "top"
---| "bottom"
---| "middle"

---@alias orientation
---| "HORIZONTAL"
---| "VERTICAL"

---@alias class
---| "WARRIOR"
---| "PALADIN"
---| "HUNTER"
---| "ROGUE"
---| "PRIEST"
---| "DEATHKNIGHT"
---| "SHAMAN"
---| "MAGE"
---| "WARLOCK"
---| "MONK"
---| "DRUID"
---| "DEMONHUNTER"
---| "EVOKER"

---@alias width number property that represents the horizontal size of a UI element, such as a frame or a texture. Gotten from the first result of GetWidth() or from the first result of GetSize(). It is expected a GetWidth() or GetSize() when the type 'height' is used.
---@alias height number property that represents the vertical size of a UI element, such as a frame or a texture. Gotten from the first result of GetHeight() or from the second result of GetSize(). It is expected a GetHeight() or GetSize() when the type 'height' is used.
---@alias red number color value representing the red component of a color, the value must be between 0 and 1. To retrieve a color from a string or table use: local red, green, blue, alpha = DetailsFramework:ParseColors(color)
---@alias green number color value representing the green component of a color, the value must be between 0 and 1. To retrieve a color from a string or table use: local red, green, blue, alpha = DetailsFramework:ParseColors(color)
---@alias blue number color value representing the blue component of a color, the value must be between 0 and 1. To retrieve a color from a string or table use: local red, green, blue, alpha = DetailsFramework:ParseColors(color)
---@alias alpha number @number(0-1.0) value representing the alpha (transparency) of a UIObject, the value must be between 0 and 1. 0 is fully transparent, 1 is fully opaque.
---@alias unit string string that represents a unit in the game, such as the player, a party member, or a raid member.
---@alias health number amount of hit points (health) of a unit. This value can be changed by taking damage or healing.
---@alias encounterid number encounter ID number received by the event ENCOUNTER_START and ENCOUNTER_END
---@alias encounterejid number encounter ID number used by the encounter journal
---@alias encountername string encounter name received by the event ENCOUNTER_START and ENCOUNTER_END also used by the encounter journal
---@alias spellid number each spell in the game has a unique spell id, this id can be used to identify a spell.
---@alias actorname string name of a unit
---@alias petname string refers to a pet's name
---@alias ownername string refers to the pet's owner name
---@alias spellname string name of a spell
---@alias spellschool number each spell in the game has a school, such as fire, frost, shadow and many others. This value can be used to identify the school of a spell.
---@alias actorid string unique id of a unit (GUID)
---@alias serial string unique id of a unit (GUID)
---@alias guid string unique id of a unit (GUID)
---@alias specialization number the ID of a class specialization
---@alias controlflags number flags telling what unit type the is (player, npc, pet, etc); it's relatiotionship to the player (friendly, hostile, etc); who controls the unit (controlled by the player, controlled by the server, etc)
---@alias color table, string @table(r: red|number, g: green|number, b: blue|number, a: alpha|number) @string(color name) @hex (000000-ffffff) value representing a color, the value must be a table with the following fields: r, g, b, a. r, g, b are numbers between 0 and 1, a is a number between 0 and 1. To retrieve a color from a string or table use: local red, green, blue, alpha = DetailsFramework:ParseColors(color)
---@alias scale number @number(0.65-2.40) value representing the scale factor of the UIObject, the value must be between 0.65 and 2.40, the width and height of the UIObject will be multiplied by this value.
---@alias script string, function is a piece of code that is executed in response to a specific event, such as a button click or a frame update. Scripts can be used to implement behavior and logic for UI elements.
---@alias event string is a notification that is sent to a frame when something happens, such as a button click or a frame update. Events can be used to trigger scripts.
---@alias backdrop table @table(bgFile: string, edgeFile: string, tile: edgeSize: number, backgroundColor: color, borderColor: color) is a table that contains information about the backdrop of a frame. The backdrop is the background of a frame, which can be a solid color, a gradient, or a texture.
---@alias npcid number a number that identifies a specific npc in the game.
---@alias textureid number each texture from the game client has an id.
---@alias texturepath string access textures from addons.
---@alias unixtime number
---@alias valueamount number used to represent a value, such as a damage amount, a healing amount, or a resource amount.
---@alias timestring string refers to a string showing a time value, such as "1:23" or "1:23:45".
---@alias combattime number elapsed time of a combat or time in seconds that a unit has been in combat.

---@class _G
---@field RegisterAttributeDriver fun(statedriver: frame, attribute: string, conditional: string)
---@field RegisterStateDriver fun(statedriver: frame, attribute: string, conditional: string)
---@field UnitGUID fun(unit: string): string
---@field UnitName fun(unit: string): string
---@field GetCursorPosition fun(): number, number return the position of the cursor on the screen, in pixels, relative to the bottom left corner of the screen.
---@field C_Timer C_Timer

---@class timer : table
---@field Cancel fun(self: timer)
---@field IsCancelled fun(self: timer): boolean

---@class C_Timer : table
---@field After fun(delay: number, func: function)
---@field NewTimer fun(delay: number, func: function): timer
---@field NewTicker fun(interval: number, func: function, iterations: number|nil): timer

---@class C_ChallengeMode : table
---@field GetActiveKeystoneInfo fun(): number, number[], boolean @returns keystoneLevel, affixIDs, wasActive

---@class tablesize : {H: number, W: number}
---@class tablecoords : {L: number, R: number, T: number, B: number}
---@class texturecoords: {left: number, right: number, top: number, bottom: number}
---@class objectsize : {height: number, width: number}
---@class texturetable : {texture: string, coords: texturecoords, size: objectsize}

---@class uiobject
---@field GetObjectType fun(self: uiobject) : string
---@field Show fun(self: uiobject) make the object be shown on the user screen
---@field Hide fun(self: uiobject) make the object be hidden from the user screen
---@field SetShown fun(self: uiobject, state: boolean) show or hide the object
---@field IsShown fun(self: uiobject) : boolean return if the object is shown or not
---@field SetAllPoints fun(self: uiobject, target: uiobject|nil) set the object to be the same size as its parent or the target object
---@field SetParent fun(self: uiobject, parent: frame) set the parent object of the object
---@field SetSize fun(self: uiobject, width: width|number, height: height|number) set the width and height of the object
---@field SetWidth fun(self: uiobject, width: width|number) set only the width of the object
---@field SetHeight fun(self: uiobject, height: height|number) set only the height of the object
---@field SetAlpha fun(self: uiobject, alpha: alpha|number) set the transparency of the object
---@field SetScale fun(self: uiobject, scale: scale|number)
---@field GetWidth fun(self: uiobject) : width|number
---@field GetHeight fun(self: uiobject) : height|number
---@field GetScale fun(self: uiobject) : scale|number
---@field GetAlpha fun(self: uiobject) : alpha|number
---@field GetSize fun(self: uiobject) : width|number, height|number
---@field GetParent fun(self: uiobject) : frame
---@field GetPoint fun(self: uiobject, index: number): string, frame, string, number, number
---@field GetCenter fun(self: uiobject): number, number
---@field SetPoint fun(self: uiobject, point: anchorpoint, relativeFrame: uiobject, relativePoint: anchorpoint, xOffset: number, yOffset: number)
---@field ClearAllPoints fun(self: uiobject)
---@field CreateAnimationGroup fun(self: uiobject, name: string|nil, templateName: string|nil) : animationgroup

---@class animationgroup : uiobject
---@field CreateAnimation fun(self: animationgroup, animationType: string, name: string|nil, inheritsFrom: string|nil) : animation
---@field GetAnimation fun(self: animationgroup, name: string) : animation
---@field GetAnimations fun(self: animationgroup) : table
---@field GetDuration fun(self: animationgroup) : number
---@field GetEndDelay fun(self: animationgroup) : number
---@field GetLoopState fun(self: animationgroup) : boolean
---@field GetScript fun(self: animationgroup, event: string) : function
---@field GetSmoothProgress fun(self: animationgroup) : boolean
---@field IsDone fun(self: animationgroup) : boolean
---@field IsPaused fun(self: animationgroup) : boolean
---@field IsPlaying fun(self: animationgroup) : boolean
---@field Pause fun(self: animationgroup)
---@field Play fun(self: animationgroup)
---@field Resume fun(self: animationgroup)
---@field SetDuration fun(self: animationgroup, duration: number)
---@field SetEndDelay fun(self: animationgroup, delay: number)
---@field SetLooping fun(self: animationgroup, loop: boolean)
---@field SetScript fun(self: animationgroup, event: string, handler: function|nil) "OnEvent"|"OnShow"
---@field SetSmoothProgress fun(self: animationgroup, smooth: boolean)
---@field Stop fun(self: animationgroup)

---@class animation : uiobject
---@field GetDuration fun(self: animation) : number
---@field GetEndDelay fun(self: animation) : number
---@field GetOrder fun(self: animation) : number
---@field GetScript fun(self: animation, event: string) : function
---@field GetSmoothing fun(self: animation) : string
---@field IsDone fun(self: animation) : boolean
---@field IsPaused fun(self: animation) : boolean
---@field IsPlaying fun(self: animation) : boolean
---@field Pause fun(self: animation)
---@field Play fun(self: animation)
---@field Resume fun(self: animation)
---@field SetDuration fun(self: animation, duration: number)
---@field SetEndDelay fun(self: animation, delay: number)
---@field SetOrder fun(self: animation, order: number)
---@field SetScript fun(self: animation, event: string, handler: function|nil)
---@field SetSmoothing fun(self: animation, smoothing: string)
---@field Stop fun(self: animation)

---@class line : uiobject
---@field GetEndPoint fun(self: line) : relativePoint: anchorpoint, relativeTo: anchorpoint, offsetX: number, offsetY: number
---@field GetStartPoint fun(self: line) : relativePoint: anchorpoint, relativeTo: anchorpoint, offsetX: number, offsetY: number
---@field GetThickness fun(self: line) : number
---@field SetStartPoint fun(self: line, point: anchorpoint, relativeFrame: uiobject|number, relativePoint: anchorpoint|number, xOffset: number|nil, yOffset: number|nil)
---@field SetEndPoint fun(self: line, point: anchorpoint, relativeFrame: uiobject|number, relativePoint: anchorpoint|number, xOffset: number|nil, yOffset: number|nil)
---@field SetColorTexture fun(self: line, red: number, green: number, blue: number, alpha: number)
---@field SetThickness fun(self: line, thickness: number)

---@class frame : uiobject
---@field CreateLine fun(self: frame, name: string|nil, drawLayer: drawlayer, templateName: string|nil, subLevel: number|nil) : line
---@field SetID fun(self: frame, id: number) set an ID for the frame
---@field SetAttribute fun(self: frame, name: string, value: any)
---@field SetScript fun(self: frame, event: string, handler: function|nil)
---@field GetScript fun(self: frame, event: string) : function
---@field SetFrameStrata fun(self: frame, strata: framestrata)
---@field SetFrameLevel fun(self: frame, level: number)
---@field SetClampedToScreen fun(self: frame, clamped: boolean)
---@field SetClampRectInsets fun(self: frame, left: number, right: number, top: number, bottom: number)
---@field SetMovable fun(self: frame, movable: boolean)
---@field SetUserPlaced fun(self: frame, userPlaced: boolean)
---@field SetBackdrop fun(self: frame, backdrop: backdrop|table)
---@field SetBackdropColor fun(self: frame, red: red|number, green: green|number, blue: blue|number, alpha: alpha|number)
---@field SetBackdropBorderColor fun(self: frame, red: red|number, green: green|number, blue: blue|number, alpha: alpha|number)
---@field SetHitRectInsets fun(self: frame, left: number, right: number, top: number, bottom: number)
---@field SetToplevel fun(self: frame, toplevel: boolean)
---@field SetPropagateKeyboardInput fun(self: frame, propagate: boolean)
---@field SetPropagateGamepadInput fun(self: frame, propagate: boolean)
---@field StartMoving fun(self: frame)
---@field IsMovable fun(self: frame) : boolean
---@field StartSizing fun(self: frame, sizingpoint: sizingpoint|nil)
---@field StopMovingOrSizing fun(self: frame)
---@field GetAttribute fun(self: frame, name: string) : any
---@field GetFrameLevel fun(self: frame) : number
---@field GetFrameStrata fun(self: frame) : framestrata
---@field GetNumChildren fun(self: frame) : number
---@field GetNumPoints fun(self: frame) : number
---@field GetNumRegions fun(self: frame) : number
---@field GetName fun(self: frame) : string
---@field GetChildren fun(self: frame) : frame[]
---@field GetRegions fun(self: frame) : region[]
---@field CreateTexture fun(self: frame, name: string|nil, layer: drawlayer, inherits: string|nil, subLayer: number|nil) : texture
---@field CreateFontString fun(self: frame, name: string|nil, layer: drawlayer, inherits: string|nil, subLayer: number|nil) : fontstring
---@field EnableMouse fun(self: frame, enable: boolean) enable mouse interaction
---@field SetResizable fun(self: frame, enable: boolean) enable resizing of the frame
---@field EnableMouseWheel fun(self: frame, enable: boolean) enable mouse wheel scrolling
---@field RegisterForDrag fun(self: frame, button: string) register the frame for drag events, allowing it to be dragged by the mouse
---@field SetResizeBounds fun(self: frame, minWidth: number, minHeight: number, maxWidth: number, maxHeight: number) set the minimum and maximum size of the frame
---@field RegisterEvent fun(self: frame, event: string) register for an event, trigers "OnEvent" script when the event is fired
---@field HookScript fun(self: frame, event: string, handler: function) run a function after the frame's script has been executed, carrying the same arguments

---@class button : frame
---@field Click fun(self: button)
---@field SetNormalTexture fun(self: button, texture: textureid|texturepath)
---@field SetPushedTexture fun(self: button, texture: textureid|texturepath)
---@field SetHighlightTexture fun(self: button, texture: textureid|texturepath)
---@field SetDisabledTexture fun(self: button, texture: textureid|texturepath)
---@field SetCheckedTexture fun(self: button, texture: textureid|texturepath)
---@field SetNormalFontObject fun(self: button, fontString: fontstring)
---@field SetHighlightFontObject fun(self: button, fontString: fontstring)
---@field SetDisabledFontObject fun(self: button, fontString: fontstring)
---@field SetText fun(self: button, text: string)
---@field GetText fun(self: button) : string
---@field SetTextInsets fun(self: button, left: number, right: number, top: number, bottom: number)
---@field GetTextInsets fun(self: button) : number, number, number, number
---@field SetDisabledTextColor fun(self: button, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field GetDisabledTextColor fun(self: button) : number, number, number, number
---@field SetFontString fun(self: button, fontString: fontstring)
---@field GetFontString fun(self: button) : fontstring
---@field SetButtonState fun(self: button, state: string, enable: boolean)
---@field GetButtonState fun(self: button, state: string) : boolean
---@field RegisterForClicks fun(self: button, button1: nil|buttontype, button2: nil|buttontype, button3: nil|buttontype, button4: nil|buttontype)
---@field GetNormalTexture fun(self: button) : texture
---@field GetPushedTexture fun(self: button) : texture
---@field GetHighlightTexture fun(self: button) : texture
---@field GetDisabledTexture fun(self: button) : texture

---@class statusbar : frame
---@field SetStatusBarColor fun(self: statusbar, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field SetStatusBarTexture fun(self: statusbar, path: string|texture)
---@field GetStatusBarTexture fun(self: statusbar) : texture
---@field SetMinMaxValues fun(self: statusbar, minValue: number, maxValue: number)
---@field SetValue fun(self: statusbar, value: number)
---@field SetValueStep fun(self: statusbar, valueStep: number)
---@field SetOrientation fun(self: statusbar, orientation: orientation)
---@field SetReverseFill fun(self: statusbar, reverseFill: boolean)
---@field GetMinMaxValues fun(self: statusbar) : number, number
---@field GetValue fun(self: statusbar) : number
---@field GetValueStep fun(self: statusbar) : number
---@field GetOrientation fun(self: statusbar) : orientation
---@field GetReverseFill fun(self: statusbar) : boolean

---@class scrollframe : frame
---@field SetScrollChild fun(self: scrollframe, child: frame)
---@field GetScrollChild fun(self: scrollframe) : frame
---@field SetHorizontalScroll fun(self: scrollframe, offset: number)
---@field SetVerticalScroll fun(self: scrollframe, offset: number)
---@field GetHorizontalScroll fun(self: scrollframe) : number
---@field GetVerticalScroll fun(self: scrollframe) : number
---@field GetHorizontalScrollRange fun(self: scrollframe) : number
---@field GetVerticalScrollRange fun(self: scrollframe) : number

---@class region : uiobject

---@class fontstring : region
---@field SetDrawLayer fun(self: fontstring, layer: drawlayer, subLayer: number|nil)
---@field SetFont fun(self: fontstring, font: string, size: number, flags: string)
---@field SetText fun(self: fontstring, text: string|number)
---@field GetText fun(self: fontstring) : string
---@field GetFont fun(self: fontstring) : string, number, string
---@field GetStringWidth fun(self: fontstring) : number return the width of the string in pixels
---@field SetShadowColor fun(self: fontstring, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field GetShadowColor fun(self: fontstring) : number, number, number, number
---@field SetShadowOffset fun(self: fontstring, offsetX: number, offsetY: number)
---@field GetShadowOffset fun(self: fontstring) : number, number
---@field SetTextColor fun(self: fontstring, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field GetTextColor fun(self: fontstring) : number, number, number, number
---@field SetJustifyH fun(self: fontstring, justifyH: justifyh)
---@field GetJustifyH fun(self: fontstring) : string
---@field SetJustifyV fun(self: fontstring, justifyV: justifyv)
---@field GetJustifyV fun(self: fontstring) : string
---@field SetNonSpaceWrap fun(self: fontstring, nonSpaceWrap: boolean)
---@field GetNonSpaceWrap fun(self: fontstring) : boolean
---@field SetIndentedWordWrap fun(self: fontstring, indentedWordWrap: boolean)
---@field GetIndentedWordWrap fun(self: fontstring) : boolean
---@field SetMaxLines fun(self: fontstring, maxLines: number)
---@field GetMaxLines fun(self: fontstring) : number
---@field SetWordWrap fun(self: fontstring, wordWrap: boolean)
---@field GetWordWrap fun(self: fontstring) : boolean
---@field SetSpacing fun(self: fontstring, spacing: number)
---@field GetSpacing fun(self: fontstring) : number
---@field SetLineSpacing fun(self: fontstring, lineSpacing: number)
---@field GetLineSpacing fun(self: fontstring) : number
---@field SetMaxLetters fun(self: fontstring, maxLetters: number)
---@field GetMaxLetters fun(self: fontstring) : number
---@field SetTextInsets fun(self: fontstring, left: number, right: number, top: number, bottom: number)
---@field GetTextInsets fun(self: fontstring) : number, number, number, number
---@field SetTextJustification fun(self: fontstring, justifyH: string, justifyV: string)
---@field GetTextJustification fun(self: fontstring) : string, string
---@field SetTextShadowColor fun(self: fontstring, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field GetTextShadowColor fun(self: fontstring) : number, number, number, number
---@field SetTextShadowOffset fun(self: fontstring, offsetX: number, offsetY: number)
---@field GetTextShadowOffset fun(self: fontstring) : number, number
---@field SetTextShadow fun(self: fontstring, offsetX: number, offsetY: number, r: red|number, g: green|number, b: blue|number, a: alpha|number)
---@field SetTextTruncate fun(self: fontstring, truncate: string)
---@field GetTextTruncate fun(self: fontstring) : string
---@field SetTextTruncateWidth fun(self: fontstring, width: number)
---@field GetTextTruncateWidth fun(self: fontstring) : number
---@field SetTextTruncateLines fun(self: fontstring, lines: number)
---@field GetTextTruncateLines fun(self: fontstring) : number

---@class texture : region
---@field SetDrawLayer fun(self: texture, layer: drawlayer, subLayer: number|nil)
---@field SetTexture fun(self: texture, path: string)
---@field SetAtlas fun(self: texture, atlas: string)
---@field SetColorTexture fun(self: texture, r: red|number, g: green|number, b: blue|number, a: alpha|number|nil)
---@field SetDesaturated fun(self: texture, desaturate: boolean)
---@field SetBlendMode fun(self: texture, mode: "ADD"|"BLEND"|"DISABLE"|"MOD"|"MOD2X"|"OVERLAY"|"REPLACE"|"SUBTRACT")
---@field SetVertexColor fun(self: texture, r: red|number, g: green|number, b: blue|number, a: alpha|number|nil)
---@field GetPoint fun(self: texture, index: number) : string, table, string, number, number
---@field SetShown fun(self: texture, state: boolean)
---@field IsShown fun(self: texture) : boolean
---@field GetParent fun(self: texture) : table
---@field SetTexCoord fun(self: texture, left: number, right: number, top: number, bottom: number)
---@field GetTexCoord fun(self: texture) : number, number, number, number
---@field SetRotation fun(self: texture, rotation: number)
---@field GetRotation fun(self: texture) : number
---@field SetRotationRadians fun(self: texture, rotation: number)
---@field GetRotationRadians fun(self: texture) : number
---@field SetRotationDegrees fun(self: texture, rotation: number)
---@field GetRotationDegrees fun(self: texture) : number
---@field SetMask fun(self: texture, mask: table)
---@field GetMask fun(self: texture) : table
---@field SetMaskTexture fun(self: texture, maskTexture: table)
---@field GetMaskTexture fun(self: texture) : table
---@field GetDesaturated fun(self: texture) : boolean
---@field SetGradient fun(self: texture, gradient: string)
---@field GetGradient fun(self: texture) : string
---@field SetGradientAlpha fun(self: texture, gradient: string)
---@field GetGradientAlpha fun(self: texture) : string
---@field SetGradientRotation fun(self: texture, rotation: number)
---@field GetGradientRotation fun(self: texture) : number
---@field SetGradientRotationRadians fun(self: texture, rotation: number)
---@field GetGradientRotationRadians fun(self: texture) : number
---@field SetGradientRotationDegrees fun(self: texture, rotation: number)
---@field GetGradientRotationDegrees fun(self: texture) : number
---@field SetGradientColors fun(self: texture, ...)
---@field GetGradientColors fun(self: texture) : number, number, number, number, number, number, number, number, number, number, number, number
---@field GetBlendMode fun(self: texture) : string
---@field GetVertexColor fun(self: texture) : number, number, number, number

