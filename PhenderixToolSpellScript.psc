
scriptName PhenderixToolSpellScript extends activemagiceffect

Import PhenderixToolResourceScript
Import JContainers

;-- Properties --------------------------------------
message property handSelectionMenu auto
message property changeAttributeMenu auto
message property increaseDecreaseMenu auto
message property whichEffectMenu auto
message property handSelectionMenu3 auto
globalvariable property ZZProteusSpellTotalEdits auto
message property PromptSaveMenu auto
message property handSelectionMenu2 auto
message property ZZPhenderixToolSpellEditHandSelectionView auto
message property mainMenuNPC auto
message property mainMenu auto
message property ZZSpellContinueEditMenu auto

String[] spellMagicEffectListNames
Quest property ZZProteusSkyUIMenu auto

;-- Variables ---------------------------------------
Actor target

;-- Functions ---------------------------------------

function OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
	MainMenu()
endFunction

function MainMenu()
	String[] stringArray
	stringArray= new String[5]
	stringArray[0] = " Spell Summary"
	stringArray[1] = " Spell Edit"
	stringArray[2] = " Forget Spells"
	stringArray[3] = " Dispel Active Magic Effects"
	stringArray[4] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 5
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	
	if result == 0
		if(target.GetEquippedItemType(0) != 9 && target.GetEquippedItemType(1) != 9)
			Debug.Notification("This actor doesn't have any spells equipped in their hands.")
			MainMenu()
		else
			ViewStatsOption()
		endIf
	elseif result == 1
		if(target.GetEquippedItemType(0) != 9 && target.GetEquippedItemType(1) !=9)
			Debug.Notification("This actor doesn't have any spells equipped in their hands.")
			MainMenu()
		else
			EditStatsOption()
		endIf
	elseif result == 2
		UIMagicMenu magicMenu = UIExtensions.GetMenu("UIMagicMenu") as UIMagicMenu
		magicMenu.OpenMenu(target)
	elseif result == 3
		target.DispelAllSpells()
		debug.Notification("Active effects dispelled. (excludes abilities, diseases, & enchantments)")
		;MainMenu()
	elseif result == 4
	EndIf
EndFunction




function EditStatsOption()

	Int handButton = handSelectionMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if handButton == 0
		if target.GetEquippedItemType(0) == 9
			ChangeSpellEffect(0)
		else
			debug.MessageBox("A spell is not equipped in that hand.")
			EditStatsOption()
		endIf
	elseIf handButton == 1
		if target.GetEquippedItemType(1) == 9
			ChangeSpellEffect(1)
		else
			debug.MessageBox("A spell is not equipped in that hand.")
			EditStatsOption()
		endIf
	elseIf handButton == 2
		mainMenu()
	endIf
endFunction






function ViewStatsOption()

	Int ibutton2 = ZZPhenderixToolSpellEditHandSelectionView.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton2 == 0
		if target.GetEquippedItemType(0) == 9
			GenerateViewStats(target.GetEquippedSpell(0), 0, 0)
		else
			debug.MessageBox("A spell is not equipped in that hand.")
			ViewStatsOption()
		endIf
	elseIf ibutton2 == 1
		if target.GetEquippedItemType(1) == 9
			GenerateViewStats(target.GetEquippedSpell(1), 1, 0)
		else
			debug.MessageBox("A spell is not equipped in that hand.")
			ViewStatsOption()
		endIf
	elseIf ibutton2 == 2
		MainMenu()
	endIf
endFunction

function ChangeSpellStats(Int x, Int y)

	String[] stringArray
	stringArray= new String[5]
	stringArray[0] = " Magnitude"
	stringArray[1] = " Duration"
	stringArray[2] = " Area"
	stringArray[3] = " Back"
	stringArray[4] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 5
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		IncreaseDecrease(x, y, "magnitude")
	elseIf result == 1
		IncreaseDecrease(x, y, "duration")
	elseIf result == 2
		IncreaseDecrease(x, y, "area")
	elseIf result == 3
		ChangeSpellEffect(y)
	elseIf result == 4
	endIf
endFunction





function GenerateViewStats(Spell S, Int handSelected, Int option)
	Float castTime = S.GetCastTime()
	Int numberOfEffects = S.GetNumEffects()

	Debug.MessageBox(S.GetName() + " Spell Summary\n\n " + "Base Magicka Cost: " + Proteus_Round(S.GetMagickaCost(), 0) + "\nEffective Magicka Cost: " + Proteus_Round(S.GetEffectiveMagickaCost(target),0)+ "\nCast Time: " + Proteus_Round(castTime,1)+ "\nTotal Effects: " + Proteus_Round(S.GetNumEffects(), 0))
	
	Int i = 0
	String[] effectsString = new String[128]
	while i < numberOfEffects
		effectsString[i] = S.GetNthEffectMagicEffect(i).GetName() + "\nMagnitude: " + Proteus_Round(S.GetNthEffectMagnitude(i), 1) + "\nDuration: " + Proteus_Round(S.GetNthEffectDuration(i),1) + "\nArea: " + Proteus_Round(S.GetNthEffectArea(i), 1)+ "\n\n"
		Debug.MessageBox(S.GetName() + "\nEffect #" + (i+1) + "\n\n" + effectsString[i])
		i += 1
	endWhile
	
	if option == 0
		ViewStatsOption()
	elseif option == 1
		Int ibutton = ZZSpellContinueEditMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		if ibutton == 0 ;yes, continue editing
			ChangeSpellEffect(handSelected)
		elseIf ibutton == 1 ;save
			JSaveOption(handSelected)
		elseIf ibutton == 2 ;main menu
			MainMenu()
		elseIf ibutton == 3 ;exit menu
		endIf
	EndIf
endFunction




function JSaveSpellStats(spell wName, String processedTargetName, String processedSpellName, Int handSelected, Int saveOption)

	Int numberOfEffects = wName.GetNumEffects()
	Int i = 0
	String effectsString = "List of Effects \n"
	while i < numberOfEffects
		Int jSpellStatList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Spell_Template.json")
		Int jWStats = jmap.object()
		Int maxCount = jvalue.Count(jSpellStatList)
		Int j = 0
		while j < maxCount
			String value
			String stat = jarray.getStr(jSpellStatList, j, "")
			if j == 0
				value = wName.GetNthEffectArea(i) as String
			elseIf j == 1
				value = wName.GetNthEffectDuration(i) as String
			elseIf j == 2
				value = wName.GetNthEffectMagnitude(i) as String
			endIf
			jmap.SetStr(jWStats, stat, value)
			j += 1
		endWhile
		i += 1
		if saveOption == 0
			jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedTargetName + "_" + processedSpellName + i as String + ".json")
		elseIf saveOption == 1
			jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedSpellName + i as String + ".json")
		endIf
	endWhile
	debug.Notification(wName.GetName() + " saved into the Proteus system.")
	ChangeSpellEffect(handSelected)
endFunction

function IncreaseDecrease(Int x, Int y, String S)

	if S == "magnitude"
		string[] stringArray
		stringArray= new String[10]
		stringArray[0] = " -100%"
		stringArray[1] = " -50%"
		stringArray[2] = " -10%"
		stringArray[3] = " +10%"
		stringArray[4] = " +50%"
		stringArray[5] = " +100%"
		stringArray[6] = " +1"
		stringArray[7] = " Custom Effect Magnitude"
		stringArray[8] = " Back"
		stringArray[9] = " Exit"

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 10
			int i = 0
			while i < n
				listMenu.AddEntryItem(stringArray[i])
				i += 1
			endwhile
		EndIf

		listMenu.OpenMenu()
		int result = listMenu.GetResultInt()

		if result == 0
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 0.0
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 1
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 0.5
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 2
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 0.9
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 3
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 1.1
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 4
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 1.5
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 5
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) * 2.0
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 6
			Float value = target.GetEquippedSpell(y).GetNthEffectMagnitude(x) + 1 as Float
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 7 ;enter custom magnitude
			Float value = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput( target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude:") as Float	
			target.GetEquippedSpell(y).SetNthEffectMagnitude(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " magnitude is now "  + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectMagnitude(x), 2))
			IncreaseDecrease(x, y, "magnitude")
		elseIf result == 8 ;back
			ChangeSpellStats(x, y)
		elseIf result == 9 ;exit
		endIf
	elseIf S == "duration"
		string[] stringArray
		stringArray= new String[10]
		stringArray[0] = " -100%"
		stringArray[1] = " -50%"
		stringArray[2] = " -10%"
		stringArray[3] = " +10%"
		stringArray[4] = " +50%"
		stringArray[5] = " +100%"
		stringArray[6] = " +1"
		stringArray[7] = " Custom Effect Duration"
		stringArray[8] = " Back"
		stringArray[9] = " Exit"

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 10
			int i = 0
			while i < n
				listMenu.AddEntryItem(stringArray[i])
				i += 1
			endwhile
		EndIf

		listMenu.OpenMenu()
		int result = listMenu.GetResultInt()
		if result == 0
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 0.000000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 1
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 0.500000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 2
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 0.90000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 3
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 1.10000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 4
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 1.50000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 5
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) * 2.00000 as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 6
			Int value = target.GetEquippedSpell(y).GetNthEffectDuration(x) + 1
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")
		elseIf result == 7 ;enter custom duration
			Int value = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput( target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration:")	as Int
			target.GetEquippedSpell(y).SetNthEffectDuration(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " duration is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectDuration(x), 2))
			IncreaseDecrease(x, y, "duration")	
		elseIf result == 8 ;back
			ChangeSpellStats(x, y)
		elseIf result == 9 ;exit menu
		endIf
	elseIf S == "area"
		string[] stringArray
		stringArray= new String[10]
		stringArray[0] = " -100%"
		stringArray[1] = " -50%"
		stringArray[2] = " -10%"
		stringArray[3] = " +10%"
		stringArray[4] = " +50%"
		stringArray[5] = " +100%"
		stringArray[6] = " +1"
		stringArray[7] = " Custom Effect Area"
		stringArray[8] = " Back"
		stringArray[9] = " Exit"

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 10
			int i = 0
			while i < n
				listMenu.AddEntryItem(stringArray[i])
				i += 1
			endwhile
		EndIf

		listMenu.OpenMenu()
		int result = listMenu.GetResultInt()


		if result == 0
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 0.000000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 1
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 0.500000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 2
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 0.90000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 3
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 1.10000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 4
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 1.50000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 5
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) * 2.00000 as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 6 
			Int value = target.GetEquippedSpell(y).GetNthEffectArea(x) + 1
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 7 ;custom value
			Int value = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput( target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area:")	as Int
			target.GetEquippedSpell(y).SetNthEffectArea(x, value)
			debug.Notification(target.GetEquippedSpell(y).GetNthEffectMagicEffect(x).GetName() + " area is now " + Proteus_Round(target.GetEquippedSpell(y).GetNthEffectArea(x),2))
			IncreaseDecrease(x, y, "area")
		elseIf result == 8 ;back
			ChangeSpellStats(x, y)
		elseIf result == 9 ;exit
		endIf
	endIf
endFunction




function ChangeSpellEffect(Int handSelected)
	Spell spellName = target.GetEquippedSpell(handSelected)
	Int numberOfEffects = spellName.GetNumEffects()
	spellMagicEffectListNames = Utility.CreateStringArray(100)
	int i = 0
	while i < numberOfEffects 
		if(StringUtil.GetLength(spellName.GetNthEffectMagicEffect(i).GetName()) > 0)
			spellMagicEffectListNames[i] = spellName.GetNthEffectMagicEffect(i).GetName()
		Else
			spellMagicEffectListNames[i] = "Magic Effect " + i
		endif
		i+=1
	endWhile
	spellMagicEffectListNames[i] = " Spell Summary"
	i+=1
	spellMagicEffectListNames[i] = " Permanently Save Spell"
	i+=1
	spellMagicEffectListNames[i] = " Clear Spell Proteus System Edits"
	i+=1
	spellMagicEffectListNames[i] = " Back"
	i+=1
	spellMagicEffectListNames[i] = " Exit"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = i+1
		int j = 0
		while j < n
			;Debug.Notification("Adding List Item: " + spellMagicEffectListNames[j])
			listMenu.AddEntryItem(spellMagicEffectListNames[j])
			j += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int clearOption = i - 2
	int backOption = i - 1
	int saveOption = i - 3
	int summaryOption = i - 4

	if (target.GetEquippedSpell(handSelected).GetNthEffectMagicEffect(result).GetName() != "" && result < summaryOption)
			debug.Notification(target.GetEquippedSpell(handSelected).GetNthEffectMagicEffect(result).GetName() + " effect chosen for editing.")
			ChangeSpellStats(result, handSelected)
	elseIf result == summaryOption ;spell summary
		GenerateViewStats(target.GetEquippedSpell(handSelected), handSelected, 1)
	elseIf result == saveOption ;save
		JSaveOption(handSelected)
	elseIf result == clearOption
		Proteus_ClearSpellEdits(target.GetEquippedSpell(handSelected))
	elseIf result == backOption ;back
		EditStatsOption()
	endIf
endFunction

function JSaveOption(Int handSelected)

	Int ibutton4 = PromptSaveMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton4 == 0
		JSaveSpell(handSelected, 0)
	elseIf ibutton4 == 1
		JSaveSpell(handSelected, 1)
	elseIf ibutton4 == 2
		ChangeSpellEffect(handSelected)
	elseIf ibutton4 == 3
		mainMenu()
	endIf
endFunction





function JSaveSpell(Int handSelected, Int saveOption)
	Actor player = Game.GetPlayer()
	String playerName = player.GetBaseObject().GetName()
	String processedPlayerName = processName(playerName)
	spell sName = player.GetEquippedSpell(handSelected)
	String processedSpellName = processName(sName.GetName())
	JSaveSpellForm(sName, processedPlayerName, processedSpellName, handSelected, saveOption)
endFunction


function JSaveSpellForm(spell wName, String processedTargetName, String processedSpellName, Int handSelected, Int saveOption)

	Int jSpellFormList
	if saveOption == 0
		if ZZProteusSpellTotalEdits.GetValue() == 1 as Float
			if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedTargetName + ".json"))
				jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedTargetName + ".json")
			endIf
		endIf
	elseIf saveOption == 1
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json"))
			jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json")
		endIf
	endIf
	Int jWFormNames = jmap.object()
	String spellFormKey = jmap.nextKey(jSpellFormList, "", "")
	Bool insertNewSpell = true
	while spellFormKey
		spell value = jmap.GetForm(jSpellFormList, spellFormKey, none) as spell
		if value == wName
			insertNewSpell = false
		endIf
		jmap.SetForm(jWFormNames, spellFormKey, value as form)
		spellFormKey = jmap.nextKey(jSpellFormList, spellFormKey, "")
	endWhile
	if insertNewSpell == true
		jmap.SetForm(jWFormNames, processedSpellName, wName as form)
		ZZProteusSpellTotalEdits.SetValue(1 as Float)
	endIf
	if saveOption == 0
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedTargetName + ".json")
	elseIf saveOption == 1
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json")
	endIf
	JSaveSpellStats(wName, processedTargetName, processedSpellName, handSelected, saveOption)
endFunction






;remove Spell edits 
function Proteus_ClearSpellEdits(Spell targetName)

    String playerName = Game.GetPlayer().GetActorBase().GetName()
    String processedPlayerName = processName(playerName)
    Int jSpellFormList

    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json"))
        jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json")
        Int jNFormNames = jmap.object()
        String SpellFormKey = jmap.nextKey(jSpellFormList, "", "")
        Bool insertNewSpell = true
        int i = 0
        while SpellFormKey
            Spell value = jmap.GetForm(jSpellFormList,SpellFormKey, none) as Spell
            if value == targetName
            else
                jmap.SetForm(jNFormNames, SpellFormKey, value as form)
            endIf
            i+=1
            SpellFormKey = jmap.nextKey(jSpellFormList, SpellFormKey, "")
        endWhile
        ;write file with removed Spell form
        jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json")
    endIf

    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedPlayerName + ".json"))
        jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedPlayerName + ".json")
        Int jNFormNames = jmap.object()
        String SpellFormKey = jmap.nextKey(jSpellFormList, "", "")
        Bool insertNewSpell = true
        int i = 0
        while SpellFormKey
            Spell value = jmap.GetForm(jSpellFormList,SpellFormKey, none) as Spell
            if value == targetName
            else
                jmap.SetForm(jNFormNames, SpellFormKey, value as form)
            endIf
            i+=1
            SpellFormKey = jmap.nextKey(jSpellFormList, SpellFormKey, "")
        endWhile
        ;write file with removed Spell form
        jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedPlayerName + ".json")
    endIf

    String SpellName = targetName.GetName()
	String processedSpellname = processName(SpellName)
	Int numberOfEffects = targetName.GetNumEffects()
	;Debug.MessageBox("PlayerName:" + processedPlayerName + " SpellName:" + processedSpellname)
	int j = 0
	while j < numberOfEffects + 1
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedPlayerName + "_" + processedSpellname + Proteus_Round(j,0) + ".json"))
			removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedPlayerName + "_" + processedSpellname + Proteus_Round(j,0) + ".json")
		endIf
		j+=1
	endWhile

	j = 0
	while j < numberOfEffects + 1
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_"  + processedSpellname + Proteus_Round(j,0) + ".json"))
			removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_"  + processedSpellname + Proteus_Round(j,0) + ".json")
		endIf
		j+=1
	endWhile

    debug.Notification(targetName.GetName() + " edits removed. Must relaunch Skyrim for spell stats to properly reset.")
endFunction


