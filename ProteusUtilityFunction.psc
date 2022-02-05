Scriptname ProteusUtilityFunction extends ActiveMagicEffect  

Import PhenderixToolResourceScript
Import JContainers
Import CharGen

GlobalVariable property ZZHasSavedPlayerCharacter auto
GlobalVariable property ZZNPCAppearanceSaved auto
FormList property combatStylesList auto
Spell property ProteusSpawnerSpell auto


Spell property ProteusArmor auto
Spell property ProteusWeapon auto
Spell property ProteusSpell auto
Spell property ProteusNPC auto
Spell property ProteusWeather auto
Spell property ProteusPlayer auto
Spell property ProteusWheel auto
Spell property ProteusUtility auto

FormList property teleportLocationsList auto


function OnEffectStart(Actor akplayer, Actor akCaster)
	Actor player = Game.GetPlayer()
	string[] stringArray = new String[7]
	stringArray[0] = " Spawner"
	stringArray[1] = " Teleporter"
	stringArray[2] = " Reload Presets on all NPCs"
	stringArray[3] = " Clear Player Preset (May Do Nothing)"
	stringArray[4] = " Remove Proteus Spells (Besides Wheel)"
	stringArray[5] = " Add All Proteus Spells"
	stringArray[6] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 7
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		ProteusSpawnerSpell.cast(akCaster)
	elseif result == 1
		Teleporter()
	elseif result == 2
		if(ZZNPCAppearanceSaved.GetValue() > 0)
				JLoadNPCAcrossAllSaves()
			endIf
	elseif result == 3
		DeleteFaceGenData(Game.GetPlayer().GetActorBase())
		ClearPreset(Game.GetPlayer().GetActorBase())
	elseif result == 4
		player.RemoveSpell(ProteusArmor)
		player.RemoveSpell(ProteusWeapon)
		player.RemoveSpell(ProteusSpell)
		player.RemoveSpell(ProteusNPC)
		player.RemoveSpell(ProteusWeather)
		player.RemoveSpell(ProteusPlayer)
		player.RemoveSpell(ProteusUtility)
		Debug.Notification("All Proteus spells, besides wheel, removed from spell list.")
	elseif result == 5
		player.AddSpell(ProteusArmor)
		player.AddSpell(ProteusWeapon)
		player.AddSpell(ProteusSpell)
		player.AddSpell(ProteusNPC)
		player.AddSpell(ProteusWeather)
		player.AddSpell(ProteusPlayer)
		player.AddSpell(ProteusWheel)
		player.AddSpell(ProteusUtility)
		Debug.Notification("All Proteus spells added to spell list.")
	elseif result == 6
		
	endIf
endFunction


Function Teleporter()
		Actor player = Game.GetPlayer()
		Debug.Notification("Teleporter menu loading...may take a few seconds!")
		String[] stringArray = new String[125]
		Form[] teleportArray = new Form[125]
		int k = 0
		while k < teleportLocationsList.GetSize()
			Form temp = teleportLocationsList.GetAt(k)
			teleportArray[k] = temp
			stringArray[k] = " " + temp.GetName()
			k+=1
		endWhile
		UIListMenu listMenuTeleport = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		listMenuTeleport.AddEntryItem("Current Location")
		int i
		if listMenuTeleport
			int n = k+1
			i = 0
			while i < n
				listMenuTeleport.AddEntryItem(stringArray[i])
				i += 1
			endwhile
		EndIf
			
		listMenuTeleport.OpenMenu()
		int result = listMenuTeleport.GetResultInt()

		if result > 0 && result <= 130
			int numR = result - 1
			(teleportLocationsList.GetAt(numR) as Spell).Cast(player, player)
		else
		endIf

endFunction











function JLoadNPCAcrossAllSaves()
	Form[] NPCArray = Utility.CreateFormArray(500)
	String[] NPCNameArray = Utility.CreateStringArray(500)
	String ZZNPCAppearanceSavedValue = Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0)


	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusN_M1_" + ZZNPCAppearanceSavedValue + ".json"))
		Int jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusN_M1_" + ZZNPCAppearanceSavedValue + ".json")
		Int jWFormNames = jmap.object()
		String NPCForm = jmap.nextKey(jNPCFormList, "", "")
		Int i = 0

		while NPCForm
			Form value = jmap.GetForm(jNPCFormList, NPCForm, none) as Form
			NPCArray[i] = value
			Int startPosition = Stringutil.Find(NPCForm, "_ProteusNPC_", 0)
			String NPCNameProcessed = StringUtil.Substring(NPCForm, startPosition + 12, StringUtil.GetLength(NPCForm))
			;Debug.MessageBox("NPCNameProcessed: " + NPCNameProcessed)
			NPCNameArray[i] = NPCNameProcessed
			;Debug.MessageBox("PRE NPC NAME IS: " + NPCForm)

			(NPCArray[i] as Actor).SetName(NPCNameProcessed)
			(NPCArray[i] as Actor).GetActorBase().SetName(NPCNameProcessed)
			;(NPCArray[i] as Actor).SetDisplayName(NPCForm)
			NPCForm = jmap.nextKey(jNPCFormList, NPCForm, "")
			i += 1
		endWhile
		i = 0
		while i < NPCArray.length
			;Debug.Notification("JLOAD NPC: " + (NPCArray[i] as Actor).GetDisplayName())
			if NPCArray[i] == none
				i = 501
			else
				String NPCName = (NPCArray[i] as Actor).GetActorBase().GetName()
				String processedNPCName = processName(NPCName)
				;Debug.MessageBox("PROCESSED NAME: " + processedNPCName)
				
				If(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusN_M2_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json"))
					Int JNPCList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusN_M2_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json")
					Int jStats = jmap.object()
					String stat = jmap.nextKey(JNPCList, "", "")

					String value = jmap.GetStr(JNPCList, stat, "")
					Int valueInt = value as Int
					;Debug.MessageBox("ValueOne " + value + " StatOne " + stat)
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
					;Debug.MessageBox("ValueOne " + value + " StatOne " + stat)
					if stat == "name"
						if(value != "")
							;Debug.MessageBox("Appearance Load Ran")
							;Debug.MessageBox("Loading preset: " + value)
							;Proteus_LoadTargetStrings(value, NPCArray[i] as Actor, 2) ;do I need this?
							ColorForm colorHair = (NPCArray[i] as Actor).GetActorBase().GetHairColor()	
							Race currentRace = (NPCArray[i] as Actor).GetRace()
							LoadCharacterPreset((NPCArray[i] as Actor), value, colorHair) 
							LoadCharacter((NPCArray[i] as Actor), currentRace, value)
						endIf
					endIf
				EndIf

				If(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusN_VT_M2_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json"))
					Int jVTList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusN_VT_M2_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json")
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
