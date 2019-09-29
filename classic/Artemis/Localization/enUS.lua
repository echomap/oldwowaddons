--
-- English Translations
--
local addonName, L = ...; -- Let's use the private table passed to every .lua file to store our locale
local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});


--Probably static
L["ADDON_NAME"] = "StableSnapshot"

-- Translations
L["msgTimeFormat"]="%dm %02ds"

L["Addon_Desc"] = "StableSnapshot - An addon for hunters to take a snapshot of their stable, so they can remember what pets they have anywhere."

L["ldb_tooltip1"]  = "StableSnapshot is an AddOn hunters can use to see their stable when they are not near a Stable Master."
L["ldb_tooltip2"]  = "|cff1fb3ffClick|r to open the report."
L["PetFamilies_Unknown"] = "Unknown"
L["ScanStable_SavedNum"] = "Pets saved: "
L["PrintPet_CantPrintNum"] = "Printed: " 
L["ShowStable_NoneSaved"] = "No Pets saved"
L["ShowStable_NoneSaved_Hunter"] = "No saved pets yet, visit your Stable Master"
L["ShowStable_MaxNum"] = "Maxium Saved is: " 
L["ShowStable_NoPets"] = "No saved pets yet, visit your Stable Master"
L["PrintPet_CantPrintNum"] = "Printed: " 
L["Main_Title"] = "--Stable Snapshot--" 
L["Main_StatusText"] = "Stable Snapshot " 
L["Main_LastUpdatedText"] = "Last Updated: " 
L["Main_Title"] = "-=StableSnapshot=-" 
L["Main_StatusText"] = "Your Pets (view only) from anywhere!" 
