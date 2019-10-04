--[[
  * Artemis ***
  * Written by : echomap 
  *
	* Copyright (c) 2019 by Echomap	
	*
	* is distributed in the hope that it will be useful and perhaps entertaining,
	* but WITHOUT ANY WARRANTY
]]--
-------------------------------------------------------------------------
-------------------------------------------------------------------------
Artemis = {
    name            = "Artemis",	-- Matches folder and Manifest file names.
    displayName     = "Artemis Hunter Helper",
    version         = "1.0.0",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.    
    --menuName        = "Artemis_Options", -- Unique identifier for menu object.
    --menuDisplayName = "Artemis",
    view            = {
        debug = false,
        debuglvl = 1,
        maxPets  = 3,
    },
    --ArtemisDB/ArtemisDBChar
    --savedVariables  = {},
}
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

--Called the first time showhide is called
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
  ArtemisDBChar.enable = true --- uuuuu
end

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

-- really called from MAIN frame?
function Artemis:InitAddon()
  Artemis.DebugMsg("Init: Called")
  --uuu
end

function Artemis:OnUpdate()
  --Artemis.DebugMsg("OnUpdate: Called")
  if( not ArtemisDBChar.enable ) then
    return
  end
  --TODO How often is this called? too often probably?
  Artemis:LoadAmmoCount()
  Artemis:SetupDataWindow()
end

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
    --TODO check... values? arg1??
    Artemis.DebugMsg("OnEvent: arg1 = "..tostring(arg1) ) -- "pet"
    -- nil Artemis.DebugMsg("OnEvent: arg2 = "..tostring(arg2) )
    Artemis:UpdatePetHappiness()
  else
    --TODO How often is this called?
    --Artemis:LoadAmmoCount()
  end
end

function Artemis:OnUnLoad()
  Artemis.DebugMsg("OnUnLoad: Called")
  ArtemisMainFrame:UnregisterEvent("ADDON_LOADED")
  --ArtemisMainFrame:UnregisterEvent("LeftButton");  -- DRAG
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_SHOW")
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_UPDATE")
  ArtemisMainFrame:UnregisterEvent("UNIT_PET")
  ArtemisMainFrame:UnregisterEvent("UNIT_HAPPINESS")  
    
  Artemis.view.setupmain = false
  Artemis.DebugMsg("OnUnLoad: Done")
end

function Artemis:OnLoad()
  Artemis.DebugMsg("OnLoad: Called")
  
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
  
  --StableSnapshot:addSlideIcon() --create ldb launcher button
  
	--StableSnapshot:addSlideIcon() --create ldb launcher button
  if ArtemisDBChar.enable then
    Artemis:ShowWindow()    
    --Artemis:UpdatePetHappiness()
  end
  
  if( not ArtemisDBChar.enable ) then
    return
  end
  
  ArtemisMainFrame:RegisterEvent("ADDON_LOADED");  -- Fired when saved variables are loaded
  ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
  ArtemisMainFrame:RegisterForDrag("LeftButton");  -- DRAG
  
	ArtemisMainFrame:RegisterEvent("PET_STABLE_SHOW")
  ArtemisMainFrame:RegisterEvent("PET_STABLE_UPDATE")
  
  ArtemisMainFrame:RegisterUnitEvent("UNIT_PET","player")
  ArtemisMainFrame:RegisterUnitEvent("UNIT_HAPPINESS","pet")
  
	print("v"..Artemis.version.." loaded")
end

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



-------------------------------------------------------------------------
--Stable UI
-------------------------------------------------------------------------
function Artemis:InitDataWindow()
  --
end

function Artemis:SetupDataWindow() 
  --ArtemisMainFrame:SetScript("OnEscapePressed", function(self) Artemis:HideWindow() end)
  tinsert( UISpecialFrames, ArtemisMainDataFrame:GetName() )
end

function Artemis:ShowDataWindow()
	ArtemisMainDataFrame:Show()
  ArtemisMainDataFrameButtonFrame:Show()
  
  Artemis:SetupMCFrame()  
  ArtemisMainDataFrameMCFrame:Show()  
end

function Artemis:HideDataWindow()
	ArtemisMainDataFrame:Hide()
  ArtemisMainDataFrameButtonFrame:Hide()
  ArtemisMainDataFrameMCFrame:Hide()
end

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

function Artemis:BtnCloseDataFrame()
	Artemis:HideDataWindow()
end

--
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
function Artemis:OnUpdateDataFrame()  
  --Artemis.DebugMsg("OnUpdate: Called")
  --TODO How often is this called?
end

function Artemis:OnLoadDataFrame()
end

function Artemis:OnEventDataFrame(event, ...)
  --Artemis.DebugMsg("OnEventDataFrame: Called")
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisMainDataFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED (DataFrame)")
		--ArtemisMainDataFrame:UnregisterEvent("ADDON_LOADED")
		--Artemis:InitAddon()
  elseif event == "PLAYER_LOGOUT" then
    --
    --ArtemisMainDataFrame:UnregisterEvent("PET_STABLE_SHOW")
	elseif event == "PET_STABLE_SHOW" then
    --Artemis:DoStableMasterEvent()
  else
    --TODO How often is this called?
    --Artemis:LoadAmmoCount()
  end
end

function Artemis:OnLoadDataFrame()
  Artemis.DebugMsg("OnLoadDataFrame: Called")
  ArtemisMainDataFrame:RegisterForDrag("LeftButton");  -- DRAG
  -- Initalize options
  --
	--print("v"..Artemis.version.." loaded")
end

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

function Artemis:ShowTooltipDataFrame(self,messageType)
  --
end
function Artemis:HideTooltipDataFrame(self)  
	--GameTooltip:Hide()
end



-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------
function Artemis:ShowHelp()
  print("---===ARTEMIS====---")
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
-- TOOLTIP
-------------------------------------------------------------------------
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
--AMMO DATA
-------------------------------------------------------------------------
function Artemis:LoadAmmoCount()
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
--STABLE DATA
-------------------------------------------------------------------------
function Artemis:ResetStable()
  ArtemisDBChar.stable = {}		
end

function Artemis:DoStableMasterEvent()
	Artemis.PrintMsg("You have opened the stable!")
  
  local localizedClass, englishClass = UnitClass("player");
  Artemis.DebugMsg("ShowStable englishClass: " .. englishClass .. "'" )
  if englishClass == 'HUNTER' then
    --If has one pet... scan the others
    local icon, name, level, family, loyalty = GetStablePetInfo(1)
    Artemis.DebugMsg("DoStableOpened name: " .. tostring(name) .. "' family: '" ..tostring(family).. "'" )
    if icon == nil and name == nil and family == nil then
      Artemis:ResetStable()
      Artemis.PrintMsg("You have no pets at this time?")
    else 
      -- Loop through all pets in the Stable and store them
      Artemis:ScanStable()
    end
  else
    Artemis.PrintMsg("You are not a hunter and can't stable pets.")
  end
end

-- Finds data for CURRENT PET
function Artemis:ScanCurrentPet()
  Artemis.DebugMsg("ScanCurrentPet: Called")
 -- Current Pet is index ZERO  
 
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    Artemis.DebugMsg("ScanCurrentPet: scanning...")
    Artemis:ScanPetAtIndex(0)
    local petarr = ArtemisDBChar.stable[1]
    --
    local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
    local currXP, nextXP = GetPetExperience()
    local petFoodList = { GetPetFoodTypes() };
    --
    -- { name, family, level, icon, loyalty, happiness, petFoodList, currXP, nextXP }
    --TODO rate is a number, translate to words??
    local petarr2 =  { petarr[1], petarr[2], petarr[3], petarr[4], loyaltyRate, happiness, petFoodList, currXP, nextXP }   
    ArtemisDBChar.stable[1] = petarr2
    Artemis.DebugMsg("ScanCurrentPet: Done")
    return petarr2
  end
  Artemis.DebugMsg("ScanCurrentPet: Done")
end

--
function Artemis:ScanPetAtIndex(index)
  --
  local icon, name, level, family, loyalty = GetStablePetInfo(index)
  --icon =  Artemis:SetStringOrDefault(icon,"")
  name =  Artemis:SetStringOrDefault(name,"")
  level =  Artemis:SetStringOrDefault(level,"")
  family =  Artemis:SetStringOrDefault(family,"")
  loyalty =  Artemis:SetStringOrDefault(loyalty,"")
  happiness =  Artemis:SetStringOrDefault(happiness,"")
  --petFoodList =  Artemis:SetStringOrDefault(petFoodList,"")
    
    
  Artemis.DebugMsg("ScanPetAtIndex, index = " .. index .." icon=" .. tostring(icon) .. " name="..name.." level="..level.." family=" .. family.. " loyalty="..loyalty .. " happiness="..happiness)
  --.. " petFoodList="..tostring(petFoodList) )
  
  local petarr = {}
  petarr =  { name, family, level, icon, loyalty, happiness, petFoodList }
  ArtemisDBChar.stable[index+1] =  petarr
  --
end

-- The main function that loops through all pets in the Stable and stores them for viewing later
function Artemis:ScanStable()
  --
 	haveFilled = 0
	petnumidx  = 1
	ArtemisDBChar.stable = {}
  
  -- Current Pet is index ZERO  
  local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
  local currXP, nextXP = GetPetExperience()
  local petFoodList = { GetPetFoodTypes() };

  -- Scan all Pets
	for index=0, Artemis.view.maxPets-1 do		
    Artemis:ScanPetAtIndex(index)
    --{name, family, level, icon, loyalty, happiness, petFoodList }
    local petarr = ArtemisDBChar.stable[index+1]
    
    petnumidx = petnumidx +1
		if petarr ~= nil and petarr[1] and petarr[1] ~= "" then		
			haveFilled = haveFilled +1
		end
	end --for
	--Artemis.PrintMsg("Stored: num pets: " .. petnumidx)
	Artemis.PrintMsg( "You have " .. haveFilled .. " pets.")
	ArtemisDBChar.stable_petnumidx = petnumidx			
	ArtemisDBChar.stable_lasttime  = date("%B %m %Y %H:%M:%S")
  --
end 

function Artemis:printPet(petarr,index) 
	--name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
  name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)

	if name == nil then
		Artemis.PrintMsg( L["PrintPet_CantPrintNum"] .. index )
	else 
		if family == nil then
			Artemis.PrintMsg("PrintPet: " .. name )
		else
			--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
			--defaultSpec    =  Artemis:GetPetDefaultSpec(family)	
      --specialAbility =  Artemis:GetPetSpecialAbility(family)
			Artemis.PrintMsg("PrintPet: " .. name .. " is a " .. family .. " --> " .. family .. " loyalty = " .. loyalty) 
		end
	end
end

-- name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList
function Artemis:ParsePetArray(petarr) 
	name = ""
	family = ""
	level = ""
	icon = nil
	loyalty = "";
  happiness = "";
  petFoodList = "";
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
	end
	miscinfo = "Unknown Family" --L["PetFamilies_Unknown"]
	--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
	--defaultSpec    =  Artemis:GetPetDefaultSpec(family)	
	--specialAbility =  Artemis:GetPetSpecialAbility(family)
	if loyalty == nil then
		loyalty = "000"
	else
		loyalty = "<" .. loyalty .. ">"
	end
	return name, family, level, icon, loyalty, happiness, petFoodList
end

--GetStablePetInfo

-- Command line function only
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
		Artemis.PrintMsg( L["ShowStable_MaxNum"] .. maxNum )	
		
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

-- 
function Artemis:UpdatePetHappiness()
  if(UnitExists("pet")) then
    Artemis.DebugMsg("UpdatePetHappiness Called w/pet")
    
    local hasUI, isHunterPet = HasPetUI();
    --Artemis.PrintMsg("UpdatePetHappiness hasUI=".. tostring(hasUI) )
    --Artemis.PrintMsg("UpdatePetHappiness isHunterPet=".. tostring(isHunterPet) )
    if( hasUI and isHunterPet ) then
      Artemis:ScanCurrentPet()
      local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
      local icon, name, level, family, loyalty = GetStablePetInfo(1)
      if(name~=nil) then
        --ArtemisMainFrame_HappinessFrame_textPetHappiness:SetText(loyaltyRate)
        --local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
        local happy = ({"Unhappy", "Content", "Happy"})[happiness]
        local hText = "Unknown"
        textPetHappiness:SetTextColor(0,255,0) -- green
        if(happy~=nil) then
          hText = string.format("Pet is... %s", happy)
          --TODO set text color
          if(happiness==1) then
            textPetHappiness:SetTextColor(125,125,125) 
          elseif(happiness==2) then
            textPetHappiness:SetTextColor(0,125,125) --yellow
          elseif(happiness==3) then
            textPetHappiness:SetTextColor(0,255,0) --green
          else
            textPetHappiness:SetTextColor(0,125,125)--yellow
          end
        end
        textPetHappiness:SetText(hText)
      end
      if ( not ArtemisMainFrame_HappinessFrame:IsShown()) then 
        ArtemisMainFrame_HappinessFrame:Show()
      end
    else
      --TODO reset data?
    end-- has pet
 
  end
end

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
  
function Artemis:PetChangedCallback(newGUID)
	Artemis.DebugMsg("PetChangedCallback Called")
  Artemis.view.PET_GUID = newGUID
  -- update view?
	Artemis.DebugMsg("PetChangedCallback Done")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:SetupMCFrame()
	Artemis.DebugMsg("SetupMCFrame Called")
  -- 1index is 0pet(Current)  
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    if( ArtemisDBChar.stable == nil) then 
      ArtemisDBChar.stable = {}
    end
  end
  
  Artemis:ScanCurrentPet()
  if(#ArtemisDBChar.stable > 0) then
    local petarr = ArtemisDBChar.stable[1] 
    --return name, family, level, icon, loyalty, happiness, petFoodList
    local name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)    
    -- 
    if icon == nil then
      icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
    end  
    name = Artemis:SetStringOrDefault(name,"No Pet")

    if name == nil then
      Artemis.DebugMsg("PrintPet: cant find current pet ")
    end  
    --Artemis.DebugMsg("PrintPet: icon = ".. tostring(icon) )

    --
    --ArtemisMainDataFrameMCFrame_MyCurrentPet:SetMouseOverTexture(icon)
    ArtemisMainDataFrameMCFrame_MyCurrentPet:SetNormalTexture(icon)
  
  end
  --
  icon = nil
  name = nil
  if(#ArtemisDBChar.stable > 1) then
    petarr = ArtemisDBChar.stable[2] 
    --return name, family, level, icon, loyalty, happiness, petFoodList
    name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)
  end
  if icon == nil then
    icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  end  
  name = Artemis:SetStringOrDefault(name,"No Pet")

	if name == nil then
		Artemis.DebugMsg("PrintPet: cant find current pet ")
  end  
  ArtemisMainDataFrameMCFrame_MyStabledPet1:SetNormalTexture(icon)
  
  --
  icon = nil
  name = nil
  if(#ArtemisDBChar.stable > 2) then
    petarr = ArtemisDBChar.stable[3] 
    name, family, level, icon, specialAbility, defaultSpec, talent = Artemis:ParsePetArray(petarr)
  end
  if icon == nil then
    icon = "Interface\\AddOns\\StableSnapshot\\Icons\\Default.png"
  end  
  name = Artemis:SetStringOrDefault(name,"No Pet")

	if name == nil then
		Artemis.DebugMsg("PrintPet: cant find current pet ")
  end  
  ArtemisMainDataFrameMCFrame_MyStabledPet2:SetNormalTexture(icon)
  
  
  --
  ArtemisMainDataFrameMCFrame_MyPetModel:ClearModel()
  
  
	Artemis.DebugMsg("SetupMCFrame Done")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------