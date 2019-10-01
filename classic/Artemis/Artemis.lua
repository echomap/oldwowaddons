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
        maxPets  = 3,
    },
    --ArtemisDB/ArtemisDBChar
    --savedVariables  = {},
}
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis.DebugMsg(msg)
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
-------------------------------------------------------------------------
function Artemis:ShowHelp()
  print("---===ARTEMIS====---")
  print("/artemis <gui/debug/printabilities/printability <name>" )
end

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

function Artemis:SetupWindow()
  --TODO ArtemisMainFrame:SetScript("OnEscapePressed", function(self) self:Hide() end)
  Artemis.view.setupmain = true
end

function Artemis:ShowWindow()  
	ArtemisMainFrame:Show()
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    ArtemisMainFrame_HappinessFrame:Show()
  end
  ArtemisMainFrame_AmmoFrame:Show()
  ArtemisMainFrame_wpnDurFrame:Show()
	--Artemis_UpdateList()
  -- TODOcontent/tabs
end

function Artemis:HideWindow()
	ArtemisMainFrame:Hide()
  ArtemisMainFrame_HappinessFrame:Hide()
  ArtemisMainFrame_AmmoFrame:Hide()
  ArtemisMainFrame_wpnDurFrame:Hide()
end

function Artemis:BtnClose()
	Artemis:HideWindow()
end

function Artemis:InitDataWindow()
  --
end

function Artemis:SetupDataWindow() 
	--Artemis.DebugMsg("SetupDataWindow: Called")
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    Artemis:ScanCurrentPet()
    local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
    local icon, name, level, family, loyalty = GetStablePetInfo(1)
    if(name~=nil) then
    --ArtemisMainFrame_HappinessFrame_textPetHappiness:SetText(loyaltyRate)
      local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
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
  else
    --TODO reset data?
  end-- has pet
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

-------------------------------------------------------------------------
-------------------------------------------------------------------------
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

  if #options == 0 then
    Artemis:ShowHelp()
  elseif options[1] == "help" then
    Artemis:ShowHelp()
  elseif options[1] == "debug" then
    Artemis.view.debug = not Artemis.view.debug
    Artemis.DebugMsg("Debug = " .. tostring(Artemis.view.debug) )
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
  else
    Artemis:ShowHelp()
  end
  --[[
  if msg == "debug" then
		--
  elseif msg == "options" then
		--
  elseif msg == "gui" then
		Artemis:ShowHide()
  elseif msg == "printabilities" then
      --
  elseif msg == "printability" then
    local arg2 = ""
		--
	else 
		Artemis:ShowHelp()
	end	
  --]]--
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
SlashCmdList["Artemis"] = function(msg)
              Artemis.SlashCommandHandler(msg);
            end
SLASH_Artemis1 = "/artemis"
SLASH_Artemis2 = "/artemes"
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:Init()
  Artemis.DebugMsg("Init: Called")
end

function Artemis:OnUpdate()
  --Artemis.DebugMsg("OnUpdate: Called")
  --TODO How often is this called?
  Artemis:LoadAmmoCount()
  Artemis:SetupDataWindow()
end

function Artemis:OnEvent(event, ...)	
  Artemis.DebugMsg("OnEvent: Called")
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisMainFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED")
		ArtemisMainFrame:UnregisterEvent("ADDON_LOADED")
		Artemis:Init()
  elseif event == "PLAYER_LOGOUT" then
    --
    ArtemisMainFrame:UnregisterEvent("PET_STABLE_SHOW")
	elseif event == "PET_STABLE_SHOW" then
    Artemis:DoStableMasterEvent()
  else
    --TODO How often is this called?
    --Artemis:LoadAmmoCount()
  end
end

function Artemis:OnLoad()
  Artemis.DebugMsg("OnLoad: Called")
  ArtemisMainFrame:RegisterEvent("ADDON_LOADED");  -- Fired when saved variables are loaded
  ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
  ArtemisMainFrame:RegisterForDrag("LeftButton");  -- DRAG
  
	ArtemisMainFrame:RegisterEvent("PET_STABLE_SHOW")
	--StableSnapshot:addSlideIcon() --create ldb launcher button
  
  -- Initalize Saved Variables
	if not ArtemisDB then ArtemisDB = {} end -- fresh DB
	if not ArtemisDBChar then ArtemisDBChar = {} end -- fresh DB
  
  localizedClass, englishClass = UnitClass("player");
  if englishClass == 'HUNTER' then
    Artemis:ShowWindow()
  end
    
	print("v"..Artemis.version.." loaded")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
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
-------------------------------------------------------------------------
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
	--GroupBulletinBoardDB.X = GroupBulletinBoardFrame:GetLeft()
	--GroupBulletinBoardDB.Y = GroupBulletinBoardFrame:GetTop()
	--GroupBulletinBoardDB.Width = GroupBulletinBoardFrame:GetWidth()
	--GroupBulletinBoardDB.Height = GroupBulletinBoardFrame:GetHeight()
end
-------------------------------------------------------------------------
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
function Artemis:ClickPet(self,petIndex)
  ArtemisMainDataFrameMCFrame_MyPetModel:ClearModel()
  --TODO model
  --TODO XXX
  SetPetStablePaperdoll(ArtemisMainDataFrameMCFrame_MyPetModel)
end

function Artemis:ShowTooltipPet(self,petIndex)
  local message = "Artemis"
  if( petIndex == nil) then
    petIndex = 1
  end
  local petarr = ArtemisDBChar.stable[petIndex] 
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
  --Artemis.DebugMsg("OnEvent: Called")
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
	if event == "ADDON_LOADED" and arg1 == "ArtemisMainDataFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED (DataFrame)")
		--ArtemisMainDataFrame:UnregisterEvent("ADDON_LOADED")
		--Artemis:Init()
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
	--GroupBulletinBoardDB.X = GroupBulletinBoardFrame:GetLeft()
	--GroupBulletinBoardDB.Y = GroupBulletinBoardFrame:GetTop()
	--GroupBulletinBoardDB.Width = GroupBulletinBoardFrame:GetWidth()
	--GroupBulletinBoardDB.Height = GroupBulletinBoardFrame:GetHeight()
end

function Artemis:ShowTooltipDataFrame(self,messageType)
  --
end
function Artemis:HideTooltipDataFrame(self)  
	--GameTooltip:Hide()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------

function Artemis:BtnSettings()
	--Options:Open()	
end
function Artemis:ToggleOptions()
	--Options:Open()
end
function Artemis:ToggleStable()
	--Options:Open()
  Artemis:ShowHideDataWindow()
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:ResetStable()
  ArtemisDBChar.stable = {}		
end

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

function Artemis:DoStableMasterEvent()
	Artemis.PrintMsg("You have opened the stable!")
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
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:ScanCurrentPet()
  Artemis.DebugMsg("ScanCurrentPet: Called")
 -- Current Pet is index ZERO  
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
    
    
  Artemis.DebugMsg("ScanPetAtIndex, index = " .. index .." icon=" .. tostring(icon) .. " name="..name.." level="..level.." family=" .. family.. " loyalty="..loyalty .. " happiness="..happiness .. " petFoodList="..tostring(petFoodList)
  );
  
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
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:SetupMCFrame()
	Artemis.DebugMsg("SetupMCFrame Called")
  -- 1index is 0pet(Current)
  Artemis:ScanCurrentPet()
  local petarr = ArtemisDBChar.stable[1] 
	local name, family, level, icon, specialAbility, defaultSpec, talent = Artemis:ParsePetArray(petarr)
    
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
  
  --
  icon = nil
  name = nil
  if(#ArtemisDBChar.stable > 1) then
    petarr = ArtemisDBChar.stable[2] 
    name, family, level, icon, specialAbility, defaultSpec, talent = Artemis:ParsePetArray(petarr)
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