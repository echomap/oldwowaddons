--
-- Translations
--
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("RealmImIn", "zhTW", false)
if not L then return end

--Probably static
L["ADDON_NAME"] = "StableSnapshot"

-- Translations
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
L["Main_Title"] = "Printed: " 
L["Main_StatusText"] = "Printed: " 
L["PrintPet_CantPrintNum"] = "Printed: " 
L["Main_Title"] = "--Stable Snapshot--" 
L["Main_StatusText"] = "Stable Snapshot " 
L["Main_LastUpdatedText"] = "Last Updated: " 
