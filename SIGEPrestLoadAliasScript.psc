Scriptname SIGEPrestLoadAliasScript  extends ReferenceAlias  

Import PhenderixToolResourceScript
Import CharGen
Import JContainers
Import ConsoleUtil

;-- Properties --------------------------------------
GlobalVariable property ZZLoadPlayerPreset auto
GlobalVariable property ZZHasSavedPlayerCharacter auto
GlobalVariable property ZZNPCAppearanceSaved auto
FormList property combatStylesList auto
GlobalVariable property ZZPresetLoadedCounter auto
GlobalVariable property ZZPresetLoadedCounter2 auto

;-- Variables ---------------------------------------
Bool raceFound

function OnPlayerLoadGame()
	utility.Wait(0.100000)
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
					;Debug.MessageBox("PRE NPC NAME IS: " + NPCForm)
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



;postTargetAcquire (0 = spawned character, 1 = load appearance preset, 2 = swap characters)
function Proteus_LoadTargetStrings(String presetName, Actor target, int postTargetAcquire)
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json"))
		Int JStringList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json")
		Int maxCount = jvalue.Count(JStringList )

		Int jStats = jmap.object()
		Int i = 0
		String text = jmap.nextKey(JStringList, "", "")

		while i < maxCount
			String value = jmap.GetStr(JStringList, text, "")
			if text == "name"
				;set target name to other character name
				if(postTargetAcquire == 2)
					;target.GetActorBase().SetName(value)
				endIf
			elseif text == "gender"
				if(postTargetAcquire == 2 || postTargetAcquire == 1)
					if((target.GetActorBase()).GetSex() == 0 && value == 0)
					elseif((target.GetActorBase()).GetSex() == 1 && value == 1)
					else
						SetSelectedReference(target)
						ExecuteCommand("sexchange")
					EndIf
				endIf
			elseif text == "race"
			EndIf
			text = jmap.nextKey(JStringList, text, "")
			i += 1
		endWhile
		;debug.Notification("Name loaded from the Proteus system.")
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