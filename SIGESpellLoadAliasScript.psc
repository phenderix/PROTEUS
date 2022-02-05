
scriptName SIGESpellLoadAliasScript extends ReferenceAlias

Import PhenderixToolResourceScript
Import JContainers

;-- Properties --------------------------------------
globalvariable property ZZProteusSpellTotalEdits auto

function OnPlayerLoadGame()
	Utility.Wait(0.5)
	JLoadSpellAcrossAllSaves()
	if ZZProteusSpellTotalEdits.GetValue() != 0 as Float
		JLoadSpellSpecificSave()
	endIf
endFunction

function JLoadSpellSpecificSave()
	String playerName = game.GetPlayer().GetBaseObject().GetName()
	String processedPlayerName = processName(playerName)
	Form[] spellArray = Utility.CreateFormArray(500)
	String[] spellNameArray = Utility.CreateStringArray(500)

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedPlayerName + ".json"))
		Int jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_" + processedPlayerName + ".json")
		Int jWFormNames = jmap.object()
		String spellForm = jmap.nextKey(jSpellFormList, "", "")
		Int i = 0
		Bool insertNewSpell = true
		while spellForm
			spell value = jmap.GetForm(jSpellFormList, spellForm, none) as spell
			if(value != NONE)
				spellNameArray[i] = spellForm
				spellArray[i] = value
				spellForm = jmap.nextKey(jSpellFormList, spellForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < spellArray.length
			if spellArray[i] == none
				i = 501
			else
				String spellName = spellArray[i].GetName()
				String processedSpellName = processName(spellName)
				Int numEffects = (spellArray[i] as Spell).GetNumEffects()
				Int z = 0
				while z < numEffects
					Int zVar = z + 1


					if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedPlayerName + "_" + processedSpellName + zVar as String + ".json"))
						Int JSpellStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedPlayerName + "_" + processedSpellName + zVar as String + ".json")
						Int jStats = jmap.object()
						Int j = 0
						String stat = jmap.nextKey(JSpellStatList, "", "")
						while j < 3
							String value = jmap.GetStr(JSpellStatList, stat, "")
							if stat == "area"
								(spellArray[i] as Spell).SetNthEffectArea(z, value as Int)
							elseIf stat == "duration"
								(spellArray[i] as Spell).SetNthEffectDuration(z, value as Int)
							elseIf stat == "magnitude"
								(spellArray[i] as Spell).SetNthEffectMagnitude(z, value as Float)
							endIf
							stat = jmap.nextKey(JSpellStatList, stat, "")
							j += 1
						endWhile
						z += 1
					EndIf
				endWhile
				i += 1
			endIf
		endWhile
	EndIf
endFunction

function JLoadSpellAcrossAllSaves()
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json"))
		Form[] spellArray = Utility.CreateFormArray(500)
		String[] spellNameArray = Utility.CreateStringArray(500)
	
		Int jSpellFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M1_ACROSS_ALL_SAVES.json")
		Int jWFormNames = jmap.object()
		String spellForm = jmap.nextKey(jSpellFormList, "", "")
		Int i = 0
		Bool insertNewSpell = true
		while spellForm
			spell value = jmap.GetForm(jSpellFormList, spellForm, none) as spell
			if(value != NONE)
				spellNameArray[i] = spellForm
				spellArray[i] = value
				spellForm = jmap.nextKey(jSpellFormList, spellForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < spellArray.length
			if spellArray[i] == none
				i = 501
			else
				String spellName = spellArray[i].GetName()
				String processedSpellName = processName(spellName)
				Int numEffects = (spellArray[i] as Spell).GetNumEffects()
				Int z = 0
				while z < numEffects
					Int zVar = z + 1

					if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedSpellName + zVar as String + ".json"))
						Int JSpellStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusS_M2_" + processedSpellName + zVar as String + ".json")
						Int jStats = jmap.object()
						Int j = 0
						String stat = jmap.nextKey(JSpellStatList, "", "")
						while j < 3
							String value = jmap.GetStr(JSpellStatList, stat, "")
							if stat == "area"
								(spellArray[i] as Spell).SetNthEffectArea(z, value as Int)
							elseIf stat == "duration"
								(spellArray[i] as Spell).SetNthEffectDuration(z, value as Int)
							elseIf stat == "magnitude"
								(spellArray[i] as Spell).SetNthEffectMagnitude(z, value as Float)
							endIf
							stat = jmap.nextKey(JSpellStatList, stat, "")
							j += 1
						endWhile
					endIf
					z += 1
				endWhile
				i += 1
			endIf
		endWhile
	EndIf
endFunction



