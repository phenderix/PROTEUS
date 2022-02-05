
scriptName SIGEStartupScript extends Quest

Import PhenderixToolResourceScript
Import CharGen
Import JContainers

;-- Properties --------------------------------------
spell property sigeSpell auto
spell property sigeWeather auto
spell property sigePlayer auto
spell property sigeArmor auto
spell property sigeNPC auto
spell property sigeWeapon auto
spell property sigeUtility auto
spell property sigeWheel auto


;-- Functions ---------------------------------------
function OnInit()
	utility.Wait(5)
	actor player = game.GetPlayer()
	player.AddSpell(sigeSpell, true)
	player.AddSpell(sigeWeapon, true)
	player.AddSpell(sigeNPC, true)
	player.AddSpell(sigePlayer, true)
	player.AddSpell(sigeArmor, true)
	player.AddSpell(sigeWeather, true)
	player.AddSpell(sigeUtility, true)
	player.AddSpell(sigeWheel, true)
	
	;LOAD Proteus SAVED VALUES/FORMS ACROSS ALL SAVES
	JLoadArmorAcrossAllSaves()
	JLoadSpellAcrossAllSaves()
	JLoadWeaponsAcrossAllSaves()
	JLoadNPCAcrossAllSaves()
	Debug.Notification("PROJECT PROTEUS has been installed.")
endFunction






function JLoadNPCAcrossAllSaves()
	Form[] NPCArray = Utility.CreateFormArray(500)
	String[] NPCNameArray = Utility.CreateStringArray(500)
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusN_M1_ACROSS_ALL_SAVES.json") == true) 
		Int jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusN_M1_ACROSS_ALL_SAVES.json")
		Int jWFormNames = jmap.object()
		String NPCForm = jmap.nextKey(jNPCFormList, "", "")
		Int i = 0

		while NPCForm
			Actor value = jmap.GetForm(jNPCFormList, NPCForm, none) as Actor
			NPCNameArray[i] = NPCForm
			NPCArray[i] = value
			NPCForm = jmap.nextKey(jNPCFormList, NPCForm, "")
			i += 1
		endWhile
		i = 0
		while i < NPCArray.length
			;Debug.Notification("JLOAD NPC: " + (NPCArray[i] as Actor).GetDisplayName())
			if NPCArray[i] == none
				i = 501
			else
				String NPCName = (NPCArray[i] as Actor).GetDisplayName()
				String processedNPCName = processName(NPCName)
				;Debug.MessageBox(processedNPCName)
				
				If(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusN_M2_" + processedNPCName + ".json"))
					Int JNPCList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusN_M2_" + processedNPCName + ".json")
					Int jStats = jmap.object()
					String stat = jmap.nextKey(JNPCList, "", "")

					String value = jmap.GetStr(JNPCList, stat, "")
					if stat == "name"
						ColorForm colorHair = (NPCArray[i] as Actor).GetActorBase().GetHairColor()	
						Race currentRace = (NPCArray[i] as Actor).GetRace()
						LoadCharacterPreset((NPCArray[i] as Actor), value, colorHair) 
						LoadCharacter((NPCArray[i] as Actor), currentRace, value)
					endIf
				EndIf
				i += 1
			endIf
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
			armorNameArray[i] = armorForm
			armorArray[i] = value
			armorForm = jmap.nextKey(jArmorFormList, armorForm, "")
			i += 1
		endWhile
		i = 0
		while i < armorArray.length
			if armorArray[i] == none
				i = 501
			else
				String armorName = armorArray[i].GetName()
				String processedArmorName = processName(armorName)

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedArmorName + ".json"))
					Int JArmorStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedArmorName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JArmorStatList, "", "")
					while j < 4
						String value = jmap.GetStr(JArmorStatList, stat, "")
						if stat == "armorrating"
							(armorArray[i] as Armor).SetArmorRating(value as Int)
						elseIf stat == "weightclass"
							(armorArray[i] as Armor).SetWeightClass(value as Int)
						elseIf stat == "goldval"
							(armorArray[i] as Armor).SetGoldValue(value as Int)
						elseIf stat == "Weight"
							(armorArray[i] as Armor).SetWeight(value as Float)
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
			spellNameArray[i] = spellForm
			spellArray[i] = value
			spellForm = jmap.nextKey(jSpellFormList, spellForm, "")
			i += 1
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









function JLoadWeaponsAcrossAllSaves()

	Form[] weaponArray = Utility.CreateFormArray(500)
	String[] weaponNameArray = Utility.CreateStringArray(500)

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json"))
		Int jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
		Int jWFormNames = jmap.object()
		String weaponForm = jmap.nextKey(jWeaponFormList, "", "")
		Int i = 0
		Bool insertNewWeapon = true
		while weaponForm
			weapon value = jmap.GetForm(jWeaponFormList, weaponForm, none) as weapon
			weaponNameArray[i] = weaponForm
			weaponArray[i] = value
			weaponForm = jmap.nextKey(jWeaponFormList, weaponForm, "")
			i += 1
		endWhile
		i = 0
		while i < weaponArray.length
			if weaponArray[i] == none
				i = 501
			else
				String weaponName = weaponArray[i].GetName()
				String processedWeaponName = processName(weaponName)

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedWeaponName + ".json"))
					Int JWeaponStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedWeaponName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JWeaponStatList, "", "")
					while j < 7
						String value = jmap.GetStr(JWeaponStatList, stat, "")
						if stat == "crit"
							(weaponArray[i] as Weapon).SetCritDamage(value as Int)
						elseIf stat == "damage"
							(weaponArray[i] as Weapon).SetBaseDamage(value as Int)
						elseIf stat == "goldval"
							(weaponArray[i] as Weapon).SetGoldValue(value as Int)
						elseIf stat == "Reach"
							(weaponArray[i] as Weapon).SetReach(value as Float)
						elseIf stat == "Speed"
							(weaponArray[i] as Weapon).SetSpeed(value as Float)
						elseIf stat == "Stagger"
							(weaponArray[i] as Weapon).SetStagger(value as Float)
						elseIf stat == "Weight"
							(weaponArray[i] as Weapon).SetWeight(value as Float)
						endIf
						stat = jmap.nextKey(JWeaponStatList, stat, "")
						j += 1
					endWhile
				endIf
			endIf
			i += 1
		endWhile
	EndIf
endFunction