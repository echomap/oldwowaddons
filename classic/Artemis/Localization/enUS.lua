-------------------------------------------------------------------------
-- English Translations
-------------------------------------------------------------------------
local addonName, L = ...; -- Let's use the private table passed to every .lua file to store our locale
local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to 
 -- avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});
-------------------------------------------------------------------------
-------------------------------------------------------------------------
--Probably static
L["ADDON_NAME"] = "Artemis"

-- Translations
L["msgTimeFormat"] = "%dm %02ds"
L["Addon_Desc"] = "Artemis - An addon for hunters to take a snapshot of their stable, so they can remember what pets they have anywhere!"

L["StableNoPets"]            = "You have no pets at this time?"
L["StableOpenMessage"]       = "You have opened the stable!"
L["StableNotAHunterMessage"] = "You are not a hunter and can't stable pets."
L["StableNumPetsMessage"]    = "You have %s pets."
L["PetUnitChanged"]          = "Pet was switched out or changed? (TODO)")
L["PetFamilies_Unknown"]     = "Unknown"
L["PrintPet_CantPrintNum"]   = "Problem printed index=%d" 
L["ShowStable_MaxNum"]       = "Pets: Maximum saved is: %d"
L["ShowStable_NoneSaved"]    = "No Pets saved"
L["ShowStable_NoneSaved_Hunter"] = "No saved pets yet, visit your Stable Master."
L["ShowStable_NoPets"]           = "No saved pets yet, visit your Stable Master."

--L["ldb_tooltip1"]  = "StableSnapshot is an AddOn hunters can use to see their stable when they are not near a Stable Master."
--L["ldb_tooltip2"]  = "|cff1fb3ffClick|r to open the report."
--L["ScanStable_SavedNum"] = "Pets saved: "
--L["Main_Title"] = "--Stable Snapshot--" 
--L["Main_LastUpdatedText"] = "Last Updated: " 
--L["Main_Title"] = "-=StableSnapshot=-" 
--L["Main_StatusText"] = "Your Pets (view only) from anywhere!"
-- 
--
