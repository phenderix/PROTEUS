Scriptname ProteusCheatFunctions 

import PO3_SKSEFunctions
import PhenderixToolResourceScript
import CharGen
import JContainers
import ProteusDLLUtils

String Function GetFormMenuName(Form theForm) global
    String name = GetFormEditorID(theForm)
		if(name == "")
			name = theForm.GetName()
		endif
        if(name == "")
            name = "(Missing Name)"
        endif
    return name
EndFunction

Function Proteus_CheatSpell(Actor targetActor, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Spell menu loading...may take a few seconds!")
    Form[] allGameSpells = GetAllForms(typeCode) ;get all Spells in game and from mods

    int numPages = (allGameSpells.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Search Spells]")
        i+=1
        while startingPoint <= allGameSpells.Length && i < 128
			String name = GetFormMenuName(allGameSpells[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int spellCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
			Form[] foundSpells = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatSpellSearch(targetActor, foundSpells, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatSpell(targetActor, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedSpell = allGameSpells[startingPointInitial + result - 2]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpell(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedSpell = allGameSpells[result - 2]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpell(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction

Function Proteus_CheatSpellSearch(Actor targetActor, Form[] foundSpells, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Spell menu loading...may take a few seconds!")
    Form[] allGameSpells = foundSpells ;get all Spells in game and from mods

    int numPages = (allGameSpells.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Search Spells]")
        i+=1
        while startingPoint <= allGameSpells.Length && i < 128
            String name = GetFormMenuName(allGameSpells[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int spellCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
			Form[] foundSpells2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatSpellSearch(targetActor, foundSpells2, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatSpellSearch(targetActor, foundSpells, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedSpell = allGameSpells[startingPointInitial + result - 2]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpellSearch(targetActor, foundSpells, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedSpell = foundSpells[result - 2]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpellSearch(targetActor, foundSpells, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction

Function Proteus_CheatPerk(Actor targetActor, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Perk menu loading...may take a few seconds!")
    Form[] allGamePerks = GetAllForms(typeCode) ;get all Perks in game and from mods

    int numPages = (allGamePerks.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Search Perks]")
        i+=1
        while startingPoint <= allGamePerks.Length && i < 128
            String name = GetFormMenuName(allGamePerks[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int PerkCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundPerks = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatPerkSearch(targetActor, foundPerks, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatPerk(targetActor, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedPerk = allGamePerks[startingPointInitial + result - 2]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerk(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedPerk = allGamePerks[result - 2]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerk(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction

Function Proteus_CheatPerkSearch(Actor targetActor, Form[] foundPerks, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Perk menu loading...may take a few seconds!")
    Form[] allGamePerks = foundPerks ;get all Perks in game and from mods

    int numPages = (allGamePerks.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Search Perks]")
        i+=1
        while startingPoint <= allGamePerks.Length && i < 128
            String name = GetFormMenuName(allGamePerks[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int PerkCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundPerks2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatPerkSearch(targetActor, foundPerks2, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatPerkSearch(targetActor, foundPerks, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedPerk = allGamePerks[startingPointInitial + result - 2]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerkSearch(targetActor, foundPerks, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedPerk = foundPerks[result - 2]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerkSearch(targetActor, foundPerks, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction




Function Proteus_CheatShout(Actor targetActor, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Shout menu loading...may take a few seconds!")
    Form[] allGameShouts = GetAllForms(typeCode) ;get all Shouts in game and from mods

    int numPages = (allGameShouts.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Search Shouts]")
        i+=1
        while startingPoint <= allGameShouts.Length && i < 128
            String name = GetFormMenuName(allGameShouts[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int ShoutCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundShouts = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatShoutSearch(targetActor, foundShouts, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatShout(targetActor, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedShout = allGameShouts[startingPointInitial + result - 2]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShout(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedShout = allGameShouts[result - 2]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShout(targetActor, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction

Function Proteus_CheatShoutSearch(Actor targetActor, Form[] foundShouts, int startingPoint, int currentPage, int typeCode, Quest ZZProteusSkyUIMenu) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Shout menu loading...may take a few seconds!")
    Form[] allGameShouts = foundShouts ;get all Shouts in game and from mods

    int numPages = (allGameShouts.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Search Shouts]")
        i+=1
        while startingPoint <= allGameShouts.Length && i < 128
            String name = GetFormMenuName(allGameShouts[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            int ShoutCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundShouts2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatShoutSearch(targetActor, foundShouts2, 0, 1, typeCode, ZZProteusSkyUIMenu)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatShoutSearch(targetActor, foundShouts, startingPoint, currentPage, typeCode, ZZProteusSkyUIMenu)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedShout = allGameShouts[startingPointInitial + result - 2]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShoutSearch(targetActor, foundShouts, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        Else
            Form selectedShout = foundShouts[result - 2]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShoutSearch(targetActor, foundShouts, startingPointInitial, currentPage, typeCode, ZZProteusSkyUIMenu)
        endIf
    endIf
EndFunction