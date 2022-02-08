scriptName SIGEArmorLoadAliasScript extends ReferenceAlias

Import PhenderixToolResourceScript
Import JContainers
Import ProteusDLLUtils

;-- Properties --------------------------------------
globalvariable property ZZProteusArmorTotalEdits auto
Keyword property lightArmorKWD auto
Keyword property heavyArmorKWD auto


function OnPlayerLoadGame()
	utility.Wait(0.5)
	JLoadArmorAcrossAllSaves()
	if ZZProteusArmorTotalEdits.GetValue() != 0 as Float
		JLoadArmorSpecificSave()
	endIf
endFunction


function JLoadArmorSpecificSave()
	String playerName = game.GetPlayer().GetBaseObject().GetName()
	String processedPlayerName = processName(playerName)

	Form[] armorArray = Utility.CreateFormArray(500)
	String[] armorNameArray = Utility.CreateStringArray(500)


	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedPlayerName + ".json"))
		Int jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedPlayerName + ".json")
		Int jWFormNames = jmap.object()
		String armorForm = jmap.nextKey(jArmorFormList, "", "")
		Int i = 0
		Bool insertNewArmor = true
		while armorForm
			armor value = jmap.GetForm(jArmorFormList, armorForm, none) as armor
			if(value != NONE)
				armorNameArray[i] = armorForm
				armorArray[i] = value
				armorForm = jmap.nextKey(jArmorFormList, armorForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < armorArray.length
			if armorArray[i] == none
				i = 501
			else
				String armorName = armorArray[i].GetName()
				String processedArmorName = processName(armorName)
				Armor armorTemp = armorArray[i] as Armor

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedPlayerName + "_" + processedArmorName + ".json"))
					Int JArmorStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedPlayerName + "_" + processedArmorName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JArmorStatList, "", "")
					while j < 5
						String value = jmap.GetStr(JArmorStatList, stat, "")
						if stat == "armorrating"
							armorTemp.SetArmorRating(value as Int)
						elseIf stat == "weightclass"
							armorTemp.SetWeightClass(value as Int)
						elseIf stat == "goldval"
							armorTemp.SetGoldValue(value as Int)
						elseIf stat == "Weight"
							armorTemp.SetWeight(value as Float)
						elseIf stat == "Type"
							if(value == "HeavyArmor")
								if(armorTemp.HasKeyword(LightArmorKWD) == TRUE)
									ProteusReplaceKeywordOnForm(armorTemp, HeavyArmorKWD, LightArmorKWD)
								elseif(armorTemp.HasKeyword(HeavyArmorKWD) == FALSE)
									ProteusAddKeywordToForm(armorTemp, HeavyArmorKWD)
								endIf
								armorTemp.SetWeightClass(1)
							elseif(value == "LightArmor")
								if(armorTemp.HasKeyword(HeavyArmorKWD) == TRUE)
									ProteusReplaceKeywordOnForm(armorTemp, lightArmorKWD, heavyArmorKWD)
								elseif(armorTemp.HasKeyword(lightArmorKWD) == FALSE)
									ProteusAddKeywordToForm(armorTemp, lightArmorKWD)
								endIf
								armorTemp.SetWeightClass(0)
							elseif(value == "NoType")
								if(armorTemp.HasKeyword(HeavyArmorKWD) == TRUE)
									ProteusRemoveKeywordOnForm(armorTemp, HeavyArmorKWD)
								endIf
								if(armorTemp.HasKeyword(LightArmorKWD) == TRUE)
									ProteusRemoveKeywordOnForm(armorTemp, LightArmorKWD)
								endif
								armorTemp.SetWeightClass(2)
							endIf
						endIf
						stat = jmap.nextKey(JArmorStatList, stat, "")
						j += 1
					endWhile
				endIf
			endIf
			i += 1
		endWhile
	EndIf
endFunction



function JLoadArmorAcrossAllSaves()
	Form[] armorArray = Utility.CreateFormArray(500)
	String[] armorNameArray = Utility.CreateStringArray(500)

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json"))
		Int jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json")
		Int jWFormNames = jmap.object()
		String armorForm = jmap.nextKey(jArmorFormList, "", "")
		Int i = 0
		Bool insertNewArmor = true
		while armorForm
			armor value = jmap.GetForm(jArmorFormList, armorForm, none) as armor
			if(value != NONE)
				armorNameArray[i] = armorForm
				armorArray[i] = value
				armorForm = jmap.nextKey(jArmorFormList, armorForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < armorArray.length
			if armorArray[i] == none
				i = 501
			else
				String armorName = armorArray[i].GetName()
				String processedArmorName = processName(armorName)
				Armor armorTemp = armorArray[i] as Armor

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedArmorName + ".json"))
					Int JArmorStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedArmorName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JArmorStatList, "", "")
					while j < 5
						String value = jmap.GetStr(JArmorStatList, stat, "")
						if stat == "armorrating"
							armorTemp.SetArmorRating(value as Int)
						elseIf stat == "weightclass"
							armorTemp.SetWeightClass(value as Int)
						elseIf stat == "goldval"
							armorTemp.SetGoldValue(value as Int)
						elseIf stat == "Weight"
							armorTemp.SetWeight(value as Float)
						elseIf stat == "Type"
							if(value == "HeavyArmor")
								if(armorTemp.HasKeyword(LightArmorKWD) == TRUE)
									ProteusReplaceKeywordOnForm(armorTemp, HeavyArmorKWD, LightArmorKWD)
								elseif(armorTemp.HasKeyword(HeavyArmorKWD) == FALSE)
									ProteusAddKeywordToForm(armorTemp, HeavyArmorKWD)
								endIf
								armorTemp.SetWeightClass(1)
							elseif(value == "LightArmor")
								if(armorTemp.HasKeyword(HeavyArmorKWD) == TRUE)
									ProteusReplaceKeywordOnForm(armorTemp, lightArmorKWD, heavyArmorKWD)
								elseif(armorTemp.HasKeyword(lightArmorKWD) == FALSE)
									ProteusAddKeywordToForm(armorTemp, lightArmorKWD)
								endIf
								armorTemp.SetWeightClass(0)
							elseif(value == "NoType")
								if(armorTemp.HasKeyword(HeavyArmorKWD) == TRUE)
									ProteusRemoveKeywordOnForm(armorTemp, HeavyArmorKWD)
								endIf
								if(armorTemp.HasKeyword(LightArmorKWD) == TRUE)
									ProteusRemoveKeywordOnForm(armorTemp, LightArmorKWD)
								endif
								armorTemp.SetWeightClass(2)
							endIf
						endIf
						stat = jmap.nextKey(JArmorStatList, stat, "")
						j += 1
					endWhile
				endIf
			endIf
			i += 1
		endWhile
	EndIf
endFunction







