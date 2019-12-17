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
    version         = "1.0.8",			-- A nuisance to match to the Manifest.
    author          = "Echomap",
    color           = "DDFFEE",			 -- Used in menu titles and so on.    
    --menuName        = "Artemis_Options", -- Unique identifier for menu object.
    --menuDisplayName = "Artemis",
    view            = {
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
  if( msg ~= nil and msg ~= "" and ArtemisDBChar~=nil and ArtemisDBChar.debug ) then
    print("Artemis " .. msg )
  end
end

function Artemis.PrintMsg(msg)
  if( msg ~= nil) then 
    --color? textWpnDur:SetTextColor(0,125,125) -- yellow
    --cff6cf900
    -- red cffff0000
    --green cff6cf900
    print("|cffFFE599".."(Artemis) " .. msg .. "|r" )
    -- "You have |cffff0000" .. tostring(#notList) .. "|r pending " .. taskPlural
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
  end
  if (not ArtemisDBChar.enable) then
    Artemis:HideWindow()
  elseif (ArtemisMainFrame:IsShown()) then 
    Artemis:HideWindow()
  else
    Artemis:ShowWindow()
  end
end

-- Called the first time showhide is called, or after OnUnLoad() is called
function Artemis:SetupWindow()
  if( not Artemis.view.setupmain ) then 
    _, class = UnitClass("player");
    
    ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
    ArtemisMainFrame:RegisterForDrag("LeftButton");  -- DRAG
    ArtemisMainFrame:RegisterEvent("PLAYER_LOGIN")
    
    ArtemisMainFrame:RegisterEvent("PET_STABLE_SHOW")
    ArtemisMainFrame:RegisterEvent("PET_STABLE_CLOSED")
    ArtemisMainFrame:RegisterEvent("PET_STABLE_UPDATE")
    
    ArtemisMainFrame:RegisterUnitEvent("UNIT_PET","player")
    ArtemisMainFrame:RegisterUnitEvent("UNIT_HAPPINESS","pet")
    --ArtemisMainFrame:RegisterUnitEvent("PET_UI_CLOSE","pet")
    
    if class=="HUNTER" then
      if( ArtemisDBChar.options.setuptrapsswitch ) then 
        --ArtemisMainFrame:RegisterEvent("SPELLS_CHANGED");
        ArtemisMainFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
        ArtemisMainFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
        --ArtemisMainFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
      end
    else
      ArtemisTrapFrame:Hide();
    end
    
  end  
  Artemis.OptionInit()
  Artemis:UpdatePetHappiness()
  Artemis.view.setupmain = true
  ArtemisDBChar.enable = true 
end

-- Show the main window: ammo/durability/happiness(if hunter)
function Artemis:ShowWindow()  
	ArtemisMainFrame:Show()
  --if has ammo and ranged weapon TODO
  ArtemisMainFrame_AmmoFrame:Show()
  if(ArtemisDBChar.options.wpndurabilityswitch) then
    ArtemisMainFrame_wpnDurFrame:Show()
  end
  local hasUI, isHunterPet = HasPetUI();
  if( hasUI and isHunterPet ) then
    Artemis.ShowPetRelatedFrames()
  end
  if(ArtemisDBChar.options.petexperienceswitch) then
     Artemis.DebugMsg("PetExperienceFrame:Show")
    ArtemisMainFrame_PetExperienceFrame:Show()
  end
  --Artemis.ShowPetRelatedFrames()
	--Artemis_UpdateList()
  -- TODOcontent/tabs
end

-- Hide the main window: ammo/durability/happiness(if hunter)
function Artemis:HideWindow()
	ArtemisMainFrame:Hide()
  ArtemisMainFrame_AmmoFrame:Hide()
  ArtemisMainFrame_wpnDurFrame:Hide()
  ArtemisMainFrame_PetExperienceFrame:Hide()
  Artemis.HidePetRelatedFrames()
  --ArtemisMainFrame_HappinessFrame:Hide()
  --ArtemisMainFrame_FeedFrame:Hide()
end

--GUI close button clicked
function Artemis:BtnClose()
	Artemis:HideWindow()
end

-- Called after ADDON_LOADED via the Main frame, event framework
function Artemis:InitAddon()
  Artemis.DebugMsg("InitAddon: Called")
  --ArtemisMainFrame:RegisterEvent("PLAYER_LOGIN")
  --ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
  Artemis.DebugMsg("InitAddon: Done")
end

-- Initalize Saved Variables
function Artemis:SetupDefaultSavedvariables()
  local localizedClass, englishClass = UnitClass("player");
  
	if not ArtemisDB then ArtemisDB = {} end -- fresh DB

  --
	if not ArtemisDBChar then 
    -- fresh DB
    ArtemisDBChar = {} 
    ArtemisDBChar.stable = {}
    --if hunter and not set/unset then enable
    if englishClass == 'HUNTER' then
      if( ArtemisDBChar == nil ) then        
        ArtemisDBChar = {}
      end
      if( ArtemisDBChar.enable == nil ) then
        ArtemisDBChar.enable = true
      end
    else
      ArtemisDBChar.enable = false
    end
  end 
  
   -- 
  if(ArtemisDBChar.options == nil) then
    ArtemisDBChar.options = {}
    ArtemisDBChar.options.wpndurabilityswitch = true
    ArtemisDBChar.options.ammocountswitch     = true
    ArtemisDBChar.options.petexperienceswitch = true
    ArtemisDBChar.options.pethappinesswitch   = true
    
    ArtemisDBChar.options.TrapFrameUnlocked   = false
    ArtemisDBChar.options.setuptrapsswitch    = false
    
    ArtemisDBChar.options.setupaspectsswitch    = false
    ArtemisDBChar.options.AspectFrameUnlocked   = false
    
    ArtemisDBChar.options.setuptrackersswitch    = false
    ArtemisDBChar.options.TrackerFrameUnlocked   = false
    
    ArtemisDBChar.options.setuptrackersorientation = false

  end
end
  
function Artemis:InitPlayer()
  Artemis.DebugMsg("InitPlayer: Called")
  if( ArtemisDBChar~=nil and ArtemisDBChar.enable) then
    Artemis.view.enable = ArtemisDBChar.enable
  end  
  Artemis:SetupDefaultSavedvariables() 
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
  ArtemisMainFrame:RegisterEvent("PET_STABLE_CLOSED")
  ArtemisMainFrame:RegisterEvent("PET_STABLE_UPDATE")
  
  ArtemisMainFrame:RegisterUnitEvent("UNIT_PET","player")
  ArtemisMainFrame:RegisterUnitEvent("UNIT_HAPPINESS","pet")
  --ArtemisMainFrame:RegisterUnitEvent("PET_UI_CLOSE","pet")
  ArtemisMainFrame:RegisterUnitEvent("PET_DISMISS_START") 
  
  local localizedClass, englishClass = UnitClass("player");
  if class=="HUNTER" then
    if( ArtemisDBChar.options.setuptrapsswitch ) then 
      --ArtemisMainFrame:RegisterEvent("SPELLS_CHANGED");
      ArtemisMainFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
      ArtemisMainFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
      --ArtemisMainFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
      --
      Artemis.TrapFrame_Initialize()
      ArtemisTrapFrame:Show();
    end
    if( ArtemisDBChar.options.setupaspectsswitch ) then 
      Artemis.AspectFrame_Initialize()
      ArtemisAspectFrame:Show();
    end    
    if( ArtemisDBChar.options.setuptrackersswitch ) then 
      Artemis.TrackerFrame_Initialize()
      ArtemisTrackerFrame:Show();
    end    
  end  
  
  Artemis.OptionInit()
  ArtemisMainFrame:UnregisterEvent("PLAYER_LOGIN")
  Artemis.DebugMsg("InitPlayer: Done")
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
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg, arg9 = ...
  Artemis.DebugMsg("OnEvent: arg1 = "..tostring(arg1) )
  if( arg2 ~= nil) then
    Artemis.DebugMsg("OnEvent: arg2 = "..tostring(arg2) )
  end
	
  if event == "ADDON_LOADED" and arg1 == "ArtemisMainFrame" then
    Artemis.DebugMsg("OnEvent: ADDON_LOADED")
		ArtemisMainFrame:UnregisterEvent("ADDON_LOADED")
		--Artemis:InitAddon()
  elseif event == "PLAYER_LOGIN" then
    Artemis:InitPlayer()
  elseif event == "PLAYER_LOGOUT" then
    Artemis:OnUnLoad()
  end
  
  if( not ArtemisDBChar or not ArtemisDBChar.enable) then
    return
  end
  
 if event == "PET_STABLE_SHOW" then
    Artemis:DoStableMasterShowEvent()
	elseif event == "PET_STABLE_CLOSED" then
    Artemis:DoStableMasterClosedEvent()
	elseif event == "PET_STABLE_UPDATE" then
    Artemis:DoStableMasterShowEvent()
  elseif event == "UNIT_PET" then
    if(not Artemis.instableevent) then
      Artemis:CheckPetChanged()
    end
  elseif event == "UNIT_HAPPINESS" then
    Artemis.DebugMsg("OnEvent: arg1 = "..tostring(arg1) ) -- "pet"
    Artemis:UpdatePetHappiness()
  elseif event == "PET_UI_CLOSE" then
    Artemis:CheckPetChanged()
    Artemis.DebugMsg("PET_UI_CLOSE")
  elseif event == "PET_DISMISS_START" then
    Artemis.DebugMsg("PET_DISMISS_START")
    Artemis:CheckPetChanged()
  elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
    --Artemis.PrintMsg("OnEvent: UNIT_SPELLCAST_SUCCEEDED")
    --Artemis.PrintMsg("OnEvent: arg1 = "..tostring(arg1) )
  if( arg2 ~= nil) then
    --Artemis.PrintMsg("OnEvent: arg2 = "..tostring(arg2) )
    --local desc = GetSpellDescription(arg2);
    --Artemis.PrintMsg("OnEvent: desc = "..tostring(desc) )
  end

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
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_CLOSED")
  ArtemisMainFrame:UnregisterEvent("PET_STABLE_UPDATE")
  ArtemisMainFrame:UnregisterEvent("UNIT_PET")
  ArtemisMainFrame:UnregisterEvent("UNIT_HAPPINESS")  
  --ArtemisMainFrame:UnregisterEvent("PET_UI_CLOSE")  
  ArtemisMainFrame:UnregisterEvent("PET_DISMISS_START")  
  
  --ArtemisMainFrame:UnregisterEvent("SPELLS_CHANGED");
  ArtemisMainFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
  ArtemisMainFrame:UnregisterEvent("LEARNED_SPELL_IN_TAB");
  --ArtemisMainFrame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");

  --
  Artemis.view.setupmain = false
  Artemis.DebugMsg("OnUnLoad: Done")
end


-- Called via Main frame: load 
function Artemis:OnLoad()
  Artemis.DebugMsg("OnLoad: Called")
  
  -- If saved variables has enabled == false (not null/not unset ), then stop!
  --if( ArtemisDBChar~=nil and ArtemisDBChar.enable~=nil and ArtemisDBChar.enable == false ) then
  --    return
  --end
  
  ArtemisMainFrame:RegisterEvent("PLAYER_LOGIN")
  ArtemisMainFrame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

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

--20191213
function Artemis.ShowPetRelatedFrames()
  if(ArtemisDBChar.options.pethappinesswitch==nil) then
    ArtemisDBChar.options.pethappinesswitch = true
  end
  if(ArtemisDBChar.options.petexperienceswitch==nil) then
    ArtemisDBChar.options.petexperienceswitch = true
  end
  if(ArtemisDBChar.options.pethappinesswitch) then
    ArtemisMainFrame_HappinessFrame:Show()
  end
  if(ArtemisDBChar.options.setupfeedbutton) then
    Artemis.SetupFeedPet()
    ArtemisMainFrame_FeedFrame:Show()
  end
  if(ArtemisDBChar.options.petexperienceswitch) then
    ArtemisMainFrame_PetExperienceFrame:Show()
  end
end
function Artemis.HidePetRelatedFrames()
  ArtemisMainFrame_HappinessFrame:Hide()
  ArtemisMainFrame_FeedFrame:Hide()
  ArtemisMainFrame_PetExperienceFrame:Hide() --20191214
end

-- Tooltip
function Artemis:ShowTooltipByCategory(self,messageType,messageCategoryType)
  Artemis.DebugMsg("messageCategoryType: " .. messageCategoryType)       
  local message = "Artemis"
  local sid 
  local slink   
  local message1, message2, message3
  if(messageCategoryType=="TRAP") then
    sid = Artemis.Trap_Traps[messageType]
  end
  if(messageCategoryType=="TRACKER") then
    sid = Artemis.Tracker_Trackers[messageType]
  end
  if(messageCategoryType=="ASPECT") then
    sid = Artemis.Aspect_Aspects[messageType]
  end
  if(sid~=nil) then
    slink = GetSpellLink( messageType )
    --name/mana/instant/desc
    Artemis.DebugMsg("Link: " .. tostring(slink) )
    Artemis.DebugMsg("sid: " .. tostring(sid) )
    Artemis.DebugMsg("slink: " .. tostring(slink) )
    local sdesc = GetSpellDescription(slink)
    if( sid~=nil and slink~=nil and sdesc~=nil ) then
      message = sdesc    
      --Artemis.DebugMsg("sdesc: " .. tostring(sdesc) )
      --local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(messageType)  
      local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(messageType)        
      --local start, duration, enabled = GetSpellCooldown(messageType)
      local costs = GetSpellPowerCost(messageType)
      
      message1 = name
      if(rank~=nil) then
        message1 = message1 .. "            " .. rank
      end
      if(costs~=nil and costs[1]~=nil ) then
        local costs0 = costs[1]
        local costmana, costtype = costs0["cost"], costs0["name"]
        --Artemis.PrintMsg("costmana: " .. tostring(costmana) .." costtype: " .. tostring(costtype) )
        if(costmana~=nil) then
          message2 = tostring(costmana).. " Mana" --double check? or in this case, always mana...
    end
  end
      if(castTime==0) then
        message3 = "Instant Cast"
      else
        message3 = "Cast time:" .. tostring(castTime) 
      end
      if(duration~=nil) then
        message3 = message3 .. "            " .. "CD: ".. duration
      end

    end
  end
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0	)
  if(message1~=nil) then
    --text [, red, green, blue [, wrapText]]
    GameTooltip:AddLine(message1 .."\n" ,1,1,1,1,false)
  end
  if(message2~=nil) then  
    GameTooltip:AddLine(message2  ,1,1,1,1,false)
  end
  if(message3~=nil) then  
    GameTooltip:AddLine(message3  ,.8,.8,.8,1,false)
  end
	GameTooltip:AddLine(message .."\n" ,.8,.8,.8,1,false)
	GameTooltip:Show()
end

-- Tooltip
function Artemis:ShowTooltipByMessageType(self,messageType)
  Artemis.DebugMsg("messageType: " .. messageType)       
  local message = "Artemis"
  
  if( messageType == "Settings") then 
    message = message .. " Settings/Options"
  elseif( messageType == "AmmoCount") then
    local itemLink = Artemis.view.ammoItemLink --GetInventoryItemLink("player", Artemis.view.ammoSlot )
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
      --Artemis:UpdatePetHappiness()
      local petarr = ArtemisDBChar.stable[1] 
      -- name, family, level, icon, loyalty, happiness, petFoodList, currexp, nextexp
      local name, family, level, icon, loyalty, happiness, petFoodList = Artemis:ParsePetArray(petarr)	
      --local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
      --local happy = ({"Unhappy", "Content", "Happy"})[happiness]
      message = "<" .. happiness .. ">"
    end
  elseif( messageType == "PetFeed") then
    if( ArtemisDBChar.stable ~= nil ) then
      local mText = ""
      if(ArtemisDBChar.options.setupfeedbuttonismacro) then
        mText = "FeedPetMacro"
        local name, icon, body, isLocal = GetMacroInfo("FeedPetMacro")
        if(name~=nil and body~=nil) then
          mText = "FeedPetMacro=" .. body 
        end
      else
        mText = "Feed Pet Spell"
      end
      message = "<" .. mText .. ">"
    end
  else
    message = message .. " " .. messageType
  end
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0,0	)
	GameTooltip:AddLine(message .."\n" ,.8,.8,.8,1,false)
	GameTooltip:Show()  
end

-- Main Window tooltip
function Artemis:ShowTooltip(self,messageType,messageCategoryType)
  Artemis.DebugMsg("ShowTooltip: messageType=" .. tostring(messageType))
  Artemis.DebugMsg("ShowTooltip: messageCategoryType=" .. tostring(messageCategoryType))
  if( not ArtemisMainFrame:IsShown()) then
    return
  end  
  if(messageCategoryType ~= nil) then
    Artemis:ShowTooltipByCategory(self,messageType,messageCategoryType)
  elseif( messageType ~= nil) then
    Artemis:ShowTooltipByMessageType(self,messageType)
  else
    local message = "Artemis"
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0,0	)
    GameTooltip:AddLine(message .."\n" ,.8,.8,.8,1,false)
    GameTooltip:Show()
  end
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
  ArtemisPetSearchFrameDataText:Show()
  ArtemisPetSearchFrameScrollChildFrame:Show()
end

-- Hide the PetSkills window: 
function Artemis:HidePetSkillsWindow()
	ArtemisPetSearchFrame:Hide()
  --ArtemisMainDataFrameButtonFrame:Hide()
  
  ArtemisPetSearchFrameButtonFrame:Hide()
  ArtemisPetSearchFrameLeftSideFrame:Hide()
  
  Artemis:ShowPetSearchAbilityButtons(false)
  
  ArtemisPetSearchFrameMainDataFrame:Hide()
  ArtemisPetSearchFrameDataText:Hide()
  ArtemisPetSearchFrameScrollChildFrame:Hide()
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


-- Called via PetSkills frame: show 
function Artemis:OnShowPetSkillsFrame()    
	ArtemisPetSearchFrameMainDataFrame:UpdateScrollChildRect();
	ArtemisPetSearchFrameMainDataFrameScrollBar:SetValue(0);
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
  --
  if( not Artemis.view.tameListCreated ) then
    Artemis:CreateTameList()
    Artemis.view.tameListCreated = true
  end
  
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
	Artemis.DebugMsg("OnPetSkillsAbilityValueChanged Called")
  Artemis.DebugMsg("OnPetSkillsAbilityValueChanged Done")
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
    
    if lineplusoffset <= #Artemis.Abilities_Base then --Ability_Base_List then
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
  Artemis.DebugMsg("PetSkillsAbilityDropdown_OnLoad Called")
  Artemis.DebugMsg("PetSkillsAbilityDropdown_OnLoad kData='" .. tostring(Artemis.view.selectPetAbility) .."'" )
  
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
    Artemis.DebugMsg("PetSkillsAbilityDropdown_OnClick called")
    --indexData=" .. tostring(indexData) )
    --[[for i,v in pairs(indexData) do
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick i=" .. tostring(i) )
      Artemis.PrintMsg("PetSkillsAbilityDropdown_OnClick v=" .. tostring(v) )
    end --]]--   
    if(indexData~=nil) then
      local selectedNum = indexData.value
      Artemis.DebugMsg("PetSkillsAbilityDropdown_OnClick selectedNum=" .. tostring(selectedNum) )
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
      Artemis.DebugMsg("PetSkillsAbilityDropdown_OnClick nameNew=" .. tostring(nameNew) )
      local abilityDetails = Artemis.Abilities [nameNew]
      --abilityDetails["trainer"]
      --abilityDetails["MinPetLevel"] 
      --abilityDetails["CostTP"] 
      --abilityDetails["Params"] 
      --abilityDetails["Text"] 
      --abilityDetails["AbilityFamily"]
      --abilityDetails["AbilityLevel"] 
      local TamingList = abilityDetails["TamingList"]
     
      --
      local textAll = abilityDetails["Text"] --.. " " .. TamingList
      textAll = textAll.. "\n"
      if(TamingList~=nil) then
        textAll = textAll.. "\n"
        for i,v in pairs(TamingList) do
          textAll = textAll.. " name: " ..i.. "  lvl: " ..v["MinLvl"].. " - " .. v["MaxLvl"].. "\n"
          textAll = textAll.. "  location:" .. v["location"] .. "\n"
          --v["type"]   = family,
          --v["MinLvl"] = minlvl,
          --v["MaxLvl"] = maxlvl, 
          --v["location"] = location
        end
      end
      
      --ArtemisPetSearchTitleText:SetText(nameNew)
      ArtemisPetSearchFrameDataText:SetText( textAll ) 
      
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
  print("/artemis <gui/debug/aspects/traps/printabilities/printability <name>" )
  print("/artemis <options> <enable> <on/off>" )
  print("/artemis petskils  (BETA)" )
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
    ArtemisDBChar.debug = not ArtemisDBChar.debug
    Artemis.DebugMsg("Debug = " .. tostring(ArtemisDBChar.debug) )    
  elseif options[1] == "options" then
    Artemis.OptionsOpen()
	elseif options[1] == "gui" then    
    Artemis:ShowHide()
	elseif options[1] == "search" then    
    Artemis:DoPetSearchLearnableSkills()
	elseif options[1] == "traps" then    
    Artemis:toggleCheckboxTraps()
	elseif options[1] == "aspects" then    
    Artemis:toggleCheckboxAspects()
	elseif options[1] == "feedpet" then    
    Artemis:DoFeedPet()       
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
  Artemis.OptionInit()
  Artemis.OptionsOpen()
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
  local itemId = GetInventoryItemID("player", slotId);
  Artemis.view.ammoItemId = itemId
  Artemis.view.ammoItemLink = GetItemInfo(itemId)
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

--
function Artemis:DoStableMasterClosedEvent()
  Artemis.instableevent = false
	Artemis.PrintMsg(L["StableClosedMessage"])
end

--Update stored stable data, called from Main Frame events, PET_STABLE_SHOW and PET_STABLE_UPDATE
function Artemis:DoStableMasterShowEvent()
  Artemis.instableevent = true
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
  petarr =  ArtemisDBChar.stable[index+1]
  local foodList, exp1, exp2 = nil
  if(petarr~=nil) then
    if( #petarr > 6 and petarr[7] ~= nil ) then
      Artemis.DebugMsg("ScanPetAtIndex got foodlilst from arr ")
      foodList = petarr[7] 
      local foodListString = Artemis.toStringFoodList(foodList)
      Artemis.DebugMsg("ScanPetAtIndex foodListString=" .. foodListString)
    else
      Artemis.DebugMsg("ScanPetAtIndex getting foodlist from data, family=".. tostring(family))
      if(Artemis.petfamily[family]~=nil) then
        foodList = Artemis.petfamily[family]["PetFoodType"]
      else
        foodList = "Unknown"
      end
    end
    if( #petarr > 7) then exp1 = petarr[8] end
    if( #petarr > 8) then exp2 = petarr[9] end
  end
  
  petarr =  { name, family, level, icon, loyalty, happiness, foodList, exp1, exp2 }
  -- Current Pet is, stable[ONE], or api[ZERO]
  ArtemisDBChar.stable[index+1] =  petarr
  return petarr
end

function Artemis.toStringFoodList(petFoodList)
  local petFoodString = ""
  if( petFoodList ~= nil and petFoodList ~= "" ) then
    for i,v in pairs(petFoodList) do
        if (v ~= nil and v ~= "") then
            petFoodString = petFoodString .. string.lower(v) .. ", " 
        end
    end
  end
  return petFoodString
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
  
  if(petarr~=nil) then
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

--On button click
function Artemis:DoCheckPetHappiness()
  Artemis:UpdatePetHappiness()
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
      local icon, name, level, family, loyalty = GetStablePetInfo(1)
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
        
        local expText = ""
        local tpText
        if( ArtemisDBChar.options.petexperiencepercentswitch ) then
        local currXP, nextXP = GetPetExperience();
          expText = string.format( "Exp: %s/%s", currXP, nextXP )
          local nextXPPerc = (currXP/nextXP)*100
          expText = string.format( "Exp: %s/%s (%s%%)", currXP, nextXP,  math.floor(nextXPPerc) )
        end        
        if(ArtemisDBChar.options.pettrainingpointsswitch) then
          local totalPoints, pointsSpent = GetPetTrainingPoints();
          local pointsLeft = totalPoints - pointsSpent
          --Artemis.PrintMsg("TP: totalPoints: " ..tostring(totalPoints) .. " pointsSpent: " ..tostring(pointsSpent)  );
          tpText = string.format( "[tp: %s]", pointsLeft, pointsSpent, totalPoints )
        end
        if(tpText~=nil) then expText = expText .. " " .. tpText end
        textPetExperience:SetText( expText );
      end
      -- Show happy frame since updated, if not shown
      if ( not ArtemisMainFrame_HappinessFrame:IsShown()) then 
        Artemis.ShowPetRelatedFrames()
      end
    else
      --TODO reset data?
    end-- has pet\
  else
    --pet is unsumoned or dead? uuuu
    if(UnitIsDead("pet")) then
      textPetHappiness:SetTextColor(125,125,125) 
      hText = string.format("Pet is... %s", "Dead?") --TODO check this shows,,,when?
    else
      textPetHappiness:SetTextColor(0,125,125) --yellow
      hText = string.format("Pet is... %s", "Uknown?") --TODO check this shows,,,when?
    end
    textPetHappiness:SetText(hText)
  end --Pet is alive
end

-- Called on event: UNIT_PET 
function Artemis:CheckPetChanged()
  if(UnitExists("pet")) then
    Artemis.DebugMsg("CheckPetChanged Called, and pet exists")
    local newGUID = UnitGUID("pet")
    if(Artemis.view.PET_GUID == nil) then
      Artemis.view.PET_GUID = newGUID
    end
    if( newGUID ~= Artemis.view.PET_GUID) then
      Artemis:PetChangedCallback(newGUID)
    end
  else
    Artemis.DebugMsg("CheckPetChanged Called, and pet not exists")
    --pet dead or unsummoned?
    if(UnitIsDead("pet")) then
      Artemis.PrintMsg( L["PetUnitDead"] )
      textWpnDur:SetTextColor(255,0,0) -- borken
      --textPetHappiness:SetTextColor(125,0,0) -- red
      local hText = string.format(L["Artemis_PET_STATUS_MSG"], L["Artemis_PET_DEAD"] )
      textPetHappiness:SetText(hText)        
    else
      textPetHappiness:SetTextColor(0,125,125) -- yellow
      local hText = string.format(L["Artemis_PET_STATUS_MSG"], L["Artemis_PET_UNSUMMONED"] )
      textPetHappiness:SetText(hText)        
    end
  end
end
  
-- Called when pet data seems to be updated
function Artemis:PetChangedCallback(newGUID)
	Artemis.DebugMsg("PetChangedCallback Called")
  Artemis.DebugMsg("PetChangedCallback storedGUID= " .. tostring(Artemis.view.PET_GUID) )
  Artemis.DebugMsg("PetChangedCallback newGUID= " .. tostring(newGUID) )
  if( Artemis.view.PET_GUID==nil and newGUID~=nil ) then
    Artemis.PrintMsg("PetChangedCallback new pet?")
  elseif(Artemis.view.PET_GUID~=newGUID) then
    Artemis.DebugMsg("PetChangedCallback different pet?")
  else
    Artemis.PrintMsg("PetChangedCallback other? Why/What?/TODO")
  end
  --0-4402-0-64-3619-0100115FD3
  Artemis.viewPET_GUID = newGUID
  
  --Check dead? unit, pet?
  local isDead = UnitIsDead("pet")
  if(isDead) then
    textPetHappiness:SetTextColor(125,0,0) -- red
    hText = string.format("Pet is... %s", "Dead!")
    textPetHappiness:SetText(hText)
  else
    Artemis.PrintMsg( L["PetUnitChanged"] )
    Artemis:ScanCurrentPet()
  end
  -- update view?
  -- re-show view?
	Artemis.DebugMsg("PetChangedCallback Done")
end
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function Artemis:SetupFeedPet(self)
  Artemis.DebugMsg("SetupFeedPet");
  if(ArtemisDBChar.options.setupfeedbuttonismacro==nil) then
    ArtemisDBChar.options.setupfeedbuttonismacro = false
  end
  if(ArtemisDBChar.options.setupfeedbuttonismacro) then
    Artemis.DebugMsg("SetupFeedPet: Macro as 'FeedPetMacro'");
    ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("type", "macro")
    ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("macro", "FeedPetMacro" ) --BOM.MACRONAME)	  
  else
    Artemis.DebugMsg("SetupFeedPet: Spell as 'Feed Pet'");
    ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("type", "spell")
    ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("spell", "Feed Pet" )
  end
  --ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("macro", "/say testing 1234" ) --BOM.MACRONAME)	
  --ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("type", "spell")
	--ArtemisMainFrame_FeedFrame_FeedButton:SetAttribute("spell", "Feed Pet" )  
end
  
function Artemis:DoFeedPet(self)
  --TODO
  Artemis.PrintMsg("DoFeedPet");
  --PickupMacro("FeedPetMacro")
  --ArtemisMainFrame_FeedButton:SetAttribute("type", "macro")
	--ArtemisMainFrame_FeedButton:SetAttribute("macro", "FeedPetMacro" ) --BOM.MACRONAME)	
end

-- Call when spells learned, and on load, to make sure addon knows player's pet spells
function Artemis.SetupKnownSpells()
  if( ArtemisDBChar.petskills == nil) then
    ArtemisDBChar.petskills = {}
  end
  
  local tabName, tabTexture, tabOffset, numEntries = GetSpellTabInfo(1)
  for i=tabOffset + 1, tabOffset + numEntries do
    local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_PET)
    if(spellName~=nil ) then --and spellSubName~=nil
      Artemis.PrintMsg( "==> " .. spellName .. '(' .. tostring(spellSubName) .. ')' )
      ArtemisDBChar.petskills[spellName] = spellSubName
    end
  end
  
end

-------------------------------------------------------------------------
--OPTIONS
-------------------------------------------------------------------------
function Artemis.OptionsOpen()  
  Artemis.OptionInit()
  InterfaceOptionsFrame_OpenToCategory( Artemis.view.options.panel );
  InterfaceOptionsFrame_OpenToCategory( Artemis.view.options.panel );
end

function Artemis.OptionInit()
  Artemis.DebugMsg("OptionInit Called");
  if(ArtemisDBChar.options == nil) then
    ArtemisDBChar.options = {}
    ArtemisDBChar.options.wpndurabilityswitch = true
    ArtemisDBChar.options.ammocountswitch     = true
    ArtemisDBChar.options.petexperienceswitch = true
  end
  
  if( Artemis.view.options == nil ) then
    Artemis.view.options = {}
    Artemis.view.options.panel = CreateFrame( "Frame", "ArtemisOptionsPanel", InterfaceOptionsFramePanelContainer );
    -- Register in the Interface Addon Options GUI
    -- Set the name for the Category for the Options Panel
    Artemis.view.options.panel.name = "Artemis";
    -- Add the panel to the Interface Options
    InterfaceOptions_AddCategory(Artemis.view.options.panel);

    -- Make a child panel
    Artemis.view.options.childpanel = CreateFrame( "Frame", "ArtemisOptionsChild", Artemis.view.options.panel);
    Artemis.view.options.childpanel.name = "ArtemisOptions";
    -- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
    Artemis.view.options.childpanel.parent = Artemis.view.options.panel.name;
    -- Add the child to the Interface Options
    InterfaceOptions_AddCategory(Artemis.view.options.childpanel);
    
    --
    -- Populate Parent
    local frame = Artemis.view.options.panel
    local fields = {"Version", "Author",}
    local notes = GetAddOnMetadata(Artemis.name, "Notes")

    local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")

    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(Artemis.name)

    local subtitle = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetHeight(32)
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetPoint("RIGHT", frame, -32, 0)
    subtitle:SetNonSpaceWrap(true)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetJustifyV("TOP")
    subtitle:SetText(notes)

    --
    local anchor
    for _,field in pairs(fields) do
      local val = GetAddOnMetadata(Artemis.name, field)
      if val then
        local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        title:SetWidth(75)
        if not anchor then title:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -8)
        else title:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6) end
        title:SetJustifyH("RIGHT")
        title:SetText(field:gsub("X%-", ""))

        local detail = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        detail:SetPoint("LEFT", title, "RIGHT", 4, 0)
        detail:SetPoint("RIGHT", -16, 0)
        detail:SetJustifyH("LEFT")
        detail:SetText(val)

        anchor = title
      end
    end
    
    --
    local enabledCB = Artemis:createOptionCheckBox("MainEnabledCheckButton",frame,anchor,"Main Enabled")
    enabledCB:SetScript( "OnClick", Artemis.toggleMainEnabled )
    if(ArtemisDBChar.enable) then
      enabledCB:SetChecked(true)
      ArtemisDBChar.enable = true
    else
      enabledCB:SetChecked(false)
      ArtemisDBChar.enable = false
    end    
    Artemis.view.options.panel.enabledCB = enabledCB
    
    --
    local debugCB = Artemis:createOptionCheckBox("DebugCheckButton",frame, Artemis.view.options.panel.feedButtonShowCheckBox,"Debug Enabled")
    debugCB:SetPoint( "TOPLEFT", 20, -50 )
    debugCB:SetPoint("TOPLEFT", enabledCB, "TOPLEFT", 10, -50)    
    debugCB:SetScript( "OnClick", Artemis.toggleDebug )
    if(ArtemisDBChar.debug) then
      debugCB:SetChecked(true)
      ArtemisDBChar.debug = true
    else
      debugCB:SetChecked(false)
      ArtemisDBChar.debug = false
    end    
    Artemis.view.options.panel.debugCB = debugCB

    --
    local durCheckBox = CreateFrame( "CheckButton", "DurabilityEnabledCB", frame,"OptionsCheckButtonTemplate" )-- "ChatConfigCheckButtonTemplate" ) --"OptionsCheckButtonTemplate" )
    durCheckBox:SetText("Durability Enabled")    
    _G[ "DurabilityEnabledCB" .. "Text" ]:SetText( "Durability Enabled")    
    --durCheckBox.tooltip = tooltip
    durCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    durCheckBox:SetPoint("TOPLEFT", Artemis.view.options.panel.enabledCB, "TOPLEFT", 10, -50)
    durCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxDurablity )
    if(ArtemisDBChar.options.wpndurabilityswitch) then
      durCheckBox:SetChecked(true)
      ArtemisDBChar.options.wpndurabilityswitch = true
    else
      durCheckBox:SetChecked(false)
      ArtemisDBChar.options.wpndurabilityswitch = false
    end    
    
    Artemis.view.options.panel.durCheckBox = durCheckBox
    
    --
    local expCheckBox = CreateFrame( "CheckButton", "ExperienceEnabledCB", frame,"OptionsCheckButtonTemplate" )-- "ChatConfigCheckButtonTemplate" ) --"OptionsCheckButtonTemplate" )
    expCheckBox:SetText("Experience Enabled")    
    _G[ "ExperienceEnabledCB" .. "Text" ]:SetText( "Experience Enabled")    
    expCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    expCheckBox:SetPoint( "TOPLEFT", durCheckBox, "TOPRIGHT", 150, 0)
    expCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxPetExperience )
    if(ArtemisDBChar.options.petexperienceswitch) then
      expCheckBox:SetChecked(true)
      ArtemisDBChar.options.petexperienceswitch = true
      Artemis.PrintMsg("PetExp is true");
    else
      expCheckBox:SetChecked(false)
      ArtemisDBChar.options.petexperienceswitch = false
      Artemis.PrintMsg("PetExp is false");
    end    
    Artemis.view.options.panel.expCheckBox = expCheckBox
    
    --
    local expPercentCheckBox = CreateFrame( "CheckButton", "ExperiencePercentEnabledCB",frame,"OptionsCheckButtonTemplate" )
    expPercentCheckBox:SetText("Experience Enabled")    
    _G[ "ExperiencePercentEnabledCB" .. "Text" ]:SetText( "Experience Percent Enabled")    
    --expPercentCheckBox.tooltip = tooltip
    expPercentCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    expPercentCheckBox:SetPoint("TOPLEFT", Artemis.view.options.panel.durCheckBox, "TOPLEFT", 0, -50)
    expPercentCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxPetExperiencePercent )
    if(ArtemisDBChar.options.petexperiencepercentswitch) then
      expPercentCheckBox:SetChecked(true)
      ArtemisDBChar.options.petexperiencepercentswitch = true
      Artemis.DebugMsg("PetExp Perc is true");
    else
      expPercentCheckBox:SetChecked(false)
      ArtemisDBChar.options.petexperiencepercentswitch = false
      Artemis.DebugMsg("PetExp Perc is false");
    end    
    Artemis.view.options.panel.expPercentCheckBox = expPercentCheckBox
    
    
    -- Traps
    local trapsCheckBox = Artemis:createOptionCheckBox("TrapsEnabledCB",frame,Artemis.view.options.panel.expPercentCheckBox,"Trap Bar Enabled")
    trapsCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxTraps )
    if(ArtemisDBChar.options.setuptrapsswitch) then
      trapsCheckBox:SetChecked(true)
      ArtemisDBChar.options.setuptrapsswitch= true
    else
      trapsCheckBox:SetChecked(false)
      ArtemisDBChar.options.setuptrapsswitch = false
    end    
    Artemis.view.options.panel.trapsCheckBox = trapsCheckBox
    
    -- Aspects
    local aspectsCheckBox = CreateFrame( "CheckButton", "AspectsEnabledCB", frame, "OptionsCheckButtonTemplate" )-- "ChatConfigCheckButtonTemplate" ) --"OptionsCheckButtonTemplate" )
    aspectsCheckBox:SetText("Aspect Bar Enabled")    
    _G[ "AspectsEnabledCB" .. "Text" ]:SetText( "Aspects Bar Enabled")    
    --aspectsCheckBox.tooltip = tooltip
    aspectsCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    aspectsCheckBox:SetPoint("TOPLEFT", Artemis.view.options.panel.trapsCheckBox, "TOPLEFT", 0, -50)
    aspectsCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxAspects )
    if(ArtemisDBChar.options.setupaspectsswitch) then
      aspectsCheckBox:SetChecked(true)
      ArtemisDBChar.options.setupaspectsswitch = true
    else
      aspectsCheckBox:SetChecked(false)
      ArtemisDBChar.options.setupaspectsswitch = false
    end    
    Artemis.view.options.panel.aspectsCheckBox = aspectsCheckBox
    
    --tracker/trackers
    local trackersCheckBox = Artemis:createOptionCheckBox("TrackerCheckButton",frame,Artemis.view.options.panel.aspectsCheckBox,"Trackers Bar Enabled")
    trackersCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxTrackers )
    if(ArtemisDBChar.options.setuptrackersswitch) then
      trackersCheckBox:SetChecked(true)
      ArtemisDBChar.options.setuptrackersswitch= true
    else
      trackersCheckBox:SetChecked(false)
      ArtemisDBChar.options.setuptrackersswitch = false
    end    
    Artemis.view.options.panel.trackersCheckBox = trackersCheckBox
    
    --    
    local trapOrientCheckBox = Artemis:createOptionCheckBox("TrapOrientCheckBox",frame, Artemis.view.options.panel.trapsCheckBox, "Trapbar Vertical Orientation ")
    trapOrientCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxTrapsOrientVertical )
    trapOrientCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    trapOrientCheckBox:SetPoint( "TOPLEFT", trapsCheckBox, "TOPRIGHT", 150, 0)
    if(ArtemisDBChar.options.setuptrapsorientation) then
      trapOrientCheckBox:SetChecked(true)
      ArtemisDBChar.options.setuptrapsorientation = true
    else
      trapOrientCheckBox:SetChecked(false)
      ArtemisDBChar.options.setuptrapsorientation = false
    end    
    Artemis.view.options.panel.trapOrientCheckBox = trapOrientCheckBox
      
    --    
    local aspectOrientCheckBox = Artemis:createOptionCheckBox("AspectOrientCheckBox",frame, Artemis.view.options.panel.aspectsCheckBox, "Aspectbar Vertical Orientation ")
    aspectOrientCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxAspectsOrientVertical )
    aspectOrientCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    aspectOrientCheckBox:SetPoint( "TOPLEFT", aspectsCheckBox, "TOPRIGHT", 150, 0)
    if(ArtemisDBChar.options.setupaspectsorientation) then
      aspectOrientCheckBox:SetChecked(true)
      ArtemisDBChar.options.setupaspectsorientation = true
    else
      aspectOrientCheckBox:SetChecked(false)
      ArtemisDBChar.options.setupaspectsorientation = false
    end    
    Artemis.view.options.panel.aspectOrientCheckBox = aspectOrientCheckBox
    
    --    
    local trackersOrientCheckBox = Artemis:createOptionCheckBox("TrackersOrientCheckBox",frame, Artemis.view.options.panel.trackersCheckBox, "Trackersbar Vertical Orientation ")
    trackersOrientCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxTrackersOrientVertical )
    trackersOrientCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    trackersOrientCheckBox:SetPoint( "TOPLEFT", trackersCheckBox, "TOPRIGHT", 150, 0)
    if(ArtemisDBChar.options.setuptrackersorientation) then
      trackersOrientCheckBox:SetChecked(true)
      ArtemisDBChar.options.setuptrackersorientation = true
    else
      trackersOrientCheckBox:SetChecked(false)
      ArtemisDBChar.options.setuptrackersorientation = false
    end    
    Artemis.view.options.panel.trackersOrientCheckBox = trackersOrientCheckBox
    
    --    
    local feedButtonShowCheckBox = Artemis:createOptionCheckBox("FeedButtonShowCheckBox",frame, Artemis.view.options.panel.trackersCheckBox, "Show FeedButton")
    feedButtonShowCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxShowFeedButton )
    if(ArtemisDBChar.options.setupfeedbutton) then
      feedButtonShowCheckBox:SetChecked(true)
      ArtemisDBChar.options.setupfeedbutton = true
    else
      feedButtonShowCheckBox:SetChecked(false)
      ArtemisDBChar.options.setupfeedbutton = false
    end    
    Artemis.view.options.panel.feedButtonShowCheckBox = feedButtonShowCheckBox
    
    --    
    local feedButtonMacroCheckBox = Artemis:createOptionCheckBox("FeedButtonMacroCheckBox",frame, Artemis.view.options.panel.feedButtonShowCheckBox, "FeedButton Macro, not spell")
    feedButtonMacroCheckBox:SetPoint( "TOPLEFT", 20, -50 )
    feedButtonMacroCheckBox:SetPoint( "TOPLEFT", feedButtonShowCheckBox, "TOPRIGHT", 150, 0)
    feedButtonMacroCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxFeedButtonMacro )
    if(ArtemisDBChar.options.setupfeedbutton) then
      feedButtonMacroCheckBox:SetChecked(true)
      ArtemisDBChar.options.setupfeedbuttonismacro = true
    else
      feedButtonMacroCheckBox:SetChecked(false)
      ArtemisDBChar.options.setupfeedbuttonismacro = false
    end    
    Artemis.view.options.panel.feedButtonMacroCheckBox = feedButtonMacroCheckBox
    
    --
    -- Clear the OnShow so it only happens once
    --frame:SetScript("OnShow", nil)
  end    
end

function Artemis:createOptionCheckBox(name,parentframe,parentposition,text)
 local lCheckBox = CreateFrame( "CheckButton", name, parentframe, "OptionsCheckButtonTemplate" )
  lCheckBox:SetText(text)    
  _G[ name .. "Text" ]:SetText( text )    
  --trapsCheckBox.tooltip = tooltip
  lCheckBox:SetPoint( "TOPLEFT", 20, -50 )
  lCheckBox:SetPoint("TOPLEFT", parentposition, "TOPLEFT", 0, -50)
  --lCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxTraps )
  return lCheckBox
end

--
function Artemis.toggleMainEnabled()
	local isChecked = Artemis.view.options.panel.enabledCB:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.enable==nil) then
    ArtemisDBChar.enable = false
  end
  if isChecked then
    ArtemisDBChar.enable = true
  else
    ArtemisDBChar.enable = false
  end
  Artemis:ShowHide()
end

function Artemis.toggleCheckboxDurablity() 
	local isChecked = Artemis.view.options.panel.durCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.wpndurabilityswitch==nil) then
    ArtemisDBChar.options.wpndurabilityswitch = true
  end
  if isChecked then
    ArtemisDBChar.options.wpndurabilityswitch = true
  else
    ArtemisDBChar.options.wpndurabilityswitch = false
  end
  
  if(ArtemisDBChar.options.wpndurabilityswitch) then
    ArtemisMainFrame_wpnDurFrame:Show()
  else
    ArtemisMainFrame_wpnDurFrame:Hide()
  end
end


function Artemis.toggleCheckboxPetExperience() 
	local isChecked = Artemis.view.options.panel.expCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.petexperienceswitch==nil) then
    ArtemisDBChar.options.petexperienceswitch = true
  end
  if isChecked then
    ArtemisDBChar.options.petexperienceswitch = true
  else
    ArtemisDBChar.options.petexperienceswitch = false
  end
  
  if(ArtemisDBChar.options.petexperienceswitch) then
    ArtemisMainFrame_HappinessFrame:Show()
    Artemis.SetupFeedPet()
    ArtemisMainFrame_FeedFrame:Show()
  else
    ArtemisMainFrame_HappinessFrame:Hide()
    ArtemisMainFrame_FeedFrame:Hide()
  end
end

function Artemis.toggleCheckboxPetExperiencePercent() 
	local isChecked = Artemis.view.options.panel.expPercentCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  --if(ArtemisDBChar.options.petexperiencepercentswitch==nil) then
  --  ArtemisDBChar.options.petexperiencepercentswitch = true
  --end
  if isChecked then
    ArtemisDBChar.options.petexperiencepercentswitch = true
  else
    ArtemisDBChar.options.petexperiencepercentswitch = false
  end
  
  if(ArtemisDBChar.options.petexperiencepercentswitch) then
    ArtemisMainFrame_HappinessFrame:Show()
    Artemis.SetupFeedPet()
    ArtemisMainFrame_FeedFrame:Show()
  else
    ArtemisMainFrame_HappinessFrame:Hide()
    ArtemisMainFrame_FeedFrame:Hide()
  end
end


function Artemis.toggleCheckboxTraps() 
	local isChecked = Artemis.view.options.panel.trapsCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setuptrapsswitch==nil) then
    ArtemisDBChar.options.setuptrapsswitch = true
  end
  if isChecked then
    ArtemisDBChar.options.setuptrapsswitch = true
  else
    ArtemisDBChar.options.setuptrapsswitch = false
  end
  
  if(ArtemisDBChar.options.setuptrapsswitch) then
    Artemis.TrapFrame_Initialize()
    ArtemisTrapFrame:Show();
  else
    ArtemisTrapFrame:Hide();
  end
end

function Artemis.toggleCheckboxAspects() 
	local isChecked = Artemis.view.options.panel.aspectsCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setupaspectsswitch==nil) then
    ArtemisDBChar.options.setupaspectsswitch = true
  end
  if isChecked then
    ArtemisDBChar.options.setupaspectsswitch = true
  else
    ArtemisDBChar.options.setupaspectsswitch = false
  end
  if(ArtemisDBChar.options.setupaspectsswitch) then
    Artemis.AspectFrame_Initialize()
    ArtemisAspectFrame:Show();
  else
    ArtemisAspectFrame:Hide();
  end
end

function Artemis.toggleCheckboxTrackers() 
	local isChecked = Artemis.view.options.panel.trackersCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setuptrackersswitch==nil) then
    ArtemisDBChar.options.setuptrackersswitch = true
  end
  if isChecked then
    ArtemisDBChar.options.setuptrackersswitch = true
  else
    ArtemisDBChar.options.setuptrackersswitch = false
  end
  if(ArtemisDBChar.options.setuptrackersswitch) then
    Artemis.TrackerFrame_Initialize()
    ArtemisTrackerFrame:Show();
  else
    ArtemisTrackerFrame:Hide();
  end
end

--ArtemisDBChar.debug
function Artemis:toggleDebug() 
	local isChecked = Artemis.view.options.panel.debugCB:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.debug==nil) then
    ArtemisDBChar.options.debug = false
  end
  if isChecked then
    ArtemisDBChar.options.debug = true
    ArtemisDBChar.debug = true
  else
    ArtemisDBChar.options.debug = false
    ArtemisDBChar.debug = false
  end
end

--ArtemisDBChar.options.setuptrapsorientation
function Artemis:toggleCheckboxTrapsOrientVertical() 
	local isChecked = Artemis.view.options.panel.trapOrientCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setuptrapsorientation==nil) then
    ArtemisDBChar.options.setuptrapsorientation = false
  end
  if isChecked then
    ArtemisDBChar.options.setuptrapsorientation = true
  else
    ArtemisDBChar.options.setuptrapsorientation = false
  end
  if(ArtemisDBChar.options.setuptrapsswitch) then
    Artemis.TrapFrame_Initialize()
    ArtemisTrapFrame:Show();
  else
    ArtemisTrapFrame:Hide();
  end
end

function Artemis:toggleCheckboxAspectsOrientVertical() 
	local isChecked = Artemis.view.options.panel.aspectOrientCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setupaspectsorientation==nil) then
    ArtemisDBChar.options.setupaspectsorientation = false
  end
  if isChecked then
    ArtemisDBChar.options.setupaspectsorientation = true
  else
    ArtemisDBChar.options.setupaspectsorientation = false
  end
  if(ArtemisDBChar.options.setupaspectsswitch) then
    Artemis.AspectFrame_Initialize()
    ArtemisAspectFrame:Show();
  else
    ArtemisAspectFrame:Hide();
  end
end

function Artemis:toggleCheckboxTrackersOrientVertical() 
	local isChecked = Artemis.view.options.panel.trackersOrientCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setuptrackersorientation==nil) then
    ArtemisDBChar.options.setuptrackersorientation = false
  end
  if isChecked then
    ArtemisDBChar.options.setuptrackersorientation = true
  else
    ArtemisDBChar.options.setuptrackersorientation = false
  end
  if(ArtemisDBChar.options.setuptrackersswitch) then
    Artemis.TrackerFrame_Initialize()
    ArtemisTrackerFrame:Show();
  else
    ArtemisTrackerFrame:Hide();
  end
end

--ArtemisDBChar.options.setupfeedbutton
function Artemis:toggleCheckboxShowFeedButton() 
	local isChecked = Artemis.view.options.panel.feedButtonShowCheckBox :GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setupfeedbutton==nil) then
    ArtemisDBChar.options.setupfeedbutton = false
  end
  if isChecked then
    ArtemisDBChar.options.setupfeedbutton = true
  else
    ArtemisDBChar.options.setupfeedbutton = false
  end
  if(ArtemisDBChar.options.setupfeedbutton) then
    Artemis.SetupFeedPet()
    ArtemisMainFrame_FeedFrame:Show()
  else
    ArtemisMainFrame_FeedFrame:Hide()
  end
end


--ArtemisDBChar.options.setupfeedbuttonismacro
function Artemis:toggleCheckboxFeedButtonMacro() 
	local isChecked = Artemis.view.options.panel.feedButtonMacroCheckBox :GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if(ArtemisDBChar.options.setupfeedbuttonismacro==nil) then
    ArtemisDBChar.options.setupfeedbuttonismacro = false
  end
  if isChecked then
    ArtemisDBChar.options.setupfeedbuttonismacro = true
  else
    ArtemisDBChar.options.setupfeedbuttonismacro = false
  end
  if(ArtemisDBChar.options.setupfeedbutton) then
    Artemis.SetupFeedPet()
    ArtemisMainFrame_FeedFrame:Show()
  else
    ArtemisMainFrame_FeedFrame:Hide()
  end
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- ARTEMIS EOF
-------------------------------------------------------------------------