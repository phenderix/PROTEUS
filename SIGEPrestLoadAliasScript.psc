Scriptname SIGEPrestLoadAliasScript  extends ReferenceAlias  

Import ProteusDLLUtils
Import PhenderixToolResourceScript
Import CharGen
Import JContainers

;-- Properties --------------------------------------
GlobalVariable property ZZLoadPlayerPreset auto
GlobalVariable property ZZHasSavedPlayerCharacter auto
GlobalVariable property ZZNPCAppearanceSaved auto
FormList property combatStylesList auto
GlobalVariable property ZZPresetLoadedCounter auto
GlobalVariable property ZZPresetLoadedCounter2 auto

;-- Variables ---------------------------------------
Bool raceFound
String JContGlobalPath
Float targetCW ;not used as of now

function OnPlayerLoadGame()
	utility.Wait(0.100000)

	Int isDllLoaded = ProteusDLLUtils.IsDLLLoaded()
	if(isDllLoaded == 0)
		Debug.MessageBox("The SKSE Proteus.dll plugin failed to load. Please correct your installation before proceeding.")
	endif

	JContGlobalPath = jcontainers.userdirectory() ;sets JContainers directory for file paths
	if(ZZLoadPlayerPreset.GetValue() == 1 && ZZHasSavedPlayerCharacter.GetValue() > 0)
		JLoadPlayerAcrossAllSaves()
	endIf
	if(ZZNPCAppearanceSaved.GetValue() > 0)
		JLoadNPCAcrossAllSaves()
	endIf
	;run second time just for good measure
	utility.Wait(0.5)
	if(ZZLoadPlayerPreset.GetValue() == 1 && ZZHasSavedPlayerCharacter.GetValue() > 0)
		JLoadPlayerAcrossAllSaves()
	endIf
	if(ZZNPCAppearanceSaved.GetValue() > 0)
		JLoadNPCAcrossAllSaves()
	endIf
endFunction

function JLoadNPCAcrossAllSaves()
	Form[] NPCArray = Utility.CreateFormArray(500)
	String[] NPCNameArray = Utility.CreateStringArray(500)
	String ZZNPCAppearanceSavedValue = Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0)

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + ZZNPCAppearanceSavedValue + ".json"))
		Int jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + ZZNPCAppearanceSavedValue + ".json")
		Int jWFormNames = jmap.object()
		String NPCForm = jmap.nextKey(jNPCFormList, "", "")
		Int i = 0

		while NPCForm
			Form value = jmap.GetForm(jNPCFormList, NPCForm, none) as Form

			if(value != NONE)
				NPCArray[i] = value
				Int startPosition = Stringutil.Find(NPCForm, "_ProteusNPC_", 0)
				String NPCNameProcessed = StringUtil.Substring(NPCForm, startPosition + 12, StringUtil.GetLength(NPCForm))
				Int procNameLength = StringUtil.GetLength(NPCNameProcessed as String)
				;Debug.MessageBox("NPCNameProcessed: " + NPCNameProcessed)
				if(procNameLength > 0)
					NPCNameArray[i] = NPCNameProcessed
					(NPCArray[i] as Actor).SetName(NPCNameProcessed)
					(NPCArray[i] as Actor).GetActorBase().SetName(NPCNameProcessed)
				endIf
			endIf
			NPCForm = jmap.nextKey(jNPCFormList, NPCForm, "")
			i += 1
		endWhile
		i = 0
		while i < NPCArray.length
			if NPCArray[i] == none
				i = 501
			else
				String NPCName = (NPCArray[i] as Actor).GetActorBase().GetName()
				String processedNPCName = processName(NPCName)
				
				If(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json"))
					Int JNPCList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json")
					Int jStats = jmap.object()
					String stat = jmap.nextKey(JNPCList, "", "")
					String value = jmap.GetStr(JNPCList, stat, "")
					Int valueInt = value as Int
					if stat == "CombatStyle"
						if valueInt  == 0
							(NPCArray[i] as Actor).GetActorBase().SetCombatStyle(combatStylesList.GetAt(0) as CombatStyle)
						elseif valueInt == 1
							(NPCArray[i] as Actor).GetActorBase().SetCombatStyle(combatStylesList.GetAt(1) as CombatStyle)
						elseif valueInt == 2
							(NPCArray[i] as Actor).GetActorBase().SetCombatStyle(combatStylesList.GetAt(2) as CombatStyle)
						elseif valueInt == 3
							(NPCArray[i] as Actor).GetActorBase().SetCombatStyle(combatStylesList.GetAt(3) as CombatStyle)
						elseif valueInt == 4
							(NPCArray[i] as Actor).GetActorBase().SetCombatStyle(combatStylesList.GetAt(4) as CombatStyle)
						endIf
					endIf
					stat = jmap.nextKey(JNPCList, stat, "")
					value = jmap.GetStr(JNPCList, stat, "")
					if stat == "name"
						if(value != "")
							ColorForm colorHair = (NPCArray[i] as Actor).GetActorBase().GetHairColor()	
							raceFound = false
							Race currentRace = Proteus_LoadCharacterRace(value)
							if(raceFound == false)
								currentRace = (NPCArray[i] as Actor).GetRace()
							endIf
							
							LoadCharacterPreset((NPCArray[i] as Actor), value, colorHair) 
							LoadCharacter((NPCArray[i] as Actor), currentRace, value)
						endIf
					endIf
				EndIf

				;load voice types onto applicable NPCs
				If(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_VT_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json"))
					Int jVTList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_VT_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json")
    				Int JVT = jmap.object()
					String textKey = jmap.nextKey(jVTList, "", "")
					Form value = jmap.GetForm(jVTList, textKey, none) as Form
					if(value != NONE)
						(NPCArray[i] as Actor).GetActorBase().SetVoiceType(value as VoiceType) 
					endIf
				endIf
				i += 1

				;equip items back onto npcs, ensures they aren't wearing their default outfit
				Proteus_EquipItems(processedNPCName, (NPCArray[i] as Actor))

			endIf
		endWhile
	EndIf
endFunction


function JLoadPlayerAcrossAllSaves()
	Actor playerRef = Game.GetPlayer()
	Int correctIndex = ZZPresetLoadedCounter.GetValue() as Int

	;Debug.Notification("PresetLoadCounter:" + correctIndex)
	String ZZNPCAppearanceSavedValue = Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0)
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + ZZNPCAppearanceSavedValue + ".json") == true) 		
		String playerName
		Int JPlayerList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + ZZNPCAppearanceSavedValue + ".json")
		Int jStats = jmap.object()
		String playerPresetName = jmap.nextKey(JPlayerList, "", "")
		int i = 0
		while playerPresetName
			String value = jmap.GetStr(JPlayerList, playerPresetName, none) as String
			if(correctIndex == i)
				playerName = value
			endIf
			playerPresetName = jmap.nextKey(JPlayerList, playerPresetName, "")
			i += 1
		endWhile

		if(StringUtil.GetLength(playerName) > 0)
			JLoadPlayerAcrossAllSaves2(playerName, playerRef)
		endIf
	EndIf
endFunction

Function JLoadPlayerAcrossAllSaves2(String playerName, Actor playerRef)
	Int correctIndex2 = ZZPresetLoadedCounter2.GetValue() as Int

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		String appearancePresetName
		Int JPlayerList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
		Int jStats = jmap.object()
		String playerPresetName = jmap.nextKey(JPlayerList, "", "")
		int i = 0
		while playerPresetName
			String value = jmap.GetStr(JPlayerList, playerPresetName, none) as String
			if(correctIndex2 == i)
				appearancePresetName = value
			endIf
			playerPresetName = jmap.nextKey(JPlayerList, playerPresetName, "")
			i += 1
		endWhile

		if(StringUtil.GetLength(appearancePresetName) > 0)
			;Debug.MessageBox("AppearancePresetLoading: " + appearancePresetName)
			Proteus_LoadTargetStrings(appearancePresetName, playerRef, 1) ;change gender if needed
			if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + appearancePresetName + ".json"))
				Race currentRace = playerRef.GetRace()
				Race presetRace = Proteus_LoadCharacterRace(appearancePresetName)
				Proteus_LoadCharacterAppearance(appearancePresetName, playerRef, currentRace, presetRace, 0)
			endIf		
		EndIf
	endIf
endFunction

Function Proteus_LoadCharacterAppearance(String presetName, Actor target, Race currentRace, Race presetRace, int option)
	if(option == 0) ;for player
		if(presetRace == currentRace)
			ColorForm colorHair = target.GetActorBase().GetHairColor()
			LoadCharacterPreset(target, presetName, colorHair)	
			LoadCharacter(target, presetRace, presetName)
			;LoadExternalCharacter(target, presetRace, presetName)
		else
			target.SetRace(presetRace)
			Utility.Wait(0.1)
			ColorForm colorHair = target.GetActorBase().GetHairColor()
			LoadCharacterPreset(target, presetName, colorHair)	
			LoadCharacter(target, presetRace, presetName)
			Utility.Wait(0.1)	
			target.SetRace(currentRace)
			Utility.Wait(0.1)
			target.SetRace(presetRace)
			Utility.Wait(0.1)
			LoadCharacterPreset(target, presetName, colorHair)	
			LoadCharacter(target, presetRace, presetName)
			;LoadExternalCharacter(target, presetRace, presetName)
		endIf
	elseif(option == 1) ;for NPC
		if(presetRace == currentRace)
			ColorForm colorHair = target.GetActorBase().GetHairColor()	
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
			Utility.Wait(0.1)
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
			;LoadExternalCharacter(target, presetRace, presetName)
		else
			target.SetRace(presetRace)
			Utility.Wait(0.1)
			ColorForm colorHair = target.GetActorBase().GetHairColor()
			LoadCharacterPreset(target, presetName, colorHair)
			LoadCharacter(target, presetRace, presetName)
			Utility.Wait(0.1)	
			target.SetRace(currentRace)
			Utility.Wait(0.1)
			target.SetRace(presetRace)
			Utility.Wait(0.1)
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
			;LoadExternalCharacter(target, presetRace, presetName)
		endIf				
	endIf
endFunction

;option (1 = load appearance preset, 2 = siwtch / spawn characters)
function Proteus_LoadTargetStrings(String presetName, Actor target, int option)
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json"))
		Int JStringList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json")
		Int maxCount = jvalue.Count(JStringList )
		Int jStats = jmap.object()
		Int i = 0
		String text = jmap.nextKey(JStringList, "", "")
		String value
		while i < maxCount
			value = jmap.GetStr(JStringList, text, "")
			if text == "name"
				if(option == 2)  ;set target name to other character name
					target.SetName(value)
					target.GetActorBase().SetName(value)
				endIf
			elseif text == "gender"
				if(value == 0) ;male
					SetSex(target, 0) 
				Elseif (value == 1) ;female
					SetSex(target, 1) 
				endIf
			elseif text == "race"
			elseif text == "CarryWeight"
				if(option == 2)
					targetCW = value as Float
				endIf
			EndIf
			text = jmap.nextKey(JStringList, text, "")
			i += 1
		endWhile
	else
	EndIf
endFunction



Race Function Proteus_LoadCharacterRace(String presetName)
	Race presetRace
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
		raceFound = TRUE
		Int JRaceList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
		Int jStats = jmap.object()
		String raceForm = jmap.nextKey(JRaceList , "", "")
		Race value = jmap.GetForm(JRaceList, raceForm, none) as Race
		if raceForm == "race"
			presetRace = value
		EndIf
	EndIf
	return presetRace
endFunction


Function Proteus_EquipItems(String preset, Actor target)
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" +  preset + ".json"))
		Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" +  preset + ".json")
		Int jItemFormNames = jmap.object()
		String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
		Form itemWeaponLoaded

		while ItemFormKey 
			Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
			;Find Item Count
			Int index1 = stringutil.Find(ItemFormKey, "ProteusCount", 0)
			Int index2 = stringutil.Find(ItemFormKey, "_ProteusHand", 0)
			String s1 = stringutil.Substring(ItemFormKey, index1+12, index2-index1)
			Int valueType = value.GetType()
			String substringTest = StringUtil.Substring(ItemFormKey, StringUtil.GetLength(ItemFormKey) - 1, 1)
			if(valueType == 41)
				if(substringTest == "L")
					target.EquipItemEx(value, 2, false, true)
				elseif(substringTest == "R")
					target.EquipItemEx(value, 1, false, true)
				elseif(substringTest == "B")
					target.EquipItemEx(value, 1, false, true)
					target.EquipItemEx(value, 2, false, true)
				EndIf
			else
				target.EquipItem(value, false, true)	
			EndIf
			ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
		endwhile
	endIf
EndFunction