--[[	
*** Artemis ***
Written by : echomap
--]]


-------------------------------------------------------------------------
-- DATA
-------------------------------------------------------------------------
Artemis.petfamily = {
  ["Cat"] = {
      ["foodlist"] = "meat, fish",
      ["PetFoodType"] =  {"meat","fish"},
    } ,
  ["Wind Serpent"] = {
      ["foodlist"] = "fish, cheese, bread",
      ["PetFoodType"] =  {"fish","cheese","bread"},
    } ,
  ["Bats"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Bears"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Boars"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Carrion Birds"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Cats"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Crocolisks"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Gorillas"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Hyenas"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Raptors"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Spiders"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Tallstriders"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Turtles"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Wind Serpents"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
  ["Wolves"] = {
      ["foodlist"] = "TODO",
      ["PetFoodType"] =  {"TODO"},
    },
}

Artemis.Ability_Base_List = {
  "bite",
  "charge",
  "claw",
  "cower",
  "dash",
  "dive",
  "furious howl",
  "lightning breath",
  "prowl",
  "scorpid poison",
  "screech",
  "shell shield",
  "thunderstomp",
  "arcane resistance",
  "fire resistance",
  "frost resistance",
  "great stamina",
  "growl",
  "natural armor",
  "nature resistance",
  "shadow resistance",
}

Artemis.Abilities_Base = {
  ["bite"] = {
      ["trainer"] = false ,
      ["MaxLevel"] = 8 ,
    } ,
  ["charge"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["claw"] = {
      ["trainer"] = false , ["MaxLevel"] = 8 ,
    } ,
  ["cower"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["dash"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["dive"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["furious howl"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["lightning breath"] = {
      ["trainer"] = false , ["MaxLevel"] = 6 ,
    } ,
  ["prowl"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["scorpid poison"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["screech"] = {
      ["trainer"] = false , ["MaxLevel"] = 4 ,
    } ,
  ["shell shield"] = {
      ["trainer"] = false , ["MaxLevel"] = 1 ,
    } ,
  ["thunderstomp"] = {
      ["trainer"] = false , ["MaxLevel"] = 3 ,
    } ,
  ["arcane resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
  ["fire resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
  ["frost resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
  ["great stamina"] = {
      ["trainer"] = true , ["MaxLevel"] = 10 ,
    } ,
  ["growl"] = {
      ["trainer"] = true , ["MaxLevel"] = 7 ,
    } ,
  ["natural armor"] = {
      ["trainer"] = true , ["MaxLevel"] = 10 ,
    } ,
  ["nature resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
  ["shadow resistance"] = {
      ["trainer"] = true , ["MaxLevel"] = 5 ,
    } ,
}


Artemis.Ability_List = {
  "bite 1", "bite 2", "bite 3", "bite 4", "bite 5", "bite 6", "bite 7", "bite 8",
  "charge 1","charge 2","charge 3","charge 4","charge 5","charge 6",
  "claw 1","claw 2","claw 3","claw 4","claw 5","claw 6","claw 7","claw 8",
  "cower 1","cower 2","cower 3","cower 4","cower 5","cower 6",
  "dash 1","dash 2","dash 3",
  "dive 1","dive 2","dive 3",
  "furious howl 1","furious howl 2","furious howl 3","furious howl 4",
  "lightning breath 1","lightning breath 2","lightning breath 3","lightning breath 4",
      "lightning breath 5","lightning breath 6",
  "prowl 1", "prowl 2", "prowl 3",
  "scorpid poison 1", "scorpid poison 2", "scorpid poison 3", "scorpid poison 4",
  "screech 1", "screech 2", "screech 3", "screech 4",
  "shell shield 1",
  "thunderstomp 1","thunderstomp 2","thunderstomp 3",
  "arcane resistance 1", "arcane resistance 2", "arcane resistance 3", "arcane resistance 4", "arcane resistance 5",
  "fire resistance 1", "fire resistance 2", "fire resistance 3", "fire resistance 4", "fire resistance 5",
  "frost resistance 1", "frost resistance 2", "frost resistance 3", "frost resistance 4", "frost resistance 5",
  "great stamina 1", "great stamina 2", "great stamina 3", "great stamina 4", "great stamina 5",
      "great stamina 6", "great stamina 7", "great stamina 8", "great stamina 9", "great stamina 10",
  "growl 1", "growl 2", "growl 3", "growl 4", "growl 5", "growl 6", "growl 7",
  "natural armor 1","natural armor 2","natural armor 3","natural armor 4","natural armor 5",
      "natural armor 6","natural armor 7","natural armor 8","natural armor 9","natural armor 10",
  "nature resistance 1", "nature resistance 2", "nature resistance 3", "nature resistance 4", "nature resistance 5",
  "shadow resistance 1", "shadow resistance 2", "shadow resistance 3", "shadow resistance 4", "shadow resistance 5",
}

--
Artemis.AbilityFamily = {
  ["bite"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Bats, Bears, Boars, Carrion Birds, Cats, Crocolisks, Gorillas, Hyenas, Raptors, Spiders, Tallstriders, Turtles, Wind Serpents, Wolves",
    ["CanLearnList"] = { "Bats", "Bears", "Boars", "Carrion Birds", "Cats", "Crocolisks", "Gorillas", "Hyenas", "Raptors", "Spiders", "Tallstriders", "Turtles", "Wind Serpents", "Wolves" } ,
   ["Text"]   = "Bite the enemy, causing damage.",
   ["Text_P"] = "Bite the enemy, causing %s to %s damage.",
  },
  ["charge"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Boars",
    ["CanLearnList"] = { "Boars" } ,
    ["Text"]   = "Charges an enemy, immobilizes it for a time, and adds melee attack power to the boar's next attack.",
    ["Text_P"] = "Charges an enemy, immobilizes it for %s sec, and adds %s melee attack power to the boar's next attack.",    
  },
  ["claw"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Bears, Carrion Birds, Cats, Crabs, Owls, Raptors, Scorpids",
    ["CanLearnList"] = { "Bears", "Carrion Birds", "Cats", "Crabs", "Owls", "Raptors", "Scorpids" } ,
    ["Text"]   = "Claw the enemy, causing damage.",
    ["Text_P"] = "Claw the enemy, causing %s to %s damage.",    
  },
  ["cower"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all" } ,
    ["Text"]   = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["Text_P"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",    
  },
  ["dash"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Boars, Cats, Hyenas, Tallstriders, Wolves",
    ["CanLearnList"] = { "Boars", "Cats", "Hyenas", "Tallstriders", "Wolves" } ,
    ["Text"]   = "Increases movement speed for 15 seconds.",
    ["Text_P"] = "Increases movement speed for 15 seconds.",    
  },
  ["dive"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Bats, Carrion Birds, Owls, Wind Serpents",
    ["CanLearnList"] = { "Bats","Carrion Birds","Owls","Wind Serpents" } ,
    ["Text"]   = "Increases movement speed for 15 seconds.",
    ["Text_P"] = "Increases movement speed for 15 seconds.",    
  },
  ["fire resistance"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all" } ,
    ["Text"]   = "Increases Fire Resistance.",
    ["Text_P"] = "Increases Fire Resistance.",    
  },
  ["frost resistance"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all" } ,
    ["Text"]   = "Increases Frost Resistance.",
    ["Text_P"] = "Increases Frost Resistance.",    
  },
  ["furious howl"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Wolves",
    ["CanLearnList"] = { "Wolves" } ,
    ["Text"]   = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",
    ["Text_P"] = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",    
  },
  ["great stamina"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families" ,
    ["CanLearnList"] = { "all", } ,
    ["Text"]   = "Increases stamina.",
    ["Text_P"] = "Increases stamina.",   
    ["NumRanks"] = 10,
  },
  ["growl"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "Boars", "all" } ,
    ["Text"]   = "Taunt the target, increasing the likelyhood the creature will focus attacks on your pet.",
    ["Text_P"] = "Taunt the target, increasing the likelyhood the creature will focus attacks on your pet.",     
    ["NumRanks"] = 7,
  },
  ["lightning breath"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Wind Serpents",
    ["CanLearnList"] = { "Wind Serpents", } ,
    ["Text"]   = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["Text_P"] = "Breathes lightning, instantly dealing Nature damage to a single target.",    
    ["NumRanks"] = 6,
  },
  ["natural armor"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all",  } ,
    ["Text"]   = "Increases armor.",
    ["Text_P"] = "Increases armor.",       
    ["NumRanks"] = 10,
  },
  ["nature resistance"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all" } ,
    ["Text"]   = "Increases Nature Resistance.",
    ["Text_P"] = "Increases Nature Resistance.",    
    ["NumRanks"] = 5,
  },
  ["prowl"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Cats",
    ["CanLearnList"] = { "Cats" } ,
    ["Text"]   = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["Text_P"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",       
    ["NumRanks"] = 3,
  },
  ["scorpid poison"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Scorpids",
    ["CanLearnList"] = { "Scorpids" } ,
    ["Text"]   = "Inflicts Nature damage over time. Effect can stack up to 5 times on a single target.",
    ["Text_P"] = "Inflicts Nature damage over time. Effect can stack up to 5 times on a single target.",       
    ["NumRanks"] = 4,
  },
  ["screech"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Bats, Carrion Birds, Owls",
    ["CanLearnList"] = { "Bats", "Carrion Birds", "Owls" } ,
    ["Text"]   = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",
    ["Text_P"] = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",       
    ["NumRanks"] = 4,
  },
  ["shadow resistance"] = {
    ["trainer"] = true ,
    ["CanLearnText"] = "Can be learned by: All Families",
    ["CanLearnList"] = { "all" } ,
    ["Text"]   = "Increases Shadow Resistance.",
    ["Text_P"] = "Increases Shadow Resistance.",    
    ["NumRanks"] = 5,
  },
  ["shell shield"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Turtles",
    ["CanLearnList"] = { "Turtles" } ,
    ["Text"]   = "Reduces all damage your pet takes by 50%, but increases the time between your pet's attacks by 43%. Lasts 12 sec.",
    ["Text_P"] = "Reduces all damage your pet takes by %s%%, but increases the time between your pet's attacks by %s%%. Lasts 12 sec.",       
    ["NumRanks"] = 1,
  },
  ["Thunderstomp"] = {
    ["trainer"] = false ,
    ["CanLearnText"] = "Can be learned by: Gorillas",
    ["CanLearnList"] = { "Gorillas" } ,
    ["Text"]   = "Shakes the ground with thundering force, doing Nature damage to all enemies within 8 yards.",
    ["Text_P"] = "Shakes the ground with thundering force, doing Nature damage to all enemies within 8 yards.",       
    ["NumRanks"] = 3,
  },
}

--
Artemis.Abilities = {
  ["bite 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Params"] = { 7,9 },
    ["Text"] = "Bite the enemy, causing 7 to 9 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 1,
  } ,
  ["bite 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 8 ,
    ["CostTP"] = 4 ,
    ["Params"] = { 16,18 },
    ["Text"] = "Bite the enemy, causing 16 to 18 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 2,
  } ,
  ["bite 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 16 ,
    ["CostTP"] = 7 ,
    ["Params"] = { 24,28 },
    ["Text"] = "Bite the enemy, causing 24 to 28 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 3,
  } ,
  ["bite 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 10 ,
    ["Text"] = "Bite the enemy, causing 31 to 37 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 4,
  } ,
  ["bite 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 32 ,
    ["CostTP"] = 13 ,
    ["Text"] = "Bite the enemy, causing 40 to 48 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 5,
  } ,
  ["bite 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 17 ,
    ["Text"] = "Bite the enemy, causing 49 to 59 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 6,
  } ,
  ["bite 7"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 21 ,
    ["Text"] = "Bite the enemy, causing 66 to 80 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 7,
  } ,
  ["bite 8"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25,
    ["Text"] = "Bite the enemy, causing 81 to 99 damage.",
    ["AbilityFamily"] = "bite",
    ["AbilityLevel"] = 8,
  },

  ["charge 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 5 ,
    ["Params"] = { 50 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 50 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 1,
  } ,
  ["charge 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 12 ,
    ["CostTP"] = 9 ,
    ["Params"] = { 100 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 100 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 2,
  } ,
  ["charge 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 13 ,
    ["Params"] = { 180 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 180 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 3,
  } ,
  ["charge 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 17 ,
    ["Params"] = { 250 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 250 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 4,
  } ,
  ["charge 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 21 ,
    ["Params"] = { 390 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 390 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 5,
  } ,
  ["charge 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 550 },
    ["Text"] = "Charges an enemy, immobilizes it for 1 sec, and adds 550 melee attack power to the boar's next attack.",
    ["AbilityFamily"] = "charge",
    ["AbilityLevel"] = 6,
  } ,
  
  ["claw 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Params"] = { 4,6 },
    ["Text"] = "Claw the enemy, causing 4 to 6 damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 1,
  } ,
  ["claw 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  8,
    ["CostTP"] = 4 ,
    ["Params"] = { 8,12 },
    ["Text"] = "Claw the enemy, causing 8 to 12 damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 2,
  } ,
  ["claw 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 16 ,
    ["CostTP"] = 7 ,
    ["Params"] = { 12,16 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 3,
  } ,
  ["claw 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 16,22 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 4,
  } ,
  ["claw 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 32 ,
    ["CostTP"] = 13 ,
    ["Params"] = { 21,29 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 5,
  } ,
  ["claw 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 17 ,
    ["Params"] = { 26,36 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 6,
  } ,
  ["claw 7"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 21 ,
    ["Params"] = { 36,49 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 7,
  } ,
  ["claw 8"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 43,59 },
    ["Text"] = "Claw the enemy, causing damage.",
    ["AbilityFamily"] = "claw",
    ["AbilityLevel"] = 8,
  } ,
  
  ["cower 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 5 ,
    ["CostTP"] = 8 ,
    ["Params"] = { 30 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 1,
  } ,
  ["cower 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  15,
    ["CostTP"] = 10 ,
    ["Params"] = { 55 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 2,
  } ,
  ["cower 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 25 ,
    ["CostTP"] = 12 ,
    ["Params"] = { 85 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 3,
  } ,
  ["cower 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 35 ,
    ["CostTP"] = 14 ,
    ["Params"] = { 125 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 4,
  } ,
  ["cower 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 45 ,
    ["CostTP"] = 14 ,
    ["Params"] = { 175 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 5,
  } ,
  ["cower 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 55 ,
    ["CostTP"] = 18 ,
    ["Params"] = { 225 },
    ["Text"] = "Cower, causing no damage but lowering your pet's threat, making the enemy less likely to attack your pet.",
    ["AbilityFamily"] = "cower",
    ["AbilityLevel"] = 6,
  } ,
  
  ["dash 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 40 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dash",
    ["AbilityLevel"] = 1,
  } ,
  ["dash 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  40,
    ["CostTP"] = 20 ,
    ["Params"] = { 60 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dash",
    ["AbilityLevel"] = 2,
  } ,
  ["dash 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 80 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dash",
    ["AbilityLevel"] = 3,
  } ,
    
  ["dive 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 40 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dive",
    ["AbilityLevel"] = 1,
  } ,
  ["dive 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  40,
    ["CostTP"] = 20 ,
    ["Params"] = { 60 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dive",
    ["AbilityLevel"] = 2,
  } ,
  ["dive 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 80 },
    ["Text"] = "Increases movement speed for 15 seconds.",
    ["AbilityFamily"] = "dive",
    ["AbilityLevel"] = 3,
  } ,
    
  ["furious howl 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 10 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 9,11 },
    ["Text"] = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",
    ["AbilityFamily"] = "furious howl",
    ["AbilityLevel"] = 1,
  } ,
  ["furious howl 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  24,
    ["CostTP"] = 15 ,
    ["Params"] = { 18,22 },
    ["Text"] = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",
    ["AbilityFamily"] = "furious howl",
    ["AbilityLevel"] = 2,
  } ,
  ["furious howl 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 20 ,
    ["Params"] = { 28,34 },
    ["Text"] = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",
    ["AbilityFamily"] = "furious howl",
    ["AbilityLevel"] = 3,
  } ,
  ["furious howl 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 45,57 },
    ["Text"] = "Party members within 15 yards receive extra damage to their next physical attack. Lasts 10 seconds.",
    ["AbilityFamily"] = "furious howl",
    ["AbilityLevel"] = 4,
  } ,
    
    
  ["lightning breath 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Params"] = { 11,13 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 1,
  } ,
  ["lightning breath 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] =  12,
    ["CostTP"] = 5 ,
    ["Params"] = { 21,23 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 2,
  } ,
  ["lightning breath 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 36,40 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 3,
  } ,
  ["lightning breath 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 51,59 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 4,
  } ,
  ["lightning breath 5"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 20 ,
    ["Params"] = { 78,90 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 5,
  } ,
  ["lightning breath 6"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 99,1113 },
    ["Text"] = "Breathes lightning, instantly dealing Nature damage to a single target.",
    ["AbilityFamily"] = "lightning breath",
    ["AbilityLevel"] = 6,
  } ,
    
  ["prowl 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 50,20 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "prowl",
    ["AbilityLevel"] = 1,
  } ,
  ["prowl 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40,
    ["CostTP"] = 20 ,
    ["Params"] = { 45,35 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "prowl",
    ["AbilityLevel"] = 2,
  } ,
  ["prowl 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 40,50 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "prowl",
    ["AbilityLevel"] = 3,
  } ,
  
  ["scorpid poison 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 8 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 10 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "scorpid poison",
    ["AbilityLevel"] = 1,
  } ,
  ["scorpid poison 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24,
    ["CostTP"] = 15 ,
    ["Params"] = { 15 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "scorpid poison",
    ["AbilityLevel"] = 2,
  } ,
  ["scorpid poison 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 20 ,
    ["Params"] = { 30 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "scorpid poison",
    ["AbilityLevel"] = 3,
  } ,
  ["scorpid poison 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 40 },
    ["Text"] = "Puts your pet in stealth mode, but slows its movement speed. The first attack from stealth receives a bonus to damage. Lasts until cancelled.",
    ["AbilityFamily"] = "scorpid poison",
    ["AbilityLevel"] = 4,
  } ,
  
  ["screech 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 8 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 7,9,25 },
    ["Text"] = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",
    ["AbilityFamily"] = "screech",
    ["AbilityLevel"] = 1,
  } ,
  ["screech 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 24,
    ["CostTP"] = 15 ,
    ["Params"] = { 12,16,50 },
    ["Text"] = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",
    ["AbilityFamily"] = "screech",
    ["AbilityLevel"] = 2,
  } ,
  ["screech 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 19,25,75 },
    ["Text"] = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",
    ["AbilityFamily"] = "screech",
    ["AbilityLevel"] = 3,
  } ,
  ["screech 4"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 56 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 26,46,100 },
    ["Text"] = "Blasts a single enemy for damage and lowers the melee attack power of all enemies in melee range. Effect lasts 4 sec.",
    ["AbilityFamily"] = "screech",
    ["AbilityLevel"] = 4,
  } ,
  
  ["shell shield 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 50,43,12 },
    ["Text"] = "Reduces all damage your pet takes by 50%, but increases the time between your pet's attacks by 43%. Lasts 12 sec.",
    ["AbilityFamily"] = "shell shield",
    ["AbilityLevel"] = 1,
  } ,
  
  ["thunderstomp 1"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["Params"] = { 67,77,9 },
    ["Text"] = "Shakes the ground with thundering force, doing Nature damage to all enemies within 8 yards.",
    ["AbilityFamily"] = "thunderstomp",
    ["AbilityLevel"] = 1,
  } , 
  ["thunderstomp 2"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 20 ,
    ["Params"] = { 87,99,8 },
    ["Text"] = "Shakes the ground with thundering force, doing Nature damage to all enemies within 8 yards.",
    ["AbilityFamily"] = "thunderstomp",
    ["AbilityLevel"] = 2,
  } ,
    ["thunderstomp 3"] = {
    ["trainer"] = false ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 115,133,8 },
    ["Text"] = "Shakes the ground with thundering force, doing Nature damage to all enemies within 8 yards.",
    ["AbilityFamily"] = "thunderstomp",
    ["AbilityLevel"] = 3,
  } ,
  
  
  ["arcane resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Arcane Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["arcane resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 60 },
    ["Text"] = "Increases Arcane Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["arcane resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 90 },
    ["Text"] = "Increases Arcane Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["arcane resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 120 },
    ["Text"] = "Increases Arcane Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["arcane resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["AbilityFamily"] = "arcane resistance",
    ["Params"] = { 140 },
    ["Text"] = "Increases Arcane Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["fire resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "fire resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Fire Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["fire resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "fire resistance",
    ["Params"] = { 60 },
    ["Text"] = "Increases Fire Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["fire resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["AbilityFamily"] = "fire resistance",
    ["Params"] = { 90 },
    ["Text"] = "Increases Fire Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["fire resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["AbilityFamily"] = "fire resistance",
    ["Params"] = { 120 },
    ["Text"] = "Increases Fire Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["fire resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["AbilityFamily"] = "fire resistance",
    ["Params"] = { 140 },
    ["Text"] = "Increases Fire Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["frost resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "frost resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Frost Resistance by 30. Can be learned from trainers.",
    ["AbilityLevel"] = 1,
  } ,
  ["frost resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "frost resistance",
    ["Params"] = { 60 },
    ["Text"] = "Increases Frost Resistance by 60. Can be learned from trainers.",
    ["AbilityLevel"] = 2,
  } ,
  ["frost resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 45 ,
    ["AbilityFamily"] = "frost resistance",
    ["Params"] = { 90 },
    ["Text"] = "Increases Frost Resistance by 90. Can be learned from trainers.",
    ["AbilityLevel"] = 3,
  } ,
  ["frost resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["AbilityFamily"] = "frost resistance",
    ["Params"] = { 120 },
    ["Text"] = "Increases Frost Resistance by 120. Can be learned from trainers.",
    ["AbilityLevel"] = 4,
  } ,
  ["frost resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["AbilityFamily"] = "frost resistance",
    ["Params"] = { 140 },
    ["Text"] = "Increases Frost Resistance by 140. Can be learned from trainers.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["great stamina 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 10 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 3 },
    ["Text"] = "Increases Stamina by 3.",
    ["AbilityLevel"] = 1,
  },
  ["great stamina 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 12 ,
    ["CostTP"] = 10 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 5 },
    ["Text"] = "Increases Stamina by 5.",
    ["AbilityLevel"] = 2,
  },
  ["great stamina 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 18 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 7 },
    ["Text"] = "Increases Stamina by 7.",
    ["AbilityLevel"] = 3,
  },
  ["great stamina 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 24 ,
    ["CostTP"] = 25 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 10 },
    ["Text"] = "Increases Stamina by 10.",
    ["AbilityLevel"] = 4,
  } ,
  ["great stamina 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 50 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 13 },
    ["Text"] = "Increases Stamina by 13.",
    ["AbilityLevel"] = 5,
  } ,
  ["great stamina 6"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 75 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 17 },
    ["Text"] = "Increases Stamina by 17.",
    ["AbilityLevel"] = 6,
  },
  ["great stamina 7"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 42 ,
    ["CostTP"] = 100 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 21 },
    ["Text"] = "Increases Stamina by 21.",
    ["AbilityLevel"] = 7,
  } ,
  ["great stamina 8"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 125 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 26 },
    ["Text"] = "Increases Stamina by 26.",
    ["AbilityLevel"] = 8,
  },
  ["great stamina 9"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 54 ,
    ["CostTP"] = 150 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 32 },
    ["Text"] = "Increases Stamina by 32.",
    ["AbilityLevel"] = 9,
  },
  ["great stamina 10"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 185 ,
    ["AbilityFamily"] = "great stamina",
    ["Params"] = { 40 },
    ["Text"] = "Increases Stamina by 40.",
    ["AbilityLevel"] = 10,
  },
  
  ["growl 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 0 ,
    ["Text"] = "Taunt the target, generating 50 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["Params"] = { 50 },
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 1,
  } ,
  ["growl 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 10 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 110 },
    ["Text"] = "Taunt the target, generating 110 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 2,
  } ,
  ["growl 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 110 },
    ["Text"] = "Taunt the target, generating 110 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 3,
  } ,
  ["growl 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 170 },
    ["Text"] = "Taunt the target, generating 170 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 4,
  } ,
  ["growl 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 240 },
    ["Text"] = "Taunt the target, generating 240 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 5,
  } ,
  ["growl 6"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 320 },
    ["Text"] = "Taunt the target, generating 320 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 6,
  } ,
  ["growl 7"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 0 ,
    ["Params"] = { 415 },
    ["Text"] = "Taunt the target, generating 415 threat and increasing the likelyhood the creature will focus attacks on your pet.",
    ["AbilityFamily"] = "growl",
    ["AbilityLevel"] = 7,
  } ,
  

  ["natural armor 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 1 ,
    ["CostTP"] = 1 ,
    ["Text"] = "Increases armor.",
    ["Params"] = { 50 },
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 1,
  } ,
  ["natural armor 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 12 ,
    ["CostTP"] =5,
    ["Params"] = { 100 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 2,
  } ,
  ["natural armor 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 18 ,
    ["CostTP"] = 10 ,
    ["Params"] = { 160 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 3,
  } ,
  ["natural armor 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 24,
    ["CostTP"] = 15 ,
    ["Params"] = { 240 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 4,
  } ,
  ["natural armor 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 25 ,
    ["Params"] = { 330 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 5,
  } ,
  ["natural armor 6"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 36 ,
    ["CostTP"] = 50 ,
    ["Params"] = { 430 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 6,
  } ,
  ["natural armor 7"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 42 ,
    ["CostTP"] = 75 ,
    ["Params"] = { 550 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 7,
  } ,
  ["natural armor 8"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 48 ,
    ["CostTP"] = 100 ,
    ["Params"] = { 675 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 8,
  } ,
  ["natural armor 9"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 54 ,
    ["CostTP"] = 125 ,
    ["Params"] = { 810 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 9,
  } ,
  ["natural armor 10"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 150 ,
    ["Params"] = { 1000 },
    ["Text"] = "Increases armor.",
    ["AbilityFamily"] = "natural armor",
    ["AbilityLevel"] = 10,
  } ,
  
  
  ["nature resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "nature resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Nature Resistance.",
    ["AbilityLevel"] = 1,
  } ,
  ["nature resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "nature resistance",
    ["Params"] = { 60 },
    ["Text"] = "Increases Nature Resistance.",
    ["AbilityLevel"] = 2,
  } ,
  ["nature resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 45 ,
    ["AbilityFamily"] = "nature resistance",
    ["Params"] = { 90 },
    ["Text"] = "Increases Nature Resistance.",
    ["AbilityLevel"] = 3,
  } ,
  ["nature resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["AbilityFamily"] = "nature resistance",
    ["Params"] = { 120 },
    ["Text"] = "Increases Nature Resistance.",
    ["AbilityLevel"] = 4,
  } ,
  ["nature resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["AbilityFamily"] = "nature resistance",
    ["Params"] = { 140 },
    ["Text"] = "Increases Nature Resistance.",
    ["AbilityLevel"] = 5,
  } ,
  
  ["shadow resistance 1"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 20 ,
    ["CostTP"] = 5 ,
    ["AbilityFamily"] = "shadow resistance",
    ["Params"] = { 30 },
    ["Text"] = "Increases Shadow Resistance.",
    ["AbilityLevel"] = 1,
  } ,
  ["shadow resistance 2"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 30 ,
    ["CostTP"] = 15 ,
    ["AbilityFamily"] = "shadow resistance",
    ["Params"] = { 60 },
    ["Text"] = "Increases Shadow Resistance.",
    ["AbilityLevel"] = 2,
  } ,
  ["shadow resistance 3"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 40 ,
    ["CostTP"] = 45 ,
    ["AbilityFamily"] = "shadow resistance",
    ["Params"] = { 90 },
    ["Text"] = "Increases Shadow Resistance.",
    ["AbilityLevel"] = 3,
  } ,
  ["shadow resistance 4"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 50 ,
    ["CostTP"] = 90 ,
    ["AbilityFamily"] = "shadow resistance",
    ["Params"] = { 120 },
    ["Text"] = "Increases Shadow Resistance.",
    ["AbilityLevel"] = 4,
  } ,
  ["shadow resistance 5"] = {
    ["trainer"] = true ,
    ["MinPetLevel"] = 60 ,
    ["CostTP"] = 105 ,
    ["AbilityFamily"] = "shadow resistance",
    ["Params"] = { 140 },
    ["Text"] = "Increases Shadow Resistance.",
    ["AbilityLevel"] = 5,
  } ,
}
-------------------------------------------------------------------------
-------------------------------------------------------------------------


-------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------
--
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
  } ,
--]]--
  Artemis.DebugMsg("GetAbilitiesBaseList: End")
end


--
--
function Artemis:SearchAbilities(abilityName,minLvl,maxLvl) 
  Artemis.DebugMsg("SearchAbilities: Start")
  local retElem = {}
  if(abilityName==nil) then
    return retElem
  end
  Artemis.DebugMsg("SearchAbilities: abilityName = ".. abilityName)  
  local elemA = Artemis.Abilities[abilityName]
  if(elemA~=nil) then
    local elemT = elemA["TamingList"]
    if(elemT~=nil) then
      for kName, kTable in pairs(elemT) do
        Artemis.DebugMsg("SearchAbilities: kName="..tostring(kName))
        local kMinL = kTable["MinLvl"]
        local kMaxL = kTable["MaxLvl"]
        local dataok = true
        if(minLvl~=nil) then
          --check lvl
          dataok = false
        end
        if(maxLvl~=nil) then
          --check lvl
          dataok = false
        end
        if(dataok) then
          retElem[kName] = kTable
        end        
      end --for 
    else
      Artemis.DebugMsg("SearchAbilities: not found TamingList")
    end
  else
    Artemis.DebugMsg("SearchAbilities: not found ability")
  end
  --retElem
  for kName, kTable in pairs(retElem) do
    Artemis.DebugMsg("SearchAbilities: kName="..tostring(kName))
    for vName, vValue in pairs(kTable) do
      Artemis.DebugMsg("SearchAbilities: vName="..tostring(vName))
      Artemis.DebugMsg("SearchAbilities: vValue="..tostring(vValue))
    end
  end
  
  --[[
   Artemis.Abilities[abilityName][subElem][name] = {
          ["type"] = family,
          ["MinLvl"] = minlvl,
          ["MaxLvl"] = maxlvl, 
          ["location"] = location
          
  for k, v in pairs(Artemis.Abilities_Base) do
    Artemis.DebugMsg("GetAbilitiesBase: k="..tostring(k))
  end
    
  --for id,tag in pairs(searchTagsLoc[loc]) do
	--	tagList[tag]=GBB_TAGSEARCH
	--end
    "Bite" = {
      ["trainer"] = false , ["MaxLevel"] = 8 ,
    } ,
    ]]--
  Artemis.DebugMsg("SearchAbilities: End")
end


-------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------
--
--
function Artemis:CreateTameListItem(abilityName,subElem,name,family,minlvl,maxlvl,location) 
  if(Artemis.Abilities[abilityName] == nil ) then
    Artemis.Abilities[abilityName] = {}
  end
  if( Artemis.Abilities[abilityName][subElem] == nil ) then
    Artemis.Abilities[abilityName][subElem] = {}
  end
  
  Artemis.Abilities[abilityName][subElem][name] = {
          ["type"]   = family,
          ["MinLvl"] = minlvl,
          ["MaxLvl"] = maxlvl, 
          ["location"] = location
  }
  Artemis.DebugMsg("CreateTameListItem abilityName='"..abilityName .. "'" )
end

-- input: "Barnabus (Wolf, 38, Badlands)" 
-- input: "Drywallow Daggermaw (Crocolisk, 40-41, Dustwallow Marsh)"
-- input: "Drywallow Daggermaw (Crocolisk, 42, Dustwallow Marsh)"
-- input: "NAME (FAMILY, L1-L2, LOC)"
function Artemis:CreateParsedTameListItem(abilityName,dataString)
  Artemis.DebugMsg("CPTLI0: abilityName='"..abilityName .. "'" )
  Artemis.DebugMsg("CPTLI0: dataString="..tostring(dataString) )
  local matched = false
  local name, family, level1, location = string.match(dataString, "(.+)%((.+)%,%s-(%d+)%,(.+)%)" )
  --Artemis.PrintMsg("CPTLI1: name="..tostring(name) .. " family=".. tostring(family) )
  -- matches? 
  if( name ~= nil) then
    --minlvl = level1
    Artemis.DebugMsg("CPTLI0: found ability setting list(a)='"..abilityName .. "'" )
    Artemis:CreateTameListItem(abilityName,"TamingList",name,family,level1,level1,location)
    matched = true
  end
  if(not matched) then
    name, family, minlvl, maxlvl, location = string.match( dataString, "(.+)%((.+)%,%s-(%d+)%-(%d+)%,(.+)%)" )
    if( name ~= nil) then
      Artemis.DebugMsg("CPTLI0: fountd ability setting list(b)="..abilityName .. " " )
      Artemis:CreateTameListItem(abilityName,"TamingList",name,family,minlvl,maxlvl,location)
      matched = true
    end
  end
  if(not matched) then
    name, family, minlvl, maxlvl, location = string.match( dataString, "(.+)%((.+)%,%s(%d+)%-(%d+)%,(.+)%)" )      
    if( name ~= nil) then
      Artemis.DebugMsg("CPTLI0: fountd ability setting list(b)="..abilityName .. " " )
      Artemis:CreateTameListItem(abilityName,"TamingList",name,family,minlvl,maxlvl,location)
    end
  end
  if(not matched) then
      Artemis.DebugMsg("Error in parsing dataString="..tostring(dataString) )    
  end
end  

--
--
function Artemis:CreateTameList()
  Artemis:CreateTameListItem("bite 1","TamingList","Ragged Scavenger","Wolf",2,3,"Tirisfal Glades")
  Artemis:CreateTameListItem("bite 1","TamingList","Night Web Spider","Spider",3,4,"Tirisfal Glades")
  Artemis:CreateTameListItem("bite 1","TamingList","Prairie Wolf","Wolf",5,6,"Mulgore")
  Artemis:CreateTameListItem("bite 1","TamingList","Night Web Matriarch","Spider",5,5,"Tirisfal Glades")
  Artemis:CreateTameListItem("bite 1","TamingList","Githyiss the Vile","Spider",5,53,"Teldrassil")
  Artemis:CreateTameListItem("bite 1","TamingList","Forest Spider","Spider",5,6,"Elwynn Forest")
  Artemis:CreateTameListItem("bite 1","TamingList","Snow Tracker","Wolf",6,7,"Dun Morogh")
  Artemis:CreateTameListItem("bite 1","TamingList","Prairie Stalker","Wolf",7,8,"Mulgore")
  Artemis:CreateTameListItem("bite 1","TamingList","Gray Forest Wolf","Wolf",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("bite 1","TamingList","Webwood Venomfang","Spider",7,8,"Teldrassil")
  Artemis:CreateTameListItem("bite 1","TamingList","Winter Wolf","Wolf",7,8,"Dun Morogh")
  Artemis:CreateTameListItem("bite 1","TamingList","Dreadmaw Crocolisk","Crocolisk",5,5,"Durotar")
  
  Artemis:CreateTameListItem("bite 2","TamingList","Starving Winter Wolf","Wolf",8,9,"Dun Morogh")
  Artemis:CreateTameListItem("bite 2","TamingList","Webwood Silkspinner","Spider",8,9,"Teldrassil")
  Artemis:CreateTameListItem("bite 2","TamingList","Prowler","Wolf",9,10,"Elwynn Forest")
  Artemis:CreateTameListItem("bite 2","TamingList","Vicious Night Web Spider","Spider",9,10,"Tirisfal Glades")
  Artemis:CreateTameListItem("bite 2","TamingList","Prairie Wolf Alpha","Wolf",9,10,"Mulgore")
  Artemis:CreateTameListItem("bite 2","TamingList","Forest Lurker","Spider",10,11,"Loch Modan")
  Artemis:CreateTameListItem("bite 2","TamingList","Coyote","Wolf",10,11,"Westfall")
  Artemis:CreateTameListItem("bite 2","TamingList","Giant Webwood Spider","Spider",10,11,"Teldrassil")
  Artemis:CreateTameListItem("bite 2","TamingList","Worg","Wolf",10,11,"Silverpine Forest")
  Artemis:CreateTameListItem("bite 2","TamingList","Timber","Wolf",10,11,"Dun Morogh")
  Artemis:CreateTameListItem("bite 2","TamingList","Coyote Packleader","Wolf",11,12,"Westfall")
  Artemis:CreateTameListItem("bite 2","TamingList","Lady Sathrah","Spider",12,12,"Teldrassil")
  Artemis:CreateTameListItem("bite 2","TamingList","Loch Crocolisk","Crocolisk",14,15,"Loch Modan")
  Artemis:CreateTameListItem("bite 2","TamingList","Tarantula","Spider",15,16,"Redridge Mountains")
  Artemis:CreateTameListItem("bite 2","TamingList","Oasis Snapjaw","Turtle",15,16,"Tirisfal")
  
  Artemis:CreateTameListItem("bite 3","TamingList","Bloodsnout Worg","Wolf",16,17,"Silverpine Forest")
  Artemis:CreateTameListItem("bite 3","TamingList","Deepmoss Creeper ","Spider",16,17,"Stonetalon Mountains")
  Artemis:CreateTameListItem("bite 3","TamingList","Wood Lurker","Spider",17,18,"Loch Modan")
  Artemis:CreateTameListItem("bite 3","TamingList","Deviate Crocolisk","Crocolisk",18,19,"The Wailing Caverns")
  Artemis:CreateTameListItem("bite 3","TamingList","Shanda the Spinner","Spider",19,19,"Loch Modan")
  Artemis:CreateTameListItem("bite 3","TamingList","Greater Tarantula","Spider",19,20,"Redridge Mountains")
  Artemis:CreateTameListItem("bite 3","TamingList","Ghostpaw Runner","Wolf",19,20,"Ashenvale")
  Artemis:CreateTameListItem("bite 3","TamingList","Deepmoss Webspinner","Spider",16,17,"Stonetalon Mountains")
  Artemis:CreateTameListItem("bite 3","TamingList","Kresh","Turtle",20,20,"The Wailing Caverns")
  Artemis:CreateTameListItem("bite 3","TamingList","Forest Moss Creeper","Spider",20,21,"Hillsbrad Foothills")
  Artemis:CreateTameListItem("bite 3","TamingList","Green Recluse","Spider",21,22,"Duskwood")
  Artemis:CreateTameListItem("bite 3","TamingList","Besseleth","Spider",21,21,"Stonetalon Mountains")
  Artemis:CreateTameListItem("bite 3","TamingList","Large Loch Crocolisk","Crocolisk",22,22,"Loch Modan")
  Artemis:CreateTameListItem("bite 3","TamingList","Chatter","Spider",23,23,"Redridge Mountains")
  Artemis:CreateTameListItem("bite 3","TamingList","Lupos","Wolf",23,23,"Duskwood")
  Artemis:CreateTameListItem("bite 3","TamingList","Aku'mai Fisher","Turtle",23,24,"Blackfathom Deeps")
  Artemis:CreateTameListItem("bite 3","TamingList","Creepthess","Spider",24,24,"Hillsbrad Foothills")
  
  Artemis:CreateTameListItem("bite 4","TamingList","Black Ravager","Wolf",24,25,"Duskwood")  
  Artemis:CreateTameListItem("bite 4","TamingList","Leech Widow ","Spider",24,24,"Wetlands")
  Artemis:CreateTameListItem("bite 4","TamingList","Giant Moss Creeper","Spider",24,25,"Hillsbrad Foothills")
  Artemis:CreateTameListItem("bite 4","TamingList","Ghamoo-ra","Turtle",25,25,"Blackfathom Deeps")
  Artemis:CreateTameListItem("bite 4","TamingList","Giant Wetlands Crocolisk ","Turtle",24,25,"Wetlands")
  Artemis:CreateTameListItem("bite 4","TamingList","Black Ravager Mastiff","Wolf",24,25,"Duskwood")
  Artemis:CreateTameListItem("bite 4","TamingList","Aku'mai Snapjaw","Turtle",24,25,"Blackfathom Deeps")
  Artemis:CreateTameListItem("bite 4","TamingList","Elder Moss Creeper","Spider",26,27,"Hillsbrad Foothills")
  Artemis:CreateTameListItem("bite 4","TamingList","Naraxis","Spider",27,27,"Duskwood")
  Artemis:CreateTameListItem("bite 4","TamingList","Ghostpaw Alpha ","Wolf",27,28,"Ashenvale")
  Artemis:CreateTameListItem("bite 4","TamingList","Wildthorn Lurker","Spider",28,29,"Ashenvale")
  Artemis:CreateTameListItem("bite 4","TamingList","Snapjaw","Turtle",30,31,"Hillsbrad Foothills")

  Artemis:CreateTameListItem("bite 5","TamingList","Plains Creeper","Spider",32,33,"Arathi Highlands")
  Artemis:CreateTameListItem("bite 5","TamingList","Sparkleshell Snapper","Turtle",34,35," Thousand Needles")
  Artemis:CreateTameListItem("bite 5","TamingList","Darkfang Spider","Spider",35,36,"Dustwallow Marsh")
  Artemis:CreateTameListItem("bite 5","TamingList","Crag Coyote","Wolf",35,36,"Badlands")
  Artemis:CreateTameListItem("bite 5","TamingList","Drywallow Crocolisk","Crocolisk",35,36,"Dustwallow Marsh")
  Artemis:CreateTameListItem("bite 5","TamingList","Giant Plains Creeper","Spider",35,36,"Arathi Highlands")
  Artemis:CreateTameListItem("bite 5","TamingList","Mudrock Tortoise","Turtle",36,37,"Dustwallow Marsh")
  Artemis:CreateTameListItem("bite 5","TamingList","Darkfang Lurker","Spider",36,37,"Dustwallow Marsh")
  Artemis:CreateTameListItem("bite 5","TamingList","Mottled Drywallow","Crocolisk",38,39,"Dustwallow Marsh")
  Artemis:CreateTameListItem("bite 5","TamingList","Darkfang Creeper","Spider",38,39,"Dustwallow Marsh")

  Artemis:CreateParsedTameListItem("bite6", "Barnabus (Wolf, 38, Badlands)")
  Artemis:CreateParsedTameListItem("bite6", "Ripscale (Crocolisk, 39, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite6", "Drywallow Daggermaw (Crocolisk, 40-41, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite6", "Drywallow (Crocolisk, 40-41, Dustwallow Marsh)")
  
  Artemis:CreateParsedTameListItem("bite 6","Barnabus (Wolf, 38, Badlands)")
  Artemis:CreateParsedTameListItem("bite 6","Ripscale (Crocolisk, 39, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite 6","Drywallow Daggermaw (Crocolisk, 40-41, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite 6","Longtooth Runner (Wolf, 40-41, Feralas)")
  Artemis:CreateParsedTameListItem("bite 6","Deathstrike Tarantula (Spider, 40-41, Swamp of Sorrows)")
  Artemis:CreateParsedTameListItem("bite 6","Sawtooth Snapper (Crocolisk, 41-42, Swamp of Sorrows)")
  Artemis:CreateParsedTameListItem("bite 6","Mudrock Snapjaw (Turtle, 41-42, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite 6","Old Cliff Jumper (Wolf, 42, The Hinterlands)")
  Artemis:CreateParsedTameListItem("bite 6","Snarler (Wolf, 42, Feralas)")
  Artemis:CreateParsedTameListItem("bite 6","Deadmire (Crocolisk, 45, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("bite 6","Timberweb Recluse (Spider, 47-48, Azshara)")
  Artemis:CreateParsedTameListItem("bite 6","Felpaw Wolf (Wolf, 47-48, Felwood)")
  Artemis:CreateParsedTameListItem("bite 6","Death Howl (Wolf, 49, Felwood)")

  Artemis:CreateParsedTameListItem("bite 7","Rekk'tilac (Spider, 48, Searing Gorge)")
  Artemis:CreateParsedTameListItem("bite 7","Saltwater Snapjaw (Turtle, 49-50, The Hinterlands)")
  Artemis:CreateParsedTameListItem("bite 7","Vilebranch Raiding Wolf (Wolf, 50-51, The Hinterlands)")
  Artemis:CreateParsedTameListItem("bite 7","Cave Creeper (Spider, 50-52, Blackrock Depths)")
  Artemis:CreateParsedTameListItem("bite 7","Felpaw Ravager (Wolf, 51-52, Felwood)")
  Artemis:CreateParsedTameListItem("bite 7","Uhk'loc (Gorilla, 52, Un'Goro Crater)")
  Artemis:CreateParsedTameListItem("bite 7","Diseased Wolf (Wolf, 53-54, Western Plaguelands)")
  Artemis:CreateParsedTameListItem("bite 7","Plague Lurker (Spider, 54-55, Western Plaguelands)")
    
  Artemis:CreateParsedTameListItem("bite 8","Bloodaxe Worg (Wolf, 56-57, Blackrock Spire)")
  
  --
  Artemis:CreateTameListItem("charge 1","TamingList","Young Thistle Boar","Boar",1,2,"Teldrassil")
  Artemis:CreateTameListItem("charge 1","TamingList","Mottled Boar","Boar",1,2,"Durotar")
  Artemis:CreateTameListItem("carge 1","TamingList","Thistle Boar","Boar",2,3,"Teldrassil")
  Artemis:CreateTameListItem("charge 1","TamingList","Battleboar","Boar",3,4,"Mulgore")
  Artemis:CreateTameListItem("charge 1","TamingList","Small Crag Boar","Boar",3,3,"Dun Morogh")
  Artemis:CreateTameListItem("charge 1","TamingList","Bristleback Battleboar","Boar",4,5,"Mulgore")
  Artemis:CreateTameListItem("charge 1","TamingList","Crag Boar","Boar",5,6,"Dun Morogh")
  Artemis:CreateTameListItem("charge 1","TamingList","Dire Mottled Boar","Boar",6,7,"Durotar")
  Artemis:CreateTameListItem("charge 1","TamingList","Large Crag Boar","Boar",1,2,"Dun Morogh")
  Artemis:CreateTameListItem("charge 1","TamingList","Stonetusk Boar","Boar",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("charge 1","TamingList","Porcine Entourage","Boar",7,7,"Elwynn Forest")
  Artemis:CreateTameListItem("charge 1","TamingList","Elder Crag Boar ","Boar",7,8,"Dun Morogh")
  Artemis:CreateTameListItem("charge 1","TamingList","Rockhide Boar","Boar",7,8,"Elwynn Forest")
  Artemis:CreateTameListItem("charge 1","TamingList","Elder Mottled Boar","Boar",8,9,"Durotar")
  Artemis:CreateTameListItem("charge 1","TamingList","Princess","Boar",9,9,"Elwynn Forest")
  Artemis:CreateTameListItem("charge 1","TamingList","Scarred Crag Boar","Boar",9,10,"Dun Morogh")
  Artemis:CreateTameListItem("charge 1","TamingList","Mountain Boar","Boar",10,11,"Loch Modan")
  Artemis:CreateTameListItem("charge 1","TamingList","Corrupted Mottled Boar","Boar",10,11,"Durotar")
  Artemis:CreateTameListItem("charge 1","TamingList","Longsnout","Boar",10,11,"Elwynn Forest")

  Artemis:CreateParsedTameListItem("charge 2","Young Goretusk (Boar, 12-13, Westfall)")
  Artemis:CreateParsedTameListItem("charge 2","Goretusk (Boar, 14-15, Westfall)")
  Artemis:CreateParsedTameListItem("charge 2","Mangy Mountain Boar (Boar, 14-15, Loch Modan)")
  Artemis:CreateParsedTameListItem("charge 2","Elder Mountain Boar (Boar, 16-17, Loch Modan)")
  Artemis:CreateParsedTameListItem("charge 2","Great Goretusk (Boar, 16-17, Redridge Mountains)")

  Artemis:CreateParsedTameListItem("charge 3","Bellygrub (Boar, 24, Redridge Mountains)")
  Artemis:CreateParsedTameListItem("charge 3","Agam'ar (Boar, 24-25, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("charge 3","Raging Agam'ar (Boar, 25-26, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("charge 3","Rotting Agam'ar (Boar, 28, Razorfen Kraul)")

  Artemis:CreateParsedTameListItem("charge 4","No known training source.")
  
  Artemis:CreateParsedTameListItem("charge 5","Ashmane Boar (Boar, 48-49, Blasted Lands)")
  Artemis:CreateParsedTameListItem("charge 5","Grunter (Boar, 50, Blasted Lands)")

  Artemis:CreateParsedTameListItem("charge 6","Plagued Swine (Boar, 60, Eastern Plaguelands)")
  
  --
  Artemis:CreateParsedTameListItem("claw 1","Scorpid Worker (Scorpid, 3, Durotar)")
  Artemis:CreateParsedTameListItem("claw 1","Sarkoth (Scorpid, 4, Durotar)")
  Artemis:CreateParsedTameListItem("claw 1","Pygmy Surf Crawler (Crab, 5-6, Durotar)")
  Artemis:CreateParsedTameListItem("claw 1","Strigid Owl (Owl, 5-6, Teldrassil)")
  Artemis:CreateParsedTameListItem("claw 1","Ice Claw Bear (Bear, 7-8, Dun Morogh)")
  
  Artemis:CreateParsedTameListItem("claw 2","  Strigid Hunter (Owl, 8-9, Teldrassil)")
  Artemis:CreateParsedTameListItem("claw 2","Encrusted Surf Crawler (Crab, 9-10, Durotar)")
  Artemis:CreateParsedTameListItem("claw 2","Venomtail Scorpid (Scorpid, 9-10, Durotar)")
  Artemis:CreateParsedTameListItem("claw 2","Thistle Bear (Bear, 11-12, Darkshore)")
  Artemis:CreateParsedTameListItem("claw 2","Mangeclaw (Bear, 11, Dun Morogh)")
  Artemis:CreateParsedTameListItem("claw 2","Death Flayer (Scorpid, 11, Durotar)")
  Artemis:CreateParsedTameListItem("claw 2","Ferocious Grizzled Bear (Bear, 11-12, Silverpine Forest)")
  Artemis:CreateParsedTameListItem("claw 2","Bjarn (Bear, 12, Dun Morogh)")
  Artemis:CreateParsedTameListItem("claw 2","Tide Crawler (Crab, 12-14, Darkshore)")
  
  Artemis:CreateParsedTameListItem("claw 3","Black Bear Patriarch (Bear, 16-17, Loch Modan)")
  Artemis:CreateParsedTameListItem("claw 3","Shore Crawler (Crab, 17-18, Westfall)")
  Artemis:CreateParsedTameListItem("claw 3","Den Mother (Bear, 18-19, Darkshore)")
  Artemis:CreateParsedTameListItem("claw 3","Clattering Crawler (Crab, 19-20, Ashenvale)")
  Artemis:CreateParsedTameListItem("claw 3","Ghost Saber (Cat, 19-20, Darkshore)")
  Artemis:CreateParsedTameListItem("claw 3","Ol' Sooty (Bear, 20, Loch Modan)")
  Artemis:CreateParsedTameListItem("claw 3","Gray Bear (Bear, 21-22, Hillsbrad Foothills)")
  Artemis:CreateParsedTameListItem("claw 3","Ashenvale Bear (Bear, 21-22, Ashenvale)")
  Artemis:CreateParsedTameListItem("claw 3","Skittering Crustacean (Crab, 22-23, Blackfathom Deeps)")
  Artemis:CreateParsedTameListItem("claw 3","Snapping Crustacean (Crab, 23-24, Blackfathom Deeps)")
  
  Artemis:CreateParsedTameListItem("claw 4","Elder Ashenvale Bear (Bear, 25-26, Ashenvale)")
  Artemis:CreateParsedTameListItem("claw 4","Barbed Crustacean (Crab, 25-26, Blackfathom Deeps)")
  Artemis:CreateParsedTameListItem("claw 4","Scorpashi Snapper (Scorpid, 30-31, Desolace)")
  Artemis:CreateParsedTameListItem("claw 4","Scorpid Reaver (Scorpid, 31-32, Thousand Needles)")
  
  Artemis:CreateParsedTameListItem("claw 5","Scorpashi Lasher (Scorpid, 34-35, Desolace)")
  Artemis:CreateParsedTameListItem("claw 5","Vile Sting (Scorpid, 35, Thousand Needles)")
  Artemis:CreateParsedTameListItem("claw 5","Drywallow Snapper (Crocolisk, 37-38, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("claw 5","Venomlash Scorpid (Scorpid, 39-40, Uldaman)")
  
  Artemis:CreateParsedTameListItem("claw 6","Scorpid Hunter (Scorpid, 40-41, Tanaris)")
  Artemis:CreateParsedTameListItem("claw 6","Silt Crawler (Crab, 40-41, Swamp of Sorrows)")
  Artemis:CreateParsedTameListItem("claw 6","Ironfur Bear (Bear, 41-42, Feralas)")
  Artemis:CreateParsedTameListItem("claw 6","King Bangalash (Cat, 43, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("claw 6","Old Grizzlegut (Bear, 43, Feralas)")
  Artemis:CreateParsedTameListItem("claw 6","Monstrous Crawler (Crab, 43-44, Swamp of Sorrows)")

  Artemis:CreateParsedTameListItem("claw 7","Ironfur Patriarch (Bear, 48-49, Feralas)")
  Artemis:CreateParsedTameListItem("claw 7","Angerclaw Mauler (Bear, 49-50, Felwood)")
  Artemis:CreateParsedTameListItem("claw 7","Mongress (Bear, 50, Felwood)")
  Artemis:CreateParsedTameListItem("claw 7","Ironbeak Hunter (Owl, 50-51, Felwood)")
  Artemis:CreateParsedTameListItem("claw 7","Olm the Wise (Owl, 52, Felwood)")
  Artemis:CreateParsedTameListItem("claw 7","Clack the Reaver (Scorpid, 53, Blasted Lands)")
  Artemis:CreateParsedTameListItem("claw 7","Shardtooth Bear (Bear, 53-54, Winterspring)")
  Artemis:CreateParsedTameListItem("claw 7","Winterspring Owl (Owl, 54-56, Winterspring)")
  Artemis:CreateParsedTameListItem("claw 7","Deathlash Scorpid (Scorpid, 54-55, Burning Steppes)")
  Artemis:CreateParsedTameListItem("claw 7","Diseased Grizzly (Bear, 55-56, Western Plaguelands)")
  
  Artemis:CreateParsedTameListItem("claw 8","Winterspring Screecher (Owl, 57-59, Winterspring)")
  Artemis:CreateParsedTameListItem("claw 8","Elder Shardtooth (Bear, 57-58, Winterspring)")

  --
  Artemis:CreateParsedTameListItem("cower 1","Juvenile Snow Leopard (Cat, 5-6, Dun Morogh)")
  Artemis:CreateParsedTameListItem("cower 1","Nightsaber (Cat, 5-6, Teldrassil)")
  Artemis:CreateParsedTameListItem("cower 1","Greater Duskbat (Bat, 6-7, Tirisfal Glades)")
  Artemis:CreateParsedTameListItem("cower 1","Flatland Cougar (Cat, 7-8, Mulgore)")
  Artemis:CreateParsedTameListItem("cower 1","Durotar Tiger (Cat, 7-8, Durotar)")
  Artemis:CreateParsedTameListItem("cower 1","Elder Plainstrider (Tallstrider, 8-9, Mulgore)")
  Artemis:CreateParsedTameListItem("cower 1","Mazzranache (Tallstrider, 9, Mulgore)")
  Artemis:CreateParsedTameListItem("cower 1","Moonstalker Runt (Cat, 10-11, Darkshore)")
  Artemis:CreateParsedTameListItem("cower 1","Foreststrider Fledgling (Tallstrider, 11-13, Darkshore)")
  Artemis:CreateParsedTameListItem("cower 1","Fleeting Plainstrider (Tallstrider, 12-13, The Barrens)")
  
  Artemis:CreateParsedTameListItem("cower 2","Savannah Patriarch (Cat, 15-16, The Barrens)")
  Artemis:CreateParsedTameListItem("cower 2","Ornery Plainstrider (Tallstrider, 16-17, The Barrens)")
  Artemis:CreateParsedTameListItem("cower 2","Giant Foreststrider (Tallstrider, 17-19, Darkshore)")
  Artemis:CreateParsedTameListItem("cower 2","Moonstalker Sire (Cat, 17-18, Darkshore)")
  Artemis:CreateParsedTameListItem("cower 2","Starving Mountain Lion (Cat, 23-24, Hillsbrad Foothills)")
  Artemis:CreateParsedTameListItem("cower 2","Twilight Runner (Cat, 23-24, Stonetalon Mountains)")
  
  Artemis:CreateParsedTameListItem("cower 3","Crag Stalker (Cat, 25-26, Thousand Needles)")
  Artemis:CreateParsedTameListItem("cower 3","Feral Mountain Lion (Cat, 27-28, Hillsbrad Foothills)")
  Artemis:CreateParsedTameListItem("cower 3","Young Stranglethorn Tiger (Cat, 30-31, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("cower 3","Kraul Bat (Bat, 30-31, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("cower 3","Young Panther (Cat, 30-31, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("cower 3","Greater Kraul Bat (Bat, 32, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("cower 3","Panther (Cat, 32-33, Stranglethorn Vale)")
  
  Artemis:CreateParsedTameListItem("cower 4","Ridge Stalker (Cat, 36-37, Badlands)")
  Artemis:CreateParsedTameListItem("cower 4","Shrike Bat (Bat, 38-39, Uldaman)")
  Artemis:CreateParsedTameListItem("cower 4","Ridge Huntress (Cat, 38-39, Badlands)")
  
  Artemis:CreateParsedTameListItem("cower 5","Jaguero Stalker (Cat, 50, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("cower 5","Plaguebat (Bat, 53-55, Eastern Plaguelands)")
  Artemis:CreateParsedTameListItem("cower 5","Noxious Plaguebat (Bat, 54-56, Eastern Plaguelands)")
  
  Artemis:CreateParsedTameListItem("cower 6","Frostsaber Cub (Cat, 55-56, Winterspring)")
  Artemis:CreateParsedTameListItem("cower 6","Monstrous Plaguebat (Bat, 56-58, Eastern Plaguelands)")

  --
  Artemis:CreateParsedTameListItem("dash 1","Kurzen War Tiger (Cat, 32-33, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 1","Stranglethorn Tiger (Cat, 32-33, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 1","Scarlet Tracking Hound (Hyena, 33-34, Scarlet Monastery)")
  Artemis:CreateParsedTameListItem("dash 1","Bonepaw Hyena (Hyena, 33-35, Desolace)")
  Artemis:CreateParsedTameListItem("dash 1","Crag Coyote (Wolf, 35-36, Badlands)")
  Artemis:CreateParsedTameListItem("dash 1","Spot (Wolf, 35, Dustwallow Marsh)")
  Artemis:CreateParsedTameListItem("dash 1","Swamp Jaguar (Cat, 36-37, Swamp of Sorrows)")
  Artemis:CreateParsedTameListItem("dash 1","Magram Bonepaw (Hyena, 37-38, Desolace)")
  Artemis:CreateParsedTameListItem("dash 1","Broken Tooth (Cat, 37, Badlands)")
  Artemis:CreateParsedTameListItem("dash 1","Feral Crag Coyote (Wolf, 37-38, Badlands)")
  Artemis:CreateParsedTameListItem("dash 1","Sin'Dall (Cat, 37, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 1","Elder Crag Coyote (Wolf, 39-40, Badlands)")
  
  Artemis:CreateParsedTameListItem("dash 2","Longtooth Runner (Wolf, 40-41, Feralas)")
  Artemis:CreateParsedTameListItem("dash 2","Ridge Stalker Patriarch (Cat, 40-41, Badlands)")
  Artemis:CreateParsedTameListItem("dash 2","Bhag'thera (Cat, 40, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 2","Starving Blisterpaw (Hyena, 41-42, Tanaris)")
  Artemis:CreateParsedTameListItem("dash 2","Rabid Crag Coyote (Wolf, 42-43, Badlands)")
  Artemis:CreateParsedTameListItem("dash 2","Elder Shadowmaw Panther (Cat, 42-43, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 2","Old Cliff Jumper (Wolf, 42, The Hinterlands)")
  Artemis:CreateParsedTameListItem("dash 2","King Bangalash (Cat, 43, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("dash 2","Blisterpaw Hyena (Hyena, 44-45, Tanaris)")
  Artemis:CreateParsedTameListItem("dash 2","Rabid Blisterpaw (Hyena, 47-48, Tanaris)")
  Artemis:CreateParsedTameListItem("dash 2","Silvermane Stalker (Wolf, 47-48, The Hinterlands)")
  
  Artemis:CreateParsedTameListItem("dash 3","Vilebranch Raiding Wolf (Wolf, 50-51, The Hinterlands)")
  Artemis:CreateParsedTameListItem("dash 3","Grunter (Boar, 50, Blasted Lands)")
  Artemis:CreateParsedTameListItem("dash 3","Ravage (Hyena, 51, Blasted Lands)")
  Artemis:CreateParsedTameListItem("dash 3","Scarshield Worg (Wolf, 53-54, Blackrock Spire)")
  Artemis:CreateParsedTameListItem("dash 3","Blackrock Worg (Wolf, 54-55, Burning Steppes)")
  Artemis:CreateParsedTameListItem("dash 3","Bloodaxe Worg (Wolf, 56-57, Blackrock Spire)")
  Artemis:CreateParsedTameListItem("dash 3","Rak'Shiri (Cat, 57, Winterspring)")
  Artemis:CreateParsedTameListItem("dash 3","Frostsaber Huntress (Cat, 58-59, Winterspring)")
  Artemis:CreateParsedTameListItem("dash 3","Frostsaber Stalker (Cat, 59-60, Winterspring)")
  Artemis:CreateParsedTameListItem("dash 3","Zulian Panther (Cat, 60, Zul'Gurub)")

  --
  
  Artemis:CreateParsedTameListItem("dive 1","Kraul Bat (Bat, 30-31, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("dive 1","Young Mesa Buzzard (Carrion Bird, 31-32, Arathi Highlands)")
  Artemis:CreateParsedTameListItem("dive 1","Greater Kraul Bat (Bat, 32, Razorfen Kraul)")
  Artemis:CreateParsedTameListItem("dive 1","Mesa Buzzard (Carrion Bird, 34-35, Arathi Highlands)")
  Artemis:CreateParsedTameListItem("dive 1","Wayward Buzzard (Carrion Bird, 35-37, Badlands)")
  Artemis:CreateParsedTameListItem("dive 1","Dread Flyer (Carrion Bird, 36-37, Desolace)")
  Artemis:CreateParsedTameListItem("dive 1","Shrike Bat (Bat, 38-39, Uldaman)")
  
  Artemis:CreateParsedTameListItem("dive 2","Vale Screecher (Wind Serpent, 41-43, Feralas)")
  Artemis:CreateParsedTameListItem("dive 2","Roc (Carrion Bird, 42-43, Tanaris)")
  Artemis:CreateParsedTameListItem("dive 2","Fire Roc (Carrion Bird, 43-45, Tanaris)")
  Artemis:CreateParsedTameListItem("dive 2","Rogue Vale Screecher (Wind Serpent, 44-46, Feralas)")
  Artemis:CreateParsedTameListItem("dive 2","Greater Firebird (Carrion Bird, 46, Tanaris)")
  Artemis:CreateParsedTameListItem("dive 2","Searing Roc (Carrion Bird, 47-49, Tanaris)")
  Artemis:CreateParsedTameListItem("dive 2","Ironbeak Owl (Owl, 48-49, Felwood)")
  Artemis:CreateParsedTameListItem("dive 2","Arash-ethis (Wind Serpent, 49, Feralas)")
  
  Artemis:CreateParsedTameListItem("dive 3","Dark Screecher (Bat, 50-52, Blackrock Depths)")
  Artemis:CreateParsedTameListItem("dive 3","Carrion Vulture (Carrion Bird, 50-52, Western Plaguelands)")
  Artemis:CreateParsedTameListItem("dive 3","Ironbeak Hunter (Owl, 50-51, Felwood)")
  Artemis:CreateParsedTameListItem("dive 3","Spawn of Hakkar (Wind Serpent, 51, The Temple of Atal'Hakkar)")
  Artemis:CreateParsedTameListItem("dive 3","Spiteflayer (Carrion Bird, 52, Blasted Lands)")
  Artemis:CreateParsedTameListItem("dive 3","Olm the Wise (Owl, 52, Felwood)")
  Artemis:CreateParsedTameListItem("dive 3","Ironbeak Screecher (Owl, 52-53, Felwood)")
  Artemis:CreateParsedTameListItem("dive 3","Plaguebat (Bat, 53-55, Eastern Plaguelands)")
  Artemis:CreateParsedTameListItem("dive 3","Winterspring Owl (Owl, 54-56, Winterspring)")
  Artemis:CreateParsedTameListItem("dive 3","Zaricotl (Carrion Bird, 55, Badlands)")
  Artemis:CreateParsedTameListItem("dive 3","Winterspring Screecher (Owl, 57-59, Winterspring)")

  --
  Artemis:CreateParsedTameListItem("furious howl 1","Prairie Wolf Alpha (Wolf, 9-10, Mulgore)")
  Artemis:CreateParsedTameListItem("furious howl 1","Worg (Wolf, 10-11, Silverpine Forest)")
  Artemis:CreateParsedTameListItem("furious howl 1","Coyote Packleader (Wolf, 11-12, Westfall)")
  Artemis:CreateParsedTameListItem("furious howl 1"," Mist Howler (Wolf, 22, Ashenvale)")
  
  Artemis:CreateParsedTameListItem("furious howl 2","Black Ravager Mastiff (Wolf, 25-26, Duskwood)")
  Artemis:CreateParsedTameListItem("furious howl 2","Ghostpaw Alpha (Wolf, 27-28, Ashenvale)")
  Artemis:CreateParsedTameListItem("furious howl 2","Elder Crag Coyote (Wolf, 39-40, Badlands)")
  Artemis:CreateParsedTameListItem("furious howl 2","Longtooth Howler (Wolf, 43-44, Feralas)")
  Artemis:CreateParsedTameListItem("furious howl 2","Silvermane Howler (Wolf, 45-46, The Hinterlands)")
  
  Artemis:CreateParsedTameListItem("furious howl 3","Longtooth Runner (Wolf, 40-41, Feralas)")
  Artemis:CreateParsedTameListItem("furious howl 3","Snarler (Wolf, 42, Feralas)")
  Artemis:CreateParsedTameListItem("furious howl 3","Silvermane Wolf (Wolf, 43-44, The Hinterlands)")
  Artemis:CreateParsedTameListItem("furious howl 3","Felpaw Wolf (Wolf, 47-48, Felwood)")
  Artemis:CreateParsedTameListItem("furious howl 3","Death Howl (Wolf, 49, Felwood)")
    
  Artemis:CreateParsedTameListItem("furious howl 4","Bloodaxe Worg (Wolf, 56-57, Blackrock Spire)")

  --
  --Artemis:CreateParsedTameListItem("lightning breath 1","
  Artemis:CreateParsedTameListItem("lightning breath 2","Deviate Coiler (Wind Serpent, 15-16, The Wailing Caverns)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Deviate Stinglash (Wind Serpent, 16-17, The Wailing Caverns)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Thunderhawk Hatchling (Wind Serpent, 18-20, The Barrens)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Thunderhawk Cloudscraper (Wind Serpent, 20-22, The Barrens)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Deviate Dreadfang (Wind Serpent, 20-21, The Wailing Caverns)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Deviate Venomwing (Wind Serpent, 20-21, The Wailing Caverns)")
  Artemis:CreateParsedTameListItem("lightning breath 2","Greater Thunderhawk (Wind Serpent, 23-24, The Barrens)")
 
  Artemis:CreateParsedTameListItem("lightning breath 3","Cloud Serpent (Wind Serpent, 25-26, Thousand Needles)")
  Artemis:CreateParsedTameListItem("lightning breath 3","Washte Pawne (Wind Serpent, 25, The Barrens)")
  Artemis:CreateParsedTameListItem("lightning breath 3","Venomous Cloud Serpent (Wind Serpent, 26-28, Thousand Needles)")
  Artemis:CreateParsedTameListItem("lightning breath 3","Elder Cloud Serpent (Wind Serpent, 27-29, Thousand Needles)")
 
  Artemis:CreateParsedTameListItem("lightning breath 4","Vale Screecher (Wind Serpent, 41-43, Feralas)")
  Artemis:CreateParsedTameListItem("lightning breath 4","Rogue Vale Screecher (Wind Serpent, 44-46, Feralas)")

  Artemis:CreateParsedTameListItem("lightning breath 5","Hakkari Sapper (Wind Serpent, 49-50, The Temple of Atal'Hakkar)")
  Artemis:CreateParsedTameListItem("lightning breath 5","Hakkari Frostwing (Wind Serpent, 49-50, The Temple of Atal'Hakkar)")
  Artemis:CreateParsedTameListItem("lightning breath 5","Arash-ethis (Wind Serpent, 49, Feralas)")
  Artemis:CreateParsedTameListItem("lightning breath 5","Spawn of Hakkar (Wind Serpent, 51, The Temple of Atal'Hakkar)")

  Artemis:CreateParsedTameListItem("lightning breath 6","Son of Hakkar (Wind Serpent, 60, Zul'Gurub)")

  --
  Artemis:CreateParsedTameListItem("prowl 1","Mountain Lion (Cat, 32-33, Alterac Mountains)")
  Artemis:CreateParsedTameListItem("prowl 1","Ridge Stalker (Cat, 36-37, Badlands)")
  Artemis:CreateParsedTameListItem("prowl 1","Shadowmaw Panther (Cat, 37-38, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("prowl 1","Shadow Panther (Cat, 39-40, Swamp of Sorrows)")

  Artemis:CreateParsedTameListItem("prowl 2","Ridge Stalker Patriarch (Cat, 40-41, Badlands)")
  Artemis:CreateParsedTameListItem("prowl 2","Elder Shadowmaw Panther (Cat, 42-43, Stranglethorn Vale)")
 
  Artemis:CreateParsedTameListItem("prowl 3","Jaguero Stalker (Cat, 50, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("prowl 3","Frostsaber Stalker (Cat, 59-60, Winterspring)")

  --
  Artemis:CreateParsedTameListItem("scorpid poison 1","Venomtail Scorpid (Scorpid, 9-10, Durotar)")
  Artemis:CreateParsedTameListItem("scorpid poison 1","Corrupted Scorpid (Scorpid, 10-11, Durotar)")
  Artemis:CreateParsedTameListItem("scorpid poison 1","Death Flayer (Scorpid, 11, Durotar)")
  Artemis:CreateParsedTameListItem("scorpid poison 1","Silithid Creeper (Scorpid, 20-21, The Barrens)")
  Artemis:CreateParsedTameListItem("scorpid poison 1","Silithid Swarmer (Scorpid, 21-22, The Barrens)")
    
  Artemis:CreateParsedTameListItem("scorpid poison 2","Scorpashi Snapper (Scorpid, 30-31, Desolace)")
  Artemis:CreateParsedTameListItem("scorpid poison 2","Scorpid Reaver (Scorpid, 31-32, Thousand Needles)")
  Artemis:CreateParsedTameListItem("scorpid poison 2","Scorpid Terror (Scorpid, 33-34, Thousand Needles)")
  Artemis:CreateParsedTameListItem("scorpid poison 2","Vile Sting (Scorpid, 35, Thousand Needles)")
  Artemis:CreateParsedTameListItem("scorpid poison 2","Cleft Scorpid (Scorpid, 35-36, Uldaman)")
  Artemis:CreateParsedTameListItem("scorpid poison 2","Scorpashi Venomlash (Scorpid, 38-39, Desolace)")
    
  Artemis:CreateParsedTameListItem("scorpid poison 3","Scorpid Hunter (Scorpid, 40-41, Tanaris)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Deadly Cleft Scorpid (Scorpid, 42-43, Uldaman)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Scorpid Tail Lasher (Scorpid, 43-44, Tanaris)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Scorpid Duneburrower (Scorpid, 46-47, Tanaris)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Scorpid Dunestalker (Scorpid, 46-47, Tanaris)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Deep Stinger (Scorpid, 50-52, Blackrock Depths)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Venomtip Scorpid (Scorpid, 52-53, Burning Steppes)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Deathlash Scorpid (Scorpid, 54-55, Burning Steppes)")
  Artemis:CreateParsedTameListItem("scorpid poison 3","Stonelash Scorpid (Scorpid, 54-55, Silithus)")
  
  Artemis:CreateParsedTameListItem("scorpid poison 4","Krellack (Scorpid, 56, Silithus)")
  Artemis:CreateParsedTameListItem("scorpid poison 4","Stonelash Pincer (Scorpid, 56-57, Silithus)")
  Artemis:CreateParsedTameListItem("scorpid poison 4","Firetail Scorpid (Scorpid, 56-57, Burning Steppes)")
  Artemis:CreateParsedTameListItem("scorpid poison 4","Stonelash Flayer (Scorpid, 58-59, Silithus)")

  --Screech
  Artemis:CreateParsedTameListItem("screech 1","Greater Fleshripper (Carrion Bird, 16-17, Westfall)")
  
  Artemis:CreateParsedTameListItem("screech 2","Salt Flats Vulture (Carrion Bird, 32-34, Thousand Needles)")
  Artemis:CreateParsedTameListItem("screech 2","Shrike Bat (Bat, 38-39, Uldaman)")
  Artemis:CreateParsedTameListItem("screech 2","Dread Ripper (Carrion Bird, 39-40, Desolace)")
  
  Artemis:CreateParsedTameListItem("screech 3","Ironbeak Owl (Owl, 48-49, Felwood)")
  Artemis:CreateParsedTameListItem("screech 3","Carrion Vulture (Carrion Bird, 50-52, Western Plaguelands)")
  Artemis:CreateParsedTameListItem("screech 3","Dark Screecher (Bat, 50-52, Blackrock Depths)")
  
  Artemis:CreateParsedTameListItem("screech 4","Monstrous Plaguebat (Bat, 56-58, Eastern Plaguelands)")
  Artemis:CreateParsedTameListItem("screech 4","Winterspring Screecher (Owl, 57-59, Winterspring)")

  --
  Artemis:CreateParsedTameListItem("shell shield 1","Kresh (Turtle, 20, The Wailing Caverns)")
  Artemis:CreateParsedTameListItem("shell shield 1","Aku'mai Fisher (Turtle, 23-24, Blackfathom Deeps)")
  Artemis:CreateParsedTameListItem("shell shield 1","Ghamoo-ra (Turtle, 25, Blackfathom Deeps)")
  Artemis:CreateParsedTameListItem("shell shield 1","Aku'mai Snapjaw (Turtle, 26-27, Blackfathom Deeps)")
  Artemis:CreateParsedTameListItem("shell shield 1","Snapjaw (Turtle, 30-31, Hillsbrad Foothills)")
  Artemis:CreateParsedTameListItem("shell shield 1","Cranky Benj (Turtle, 32, Alterac Mountains)")

  --
  Artemis:CreateParsedTameListItem("thunderstomp 1","Mistvale Gorilla (Gorilla, 32-33, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("thunderstomp 1","Jungle Thunderer (Gorilla, 37-38, Stranglethorn Vale)")
  
  Artemis:CreateParsedTameListItem("thunderstomp 2","Elder Mistvale Gorilla (Gorilla, 40-41, Stranglethorn Vale)")
  Artemis:CreateParsedTameListItem("thunderstomp 2","Groddoc Thunderer (Gorilla, 49-50, Feralas)")
  
  Artemis:CreateParsedTameListItem("thunderstomp 3","Un'Goro Thunderer (Gorilla, 52-53, Un'Goro Crater)")
  Artemis:CreateParsedTameListItem("thunderstomp 3","U'cha (Gorilla, 55, Un'Goro Crater)")

end

