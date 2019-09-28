--[[	
*** Artemis ***
Written by : echomap
--]]

Artemis.Ability_Base_List = {
  "Bite",
  "Charge",
  "Claw",
  "Cower",
  "Dash",
  "Dive",
  "Furious Howl",
  "Lightning Breath",
  "Prowl",
  "Scorpid Poison",
  "Screech",
  "Shell Shield",
  "Thunderstomp",
  "Arcane Resistance",
  "Fire Resistance",
  "Frost Resistance",
  "Great Stamina",
  "Growl",
  "Natural Armor",
  "Nature Resistance",
  "Shadow Resistance",
}

Artemis.Abilities_Base = {
  ["Bite"] = {
      ["trainer"] = false ,
      ["MaxLevel"] = 8 ,
    } ,
  ["Charge"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["Claw"] = {
      ["trainer"] = false , ["MaxLevel"] = 8 ,
    } ,
  ["Cower"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["Dash"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["Dive"] = {
      ["trainer"] = false , ["MaxLevel"] = 0 ,
    } ,
  ["Furious Howl"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["Lightning Breath"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["Prowl"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["Scorpid Poison"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["Screech"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["Shell Shield"] = {
      ["trainer"] = false , ["MaxLevel"] = 1 ,
    } ,
  ["Thunderstomp"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["Arcane Resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 0 ,
    } ,
  ["Fire Resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 0 ,
    } ,
  ["Frost Resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 0 ,
    } ,
  ["Great Stamina"] = {
      ["trainer"] = true , ["MaxLevel"] = 10 ,
    } ,
  ["Growl"] = {
      ["trainer"] = true , ["MaxLevel"] = 7 ,
    } ,
  ["Natural Armor"] = {
      ["trainer"] = true , ["MaxLevel"] = 10 ,
    } ,
  ["Nature Resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
  ["Shadow Resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
}


Artemis.Ability_List = {
  "Bite 1", "Bite 2", "Bite 3", "Bite 4", "Bite 5", "Bite 6", "Bite 7", "Bite 8",
  "Charge 1","Charge 2","Charge 3","Charge 4","Charge 5","Charge 6",
  "Claw 1","Claw 2","Claw 3","Claw 4","Claw 5","Claw 6","Claw 7","Claw 8",
  "Cower 1","Cower 2","Cower 3","Cower 4","Cower 5","Cower 6",
  "Dash 1","Dash 2","Dash 3",
  "Dive 1","Dive 2","Dive 3",
  "Furious Howl 1","Furious Howl 2","Furious Howl 3","Furious Howl 4",
  "Lightning Breath 1","Lightning Breath 2","Lightning Breath 3","Lightning Breath 4",
      "Lightning Breath 5","Lightning Breath 6",
  "Prowl 1", "Prowl 2", "Prowl 3",
  "Scorpid Poison 1", "Scorpid Poison 2", "Scorpid Poison 3", "Scorpid Poison 4",
  "Screech 1", "Screech 2", "Screech 3", "Screech 4",
  "Shell Shield 1",
  "Thunderstomp 1","Thunderstomp 2","Thunderstomp 3",
  "Arcane Resistance 1", "Arcane Resistance 2", "Arcane Resistance 3", "Arcane Resistance 4", "Arcane Resistance 5",
  "Fire Resistance 1", "Fire Resistance 2", "Fire Resistance 3", "Fire Resistance 4", "Fire Resistance 5",
  "Frost Resistance 1", "Frost Resistance 2", "Frost Resistance 3", "Frost Resistance 4", "Frost Resistance 5",
  "Great Stamina 1", "Great Stamina 2", "Great Stamina 3", "Great Stamina 4", "Great Stamina 5",
      "Great Stamina 6", "Great Stamina 7", "Great Stamina 8", "Great Stamina 9", "Great Stamina 10",
  "Growl 1", "Growl 2", "Growl 3", "Growl 4", "Growl 5", "Growl 6", "Growl 7",
  "Natural Armor 1","Natural Armor 2","Natural Armor 3","Natural Armor 4","Natural Armor 5",
      "Natural Armor 6","Natural Armor 7","Natural Armor 8","Natural Armor 9","Natural Armor 10",
  "Nature Resistance 1", "Nature Resistance 2", "Nature Resistance 3", "Nature Resistance 4", "Nature Resistance 5",
  "Shadow Resistance 1", "Shadow Resistance 2", "Shadow Resistance 3", "Shadow Resistance 4", "Shadow Resistance 5",
}

--
Artemis.AbilityFamily = {
  ["Bite"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Bats, Bears, Boars, Carrion Birds, Cats, Crocolisks, Gorillas, Hyenas, Raptors, Spiders, Tallstriders, Turtles, Wind Serpents, Wolves",
    ["CanLearnList"] = { "Bats", "Bears", "Boars", "Carrion Birds", "Cats", "Crocolisks", "Gorillas", "Hyenas", "Raptors", "Spiders", "Tallstriders", "Turtles", "Wind Serpents", "Wolves" } ,
   ["Text"] = "Bite the enemy, causing damage.",
  },
  
  ["Charge"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Boars",
    ["CanLearnList"] = { "Boars" } ,
   ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds melee attack power to the boar's next attack.",
  },
}

--
Artemis.Abilities = {
  ["Bite 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Text"] = "Bite the enemy, causing 7 to 9 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 1,
    ["AbilityValue"] = 7,
  } ,
  ["Bite 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 8 ,
    ["CostTP"] = 4 ,
    ["Text"] = "Bite the enemy, causing 16 to 18 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 2,
    ["AbilityValue"] = 16,
  } ,
  ["Bite 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 16 ,
    ["CostTP"] = 7 ,
    ["Text"] = "Bite the enemy, causing 24 to 28 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 3,
    ["AbilityValue"] = 24,
  } ,
  ["Bite 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 10 ,
    ["Text"] = "Bite the enemy, causing 31 to 37 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 4,
    ["AbilityValue"] = 31,
  } ,
  ["Bite 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 32 ,
    ["CostTP"] = 13 ,
    ["Text"] = "Bite the enemy, causing 40 to 48 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 5,
    ["AbilityValue"] = 40,
  } ,
  ["Bite 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 17 ,
    ["Text"] = "Bite the enemy, causing 49 to 59 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 6,
    ["AbilityValue"] = 49,
  } ,
  ["Bite 7"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 21 ,
    ["Text"] = "Bite the enemy, causing 66 to 80 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 7,
    ["AbilityValue"] = 66,
  } ,
  ["Bite 8"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25,
    ["Text"] = "Bite the enemy, causing 81 to 99 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 8,
    ["AbilityValue"] = 81,
  },

  ["Charge 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 5 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 50 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 1,
  } ,
  ["Charge 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 12 ,
    ["CostTP"] = 9 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 100 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 2,
  } ,
  ["Charge 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 13 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 180 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 3,
  } ,
  ["Charge 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 17 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 250 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 4,
  } ,
  ["Charge 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 21 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 390 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 5,
  } ,
  ["Charge 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 25 ,
    ["Text"] = " Charges an enemy, immobilizes it for 1 sec, and adds 550 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "Charge",
    ["AbilityLevel"] = 6,
  } ,
  --[[	
  ["Claw"] = {
    ["trainer"] = false ,
  } ,
  ["Cower"] = {
    ["trainer"] = false ,
  } ,
  ["Dash"] = {
    ["trainer"] = false ,
  } ,
  ["Dive"] = {
    ["trainer"] = false ,
  } ,
  ["Furious Howl"] = {
    ["trainer"] = false ,
  } ,
  ["Lightning Breath"] = {
    ["trainer"] = false ,
  } ,
  ["Prowl"] = {
    ["trainer"] = false ,
  } ,
  ["Scorpid Poison"] = {
    ["trainer"] = false ,
  } ,
  ["Screech"] = {
    ["trainer"] = false ,
  } ,
  ["Shell Shield"] = {
    ["trainer"] = false ,
  } ,
  ["Thunderstomp"] = {
    ["trainer"] = false ,
  } ,
--]]

  ["Arcane Resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Arcane Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["Arcane Resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Arcane Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["Arcane Resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["Text"] = "Increases Arcane Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["Arcane Resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["Text"] = "Increases Arcane Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["Arcane Resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["Text"] = "Increases Arcane Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  ["Fire Resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Fire Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["Fire Resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Fire Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["Fire Resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["Text"] = "Increases Fire Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["Fire Resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["Text"] = "Increases Fire Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["Fire Resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["Text"] = "Increases Fire Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["Frost Resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Frost Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["Frost Resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Frost Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["Frost Resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["Text"] = "Increases Frost Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["Frost Resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["Text"] = "Increases Frost Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["Frost Resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["Text"] = "Increases Frost Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["Great Stamina 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 10 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Stamina by 3.",
    ["AbilityLevel"] = 1,
    ["AbilityValue"] = 3,
  },
  ["Great Stamina 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 12 ,
    ["CostTP"] = 10 ,
    ["Text"] = "Increases Stamina by 5.",
    ["AbilityLevel"] = 2,
    ["AbilityValue"] = 5,
  },
  ["Great Stamina 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 18 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Stamina by 7.",
    ["AbilityLevel"] = 3,
    ["AbilityValue"] = 7,
  },
  ["Great Stamina 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 25 ,
    ["Text"] = "Increases Stamina by 10.",
    ["AbilityLevel"] = 4,
    ["AbilityValue"] = 10,
  } ,
  ["Great Stamina 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 50 ,
    ["Text"] = "Increases Stamina by 13.",
    ["AbilityLevel"] = 5,
    ["AbilityValue"] = 13,
  } ,
  ["Great Stamina 6"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 75 ,
    ["Text"] = "Increases Stamina by 17.",
    ["AbilityLevel"] = 6,
    ["AbilityValue"] = 17,
  },
  ["Great Stamina 7"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 42 ,
    ["CostTP"] = 100 ,
    ["Text"] = "Increases Stamina by 21.",
    ["AbilityLevel"] = 7,
    ["AbilityValue"] = 21,
  } ,
  ["Great Stamina 8"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 125 ,
    ["Text"] = "Increases Stamina by 26.",
    ["AbilityLevel"] = 8,
    ["AbilityValue"] = 26,
  },
  ["Great Stamina 9"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 54 ,
    ["CostTP"] = 150 ,
    ["Text"] = "Increases Stamina by 32.",
    ["AbilityLevel"] = 9,
    ["AbilityValue"] = 32,
  },
  ["Great Stamina 10"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 185 ,
    ["Text"] = "Increases Stamina by 40.",
    ["AbilityLevel"] = 10,
    ["AbilityValue"] = 40,
  },
  
  ["Growl 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 50 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 1,
    ["AbilityValue"] = 50,
  } ,
  ["Growl 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 10 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 110 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 2,
    ["AbilityValue"] = 110,
  } ,
  ["Growl 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 170 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 3,
    ["AbilityValue"] = 170,
  } ,
  ["Growl 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 170 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 4,
    ["AbilityValue"] = 170,
  } ,
  ["Growl 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 240 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 5,
    ["AbilityValue"] = 240,
  } ,
  ["Growl 6"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 320 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 6,
    ["AbilityValue"] = 320,
  } ,
  ["Growl 7"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 415 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "Growl",
    ["AbilityLevel"] = 7,
    ["AbilityValue"] = 415,
  } ,
  
  --[[
  "Natural Armor" = {
    ["trainer"] = true ,
  } ,
  "Nature Resistance 1" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Nature Resistance by 30. Can be learned from trainers.",
  } ,
  "Nature Resistance 2" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Nature Resistance by 60. Can be learned from trainers.",
  } ,
  "Nature Resistance 3" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["Text"] = "Increases Nature Resistance by 90. Can be learned from trainers.",
  } ,
  "Nature Resistance 4" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["Text"] = "Increases Nature Resistance by 120. Can be learned from trainers.",
  } ,
  "Nature Resistance 5" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["Text"] = "Increases Nature Resistance by 140. Can be learned from trainers.",
  } ,
  "Shadow Resistance 1" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["Text"] = "Increases Shadow Resistance by 30. Can be learned from trainers.",
  } ,
  "Shadow Resistance 2" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Text"] = "Increases Shadow Resistance by 60. Can be learned from trainers.",
  } ,
  "Shadow Resistance 3" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["Text"] = "Increases Shadow Resistance by 90. Can be learned from trainers.",
  } ,
  "Shadow Resistance 4" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["Text"] = "Increases Shadow Resistance by 120. Can be learned from trainers.",
  } ,
  "Shadow Resistance 5" = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["Text"] = "Increases Shadow Resistance by 140. Can be learned from trainers.",
  } ,
  ]]--
}

--
--
function Artemis:CreateTameListItem(abilityName,subElem,name,family,minlvl,maxlvl,location) 
  Artemis.Abilities[abilityName][subElem] = {}
  Artemis.Abilities[abilityName][subElem][name] = {
          ["type"] = family,
          ["MinLvl"] = minlvl,
          ["MaxLvl"] = maxlvl, 
          ["location"] = location
  }
end


--
function Artemis:CreateTameList()
  Artemis:CreateTameListItem("Bite 1","TamingList","Ragged Scavenger","Wolf",2,3,"Tirisfal Glades")
  Artemis:CreateTameListItem("Bite 1","TamingList","Night Web Spider","Spider",3,4,"Tirisfal Glades")
  Artemis:CreateTameListItem("Bite 1","TamingList","Prairie Wolf","Wolf",5,6,"Mulgore")
  Artemis:CreateTameListItem("Bite 1","TamingList","Night Web Matriarch","Spider",5,5,"Tirisfal Glades")
  Artemis:CreateTameListItem("Bite 1","TamingList","Githyiss the Vile","Spider",5,53,"Teldrassil")
  Artemis:CreateTameListItem("Bite 1","TamingList","Forest Spider","Spider",5,6,"Elwynn Forest")
  Artemis:CreateTameListItem("Bite 1","TamingList","Snow Tracker","Wolf",6,7,"Dun Morogh")
  Artemis:CreateTameListItem("Bite 1","TamingList","Prairie Stalker","Wolf",7,8,"Mulgore")
  Artemis:CreateTameListItem("Bite 1","TamingList","Gray Forest Wolf","Wolf",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("Bite 1","TamingList","Webwood Venomfang","Spider",7,8,"Teldrassil")
  Artemis:CreateTameListItem("Bite 1","TamingList","Winter Wolf","Wolf",7,8,"Dun Morogh")
  Artemis:CreateTameListItem("Bite 1","TamingList","Dreadmaw Crocolisk","Crocolisk",5,5,"Durotar")
  

  Artemis:CreateTameListItem("Bite 2","TamingList","Starving Winter Wolf","Wolf",8,9,"Dun Morogh")
  Artemis:CreateTameListItem("Bite 2","TamingList","Webwood Silkspinner","Spider",8,9,"Teldrassil")
  Artemis:CreateTameListItem("Bite 2","TamingList","Prowler","Wolf",9,10,"Elwynn Forest")
  Artemis:CreateTameListItem("Bite 2","TamingList","Vicious Night Web Spider","Spider",9,10,"Tirisfal Glades")
  Artemis:CreateTameListItem("Bite 2","TamingList","Prairie Wolf Alpha","Wolf",9,10,"Mulgore")
  Artemis:CreateTameListItem("Bite 2","TamingList","Forest Lurker","Spider",10,11,"Loch Modan")
  Artemis:CreateTameListItem("Bite 2","TamingList","Coyote","Wolf",10,11,"Westfall")
  Artemis:CreateTameListItem("Bite 2","TamingList","Giant Webwood Spider","Spider",10,11,"Teldrassil")
  Artemis:CreateTameListItem("Bite 2","TamingList","Worg","Wolf",10,11,"Silverpine Forest")
  Artemis:CreateTameListItem("Bite 2","TamingList","Timber","Wolf",10,11,"Dun Morogh")
  Artemis:CreateTameListItem("Bite 2","TamingList","Coyote Packleader","Wolf",11,12,"Westfall")
  Artemis:CreateTameListItem("Bite 2","TamingList","Lady Sathrah","Spider",12,12,"Teldrassil")
  Artemis:CreateTameListItem("Bite 2","TamingList","Loch Crocolisk","Crocolisk",14,15,"Loch Modan")
  Artemis:CreateTameListItem("Bite 2","TamingList","Tarantula","Spider",15,16,"Redridge Mountains")
  Artemis:CreateTameListItem("Bite 2","TamingList","Oasis Snapjaw","Turtle",15,16,"Tirisfal")
  
--[[
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
Bite 3: Pet Level 16, Cost 7 TP. Bite the enemy, causing 24 to 28 damage. Can be learned by taming:

    Bloodsnout Worg (Wolf, 16-17, Silverpine Forest)
    Deepmoss Creeper (Spider, 16-17, Stonetalon Mountains)
    Wood Lurker (Spider, 17-18, Loch Modan)
    Deviate Crocolisk (Crocolisk, 18-19, The Wailing Caverns)
    Shanda the Spinner (Spider, 19, Loch Modan)
    Greater Tarantula (Spider, 19-20, Redridge Mountains)
    Ghostpaw Runner (Wolf, 19-20, Ashenvale)
    Deepmoss Webspinner (Spider, 19-20, Stonetalon Mountains)
    Kresh (Turtle, 20, The Wailing Caverns)
    Forest Moss Creeper (Spider, 20-21, Hillsbrad Foothills)
    Green Recluse (Spider, 21-22, Duskwood)
    Besseleth (Spider, 21, Stonetalon Mountains)
    Large Loch Crocolisk (Crocolisk, 22, Loch Modan)
    Chatter (Spider, 23, Redridge Mountains)
    Lupos (Wolf, 23, Duskwood)
    Aku'mai Fisher (Turtle, 23-24, Blackfathom Deeps)
    Creepthess (Spider, 24, Hillsbrad Foothills)

Bite 4: Pet Level 24, Cost 10 TP. Bite the enemy, causing 31 to 37 damage. Can be learned by taming:

    Black Ravager (Wolf, 24-25, Duskwood)
    Leech Widow (Spider, 24, Wetlands)
    Giant Moss Creeper (Spider, 24-25, Hillsbrad Foothills)
    Ghamoo-ra (Turtle, 25, Blackfathom Deeps)
    Giant Wetlands Crocolisk (Crocolisk, 25-26, Wetlands)
    Black Ravager Mastiff (Wolf, 25-26, Duskwood)
    Aku'mai Snapjaw (Turtle, 26-27, Blackfathom Deeps)
    Elder Moss Creeper (Spider, 26-27, Hillsbrad Foothills)
    Naraxis (Spider, 27, Duskwood)
    Ghostpaw Alpha (Wolf, 27-28, Ashenvale)
    Wildthorn Lurker (Spider, 28-29, Ashenvale)
    Snapjaw (Turtle, 30-31, Hillsbrad Foothills)

Bite 5: Pet Level 32, Cost 13 TP. Bite the enemy, causing 40 to 48 damage. Can be learned by taming:

    Plains Creeper (Spider, 32-33, Arathi Highlands)
    Sparkleshell Snapper (Turtle, 34-35, Thousand Needles)
    Darkfang Spider (Spider, 35-36, Dustwallow Marsh)
    Crag Coyote (Wolf, 35-36, Badlands)
    Drywallow Crocolisk (Crocolisk, 35-36, Dustwallow Marsh)
    Giant Plains Creeper (Spider, 35-36, Arathi Highlands)
    Mudrock Tortoise (Turtle, 36-37, Dustwallow Marsh)
    Darkfang Lurker (Spider, 36-37, Dustwallow Marsh)
    Mottled Drywallow Crocolisk (Crocolisk, 38-39, Dustwallow Marsh)
    Darkfang Creeper (Spider, 38-39, Dustwallow Marsh)

Bite 6: Pet Level 40, Cost 17 TP. Bite the enemy, causing 49 to 59 damage. Can be learned by taming:

    Barnabus (Wolf, 38, Badlands)
    Ripscale (Crocolisk, 39, Dustwallow Marsh)
    Drywallow Daggermaw (Crocolisk, 40-41, Dustwallow Marsh)
    Longtooth Runner (Wolf, 40-41, Feralas)
    Deathstrike Tarantula (Spider, 40-41, Swamp of Sorrows)
    Sawtooth Snapper (Crocolisk, 41-42, Swamp of Sorrows)
    Mudrock Snapjaw (Turtle, 41-42, Dustwallow Marsh)
    Old Cliff Jumper (Wolf, 42, The Hinterlands)
    Snarler (Wolf, 42, Feralas)
    Deadmire (Crocolisk, 45, Dustwallow Marsh)
    Timberweb Recluse (Spider, 47-48, Azshara)
    Felpaw Wolf (Wolf, 47-48, Felwood)
    Death Howl (Wolf, 49, Felwood)

Bite 7: Pet Level 48, Cost 21 TP. Bite the enemy, causing 66 to 80 damage. Can be learned by taming:

    Rekk'tilac (Spider, 48, Searing Gorge)
    Saltwater Snapjaw (Turtle, 49-50, The Hinterlands)
    Vilebranch Raiding Wolf (Wolf, 50-51, The Hinterlands)
    Cave Creeper (Spider, 50-52, Blackrock Depths)
    Felpaw Ravager (Wolf, 51-52, Felwood)
    Uhk'loc (Gorilla, 52, Un'Goro Crater)
    Diseased Wolf (Wolf, 53-54, Western Plaguelands)
    Plague Lurker (Spider, 54-55, Western Plaguelands)

Bite 8: Pet Level 56, Cost 25 TP. Bite the enemy, causing 81 to 99 damage. Can be learned by taming:

    Bloodaxe Worg (Wolf, 56-57, Blackrock Spire)
]]--

  --
  Artemis:CreateTameListItem("Charge 1","TamingList","Young Thistle Boar","Boar",1,2,"Teldrassil")
  Artemis:CreateTameListItem("Charge 1","TamingList","Mottled Boar","Boar",1,2,"Durotar")
  Artemis:CreateTameListItem("Charge 1","TamingList","Thistle Boar","Boar",2,3,"Teldrassil")
  Artemis:CreateTameListItem("Charge 1","TamingList","Battleboar","Boar",3,4,"Mulgore")
  Artemis:CreateTameListItem("Charge 1","TamingList","Small Crag Boar","Boar",3,3,"Dun Morogh")
  Artemis:CreateTameListItem("Charge 1","TamingList","Bristleback Battleboar","Boar",4,5,"Mulgore")
  Artemis:CreateTameListItem("Charge 1","TamingList","Crag Boar","Boar",5,6,"Dun Morogh")
  Artemis:CreateTameListItem("Charge 1","TamingList","Dire Mottled Boar","Boar",6,7,"Durotar")
  Artemis:CreateTameListItem("Charge 1","TamingList","Large Crag Boar","Boar",1,2,"Dun Morogh")
  Artemis:CreateTameListItem("Charge 1","TamingList","Stonetusk Boar","Boar",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("Charge 1","TamingList","Porcine Entourage","Boar",7,7,"Elwynn Forest")
  Artemis:CreateTameListItem("Charge 1","TamingList","Elder Crag Boar ","Boar",7,8,"Dun Morogh")
  Artemis:CreateTameListItem("Charge 1","TamingList","Rockhide Boar","Boar",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("Charge 1","TamingList","Elder Mottled Boar","Boar",8,9,"Durotar")
  Artemis:CreateTameListItem("Charge 1","TamingList","Princess","Boar",9,9,"Elwynn Forest")
  Artemis:CreateTameListItem("Charge 1","TamingList","Scarred Crag Boar","Boar",9,10,"Dun Morogh")
  Artemis:CreateTameListItem("Charge 1","TamingList","Mountain Boar","Boar",10,11,"Loch Modan")
  Artemis:CreateTameListItem("Charge 1","TamingList","Corrupted Mottled Boar","Boar",10,11,"Durotar")
  Artemis:CreateTameListItem("Charge 1","TamingList","Longsnout","Boar",10,11,"Elwynn Forest")

--[[
  
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
  Charge 2: Pet Level 12, Cost 9 TP. Charges an enemy, immobilizes it for 1 sec, and adds 100 melee attack power to the boar's next attack. Can be learned by taming:

    Young Goretusk (Boar, 12-13, Westfall)
    Goretusk (Boar, 14-15, Westfall)
    Mangy Mountain Boar (Boar, 14-15, Loch Modan)
    Elder Mountain Boar (Boar, 16-17, Loch Modan)
    Great Goretusk (Boar, 16-17, Redridge Mountains)

Charge 3: Pet Level 24, Cost 13 TP. Charges an enemy, immobilizes it for 1 sec, and adds 180 melee attack power to the boar's next attack. Can be learned by taming:

    Bellygrub (Boar, 24, Redridge Mountains)
    Agam'ar (Boar, 24-25, Razorfen Kraul)
    Raging Agam'ar (Boar, 25-26, Razorfen Kraul)
    Rotting Agam'ar (Boar, 28, Razorfen Kraul)

Charge 4: Pet Level 36, Cost 17 TP. Charges an enemy, immobilizes it for 1 sec, and adds 250 melee attack power to the boar's next attack. No known training source.
Charge 5: Pet Level 48, Cost 21 TP. Charges an enemy, immobilizes it for 1 sec, and adds 390 melee attack power to the boar's next attack. Can be learned by taming:

    Ashmane Boar (Boar, 48-49, Blasted Lands)
    Grunter (Boar, 50, Blasted Lands)

Charge 6: Pet Level 60, Cost 25 TP. Charges an enemy, immobilizes it for 1 sec, and adds 550 melee attack power to the boar's next attack. Can be learned by taming:

    Plagued Swine (Boar, 60, Eastern Plaguelands)


]]--


--[[
  
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
  --Artemis:CreateTameListItem("Bite 3","TamingList","Ragged","Wolf",16,17,"Tirisfal")
]]--
  
end

--
function Artemis:GetAbilitiesBase() 
  Artemis.DebugMsg("GetAbilitiesBase: Start")
  for k, v in pairs(Artemis.Abilities_Base) do
    Artemis.DebugMsg("GetAbilitiesBase: k="..tostring(k))
  end
    
  --for id,tag in pairs(searchTagsLoc[loc]) do
	--	tagList[tag]=GBB_TAGSEARCH
	--end
  --[[
    "Bite" = {
      ["trainer"] = false , ["MaxLevel"] = 8 ,
    } ,
    ]]--
  Artemis.DebugMsg("GetAbilitiesBase: End")
end

--
function Artemis:GetAbilitiesBaseList(basename) 
  Artemis.DebugMsg("GetAbilitiesBaseList: Start")
  local ab1 = Artemis.Abilities_Base[basename]
  if( ab1 == nil ) then
    Artemis.DebugMsg("GetAbilitiesBase: No such ability data")
  else
    Artemis.DebugMsg("GetAbilitiesBase: trainer=" .. Artemis:SetStringOrDefault(ab1["trainer"],"") )
    Artemis.DebugMsg("GetAbilitiesBase: MaxLevel=".. Artemis:SetStringOrDefault(ab1["MaxLevel"],"") )
 
    for i = 1, ab1["MaxLevel"] do
      local k = basename .. tostring(i)
      Artemis.DebugMsg("GetAbilitiesBaseList: k=" .. tostring(k) )
      local ab2 = Artemis.Abilities[k]
      local ab2text = ab2["Text"]
      Artemis.DebugMsg("GetAbilitiesBaseList: ab2text=" .. tostring(ab2text) )
    end
    
  end
  
--[[--
Artemis.Abilities = {
  "Bite 1" = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Text"] = "Bite the enemy, causing 7 to 9 damage.",
    ["AbilityFamily"] = "Bite",
    ["AbilityLevel"] = 1,
    ["AbilityValue"] = 7,
  } ,
--]]--
  Artemis.DebugMsg("GetAbilitiesBaseList: End")
end

