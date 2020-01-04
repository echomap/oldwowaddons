--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Setup GUI Methods
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
	--Artemis.PrintMsg("SetupPetSkillsWindow Called")
  --
 	--Artemis.PrintMsg("SetupPetSkillsWindow Done")
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
	--Artemis.PrintMsg("InitPetSkillsWindow Called")
  
  -- ArtemisPetSearchFrameLeftSideFrame
  -- Default first one
  
  -- Fill in the dropdown with all ranks
  -- Artemis.Abilities_Base ("trainer" and "MaxLevel")
  -- Default first one
  
  -- Allow picking of ability and rank
  --   
end

-------------------------------------------------------------------------
-- GUI Methods
-------------------------------------------------------------------------

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
-- Util Methods
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
  
    local abBaseMax = 0 -- #Artemis.view.MyModData  why doesnt this work later here?
    for i,v in pairs(Artemis.Abilities_Base) do
      abBaseMax = abBaseMax + 1
      Artemis.view.MyModData[abBaseMax] = i      
      --Artemis.PrintMsg("Artemis.view.MyModData[i]: " .. tostring(Artemis.view.MyModData[i]))
    end
    Artemis.view.MyModDataMax = abBaseMax
  end  
  
  local line; -- 1 through 5 of our window to scroll
  local lineplusoffset; -- an index into our data calculated from the scroll offset
  FauxScrollFrame_Update(ArtemisPetSearchFrameLeftSideFrame,50,5,16);
  --Artemis.PrintMsg("PetSkillsAbilityScrollBar_Update reset data")
  
  --Artemis.PrintMsg("Abilities_Base max " .. tostring(#Artemis.Abilities_Base))
  --Artemis.PrintMsg("Artemis.view.MyModData max " .. tostring(#Artemis.view.MyModData))  
  --Artemis.PrintMsg("abBaseMax max " .. tostring(Artemis.view.MyModDataMax))
  
  for line=1,10 do
    lineplusoffset = line + FauxScrollFrame_GetOffset(ArtemisPetSearchFrameLeftSideFrame);
    if lineplusoffset <= Artemis.view.MyModDataMax then --Ability_Base_List then
      --Artemis.PrintMsg("Abilities_Base lineplusoffset " .. tostring(lineplusoffset))
      --Artemis.PrintMsg("data name: " .. tostring(Artemis.view.MyModData[lineplusoffset]))
      --Artemis.PrintMsg("data2: " .. tostring(Artemis.Abilities_Base[Artemis.view.MyModData[lineplusoffset]]))
      getglobal("MyModEntry"..line):SetText(Artemis.view.MyModData[lineplusoffset]);
      getglobal("MyModEntry"..line).moddata = Artemis.Abilities_Base[Artemis.view.MyModData[lineplusoffset]]
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
       
      --local abilityFamily = Artemis.AbilityFamily [Artemis.view.selectPetAbility]
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
      local textAll = ""
      textAll = textAll.. "  MinLvl: " .. abilityDetails["MinPetLevel"] .. "\n"
      textAll = textAll.. "  Text: \n" .. abilityDetails["Text"] .. "\n"
      textAll = textAll.. "  TamingList: " -- .. abilityDetails["TamingList"] .. "\n"       
      
      textAll = textAll.. "\n"
      if(TamingList~=nil) then
        textAll = textAll.. "\n"
        for i,v in pairs(TamingList) do
          textAll = textAll.. " name: " ..i.. "  lvl: " ..v["MinLvl"].. " - " .. v["MaxLvl"].. "\n"
          textAll = textAll.. "  location:" .. v["location"] .. "\n"
          --textAll = textAll.. "  Min Lvl:" .. v["MinLvl"] .. "\n"
          --textAll = textAll.. "  Max Lvl:" .. v["MaxLvl"] .. "\n"
          --v["type"]   = family,
          --v["MinLvl"] = minlvl,
          --v["MaxLvl"] = maxlvl, 
          --v["location"] = location
        end
      else
        textAll = textAll.. "<None Found>"  
      end
      
      --ArtemisPetSearchTitleText:SetText(nameNew)
      ArtemisPetSearchFrameDataText:SetText( textAll ) 
      
    end
    
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------
