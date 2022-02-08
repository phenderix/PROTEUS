
scriptName SIGEWeaponLoadAliasScript extends ReferenceAlias

import PhenderixToolResourceScript
import JContainers

;-- Properties --------------------------------------
globalvariable property ZZProteusWeaponTotalEdits auto
Keyword property weapTypeBattleaxe auto
Keyword property weapTypeBow auto
Keyword property weapTypeDagger auto
Keyword property weapTypeGreatsword auto
Keyword property weapTypeMace auto
Keyword property weapTypeStaff auto
Keyword property weapTypeSword auto
Keyword property weapTypeWarAxe auto
Keyword property weapTypeWarhammer auto
;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

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
			if(value != NONE)
				weaponNameArray[i] = weaponForm
				weaponArray[i] = value
				weaponForm = jmap.nextKey(jWeaponFormList, weaponForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < weaponArray.length
			if weaponArray[i] == none
				i = 501
			else
				String weaponName = weaponArray[i].GetName()
				String processedWeaponName = processName(weaponName)
				Weapon weaponTemp = (weaponArray[i] as Weapon)

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedWeaponName + ".json"))
					Int JWeaponStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedWeaponName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JWeaponStatList, "", "")
					while j < 8
						String value = jmap.GetStr(JWeaponStatList, stat, "")
						if stat == "crit"
							weaponTemp.SetCritDamage(value as Int)
						elseIf stat == "damage"
							weaponTemp.SetBaseDamage(value as Int)
						elseIf stat == "goldval"
							weaponTemp.SetGoldValue(value as Int)
						elseIf stat == "Reach"
							weaponTemp.SetReach(value as Float)
						elseIf stat == "Speed"
							weaponTemp.SetSpeed(value as Float)
						elseIf stat == "Stagger"
							weaponTemp.SetStagger(value as Float)
						elseIf stat == "Weight"
							weaponTemp.SetWeight(value as Float)
						elseif stat == "Type"
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

function OnPlayerLoadGame()

	utility.Wait(0.500000)
	JLoadWeaponsAcrossAllSaves()
	if ZZProteusWeaponTotalEdits.GetValue() != 0 as Float
		JLoadWeaponSpecificSave()
	endIf
endFunction

function JLoadWeaponSpecificSave()

	String playerName = game.GetPlayer().GetBaseObject().GetName()
	String processedPlayerName = processName(playerName)
	Form[] weaponArray = Utility.CreateFormArray(500)
	String[] weaponNameArray = Utility.CreateStringArray(500)

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json"))
		Int jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json")
		Int jWFormNames = jmap.object()
		String weaponForm = jmap.nextKey(jWeaponFormList, "", "")
		Int i = 0
		Bool insertNewWeapon = true
		while weaponForm
			weapon value = jmap.GetForm(jWeaponFormList, weaponForm, none) as weapon
			if(value != NONE)
				weaponNameArray[i] = weaponForm
				weaponArray[i] = value
				weaponForm = jmap.nextKey(jWeaponFormList, weaponForm, "")
				i += 1
			endIf
		endWhile
		i = 0
		while i < weaponArray.length
			if weaponArray[i] == none
				i = 501
			else
				String weaponName = weaponArray[i].GetName()
				String processedWeaponName = processName(weaponName)
				Weapon weaponTemp = (weaponArray[i] as Weapon)

				if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + processedWeaponName + ".json"))
					Int JWeaponStatList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + processedWeaponName + ".json")
					Int jStats = jmap.object()
					Int j = 0
					String stat = jmap.nextKey(JWeaponStatList, "", "")
					while j < 8
						String value = jmap.GetStr(JWeaponStatList, stat, "")
						if stat == "crit"
							weaponTemp.SetCritDamage(value as Int)
						elseIf stat == "damage"
							weaponTemp.SetBaseDamage(value as Int)
						elseIf stat == "goldval"
							weaponTemp.SetGoldValue(value as Int)
						elseIf stat == "Reach"
							weaponTemp.SetReach(value as Float)
						elseIf stat == "Speed"
							weaponTemp.SetSpeed(value as Float)
						elseIf stat == "Stagger"
							weaponTemp.SetStagger(value as Float)
						elseIf stat == "Weight"
							weaponTemp.SetWeight(value as Float)
						elseif stat == "Type"
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







