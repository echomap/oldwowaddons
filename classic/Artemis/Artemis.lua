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
  if( msg ~= nil and msg ~= "") then 
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
	if ArtemisMainFrame == nil then 
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
    --
end

function Artemis:ShowWindow()
	ArtemisMainFrame:Show()
	--Artemis_UpdateList()
  -- TODOcontent/tabs
end

function Artemis:HideWindow()
	ArtemisMainFrame:Hide()
end

function Artemis:BtnClose()
	Artemis:HideWindow()
end


function Artemis:SetupDataWindow()
end

function Artemis:ShowDataWindow()
	ArtemisMainDataFrame:Show()
end

function Artemis:HideDataWindow()
	ArtemisMainDataFrame:Hide()
end

    
function Artemis:ShowHideDataWindow()
	if ArtemisMainDataFrame == nil then 
		Artemis:SetupDataWindow()
    Artemis:ShowDataWindow()
	else
    if (ArtemisMainDataFrame:IsShown()) then 
      Artemis:HideDataWindow()
    else
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
  
  -- Initalize options
	if not ArtemisDB then ArtemisDB = {} end -- fresh DB
	if not ArtemisDBChar then ArtemisDBChar = {} end -- fresh DB
  
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
  local message = "Artemis"
  if( messageType ~= nil) then
    if( messageType == "Settings") then 
      message = message .. " Settings/Options"
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
  Artemis.view.ammoSlot  = GetInventorySlotInfo("AmmoSlot");
  Artemis.view.ammoCount = tonumber(GetInventoryItemCount("player", Artemis.view.ammoSlot ));
  
  Artemis.view.rangedSlot  = GetInventorySlotInfo("RangedSlot");
  Artemis.view.rangedDurCurr = GetInventoryItemDurability( Artemis.view.rangedSlot );
  Artemis.view.rangedDurMax = GetInventoryItemDurability( Artemis.view.rangedSlot );
  --  0 normal (6+), 1 yellow (5-1), 2 broken (0)
  Artemis.view.rangedDurStatus = GetInventoryAlertStatus( Artemis.view.rangedSlot );
  
  textAmmoCount:SetText( Artemis.view.ammoCount )
  if( Artemis.view.rangedDurCurr ~= nil and Artemis.view.rangedDurMax ~= nil) then
    textWpnDur:SetText(    Artemis.view.rangedDurCurr .. "/" .. Artemis.view.rangedDurMax )
  else
    textWpnDur:SetText( "n/a" )
  end
  
end

function Artemis:DoStableMasterEvent()
	Artemis.PrintMsg("You have opened the stable!")
  --If has one pet... scan the others
	local icon, name, level, family, loyalty = GetStablePetInfo(1)
	Artemis.DebugMsg("DoStableOpened name: " .. name .. "' family: '" ..family.. "'" )
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
 -- Current Pet is index ZERO  
  local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
  local currXP, nextXP = GetPetExperience()
  local petFoodList = { GetPetFoodTypes() };

  Artemis:ScanPetAtIndex(0)
  local petarr = ArtemisDBChar.stable[0]
  --
end

function Artemis:ScanPetAtIndex(index)
  --
  local icon, name, level, family, loyalty = GetStablePetInfo(index)
  icon =  Artemis:SetStringOrDefault(icon,"")
  name =  Artemis:SetStringOrDefault(name,"")
  level =  Artemis:SetStringOrDefault(level,"")
  family =  Artemis:SetStringOrDefault(family,"")
  loyalty =  Artemis:SetStringOrDefault(loyalty,"")
  happiness =  Artemis:SetStringOrDefault(happiness,"")
  petFoodList =  Artemis:SetStringOrDefault(petFoodList,"")
    
  Artemis.DebugMsg("ScanStable: ScanPetAtIndex, index = " .. index .." icon=" .. icon .. " name="..name.." level="..level.." family=" .. family.. " loyalty="..loyalty .. " happiness="..happiness .. " petFoodList="..tostring(petFoodList)
  );
  
  local petarr = {}
  petarr =  { name, family, level, icon, loyalty, happiness, petFoodList }
  ArtemisDBChar.stable[petnumidx] =  petarr
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
    local petarr = ArtemisDBChar.stable[index]
    
    petnumidx = petnumidx +1
		if petarr ~= nil and petarr[1] and petarr[1] ~= "" then		
			haveFilled = haveFilled +1
		end
	end --for
	--print("Stored: num pets: " .. petnumidx)
	print( "You have " .. haveFilled .. " pets stabled")
	ArtemisDBChar.stable_petnumidx = petnumidx			
	ArtemisDBChar.stable_lasttime  = date("%B %m %Y %H:%M:%S")
  --
end 

function Artemis:printPet(petarr,index) 
	--name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
  name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)

	if name == nil then
		print( L["PrintPet_CantPrintNum"] .. index )
	else 
		if family == nil then
			print("PrintPet: " .. name )
		else
			--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
			--defaultSpec    =  Artemis:GetPetDefaultSpec(family)	
      --specialAbility =  Artemis:GetPetSpecialAbility(family)
			print("PrintPet: " .. name .. " is a " .. family .. " --> " .. family .. " loyalty = " .. loyalty) 
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
		--print( tostring(index) .. " : " .. value )
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
	miscinfo = L["PetFamilies_Unknown"]
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
		print( L["ShowStable_NoneSaved"] )
		--playerUnitId = UnitId("player")
		localizedClass, englishClass = UnitClass("player");
		Artemis.DebugMsg("ShowStable englishClass: " .. englishClass .. "'" )
		if englishClass == 'HUNTER' then
			print( L["ShowStable_NoneSaved_Hunter"] )
		end
	else 
		print( L["ShowStable_MaxNum"] .. maxNum )	
		
		petarrAll = ArtemisDBChar.stable
		if petarrAll == nil then
			print( L["ShowStable_NoPets"] )
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


-------------------------------------------------------------------------
-------------------------------------------------------------------------