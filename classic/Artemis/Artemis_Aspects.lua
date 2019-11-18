--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Aspect Utils
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Aspect Setup
-------------------------------------------------------------------------

function Artemis.AspectFrame_Initialize()
  Artemis.DebugMsg("AspectFrame_Initialize Called")
  --
  Artemis.Aspect_NumAspects = 6;
  Artemis.Aspect_Aspects = {
    [L["Artemis_Aspec_Monkey"]  ]= 0,
    [L["Artemis_Aspec_Cheetah"] ]= 0,
    [L["Artemis_Aspec_Pack"]    ]= 0,
    [L["Artemis_Aspec_Hawk"]    ]= 0,
    [L["Artemis_Aspec_Beast"]   ]= 0,
    [L["Artemis_Aspec_Wild"]    ]= 0,
  }

	-- Reset the available abilities.
  Artemis.DebugMsg("AspectFrame_Initialize: Reset the available abilities." )
	for spell, id in pairs( Artemis.Aspect_Aspects ) do
    Artemis.DebugMsg("AspectFrame_Initialize: Aspects =" .. tostring(spell) )
		if (id > 0) then
			Artemis.Aspect_Aspects[spellName] = 0      
		end
	end
  
  --
  Artemis.DebugMsg("AspectFrame_Initialize: Setup abilities." )
  local i = 1
  while true do
    local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
    if not spellName then
      do break end
    end     
    -- use spellName and spellRank here
    if (Artemis.Aspect_Aspects[spellName]) then
      Artemis.Aspect_Aspects[spellName] = i
      Artemis.DebugMsg("AspectFrame_Initialize: found a Aspect at idx: " .. tostring(i) )
    end
    i = i + 1
	end
  
  --
	local count = 0;
	for spell, id in pairs(Artemis.Aspect_Aspects) do
		if (id > 0) then
			count = count + 1;
      Artemis.DebugMsg("AspectFrame_Initialize: spell=" .. tostring(spell) )
			local button = getglobal("ArtemisAspectFrame_Aspect"..count);
			button:SetAttribute("type", "spell");
			button:SetAttribute("spell", spell);
      local buttontext = getglobal("ArtemisAspectFrame_Aspect"..count.."Icon");
      
      local textureName = GetSpellBookItemTexture(spell)      
      local tex = ArtemisAspectFrame:CreateTexture(textureName, "BACKGROUND")
      --tex:SetAllPoints()
      --tex:SetColorTexture(1, 1, 1, 0.5)
      --tex:SetTexture(textureName)
      
      if(textureName~=nil) then
        Artemis.DebugMsg("AspectFrame_Initialize: textureName=" .. tostring(textureName) )
        SetItemButtonTexture(button,textureName)
      else
        Artemis.DebugMsg("AspectFrame_Initialize: setting choice of texture")                
        buttontext:SetTexture("Interface\\Icons\\Ability_Druid_DemoralizingRoar");
      end
      
			button.SpellID = id;
			button:Show();
		end
	end
  
  -- Hide the buttons we don't need.
	for i = count + 1, Artemis.Aspect_NumAspects, 1 do
		local button = getglobal("ArtemisAspectFrame_Aspect"..i);
		button:Hide();
	end
  
  Artemis.Aspect_UpdateLock()
  
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Aspect Gui
-------------------------------------------------------------------------
function Artemis.AspectButton_OnEnter(self)
  Artemis.DebugMsg("AspectButton_OnEnter Called" .. tostring(self) );
  Artemis:ShowTooltip(self, self:GetAttribute("spell") )
end

function Artemis.AspectButton_OnLeave(self)
  --Artemis.DebugMsg("AspectButton_OnLeave Called");
   GameTooltip:Hide()
end

function Artemis.Aspect_ToggleLock()
  Artemis.DebugMsg("Aspect_ToggleLock Called, is: " .. tostring(ArtemisDBChar.options.AspectFrameUnlocked));
	if(ArtemisDBChar.options.AspectFrameUnlocked) then
		ArtemisDBChar.options.AspectFrameUnlocked = false;
		Artemis.Aspect_UpdateLock();
	else
		ArtemisDBChar.options.AspectFrameUnlocked = true;
		Artemis.Aspect_UpdateLock();
	end
end

function Artemis.Aspect_UpdateLock()
  Artemis.DebugMsg("Aspect_UpdateLock Called");
	if(not ArtemisDBChar.options.AspectFrameUnlocked) then
		ArtemisAspectLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Up");
		ArtemisAspectLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Locked-Down");
		ArtemisAspectFrame_Back:Hide();
    ArtemisAspectFrame_Text:Hide();
    Artemis.DebugMsg("Aspect_UpdateLock lock");
	else
		ArtemisAspectLockNorm:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Up");
		ArtemisAspectLockPush:SetTexture("Interface\\AddOns\\Artemis\\Media\\LockButton-Unlocked-Down");
		ArtemisAspectFrame_Back:Show();
    ArtemisAspectFrame_Text:Show();
    Artemis.DebugMsg("Aspect_UpdateLock unlock");
	end
end

function Artemis.Aspect_OnLoad()
  Artemis.DebugMsg("Aspect_OnLoad Called");
  _, class = UnitClass("player");
  if class=="HUNTER" then
    --[[
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("SPELLS_CHANGED");
    this:RegisterEvent("LEARNED_SPELL_IN_TAB");
    this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
    --]]
  else
      ArtemisAspectFrame:Hide();
  end
end

function Artemis.Aspect_OnEvent()
  Artemis.DebugMsg("Aspect_OnEvent Called");
end


-------------------------------------------------------------------------
-------------------------------------------------------------------------
