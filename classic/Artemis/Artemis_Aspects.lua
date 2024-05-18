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
	Artemis.Aspect_NumAspects = 7;
	Artemis.Aspect_Aspects = {
	[L["Artemis_Aspect_Monkey"]  ]= 0,
	[L["Artemis_Aspect_Cheetah"] ]= 0,
	[L["Artemis_Aspect_Pack"]    ]= 0,
	[L["Artemis_Aspect_Hawk"]    ]= 0,
	[L["Artemis_Aspect_Beast"]   ]= 0,
	[L["Artemis_Aspect_Wild"]    ]= 0,
	[L["Artemis_Aspect_Viper"]    ]= 0, --check what patch this is in?
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
	--Artemis.DebugMsg("AspectFrame_Initialize: Setup abilities." )
	--To collect the levels we've used, so it doesn't downrank
	Artemis.view.skillscollected = {}
	local i = 1
	while true do
		local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end     
		-- use spellName and spellRank here
		--DEFAULT_CHAT_FRAME:AddMessage( spellName .. '(' .. spellRank .. ')' )
		if (Artemis.Aspect_Aspects[spellName]) then
			--Artemis.DebugMsg("AspectFrame_Initialize: spellName=" .. tostring(spellName) .. '(' .. tostring(spellRank) .. ')')
			Artemis.Aspect_Aspects[spellName] = i
			Artemis.DebugMsg("AspectFrame_Initialize: found Aspect("..spellName.. ") at idx: " .. tostring(i) )
		end
		i = i + 1
	end
	
	-- Check current User Buffs
	local buffs = { }
	local idx   = 1;
	local buff = UnitBuff("player", idx);
	while buff do
		buffs[buff] = buff;
		idx = idx + 1;
		buff = UnitBuff("player", idx);
	end;

	--
	Artemis.DebugMsg("AspectFrame_Initialize: Setup abilities 2." )
	local count = 0;
	for spell, id in pairs(Artemis.Aspect_Aspects) do
		if (id > 0) then
			local sname, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spell)
			--
			Artemis.DebugMsg("AspectFrame_Initialize: spell=" .. tostring(spell).." id=" ..tostring(id).. " spellid="..tostring(spellId) )
			if(spellId~=nil) then
				local isKnown = IsSpellKnown(spellId)
				Artemis.DebugMsg("AspectFrame_Initialize: spell=" .. tostring(sname).." isKnown=" .. tostring(isKnown) )
				if(isKnown) then
					--Artemis.PrintMsg("AspectFrame_Initialize: spell=" .. tostring(id) )
					--Artemis.view.buttonspelllist[spellId] = "ArtemisAspectFrame_Aspect"..count.."Cooldown"
					
					--
					count = count + 1;
					--Artemis.DebugMsg("AspectFrame_Initialize: spell=" .. tostring(spell) )
					local button = getglobal("ArtemisAspectFrame_Aspect"..count);
					button:SetAttribute("type", "spell");
					button:SetAttribute("spell", spell);
					local buttontext = getglobal("ArtemisAspectFrame_Aspect"..count.."Icon");
					
					--
					local myCooldown = getglobal("ArtemisAspectFrame_Aspect"..count.."Cooldown");
					Artemis.view.buttonspelllist[spellId] = {}
					Artemis.view.buttonspelllist[spellId].myCooldown = myCooldown
					Artemis.view.buttonspelllist[spellId].myType = "ASPECT"
					Artemis.view.buttonspelllist[spellId].spellname = spell
					
					--local textureName = GetSpellBookItemTexture(spell)      
					local textureName = GetSpellBookItemTexture(id,BOOKTYPE_SPELL)      
					local tex = ArtemisAspectFrame:CreateTexture(textureName, "BACKGROUND")
					Artemis.DebugMsg("AspectFrame_Initialize: get textureName=" .. tostring(textureName) )
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
					if(textureName~=nil) then
						button:Show();
						Artemis.view.buttonspelllist[spellId].button = button
						--button:SetButtonState("PUSHED")
						Artemis.CheckAspectBuffs(spell)
						--if( buffs[spell] ~=nil ) then
						--	SetItemButtonDesaturated(button,true)
						--end	
					end
				end
			end
		end
	end --for
	
	-- Hide the buttons we don't need.
	for i = count + 1, Artemis.Aspect_NumAspects, 1 do
		local button = getglobal("ArtemisAspectFrame_Aspect"..i);
		button:Hide();
	end
  
	Artemis.DebugMsg("AspectFrame_Initialize: Orient: " .. tostring(ArtemisDBChar.options.setupaspectsorientation))     
	-- Vertical
	if( ArtemisDBChar.options.setupaspectsorientation) then
		ArtemisAspectFrame:SetSize(60,250);

		local pAnchor = getglobal("ArtemisAspectFrame_Anchor");      
		pAnchor:ClearAllPoints()
		pAnchor:SetPoint( "TOP", "ArtemisAspectFrame" , "TOP" , 0 , -12 )

		for count = 1, Artemis.Aspect_NumAspects do
			local button = getglobal("ArtemisAspectFrame_Aspect"..count);      
			button:ClearAllPoints()
			--obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
			button:SetPoint( "TOP", pAnchor , "BOTTOM" );
			pAnchor = button
		end
	end

  --Horizontal   <AbsDimension x="240" y="60"/>
  if( ArtemisDBChar.options.setupaspectsorientation==nil or not ArtemisDBChar.options.setupaspectsorientation ) then
    ArtemisAspectFrame:SetSize(250,60);
    
    local pAnchor = getglobal("ArtemisAspectFrame_Anchor");      
    pAnchor:ClearAllPoints()
    pAnchor:SetPoint( "LEFT", "ArtemisAspectFrame" , "LEFT" , 0 , -12 )
   
    for count = 1, Artemis.Aspect_NumAspects do
      local button = getglobal("ArtemisAspectFrame_Aspect"..count);      
      button:ClearAllPoints()
      --obj:SetPoint(point, relativeTo, relativePoint, ofsx, ofsy);
      button:SetPoint( "LEFT", pAnchor , "RIGHT" );
      pAnchor = button
    end
  end
  
  --
  Artemis.Aspect_UpdateLock()
  
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Aspect Gui
-------------------------------------------------------------------------
function Artemis.AspectButton_OnEnter(self)
  --Artemis.DebugMsg("AspectButton_OnEnter Called" .. tostring(self) );
  Artemis:ShowTooltip(self, self:GetAttribute("spell"), "ASPECT" )
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
