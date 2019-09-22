--[[	
*** StableSnapshot ***
Written by : echomap
--]]

local testTabs = false

local StableSnapshot_MainFrame  = nil
local StableSnapshot_PetFrame = nil
local StableSnapshot_Icons = {}
local StableSnapshot_guishown = false
local selGroup
--local CountByFamilyGui_

local L = LibStub("AceLocale-3.0"):GetLocale("StableSnapshot", false)

-- 
function StableSnapshot:ToggleGui()
	StableSnapshot:DebugMessage("toggle: Called")
	if StableSnapshot_MainFrame == nil then
		StableSnapshot:DebugMessage("toggle: frame is nil")
		StableSnapshot:ShowGui()
    else    		
		if StableSnapshot_MainFrame.frame:IsShown() then
		StableSnapshot:DebugMessage("toggle: frame is shown right now")
			StableSnapshot:HideGui()
		else 
			StableSnapshot:DebugMessage("toggle: frame is not shown right now")
			StableSnapshot:ShowGui()
		end
	end
end

-- 
function StableSnapshot:ShowGui()
    local AceGUI = LibStub("AceGUI-3.0")
    
	local f = AceGUI:Create("Frame")
	StableSnapshot_MainFrame = f
	f:SetCallback("OnClose", StableSnapshot.HideGui )
	--function(self) StableSnapshot.HideGui2(self) end )
	--StableSnapshot.HideGui )
	-- function(widget) AceGUI:Release(widget) StableSnapshot_guishown = false print("Closing StableSnapshot") end)
	--StableSnapshot.HideGui2 )	
	--function(widget) AceGUI:Release(widget) end)
	f:SetCallback("OnEscapePressed", StableSnapshot.HideGui ) 
	--function(widget) AceGUI:Release(widget) StableSnapshot_guishown = false print("Closing StableSnapshot") end)
	f:SetLayout("Flow")
	f:SetTitle( L["Main_Title"] )
	f:SetStatusText( L["Main_StatusText"] )	
	f:SetWidth(400)
	f:SetHeight(300)
	--f:SetMovable(true)
	
	_G["StableSnapshot_Display"] = f
	tinsert (UISpecialFrames, "StableSnapshot_Display")

	StableSnapshot:ShowGuiIcons(f)	
	
	-- TABS		
	if testTabs == true then 
		StableSnapshot.SetupTabs()
	end
		
	-- Button(s)
	--local btn1 = AceGUI:Create("Button")
	--btn1:SetText("Count By Family")
	--btn1:SetWidth(400)
	--btn1:SetCallback("OnClick", StableSnapshot.CountByFamilyGui )
	--f:AddChild(btn1)

	--local btn2 = AceGUI:Create("Button")
	--btn2:SetText("Count By Special")
	--btn2:SetWidth(400)
	--btn2:SetCallback("OnClick", StableSnapshot.CountBySpecialGui )
	--f:AddChild(btn2)

	local btn3 = AceGUI:Create("Button")
	btn3:SetText("Clear All Pets")
	--btn2:SetWidth(400)
	btn3:SetCallback("OnClick", StableSnapshot.ClearAllPets )
	f:AddChild(btn3)
	
	if self.db.char.stable_lasttime == nil then
	else 
		local label = AceGUI:Create("Label")
		--label:SetFontObject("GameFontNormalSmall")
		label:SetColor(0.9,0.9,0.9)
		label:SetFullWidth(true)
		label:SetText( L["Main_LastUpdatedText"] .. self.db.char.stable_lasttime )
		f:AddChild(label)
	end
		
	-- END
	StableSnapshot_guishown = true
end

-- 
function StableSnapshot:HideGui()
	StableSnapshot:DebugMessage("Closing StableSnapshot")
	local AceGUI = LibStub("AceGUI-3.0")
	AceGUI:Release(StableSnapshot_MainFrame)	
	--AceGUI:Release(StableSnapshot_PetFrame)
	StableSnapshot_guishown = false	
	StableSnapshot:DebugMessage("Closed StableSnapshot")
end

-- 
function StableSnapshot:HideGui2(widget)
	StableSnapshot:DebugMessage("Closing StableSnapshot 2")
	local AceGUI = LibStub("AceGUI-3.0")
	AceGUI:Release(widget)	
	StableSnapshot_guishown = false
	StableSnapshot:DebugMessage("Closed StableSnapshot 2")
end

-- 
function StableSnapshot:HidePetGui()
	StableSnapshot:DebugMessage("Closing StableSnapshot PetFrame")
	--local AceGUI = LibStub("AceGUI-3.0")
	--AceGUI:Release(StableSnapshot_PetFrame)
	HideUIPanel(StableSnapshot_PetFrame);
	StableSnapshot:DebugMessage("Closed StableSnapshot PetFrame")
end

-- 
function StableSnapshot:OnRelease()
	StableSnapshot_guishown = false
	StableSnapshot:DebugMessage("Released StableSnapshot")
end

-- 
function StableSnapshot:ShowGuiIcons(frame)
 	--maxPets = 55
	petnumidx = 1
	
	filledNum  = self.db.char.stable_petnumidx;
	if filledNum == nil then
		--playerUnitId = UnitId("player")
		localizedClass, englishClass = UnitClass("player");
		StableSnapshot:DebugMessage("ShowStable englishClass: " .. englishClass .. "'" )
		if englishClass == 'HUNTER' then
			print( L["ShowStable_NoneSaved_Hunter"] )
		else 
			print( L["ShowStable_NoneSaved"] )
		end		
	else 
		StableSnapshot:DebugMessage("ShowStableGui: filledNum: " .. filledNum )
		
		petarrAll = self.db.char.stable
		if petarrAll == nil then
			print( L["ShowStable_NoPets"] )
		else 	
			for index=1, StableSnapshot.maxPets do				
				petarr = self.db.char.stable[index] 			
				if petarr == nil then
					StableSnapshot:DebugMessage("ShowStableGui: can't print pet: " .. index )
				else 
					StableSnapshot:SetupPetIcon(petarr,index,frame)
				end
			end
		end
	end	
	StableSnapshot:DebugMessage("ShowStableGui Done")
end

-- Create Icon's for each pet slot in the stable
function StableSnapshot:SetupPetIcon(petarr,index,frame) 

	name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)

	if name == nil then
		StableSnapshot:DebugMessage("PrintPet: cant print num " .. index )
	else 
	
		if icon == nil then
			--StableSnapshot:DebugMessage("PrintPet: no icon for num " .. index )
			icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
			--StableSnapshot:DebugMessage("PrintPet: putting in a default icon")
		end

		local AceGUI = LibStub("AceGUI-3.0")
		local icon1 = AceGUI:Create("Icon")
		icon1:SetImage(icon)
		icon1:SetImageSize(30,30)
		icon1:SetLabel(name) -- .. " ("..miscinfo..")" )
		icon1.tooltipText = name
		icon1.tooltip = name;
		--?? icon1.tooltipSubtext = format(STABLE_PET_INFO_TOOLTIP_TEXT, level, family, name);				
		frame:AddChild(icon1)		
		--icon1:SetCallback("OnEnter", StableSnapshot.PetIconTooltip )	
		StableSnapshot_Icons[index] = icon1
		
		-- Callbacks
		icon1:SetCallback("OnClick", function() StableSnapshot:PetOnMouseUp(index) end)
		icon1:SetCallback("OnEnter", function() StableSnapshot.PetIconTooltipNew(index) end)
		icon1:SetCallback("OnLeave", StableSnapshot.HidePetIconTooltip )
		-- Callbacks
				
		return icon1
	end
end

-- Callback functions
function StableSnapshot:PetOnMouseUp(index)
	StableSnapshot:DebugMessage("PetOnMouseUp: Called");
	if(index) then
		StableSnapshot:DebugMessage("PetOnMouseUp: index = " ..index)
	end

	local f = nil

	if StableSnapshot_PetFrame ~= nil then
		f = StableSnapshot_PetFrame
	else
		f = CreateFrame("PlayerModel", nil, StableSnapshot.StableSnapshot_MainFrame )	
	
		StableSnapshot_PetFrame = f		
		f:SetSize(300, 300)
		--f:SetPoint("BOTTOMLEFT", 2, 4);
		--f:SetPoint("BOTTOMLEFT", 0, 0);
		--f:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0);
		--f:SetPoint("TOPRIGHT", StableSnapshot.StableSnapshot_MainFrame, "BOTTOMLEFT", 0, 0)
		f:ClearAllPoints();
		--f:SetPoint("BOTTOMLEFT", StableSnapshot.StableSnapshot_MainFrame, "BOTTOMLEFT", 0, 0)
		f:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 0, 0);

		f:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeSize = 1,
		})
		f:SetBackdropColor(0, 0, 0, .5)
		f:SetBackdropBorderColor(0, 0, 0)

		f:EnableMouse(true)
		f:SetMovable(true)
		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", f.StartMoving)
		f:SetScript("OnDragStop", f.StopMovingOrSizing)
		f:SetScript("OnHide", f.StopMovingOrSizing)
		--f:SetScript("OnEscapePressed", f.Hide )
		--f:SetCallback("OnEscapePressed", f:Hide() ) 
		f:SetClampedToScreen(true);
		f:SetFrameStrata("HIGH");
		--f:SetScript("OnEscapePressed", StableSnapshot.HidePetGui );
		
		local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
		f.closeButton = close	
		close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
		close:SetScript("OnClick", function()	
			f:Hide()
		end)
		--local topText = CreateFrame("Frame", nil, f, "UIPanelEditBox")	
		--topText:SetPoint("TOPLEFT", f, "TOPLEFT")
		--topText.SetText("asdfadsf");
		f.text = f:CreateFontString(nil, "BACKGROUND", "GameFontNormal")		
		f.text:SetPoint("BOTTOM", f, "BOTTOM", 40, 40)
	end			
	
	local petarr = self.db.char.stable[index] 
	StableSnapshot:DebugMessage("PetOnMouseUp: Trying to get spell details");
	--StableSnapshot:printPet(petarr,index) 
	--name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
  name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList = StableSnapshot:ParsePetArray(petarr)
	local spellName = "";	

	f.text:SetText("")
	
	if specialAbility ~= nil then
		StableSnapshot:DebugMessage("PetOnMouseUp: SpecialAbility = " .. specialAbility );
		local spellID, text, range, castTime, cd  = StableSnapshot:GetPetSpellDetails(specialAbility)
		if text ~= nil then		
			--f.text:SetText(">>Special>> " .. text )
			f.text:SetText( text )
			--print("SpellName: " .. text )
		else
			StableSnapshot:DebugMessage("PetOnMouseUp: Bad result from DBSPELLS" )
		end
	else
		f.text:SetText("No spells details available")
	end
	
	SetPetStablePaperdoll(f, index)
	ShowUIPanel(StableSnapshot_PetFrame);
	StableSnapshot:DebugMessage("PetOnMouseUp: Done")
end

-- 
function StableSnapshot.PetIconTooltipNew(index)
	StableSnapshot:DebugMessage("PetIconTooltipNew: Checking vs self")
	if(index) then
		StableSnapshot:DebugMessage("PetIconTooltipNew: index = " ..index)
	end		
	StableSnapshot:PetIconTooltipStub(index)
end

-- 
function StableSnapshot:SetupIconCallbacks(icon1,funct)
	icon1:SetCallback("OnEnter", funct )	
	icon1:SetCallback("OnLeave", StableSnapshot.HidePetIconTooltip )
end

-- 
function StableSnapshot.HidePetIconTooltip(self)
	StableSnapshot:DebugMessage("HidePetIconTooltip: Called")
	if self == nil then
		StableSnapshot.HidePetIconTooltip2()
	else
		StableSnapshot.HidePetIconTooltip1(self)
	end
	StableSnapshot:DebugMessage("HidePetIconTooltip: Done")
end

-- 
function StableSnapshot.HidePetIconTooltip1(self)
	StableSnapshot:DebugMessage("HidePetIconTooltip: Checking vs self")
	if GameTooltip:IsOwned(self.frame) then
		StableSnapshot:DebugMessage("Releasing gametip from self")	
		GameTooltip:Hide()
	else 
		StableSnapshot:DebugMessage("HidePetIconTooltip: tooltip not owned by self")
		StableSnapshot.HidePetIconTooltip2()
	end
end

-- 
function StableSnapshot.HidePetIconTooltip2()
	if StableSnapshot_MainFrame == nil then
		StableSnapshot:DebugMessage("HidePetIconTooltip: MainFrame is nil")
	else
		StableSnapshot:DebugMessage("HidePetIconTooltip: Checking vs MainFrame")
		if GameTooltip:IsOwned(StableSnapshot_MainFrame.frame) then
			StableSnapshot:DebugMessage("Releasing gametip from MainFrame")	
			GameTooltip:Hide()
		end			
	end
end

-- 
function StableSnapshot:PetIconToolTipUtil(text,line1,line2,line3,line4)
	GameTooltip:SetOwner(StableSnapshot_MainFrame.frame, "ANCHOR_CURSOR");
	GameTooltip:SetText(text);
	GameTooltip:AddLine(line1, 1.0, 1.0, 1.0);
	GameTooltip:AddLine(line2, 1.0, 1.0, 1.0);
	if line3 ~= nil then
		GameTooltip:AddLine(line3, 1.0, 1.0, 1.0);
	end
	if line4 ~= nil then
		GameTooltip:AddLine(line4, 1.0, 1.0, 1.0);
	end
	GameTooltip:Show();
end

	--[[
	local LibQTip = LibStub('LibQTip-1.0')
	local tooltip = LibQTip:Acquire("Tooltip", 3, "LEFT", "CENTER", "RIGHT")	
	-- Add an header filling only the first two columns
	tooltip:AddHeader('Anchor', 'Tooltip')
	-- Add an new line, using all columns
	tooltip:AddLine('Hello', 'World', '!')						  							  
	-- Use smart anchoring code to anchor the tooltip to our frame
	--tooltip:SmartAnchorTo(self.frame)	   
	-- Show it, etc !
	tooltip:Show()	
	]]
	
-- 
function StableSnapshot:PetIconTooltipStub(index)
	StableSnapshot:DebugMessage("Show tooltip [" .. index .. "]" )
	-- do i really need to do this again here??
	self.db =  LibStub("AceDB-3.0"):New("StableSnapshotDB", StableSnapshotDB_defaults, true )       
	petarr = self.db.char.stable[index] 
	--name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
  name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList = StableSnapshot:ParsePetArray(petarr)
	StableSnapshot:PetIconToolTipUtil(name,"Level: ".. level .. " Family: " .. family , "Special: " .. specialAbility, "loyalty: " .. loyalty .. " happiness: " ..happiness.. " petFoodList: " ..tostring(petFoodList) )
end	


-- TABS

-- 
function StableSnapshot:SetupTabs()
	
	local f2 = AceGUI:Create("Frame")	
	f2:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end )
	f2:SetLayout("Flow")
	f2:SetWidth(300)
	f2:SetHeight(300)
	-- Create the TabGroup
	local tabGroup =  AceGUI:Create("TabGroup")
	tabGroup:SetLayout("Flow")
	-- Setup Tabs
	 local tab1= {text = "Test1", value=1}
	 local tab2= {text = "Test2", value=2}
	 local tab3= {text = "Test3", value=3}
	 local tab4= {text = "ReallyLongTabName", value=4}	
	-- Setup which tabs to show
	tabGroup:SetTabs({tab1, tab2, tab3, tab4})
	-- Register callback
	tabGroup:SetCallback("OnGroupSelected", 
		function(container, event, group) 
			selGroup = group 
			StableSnapshot.SelectGroup(container, event, group) 
		end )
	-- Set initial Tab (this will fire the OnGroupSelected callback)
	tabGroup:SelectTab("tab1")
	-- add to the frame container
	f2:AddChild(tabGroup)
end

-- Callback function for OnGroupSelected
function StableSnapshot:SelectGroup(container, event, group)
	StableSnapshot:DebugMessage("SelectGroup Called")
	if group == nil then
		StableSnapshot:DebugMessage("SelectGroup: group is nil")
		if selGroup == nil then
			StableSnapshot:DebugMessage("SelectGroup: uh oh, selGroup is nil")
		end
		group = selGroup
	end
	--??container:ReleaseChildren()	
	StableSnapshot:DebugMessage("SelectGroup: group: '" .. group .. "'" )	
	if group == "1" then
		StableSnapshot:DebugMessage("SelectGroup call tab1")
		StableSnapshot.DrawGroup1(container)
	elseif group == "2" then
	StableSnapshot:DebugMessage("SelectGroup call tab2")
		StableSnapshot.DrawGroup2(container)
	elseif group == "3" then
	StableSnapshot:DebugMessage("SelectGroup call tab3")
		StableSnapshot.DrawGroup3(container)
	elseif group == "4" then
	StableSnapshot:DebugMessage("SelectGroup call tab4")
		StableSnapshot.DrawGroup4(container)      
	end
	StableSnapshot:DebugMessage("SelectGroup Done")
end

-- function that draws the widgets for the first tab
function StableSnapshot:DrawGroup1(container)
  local desc = AceGUI:Create("Label")
  desc:SetText("This is Tab 1")
  desc:SetFullWidth(true)
  container:AddChild(desc)
  
  local button = AceGUI:Create("Button")
  button:SetText("Tab 1 Button")
  button:SetWidth(200)
  container:AddChild(button)
end

-- function that draws the widgets for the second tab
function StableSnapshot:DrawGroup2(container)
  local desc = AceGUI:Create("Label")
  desc:SetText("This is Tab 2")
  desc:SetFullWidth(true)
  container:AddChild(desc)
  
  local button = AceGUI:Create("Button")
  button:SetText("Tab 2 Button")
  button:SetWidth(200)
  container:AddChild(button)
  StableSnapshot:DebugMessage("DrawGroup2 Done")
end

-- 
function StableSnapshot:DrawGroup3(container)
  local desc = AceGUI:Create("Label")
  desc:SetText("This is Tab 3")
  desc:SetFullWidth(true)
  container:AddChild(desc)
  
  local button = AceGUI:Create("Button")
  button:SetText("Tab 3 Button")
  button:SetWidth(200)
  container:AddChild(button)
end

-- 
function StableSnapshot:DrawGroup4(container)
  local desc = AceGUI:Create("Label")
  desc:SetText("This is Tab 4")
  desc:SetFullWidth(true)
  container:AddChild(desc)
  
  local button = AceGUI:Create("Button")
  button:SetText("Tab 4 Button")
  button:SetWidth(200)
  container:AddChild(button)
end


-- END OF FILE