--[[	
*** Artemis ***
Written by : echomap
--]]

local _, L = ...;
-------------------------------------------------------------------------
-- Search Utils
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Search Gui Setup
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Search GUI Methods
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Search Methods
-------------------------------------------------------------------------
function Artemis:DoPetSearchLearnableSkills()
  Artemis.PrintMsg("You have these pet skills-->")
  Artemis.view.petskills = {}
  local tabName, tabTexture, tabOffset, numEntries = GetSpellTabInfo(1)
  for i=tabOffset + 1, tabOffset + numEntries do
    local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_PET)
    if(spellName~=nil ) then --and spellSubName~=nil
      Artemis.PrintMsg( "==> " .. spellName .. '(' .. tostring(spellSubName) .. ')' )
      Artemis.view.petskills[spellName] = spellSubName
    end
  end
  --Artemis.view.petskills
  --Artemis.Abilities
  Artemis.view.petcanlearn = {}
  
  local abilName = "arcane resistance 1"
  local abilTree = Artemis.Abilities[abilName]
  if(Artemis.view.petcanlearn[abilName]==nil) then
    Artemis.view.petcanlearn[abilName] = {}
  end
  local playerLevel = 40 //TODO
  
  if(abilTree.trainer) then
    if( abilTree["MinPetLevel"] <= playerLevel ) then
      if(Artemis.view.petcanlearn[abilName].trainer==nil) then
        Artemis.view.petcanlearn[abilName].trainer = {}
      end
      Artemis.view.petcanlearn[abilName].trainer[abilName] = true
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
        end
      end --for 
      
    end
  end
  
  --[[
  ["arcane resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Arcane Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  --]]
  
  Artemis.PrintMsg("<--")
end

-------------------------------------------------------------------------
-------------------------------------------------------------------------
