Scriptname ProteusCheatFunctions 

import PhenderixToolResourceScript
import CharGen
import JContainers
import ProteusDLLUtils

String Function GetFormMenuName(Form selectedItem) global
    String name = selectedItem.GetName()
    if(name == "")
        name = ProteusGetFormEditorID(selectedItem)
    endif
    if(name == "")
        name = "(Missing Name)"
    endif
    return name
EndFunction


Function Proteus_CheatSpell(Quest ZZProteusSkyUIMenu, Actor targetActor, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Spell menu loading...may take a few seconds!")
    Form[] allGameSpells = ProteusGetAllByFormId(typeCode) ;get all Spells in game and from mods

    int numPages = Math.Ceiling(allGameSpells.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Search Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Spells by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameSpells.Length && i < 128 && allGameSpells[startingPoint] != NONE
			String name = GetFormMenuName(allGameSpells[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameSpells[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
			Form[] foundSpells = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatSpellSearch(ZZProteusSkyUIMenu, targetActor, foundSpells, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGameSpells = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatSpell(ZZProteusSkyUIMenu, targetActor, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedSpell = allGameSpells[startingPointInitial + result - 4]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpell(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedSpell = allGameSpells[result - 4]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpell(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatSpellSearch(Quest ZZProteusSkyUIMenu, Actor targetActor, Form[] foundSpells, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Spell menu loading...may take a few seconds!")
    Form[] allGameSpells = foundSpells ;get all Spells in game and from mods

    int numPages = Math.Ceiling(allGameSpells.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Search Spells]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Spells by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameSpells.Length && i < 128 && allGameSpells[startingPoint] != NONE
            String name = GetFormMenuName(allGameSpells[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameSpells[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
			Form[] foundSpells2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatSpellSearch(ZZProteusSkyUIMenu, targetActor, foundSpells2, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGameSpells = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatSpellSearch(ZZProteusSkyUIMenu, targetActor, foundSpells, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedSpell = allGameSpells[startingPointInitial + result - 4]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpellSearch(ZZProteusSkyUIMenu, targetActor, foundSpells, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedSpell = foundSpells[result - 4]
            targetActor.AddSpell(selectedSpell as Spell)
            Proteus_CheatSpellSearch(ZZProteusSkyUIMenu, targetActor, foundSpells, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatPerk(Quest ZZProteusSkyUIMenu, Actor targetActor, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Perk menu loading...may take a few seconds!")
    Form[] allGamePerks = ProteusGetAllByFormId(typeCode) ;get all Perks in game and from mods

    int numPages = Math.Ceiling(allGamePerks.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Search Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Perks by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGamePerks.Length && i < 128 && allGamePerks[startingPoint] != NONE
            String name = GetFormMenuName(allGamePerks[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGamePerks[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] foundPerks = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatPerkSearch(ZZProteusSkyUIMenu, targetActor, foundPerks, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGamePerks = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatPerk(ZZProteusSkyUIMenu, targetActor, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedPerk = allGamePerks[startingPointInitial + result - 4]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerk(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedPerk = allGamePerks[result - 4]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerk(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatPerkSearch(Quest ZZProteusSkyUIMenu, Actor targetActor, Form[] foundPerks, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Perk menu loading...may take a few seconds!")
    Form[] allGamePerks = foundPerks ;get all Perks in game and from mods

    int numPages = Math.Ceiling(allGamePerks.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Search Perks]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Perks by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGamePerks.Length && i < 128 && allGamePerks[startingPoint] != NONE
            String name = GetFormMenuName(allGamePerks[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGamePerks[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] foundPerks2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatPerkSearch(ZZProteusSkyUIMenu, targetActor, foundPerks2, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGamePerks = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatPerkSearch(ZZProteusSkyUIMenu, targetActor, foundPerks, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedPerk = allGamePerks[startingPointInitial + result - 4]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerkSearch(ZZProteusSkyUIMenu, targetActor, foundPerks, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedPerk = foundPerks[result - 4]
            targetActor.AddPerk(selectedPerk as Perk)
			Debug.Notification(selectedPerk.getName() + " added.")
            Proteus_CheatPerkSearch(ZZProteusSkyUIMenu, targetActor, foundPerks, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatShout(Quest ZZProteusSkyUIMenu, Actor targetActor, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Shout menu loading...may take a few seconds!")
    Form[] allGameShouts = ProteusGetAllByFormId(typeCode) ;get all Shouts in game and from mods

    int numPages = Math.Ceiling(allGameShouts.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Search Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Shouts by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameShouts.Length && i < 128 && allGameShouts[startingPoint] != NONE
            String name = GetFormMenuName(allGameShouts[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameShouts[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] foundShouts = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatShoutSearch(ZZProteusSkyUIMenu, targetActor, foundShouts, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGameShouts = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatShout(ZZProteusSkyUIMenu, targetActor, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedShout = allGameShouts[startingPointInitial + result - 4]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShout(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedShout = allGameShouts[result - 4]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShout(ZZProteusSkyUIMenu, targetActor, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatShoutSearch(Quest ZZProteusSkyUIMenu, Actor targetActor, Form[] foundShouts, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
    Debug.Notification("Shout menu loading...may take a few seconds!")
    Form[] allGameShouts = foundShouts ;get all Shouts in game and from mods

    int numPages = Math.Ceiling(allGameShouts.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Search Shouts]")
        i+=1
        listMenuBase.AddEntryItem("[Explore Shouts by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameShouts.Length && i < 128 && allGameShouts[startingPoint] != NONE
            String name = GetFormMenuName(allGameShouts[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameShouts[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] foundShouts2 = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatShoutSearch(ZZProteusSkyUIMenu, targetActor, foundShouts2, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, targetActor, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGameShouts = NONE
        PlayerCheats(ZZProteusSkyUIMenu, targetActor)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatShoutSearch(ZZProteusSkyUIMenu, targetActor, foundShouts, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedShout = allGameShouts[startingPointInitial + result - 4]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShoutSearch(ZZProteusSkyUIMenu, targetActor, foundShouts, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedShout = foundShouts[result - 4]
            targetActor.AddShout(selectedShout as Shout)
			int s = 0
			while (selectedShout as Shout).GetNthWordOfPower(s)
				WordOfPower wordTemp = (selectedShout as Shout).GetNthWordOfPower(s)
				Game.UnlockWord(wordTemp)
				s+=1
			endWhile
			Debug.Notification(selectedShout.getName() + " added.")
            Proteus_CheatShoutSearch(ZZProteusSkyUIMenu, targetActor, foundShouts, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatItem(Quest ZZProteusSkyUIMenu, Actor target, int startingPoint, int currentPage, int typeCode) global
	String typeString = Proteus_GetTypeString(typeCode)

	Debug.Notification(typeString + " menu loading...may take a few seconds!")

    Form[] allGameItems = Utility.CreateFormArray(10000)
    allGameItems = ProteusGetAllByFormId(typeCode) ;get all Items in game and from mods
	int numPages = Math.Ceiling(allGameItems.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding" + typeString + "]")
        i+=1
        listMenuBase.AddEntryItem("[Search" + typeString + "]")
        i+=1
		listMenuBase.AddEntryItem("[Explore" + typeString + " by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameItems.Length && i < 128
			String name = GetFormMenuName(allGameItems[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameItems[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            int itemCount = ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundItems = ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatItemSearch(ZZProteusSkyUIMenu, target, foundItems, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, typeCode, 0)    
    elseif result == 3 ;back option
        allGameItems = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
	elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatItem(ZZProteusSkyUIMenu, target, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedItem = allGameItems[startingPointInitial + result - 4]
            Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
            Utility.Wait(0.1)
            if (itemAmount > 0)   
                target.AddItem(selectedItem, itemAmount,  true)
                String name = selectedItem.GetName()
                Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
                if(typeCode == 41 || typeCode == 26 || typeCode == 42)
                    Utility.Wait(0.1)
                    target.EquipItem(selectedItem)
                endIf
            elseif itemAmount != 0
                Debug.Notification("Invalid amount entered.")
            endIf
            Proteus_CheatItem(ZZProteusSkyUIMenu, target, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedItem = allGameItems[result - 4]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				target.AddItem(selectedItem, itemAmount,  true)
				String name = GetFormMenuName(selectedItem)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					target.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItem(ZZProteusSkyUIMenu, target, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatItemSearch(Quest ZZProteusSkyUIMenu, Actor target, Form[] foundItems, int startingPoint, int currentPage, int typeCode) global ;option 0 = cheat, 1 = reset
	String typeString = Proteus_GetTypeString(typeCode)
	Debug.Notification(typeString + " menu loading...may take a few seconds!")
	
	Form[] allGameItems = foundItems ;get all Items in game and from mods

	int numPages = Math.Ceiling(allGameItems.Length / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding" + typeString + "]")
        i+=1
        listMenuBase.AddEntryItem("[Search" + typeString + "]")
        i+=1
		listMenuBase.AddEntryItem("[Explore" + typeString + " by Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= allGameItems.Length && i < 128
			String name = GetFormMenuName(allGameItems[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
			if(allGameItems[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            int itemCount = ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundItems2 = ProteusGetItemBySearch(searchTerm, typeCode, "")
            Proteus_CheatItemSearch(ZZProteusSkyUIMenu, target, foundItems2, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;mod explorer option
		Utility.Wait(0.1)
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, typeCode, 0)
    elseif result == 3 ;back option
        allGameItems = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
	elseif result == 127 ;next page option,
        currentPage += 1
        Proteus_CheatItemSearch(ZZProteusSkyUIMenu, target, foundItems, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedItem = allGameItems[startingPointInitial + result - 4]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				target.AddItem(selectedItem, itemAmount,  true)
				String name = GetFormMenuName(selectedItem)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					target.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItemSearch(ZZProteusSkyUIMenu, target, foundItems, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedItem = foundItems[result - 4]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				target.AddItem(selectedItem, itemAmount,  true)
				String name = GetFormMenuName(selectedItem)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					target.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItemSearch(ZZProteusSkyUIMenu, target, foundItems, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

;option = 0 is by type code, option = 999 is all items
Function Proteus_ModExplorer(Quest ZZProteusSkyUIMenu, Actor target, int startingPoint, int currentPage, int typeCode, int option) global
	Debug.Notification("Mod Explorer loading...may take a few seconds!")
	int numMods = Game.GetModCount()
	String[] modNames = Utility.CreateStringArray(numMods)

	int numPages = Math.Ceiling(numMods / 127 as Float) as Int
    int startingPointInitial = startingPoint

	int i = 0
	while i < numMods
		modNames[i] = Game.GetModName(i)
		i += 1
	EndWhile
	i = 0
	UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        listMenuBase.AddEntryItem("[Quit" + Proteus_GetTypeString(typeCode) + " Mod Explorer]")
        i+=1
        listMenuBase.AddEntryItem("[Search For Mod]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= numMods && i < 128
            listMenuBase.AddEntryItem(modNames[startingPoint])
            i += 1
            startingPoint += 1
			if(modNames[startingPoint] == "")
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for mod named:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)  
			int j = 0
			int z = 0
			String[] foundItems = Utility.CreateStringArray(5000)
			while j < numMods 
				Int indexSearch = Stringutil.Find(modNames[j], searchTerm, 0)
				if indexSearch != -1
					foundItems[z] = modNames[j]
					z += 1
				endIf
				j+=1
			endWhile
			if z == 0
				Debug.Notification("No matching mods found for search term.")
			endIf
            Proteus_ModExplorer_Search(ZZProteusSkyUIMenu, target, modNames, foundItems, z, 0, 1, typeCode, option)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;back option
        modNames = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_ModExplorer(ZZProteusSkyUIMenu, target, startingPoint, currentPage, typeCode, option)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, modNames[startingPointInitial + result - 3], startingPointInitial, currentPage, typeCode, option)
        Else
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, modNames[result - 3], startingPointInitial, currentPage, typeCode, option)
        endIf
    endIf
endFunction

;option = 0 is by type code, option = 999 is all items
Function Proteus_ModExplorer_Search(Quest ZZProteusSkyUIMenu, Actor target, String[] modNames, String[] matchingMods, int countMatches, int startingPoint, int currentPage, int typeCode, int option) global

	int numPages = Math.Ceiling(countMatches / 127 as Float) as Int
    int startingPointInitial = startingPoint

	int i = 0
	UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        listMenuBase.AddEntryItem("[Quit" + Proteus_GetTypeString(typeCode) + " Mod Explorer]")
        i+=1
        listMenuBase.AddEntryItem("[Search For Mod]")
        i+=1
		listMenuBase.AddEntryItem("[Back to Mod List]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= matchingMods.Length && i < 128
            listMenuBase.AddEntryItem(matchingMods[startingPoint])
            i += 1
            startingPoint += 1
			if(matchingMods[startingPoint] == "")
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for mod named:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)  
			int j = 0
			int z = 0
			int numMods = Game.GetModCount()
			String[] foundItems = Utility.CreateStringArray(5000)
			while j < numMods 
				Int indexSearch = stringutil.Find(modNames[j], searchTerm, 0)
				if indexSearch != -1
					foundItems[z] = modNames[j]
					z += 1
				endIf
				j+=1
			endWhile
			if z == 0
				Debug.Notification("No matching mods found for search term.")
			endIf
            Proteus_ModExplorer_Search(ZZProteusSkyUIMenu, target, modNames, foundItems, z, 0, 1, typeCode, option)
        else
            Debug.Notification("Invalid length search term.")
        endIf
	elseif result == 2 ;back to mod list
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, typeCode, option)
    elseif result == 3 ;back option
        matchingMods = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_ModExplorer(ZZProteusSkyUIMenu, target, startingPoint, currentPage, typeCode, option)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, matchingMods[startingPointInitial + result - 4], startingPointInitial, currentPage, typeCode, option)
        Else
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, matchingMods[result - 4], startingPointInitial, currentPage, typeCode, option)
        endIf
    endIf
endFunction

Function Proteus_ModExplorer_Dive(Quest ZZProteusSkyUIMenu, Actor target, String selectedMod, int startingPoint, int currentPage, int typeCode, int option) global
	String typeString = Proteus_GetTypeString(typeCode)
	Debug.Notification(typeString + " mod explorer menu loading...may take a few seconds!")
    Int counterAll
    Form[] itemArray = Utility.CreateFormArray(10000)
    if typeCode == 999
        Form[] weaponArray = ProteusGetAllInModByFormId(41, selectedMod)
        Form[] armorArray = ProteusGetAllInModByFormId(26, selectedMod)
        Form[] miscArray = ProteusGetAllInModByFormId(32, selectedMod)
        Form[] ammoArray = ProteusGetAllInModByFormId(42, selectedMod)
        Form[] scrollArray = ProteusGetAllInModByFormId(23, selectedMod)
        Form[] bookArray = ProteusGetAllInModByFormId(27, selectedMod)
        Form[] keyArray = ProteusGetAllInModByFormId(45, selectedMod)
        Form[] potionArray = ProteusGetAllInModByFormId(46, selectedMod)
        int w = 0
        counterAll = 0
        while w < weaponArray.Length && weaponArray[w]
            itemArray[counterAll] = weaponArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < armorArray.Length && armorArray[w]
            itemArray[counterAll] = armorArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < miscArray.Length && miscArray[w]
            itemArray[counterAll] = miscArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < ammoArray.Length && ammoArray[w]
            itemArray[counterAll] = ammoArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < scrollArray.Length && scrollArray[w]
            itemArray[counterAll] = scrollArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < bookArray.Length && bookArray[w]
            itemArray[counterAll] = bookArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < keyArray.Length && keyArray[w]
            itemArray[counterAll] = keyArray[w]
            w += 1
            counterAll += 1
        endWhile
        w = 0
        while w < potionArray.Length && potionArray[w]
            itemArray[counterAll] = potionArray[w]
            w += 1
            counterAll += 1
        endWhile
    else
        itemArray = ProteusDLLUtils.ProteusGetAllInModByFormId(typeCode, selectedMod)
    endIf

	int numPages = Math.Ceiling(counterAll / 127 as Float) as Int
    int startingPointInitial = startingPoint

	int i = 0
	UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        listMenuBase.AddEntryItem("[Quit" + Proteus_GetTypeString(typeCode) + " Mod Explorer]")
        i+=1
        listMenuBase.AddEntryItem("[Search " + selectedMod + " for" + typeString + "]")
        i+=1
        if typeCode == 22 ;spell
            listMenuBase.AddEntryItem("[Add All Spells]")
        elseif typeCode == 92 ;perk
            listMenuBase.AddEntryItem("[Add All Perks]")
        elseif typeCode == 119 ;shout
            listMenuBase.AddEntryItem("[Add All Shouts]")
        else
            listMenuBase.AddEntryItem("[Add All to Inventory]")
        endIf
        i+=1
		listMenuBase.AddEntryItem("[Back to Mod List]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= itemArray.Length && i < 128
			String name = GetFormMenuName(itemArray[startingPoint])
            listMenuBase.AddEntryItem(name)			
			i += 1
            startingPoint += 1
            if(itemArray[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] allGameItems = Utility.CreateFormArray(10000)
            if typeCode == 999
                Form[] weaponArray = ProteusGetItemBySearch(searchTerm, 41, selectedMod)
                Form[] armorArray = ProteusGetItemBySearch(searchTerm, 26, selectedMod)
                Form[] miscArray = ProteusGetItemBySearch(searchTerm, 32, selectedMod)
                Form[] ammoArray = ProteusGetItemBySearch(searchTerm, 42, selectedMod)
                Form[] scrollArray = ProteusGetItemBySearch(searchTerm, 23, selectedMod)
                Form[] bookArray = ProteusGetItemBySearch(searchTerm, 27, selectedMod)
                Form[] keyArray = ProteusGetItemBySearch(searchTerm, 45, selectedMod)
                Form[] potionArray = ProteusGetItemBySearch(searchTerm, 46, selectedMod)
                int w = 0
                counterAll = 0
                while w < weaponArray.Length && weaponArray[w]
                    allGameItems[counterAll] = weaponArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < armorArray.Length && armorArray[w]
                    allGameItems[counterAll] = armorArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < miscArray.Length && miscArray[w]
                    allGameItems[counterAll] = miscArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < ammoArray.Length && ammoArray[w]
                    allGameItems[counterAll] = ammoArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < scrollArray.Length && scrollArray[w]
                    allGameItems[counterAll] = scrollArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < bookArray.Length && bookArray[w]
                    allGameItems[counterAll] = bookArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < keyArray.Length && keyArray[w]
                    allGameItems[counterAll] = keyArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < potionArray.Length && potionArray[w]
                    allGameItems[counterAll] = potionArray[w]
                    w += 1
                    counterAll += 1
                endWhile
            else
                allGameItems = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, selectedMod)
            endIf
            Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, allGameItems, selectedMod, 0, 1, typeCode, option, counterAll)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;add all
		int j = 0
        if(typeCode != 92 && typeCode != 22 && typeCode != 119)
            while j < itemArray.Length
                target.AddItem(itemArray[j], 1, true)
                j+=1
		    endWhile
            Debug.Notification("All matching items added to inventory.")
        elseif typeCode == 92
            while j < itemArray.Length
                target.AddPerk(itemArray[j] as Perk)
                j+=1
            endWhile
            Debug.Notification("All matching perks added.")
        elseif typeCode == 22
            while j < itemArray.Length
                target.AddSpell(itemArray[j] as Spell)
                j+=1
            endWhile
            Debug.Notification("All matching spells added.")
        elseif typeCode == 119
            while j < itemArray.Length
                target.AddShout(itemArray[j] as Shout)
                j+=1
                int s = 0
                while (itemArray[j] as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (itemArray[j] as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
            endWhile
            Debug.Notification("All matching shouts added.")
        endIf
		Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, selectedMod, startingPointInitial, currentPage, typeCode, option)
	elseif result == 3 ;back to mod list
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, typeCode, option)
    elseif result == 4 ;back option
        itemArray = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
	elseif result == 127 ;next page option
        currentPage += 1
		Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, selectedMod, startingPoint, currentPage, typeCode, option)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
			Form selectedItem = itemArray[startingPointInitial + result - 5]
            if(typeCode != 92 && typeCode != 22 && typeCode != 119)
                Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
                Utility.Wait(0.1)
                if (itemAmount > 0)   
                    target.AddItem(selectedItem, itemAmount, true)
                    String name = GetFormMenuName(selectedItem)
                    Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
                    if(typeCode == 41 || typeCode == 26 || typeCode == 42)
                        Utility.Wait(0.1)
                        target.EquipItem(selectedItem)
                    endIf
                elseif itemAmount != 0
                    Debug.Notification("Invalid amount entered.")
                endIf
            elseif typeCode == 92
                target.AddPerk(selectedItem as Perk)
                Debug.Notification(selectedItem.getName() + " added.")
            elseif typeCode == 22
                target.AddSpell(selectedItem as Spell)
            elseif typeCode == 119
                target.AddShout(selectedItem as Shout)
                int s = 0
                while (selectedItem as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (selectedItem as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
                Debug.Notification(selectedItem.getName() + " added.")
            endIf
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, selectedMod, startingPointInitial, currentPage, typeCode, option)
        Else
			Form selectedItem = itemArray[result - 5]
            if(typeCode != 92 && typeCode != 22 && typeCode != 119)
                Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
                Utility.Wait(0.1)
                if (itemAmount > 0)   
                    target.AddItem(selectedItem, itemAmount, true)
                    String name = GetFormMenuName(selectedItem)
                    Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
                    if(typeCode == 41 || typeCode == 26 || typeCode == 42)
                        Utility.Wait(0.1)
                        target.EquipItem(selectedItem)
                    endIf
                elseif itemAmount != 0
                    Debug.Notification("Invalid amount entered.")
                endIf
            elseif typeCode == 92
                target.AddPerk(selectedItem as Perk)
                Debug.Notification(selectedItem.getName() + " added.")
            elseif typeCode == 22
                target.AddSpell(selectedItem as Spell)
            elseif typeCode == 119
                target.AddShout(selectedItem as Shout)
                int s = 0
                while (selectedItem as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (selectedItem as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
                Debug.Notification(selectedItem.getName() + " added.")
            endIf
            Proteus_ModExplorer_Dive(ZZProteusSkyUIMenu, target, selectedMod, startingPointInitial, currentPage, typeCode, option)
        endIf
    endIf
endFunction

Function Proteus_ModExplorer_Dive_Search(Quest ZZProteusSkyUIMenu,Actor target, Form[] itemArray, String selectedMod, int startingPoint, int currentPage, int typeCode, int option, int counterAll2) global ;option 0 = cheat, 1 = reset
	String typeString = Proteus_GetTypeString(typeCode)
	Debug.Notification(typeString + " mod explorer menu loading...may take a few seconds!")		


	int numPages = Math.Ceiling(counterAll2 / 127 as Float) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Quit" + Proteus_GetTypeString(typeCode) + " Mod Explorer]")
        i+=1
        listMenuBase.AddEntryItem("[Search + " + selectedMod + " for" + typeString + "]")
        i+=1
        if typeCode == 22 ;spell
            listMenuBase.AddEntryItem("[Add All Spells]")
        elseif typeCode == 92 ;perk
            listMenuBase.AddEntryItem("[Add All Perks]")
        elseif typeCode == 119 ;shout
            listMenuBase.AddEntryItem("[Add All Shouts]")
        else
            listMenuBase.AddEntryItem("[Add All to Inventory]")
        endIf        
        i+=1
		listMenuBase.AddEntryItem("[Back to Mod List]")
        i+=1
        listMenuBase.AddEntryItem("[Back to Cheat Menu]")
        i+=1
        while startingPoint <= itemArray.Length && i < 128
			String name = GetFormMenuName(itemArray[startingPoint])
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(itemArray[startingPoint] == NONE)
				i = 128
			endIf
			if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
                i = 128
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
            Form[] allGameItems = Utility.CreateFormArray(10000)
            int counterAll
            if typeCode == 999
                Form[] weaponArray = ProteusGetItemBySearch(searchTerm, 41, selectedMod)
                Form[] armorArray = ProteusGetItemBySearch(searchTerm, 26, selectedMod)
                Form[] miscArray = ProteusGetItemBySearch(searchTerm, 32, selectedMod)
                Form[] ammoArray = ProteusGetItemBySearch(searchTerm, 42, selectedMod)
                Form[] scrollArray = ProteusGetItemBySearch(searchTerm, 23, selectedMod)
                Form[] bookArray = ProteusGetItemBySearch(searchTerm, 27, selectedMod)
                Form[] keyArray = ProteusGetItemBySearch(searchTerm, 45, selectedMod)
                Form[] potionArray = ProteusGetItemBySearch(searchTerm, 46, selectedMod)
                int w = 0
                counterAll = 0
                while w < weaponArray.Length && weaponArray[w]
                    allGameItems[counterAll] = weaponArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < armorArray.Length && armorArray[w]
                    allGameItems[counterAll] = armorArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < miscArray.Length && miscArray[w]
                    allGameItems[counterAll] = miscArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < ammoArray.Length && ammoArray[w]
                    allGameItems[counterAll] = ammoArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < scrollArray.Length && scrollArray[w]
                    allGameItems[counterAll] = scrollArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < bookArray.Length && bookArray[w]
                    allGameItems[counterAll] = bookArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < keyArray.Length && keyArray[w]
                    allGameItems[counterAll] = keyArray[w]
                    w += 1
                    counterAll += 1
                endWhile
                w = 0
                while w < potionArray.Length && potionArray[w]
                    allGameItems[counterAll] = potionArray[w]
                    w += 1
                    counterAll += 1
                endWhile
            else
                allGameItems = ProteusDLLUtils.ProteusGetItemBySearch(searchTerm, typeCode, selectedMod)
            endIf
			Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, allGameItems, selectedMod, 0, 1, typeCode, option, counterAll)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 2 ;add all items
		int j = 0
        if(typeCode != 92 && typeCode != 22 && typeCode != 119)
            while j < itemArray.Length
                target.AddItem(itemArray[j], 1, true)
                j+=1
		    endWhile
            Debug.Notification("All matching items added to inventory.")
        elseif typeCode == 92
            while j < itemArray.Length
                target.AddPerk(itemArray[j] as Perk)
                j+=1
            endWhile
            Debug.Notification("All matching perks added.")
        elseif typeCode == 22
            while j < itemArray.Length
                target.AddSpell(itemArray[j] as Spell)
                j+=1
            endWhile
            Debug.Notification("All matching spells added.")
        elseif typeCode == 119
            while j < itemArray.Length
                target.AddShout(itemArray[j] as Shout)
                j+=1
                int s = 0
                while (itemArray[j] as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (itemArray[j] as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
            endWhile
            Debug.Notification("All matching shouts added.")
        endIf
		Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, itemArray, selectedMod, startingPointInitial, currentPage, typeCode, option, counterAll2)
	elseif result == 3 ;back to mod list
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, typeCode, option)
    elseif result == 4 ;back option
        itemArray = NONE
        PlayerCheats(ZZProteusSkyUIMenu, target)
	elseif result == 127 ;next page option
        currentPage += 1
		Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, itemArray, selectedMod, startingPoint, currentPage, typeCode, option, counterAll2)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedItem = itemArray[startingPointInitial + result - 5]
            if(typeCode != 92 && typeCode != 22 && typeCode != 119)
                Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
                Utility.Wait(0.1)
                if (itemAmount > 0)   
                    target.AddItem(selectedItem, itemAmount, true)
                    String name = GetFormMenuName(selectedItem)
                    Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
                    if(typeCode == 41 || typeCode == 26 || typeCode == 42)
                        Utility.Wait(0.1)
                        target.EquipItem(selectedItem)
                    endIf
                elseif itemAmount != 0
                    Debug.Notification("Invalid amount entered.")
                endIf
            elseif typeCode == 92
                target.AddPerk(selectedItem as Perk)
                Debug.Notification(selectedItem.getName() + " added.")
            elseif typeCode == 22
                target.AddSpell(selectedItem as Spell)
            elseif typeCode == 119
                target.AddShout(selectedItem as Shout)
                int s = 0
                while (selectedItem as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (selectedItem as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
                Debug.Notification(selectedItem.getName() + " added.")
            endIf
            Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, itemArray, selectedMod, 0, 1, typeCode, option, counterAll2)
        Else
            Form selectedItem = itemArray[result - 5]
            if(typeCode != 92 && typeCode != 22 && typeCode != 119)
                Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?", "1") as Int
                Utility.Wait(0.1)
                if (itemAmount > 0)   
                    target.AddItem(selectedItem, itemAmount, true)
                    String name = GetFormMenuName(selectedItem)
                    Debug.Notification(Proteus_Round(itemAmount, 0) + " " + name + " added to inventory.")
                    if(typeCode == 41 || typeCode == 26 || typeCode == 42)
                        Utility.Wait(0.1)
                        target.EquipItem(selectedItem)
                    endIf
                elseif itemAmount != 0
                    Debug.Notification("Invalid amount entered.")
                endIf
            elseif typeCode == 92
                target.AddPerk(selectedItem as Perk)
                Debug.Notification(selectedItem.getName() + " added.")
            elseif typeCode == 22
                target.AddSpell(selectedItem as Spell)
            elseif typeCode == 119
                target.AddShout(selectedItem as Shout)
                int s = 0
                while (selectedItem as Shout).GetNthWordOfPower(s)
                    WordOfPower wordTemp = (selectedItem as Shout).GetNthWordOfPower(s)
                    Game.UnlockWord(wordTemp)
                    s+=1
                endWhile
                Debug.Notification(selectedItem.getName() + " added.")
            endIf
            Proteus_ModExplorer_Dive_Search(ZZProteusSkyUIMenu, target, itemArray, selectedMod, 0, 1, typeCode, option, counterAll2)
        endIf
    endIf
EndFunction


String function Proteus_GetTypeString(Int typeCode) global
	String typeString
    if(typeCode == 41)
		typeString = " Weapons"
	elseif typeCode == 32
		typeString = " Misc Items"
	elseif typeCode == 26
		typeString = " Armors"
	elseif typeCode == 23
		typeString = " Scrolls"
	elseif typeCode == 27
		typeString = " Books"
	elseif typeCode == 42
		typeString = " Ammo"
	elseif typeCode == 45
		typeString = " Keys"
	elseif typeCode == 46
		typeString = " Potions"
    else
        typeString = " Items"
	endIf
    return typeString
endFunction


function PlayerCheats(Quest ZZProteusSkyUIMenu, Actor target) global
	String[] stringArray= new String[16]

	stringArray[0] = " Mod Explorer (Items)"
	stringArray[1] = " Add Weapon"
	stringArray[2] = " Add Armor"
	stringArray[3] = " Add Misc Item"
	stringArray[4] = " Add Ammo"
	stringArray[5] = " Add Scroll"
	stringArray[6] = " Add Book"
	stringArray[7] = " Add Key"
	stringArray[8] = " Add Potion"
	stringArray[9] = " Add Spell"
	stringArray[10] = " Add Perk"
	stringArray[11] = " Add Shout"
	stringArray[12] = " Add Perk Point"
	stringArray[13] = " Add Dragon Soul"
	stringArray[14] = " Dispel Active Effects"
	stringArray[15] = " [Exit Menu]"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 16
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	if result == 0
		Proteus_ModExplorer(ZZProteusSkyUIMenu, target, 0, 1, 999, 999)
	elseif result == 1 ;weapon
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 41)
	elseIf result == 2 ;armor
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 26)
	elseif result == 3 ;misc item
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 32)
	elseif result == 4 ;ammo
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 42)
	elseif result == 5 ;scroll
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 23)
	elseif result == 6 ;book
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 27)
	elseif result == 7 ;key
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 45)
	elseif result == 8 ;potion
		Proteus_CheatItem(ZZProteusSkyUIMenu, target, 0, 1, 46)
	elseif result == 9 ;spell
		Proteus_CheatSpell(ZZProteusSkyUIMenu, target, 0, 1, 22)
	elseif result == 10 ;perk
		Proteus_CheatPerk(ZZProteusSkyUIMenu, target, 0, 1, 92)
	elseif result == 11 ;shout
		Debug.MessageBox("Be careful using this function. Learning shouts you are not supposed to know yet, that are given by quest lines, may break the associated quest. \n\nLearning a shout via this feature will also teach you its corresponding words of power.")
		Utility.Wait(0.1)
		Proteus_CheatShout(ZZProteusSkyUIMenu, target, 0, 1, 119)
	elseif result == 12 ;perk points
		String amount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many perk points?", "1")
		if(amount as Int > 0)
			Game.AddPerkPoints(amount as Int)
			Debug.Notification("Player gained " + Proteus_Round(amount as Int, 0) + " perk point(s).")
		endIf
		playerCheats(ZZProteusSkyUIMenu, target)
	elseIf result == 13 ;dragon souls
		String amount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many dragon souls?", "1")
		if(amount as Int > 0)
			target.modav("dragonsouls", amount as Int)
			Debug.Notification("Player gained " + Proteus_Round(amount as Int, 0) + " dragon soul(s).")
		endIf
		playerCheats(ZZProteusSkyUIMenu, target)
	elseif result == 14 ;dispel
		target.DispelAllSpells()
	elseIf result == 15	;exit
	endIf
endFunction