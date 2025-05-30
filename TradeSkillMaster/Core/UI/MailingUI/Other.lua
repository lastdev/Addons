-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Groups = TSM.UI.MailingUI:NewPackage("Other") ---@type AddonPackage
local L = TSM.Locale.GetTable()
local FSM = TSM.LibTSMUtil:Include("FSM")
local Event = TSM.LibTSMWoW:Include("Service.Event")
local Money = TSM.LibTSMUtil:Include("UI.Money")
local String = TSM.LibTSMUtil:Include("Lua.String")
local ItemInfo = TSM.LibTSMService:Include("Item.ItemInfo")
local BagTracking = TSM.LibTSMService:Include("Inventory.BagTracking")
local PlayerInfo = TSM.LibTSMApp:Include("Service.PlayerInfo")
local UIElements = TSM.LibTSMUI:Include("Util.UIElements")
local UIUtils = TSM.LibTSMUI:Include("Util.UIUtils")
local private = {
	settings = nil,
	frame = nil,
	fsm = nil,
}

local PLAYER_NAME = UnitName("player")
local PLAYER_NAME_REALM = gsub(PLAYER_NAME.."-"..GetRealmName(), "%s+", "")



-- ============================================================================
-- Module Functions
-- ============================================================================

function Groups.OnInitialize(settingsDB)
	private.settings = settingsDB:NewView()
		:AddKey("factionrealm", "internalData", "mailDisenchantablesChar")
		:AddKey("factionrealm", "internalData", "mailExcessGoldChar")
		:AddKey("factionrealm", "internalData", "mailExcessGoldLimit")
		:AddKey("global", "mailingOptions", "deMaxQuality")
	private.FSMCreate()
	TSM.UI.MailingUI.RegisterTopLevelPage(OTHER, private.GetOtherFrame)
end



-- ============================================================================
-- Other UI
-- ============================================================================

function private.GetOtherFrame()
	UIUtils.AnalyticsRecordPathChange("mailing", "other")
	local frame = UIElements.New("Frame", "other")
		:SetLayout("VERTICAL")
		:SetPadding(10)
		:SetBackgroundColor("PRIMARY_BG")
		:AddChild(UIElements.New("Text", "enchant")
			:SetHeight(24)
			:SetFont("BODY_BODY1_BOLD")
			:SetText(L["Mail Disenchantables"])
		)
		:AddChild(UIElements.New("Text", "enchantDesc")
			:SetHeight(20)
			:SetMargin(0, 0, 4, 0)
			:SetFont("BODY_BODY2")
			:SetText(L["Quickly mail all excess disenchantable items to a character"])
		)
		:AddChild(UIElements.New("Text", "enchantRecipient")
			:SetHeight(15)
			:SetMargin(0, 0, 12, 0)
			:SetFont("BODY_BODY2")
			:SetText(L["Recipient"])
		)
		:AddChild(UIElements.New("Frame", "enchantHeader")
			:SetLayout("HORIZONTAL")
			:SetHeight(24)
			:SetMargin(0, 0, 8, 0)
			:AddChild(UIElements.New("Input", "recipient")
				:SetMargin(0, 8, 0, 0)
				:SetAutoComplete(PlayerInfo.GetConnectedAlts())
				:SetClearButtonEnabled(true)
				:SetValue(private.settings.mailDisenchantablesChar)
				:SetScript("OnValueChanged", private.EchantRecipientOnValueChanged)
			)
			:AddChild(UIElements.New("ActionButton", "send")
				:SetSize(186, 24)
				:SetDisabled(true)
				:SetText(L["Send Disenchantables"])
				:SetScript("OnClick", private.EnchantSendBtnOnClick)
			)
		)
		:AddChild(UIElements.New("Text", "gold")
			:SetHeight(24)
			:SetMargin(0, 0, 24, 0)
			:SetFont("BODY_BODY1_BOLD")
			:SetText(L["Send Excess Gold to Banker"])
		)
		:AddChild(UIElements.New("Text", "goldDesc")
			:SetHeight(18)
			:SetMargin(0, 0, 4, 0)
			:SetFont("BODY_BODY2")
			:SetText(L["Quickly mail all excess gold (limited to a certain amount) to a character"])
		)
		:AddChild(UIElements.New("Frame", "goldTextHeader")
			:SetLayout("HORIZONTAL")
			:SetHeight(13)
			:SetMargin(0, 0, 12, 0)
			:AddChild(UIElements.New("Text", "recipient")
				:SetMargin(0, 8, 0, 0)
				:SetFont("BODY_BODY2")
				:SetText(L["Recipient"])
			)
			:AddChild(UIElements.New("Text", "limit")
				:SetWidth(128)
				:SetMargin(0, 8, 0, 0)
				:SetFont("BODY_BODY2")
				:SetText(L["Limit"])
			)
			:AddChild(UIElements.New("Spacer", "spacer")
				:SetWidth(106)
			)
		)
		:AddChild(UIElements.New("Frame", "goldHeader")
			:SetLayout("HORIZONTAL")
			:SetHeight(24)
			:SetMargin(0, 0, 4, 0)
			:AddChild(UIElements.New("Input", "recipient")
				:SetMargin(0, 8, 0, 0)
				:SetAutoComplete(PlayerInfo.GetConnectedAlts())
				:SetClearButtonEnabled(true)
				:SetValue(private.settings.mailExcessGoldChar)
				:SetScript("OnValueChanged", private.GoldRecipientOnValueChanged)
			)
			:AddChild(UIElements.New("Input", "limit")
				:SetSize(128, 24)
				:SetMargin(0, 8, 0, 0)
				:SetBackgroundColor("PRIMARY_BG_ALT")
				:SetJustifyH("RIGHT")
				:SetValidateFunc(private.LimitValidateFunc)
				:SetValue(Money.ToStringForUIShort(private.settings.mailExcessGoldLimit))
				:SetScript("OnValueChanged", private.LimitOnValueChanged)
			)
			:AddChild(UIElements.New("ActionButton", "send")
				:SetSize(106, 24)
				:SetDisabled(true)
				:SetText(L["Send Gold"])
				:SetScript("OnClick", private.GoldSendBtnOnClick)
			)
		)
		:AddChild(UIElements.New("Spacer", "spacer")
	)
	:SetScript("OnUpdate", private.FrameOnUpdate)
	:SetScript("OnHide", private.FrameOnHide)

	private.frame = frame

	return frame
end



-- ============================================================================
-- Local Script Handlers
-- ============================================================================

function private.FrameOnUpdate(frame)
	frame:SetScript("OnUpdate", nil)

	private.UpdateEnchantButton()
	private.UpdateGoldButton()

	private.fsm:ProcessEvent("EV_FRAME_SHOW", frame)
end

function private.FrameOnHide(frame)
	private.fsm:ProcessEvent("EV_FRAME_HIDE")
end

function private.EchantRecipientOnValueChanged(input)
	local value = input:GetValue()
	if value == private.settings.mailDisenchantablesChar then
		return
	end
	private.settings.mailDisenchantablesChar = value
	private.UpdateEnchantButton()
end

function private.EnchantSendBtnOnClick(button)
	local items = {}
	local query = BagTracking.CreateQueryBags()
		:OrderBy("slotId", true)
		:Select("itemString", "quantity")
		:Equal("isBound", false)
	for _, itemString, quantity in query:Iterator() do
		if ItemInfo.IsDisenchantable(itemString) then
			local quality = ItemInfo.GetQuality(itemString)
			if quality <= private.settings.deMaxQuality then
				items[itemString] = (items[itemString] or 0) + quantity
			end
		end
	end
	query:Release()
	private.fsm:ProcessEvent("EV_BUTTON_CLICKED", private.settings.mailDisenchantablesChar, 0, items)
end

function private.GoldRecipientOnValueChanged(input)
	local value = input:GetValue()
	if value == private.settings.mailExcessGoldChar then
		return
	end
	private.settings.mailExcessGoldChar = value
	private.UpdateGoldButton()
end

function private.GoldSendBtnOnClick(button)
	local money = private.GetSendMoney()
	private.fsm:ProcessEvent("EV_BUTTON_CLICKED", private.settings.mailExcessGoldChar, money)
end

function private.ConvertLimitValue(value)
	value = gsub(value, String.Escape(LARGE_NUMBER_SEPERATOR), "")
	value = tonumber(value) or Money.FromString(value)
	if not value then
		return nil
	end
	return value > 0 and value <= MAXIMUM_BID_PRICE and value or nil
end

function private.LimitValidateFunc(_, value)
	return private.ConvertLimitValue(value) and true or false
end

function private.LimitOnValueChanged(input)
	local value = private.ConvertLimitValue(input:GetValue())
	assert(value)
	if value == private.settings.mailExcessGoldLimit then
		return
	end
	private.settings.mailExcessGoldLimit = value
	private.UpdateGoldButton()
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.GetSendMoney()
	local money = GetMoney() - 30 - private.settings.mailExcessGoldLimit
	if money < 0 then
		money = 0
	end

	return money
end

function private.UpdateEnchantButton()
	local recipient = private.settings.mailDisenchantablesChar
	local enchantButton = private.frame:GetElement("enchantHeader.send")

	if recipient == "" or recipient == PLAYER_NAME or recipient == PLAYER_NAME_REALM then
		enchantButton:SetDisabled(true)
			:Draw()
		return
	else
		enchantButton:SetDisabled(false)
			:Draw()
	end
end

function private.UpdateGoldButton()
	local recipient = private.settings.mailExcessGoldChar
	local goldButton = private.frame:GetElement("goldHeader.send")

	if recipient == "" or recipient == PLAYER_NAME or recipient == PLAYER_NAME_REALM then
		goldButton:SetDisabled(true)
			:Draw()
		return
	end

	if private.GetSendMoney() > 0 then
		goldButton:SetDisabled(false)
	else
		goldButton:SetDisabled(true)
	end

	goldButton:Draw()
end



-- ============================================================================
-- FSM
-- ============================================================================

function private.FSMCreate()
	Event.Register("PLAYER_MONEY", function()
		private.fsm:SetLoggingEnabled(false)
		private.fsm:ProcessEvent("EV_PLAYER_MONEY_UPDATE")
		private.fsm:SetLoggingEnabled(true)
	end)

	local fsmContext = {
		frame = nil,
		sending = false
	}

	local function UpdateEnchant(context)
		context.frame:GetElement("enchantHeader.send"):SetText(context.sending and L["Sending..."] or L["Send Disenchantables"])
			:SetPressed(context.sending)
			:Draw()
	end

	local function UpdateGold(context)
		private.UpdateGoldButton()

		context.frame:GetElement("goldHeader.send"):SetText(context.sending and L["Sending..."] or L["Send Gold"])
			:SetPressed(context.sending)
			:Draw()
	end

	private.fsm = FSM.New("MAILING_GROUPS")
		:AddState(FSM.NewState("ST_HIDDEN")
			:SetOnEnter(function(context)
				context.frame = nil
			end)
			:AddTransition("ST_SHOWN")
			:AddTransition("ST_HIDDEN")
			:AddEventTransition("EV_FRAME_SHOW", "ST_SHOWN")
		)
		:AddState(FSM.NewState("ST_SHOWN")
			:SetOnEnter(function(context, frame)
				if not context.frame then
					context.frame = frame
				end
			end)
			:AddTransition("ST_HIDDEN")
			:AddTransition("ST_SENDING_START")
			:AddEvent("EV_PLAYER_MONEY_UPDATE", function(context)
				UpdateGold(context)
			end)
			:AddEventTransition("EV_BUTTON_CLICKED", "ST_SENDING_START")
		)
		:AddState(FSM.NewState("ST_SENDING_START")
			:SetOnEnter(function(context, recipient, money, items)
				context.sending = true
				if money > 0 then
					TSM.Mailing.Send.StartSending(private.FSMOthersCallback, recipient, "TSM Mailing: Excess Gold", "", money)
					UpdateGold(context)
				elseif items then
					TSM.Mailing.Send.StartSending(private.FSMOthersCallback, recipient, "TSM Mailing: Disenchantables", "", money, items)
					UpdateEnchant(context)
				end
			end)
			:SetOnExit(function(context)
				context.sending = false
				UpdateEnchant(context)
				UpdateGold(context)
			end)
			:AddTransition("ST_SHOWN")
			:AddTransition("ST_HIDDEN")
			:AddEventTransition("EV_SENDING_DONE", "ST_SHOWN")
		)
		:AddDefaultEventTransition("EV_FRAME_HIDE", "ST_HIDDEN")
		:Init("ST_HIDDEN", fsmContext)
end

function private.FSMOthersCallback()
	private.fsm:ProcessEvent("EV_SENDING_DONE")
end
