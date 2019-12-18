--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Traps Utils
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Traps Setup
-------------------------------------------------------------------------

function Artemis.TrapFrame_Initialize()
  Artemis.DebugMsg("TrapFrame_Initialize Called")
  --
  Artemis.Traps_NumTraps = 5;
  Artemis.Trap_Traps = {
    [L["Artemis_Trap_IMMOLATION"] ]= 0,
    [L["Artemis_Trap_FREEZING"]   ]= 0,
    [L["Artemis_Trap_FROST"]      ]= 0,
    [L["Artemis_Trap_EXPLOSIVE"]  ]= 0,
    [L["Artemis_Trap_SNAKE"]      ]= 0,
  }
  --Artemis.Trap_Traps[ L["Artemis_Trap_IMMOLATION"] ]= 0
  --Artemis.DebugMsg("TrapFrame_Initialize: test immo = ".. L["Artemis_Trap_IMMOLATION"] )

	-- Reset the available abilities.
  Artemis.DebugMsg("TrapFrame_Initialize: Reset the available abilities." )
	for spell, id in pairs( Artemis.Trap_Traps ) do
    Artemis.DebugMsg("TrapFrame_Initialize: Traps =" .. tostring(spell) )
		if (id > 0) then
			Artemis.Trap_Traps[spellName] = 0      
		end
	end
  
  --
  Artemis.DebugMsg("TrapFrame_Initialize: Setup abilities." )
  local i = 1
  while true do
    local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
    if not spellName then
      do break end
    end     
    -- use spellName and spellRank here
    --DEFAULT_CHAT_FRAME:AddMessage( spellName .. '(' .. spellRank .. ')' )
    --Artemis.DebugMsg("TrapFrame_Initialize: spellName=" .. tostring(spellName) .. '(' .. spellRank .. ')' )
    if (Artemis.Trap_Traps[spellName]) then
      Artemis.Trap_Traps[spellName] = i
      Artemis.DebugMsg("TrapFrame_Initialize: found a trap at idx: " .. tostring(i) )
    end
    i = i + 1
	end
  
  --
	local count = 0;
	for spell, id in pairs(Artemis.Trap_Traps) do
		if (id > 0) then
			count = count + 1;
      Artemis.DebugMsg("TrapFrame_Initialize: spell=" .. tostring(spell) )
			local button = getglobal("ArtemisTrapFrame_Trap"..count);
			button:SetAttribute("type", "spell");
			button:SetAttribute("spell", spell);
      local buttontext = getglobal("ArtemisTrapFrame_Trap"..count.."Icon");
            
      local textureName = GetSpellBookItemTexture(spell)      
      local tex = ArtemisTrapFrame:CreateTexture(textureName, "BACKGROUND")
      --tex:SetAllPoints()
      --tex:SetColorTexture(1, 1, 1, 0.5)
      --tex:SetTexture(textureName)
      
      if(textureName~=nil) then
        Artemis.DebugMsg("TrapFrame_Initialize: textureName=" .. tostring(textureName) )
        SetItemButtonTexture(button,textureName)
      else
        Artemis.DebugMsg("TrapFrame_Initialize: setting choice of texture")                
        buttontext:SetTexture("Interface\\Icons\\Ability_Druid_DemoralizingRoar");
      end
      
			button.SpellID = id;
			button:Show();
      
      --
      local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spell)
      --Artemis.PrintMsg("TrapFrame_Initialize: spell=" .. tostring(id) )
      --Artemis.view.buttonspelllist[spellId] = "ArtemisTrapFrame_Trap"..count.."Cooldown"
      local myCooldown = getglobal("ArtemisTrapFrame_Trap"..count.."Cooldown");
      Artemis.view.buttonspelllist[spellId] = {}
      Artemis.view.buttonspelllist[spellId].myCooldown = myCooldown
      Artemis.view.buttonspelllist[spellId].myType = "TRAP"

		end
	end
  
  -- Hide the buttons we don't need.
	for i = count + 1, Artemis.Traps_NumTraps, 1 do
		local button = getglobal("ArtemisTrapFrame_Trap"..i);
		button:Hide();
	end
  
  Artemis.DebugMsg("TrapFrame_Initialize: Orient: " .. tostring(ArtemisDBChar.options.setuptrapsorientation))     
  -- Vertical
  if( ArtemisDBChar.options.setuptrapsorientation) then
    ArtemisTrapFrame:SetSize(60,250);
    
    local pAnchor = getglobal("ArtemisTrapFrame_Anchor");      
    pAnchor:ClearAllPoints()
    pAnchor:SetPoint( "TOP", "ArtemisTrapFrame" , "TOP" , 0 , -12 )
      
    for count = 1, Artemis.Traps_NumTraps do
      local button = getglobal("ArtemisTrapFrame_Trap"..count);      
      button:ClearAllPoints()
      --obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
      button:SetPoint( "TOP", pAnchor , "BOTTOM" );
       pAnchor = button
    end
  end
  
  --Horizontal   <AbsDimension x="240" y="60"/>
  if( ArtemisDBChar.options.setuptrapsorientation==nil or not ArtemisDBChar.options.setuptrapsorientation ) then
    ArtemisTrapFrame:SetSize(250,60);
    
    local pAnchor = getglobal("ArtemisTrapFrame_Anchor");      
    pAnchor:ClearAllPoints()
    pAnchor:SetPoint( "LEFT", "ArtemisTrapFrame" , "LEFT" , 0 , -12 )
   
    for count = 1, Artemis.Traps_NumTraps do
      local button = getglobal("ArtemisTrapFrame_Trap"..count);      
      button:ClearAllPoints()
      --obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
      button:SetPoint( "LEFT", pAnchor , "RIGHT" );
      pAnchor = button
    end
  end
  
  --
  Artemis.Trap_UpdateLock()
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Traps Gui
-------------------------------------------------------------------------
function Artemis.TrapButton_OnEnter(self)
  --Artemis.DebugMsg("TrapButton_OnEnter Called");
  Artemis:ShowTooltip(self, self:GetAttribute("spell"), "TRAP" )
end

function Artemis.TrapButton_OnLeave()
  --Artemis.DebugMsg("TrapButton_OnLeave Called");
  GameTooltip:Hide()
end

function Artemis.Trap_ToggleLock()
  Artemis.DebugMsg("Trap_ToggleLock Called, is: " .. tostring(ArtemisDBChar.options.TrapFrameUnlocked));
	if(ArtemisDBChar.options.TrapFrameUnlocked) then
		ArtemisDBChar.options.TrapFrameUnlocked = false;
		Artemis.Trap_UpdateLock();
	else
		ArtemisDBChar.options.TrapFrameUnlocked = true;
		Artemis.Trap_UpdateLock();
	end
end

function Artemis.Trap_UpdateLock()
  Artemis.DebugMsg("Trap_UpdateLock Called");
	if(not ArtemisDBChar.options.TrapFrameUnlocked) then
		ArtemisTrapLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Up");
		ArtemisTrapLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Down");
		ArtemisTrapFrame_Back:Hide();
    ArtemisTrapFrame_Text:Hide();
    Artemis.DebugMsg("Trap_UpdateLock lock");
	else
		ArtemisTrapLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Up");
		ArtemisTrapLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Down");
		ArtemisTrapFrame_Back:Show();
    ArtemisTrapFrame_Text:Show();
    Artemis.DebugMsg("Trap_UpdateLock unlock");
	end
end

function Artemis.Trap_OnLoad()
  Artemis.DebugMsg("Trap_OnLoad Called");
  _, class = UnitClass("player");
  if class=="HUNTER" then
    --[[
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("LEARNED_SPELL_IN_TAB");
    this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
    --]]
  else
      ArtemisTrapFrame:Hide();
  end
end

function Artemis.Trap_OnEvent()
  Artemis.DebugMsg("Trap_OnEvent Called");
end


-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Traps Utils
-------------------------------------------------------------------------

function Artemis.TrapsPostClick(self)
  Artemis.printMsg("TrapsPostClick Called");
end

function Artemis.DoClickTrapButton_1()
  local button = getglobal("ArtemisTrapFrame_Trap"..1);
  button:Click("LeftButton",false)
end
function Artemis.DoClickTrapButton_2()
  local button = getglobal("ArtemisTrapFrame_Trap"..2);
  button:Click("LeftButton",false)
end
function Artemis.DoClickTrapButton_3()
  local button = getglobal("ArtemisTrapFrame_Trap"..3);
  button:Click("LeftButton",false)
end
function Artemis.DoClickTrapButton_4()
  local button = getglobal("ArtemisTrapFrame_Trap"..4);
  button:Click("LeftButton",false)
end
function Artemis.DoClickTrapButton_5()
  local button = getglobal("ArtemisTrapFrame_Trap"..5);
  button:Click("LeftButton",false)
end
function Artemis.DoClickTrapButton_6()
  local button = getglobal("ArtemisTrapFrame_Trap"..6);
  button:Click("LeftButton",false)
end



  
  -------------------------------------------------------------------------
-------------------------------------------------------------------------
