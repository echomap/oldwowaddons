--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Options
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
    ArtemisDBChar.options.pethappinesswitch   = true
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
    debugCB:SetPoint("TOPLEFT", enabledCB, "TOPRIGHT", 50, -20)    
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
    
        --
    local petTPCheckBox = CreateFrame( "CheckButton", "PetTPEnabledCB",frame,"OptionsCheckButtonTemplate" )
    expPercentCheckBox:SetText("Training Points Enabled")    
    _G[ "PetTPEnabledCB" .. "Text" ]:SetText( "Training Points Enabled")    
    petTPCheckBox:SetPoint("TOPLEFT", Artemis.view.options.panel.expPercentCheckBox, "TOPRIGHT", 180, 0)
    petTPCheckBox:SetScript( "OnClick", Artemis.toggleCheckboxPetTrainingPoints )
    if(ArtemisDBChar.options.pettrainingpointsswitch) then
      petTPCheckBox:SetChecked(true)
      ArtemisDBChar.options.pettrainingpointsswitch = true
      Artemis.DebugMsg("PetExp Perc is true");
    else
      petTPCheckBox:SetChecked(false)
      ArtemisDBChar.options.pettrainingpointsswitch = false
      Artemis.DebugMsg("PetExp Perc is false");
    end    
    Artemis.view.options.panel.petTPCheckBox = petTPCheckBox

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
  --lCheckBox:SetPoint( "TOPLEFT", 20, -50 )
  lCheckBox:SetPoint("TOPLEFT", parentposition, "TOPLEFT", 0, -40)
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
    Artemis.ShowPetRelatedFrames()
  else
    Artemis.HidePetRelatedFrames()
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
    Artemis.ShowPetRelatedFrames()
  else
    Artemis.HidePetRelatedFrames()
  end
end


--ArtemisDBChar.options.pettrainingpointsswitch
function Artemis.toggleCheckboxPetTrainingPoints() 
	local isChecked = Artemis.view.options.panel.petTPCheckBox:GetChecked()
  if(ArtemisDBChar.options==nil) then
    ArtemisDBChar.options = {}
  end
  if isChecked then
    ArtemisDBChar.options.pettrainingpointsswitch = true
  else
    ArtemisDBChar.options.pettrainingpointsswitch = false
  end
  
  if(ArtemisDBChar.options.pettrainingpointsswitch) then
    Artemis.ShowPetRelatedFrames()
  else
    Artemis.HidePetRelatedFrames()
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
-- Options
-------------------------------------------------------------------------
