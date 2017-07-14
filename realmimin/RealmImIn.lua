---
--- Addon: Realm_Im_In
--- 'OMG! I don't want to logout, but what realm is this character in?'
---

local MY_ADDON_ID = "RealmImIn";
local MY_ADDON_CAT = "Information";
local MY_ADDON_ICON = "Interface\\Addons\\RealmImIn\\Media\\R"
local ICON_HORDE = "Interface\\WorldStateFrame\\HordeIcon"
local ICON_ALLY = "Interface\\WorldStateFrame\\AllianceIcon"

local RealmImIn = LibStub("AceAddon-3.0"):NewAddon(MY_ADDON_ID, "AceConsole-3.0", "AceEvent-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale(MY_ADDON_ID, false)
local QT = LibStub("LibQTip-1.0");
--local icon = LibStub("LibDBIcon-1.0")

--local RealmImInLDB

--  Get data from the TOC file.
RealmImIn.version = tostring(GetAddOnMetadata(MY_ADDON_ID, "Version")) or "Unknown" 
RealmImIn.author = GetAddOnMetadata(MY_ADDON_ID, "Author") or "Unknown"
RealmImIn.id = MY_ADDON_ID
RealmImIn.realm = GetRealmName()

function RealmImIn:OnEnable()
	RealmImIn:Print("v"..RealmImIn.version.." loaded" );
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function RealmImIn:PLAYER_ENTERING_WORLD()
	-- print("RealmImIn: PLAYER_ENTERING_WORLD");
	RealmImIn.realm = GetRealmName();
end


-- Oninitialize: Called when the addon is loaded
function RealmImIn:OnInitialize()
	
	RealmImIn.realm = GetRealmName()
	RealmImIn.faction, RealmImIn.LocFaction = UnitFactionGroup("player")
	
	if "Horde" == RealmImIn.faction then
		RealmImIn.icon = ICON_HORDE
	else 
		RealmImIn.icon = ICON_ALLY	
    end
	
	if  RealmImIn.icon == null then
		RealmImIn.icon = MY_ADDON_ICON
	end
		
	RealmImInLDB = LibStub("LibDataBroker-1.1"):NewDataObject(MY_ADDON_ID, {
		type = "data source",		
		text = "|cff1fb3ff" .. RealmImIn.realm .. "|r ",
		label = MY_ADDON_ID,
		value = RealmImIn.realm ,
		icon = RealmImIn.icon,
		version = RealmImIn.version,
		align = "left",
		isChildButton = "false",
		showPluginText = "true",
		["X-Category"] = MY_ADDON_CAT,
		OnClick = function(self, button,ischild) RealmImIn:OnClick(self, button,ischild) end,
		})
		
	function RealmImInLDB:OnEnter()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
		GameTooltip:ClearLines()
		RealmImInLDB.OnTooltipShow(GameTooltip)
		GameTooltip:Show()
	end
	function RealmImInLDB:OnTooltipShow()
		self:AddLine( L["LDB_TEXT1"] ,  1,1,0.5, 1)
		self:AddLine( "|cff1fb3ff" .. RealmImIn.realm .. "|r ",  1,1,0.5, 1)
	end
	function RealmImInLDB:OnLeave()
		GameTooltip:Hide()
	end
		
	--RealmImIn:DrawTooltip();
	--RealmImInLDB.label = MY_ADDON_ID .. ": " .. RealmImIn.realm
	--RealmImInLDB.text = "|cff1fb3ff" .. RealmImIn.realm .. "|r "
	--RealmImInLDB.value = RealmImIn.realm
	
	RealmImIn:RegisterChatCommand("realmimin", "SlashFunc")	
		
end

-----------------
-- CoOmmand Line --
-----------------

function RealmImIn:SlashFunc(input)
	-- Process the slash command ('input' contains whatever follows the slash command)	
	print( "|cff44ffaa" .. L["ADDON_NAME"] .. ": |r " ..
		L["cmd_text2"] .. "'|cff1fb3ff" .. RealmImIn.realm .. "|r'.")
end

-----------------
-- Data Broker --
-----------------

function RealmImIn:OnClick(aClickedFrame, aButton, ischild)
	--self:Print("v"..RealmImIn.version.." OnClick called");
	RealmImIn.realm = GetRealmName()
	RealmImInLDB.text = RealmImIn.realm
	if (aButton == "RightButton") then
		--ToggleDropDownMenu(1, nil, VuhDoMinimapDropDown, aClickedFrame:GetName(), 0, -5);
		RealmImIn:OnRightClick(aClickedFrame, aButton, ischild);
	else
		RealmImIn:OnLeftClick(aClickedFrame, aButton, ischild);
	end
end

function RealmImIn:OnLeftClick(aClickedFrame, aButton, ischild)
	RealmImIn:Print("v"..RealmImIn.version..": realm = ".. RealmImIn.realm );
end

function RealmImIn:OnRightClick(aClickedFrame, aButton, ischild)
	RealmImIn:Print("v"..RealmImIn.version..": realm = ".. RealmImIn.GetRealmName() .. " (NumAddons=" .. GetNumAddOns() .. ")" );
end

-----------------
-- Titan       --
-----------------

function RealmImIn.Button_OnLoad(self)
	--RealmImIn:Print("v"..RealmImIn.version..": Button_OnLoad ");
	self.registry = {
		id = MY_ADDON_ID,
		version = RealmImIn.version,
		category = MY_ADDON_CAT,
		menuText = RealmImIn.menu_text,
		buttonTextFunction = "TitanPanelRealmImInButton_GetButtonText",
		tooltipTextFunction = "TitanPanelRealmImInButton_GetTooltipText",
		controlVariables = {
			ShowIcon = true,
			ShowLabelText = true,
			ShowColoredText = true,
			DisplayOnRightSide = false
		},
		savedVariables = {
			ShowIcon = false,
			ShowLabelText = true,
			ShowColoredText = false,  
		}
	}
end

function TitanPanelRightClickMenu_PrepareRealmImInMenu()
	local info

	-- level 2 menu
	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "Options" then
			--TitanPanelRightClickMenu_AddTitle(RealmImIn.menu_option, UIDROPDOWNMENU_MENU_LEVEL)
		end
		return -- so the menu does not create extra repeat buttons
	end
	
	-- level 1 menu
--	if "UIDROPDOWNMENU_MENU_LEVEL" == 1 then
		TitanPanelRightClickMenu_AddTitle(TitanPlugins[RealmImIn.id].menuText);
		 
		info = {};
		--info.text = RealmImIn.menu_option
		--info.value = "Options"
		--info.hasArrow = 1;
		--UIDropDownMenu_AddButton(info);

		TitanPanelRightClickMenu_AddSpacer();     
		TitanPanelRightClickMenu_AddToggleIcon(RealmImIn.id);
		TitanPanelRightClickMenu_AddToggleLabelText(RealmImIn.id);
		TitanPanelRightClickMenu_AddToggleColoredText(RealmImIn.id);
		TitanPanelRightClickMenu_AddSpacer();     
		TitanPanelRightClickMenu_AddCommand(L["TITAN_PANEL_MENU_HIDE"], RealmImIn.id, TITAN_PANEL_MENU_FUNC_HIDE);
--	end

end

function TitanPanelRealmImInButton_GetButtonText(id)
	local label = ""
	local text = ""
	
	if (TitanGetVar(RealmImIn.id, "ShowLabelText")) then
		label = L["ADDON_NAME"] .. ": "
	end

	if (TitanGetVar(RealmImIn.id, "ShowColoredText")) then
		text = "|cff1fb3ff" .. RealmImIn.realm .. "|r "
	else
		text = RealmImIn.realm
	end	
	
	return label .. text 
end

function TitanPanelRepairButton_GetTooltipText()
	return "???tooltiptext???"
end

-- -- -- -- -- --