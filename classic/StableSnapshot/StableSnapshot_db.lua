--[[	
*** StableSnapshot ***
Written by : echomap
--]]

local L = LibStub("AceLocale-3.0"):GetLocale("StableSnapshot", false)
--local maxPets = 10

-- name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList
function StableSnapshot:ParsePetArray(petarr) 
	name = ""
	family = ""
	level = ""
	icon = nil
	loyalty = "";
  happiness = "";
  petFoodList = "";
	for index,value in ipairs(petarr) do 
		--print( tostring(index) .. " : " .. value )
		if index == 1 then
			name = value
		end
		if index == 2 then
			family = value
		end
		if index == 3 then
			level = value
		end
		if index == 4 then
			icon = value
		end
		if index == 5 then
			loyalty = value
		end
		if index == 6 then
			happiness = value
		end
		if index == 7 then
			petFoodList = value
		end    
	end
	miscinfo = L["PetFamilies_Unknown"]
	--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
	defaultSpec =  StableSnapshot:GetPetDefaultSpec(family)	
	specialAbility =  StableSnapshot:GetPetSpecialAbility(family)
	if loyalty == nil then
		loyalty = defaultSpec
	else
		loyalty = "<" .. loyalty .. ">"
	end
	return name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList
end

--function StableSnapshot:GetPetTypeInfo(class)
	--return StableSnapshot.DBDefaults[class] or ""
--end

-- 
function StableSnapshot:GetPetSpellDetails(spellName)
  StableSnapshot:DebugMessage("GetPetSpellDetails spellName: " .. spellName .. "'")
	--print("Spell details--> for "..spellName);
	--print("GetPetSpellDetails: input=".. class)
	--local sn = "SpecialAbilities/".. class
	--print("GetPetSpellDetails: sn=<".. sn ..">")
	spellID = ""
	text	= ""
	range	= ""
	castTime= ""
	cd      =""
	spellArr = StableSnapshot.DBSPELLS[spellName]
	if spellArr == nil then
		--print("Spell results are nil");
	else
		--[[
		for index,value in pairs(spellArr) do 
			local key = tostring(index)
			local val = value
			print( "*"..key .. " : " .. value )
			if key=="text" then
				--text = val;
			end
		end
		--]]
		spellID  = spellArr["spellID"]
		text	 = spellArr["text"]
		range	 = spellArr["range"]
		castTime = spellArr["castTime"]
		cd	     = spellArr["cd"]
	end	
	--print("<--Spell details");
	return spellID, text, range, castTime, cd
end

-- 
function StableSnapshot:GetPetSpecialAbility(family)
	ldb2 = StableSnapshot.DBDefaults2[family]
	if ldb2 then
		return ldb2["SpecialAbility"] or ""
	end
	return ""
end

-- 
function StableSnapshot:GetPetDefaultSpec(family)
	ldb2 = StableSnapshot.DBDefaults2[family]
	if ldb2  then
		return ldb2["DefaultSpec"] or ""
	end
	return ""
end

-- 
function StableSnapshot:ClearAllPets()
	self.db =  LibStub("AceDB-3.0"):New("StableSnapshotDB", StableSnapshotDB_defaults, true )     
	self.db.char.stable = {}	
	self.db.char.stable_petnumidx = nil;
	self.db.char.stable_lasttime  = nil;
end

-- The main function that loops through all pets in the Stable and stores them for viewing later
function StableSnapshot:ScanStable()
 	--maxPets    = 5
 	haveFilled = 0
	petnumidx  = 1
	self.db.char.stable = {}
  
  -- Current Pet as ZERO  
  local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
  local currXP, nextXP = GetPetExperience()
  local petFoodList = { GetPetFoodTypes() };

	--StableSnapshot:DebugMessage("ScanStable: GetStablePetInfo, maxPets = " .. StableSnapshot.maxPets )
  --
	for index=0, StableSnapshot.maxPets do		
		--retail  petIcon, petName, petLevel, petType, petTalents = GetStablePetInfo(index);
		--classic petIcon, petName, petLevel, petType, petLoyalty = GetStablePetInfo(index);
		local icon, name, level, family, loyalty = GetStablePetInfo(index)
		if  icon == nil then
			icon = "";
		end
		if  name == nil then
			name = "";
		end
		if  level == nil then
			level = "";
		end
		if  family == nil then
			family = "";
		end
		if  loyalty == nil then
			loyalty = "";
		end
    if  happiness == nil then
			happiness = "";
		end
    --damagePercentage, loyaltyRate
    if  petFoodList == nil then
			petFoodList = "";
		end    
    --local currXP, nextXP = GetPetExperience()
  
		StableSnapshot:DebugMessage("ScanStable: GetStablePetInfo, index = " .. index .." icon=" .. icon .. " name="..name.." level="..level.." family=" .. family.. " loyalty="..loyalty .. " happiness="..happiness .. " petFoodList="..tostring(petFoodList)
      );
		--if name == nil then
			--print("Pet: noname")
		--else 
    --print("Store: Pet: " .. name .. " is a " .. family .. " as index: " .. petnumidx )
    --petarr =  { name, level, family, talent } 
    --
    petarr = {}
    petarr =  {name, family, level, icon, loyalty, happiness, petFoodList }
    self.db.char.stable[petnumidx] =  petarr
    petnumidx = petnumidx +1
		if name   then		
			haveFilled = haveFilled +1
		end
	end --for
	--print("Stored: num pets: " .. petnumidx)
	print( L["ScanStable_SavedNum"] .. haveFilled )
	self.db.char.stable_petnumidx = petnumidx			
	self.db.char.stable_lasttime = date("%B %m %Y %H:%M:%S")		
end 

-- 
function StableSnapshot:printPet(petarr,index) 
	--name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
  name, family, level, icon, specialAbility, defaultSpec, loyalty, happiness, petFoodList = StableSnapshot:ParsePetArray(petarr)

	if name == nil then
		print( L["PrintPet_CantPrintNum"] .. index )
	else 
		if family == nil then
			print("PrintPet: " .. name )
		else
			--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
			defaultSpec    =  StableSnapshot:GetPetDefaultSpec(family)	
			specialAbility =  StableSnapshot:GetPetSpecialAbility(family)
			print("PrintPet: " .. name .. " is a " .. family .. " --> " .. specialAbility .. " loyalty = " .. loyalty) 
			print("          DefaultSpec = <" .. defaultSpec .. "> SpecialAbility = <"  .. specialAbility ..">") 
      --TODO
		end
	end
end

-- Command line function only
function StableSnapshot:ShowStable()
	StableSnapshot:DebugMessage("ShowStable Called")
	maxNum  = self.db.char.stable_petnumidx;
	if maxNum == nil then
		print( L["ShowStable_NoneSaved"] )
		--playerUnitId = UnitId("player")
		localizedClass, englishClass = UnitClass("player");
		StableSnapshot:DebugMessage("ShowStable englishClass: " .. englishClass .. "'" )
		if englishClass == 'HUNTER' then
			print( L["ShowStable_NoneSaved_Hunter"] )
		end
	else 
		print( L["ShowStable_MaxNum"] .. maxNum )	
		
		petarrAll = self.db.char.stable
		if petarrAll == nil then
			print( L["ShowStable_NoPets"] )
		else 	
			for index=1, maxNum-1 do				
				petarr = self.db.char.stable[index] 
				if petarr == nil then
					StableSnapshot:DebugMessage("ShowStable: can't print pet: " .. index )
				else 
					StableSnapshot:printPet(petarr,index)
				end
			end
		end
	end
	StableSnapshot:DebugMessage("ShowStable Done")
end

-- 
function StableSnapshot:ParsePetFamilyArrayVal(petarr) 
	if petarr == nil then
		return "", ""
	end
	
	name = ""
	value = ""
	for index,value in pairs(petarr) do 	
		if index == 1 then
			name = value
		end
		if index == 2 then
			value = value
		end		
	end
	
	return name, value
end
