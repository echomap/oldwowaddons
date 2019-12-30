--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- WINDOW Methods
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-------------------------------------------------------------------------

-- Call when spells learned, and on load, to make sure addon knows player's pet spells
-- It scans the pet spellbok, which when a pet is out only shows what it can learn and you've taught it!
function Artemis.SetupKnownSpells()
  --Artemis.PrintMsg("SetupKnownSpells Called");
  if( ArtemisDBChar.petskills == nil) then
    ArtemisDBChar.petskills = {}
  end
  
  local numTabs = GetNumSpellTabs()
  --Artemis.PrintMsg( "numTabs: " .. tostring(numTabs) ) 
  local tabName, tabTexture, tabOffset, numEntries = GetSpellTabInfo(1)
  --Artemis.PrintMsg( "tabName: " .. tostring(tabName) ) 
  --Artemis.PrintMsg( "tabOffset: " .. tostring(tabOffset) ) 
  --Artemis.PrintMsg( "numEntries: " .. tostring(numEntries) ) 
  for i=tabOffset + 1, tabOffset + numEntries do
    local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_PET)
    if(spellName~=nil ) then --and spellSubName~=nil
      --Artemis.PrintMsg( "==> " .. spellName .. '(' .. tostring(spellSubName) .. ')' ) 
      local rankint = string.match(spellSubName, L["Artemis_Rank"] .." (%d+)" )
      ArtemisDBChar.petskills[spellName] = {}           
      ArtemisDBChar.petskills[spellName].rank     = rankint
      ArtemisDBChar.petskills[spellName].fullname = spellName .. " " .. rankint
      ArtemisDBChar.petskills[spellName].name = spellName
      ArtemisDBChar.petskills[spellName].spellSubName = spellSubName
    end
  end
  --Artemis.PrintMsg("SetupKnownSpells Done");
end


-------------------------------------------------------------------------
-- Search Methods
-------------------------------------------------------------------------
-- BETA/ALPHA
function Artemis:DoPetSearchLearnableSkills()
  
  --[[
  SelectCraft(1)
  Artemis.PrintMsg("trainer num=" ..tostring(GetNumTrainerServices() ) )
  local i, name, rank, category;
  for i=1,GetNumTrainerServices() do
    name, rank, category = GetTrainerServiceInfo(i);
    Artemis.PrintMsg("trainer name=" ..tostring(name) )
    if (name == nil) then
      break; -- GetNumTrainerServices() does not check if you're talking to a trainer or not.
    end
    if (category == "available") then
      DEFAULT_CHAT_FRAME:AddMessage(name .. " (" .. rank .. ")");
      Artemis.PrintMsg("name=" ..tostring(name) .. " rank: " ..tostring(rank) )
    end
  end
  
  local numberOfCrafts = GetNumCrafts();
  Artemis.PrintMsg("numberOfCrafts =" ..tostring(numberOfCrafts) )
--]]

  -- ugh! THIS DOESN'T WORK AS THE API DOESNT RETURN RANK!!!
  --[[
  for k, v in pairs(Artemis.Abilities_Base) do
    Artemis.PrintMsg("GetAbilitiesBase: k="..tostring(k))
    local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(k)
    Artemis.PrintMsg("GetAbilitiesBase: name="..tostring(name) .. " rank="..tostring(rank) )
  end
  --]]

  Artemis.PrintMsg("You have these pet skills-->")
  Artemis.view.havepetskills = {}
  Artemis.view.petskills = {}
  local tabName, tabTexture, tabOffset, numEntries = GetSpellTabInfo(1)
  for i=tabOffset + 1, tabOffset + numEntries do
    local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_PET)
    if(spellName~=nil ) then --and spellSubName~=nil
      local spellNamel    = string.lower(spellName)
      local spellSubNamel = string.lower(spellSubName )      
      Artemis.PrintMsg( "==> " .. spellNamel .. '(' .. tostring(spellSubNamel) .. ')' )
      local rankint = string.match(spellSubName, "Rank (%d+)" )
      --Artemis.PrintMsg( "  rankint: " .. tostring(rankint) )
      Artemis.view.petskills[spellName .. " " .. rankint ] = true
      Artemis.view.havepetskills[spellNamel]={}
      Artemis.view.havepetskills[spellNamel].rank = rankint
      Artemis.view.havepetskills[spellNamel].fullname = spellNamel .. " " .. rankint
    end
  end  
  Artemis.PrintMsg("<--")
    
  Artemis.view.petcanlearn = {}
  
  for kName, kTable in pairs(Artemis.Abilities) do
    Artemis.DebugMsg("SearchAbilities: kTable="..tostring(kTable))
    Artemis.PetSkillsSearchForAbility2(kName, kTable)    
  end
  --[[
  for kName, kTable in pairs(Artemis.Ability_List) do
    Artemis.DebugMsg("SearchAbilities: kTable="..tostring(kTable))
    --Artemis.PetSkillsSearchForAbility(kTable)
  end
  --]]
  --TODO Artemis.PetSkillsPrint()
end

-- BETA/ALPHA
function Artemis.PetSkillsSearchForAbility2(abilName, abilTable)
  --Artemis.PrintMsg("PetSkillsSearchForAbility2 Called,  abilName: " .. tostring(abilName) )
  --if(Artemis.view.havepetskills[abilName]) then
  --  return
  --end
  local family = abilTable["AbilityFamily"]
  local rank   = abilTable ["AbilityLevel"]
  --Artemis.PrintMsg("PetSkillsSearchForAbility2 family: '" .. tostring(family) .. "' rank: '" .. tostring(rank) .."'" )

  local haveAlready = false
  local havePS = Artemis.view.havepetskills[family]  
  if(havePS~=nil) then
    --Artemis.PrintMsg("PetSkillsSearchForAbility2 havePS")
    local ranki = tonumber(rank)
    local rankl = tonumber(havePS.rank)
    if( rankl >= ranki) then
      haveAlready = true
      --Artemis.PrintMsg("PetSkillsSearchForAbility2 have==true")
    end
  end
  if(not haveAlready) then
    --Artemis.PrintMsg("PetSkillsSearchForAbility2 haveAlready: " .. tostring(haveAlready) )
    local trainer      = abilTable["trainer"]
    local minPetlevel  = abilTable["MinPetLevel"]    
    local minPetleveli = tonumber(minPetlevel)
    local playerLevel  = UnitLevel("player")
    local petLevel     = UnitLevel("pet")
    if( playerLevel >= minPetlevel) then
      Artemis.PrintMsg("PetSkillsSearchForAbility2 Could learn petskill: ".. family .." Rank "..rank)        
      Artemis.view.petcanlearn[family] = rank
    end     
  end
  --Artemis.PrintMsg("You can learn these new pet skills-->")
  
  --Artemis.PrintMsg("<--")
  --
end

-- BETA/ALPHA
--[[
function Artemis.PetSkillsPrint()  
  --2 Print for Ability
  --Artemis.view.petcanlearn[abilName].trainer
  --Artemis.view.petcanlearn.trainer[abilName]
  Artemis.PrintMsg("Trainer can teach-->")
  for kName, kBool in pairs(Artemis.view.petcanlearn.trainer) do
    if(kBool) then
      Artemis.PrintMsg("Ability="..tostring(kName))
    end
  end
  Artemis.DebugMsg("<--(Trainer can teach)")
  
  Artemis.PrintMsg("Animals can learn from-->")
  for kName, kValue in pairs(Artemis.view.petcanlearn) do
    if(kValue==nil or kValue.animals==nil ) then
      Artemis.PrintMsg("NO data for ability: '"..tostring(kName).."'")
    elseif( not kValue.trainer ) then
      for kName, kTable in pairs(kValue.animals) do
        Artemis.PrintMsg("kName="..tostring(kName))
      end
    end
  end
  Artemis.PrintMsg("<--(Animals can learn from)")
end
--]]


--[[
  ["bite 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Params"] = { 7,9 },
    ["Text"] = "Bite the enemy, causing 7 to 9 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 1,
  } ,
--]]


function Artemis.PetSkillsSearchForAbility(abilName) 
  --local abilName = "arcane resistance 1"
  Artemis.DebugMsg("PetSkillsSearchForAbility Called,  abilName: " .. tostring(abilName) )
  if(Artemis.view.petskills[abilName]) then
    return
  end
  
  --1 Parse for Ability
  local abilTree = Artemis.Abilities[abilName]
  if(Artemis.view.petcanlearn[abilName]==nil) then
    Artemis.view.petcanlearn[abilName] = {}    
  end
  local playerLevel = UnitLevel("player")
  --Artemis.PrintMsg("spell can be trained? " .. tostring(abilTree.trainer) )
  if(abilTree.trainer) then
    --Artemis.PrintMsg("spell MinPetLevel? " .. tostring( abilTree["MinPetLevel"] ) )
    --Artemis.PrintMsg("spell playerLevel? " .. tostring( playerLevel ) )
    if( abilTree["MinPetLevel"] <= playerLevel ) then
      if(Artemis.view.petcanlearn[abilName].trainer==nil) then
        Artemis.view.petcanlearn[abilName].trainer = {}
      end
      Artemis.view.petcanlearn[abilName].trainer = true
      if(Artemis.view.petcanlearn.trainer==nil) then
        Artemis.view.petcanlearn.trainer = {}
      end
      Artemis.view.petcanlearn.trainer[abilName] = true
    end    
  else
    if(Artemis.view.petcanlearn[abilName].animals==nil) then
      Artemis.view.petcanlearn[abilName].animals = {}
    end
    if(Artemis.view.petcanlearn[abilName].locations==nil) then
      Artemis.view.petcanlearn[abilName].locations = {}
    end
    local abilTame = abilTree["TamingList"]
    if(abilTame~=nil) then
      for kName, kTable in pairs(abilTame) do
        Artemis.DebugMsg("SearchAbilities: kName="..tostring(kName))
        local kMinL = kTable["MinLvl"]
        --local kMaxL = kTable["MaxLvl"]
        if(minLvl~=nil and minLvl <= playerLevel ) then
          local loc =  kTable["location"]
          -- add to table Artemis.view.petcanlearn[abilName].animals
          if(Artemis.view.petcanlearn[abilName].locations[loc]==nil) then
            Artemis.view.petcanlearn[abilName].locations[loc] = {}
          end
          -- add to table Artemis.view.petcanlearn[abilName].locations[loc]
          table.insert( Artemis.view.petcanlearn[abilName].animals , kTable )
          table.insert( Artemis.view.petcanlearn[abilName].locations[loc] , kTable )
        end
      end --for 
    end
  end
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------