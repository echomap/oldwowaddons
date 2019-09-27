--[[	
*** StableSnapshot ***
Written by : echomap
--]]

local addonName, addon = ...
local debugMe = false

StableSnapshot = LibStub("AceAddon-3.0"):NewAddon("StableSnapshot", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):NewLocale("StableSnapshot", false, debugMe)

--  Get data from the TOC file.
StableSnapshot.version = tostring(GetAddOnMetadata(addonName, "Version")) or "Unknown" 
StableSnapshot.author = GetAddOnMetadata(addonName, "Author") or "Unknown"
StableSnapshot.id = addonName
StableSnapshot.icon = "Interface\\AddOns\\stablesnapshot\\Icons\\Stable2";
--StableSnapshot.icon = "Interface\\AddOns\\stablesnapshot\\Icons\\Default";

local options = {
    name = addonName,
    handler = StableSnapshot,
    type = 'group',
	args = {
        msg = {
            type = 'input',
            name = 'My Message',
            desc = 'The message for my addon',
            get = 'GetMyStable',
        },
    },
}

--LibStub("AceConfig-3.0"):RegisterOptionsTable("StableSnapshot", options, {"strack", "StableSnapshot"})
--StableSnapshot:RegisterChatCommand("strack", "SlashFunc")

-- Oninitialize: Called when the addon is loaded
function StableSnapshot:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("StableSnapshot", options, {"StableSnapshot", "strack"})
    
    self.db =  LibStub("AceDB-3.0"):New("StableSnapshotDB", StableSnapshotDB_defaults, true )       
    self.db.profile.playerName = UnitName("player")

	StableSnapshot:RegisterChatCommand("strack", "SlashFunc")		
	StableSnapshot:RegisterChatCommand("stablesnapshot", "SlashFunc")		
end

-- OnEnable: Called when the addon is enabled
function StableSnapshot:OnEnable()
	self:RegisterEvent("PET_STABLE_SHOW")
	StableSnapshot:addSlideIcon() --create ldb launcher button
	self:Print("v"..StableSnapshot.version.." loaded")
end

function StableSnapshot:OnDisable()
    -- Called when the addon is disabled
    self:Print("StableSnapshot Disabled")
    StableSnapshot_guishown = false
end

function StableSnapshot:PET_STABLE_SHOW()
	self:DoStableOpened()
end

function StableSnapshot:SlashFunc(input)
	-- Process the slash command ('input' contains whatever follows the slash command)	
	if input == nil or input == '' then
		debugMeStr = "false"
		if debugMe then
			debugMeStr = "true"
		end
		print( L["Main/print_msg"] )
		print("/strack <gui/debug>  (debug is " .. debugMeStr .. ")" )
		print("/strack <showtest/guitest> (debug is " .. debugMeStr .. ")" )
	end   
	if input == 'show' then
		StableSnapshot:ShowGui()
	end
	if input == 'hide' then
		StableSnapshot:HideGui()
	end	
	if input == 'gui' then
		StableSnapshot:ToggleGui()
	end	
	if input == 'guitest' then
		StableSnapshot:ToggleGuiTest()
	end		
	if input == 'showtest' then
		StableSnapshot:ShowGuiTest()
	end			
	if input == 'version' then
		print("Version = " .. StableSnapshot.version);
	end		
	
	if  input == 'debug' then
		if debugMe then
			debugMe = false
			print("strack: debug is off");
		else
			debugMe = true 
			print("strack: debug is on");
		end	
	end
	if input == 'CountByFamily' then
		StableSnapshot:CountByFamily()
	end
	if input == 'CountByFamilyGui' then
		StableSnapshot:CountByFamilyGui()
	end	
	if input == 'CountBySpecial' then
		StableSnapshot:CountBySpecial()
	end
	if input == 'CountBySpecialGui' then
		StableSnapshot:CountBySpecialGui()
	end		
end

function StableSnapshot:DoStableOpened()
	StableSnapshot:DebugMessage("You have opened the stable!")
   
   -- petIcon, petName, petLevel, petType, petLoyalty = GetStablePetInfo (classic)
	local icon, name, level, family, talent = GetStablePetInfo(1)
	StableSnapshot:DebugMessage("DoStableOpened name: " .. name .. "' family: '" ..family.. "'" )
	if icon == nil and name == nil and family == nil then
		--break
	else 
		-- Loop through all pets in the Stable and store them
		StableSnapshot:ScanStable()
	end
	
end 

function StableSnapshot:DebugMessage(msg)
	if debugMe then
		print(msg)
	end
end

-- dunno if going to use this...
function StableSnapshot:GetMyStable(info)
	StableSnapshot:DebugMessage("GetMyStable Called")
	--self:ShowStable()
    return "done GetMyStable"
end

function StableSnapshot:addSlideIcon()
	local LibDataBroker = LibStub:GetLibrary("LibDataBroker-1.1", true)
	if not LibDataBroker then 
		StableSnapshot.Print("No LibDataBroker, not loading ldb functionality");
		return 
	end
	
	local LDBButton = LibDataBroker:NewDataObject("StableSnap", {
		type = "launcher",
		icon = StableSnapshot.icon,
		OnClick = function(self, button) StableSnapshot:ToggleGui(self, button) end,
		})
	
	local v1 = ""
	local v2 = ""
	local L = LibStub("AceLocale-3.0"):NewLocale("StableSnapshot", false, debugMe)	
	if L == nil then
		v1 = "StableSnapshot is an AddOn hunters can use to see their stable when they are not near a Stable Master."
		v2 = "|cff1fb3ffClick|r to open the report."
	else
		v1 = L["Main/ldb_tooltip"]
		v2 = L["Main/ldb_tooltip2"]		
	end
	
	function LDBButton:OnTooltipShow()
		self:AddLine("StableSnapshot",  1,1,0.5, 1)
		self:AddLine( v1 ,  1,1,0.5, 1)
		--self:AddLine("|cff1fb3ff".."Click".."|r ".."to open the report.",  1,1,0.5, 1)
		self:AddLine( v2 ,  1,1,0.5, 1)
	end
	function LDBButton:OnEnter()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
		GameTooltip:ClearLines()
		LDBButton.OnTooltipShow(GameTooltip)
		GameTooltip:Show()
	end
	function LDBButton:OnLeave()
		GameTooltip:Hide()
	end
		
end

local function trim (s)
      return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end


-- END