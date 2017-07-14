--[[	
*** StableSnapshot ***
Written by : echomap
--]]

local L = LibStub("AceLocale-3.0"):GetLocale("StableSnapshot", false)

--TEST FUNCTIONS

function StableSnapshot:CountBySpecial()
	StableSnapshot:DebugMessage("CountBySpecial: Called")
	countBySpecialDB = {}	
	petListDB = {}	
	
	countarr = StableSnapshot:CountByFamily()
	
	for family,amount in pairs( countarr ) do 			
		StableSnapshot:DebugMessage("CountBySpecial: family: '" .. family .. "' amount: " .. amount )
		--miscinfo =  StableSnapshot:GetPetTypeInfo(family)
		
		--0StableSnapshot:DebugMessage("CountBySpecial: Special is: '" .. miscinfo .. "'")	 
		if family == nil or miscinfo == nil then
		else 		
			if countBySpecialDB[miscinfo] == nil then							
				countBySpecialDB[miscinfo] = 1						
			else
				countBySpecialDB[miscinfo] = countBySpecialDB[miscinfo] + 1							
			end						
		
			if petListDB[miscinfo] == nil then
				petListDB[miscinfo] = family
			else
				petListDB[miscinfo] = petListDB[miscinfo] .. ", " .. family
				--StableSnapshot:DebugMessage("CountBySpecial: miscinfo: " .. miscinfo .. " = " .. petListDB[miscinfo] )
			end	
				
		end
	end
		
	for miscinfo,amount in pairs( countBySpecialDB ) do 			
		StableSnapshot:DebugMessage("CountBySpecial: Total for Special: '" .. miscinfo .. "'=" .. amount )
	end
		
	StableSnapshot:DebugMessage("CountBySpecial: Done")
	return countBySpecialDB, petListDB
end

function StableSnapshot:CountByFamilyGui()
	local AceGUI = LibStub("AceGUI-3.0")
 	local f = AceGUI:Create("Frame")
	f:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end )
	f:SetLayout("Fill")
	f:SetTitle( "Count by Family" )
	f:SetStatusText( "" )	
	f:SetWidth(400)
	f:SetHeight(625)
	--f:SetMovable(true)
	--f:SetParent(StableSnapshot_MainFrame)
	f:SetPoint("TOP", UIParent, "TOP", 0, -100)
	
	_G["StableSnapshot_Display_CBF"] = f
	tinsert (UISpecialFrames, "StableSnapshot_Display_CBF")
		
	countarr = StableSnapshot:CountByFamily()
	
	blueColor = "|cff1fb3ff"
	redColor = "|cFFFF0000"
			
	text1 = ""
	for family,value in pairs( StableSnapshot.DBDefaults ) do 			
			value = countarr[family]
			StableSnapshot:DebugMessage("CountByFamilyGui: family: " .. family )						
			if value == nil then
				value = 0
			end
			StableSnapshot:DebugMessage("CountByFamilyGui: value: " .. value )
			miscinfo =  StableSnapshot:GetPetTypeInfo(family)
			defaultSpec =  StableSnapshot:GetPetDefaultSpec(family)	
			specialAbility =  StableSnapshot:GetPetSpecialAbility(family)

			-- blue |cff1fb3ff
			-- red  |cFFFF0000						
			text1 = text1 .. "|cff1fb3ff".."DefaultSpec:"  .."|r " .. defaultSpec .. "   "
			text1 = text1 .. "|cff1fb3ff".."Count:"   .."|r " 
			if value == 0 then
				text1 = text1 .. "|cFFFF0000" .. value  .."|r " .. "   "
			else 
				text1 = text1 .. value  .. "   "
			end
			
			
			text1 = text1 .. "|cff1fb3ff".."Special:" .."|r " .. specialAbility .. "   "
			text1 = text1 .. " \n"
			--text1 = text1 .. "\n Family: " .. family .. "           Count: "  .. value 		
	end	
		
	local eb1 = AceGUI:Create("MultiLineEditBox")
	eb1:SetLabel("StableSnapshot Count By Family")
	eb1:SetText(text1)
	--eb1:SetWidth(400)
	eb1:SetNumLines(26)
	eb1:DisableButton(true)
	f:AddChild(eb1)		
end

function StableSnapshot:CountByFamily()
	StableSnapshot:DebugMessage("CountByFamily: Called")
	countByFamilyDB = {}
	petarrAll = self.db.char.stable
	if petarrAll == nil then
		print( L["ShowStable_NoPets"] )
	else 	
		for index=1, maxPets do				
			petarr = self.db.char.stable[index] 
			if petarr == nil then
				--StableSnapshot:DebugMessage("ShowStable: can't print pet: " .. index )
			else 
				name, family, level, icon, specialAbility, defaultSpec, talent = StableSnapshot:ParsePetArray(petarr)
				if name == nil then
					StableSnapshot:DebugMessage( L["PrintPet_CantPrintNum"] .. index )
				else 
					if family == nil or family == "" then
						StableSnapshot:DebugMessage( L["PrintPet_CantPrintNum"] .. index .. " name: " .. name )
					else
						if countByFamilyDB[family] == nil then							
							countByFamilyDB[family] = 1						
						else
							countByFamilyDB[family] = countByFamilyDB[family] + 1							
						end						
						--StableSnapshot:DebugMessage("CountByFamily: family: "..family.." sofar: " .. countByFamilyDB[family] )
					end
				end
			end
		end
	end
		
	--print("ParsePetFamilyArray: Report>>")
	for family,value in pairs( StableSnapshot.DBDefaults ) do 			
			--StableSnapshot:DebugMessage("ParsePetFamilyArray: family: " .. family )
			value = countByFamilyDB[family]
			if value == nil then
				value = 0
			end
			--print( "Family: " .. family .. " Count: "  .. value )
	end
	--print("Totals: TODO " )	
	
	StableSnapshot:DebugMessage("CountByFamily: Done")
	return countByFamilyDB
end


function StableSnapshot:CountBySpecialGui()
	local AceGUI = LibStub("AceGUI-3.0")
 	local f = AceGUI:Create("Frame")
	f:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end )
	f:SetLayout("Fill")
	f:SetTitle( "Count by Special" )
	f:SetStatusText( "" )	
	f:SetWidth(400)
	f:SetHeight(450)
	--f:SetMovable(true)
		
	_G["StableSnapshot_Display_CBS"] = f
	tinsert (UISpecialFrames, "StableSnapshot_Display_CBS")

	countBySpecialDB, petListDB = StableSnapshot:CountBySpecial()
	for family,special in pairs( StableSnapshot.DBDefaults ) do 			
		if countBySpecialDB[special] == nil then
			countBySpecialDB[special] = 0
		end  
	end	
	
	blueColor = "|cff1fb3ff"
	redColor = "|cFFFF0000"			
			
	totalCount = 0
	text1 = ""
	for miscinfo,value in pairs( countBySpecialDB ) do 			
			StableSnapshot:DebugMessage("CountBySpecialGui: special: " .. miscinfo )						
			if value == nil then
				value = 0
			end
			StableSnapshot:DebugMessage("CountBySpecialGui: value: " .. value )
			totalCount = totalCount + value
			text1 = text1 .. "|cff1fb3ff".."Special:"  .."|r " .. miscinfo .. "   "
			text1 = text1 .. "|cff1fb3ff".."Count:"   .."|r " 
			if value == 0 then
				text1 = text1 .. "|cFFFF0000" .. value  .."|r " .. "   "
			else 
				text1 = text1 .. value  .. "   "
			end
					
			petsBelongingTo = petListDB[miscinfo]
			if petsBelongingTo == nil then
				petsBelongingTo = ""
			end
			text1 = text1 .. "  <" .. petsBelongingTo .. ">"
			
			text1 = text1 .. " \n"
			--text1 = text1 .. "\n Family: " .. family .. "           Count: "  .. value 		
	end	
		
	local eb1 = AceGUI:Create("MultiLineEditBox")
	eb1:SetLabel("StableSnapshot Count By Special: totalCount: " .. totalCount)
	eb1:SetText(text1)
	--eb1:SetWidth(400)
	eb1:SetNumLines(26)
	eb1:DisableButton(true)
	f:AddChild(eb1)		
end

--TEST FUNCTIONS

-- END OF FILE