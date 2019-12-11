--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Tracker Utils
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Tracker Setup
-------------------------------------------------------------------------

function Artemis.TrackerFrame_Initialize()
  Artemis.DebugMsg("TrackerFrame_Initialize Called")
  --
  Artemis.Tracker_NumTrackers = 8;
  Artemis.Tracker_Trackers = {
    [ L["Artemis_Track_Beasts"]    ] = 0,
    [ L["Artemis_Track_Humanoids"] ] = 0,
    [ L["Artemis_Track_Undead"]    ] = 0,
    [ L["Artemis_Track_Hidden"]    ] = 0,
    [ L["Artemis_Track_Elementals"]] = 0,
    [ L["Artemis_Track_Demons"]    ]= 0,
    [ L["Artemis_Track_Giants"]    ] = 0,
    [ L["Artemis_Track_Dragonkin"] ] = 0,
  }

	-- Reset the available abilities.
  Artemis.DebugMsg("TrackerFrame_Initialize: Reset the available abilities." )
	for spell, id in pairs( Artemis.Tracker_Trackers ) do
    Artemis.DebugMsg("TrackerFrame_Initialize: Trackers =" .. tostring(spell) )
		if (id > 0) then
			Artemis.Tracker_Trackers[spellName] = 0      
		end
	end
  
  --
  Artemis.DebugMsg("TrackerFrame_Initialize: Setup abilities." )
  local i = 1
  while true do
    local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
    if not spellName then
      do break end
    end     
    -- use spellName and spellRank here
    if (Artemis.Tracker_Trackers[spellName]) then
      Artemis.Tracker_Trackers[spellName] = i
      Artemis.DebugMsg("TrackerFrame_Initialize: found a Tracker at idx: " .. tostring(i) )
    end
    i = i + 1
	end
  
  --
	local count = 0;
	for spell, id in pairs(Artemis.Tracker_Trackers) do
		if (id > 0) then
			count = count + 1;
      Artemis.DebugMsg("TrackerFrame_Initialize: spell=" .. tostring(spell) )
			local button = getglobal("ArtemisTrackerFrame_Tracker"..count);
			button:SetAttribute("type", "spell");
			button:SetAttribute("spell", spell);
      local buttontext = getglobal("ArtemisTrackerFrame_Tracker"..count.."Icon");
      
      local textureName = GetSpellBookItemTexture(spell)      
      local tex = ArtemisTrackerFrame:CreateTexture(textureName, "BACKGROUND")
      --tex:SetAllPoints()
      --tex:SetColorTexture(1, 1, 1, 0.5)
      --tex:SetTexture(textureName)
      
      if(textureName~=nil) then
        Artemis.DebugMsg("TrackerFrame_Initialize: textureName=" .. tostring(textureName) )
        SetItemButtonTexture(button,textureName)
      else
        Artemis.DebugMsg("TrackerFrame_Initialize: setting choice of texture")                
        buttontext:SetTexture("Interface\\Icons\\Ability_Druid_DemoralizingRoar");
      end
      
			button.SpellID = id;
			button:Show();
		end
	end
  
  -- Hide the buttons we don't need.
	for i = count + 1, Artemis.Tracker_NumTrackers, 1 do
		local button = getglobal("ArtemisTrackerFrame_Tracker"..i);
    if(button~=nil) then
      button:Hide();
    end
	end
  
  Artemis.DebugMsg("TrackerFrame_Initialize: Orient: " .. tostring(ArtemisDBChar.options.setuptrackersorientation))     
  -- Vertical
  if( ArtemisDBChar.options.setuptrackersorientation) then
    ArtemisTrackerFrame:SetSize(60,250);
    
    local pAnchor = getglobal("ArtemisTrackerFrame_Anchor");      
    pAnchor:ClearAllPoints()
    pAnchor:SetPoint( "TOP", "ArtemisTrackerFrame" , "TOP" , 0 , -12 )
      
    for count = 1, Artemis.Tracker_NumTrackers do
      local button = getglobal("ArtemisTrackerFrame_Tracker"..count);      
      button:ClearAllPoints()
      --obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
      button:SetPoint( "TOP", pAnchor , "BOTTOM" );
       pAnchor = button
    end
  end
  
  --Horizontal   <AbsDimension x="240" y="60"/>
  if( ArtemisDBChar.options.setuptrackersorientation==nil or not ArtemisDBChar.options.setuptrackersorientation ) then
    ArtemisTrackerFrame:SetSize(250,60);
    
    local pAnchor = getglobal("ArtemisTrackerFrame_Anchor");      
    pAnchor:ClearAllPoints()
    pAnchor:SetPoint( "LEFT", "ArtemisTrackerFrame" , "LEFT" , 0 , -12 )
   
    for count = 1, Artemis.Tracker_NumTrackers do
      local button = getglobal("ArtemisTrackerFrame_Tracker"..count);      
      button:ClearAllPoints()
      --obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
      button:SetPoint( "LEFT", pAnchor , "RIGHT" );
      pAnchor = button
    end
  end
  
  --
  Artemis.Tracker_UpdateLock()
  
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Tracker Gui
-------------------------------------------------------------------------
function Artemis.TrackerButton_OnEnter(self)
  Artemis.DebugMsg("TrackerButton_OnEnter Called" .. tostring(self) );
  Artemis:ShowTooltip(self, self:GetAttribute("spell", "TRACKER") )
end

function Artemis.TrackerButton_OnLeave(self)
  --Artemis.DebugMsg("TrackerButton_OnLeave Called");
   GameTooltip:Hide()
end

function Artemis.Tracker_ToggleLock()
  Artemis.DebugMsg("Tracker_ToggleLock Called, is: " .. tostring(ArtemisDBChar.options.TrackerFrameUnlocked));
	if(ArtemisDBChar.options.TrackerFrameUnlocked) then
		ArtemisDBChar.options.TrackerFrameUnlocked = false;
		Artemis.Tracker_UpdateLock();
	else
		ArtemisDBChar.options.TrackerFrameUnlocked = true;
		Artemis.Tracker_UpdateLock();
	end
end

function Artemis.Tracker_UpdateLock()
  Artemis.DebugMsg("Tracker_UpdateLock Called");
	if(not ArtemisDBChar.options.TrackerFrameUnlocked) then
		ArtemisTrackerLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Up");
		ArtemisTrackerLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Down");
		ArtemisTrackerFrame_Back:Hide();
    ArtemisTrackerFrame_Text:Hide();
    Artemis.DebugMsg("Tracker_UpdateLock lock");
	else
		ArtemisTrackerLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Up");
		ArtemisTrackerLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Down");
		ArtemisTrackerFrame_Back:Show();
    ArtemisTrackerFrame_Text:Show();
    Artemis.DebugMsg("Tracker_UpdateLock unlock");
	end
end

function Artemis.Tracker_OnLoad()
  Artemis.DebugMsg("Tracker_OnLoad Called");
  _, class = UnitClass("player");
  if class=="HUNTER" then
    --[[
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("LEARNED_SPELL_IN_TAB");
    this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
    --]]
  else
      ArtemisTrackerFrame:Hide();
  end
end

function Artemis.Tracker_OnEvent()
  Artemis.DebugMsg("Tracker_OnEvent Called");
end


-------------------------------------------------------------------------
-------------------------------------------------------------------------
