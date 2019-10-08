--[[
  * Artemis ***
  * Written by : echomap (Echomapping)
  *
	* Copyright (c) 2019 by Echomap	@ gmail.com
	*
	* is distributed in the hope that it will be useful and perhaps entertaining,
	* but WITHOUT ANY WARRANTY
]]--
-------------------------------------------------------------------------
-------------------------------------------------------------------------
Artemis = {
    name            = "Artemis",	-- Matches folder and Manifest file names.
    displayName     = "Artemis Hunter Helper",
    version         = "1.0.2",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.    
    --menuName        = "Artemis_Options", -- Unique identifier for menu object.
    --menuDisplayName = "Artemis",
    view            = {
        debug = false,
        debuglvl = 1,
        maxPets  = 3,
    },
    --Saved Variables: ArtemisDB/ArtemisDBChar
}
local _, L = ...;
-------------------------------------------------------------------------
-- UTILS
-------------------------------------------------------------------------
function Artemis.DebugMsg(msg,level)
  if( msg ~= nil and msg ~= "" and Artemis.view.debug ) then
    print("Artemis " .. msg )
  end
end

function Artemis.PrintMsg(msg)
  if( msg ~= nil) then 
    print("(Artemis) " .. msg )
  end
  --TODO TIME STAMP date("%B %m %Y %H:%M:%S")
end

function Artemis:formatTime(sec)
  local msgTimeFormat = "%dm %02ds"
  return string.format(msgTimeFormat,math.floor(sec/60), sec %60)
	--return string.format(L["msgTimeFormat"],math.floor(sec/60), sec %60)
end

function Artemis:SetStringOrDefault(value,defaultvalue)
  if value == nil then
    return defaultvalue;
  end
  return value
end

function Artemis:trim (s)
      return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end



-------------------------------------------------------------------------
--MAIN UI
-------------------------------------------------------------------------
-- Show (or hide) the main window display
function Artemis:ShowHide()
	--DEFAULT_CHAT_FRAME:AddMessage("Is shown?" .. "was clicked.")
	if ArtemisMainFrame == nil or not Artemis.view.setupmain then 
		Artemis:SetupWindow()
    Artemis:ShowWindow()
	else
    if (ArtemisMainFrame:IsShown()) then 
      Artemis:HideWindow()
    else
      Artemis:ShowWindow()
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage(tostring(arg1).." was clicked.")
  --TODO frames/tabs
end

-- Called the first time showhide is called, or after OnUnLoad() is called
function Artemis:SetupWindow()
  if( not Artemis.view.setupmain ) then 
    ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
    ArtemisMainFrame:RegisterForDrag("LeftButton");  -- DRAG
    
    ArtemisMainFrame:RegisterEvent("PET_STABLE_SHOW")
    ArtemisMainFrame:RegisterEvent("PET_STABLE_UPDATE")
    
    ArtemisMainFrame:RegisterUnitEvent("UNIT_PET","player")
    ArtemisMainFrame:RegisterUnitEvent("UNIT_HAPPINESS","pet")
  end  
  Artemis:UpdatePetHappiness()
  Artemis.view.setupmain = true
  ArtemisDBChar.enable = true 
end

-- Show the main window: ammo/durability/happiness(if hunter)
function Artemis:ShowWindow()  
	ArtemisMainFrame:Show()
  --if has ammo and ranged weapon TODO
  ArtemisMainFrame_AmmoFrame:Show()
  ArtemisMainFrame_wpnDurFrame:Show()
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    ArtemisMainFrame_HappinessFrame:Show() --TODO not showing sometimes?
  end
  --ArtemisMainFrame_HappinessFrame:Show()
	--Artemis_UpdateList()
  -- TODOcontent/tabs
end

-- Hide the main window: ammo/durability/happiness(if hunter)
function Artemis:HideWindow()
	ArtemisMainFrame:Hide()
  ArtemisMainFrame_AmmoFrame:Hide()
  ArtemisMainFrame_wpnDurFrame:Hide()
  ArtemisMainFrame_HappinessFrame:Hide()
end

--GUI close button clicked
function Artemis:BtnClose()
	Artemis:HideWindow()
end

-- Called after ADDON_LOADED via the Main frame, event framework
function Artemis:InitAddon()
  Artemis.DebugMsg("Init: Called")
  if( ArtemisDBChar~=nil and ArtemisDBChar.debug) then
    Artemis.view.debug = ArtemisDBChar.debug
  end
    if( ArtemisDBChar~=nil and ArtemisDBChar.enable) then
    Artemis.view.enable = ArtemisDBChar.enable
  end  
end

-- Called via Main frame: update 
function Artemis:OnUpdate()
  --Artemis.DebugMsg("OnUpdate: Called")
  if( not ArtemisDBChar.enable ) then
    return
  end
  --TODO How often is this called? too often probably?
  Artemis:LoadAmmoCount()
  Artemis:SetupDataWindow()
end

-- Main frame : Event framework
function Artemis:OnEvent(event, ...)
  Artemis.DebugMsg("OnEvent: Called w/event="..tostring(event) )
  if( not ArtemisDBChar.enable) then
    return
  end
  Artemis.DebugMsg("OnEvent: arg1 = "..tostring(arg1) )
  if( arg2 ~= nil) then
    Artemis.DebugMsg("OnEvent: arg2 = "..tostring(arg2) )
  end
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisMainFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED")
		ArtemisMainFrame:UnregisterEvent("ADDON_LOADED")
		Artemis:InitAddon()
  elseif event == "PLAYER_LOGOUT" then
    Artemis:OnUnLoad()
	elseif event == "PET_STABLE_SHOW" then
    Artemis:DoStableMasterEvent()
	elseif event == "PET_STABLE_UPDATE" then
    Artemis:DoStableMasterEvent()
  elseif event == "UNIT_PET" then
    Artemis:CheckPetChanged()
  elseif event == "UNIT_HAPPINESS" then
    Artemis.DebugMsg("OnEvent: arg1 = "..tostring(arg1) ) -- "pet"
    Artemis:UpdatePetHappiness()
  else
    --TODO How often is this called? -- make sense here? Artemis:LoadAmmoCount()
  end
end

-- Unregister Main Frame events: via PLAYER_LOGOUT and /artemis enable off
function Artemis:OnUnLoad()
  Artemis.DebugMsg("OnUnLoad: Called")
  --
  ArtemisMainFrame:UnregisterEvent("ADDON_LOADED")
  --ArtemisMainFrame:UnregisterEvent("LeftButton");  -- DRAG
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_SHOW")
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_UPDATE")
  ArtemisMainFrame:UnregisterEvent("UNIT_PET")
  ArtemisMainFrame:UnregisterEvent("UNIT_HAPPINESS")  
  --
  Artemis.view.setupmain = false
  Artemis.DebugMsg("OnUnLoad: Done")
end


-- Called via Main frame: load 
function Artemis:OnLoad()
  Artemis.DebugMsg("OnLoad: Called")
  
  -- If saved variables has enabled == false (not null/not unset ), then stop!
  if( ArtemisDBChar~=nil and ArtemisDBChar.enable~=nil and ArtemisDBChar.enable == false ) then
      return
  end
  
  -- Initalize Saved Variables
	if not ArtemisDB then ArtemisDB = {} end -- fresh DB
	if not ArtemisDBChar then 
    -- fresh DB
    ArtemisDBChar = {} 
    ArtemisDBChar.stable = {}
    --if hunter and not set/unset then enable
    local localizedClass, englishClass = UnitClass("player");
    if englishClass == 'HUNTER' then
      if( ArtemisDBChar.enable == nil ) then
        ArtemisDBChar.enable = true
      end
    end    
  end 
  
  --TODO StableSnapshot:addSlideIcon() --create ldb launcher button

  --
  if ArtemisDBChar.enable then
    Artemis:ShowWindow()    
    --Artemis:UpdatePetHappiness()
  end
  
  -- If enabld == false at this point, then stop!
  if( not ArtemisDBChar.enable ) then
    return
  end
  
  --Register Events
  ArtemisMainFrame:RegisterEvent("ADDON_LOADED");  -- Fired when saved variables are loaded
  ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
  ArtemisMainFrame:RegisterForDrag("LeftButton");  -- DRAG
  
	ArtemisMainFrame:RegisterEvent("PET_STABLE_SHOW")
  ArtemisMainFrame:RegisterEvent("PET_STABLE_UPDATE")
  
  ArtemisMainFrame:RegisterUnitEvent("UNIT_PET","player")
  ArtemisMainFrame:RegisterUnitEvent("UNIT_HAPPINESS","pet")
  
	print("v"..Artemis.version.." loaded")
end

--
function Artemis:BtnStartSizeing()
  --Artemis.DebugMsg("BtnStartSizeing: Called")
  ArtemisMainFrame:StartSizing()		
end
function Artemis:BtnStopSizeing()
  --Artemis.DebugMsg("BtnStopSizeing: Called")
	ArtemisMainFrame:StopMovingOrSizing()
	Artemis:ResizeGui()
	Artemis:SaveAnchors()
end
function Artemis:ResizeGui()
  --Artemis.DebugMsg("ResizeGui: Called")
	--ArtemisMainFrame_ScrollChildFrame:SetWidth(ArtemisMainFrame_ScrollFrame:GetWidth())
end
function Artemis:SaveAnchors()
  --Artemis.DebugMsg("SaveAnchors: Called")
	--ArtemisDBChar.X = ArtemisMainFrame:GetLeft()
	--ArtemisDBChar.Y = ArtemisMainFrame:GetTop()
	--ArtemisDBChar.Width = ArtemisMainFrame:GetWidth()
	--ArtemisDBChar.Height = ArtemisMainFrame:GetHeight()
end
function Artemis:OnSizeChanged()
  --Artemis.DebugMsg("OnSizeChanged: Called")
  Artemis:ResizeGui()
end
function Artemis:OnDragStart()
  --Artemis.DebugMsg("OnDragStart: Called")  
	ArtemisMainFrame:StartMoving()
end
function Artemis:OnDragStop()
  --Artemis.DebugMsg("OnDragStop: Called")
	ArtemisMainFrame:StopMovingOrSizing()
	Artemis:SaveAnchors()
end

-- Main Window tooltip
function Artemis:ShowTooltip(self,messageType)
  if( not ArtemisMainFrame:IsShown()) then
    return
  end
  local message = "Artemis"
  if( messageType ~= nil) then
    
    if( messageType == "Settings") then 
      message = message .. " Settings/Options"
    elseif( messageType == "AmmoCount") then
      local itemLink = GetInventoryItemLink("player", Artemis.view.ammoSlot )
      if( itemLink ~= nil) then
        local itemName, itemLink2, itemRarity, itemLevel, itemMinLevel, itemType, 
            itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(itemLink)      
        message = "<" .. itemName .. ">"      
      else
        message = "< None >"
      end
    elseif( messageType == "WpnDur") then
      local itemLink = GetInventoryItemLink("player", Artemis.view.rangedSlot )
      if( itemLink ~= nil) then
        local itemName, itemLink2, itemRarity, itemLevel, itemMinLevel, itemType, 
            itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =  GetItemInfo(itemLink)      
        message = "<" .. itemName .. ">"      
      else
        message = "< None >"
      end
    elseif( messageType == "PetHappiness") then
      if( ArtemisDBChar.stable ~= nil ) then
        local petarr = ArtemisDBChar.stable[1] 
        -- name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp
        local name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)	
        --local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
        --local happy = ({"Unhappy", "Content", "Happy"})[happiness]
        message = "<" .. happiness .. ">"
      end
    else
      message = message .. " " .. messageType
    end
  end
  GameTooltip:SetOwner(ArtemisMainFrame, "ANCHOR_BOTTOM", 0,0	)
	GameTooltip:AddLine(message .."\n" ,.8,.8,.8,1,false)
	GameTooltip:Show()
end
function Artemis:HideTooltip()
	GameTooltip:Hide()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------



-------------------------------------------------------------------------
--Stable UI (DataFrame/DataWindow)
-------------------------------------------------------------------------
-- Show (or hide) the Stable window display
function Artemis:ShowHideDataWindow()
	if ArtemisMainDataFrame == nil then 
		Artemis:InitDataWindow()
    Artemis:ShowDataWindow()
	else
    if (ArtemisMainDataFrame:IsShown()) then 
      Artemis:HideDataWindow()
    else
      Artemis:SetupDataWindow()
      Artemis:ShowDataWindow()
		end
	end
	--DEFAULT_CHAT_FRAME:AddMessage(tostring(arg1).." was clicked.")
  --TODO frames/tabs
end

-- Called the first time showhide is called, or after OnUnLoad() is called
function Artemis:SetupDataWindow() 
  --ArtemisMainFrame:SetScript("OnEscapePressed", function(self) Artemis:HideWindow() end)
  tinsert( UISpecialFrames, ArtemisMainDataFrame:GetName() )
end

-- Show the Stable window: 
function Artemis:ShowDataWindow()
	ArtemisMainDataFrame:Show()
  ArtemisMainDataFrameButtonFrame:Show()
  
  Artemis:SetupMCFrame()  
  ArtemisMainDataFrameMCFrame:Show()  
end

-- Hide the Stable window: 
function Artemis:HideDataWindow()
	ArtemisMainDataFrame:Hide()
  ArtemisMainDataFrameButtonFrame:Hide()
  ArtemisMainDataFrameMCFrame:Hide()
end

--GUI close button clicked
function Artemis:BtnCloseDataFrame()
	Artemis:HideDataWindow()
end

-- Called after ADDON_LOADED via the Stable frame, event framework
function Artemis:InitDataWindow()
end

-- Called via Stable frame: update 
function Artemis:OnUpdateDataFrame()  
  --Artemis.DebugMsg("OnUpdate: Called")
  --TODO How often is this called?
end

-- Stable frame : Event framework
function Artemis:OnEventDataFrame(event, ...)
  Artemis.PrintMsg("OnEventDataFrame: Called")
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisMainDataFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED (DataFrame)")
		--ArtemisMainDataFrame:UnregisterEvent("ADDON_LOADED")
		--Artemis:InitAddon()
  elseif event == "PLAYER_LOGOUT" then
    Artemis:OnUnLoadDataFrame()
	elseif event == "PET_STABLE_SHOW" then
    --Artemis:DoStableMasterEvent()
  else
    --TODO How often is this called?
    --Artemis:LoadAmmoCount()
  end
end

-- Unregister Stable Frame events: via PLAYER_LOGOUT and /artemis enable off
function Artemis:OnUnLoadDataFrame()
end

-- Called via Stable frame: load 
function Artemis:OnLoadDataFrame()
  Artemis.DebugMsg("OnLoadDataFrame: Called")
  --ArtemisMainDataFrame:RegisterForDrag("LeftButton");  -- DRAG
  -- Initalize options
  --
	--print("v"..Artemis.version.." loaded")
end

--
function Artemis:OnDragStartDataFrame()
  --Artemis.DebugMsg("OnDragStartDataFrame: Called")  
	ArtemisMainDataFrame:StartMoving()
end
function Artemis:OnDragStopDataFrame()
  --Artemis.DebugMsg("OnDragStopDataFrame: Called")
	ArtemisMainDataFrame:StopMovingOrSizing()
	Artemis:SaveAnchorsDataFrame()
end
function Artemis:SaveAnchorsDataFrame()
  --Artemis.DebugMsg("SaveAnchors: Called")
	--ArtemisDBChar.X = ArtemisMainFrame:GetLeft()
	--ArtemisDBChar.Y = ArtemisMainFrame:GetTop()
	--ArtemisDBChar.Width = ArtemisMainFrame:GetWidth()
	--ArtemisDBChar.Height = ArtemisMainFrame:GetHeight()
end
-- Stable Frame window tooltip
function Artemis:ShowTooltipDataFrame(self,messageType)
  --
end
function Artemis:HideTooltipDataFrame(self)  
	--GameTooltip:Hide()
end

-- Called in Stable Frame when user clicked on Pet#1/2/3
function Artemis:ClickPet(petIndex)
  ArtemisMainDataFrameMCFrame_MyPetModel:ClearModel()
  if(ArtemisDBChar.stable==nil) then
    return
  end
  if( petIndex < #ArtemisDBChar.stable) then
    ClickStablePet(petIndex-1)
    SetPetStablePaperdoll(ArtemisMainDataFrameMCFrame_MyPetModel)
  else
    ArtemisMainDataFrameMCFrame_MyPetModel:ClearModel()
  end
end

-- Stable Frame Pet Icon tooltip
function Artemis:ShowTooltipPet(self,petIndex)
  local message = "Artemis"
  if( petIndex == nil) then
    petIndex = 1
  end
  if(ArtemisDBChar.stable==nil) then
    return
  end
  
  local petarr = ArtemisDBChar.stable[petIndex]   
  if(petarr==nil) then
    return
  end
   local name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)	
  if icon == nil then
    icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  end  
  name = Artemis:SetStringOrDefault(name,"No Pet")

  --local message = string.format("Pet %s Level: %s Family: %s Special: %s loyalty: %s happiness: %s petFoodList: %s", name, level, family, specialAbility, loyalty , happiness, petFoodList);
  
  GameTooltip:SetOwner(ArtemisMainDataFrameMCFrame, "ANCHOR_BOTTOM", 0,0	)
	GameTooltip:AddLine(string.format("Pet: %s\n",name)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Level: %s",level)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Family: %s",family)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Loyalty: %s",loyalty)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Happiness: %s",tostring(happiness) )  ,.8,.8,.8,1,false)
  
  local petFoodString = ""
  if( petFoodList ~= nil and petFoodList ~= "" ) then
    for i,v in pairs(petFoodList) do
        if (v ~= nil and v ~= "") then
            petFoodString = petFoodString .. string.lower(v) .. ", " 
        end
    end
  elseif( petFoodList ~= nil ) then
    petFoodString = petFoodList
  end
  GameTooltip:AddLine(string.format("PetFoodList: %s",tostring(petFoodString))  ,.8,.8,.8,1,false)

	GameTooltip:Show()
end
function Artemis:HideTooltipPet()
	GameTooltip:Hide()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- Called when showing the Stable window: via ShowDataWindow
function Artemis:SetupMCFrame()
	Artemis.DebugMsg("SetupMCFrame Called")
  
  -- Check that data is initialized
  -- Current Pet is, stable[ONE], or api[ZERO]
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    if( ArtemisDBChar.stable == nil) then 
      ArtemisDBChar.stable = {}
    end
  end
  
  -- If has pets, show pets icon pictures
  Artemis:ScanCurrentPet()
  local name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp 
   
  -- ONE
  icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  name = nil
  if(ArtemisDBChar.stable~=nil and #ArtemisDBChar.stable > 0) then
    local petarr = ArtemisDBChar.stable[1]
    name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp = Artemis:ParsePetArray(petarr)
    if icon == nil then
      icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
    end
    if name == nil then
      Artemis.DebugMsg("ScanCurrentPet: cant find current pet ")
    end
    name = Artemis:SetStringOrDefault(name,"No Pet")
    --Artemis.DebugMsg("ScanCurrentPet: icon = ".. tostring(icon) )
    --ArtemisMainDataFrameMCFrame_MyCurrentPet:SetMouseOverTexture(icon)
    ArtemisMainDataFrameMCFrame_MyCurrentPet:SetNormalTexture(icon)
  end
  
  -- TWO
  icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  name = nil
  if(ArtemisDBChar.stable~=nil and #ArtemisDBChar.stable > 1) then
    petarr = ArtemisDBChar.stable[2] 
    name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp = Artemis:ParsePetArray(petarr)
  end
  if icon == nil then
    icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  end
	if name == nil then
		Artemis.DebugMsg("SetupMCFrame: cant find current pet ")
  end
  name = Artemis:SetStringOrDefault(name,"No Pet")
  ArtemisMainDataFrameMCFrame_MyStabledPet1:SetNormalTexture(icon)
  
  -- THREE
  icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  name = nil
  if(ArtemisDBChar.stable~=nil and #ArtemisDBChar.stable > 2) then
    petarr = ArtemisDBChar.stable[3]
    name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp = Artemis:ParsePetArray(petarr)
  end
  if icon == nil then
    icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  end
	if name == nil then
		Artemis.DebugMsg("SetupMCFrame: cant find current pet ")
  end
  name = Artemis:SetStringOrDefault(name,"No Pet")
  ArtemisMainDataFrameMCFrame_MyStabledPet2:SetNormalTexture(icon)
  
  -- Clear the model
  ArtemisMainDataFrameMCFrame_MyPetModel:ClearModel()
  --
	Artemis.DebugMsg("SetupMCFrame Done")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
--Pet Skills Search UI  (ArtemisPetSearchFrame)
-------------------------------------------------------------------------
-- Show (or hide) the PetSkills window display
function Artemis:ShowHidePetSkillsWindow()
	if ArtemisPetSearchFrame == nil then 
		Artemis:SetupPetSkillsWindow()
    Artemis:ShowPetSkillsWindow()
	else
    if (ArtemisPetSearchFrame:IsShown()) then 
      Artemis:HidePetSkillsWindow()
    else
      Artemis:SetupPetSkillsFrame()
      Artemis:ShowPetSkillsWindow()
		end
	end
end

-- Called the first time showhide is called, or after OnUnLoad() is called
function Artemis:SetupPetSkillsWindow() 
	Artemis.PrintMsg("SetupPetSkillsWindow Called")
  
 	Artemis.PrintMsg("SetupPetSkillsWindow Done")
end

-- Show the PetSkills window: 
function Artemis:ShowPetSkillsWindow()
	ArtemisPetSearchFrame:Show()
  --ArtemisMainDataFrameButtonFrame:Show()
  
  --Artemis:SetupMCFrame()  
  ArtemisPetSearchFrameButtonFrame:Show()
  ArtemisPetSearchFrameLeftSideFrame:Show()
  Artemis:ShowPetSearchAbilityButtons(true)
  
  ArtemisPetSearchFrameMainDataFrame:Show()
  ArtemisPetSearchFrameMainDataFrameEditBox:Show()
end

-- Hide the PetSkills window: 
function Artemis:HidePetSkillsWindow()
	ArtemisPetSearchFrame:Hide()
  --ArtemisMainDataFrameButtonFrame:Hide()
  
  ArtemisPetSearchFrameButtonFrame:Hide()
  ArtemisPetSearchFrameLeftSideFrame:Hide()
  
  Artemis:ShowPetSearchAbilityButtons(false)
  
  ArtemisPetSearchFrameMainDataFrame:Hide()
  ArtemisPetSearchFrameMainDataFrameEditBox:Hide()
end

--GUI close button clicked for PetSkills window
function Artemis:BtnClosePetSkillsFrame()
	Artemis:HidePetSkillsWindow()
end

-- Called after ADDON_LOADED via the PetSkills frame, event framework
function Artemis:InitPetSkillsWindow()
	Artemis.PrintMsg("InitPetSkillsWindow Called")
  
  -- ArtemisPetSearchFrameLeftSideFrame
  -- Default first one
  
  -- Fill in the dropdown with all ranks
  -- Artemis.Abilities_Base ("trainer" and "MaxLevel")
  -- Default first one
  
  -- Allow picking of ability and rank
  --   
end

-- Called via PetSkills frame: update 
function Artemis:OnUpdatePetSkillsFrame()  
  --
end

-- PetSkills frame : Event framework
function Artemis:OnEventPetSkillsFrame(event, ...)
  Artemis.PrintMsg("OnEventPetSkillsFrame: Called")
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisPetSearchFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED (ArtemisPetSearchFrame)")
		Artemis:InitPetSkillsWindow()
  elseif event == "PLAYER_LOGOUT" then
    Artemis:OnUnLoadPetSkillsFrame()
  else
    --
  end
end

-- Unregister PetSkills Frame events: via PLAYER_LOGOUT and /artemis enable off
function Artemis:OnUnLoadPetSkillsFrame()
  --
end

-- Called via PetSkills frame: load 
function Artemis:OnLoadPetSkillsFrame()
  Artemis.DebugMsg("OnLoadPetSkillsFrame: Called")
end
--
function Artemis:ShowTooltipPetSkillsSearch(self)
  --
end
function Artemis:HideTooltipPetSkillsSearch(self)
	--GameTooltip:Hide()
end
--
function Artemis:OnDragStartPetSkillsFrame()
	ArtemisPetSearchFrame:StartMoving()
end
function Artemis:OnDragStopPetSkillsFrame()
	ArtemisPetSearchFrame:StopMovingOrSizing()
	Artemis:SaveAnchorsPetSkillsFrame()
end
function Artemis:SaveAnchorsPetSkillsFrame()
  --
end
function Artemis:BtnStartSizeingPetSkillsSearch()
  ArtemisPetSearchFrame:StartSizing()		
end
function Artemis:BtnStopSizeingPetSkillsSearch()
  --Artemis.DebugMsg("BtnStopSizeing: Called")
	ArtemisPetSearchFrame:StopMovingOrSizing()
	--Artemis:ResizeGui()
	--Artemis:SaveAnchors()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- Called when showing the PetSkills window: via ShowPetSkillsWindow
function Artemis:SetupPetSkillsFrame()
	Artemis.DebugMsg("SetupPetSkillsFrame Called")   
 
 
 --if( ArtemisPetSearchFrameLeftSideFrame.abilityButtonList ~= nil ) then
  --  return
  --end
  --
  ArtemisPetSearchFrameLeftSideFrame:Show()

  --
  if( Artemis.view.firstSetup == nil or not Artemis.view.firstSetup) then
    tinsert( UISpecialFrames, ArtemisPetSearchFrame:GetName() )  
    ArtemisPetSearchFrameLeftSideFrame.abilityList = {}
    --[[
    local parent     = ArtemisPetSearchFrameLeftSideFrame
    local relativeTo = ArtemisPetSearchFrameLeftSideFrame
    local fontString = nil
    for i,v in pairs(Artemis.Ability_Base_List) do
      --ArtemisPetSearchFrameLeftSideFrame
      fontString = ArtemisPetSearchFrameLeftSideFrame:CreateFontString("ability"..tostring(i), "ARTWORK", "GameFontHighlightSmall")
      fontString:SetText(v)
        -- [name [, layer [, inheritsFrom ] ] ] )
      if( parent == relativeTo ) then
        fontString:SetPoint("TOPLEFT", relativeTo, "TOPLEFT", 10, offset)
      else
        fontString:SetPoint("TOPLEFT", relativeTo, "BOTTOMLEFT", 0, offset)
      end
      --fontString:SetSize(110 , 20) -- width, height
      table.insert( ArtemisPetSearchFrameLeftSideFrame.abilityList, fontString )
      --offset = offset + 50
      relativeTo = fontString
      Artemis.DebugMsg("SetupPetSkillsFrame Btn = " ..tostring(v) .. " i = " ..tostring(i))
    end
    --]]
    Artemis.view.firstSetup = true
  end -- first time
  
  
  --[[
  -- List all abilities:
  -- Artemis.Ability_Base_List/Artemis.Abilities_Base
  ArtemisPetSearchFrameLeftSideFrame.abilityButtonList = {}
   
  local offset = 0
  local parent     = ArtemisPetSearchFrameLeftSideFrame
  local relativeTo = ArtemisPetSearchFrameLeftSideFrame
  local button = nil
  --local button = nil
  for i,v in pairs(Artemis.Ability_Base_List) do
    button = CreateFrame("Button", "btn"..i, parent, "UIPanelButtonTemplate" )-- AbilityBaseSlotTemplate )
    if( parent == relativeTo ) then
      button:SetPoint("TOPLEFT", relativeTo, "TOPLEFT", 10, offset)
    else
      button:SetPoint("TOPLEFT", relativeTo, "BOTTOMLEFT", 0, offset)
    end
    button:SetFrameStrata("HIGH")
    --button:SetWidth(80)
    --button:SetHeight(30)
    button:SetSize(110 , 20) -- width, height
    button:SetText(v)
    button:Show()
    table.insert( ArtemisPetSearchFrameLeftSideFrame.abilityButtonList, button )
    --offset = offset + 50
    relativeTo = button
    Artemis.DebugMsg("SetupPetSkillsFrame Btn = " ..tostring(v) .. " i = " ..tostring(i))
  end
  --]]
  
	Artemis.DebugMsg("SetupPetSkillsFrame Done")
end

function Artemis:OnPetSkillsAbilityValueChanged(value, userInput)  
	Artemis.PrintMsg("OnPetSkillsAbilityValueChanged Called")
  Artemis.PrintMsg("OnPetSkillsAbilityValueChanged Done")
end

--https://wow.gamepedia.com/Making_a_scrollable_list_using_FauxScrollFrameTemplate
function Artemis.PetSkillsAbilityScrollBar_Update()
  --FauxScrollFrame_Update(ArtemisPetSearchFrameLeftSideFrame,50,5,16);
  -- 50 is max entries, 5 is number of lines, 16 is pixel height of each line
  --Artemis.PrintMsg("PetSkillsAbilityScrollBar_Update called")
  if(Artemis.view.MyModData == nil) then
    Artemis.PrintMsg("PetSkillsAbilityScrollBar_Update create moddata")
    Artemis.view.MyModData = {}
    
    for i,v in pairs(Artemis.Ability_Base_List) do
      Artemis.view.MyModData[i] = v
    end
    --for i=1,50 do
    --  Artemis.view.MyModData[i] = "Test ".. tostring(i) -- math.random(100)
    --end
  end
  
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  FauxScrollFrame_Update(ArtemisPetSearchFrameLeftSideFrame,50,5,16);
  --Artemis.PrintMsg("PetSkillsAbilityScrollBar_Update reset data")
  for line=1,10 do
    lineplusoffset = line + FauxScrollFrame_GetOffset(ArtemisPetSearchFrameLeftSideFrame);
    if lineplusoffset <= #Artemis.Ability_Base_List then
      getglobal("MyModEntry"..line):SetText(Artemis.view.MyModData[lineplusoffset]);
      getglobal("MyModEntry"..line).moddata = Artemis.view.MyModData[lineplusoffset]
      getglobal("MyModEntry"..line):Show();
    else
      getglobal("MyModEntry"..line):Hide();
    end
  end
 end
 

--used??
function Artemis:ShowPetSearchAbilityButtons(enabled)
	Artemis.DebugMsg("ShowPetSearchAbilityButtons Called: enabled=".. tostring(enabled) )
  
  --[[
  if(ArtemisPetSearchFrameLeftSideFrame.abilityButtonList==nil) then
    Artemis.DebugMsg("ShowPetSearchAbilityButtons no buttons to show")
    return
  end
  for i,v in pairs(ArtemisPetSearchFrameLeftSideFrame.abilityButtonList) do
    if(enabled) then
      Artemis.DebugMsg("ShowPetSearchAbilityButtons showing: v=".. tostring(v) )
      v:Show()
    else
      Artemis.DebugMsg("ShowPetSearchAbilityButtons hiding: v=".. tostring(v) )
      v:Hide()
    end
  end
  --]]
end

--used??
function Artemis:PetSkillsAbilityButtonClicked(index)
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: Called");
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: data: " .. tostring(self.moddata) )
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: idx: " .. tostring(index) )  
  local lineoffset = FauxScrollFrame_GetOffset(ArtemisPetSearchFrameLeftSideFrame)
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: off1: " .. tostring(lineoffset) )
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: off2: " .. tostring(lineoffset+index) )  
  --Artemis.PrintMsg("PetSkillsAbilityButtonClicked: text: " .. tostring(Artemis.view.MyModData[lineoffset+index]) )
  local kData = Artemis.view.MyModData[ lineoffset+index ]
  
  Artemis.view.selectPetAbility = kData;
  
  --local dropdown = CreateFrame("Frame", "Test_DropDown", UIParent, "UIDropDownMenuTemplate");
  --UIDropDownMenu_Initialize(dropdown, Artemis.PetSkills_DropDown_Initialize, "MENU");
  --ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
  ToggleDropDownMenu(1, nil, MyDropDownMenu, "ArtemisPetSearchFrameButtonFrame", 0, 0);

end

function Artemis.PetSkillsAbilityDropdown_OnLoad()
  Artemis.PrintMsg("PetSkillsAbilityDropdown_OnLoad Called")
  Artemis.PrintMsg("PetSkillsAbilityDropdown_OnLoad kData=" .. tostring(Artemis.view.selectPetAbility) )
  
  local abilitySel = Artemis.Abilities_Base[Artemis.view.selectPetAbility]
  if(abilitySel==nil) then
    return
  end
  
  local abMax = abilitySel["MaxLevel"]
  local nMax = tonumber(abMax)
  for index=1, nMax do
    --
    info            = {};
    info.text       = index -- "This is an option in the menu.";
    info.value      = index -- "OptionVariable";
    info.func       =  Artemis.PetSkillsAbilityDropdown_OnClick 
             -- can also be done as function() FunctionCalledWhenOptionIsClicked() end;
    -- Add the above information to the options menu as a button.
    UIDropDownMenu_AddButton(info);
    --
  end
end


function Artemis.PetSkillsAbilityDropdown_OnClick(indexData)
    Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick called")
    --indexData=" .. tostring(indexData) )
    --[[for i,v in pairs(indexData) do
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick i=" .. tostring(i) )
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick v=" .. tostring(v) )
    end --]]--   
    if(indexData~=nil) then
      local selectedNum = indexData.value
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick selectedNum=" .. tostring(selectedNum) )
      local abilitySel = Artemis.Abilities_Base[Artemis.view.selectPetAbility]
      local abMax = abilitySel["MaxLevel"]
      local nMax = tonumber(abMax)
      local abTrain = abilitySel["trainer"]
       
      local abilityFamily = Artemis.AbilityFamily [Artemis.view.selectPetAbility]
      --abilityFamily["trainer"]
      --abilityFamily["CanLearnText"]
      --abilityFamily["CanLearnList"] 
      --abilityFamily["Text"]  
      --abilityFamily["Text_P"]
  
      local nameNew = Artemis.view.selectPetAbility .. " " .. tostring(selectedNum)
      Artemis.view.selectPetAbilityDetail = nameNew
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick nameNew=" .. tostring(nameNew) )
      local abilityDetails = Artemis.Abilities [nameNew]
      --abilityDetails["trainer"]
      --abilityDetails["MinPetLevel"] 
      --abilityDetails["CostTP"] 
      --abilityDetails["Params"] 
      --abilityDetails["Text"] 
      --abilityDetails["AbilityFamily"]
      --abilityDetails["AbilityLevel"] 
      
      ArtemisPetSearchFrameMainDataFrameEditBox:SetText( abilityDetails["Text"] ) 
      
    end
    
end


-------------------------------------------------------------------------
-------------------------------------------------------------------------



-------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------
function Artemis:ShowHelp()
  print("---===ARTEMIS====---")
  print( L["Addon_Desc"] )
  print("/artemis <gui/debug/printabilities/printability <name>" )
  print("/artemis <options> <enable> <on/off>" )
end

--Commands, help/debug/beta/testdata/deltestdata
function Artemis.SlashCommandHandler(msg)  
	Artemis.DebugMsg("SlashCommandHandler: " .. tostring(msg) )
  --Parse command
  local options = {}
  if( msg ~= nil and msg ~= "" ) then    
    local searchResult = { string.match(msg,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
      if (v ~= nil and v ~= "") then
          options[i] = string.lower(v)
          Artemis.DebugMsg("SlashCommandHandler: options = " .. string.lower(v) )
      end
    end
  end
  Artemis.DebugMsg("SlashCommandHandler: ArtemisDBChar.enable = " .. tostring(ArtemisDBChar.enable) )

  if #options == 0 then
    Artemis:ShowHelp()
  elseif options[1] == "help" then
    Artemis:ShowHelp()
  elseif options[1] == "debug" then
    Artemis.view.debug = not Artemis.view.debug
    Artemis.DebugMsg("Debug = " .. tostring(Artemis.view.debug) )
    ArtemisDBChar.debug = Artemis.view.debug
  elseif options[1] == "options" then
    -- TODO Show Options
	elseif options[1] == "gui" then    
    Artemis:ShowHide()
  elseif options[1] == "printabilities" or options[1] == "1" then
    Artemis:GetAbilitiesBase() 
  elseif options[1] == "printability"   or options[1] == "2" then
    if(#options == 2) then
      Artemis:GetAbilitiesBaseList(options[2]) 
    else
      Artemis:GetAbilitiesBase() 
    end
  elseif options[1] == "petskills" then  
    Artemis:ShowHidePetSkillsWindow()
  elseif options[1] == "searchabilities" then
    Artemis:SearchAbilities(options[2]) --,options[3])--,maxLvl)
  elseif (options[1] == "options" and #options == 3) then
    Artemis:DoOptionsSetUnset(options[2],options[3])
  else
    Artemis:ShowHelp()
  end
end

SlashCmdList["Artemis"] = function(msg)
              Artemis.SlashCommandHandler(msg);
            end
SLASH_Artemis1 = "/artemis"
SLASH_Artemis2 = "/artemes"
-------------------------------------------------------------------------
-------------------------------------------------------------------------



-------------------------------------------------------------------------
-- ADDON Methods
-------------------------------------------------------------------------
function Artemis:BtnSettings()
	--Options:Open()	
end
function Artemis:ToggleOptions()
	--Options:Open()
end
function Artemis:ToggleStable()
  Artemis:ShowHideDataWindow()
end

-- Slash command handle OPTIONS
function Artemis:DoOptionsSetUnset(optionName,optionValue)
    if(optionName==nil or optionValue==nil) then
      return
    end
    if(optionValue~="on" or optionValue~="off") then
      return
    end
    if(optionName=="enable" and optionValue=="off") then
      ArtemisDBChar.enable = false
      Artemis.OnUnLoad()
    elseif(optionName=="enable" and optionValue=="on") then
      ArtemisDBChar.enable = true
    elseif(optionName=="xxx") then
      
    end
    
    if(not ArtemisDBChar.enable) then
      ArtemisDBChar.debug = false
    end
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------



-------------------------------------------------------------------------
-- Helper function to setup and view AMMO DATA, ammoslot/rangedslot
-------------------------------------------------------------------------
function Artemis:LoadAmmoCount()
  -- Get DATA
  local slotId, textureName  = GetInventorySlotInfo("AmmoSlot");  
  Artemis.view.ammoSlot = slotId
  local itemId = GetInventoryItemID("unit", invSlot);
  Artemis.view.ammoItemId = itemId
  Artemis.view.ammoCount = tonumber(GetInventoryItemCount("player", Artemis.view.ammoSlot ));
  --  
  Artemis.view.rangedSlot  = GetInventorySlotInfo("RangedSlot");
  local currDur, maxDur = GetInventoryItemDurability( Artemis.view.rangedSlot );
  Artemis.view.rangedDurCurr = currDur
  Artemis.view.rangedDurMax  = maxDur
  --  0 normal (6+), 1 yellow (5-1), 2 broken (0)
  Artemis.view.rangedDurStatus = GetInventoryAlertStatus( Artemis.view.rangedSlot );
  
  -- Set TEXT
  textAmmoCount:SetText( Artemis.view.ammoCount )
  if( Artemis.view.rangedDurCurr ~= nil and Artemis.view.rangedDurMax ~= nil) then
    textWpnDur:SetText(    Artemis.view.rangedDurCurr .. "/" .. Artemis.view.rangedDurMax )    
    if(Artemis.view.rangedDurStatus==0) then
      textWpnDur:SetTextColor(0,255,0) -- green
    elseif(Artemis.view.rangedDurStatus==1) then
      textWpnDur:SetTextColor(0,125,125) -- yellow
    elseif(Artemis.view.rangedDurStatus==2) then
      textWpnDur:SetTextColor(255,0,0) -- borken
    else
      textWpnDur:SetTextColor(0,255,0) -- green
    end
  else
    textWpnDur:SetText( "n/a" )    
    textWpnDur:SetTextColor(0,255,0);
  end
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------



-------------------------------------------------------------------------
-- Helper function to setup and view AMMO DATA, STABLE/STABLE DATA/PET
-------------------------------------------------------------------------
--
function Artemis:ResetStable()
  ArtemisDBChar.stable = {}		
end

--Update stored stable data, called from Main Frame events, PET_STABLE_SHOW and PET_STABLE_UPDATE
function Artemis:DoStableMasterEvent()
	Artemis.PrintMsg(L["StableOpenMessage"])
  
  local localizedClass, englishClass = UnitClass("player");
  Artemis.DebugMsg("ShowStable englishClass: " .. englishClass .. "'" )
  if englishClass == 'HUNTER' then
    --If has one pet... scan the others
    local icon, name, level, family, loyalty = GetStablePetInfo(1)
    Artemis.DebugMsg("DoStableOpened name: " .. tostring(name) .. "' family: '" ..tostring(family).. "'" )
    if icon == nil and name == nil and family == nil then
      Artemis:ResetStable()
      Artemis.PrintMsg(L["StableNoPets"] )
    else 
      -- Loop through all pets in the Stable and store them
      Artemis:ScanStable()
    end
  else
    Artemis.PrintMsg(L["StableNotAHunterMessage"])
  end
end

-- Update stored stable data, for CURRENT PET
function Artemis:ScanCurrentPet()
  Artemis.DebugMsg("ScanCurrentPet: Called")
  -- If is a hunter, and the PET is out/alive, get current data, else don't.
  --TODO dead pet??
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    Artemis.DebugMsg("ScanCurrentPet: scanning...")
    Artemis:ScanPetAtIndex(0)
 -- Current Pet is, stable[ONE], or api[ZERO]
    local petarr = ArtemisDBChar.stable[1]
    --TODO rate is a number, translate to words
    local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
    local currXP, nextXP = GetPetExperience()
    local petFoodList = { GetPetFoodTypes() };
    --
    -- { name, family, level, icon, loyalty, happiness, petFoodList, currXP, nextXP }
    local petarr2 =  { petarr[1], petarr[2], petarr[3], petarr[4], petarr[5], happiness, petFoodList, currXP, nextXP }   
    ArtemisDBChar.stable[1] = petarr2
    Artemis.DebugMsg("ScanCurrentPet: Done")
    return petarr2
  end
  Artemis.DebugMsg("ScanCurrentPet: Done")
  return nil
end

--Check API for stabled pet data, and store stable data
-- { name, family, level, icon, loyalty, happiness, petFoodList, currXP, nextXP }
function Artemis:ScanPetAtIndex(index)
  --
  local icon, name, level, family, loyalty = GetStablePetInfo(index)
  --icon =  Artemis:SetStringOrDefault(icon,"")
  name =  Artemis:SetStringOrDefault(name,"")
  level =  Artemis:SetStringOrDefault(level,"")
  family =  Artemis:SetStringOrDefault(family,"")
  loyalty =  Artemis:SetStringOrDefault(loyalty,"")
  happiness =  Artemis:SetStringOrDefault(happiness,"")
  --petFoodList =  Artemis:SetStringOrDefault(petFoodList,"") (NOTE: Can only get for current pet?)
  Artemis.DebugMsg("ScanPetAtIndex, index = " .. index .." icon=" .. tostring(icon) .. " name="..name.." level="..level.." family=" .. family.. " loyalty="..loyalty .. " happiness="..happiness)
  
  local petarr = {}
  petarr =  { name, family, level, icon, loyalty, happiness, petFoodList, nil, nil }
  -- Current Pet is, stable[ONE], or api[ZERO]
  ArtemisDBChar.stable[index+1] =  petarr
  return petarr
end

-- The main function that loops through all pets in the Stable and stores them for viewing later
function Artemis:ScanStable()
  Artemis.DebugMsg("ScanStable: Called");
 	haveFilled = 0
	petnumidx  = 1
	ArtemisDBChar.stable = {}
  
  -- Current Pet is, stable[ONE], or api[ZERO]
  local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
  local currXP, nextXP = GetPetExperience()
  local petFoodList = { GetPetFoodTypes() };

  -- Scan all Pets
	for index=0, Artemis.view.maxPets-1 do		
    Artemis:ScanPetAtIndex(index)
    -- { name, family, level, icon, loyalty, happiness, petFoodList, currXP, nextXP }
    local petarr = ArtemisDBChar.stable[index+1]
    
    petnumidx = petnumidx +1
		if petarr ~= nil and petarr[1] and petarr[1] ~= "" then		
			haveFilled = haveFilled +1
		end
	end --for
	--Artemis.PrintMsg("Stored: num pets: " .. petnumidx)
  Artemis.PrintMsg( string.format( L["StableNumPetsMessage"] , haveFilled ) );
  -- Artemis.PrintMsg( "You have " .. haveFilled .. " pets." )
	ArtemisDBChar.stable_petnumidx  = petnumidx
	ArtemisDBChar.stable_havefilled = haveFilled
	ArtemisDBChar.stable_lasttime   = date("%B %m %Y %H:%M:%S")
  Artemis.DebugMsg("ScanStable: Done");
end 

-- Output an array data to the CONSOLE
function Artemis:printPet(petarr,index)
  -- { name, family, level, icon, loyalty, happiness, petFoodList, currXP, nextXP }
  local name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)

	if name == nil then
		Artemis.PrintMsg( string.format( L["PrintPet_CantPrintNum"] , index ) )
	else 
		if family == nil then
			Artemis.DebugMsg("PrintPet: " .. name .. " has a null family?? Is that an error?")
		else
			--miscinfo       =  StableSnapshot:GetPetTypeInfo(family)
			--defaultSpec    =  StableSnapshot:GetPetDefaultSpec(family)	
      --specialAbility =  StableSnapshot:GetPetSpecialAbility(family)
			Artemis.DebugMsg("PrintPet: " .. name .. " is a --> " ..family.. " loyalty=" .. loyalty) 
		end
	end
end

-- Slash Command line function to print stable data
function Artemis:ShowStable()
	Artemis.DebugMsg("ShowStable Called")
	maxNum = ArtemisDBChar.stable_petnumidx
  --
	if maxNum == nil then
		Artemis.PrintMsg( L["ShowStable_NoneSaved"] )
		--playerUnitId = UnitId("player")
		localizedClass, englishClass = UnitClass("player");
		Artemis.DebugMsg("ShowStable englishClass: " .. englishClass .. "'" )
		if englishClass == 'HUNTER' then
			Artemis.PrintMsg( L["ShowStable_NoneSaved_Hunter"] )
		end
	else 
		Artemis.PrintMsg( string.format( L["ShowStable_MaxNum"] ,maxNum) )	
		
		petarrAll = ArtemisDBChar.stable
		if petarrAll == nil then
			Artemis.PrintMsg( L["ShowStable_NoPets"] )
		else 	
			for index=1, maxNum-1 do				
				petarr = ArtemisDBChar.stable[index] 
				if petarr == nil then
					Artemis.DebugMsg("ShowStable: can't print pet: " .. index )
				else 
					Artemis:printPet(petarr,index)
				end
			end
		end
	end
	Artemis.DebugMsg("ShowStable Done")
end

-- name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp
function Artemis:ParsePetArray(petarr) 
	name   = ""
	family = ""
	level  = "" --TODO num?
	icon   = nil
	loyalty     = "";
  happiness   = ""; --TODO num?
  petFoodList = "";
  currexp = ""; --TODO num?
  nextexp = ""; --TODO num?
  
	for index,value in ipairs(petarr) do 
		--Artemis.PrintMsg( tostring(index) .. " : " .. value )
		if index == 1 then
			name = value
		end
		if index == 2 then
			family = value
		end
		if index == 3 then
			level = value
		end
		if index == 4 then
			icon = value
		end
		if index == 5 then
			loyalty = value
		end
		if index == 6 then
			happiness = value
		end
		if index == 7 then
			petFoodList = value
		end
    if index == 8 then
			currexp = value
		end
    if index == 9 then
			nextexp = value
		end    
	end
	miscinfo = L["PetFamilies_Unknown"]
	--miscinfo       =  StableSnapshot:GetPetTypeInfo(family)
	--defaultSpec    =  Artemis:GetPetDefaultSpec(family)	
	--specialAbility =  Artemis:GetPetSpecialAbility(family)
	if loyalty == nil then
		loyalty = "000"
	else
		loyalty = "<" .. loyalty .. ">"
	end
	return name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp
end

-- 
function Artemis:UpdatePetHappiness()
  if(UnitExists("pet")) then
    Artemis.DebugMsg("UpdatePetHappiness Called w/pet")
    
    local hasUI, isHunterPet = HasPetUI();
    --Artemis.PrintMsg("UpdatePetHappiness hasUI=".. tostring(hasUI) )
    --Artemis.PrintMsg("UpdatePetHappiness isHunterPet=".. tostring(isHunterPet) )
    -- If user is a hunter and pet is alive and out/with a name, update happiness data, else, do NOTHING
    if( hasUI and isHunterPet ) then
      Artemis:ScanCurrentPet()
      local icon, name, level, family, loyalty       = GetStablePetInfo(1)
      if(name~=nil) then
        local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
        local happy = ({"Unhappy", "Content", "Happy"})[happiness]
        local hText = "Unknown"
        textPetHappiness:SetTextColor(0,255,0) -- green
        if(happy~=nil) then
          hText = string.format("Pet is... %s", happy)
          if(happiness==1) then
            textPetHappiness:SetTextColor(125,125,125) 
          elseif(happiness==2) then
            textPetHappiness:SetTextColor(0,125,125) --yellow
          elseif(happiness==3) then
            textPetHappiness:SetTextColor(0,255,0) --green
          else
            textPetHappiness:SetTextColor(0,125,125)--yellow
          end
        else
          hText = string.format("Pet is... %s", "Uknown?") --TODO check this shows,,,when?
        end
        textPetHappiness:SetText(hText)
      end
      -- Show happy frame since updated, if not shown
      if ( not ArtemisMainFrame_HappinessFrame:IsShown()) then 
        ArtemisMainFrame_HappinessFrame:Show()
      end
    else
      --TODO reset data?
    end-- has pet
  end --Pet is alive
end

-- Called on event: UNIT_PET 
function Artemis:CheckPetChanged()
  if(UnitExists("pet")) then
    Artemis.DebugMsg("CheckPetChanged Called w/pet")
    local newGUID = UnitGUID("pet")
    if(Artemis.view.PET_GUID == nil) then
      Artemis.view.PET_GUID = newGUID
    end
    if( newGUID ~= Artemis.view.PET_GUID) then
      Artemis:PetChangedCallback(newGUID)
    end
  end
end
  
-- Called when pet data seems to be updated
function Artemis:PetChangedCallback(newGUID)
	Artemis.PrintMsg("PetChangedCallback Called")
  Artemis.PrintMsg("PetChangedCallback  Artemis.view.PET_GUID= " .. tostring(Artemis.view.PET_GUID) )
  Artemis.PrintMsg("PetChangedCallback newGUID= " .. tostring(newGUID) )
  Artemis.viewPET_GUID = newGUID
  
  Artemis.PrintMsg( L["PetUnitChanged"] )
  Artemis:ScanCurrentPet()
  -- update view?
  -- re-show view?
	Artemis.DebugMsg("PetChangedCallback Done")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- ARTEMIS EOF
-------------------------------------------------------------------------