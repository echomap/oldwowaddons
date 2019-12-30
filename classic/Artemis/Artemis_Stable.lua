--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Stable Utils
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stable Gui Setup
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Stable GUI Methods
-------------------------------------------------------------------------


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
    --Artemis:DoStableMasterShowEvent()
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

  --Artemis.OptionInit()
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
  Artemis.DebugMsg( "==> petIndex: " .. '(' .. tostring(petIndex) .. ')' ) 
  Artemis.DebugMsg( "==> #ArtemisDBChar.stable: " .. '(' .. tostring(#ArtemisDBChar.stable) .. ')' ) 
  if( petIndex <= #ArtemisDBChar.stable) then
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

  if( petFoodList==nil or #petFoodList<1 and family~=nil and Artemis.petfamily[family]~=nil) then
    Artemis.DebugMsg("ScanPetAtIndex getting foodlist from data, family=".. tostring(family))
    petFoodList = Artemis.petfamily[family]["PetFoodType"]
  end

  --local message = string.format("Pet %s Level: %s Family: %s Special: %s loyalty: %s happiness: %s petFoodList: %s", name, level, family, specialAbility, loyalty , happiness, petFoodList);
  
  GameTooltip:SetOwner(ArtemisMainDataFrameMCFrame, "ANCHOR_BOTTOM", 0,0	)
	GameTooltip:AddLine(string.format("Pet: %s\n",name)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Level: %s",level)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Family: %s",family)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Loyalty: %s",loyalty)  ,.8,.8,.8,1,false)
  GameTooltip:AddLine(string.format("Happiness: %s",tostring(happiness) )  ,.8,.8,.8,1,false)
  
  local petFoodString = Artemis.toStringFoodList(petFoodList)
  Artemis.DebugMsg("ScanPetAtIndex foodListString=" .. tostring(foodListString) )

  GameTooltip:AddLine(string.format("PetFoodList: %s",tostring(petFoodString))  ,.8,.8,.8,1,false)

	GameTooltip:Show()
end
function Artemis:HideTooltipPet()
	GameTooltip:Hide()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------



