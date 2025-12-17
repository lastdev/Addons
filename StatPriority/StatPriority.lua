local StatPriority = LibStub("AceAddon-3.0"):NewAddon("StatPriority")

if statPriorityStoredStats == nil then
	statPriorityStoredStats = {}
end

StatPriority.Stats = {}

StatPriority.Stats["WARRIORArms"] = "Strength > Critical Strike > Haste > Mastery > Versatility"
StatPriority.Stats["WARRIORFury"] = "Strength > Mastery > Haste > Versatility > Critical Strike"
StatPriority.Stats["WARRIORProtection"] = "Strength > Haste > Critical Strike = Versatility > Mastery"

StatPriority.Stats["PALADINHoly"] = "Intellect > Haste > Mastery > Critical Strike > Versatility"
StatPriority.Stats["PALADINProtection"] = "Strength > Haste > Mastery > Versatility = Critical Strike"
StatPriority.Stats["PALADINRetribution"] = "Strength > Mastery = Critical Strike > Haste > Versatility"

StatPriority.Stats["HUNTERBeast Mastery"] = "Agility > Haste to 30% > Critical Strike > Versatility > Mastery"
StatPriority.Stats["HUNTERMarksmanship"] = "Agility > Critical Strike to 54% > Mastery > Versatility > Haste"
StatPriority.Stats["HUNTERSurvival"] = "Agility > Mastery > Haste > Critical Strike > Versatility"

StatPriority.Stats["ROGUEAssassination"] = "Agility > Critical Strike > Mastery > Haste > Versatility"
StatPriority.Stats["ROGUEOutlaw"] = "Agility > Versatility > Haste > Critical Strike > Mastery"
StatPriority.Stats["ROGUESubtlety"] = "Agility > Mastery > Versatility > Critical Strike > Haste"

StatPriority.Stats["PRIESTDiscipline"] = "Intellect > Haste to 20%-25% > Critical Strike = Mastery > Versatility"
StatPriority.Stats["PRIESTHoly"] = "Intellect > Critical Strike = Mastery > Versatility > Haste"
StatPriority.Stats["PRIESTShadow"] = "Intellect > Haste > Mastery > Critical Strike > Versatility"

StatPriority.Stats["SHAMANElemental"] = "Intellect > Mastery > Haste > Versatility > Critical Strike"
StatPriority.Stats["SHAMANEnhancement"] = "Mastery > Haste > Critical Strike > Versatility > Agility"
StatPriority.Stats["SHAMANRestoration"] = "Intellect > Haste = Critical Strike > Versatility > Mastery"

StatPriority.Stats["MAGEArcane"] = "Intellect > Haste > Versatility > Mastery > Critical Strike"
StatPriority.Stats["MAGEFire"] = "Intellect > Haste > Mastery > Versatility > Critical Strike"
StatPriority.Stats["MAGEFrost"] = "Intellect > Haste > Critical Strike to 33.34% > Mastery > Versatility"

StatPriority.Stats["WARLOCKAffliction"] = "Intellect > Mastery = Critical Strike > Haste > Versatility"
StatPriority.Stats["WARLOCKDemonology"] = "Intellect > Haste = Critical Strike > Mastery > Versatility"
StatPriority.Stats["WARLOCKDestruction"] = "Haste = Critical Strike > Intellect > Mastery > Versatility"

StatPriority.Stats["DRUIDBalance"] = "Intellect > Mastery > Haste > Versatility > Critical Strike"
StatPriority.Stats["DRUIDFeral"] = "Mastery = Critical Strike > Haste > Versatility > Agility"
StatPriority.Stats["DRUIDGuardian"] = "Armor = Agility = Stamina > Haste > Versatility > Mastery > Critical Strike"
StatPriority.Stats["DRUIDRestoration"] = "Intellect > Haste = Mastery > Versatility > Critical Strike"

StatPriority.Stats["MONKBrewmaster"] = "Agility = Armor > Versatility = Mastery = Critical Strike > Haste"
StatPriority.Stats["MONKMistweaver"] = "Intellect > Haste > Critical Strike > Versatility > Mastery"
StatPriority.Stats["MONKWindwalker"] = "Agility > Mastery = Haste > Versatility = Critical Strike"

StatPriority.Stats["DEATHKNIGHTBlood"] = "Strength > Haste > Critical Strike = Versatility = Mastery"
StatPriority.Stats["DEATHKNIGHTFrost"] = "Strength > Mastery > Critical Strike > Haste > Versatility"
StatPriority.Stats["DEATHKNIGHTUnholy"] = "Strength > Haste > Mastery > Critical Strike > Versatility"

StatPriority.Stats["DEMONHUNTERHavoc"] = "Critical Strike = Mastery > Haste > Versatility > Agility"
StatPriority.Stats["DEMONHUNTERVengeance"] = "Agility > Haste = Critical Strike > Versatility > Mastery"

StatPriority.Stats["EVOKERAugmentation"] = "Intellect > Critical Strike > Haste > Mastery > Versatility"
StatPriority.Stats["EVOKERDevastation"] = "Intellect > Haste > Critial Strike > Mastery > Versatility"
StatPriority.Stats["EVOKERPreservation"] = "Intellect > Mastery > Critial Strike > Haste > Versatility"

function StatPriority:FrameOnEvent(event, arg1)
	if event == "SPELLS_CHANGED" then
		StatPriority:FrameUpdate(statPriorityText, PaperDollFrame, "player")
	end
end

function StatPriority:FrameCreate(frame, text, parent)
	if parent.IsVisible ~= nil and parent:IsVisible() then
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
						   edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
						   tile = true,
						   tileSize = 16,
						   edgeSize = 16, 
						   insets = {left = 1,
									 right = 1,
									 top = 1,
									 bottom = 1}}) 
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:SetFrameStrata("TOOLTIP")
		frame:SetWidth(parent:GetWidth())
		if parent == PaperDollFrame then
			frame:SetHeight(25)
		else
			frame:SetHeight(50)
		end
		text:ClearAllPoints()
		text:SetAllPoints(frame) 
		text:SetJustifyH("CENTER")
		text:SetJustifyV("MIDDLE")
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT",0,0)
		frame:SetPoint("BOTTOMLEFT", parent, "TOPLEFT",0,0)
		frame:SetParent(parent)
		frame:Show()
		return true
	end
	return false
end

function StatPriority:GetSpecializationName(id)
	local spec = ""
	if id == 62 then 
		spec = "Arcane"
	elseif id == 63 then 
		spec = "Fire"
	elseif id == 64 then 
		spec = "Frost"
	elseif id == 65 then 
		spec = "Holy"
	elseif id == 66 then 
		spec = "Protection"
	elseif id == 70 then 
		spec = "Retribution"
	elseif id == 71 then 
		spec = "Arms"
	elseif id == 72 then 
		spec = "Fury"
	elseif id == 73 then 
		spec = "Protection"
	elseif id == 102 then 
		spec = "Balance"
	elseif id == 103 then 
		spec = "Feral"
	elseif id == 104 then 
		spec = "Guardian"
	elseif id == 105 then 
		spec = "Restoration"
	elseif id == 250 then 
		spec = "Blood"
	elseif id == 251 then 
		spec = "Frost"
	elseif id == 252 then 
		spec = "Unholy"
	elseif id == 253 then 
		spec = "Beast Mastery"
	elseif id == 254 then 
		spec = "Marksmanship"
	elseif id == 255 then 
		spec = "Survival"
	elseif id == 256 then 
		spec = "Discipline"
	elseif id == 257 then 
		spec = "Holy"
	elseif id == 258 then 
		spec = "Shadow"
	elseif id == 259 then 
		spec = "Assassination"
	elseif id == 260 then 
		spec = "Outlaw"
	elseif id == 261 then 
		spec = "Subtlety"
	elseif id == 262 then 
		spec = "Elemental"
	elseif id == 263 then 
		spec = "Enhancement"
	elseif id == 264 then 
		spec = "Restoration"
	elseif id == 265 then 
		spec = "Affliction"
	elseif id == 266 then 
		spec = "Demonology"
	elseif id == 267 then 
		spec = "Destruction"
	elseif id == 268 then 
		spec = "Brewmaster"
	elseif id == 269 then 
		spec = "Windwalker"
	elseif id == 270 then 
		spec = "Mistweaver"
	elseif id == 577 then 
		spec = "Havoc"
	elseif id == 581 then 
		spec = "Vengeance"
	elseif id == 1467 then 
		spec = "Devastation"
	elseif id == 1468 then 
		spec = "Preservation"
	elseif id == 1473 then
		spec = "Augmentation"
	end
	return spec
end

function StatPriority:FrameUpdate(frame, frameText, parent, unit)
	if parent ~= nil and self:FrameCreate(frame, frameText, parent) then
		local temp, class = UnitClass(unit)
		local spec
		local text
		if parent == PaperDollFrame then
			spec = GetSpecializationInfo(GetSpecialization())
			spec = StatPriority:GetSpecializationName(spec)
			text = StatPriority.Stats[class .. spec];
			if statPriorityStoredStats[class..spec] == nil then
				text = StatPriority.Stats[class..spec]
			else
				text = statPriorityStoredStats[class..spec]
			end
		else
			spec = StatPriority:GetSpecializationName(GetInspectSpecialization(unit))
			text = StatPriority.Stats[class .. spec];
			if StatPriority.Stats[class..spec] ~= nil and class == UnitClass("player") then
				text = StatPriority.Stats[class..spec]
			end
		end
		frameText:SetText(text)
	end
end

function StatPriority:SetPriority(info, val)
	local _, name = UnitClass("player")
	statPriorityStoredStats[name .. info.option.name] = val
end

function StatPriority:GetPriority(info)
	local _, name = UnitClass("player")
	return statPriorityStoredStats[name .. info.option.name]
end

function StatPriority:OnInitialize()
	self.Frame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	self.Text = self.Frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
	self.Frame:RegisterEvent("SPELLS_CHANGED")
	self.Frame:SetScript("OnEvent", self.FrameOnEvent)
	PaperDollFrame:HookScript("OnShow", function() self:FrameUpdate(self.Frame, self.Text, PaperDollFrame, "player") end)
	local options;
	local _, class = UnitClass("player")
	if class == "WARRIOR" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Arms",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Fury",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Protection",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "PALADIN" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Holy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Protection",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Retribution",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "HUNTER" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Beast Mastery",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Marksmanship",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Survival",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "ROGUE" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Assassination",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Outlaw",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Subtlety",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "PRIEST" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Discipline",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Holy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Shadow",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "SHAMAN" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Elemental",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Enhancement",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Restoration",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "MAGE" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Arcane",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Fire",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Frost",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "WARLOCK" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Affliction",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Demonology",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Destruction",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DRUID" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Balance",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Feral",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Guardian",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec4 = {
							name = "Restoration",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "MONK" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Brewmaster",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Mistweaver",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Windwalker",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DEATHKNIGHT" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Blood",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Frost",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Unholy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DEMONHUNTER" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Havoc",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Vengeance",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "EVOKER" then
		options = {
			name = "Stat Priority",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "Custom priority strings",
					type = "group",
					desc = "You can put your own custom priority strings here",
					args = {
						spec1 = {
							name = "Devastation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Preservation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Augmentation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	end
	LibStub("AceConfig-3.0"):RegisterOptionsTable("StatPriority", options, nil)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("StatPriority", "Stat Priority")
end