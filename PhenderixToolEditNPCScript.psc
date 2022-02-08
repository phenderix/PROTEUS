scriptName PhenderixToolEditNPCScript extends activemagiceffect

import PO3_SKSEFunctions
import PhenderixToolResourceScript
import CharGen
import JContainers
Import ConsoleUtil
Import ProteusCheatFunctions

;-- Properties --------------------------------------
spell property NPCControlSpell auto
spell property spellEdit auto 
spell property weaponEdit auto
message property PromptAssistanceMenu auto
message property PromptAggressionMenu auto
message property PromptAIMenu auto
message property PromptResurrect auto
message property PromptItems auto
spell property armorEdit auto
message property PromptConfidenceMenu auto
faction property PotentialFollowerFaction auto
faction property PotentialMarriageFaction auto
message property PromptMarryFollowerMenu auto
message property PromptEssentialYesNo auto
message property ZZDeletePresetMenu auto
message property ZZLoadPresetMenu auto
message property ZZSavePresetMenu auto
message property ZZGameWorldSetMessage auto
Quest property ZZProteusSkyUIMenu auto
Race property argonianRace auto
Race property khajitRace auto
Race property nordRace auto

GlobalVariable property ZZNPCAppearanceSaved auto

ObjectReference property voidMarker auto

;combat styles
FormList property ZZOutfits auto
FormList property combatStylesList auto
FormList property hairColorList auto
FormList property teleportLocationsList auto
FormList property headPartsList auto
FormList property ZZVoiceTypes auto
;Face Tints
String[] Property ProteusTintList Auto
int[] Property ProteusTintColors Auto
int[] Property ProteusTintType Auto



;-- Variables ---------------------------------------
String[] presetsLoaded
Bool obisActive ;OBIS Bandits
Bool lotdActive ;Legacy of the Dragonborn
Bool haemophiliaActive ;Haemophilia Perks
Bool unarmouredDefenseActive ;Unarmoured Defense Perks
Bool dragonbornCustomPerkActive ;Dragonborn Shout Perks
Bool vigilantPerksActive ;Vigilant Perks
Bool glenmorilPerksActive ;Glenmoril Perks
Bool handtohandActive ;Hand to Hands Perks
Bool pmwActive ;Phenderix Magic World
Bool apocalypseActive ;Apocalypse - Magic of Skyrim
Bool edmrActive ;Elemental Destruction Magic Redux
Bool pmeActive ;Phenderix Magic Evolved
Bool odinActive ;Odin Odin - Skyrim Magic Overhaul
Bool triumActive ;Triumvirate - Mage Archetypes
Bool imperiousActive ;Imperious - Races of Skyrim
Bool aethActive ;Aetherius - A Race Overhaul
bool morningstarActive ;Morningstar - Minimalistic Races of Skyrim
Bool betterVampiresActive ;Better Vampires
Bool bloodlinesActive
Bool bloodmoonRisingActive
Bool curseVampireActive
bool manbeastActive
Bool lupineActive
Bool moonlightTalesActive
Bool growlActive
Bool sacrilegeActive
Bool sacrosanctActive
Bool sanguinaireActive
Bool truaActive
Bool wintersunActive
Bool pilgrimActive
Bool scionActive
Bool vampyriumActive
Bool werewolfPerksExpandedActive
Bool arcanumActive
Bool shadowspellsActive
Bool acebloodActive
Bool mysticiscmActive
Bool edmActive
int listTimesCounter
Actor npcTarget

;-- Functions ---------------------------------------
function OnEffectStart(Actor akTarget, Actor akCaster)
	npcTarget = akTarget
	if(ZZNPCAppearanceSaved.GetValue() == 0)
		WorldIdentityFunction()
	endIf

	if akTarget.IsDead() == true
		Proteus_ResurrectFunction(akTarget)
	else
		Proteus_NPCMainMenu(akTarget)
	endIf
endFunction

function Proteus_NPCMainMenu(Actor gTarget)
	string[] stringArray = new String[23]
	stringArray[0] = " Appearance"
	stringArray[1] = " Stat Summary"
	stringArray[2] = " Skills"
	stringArray[3] = " Attributes"
	stringArray[4] = " Resistances"
	stringArray[5] = " Scale/Size"
	stringArray[6] = " AI Behavior"
	stringArray[7] = " Duplicate"
	stringArray[8] = " Protected/Essential/Kill"
	stringArray[9] = " Recruit/Marry"
	stringArray[10] = " Spells/Perks"
	stringArray[11] = " Items"
	stringArray[12] = " Idle Animations"
	stringArray[13] = " Voice Type"
	stringArray[14] = " Combat Style"
	stringArray[15] = " Outfit"
	stringArray[16] = " Level"
	stringArray[17] = " Take Control"
	stringArray[18] = " Send to Void"
	stringArray[19] = " Teleporter"
	stringArray[20] = " Level Scaler"
	stringArray[21] = " Reset/Clear NPC Proteus Edits"
	stringArray[22] = " Exit"


	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 23
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		Proteus_EditNPCAppearance(gTarget)
	elseIf result == 1
		UIStatsMenu statsMenu = UIExtensions.GetMenu("UIStatsMenu") as UIStatsMenu
		statsMenu.OpenMenu(gTarget, gTarget)
	elseIf result == 2
		Proteus_NPCSkillsFunction(gTarget)
	elseIf result == 3
		Proteus_NPCAttributesFunction(gTarget)
	elseIf result == 4
		Proteus_NPCResistanceFunction(gTarget)
	elseIf result == 5
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 6
		Proteus_AIFunction(gTarget)
	elseIf result == 7
		gTarget.PlaceAtMe(gTarget.GetBaseObject(), 1, false, false)
		Debug.Notification(gTarget.GetDisplayName() + " has been duplicated.")
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 8
		Proteus_EssentialFunction(gTarget)
	elseIf result == 9
		Proteus_RecruitMarryFunction(gTarget)
	elseIf result == 10
		Proteus_NPCMagicFunction(gTarget)
	elseIf result == 11
		Proteus_NPCItemsFunction(gTarget)
	elseIf result == 12
		Proteus_IdleAnimationFunction(gTarget)
	elseif result == 13
		listTimesCounter = 0
		Proteus_NPCVoiceType(gTarget, 0)
	elseif result == 14
		Proteus_NPCCombatStyle(gTarget)
	elseif result == 15
		Proteus_CheatOutfit(gTarget, 0, 1)
	elseif result == 16
		Proteus_NPCLevelFunction(gTarget)
	elseif result == 17
		Proteus_NPCTakeControlFunction(gTarget)
	elseif result == 18
		gTarget.MoveTo(voidMarker)
	elseif result == 19
		Teleporter(gTarget)
	elseif result == 20
		LevelScaler(gTarget)
	elseif result == 21
		Proteus_ClearNPCEdits(gTarget)
	endIf
endFunction






Function Proteus_NPCCombatStyle(Actor targetName)
	;combat style
	int combatStyleNum = 0
	string[] stringArray = new String[6]
	stringArray[0] = " Warrior"
	stringArray[1] = " Archer"
	stringArray[2] = " Mage"
	stringArray[3] = " Tank"
	stringArray[4] = " Berserker"
	stringArray[5] = " Exit"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 6
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	if result == 0
		targetName.GetActorBase().SetCombatStyle(combatStylesList.GetAt(0) as CombatStyle)
		combatStyleNum = 0
	elseif result == 1
		targetName.GetActorBase().SetCombatStyle(combatStylesList.GetAt(1) as CombatStyle)
		combatStyleNum = 1
	elseif result == 2
		targetName.GetActorBase().SetCombatStyle(combatStylesList.GetAt(2) as CombatStyle)
		combatStyleNum = 2
	elseif result == 3
		targetName.GetActorBase().SetCombatStyle(combatStylesList.GetAt(3) as CombatStyle)
		combatStyleNum = 3
	elseif result == 4
		targetName.GetActorBase().SetCombatStyle(combatStylesList.GetAt(4) as CombatStyle)
		combatStyleNum = 4
	endIf

	String targetNameProcessed = processName(targetName.GetActorBase().GetName())
	Int lengthSpawnName = StringUtil.GetLength(targetNameProcessed)
	String targetPresetName
	if (lengthSpawnName > 0)
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + targetNameProcessed + ".json"))
			Int JNPCList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + targetNameProcessed + ".json")
			Int jStats = jmap.object()
			String stat = jmap.nextKey(JNPCList, "", "")
			String value = jmap.GetStr(JNPCList, stat, "")
			if stat == "name"
				targetPresetName = value
				;Debug.MessageBox("Found Target Preset Name: " + value)
			endIf
			stat = jmap.nextKey(JNPCList, stat, "")
			value = jmap.GetStr(JNPCList, stat, "")
			if stat == "name"
				targetPresetName = value
				;Debug.MessageBox("Found Target Preset Name: " + value)
			endIf
		EndIf
	endIf

	Int lengthPresetName = StringUtil.GetLength(targetPresetName)

	if(lengthPresetName > 0)
		Proteus_JSave_NPCForms(targetName, targetNameProcessed, targetPresetName)	
	else
		Proteus_JSave_NPCForms(targetName, targetNameProcessed, "")	
	endIf

	if (lengthPresetName > 0)
	Else
		targetPresetName = ""
	endIf
	Int jNPCList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_NPC_GeneralInfo_Template.json")
	Int jNStats = jmap.object()
	Int maxCount = jvalue.Count(jNPCList)
	Int j = 0
	String value
	String stat
	while j < maxCount
		stat = jarray.getStr(jNPCList, j, "")
		if j == 0
			value = targetPresetName
		elseif j == 1
			value = combatStyleNum
		EndIf
		j += 1
		jmap.SetStr(jNStats, stat, value)
	endWhile
	jvalue.writeToFile(jNStats, jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + targetNameProcessed + ".json")
	debug.Notification(targetName.GetDisplayName() + " combat style into the Proteus system.")

endFunction



Function Proteus_NPCVoiceType(Actor gTarget, int startingPoint)
	Debug.Notification("Voice Type menu loading...may take a few seconds!")

	String npcName = gTarget.GetActorBase().GetName()
	String processedNPCName = processName(NPCName)
	UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenuBase 
		int i = 0
		listMenuBase.AddEntryItem("[Exit Menu]")
		i+=1
		listMenuBase.AddEntryItem("[Complete List]")
		i+=1
		while (i - 2) < ZZVoiceTypes.GetSize()
			listMenuBase.AddEntryItem(GetFormEditorID(ZZVoiceTypes.GetAt(i - 2)))
			i += 1
		endwhile
	EndIf
	listMenuBase.OpenMenu()
	int result = listMenuBase.GetResultInt()
	if result == 1
		Debug.MessageBox("Note: Not all voice types will be follower and spouse compatible. \n\nThis will require some testing on your part.")
		Utility.Wait(0.1)
		listTimesCounter = 0
		Proteus_NPCVoiceTypeExhaustive(gTarget, 0, 1)
	elseif(result > 1)
		gTarget.GetActorBase().SetVoiceType(ZZVoiceTypes.GetAt(result - 2) as VoiceType)
		Debug.Notification(npcName + " voice type successfully changed.")
		Proteus_SaveNPCVoiceType(gTarget, processedNPCName)
	endIf
endFunction




Function Proteus_IdleAnimationFunction(Actor gTarget)
	string[] stringArray
	stringArray= new String[23]
	stringArray[0] = " Bow"
	stringArray[1] = " Bow Head"
	stringArray[2] = " Blow Horn"
	stringArray[3] = " Clean Sword"
	stringArray[4] = " Crossed Arms"
	stringArray[5] = " Drink"
	stringArray[6] = " Examine"
	stringArray[7] = " Get Attention"
	stringArray[8] = " Injured"
	stringArray[9] = " Kneeling"
	stringArray[10] = " Lay Down"
	stringArray[11] = " Look Far"
	stringArray[12] = " Meditate"
	stringArray[13] = " Read Book"
	stringArray[14] = " Read Note"
	stringArray[15] = " Salute"
	stringArray[16] = " Search Body"
	stringArray[17] = " Study"
	stringArray[18] = " Surrender"
	stringArray[19] = " Wave"
	stringArray[20] = " Welcome"
	stringArray[21] = " Back"
	stringArray[22] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 23
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		Debug.SendAnimationEvent(gTarget,"IdleSilentBow")
	elseIf result == 1
		Debug.SendAnimationEvent(gTarget,"idlebowheadatgrave_01")
	elseIf result == 2
		Debug.SendAnimationEvent(gTarget,"idleblowhornimperial")
	elseIf result == 3
		Debug.SendAnimationEvent(gTarget,"idlecleansword")
	elseIf result == 4
		Debug.SendAnimationEvent(gTarget,"idleoffsetarmscrossedstart")
	elseIf result == 5
		Debug.SendAnimationEvent(gTarget,"IdleDrink")
	elseIf result == 6
		Debug.SendAnimationEvent(gTarget,"idleexamine")
	elseIf result == 7
		Debug.SendAnimationEvent(gTarget,"IdleGetAttention")
	elseIf result == 8
		Debug.SendAnimationEvent(gTarget,"IdleInjured")
	elseIf result == 9
		Debug.SendAnimationEvent(gTarget,"IdleKneeling")
	elseIf result == 10
		Debug.SendAnimationEvent(gTarget,"IdleLayDownEnter")
	elseIf result == 11
		Debug.SendAnimationEvent(gTarget,"IdleLookFar")
	elseIf result == 12
		Debug.SendAnimationEvent(gTarget,"IdleGreybeardMeditate")
	elseIf result == 13
		Debug.SendAnimationEvent(gTarget,"idlebook_reading ")
	elseIf result == 14
		Debug.SendAnimationEvent(gTarget,"IdleNoteRead")
	elseIf result == 15
		Debug.SendAnimationEvent(gTarget,"IdleSalute")
	elseIf result == 16
		Debug.SendAnimationEvent(gTarget,"IdleSearchBody")
	elseIf result == 17
		Debug.SendAnimationEvent(gTarget,"IdleStudy")
	elseIf result == 18
		Debug.SendAnimationEvent(gTarget,"IdleSurrender")
	elseIf result == 19
		Debug.SendAnimationEvent(gTarget,"IdleWave")
	elseIf result == 20
		Debug.SendAnimationEvent(gTarget,"IdleWelcomeGesture")
	elseIf result == 21
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 22
	endIf
EndFunction







Function Proteus_NPCMagicFunction(Actor gTarget)
	string[] stringArray
	stringArray= new String[5]
	stringArray[0] = " Remove/Teach NPC Spell"
	stringArray[1] = " Add Spell to NPC"
	stringArray[2] = " Add Perk to NPC"
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

	if result == 0 ;forget or teach spell
		UIMagicMenu magicMenu = UIExtensions.GetMenu("UIMagicMenu") as UIMagicMenu
		magicMenu.SetPropertyForm("receivingActor", Game.GetPlayer())
		magicMenu.OpenMenu(gTarget)
		magicMenu = None
	elseif result == 1
		Proteus_CheatSpell(gTarget, 0, 1, 22, ZZProteusSkyUIMenu)
	elseif result == 2
		Proteus_CheatPerk(gTarget, 0, 1, 92, ZZProteusSkyUIMenu)
	elseif result == 3 ;back
		Proteus_NPCMainMenu(gTarget)
	elseif result == 4 ;exit
	endIf
EndFunction






int function Proteus_NPCSkillsFunction(Actor gTarget)
	string[] stringArray
	stringArray= new String[21]
	stringArray[0] = " Alchemy"
	stringArray[1] = " Alteration"
	stringArray[2] = " Archery"
	stringArray[3] = " Block"
	stringArray[4] = " Conjuration"
	stringArray[5] = " Destruction"
	stringArray[6] = " Enchanting"
	stringArray[7] = " Heavy Armor"
	stringArray[8] = " Illusion"
	stringArray[9] = " Light Armor"
	stringArray[10] = " Lockpicking"
	stringArray[11] = " One-Handed"
	stringArray[12] = " Pickpocket"
	stringArray[13] = " Restoration"
	stringArray[14] = " Smithing"
	stringArray[15] = " Sneak"
	stringArray[16] = " Speech"
	stringArray[17] = " Two-Handed"
	stringArray[18] = " Stat Summary"
	stringArray[19] = " Back"
	stringArray[20] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 21
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	;Debug.Notification("Selected : "+ stringArray[result])

	if result == 0
		Proteus_SkillModify("alchemy", gTarget)
	elseIf result == 1
		Proteus_SkillModify("alteration", gTarget)
	elseIf result == 2
		Proteus_SkillModify("Marksman", gTarget)
	elseIf result == 3
		Proteus_SkillModify("block", gTarget)
	elseIf result == 4
		Proteus_SkillModify("conjuration", gTarget)
	elseIf result == 5
		Proteus_SkillModify("destruction", gTarget)
	elseIf result == 6
		Proteus_SkillModify("enchanting", gTarget)
	elseIf result == 7
		Proteus_SkillModify("heavyArmor", gTarget)
	elseIf result == 8
		Proteus_SkillModify("illusion", gTarget)
	elseIf result == 9
		Proteus_SkillModify("lightArmor", gTarget)
	elseIf result == 10
		Proteus_SkillModify("lockpicking", gTarget)
	elseIf result == 11
		Proteus_SkillModify("oneHanded", gTarget)
	elseIf result == 12
		Proteus_SkillModify("pickpocket", gTarget)
	elseIf result == 13
		Proteus_SkillModify("restoration", gTarget)
	elseIf result == 14
		Proteus_SkillModify("smithing", gTarget)
	elseIf result == 15
		Proteus_SkillModify("sneak", gTarget)
	elseIf result == 16
		Proteus_SkillModify("Speechcraft", gTarget)
	elseIf result == 17
		Proteus_SkillModify("twoHanded", gTarget)
	elseIf result == 18
		Proteus_NPCSkillSummaryFunction(gTarget)
		Proteus_NPCSkillsFunction(gTarget)
	elseIf result == 19
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 20
		return 0 ;close out of menus
	endIf
EndFunction






function Proteus_NPCAttributeModifyFunction(String S, Actor gTarget)

	Float currentAttributeValue = gTarget.GetBaseAV(S)

	string[] stringArray = new String[9]
	stringArray[0] = " -100 Attribute"
	stringArray[1] = " -50 Attribute"
	stringArray[2] = " -10 Attribute"
	stringArray[3] = " +10 Attribute"
	stringArray[4] = " +50 Attribute"
	stringArray[5] = " +100 Attribute"
	stringArray[6] = " Custom Attribute"
	stringArray[7] = " Back"
	stringArray[8] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 9
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()


	if result == 0
		Float newAttributeValue = currentAttributeValue - 100
		if(newAttributeValue < 0)
			Debug.Notification(S + " cannot be lower than 1. Set to 1.")
			newAttributeValue = 1
		else
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		endIf
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 1
		Float newAttributeValue = currentAttributeValue - 50
		if(newAttributeValue < 0)
			Debug.Notification(S + " cannot be lower than 1. Set to 1.")
			newAttributeValue = 1
		else
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		endIf
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 2
		Float newAttributeValue = currentAttributeValue - 10
		if(newAttributeValue < 0)
			Debug.Notification(S + " cannot be lower than 1. Set to 1.")
			newAttributeValue = 1
		else
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		endIf
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 3
		Float newAttributeValue = currentAttributeValue + 10
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 4
		Float newAttributeValue = currentAttributeValue + 50
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 5
		Float newAttributeValue = currentAttributeValue + 100
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetAV(S, newAttributeValue)
		Proteus_NPCAttributeModifyFunction(S, gTarget)
	elseIf result == 6
		String customAttributeValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Attribute Value:")
		if (customAttributeValue as Int) > 0 
			Float newAttributeValue = customAttributeValue as Float
			gTarget.SetAV(S, newAttributeValue)
			Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
			Proteus_NPCAttributeModifyFunction(S, gTarget)
		else
			Debug.Notification("Invalid skill level entered. Try again")
			Proteus_NPCAttributeModifyFunction(S, gTarget)
		endIf
	elseIf result == 7
		Proteus_NPCAttributesFunction(gTarget)
	elseIf result == 8
	endIf
endFunction







function Proteus_AISummaryFunction(Actor gTarget)
	String Confidence
	String Assistance
	String Aggression
	Float aggressionVal = gTarget.GetAV("Aggression")
	Float confidenceVal = gTarget.GetAV("Confidence")
	Float assistanceVal = gTarget.GetAV("Assistance")
	if aggressionVal == 0 as Float
		Aggression = "Unaggressive"
	elseIf aggressionVal == 1 as Float
		Aggression = "Aggressive"
	elseIf aggressionVal == 2 as Float
		Aggression = "Very Aggressive"
	elseIf aggressionVal == 3 as Float
		Aggression = "Frenzied"
	endIf
	if assistanceVal == 0 as Float
		Assistance = "Helps Nobody"
	elseIf assistanceVal == 1 as Float
		Assistance = "Helps Allies"
	elseIf assistanceVal == 2 as Float
		Assistance = "Helps Friends/Allies"
	endIf
	if confidenceVal == 0 as Float
		Confidence = "Cowardly"
	elseIf confidenceVal == 1 as Float
		Confidence = "Cautious"
	elseIf confidenceVal == 2 as Float
		Confidence = "Average"
	elseIf confidenceVal == 3 as Float
		Confidence = "Brave"
	elseIf confidenceVal == 4 as Float
		Confidence = "Foolhardy"
	endIf
	Debug.notification(gTarget.GetBaseObject().GetName() + ": "+ Aggression + ", " + Assistance + ", " + Confidence + ".")
	Proteus_AIFunction(gTarget)
endFunction





int function Proteus_NPCAttributesFunction(Actor gTarget)
	
	string[] stringArray = new String[11]
	stringArray[0] = " Health"
	stringArray[1] = " Stamina"
	stringArray[2] = " Magicka"
	stringArray[3] = " Regen Rate: Health"
	stringArray[4] = " Regen Rate: Stamina"
	stringArray[5] = " Regen Rate: Magicka"
	stringArray[6] = " Carry Weight"
	stringArray[7] = " Divine Restoration"
	stringArray[8] = " Stat Summary"
	stringArray[9] = " Back"
	stringArray[10] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 11
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		Proteus_NPCAttributeModifyFunction("health", gTarget)
	elseIf result == 1
		Proteus_NPCAttributeModifyFunction("stamina", gTarget)
	elseIf result == 2
		Proteus_NPCAttributeModifyFunction("magicka", gTarget)
	elseIf result == 3
		Proteus_AttributeRegenModify("healRate", gTarget)
	elseIf result == 4
		Proteus_AttributeRegenModify("staminaRate", gTarget)
	elseIf result == 5
		Proteus_AttributeRegenModify("magickaRate", gTarget)
	elseIf result == 6
		Proteus_NPCAttributeModifyFunction("carryWeight", gTarget)
	elseIf result == 7
		gTarget.RestoreAV("Health", 1000000 as Float)
		gTarget.RestoreAV("Stamina", 1000000 as Float)
		gTarget.RestoreAV("Magicka", 1000000 as Float)
		Debug.Notification(gTarget.GetDisplayName() + " Health, Magicka, Stamina fully restored.")
		Proteus_NPCAttributesFunction(gTarget)
	elseIf result == 8
		Proteus_NPCSkillSummaryFunction(gTarget)
		Proteus_NPCAttributesFunction(gTarget)
	elseIf result == 9
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 10
		return 0 ;close out of menus	
	endIf
endFunction


function Proteus_EssentialFunction(Actor gTarget)
	string[] stringArray
	stringArray= new String[6]
	stringArray[0] = " Killable"
	stringArray[1] = " Protected Toggle"
	stringArray[2] = " Essential Toggle"
	stringArray[3] = " Kill NPC"	
	stringArray[4] = " Back"	
	stringArray[5] = " Exit"	

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 6
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		gTarget.GetActorBase().SetEssential(false)
		gTarget.GetActorBase().SetProtected(false)
		debug.Notification(gTarget.GetBaseObject().GetName() + " is not essential or protected.")
		Proteus_EssentialFunction(gTarget)
	elseIf result == 1
		if gTarget.GetActorBase().IsProtected() == true
			gTarget.GetActorBase().SetProtected(false)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now not protected.")
		elseIf gTarget.GetActorBase().IsEssential() == true
			gTarget.GetActorBase().SetProtected(true)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now protected and no longer essential.")
		else
			gTarget.GetActorBase().SetProtected(true)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now protected.")
		endIf
		Proteus_EssentialFunction(gTarget)
	elseIf result == 2
		if gTarget.GetActorBase().IsEssential() == true
			gTarget.GetActorBase().SetEssential(false)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now not essential.")
		elseIf gTarget.GetActorBase().IsProtected() == true
			gTarget.GetActorBase().SetEssential(true)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now essential and no longer protected.")
		else
			gTarget.GetActorBase().SetEssential(true)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now essential.")
		endIf
		Proteus_EssentialFunction(gTarget)
	elseIf result == 3
		gTarget.Kill()
	elseIf result == 4
		Proteus_NPCMainMenu(gTarget)
	endIf

endFunction





function Proteus_NPCItemsFunction(Actor gTarget)
	string[] stringArray
	stringArray= new String[4]
	;stringArray[0] = " Edit Equipped Weapon"
	;stringArray[1] = " Edit Equipped Armor"
	stringArray[0] = " Open Inventory"
	stringArray[1] = " Unequip All Items"	
	stringArray[2] = " Back"	
	stringArray[3] = " Exit"	

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 4
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	;if result == 0
		;weaponEdit.Cast(gTarget as objectreference, none)
	;elseIf result == 1
		;armorEdit.Cast(gTarget as objectreference, none)
	if result == 0
		gTarget.OpenInventory(true)
	elseIf result == 1
		gTarget.UnEquipAll()
		Proteus_NPCItemsFunction(gTarget)
	elseIf result == 2
		Proteus_NPCMainMenu(gTarget)
	endIf
endFunction




function Proteus_ResurrectFunction(Actor gTarget)
	Debug.Notification(gTarget.GetActorBase().GetName() + " was killed by " + gTarget.GetKiller().GetActorBase().GetName() + ".")
	Int ibutton = PromptResurrect.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton == 0
		gTarget.Resurrect()
		Debug.Notification(gTarget.GetDisplayName() + " was resurrected.")
	elseif ibutton == 1
		gTarget.Disable()
	endIf
endFunction

function Proteus_RecruitMarryFunction(Actor gTarget) 
	string[] stringArray
	stringArray= new String[4]
	stringArray[0] = " Recruitable"
	stringArray[1] = " Marriable"
	stringArray[2] = " Back"
	stringArray[3] = " Exit"	

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 4
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		Proteus_RecruitableFunction(gTarget)
	elseIf result == 1
		Proteus_MarriableFunction(gTarget)
	elseIf result == 2
		Proteus_NPCMainMenu(gTarget)
	endIf
endFunction



function Proteus_SkillModify(String S, Actor gTarget)
	Float currentSkillValue = gTarget.GetBaseAV(S)
	
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " -10 Skill Level"
	stringArray[1] = " -5 Skill Level"
	stringArray[2] = " -1 Skill Level"
	stringArray[3] = " +1 Skill Level"
	stringArray[4] = " +5 Skill Level"
	stringArray[5] = " +10 Skill Level"
	stringArray[6] = " Custom Skill Level"
	stringArray[7] = " Back"
	stringArray[8] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 9
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()

    if result == 0
        Float newSkillValue = currentSkillValue - 10
        if newSkillValue < 0
            debug.Notification("Skill level cannot be lower than 0. Set to 0.")
            gTarget.SetAV(S, 0)
        else
            gTarget.SetAV(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseif result == 1
        Float newSkillValue = currentSkillValue - 5
        if newSkillValue < 0
            debug.Notification("Skill level cannot be lower than 0. Set to 0.")
            gTarget.SetAV(S, 0)
        else
            gTarget.SetAV(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseIf result == 2
        Float newSkillValue = currentSkillValue - 1
        if newSkillValue < 0
            debug.Notification("Skill level cannot be lower than 0. Set to 0.")
            gTarget.SetAV(S, 0)
        else
            gTarget.SetAV(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseIf result == 3
        Float newSkillValue = currentSkillValue +1
        gTarget.SetAV(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseIf result == 4
        Float newSkillValue = currentSkillValue +5
        gTarget.SetAV(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseIf result == 5
        Float newSkillValue = currentSkillValue +10
        gTarget.SetAV(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_SkillModify(S, gTarget)
    elseIf result == 6
        String customSkillValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Skill Level:")
        if (customSkillValue as Int) > 0 
            Float newSkillValue = customSkillValue as Float
            gTarget.SetAV(S, newSkillValue)
            Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
            Proteus_SkillModify(S, gTarget)
        else
            Debug.Notification("Invalid skill level entered. Try again")
            Proteus_SkillModify(S, gTarget)
        endIf
    elseIf result == 7
        Proteus_NPCSkillsFunction(gTarget)
    endIf


endFunction




function Proteus_AttributeRegenModify(String S, Actor gTarget)

    string[] stringArray
    stringArray= new String[10]
    stringArray[0] = " -5 Regeneration"
    stringArray[1] = " -2 Regeneration"
    stringArray[2] = " -0.5 Regeneration"
    stringArray[3] = " -0.1 Regeneration"
    stringArray[4] = " +0.1 Regeneration"
    stringArray[5] = " +0.5 Regeneration"
    stringArray[6] = " +2 Regeneration"
    stringArray[7] = " +5 Regeneration"
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
        gTarget.SetAV(S, -5.00000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountChange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetAV(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseif result == 1
        gTarget.SetAV(S, -2.00000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountChange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetAV(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 2
        gTarget.SetAV(S, -0.500000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountchange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetAV(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 3
        gTarget.SetAV(S, -0.100000)
        if gTarget.GetBaseAV(S) < 0 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountchange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetAV(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 4
        gTarget.SetAV(S, 0.100000)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 5
        gTarget.SetAV(S, 0.500000)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 6
        gTarget.SetAV(S, 2 as Float)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 7
        gTarget.SetAV(S, 5 as Float)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_AttributeRegenModify(S, gTarget)
    elseIf result == 8
        Proteus_NPCAttributesFunction(gTarget)
    elseIf result == 9
    endIf
endFunction





function Proteus_NPCSkillSummaryFunction(Actor gTarget)
	UIStatsMenu statsMenu = UIExtensions.GetMenu("UIStatsMenu") as UIStatsMenu
	statsMenu.OpenMenu(gTarget)
endFunction











function Proteus_NPCResistanceFunction(Actor gTarget)
	
	string[] stringArray
	stringArray= new String[8]
	stringArray[0] = " Resist Fire"
	stringArray[1] = " Resist Frost"
	stringArray[2] = " Resist Shock"
	stringArray[3] = " Resist Poison"
	stringArray[4] = " Resist Disease"
	stringArray[5] = " Stat Summary"
	stringArray[6] = " Back"
	stringArray[7] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 8
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		Proteus_NPCResistanceModifyFunction("fireResist", gTarget)
	elseIf result == 1
		Proteus_NPCResistanceModifyFunction("frostResist", gTarget)
	elseIf result == 2
		Proteus_NPCResistanceModifyFunction("ElectricResist", gTarget)
	elseIf result == 3
		Proteus_NPCResistanceModifyFunction("poisonResist", gTarget)
	elseIf result == 4
		Proteus_NPCResistanceModifyFunction("diseaseResist", gTarget)
	elseIf result == 5
		Proteus_NPCSkillSummaryFunction(gTarget)
		Proteus_NPCResistanceFunction(gTarget)
	elseIf result == 6
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 7
	endIf
endFunction



function Proteus_NPCResistanceModifyFunction(String S, Actor gTarget)
    
    string[] stringArray
    stringArray= new String[7]
    stringArray[0] = " -25% Resistance"
    stringArray[1] = " -5% Resistance"
    stringArray[2] = " +5% Resistance"
    stringArray[3] = " +25% Resistance"
    stringArray[4] = " Maximum Resistance"
    stringArray[5] = " Back"
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

    If result == 0
        gTarget.SetAV(S, gTarget.GetBaseAV(S) - 25)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_NPCResistanceModifyFunction(S, gTarget)
    elseIf result == 1
        gTarget.SetAV(S, gTarget.GetBaseAV(S) - 5)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_NPCResistanceModifyFunction(S, gTarget)
    elseIf result == 2
        gTarget.SetAV(S, gTarget.GetBaseAV(S) + 5)
        If gTarget.GetBaseAV(S) > 100
            debug.Notification("Resistance cannot be greater than 100. Set to 100.")
            gTarget.SetAV(S, 100)
        endIf
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_NPCResistanceModifyFunction(S, gTarget)
    elseIf result == 3
        gTarget.SetAV(S, gTarget.GetBaseAV(S) + 25)
        If gTarget.GetBaseAV(S) > 100
            debug.Notification("Resistance cannot be greater than 100. Set to 100.")
            gTarget.SetAV(S, 100)
        endIf
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_NPCResistanceModifyFunction(S, gTarget)
    elseIf result == 4
        gTarget.SetAV(S, 100)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_NPCResistanceModifyFunction(S, gTarget)
    elseIf result == 5
        Proteus_NPCResistanceFunction(gTarget)
    endIf
endFunction








function Proteus_AIFunction(Actor gTarget)
	
	string[] stringArray
	stringArray= new String[6]
	stringArray[0] = " Aggression"
	stringArray[1] = " Assistance"
	stringArray[2] = " Confidence"
	stringArray[3] = " AI Summary"
	stringArray[4] = " Back"
	stringArray[5] = " Exit"


	UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenuBase
		int n = 6
		int i = 0
		while i < n
			listMenuBase.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenuBase.OpenMenu()
	int resultBase = listMenuBase.GetResultInt()

	if resultBase == 0
		stringArray= new String[6]
		stringArray[0] = " Unaggressive"
		stringArray[1] = " Aggressive (attacks enemies)"
		stringArray[2] = " Very Aggressive (attacks enemies/neutrals)"
		stringArray[3] = " Frenzied (attacks everyone)"	
		stringArray[4] = " Back"	
		stringArray[5] = " Exit"	

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 6
			int i = 0
			while i < n
				listMenu.AddEntryItem(stringArray[i])
				i += 1
			endwhile
		EndIf

		listMenu.OpenMenu()
		int result = listMenu.GetResultInt()

		if result == 0
			gTarget.SetAV("Aggression", 0 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now unaggressive.")
			Proteus_AIFunction(gTarget)
		elseIf result == 1
			gTarget.SetAV("Aggression", 1 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now aggressive.")
			Proteus_AIFunction(gTarget)
		elseIf result == 2
			gTarget.SetAV("Aggression", 2 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now very aggressive.")
			Proteus_AIFunction(gTarget)
		elseIf result == 3
			gTarget.SetAV("Aggression", 3 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now frenzied.")
			Proteus_AIFunction(gTarget)
		elseIf result == 4
			Proteus_AIFunction(gTarget)
		endIf
	elseIf resultBase == 1
		stringArray= new String[5]
		stringArray[0] = " Helps Nobody"
		stringArray[1] = " Helps Allies"
		stringArray[2] = " Helps Friends and Allies"
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
			gTarget.SetAV("Assistance", 0 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " now helps nobody.")
			Proteus_AIFunction(gTarget)
		elseIf result == 1
			gTarget.SetAV("Assistance", 1 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " now helps allies.")
			Proteus_AIFunction(gTarget)
		elseIf result == 2
			gTarget.SetAV("Assistance", 2 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " now helps friends and allies.")
			Proteus_AIFunction(gTarget)
		elseIf result == 3
			Proteus_AIFunction(gTarget)
		endIf

	elseIf resultBase == 2
		stringArray= new String[5]
		stringArray[0] = " Cowardly (always flee)"
		stringArray[1] = " Cautious"
		stringArray[2] = " Average"
		stringArray[3] = " Brave"	
		stringArray[4] = " Foolhardy (never flee)"	
		stringArray[5] = " Back"	
		stringArray[6] = " Exit"	

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
			gTarget.SetAV("Confidence", 0 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now cowardly.")
			Proteus_AIFunction(gTarget)
		elseIf result == 1
			gTarget.SetAV("Confidence", 1 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now cautious.")
			Proteus_AIFunction(gTarget)
		elseIf result == 2
			gTarget.SetAV("Confidence", 2 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now average.")
			Proteus_AIFunction(gTarget)
		elseIf result == 3
			gTarget.SetAV("Confidence", 3 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now brave.")
			Proteus_AIFunction(gTarget)
		elseIf result == 4
			gTarget.SetAV("Confidence", 4 as Float)
			debug.Notification(gTarget.GetBaseObject().GetName() + " is now foolhardy.")
			Proteus_AIFunction(gTarget)
		elseIf result == 5
			Proteus_AIFunction(gTarget)
		endIf

	elseIf resultBase == 3
		Proteus_AISummaryFunction(gTarget)
	elseIf resultBase == 4
		Proteus_NPCMainMenu(gTarget)
	endIf
endFunction






int function Proteus_SizeScaleFunction(Actor gTarget)
	Float size = gTarget.GetScale()

	string[] stringArray
	stringArray= new String[8]
	stringArray[0] = " -0.5 Size"
	stringArray[1] = " -0.1 Size"
	stringArray[2] = " +0.1 Size"
	stringArray[3] = " +0.5 Size"
	stringArray[4] = " Reset Size to 1"
	stringArray[5] = " Custom Size"
	stringArray[6] = " Back"
	stringArray[7] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 8
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		gTarget.SetScale(size - 0.5)
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 1
		gTarget.SetScale(size - 0.1)
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 2
		gTarget.SetScale(size + 0.1)
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 3
		gTarget.SetScale(size + 0.5)
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 4
		gTarget.SetScale(1 as Float)
		Proteus_SizeScaleFunction(gTarget)
	elseIf result == 5
		String customSizeValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Size: \nBase value is 1. Enter small adjustments like 0.99 or 1.01.")
		if (customSizeValue as Float) > 0 
			Float newAttributeValue = customSizeValue as Float
			gTarget.SetScale(newAttributeValue)
			Proteus_SizeScaleFunction(gTarget)
		else
			Debug.Notification("Invalid scale size entered. Try again")
			Proteus_SizeScaleFunction(gTarget)
		endIf
	elseIf result == 6
		Proteus_NPCMainMenu(gTarget)
	endIf
endFunction





function Proteus_MarriableFunction(Actor gTarget) 
	if gTarget.IsInFaction(PotentialMarriageFaction) == false
		gTarget.AddToFaction(PotentialMarriageFaction)
	endIf
	gTarget.SetRelationshipRank(Game.GetPlayer(), 4)
	debug.Notification(gTarget.GetBaseObject().GetName() + " should now be marriageable.")
	Proteus_NPCMainMenu(gTarget)
endFunction




function Proteus_RecruitableFunction(Actor gTarget)
	if gTarget.IsInFaction(PotentialFollowerFaction) == false
		gTarget.AddToFaction(PotentialFollowerFaction)
	endIf
	gTarget.SetRelationshipRank(game.GetPlayer(), 3)
	gTarget.SetAV("Aggression", 1 as Float)
	gTarget.SetAV("Confidence", 3 as Float)
	debug.Notification(gTarget.GetBaseObject().GetName() + " should now be recruitable.")
	Proteus_NPCMainMenu(gTarget)
endFunction






;Code for NPC appearance editor to work properly with overlays
int Function GetAllVisibleOverlays(Actor targetT)
    int totalVisible = 0
    If SKSE.GetPluginVersion("skee") >= 1 ; Checks to make sure the skee plugin exists
        totalVisible += GetVisibleOverlays(targetT, 256, "Body [Ovl", NiOverride.GetNumBodyOverlays())
        totalVisible += GetVisibleOverlays(targetT, 257, "Hands [Ovl", NiOverride.GetNumHandOverlays())
        totalVisible += GetVisibleOverlays(targetT, 258, "Feet [Ovl", NiOverride.GetNumFeetOverlays())
        totalVisible += GetVisibleOverlays(targetT, 259, "Face [Ovl", NiOverride.GetNumFaceOverlays())
    Endif
    return totalVisible
EndFunction

int Function GetVisibleOverlays(Actor targetT, int tintType, string tintTemplate, int tintCount)
    int i = 0
    int visible = 0
    ActorBase targetBase = targetT.GetActorBase()
    While i < tintCount
        string nodeName = tintTemplate + i + "]"
        float alpha = 0
        string texture = ""
        If NetImmerse.HasNode(targetT, nodeName, false) ; Actor has the node, get the immediate property
            alpha = NiOverride.GetNodePropertyFloat(targetT, false, nodeName, 8, -1)
            texture = NiOverride.GetNodePropertyString(targetT, false, nodeName, 9, 0)
        Else ; Doesn't have the node, get it from the override
            bool isFemale = targetBase.GetSex() as bool
            alpha = NiOverride.GetNodeOverrideFloat(targetT, isFemale, nodeName, 8, -1)
            texture = NiOverride.GetNodeOverrideString(targetT, isFemale, nodeName, 9, 0)
        Endif
        If texture == ""
            texture = "Actors\\Character\\Overlays\\Default.dds"
        Endif
        If texture != "Actors\\Character\\Overlays\\Default.dds" && alpha > 0.0
            visible += 1
        Endif
        i += 1
    EndWhile
    return visible
EndFunction



Function Proteus_EditNPCAppearance(Actor gTarget)
	string[] stringArray
	stringArray= new String[6]
	stringArray[0] = " Cosmetic Menu"
	stringArray[1] = " Preset Menu"
	stringArray[2] = " Copy NPC Appearance to Player"
	stringArray[3] = " Change NPC Hair Color (Temporary)" 
	stringArray[4] = " Back"
	stringArray[5] = " Exit"	

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 6
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	if result == 0
		If SKSE.GetPluginVersion("skee") >= 1
			If !NiOverride.HasOverlays(gTarget)
				NiOverride.AddOverlays(gTarget)
			Endif
		Endif

		UICosmeticMenu cosMenu = UIExtensions.GetMenu("UICosmeticMenu") as UICosmeticMenu
		cosMenu.SetPropertyInt("categories", 0x7E)
		cosMenu.OpenMenu(gTarget)

    		If SKSE.GetPluginVersion("skee") >= 1
        		If GetAllVisibleOverlays(gTarget) == 0
           	 		NiOverride.RemoveOverlays(gTarget)
        		Endif
    		Endif
	elseif result == 1
		Proteus_PresetFunction(gTarget)
	elseif result == 2 ;copy NPC appearance
		Game.SetHudCartMode()
		Game.DisablePlayerControls(true,true,true,true,true, true, true, true)
		Game.ForceFirstPerson()
		Proteus_CopyNPCAppearance(gTarget)
		Utility.Wait(0.1)
		Proteus_CopyNPCAppearance(gTarget)
		Game.SetHudCartMode(false)
		Game.EnablePlayerControls()
		Debug.MessageBox("Copy Complete.")
	elseif result == 3
		Proteus_NPCChangeHairColor(gTarget)
	elseIf result == 4
		Proteus_NPCMainMenu(gTarget)
	Endif
EndFunction



Function Proteus_CopyNPCAppearance(Actor gTarget)
	Actor player = Game.GetPlayer()

	;attempt to clear current player appearance / half of this probably does nothing...
	NIOverride.RevertHeadOverlays(player)
	NIOverride.ClearMorphs(player)
	NIOverride.RemoveAllReferenceSkinOverrides(player)
	NIOverride.RemoveAllReferenceOverrides(player)
	CharGen.ClearPreset(player.GetActorBase())
	CharGen.DeleteFaceGenData(player.GetActorBase())

	;set up player and target variables
	Race playerRace = player.GetRace()
	Race targetRace = gTarget.GetRace()
	RaceMenu rcMenu = Game.GetFormFromFile(0x800, "RaceMenu.esp") as RaceMenu
	ActorBase playerBase = player.GetActorBase()
	ActorBase targetBase = gTarget.GetActorBase()

	If rcMenu && playerBase && targetBase
		player.ChangeHeadPart(Game.GetFormFromFile(0x000F5009, "Skyrim.esm") as HeadPart) ;remove beard
		;swap genders if necessary
		if(targetBase.GetSex() == 0 && playerBase.GetSex() == 1)
			player.SetRace(argonianRace) ;helps clearup racemenu / body & face mismatches
			player.SetRace(khajitRace)
			SetSelectedReference(player)
			ExecuteCommand("sexchange")
			Utility.Wait(0.2)
		elseif(targetBase.GetSex() == 1 && playerBase.GetSex() == 0)
			player.SetRace(argonianRace) ;helps clearup racemenu / body & face mismatches
			player.SetRace(khajitRace)
			SetSelectedReference(player)
			ExecuteCommand("sexchange")
			Utility.Wait(0.2)
		else
			player.SetRace(argonianRace) ;helps clearup racemenu / body & face mismatches
			player.SetRace(khajitRace)
			SetSelectedReference(player)
			ExecuteCommand("sexchange")
			Utility.Wait(0.1)
			ExecuteCommand("sexchange")
		EndIf

		player.SetRace(argonianRace)
		Utility.Wait(0.1)
		player.SetRace(targetRace)
		player.SetRace(khajitRace)
		Utility.Wait(0.1)
		player.SetRace(targetRace)

		;scale, height, weight
		Float scaleActor = gTarget.GetScale()
		player.SetScale(scaleActor)
		Float height = targetBase.GetHeight()
		FLoat weight = targetBase.GetWeight()
		playerBase.SetHeight(height)
		playerBase.SetWeight(weight)
		player.UpdateWeight(weight)

		int totalPresets = rcMenu.MAX_PRESETS
		int i = 0
		While i < totalPresets
			playerBase.SetFacePreset(targetBase.GetFacePreset(i), i)
			i += 1
		EndWhile

		int totalMorphs = rcMenu.MAX_MORPHS
		i = 0
		While i < totalMorphs
			playerBase.SetFaceMorph(targetBase.GetFaceMorph(i), i)
			i += 1
		EndWhile

		HeadPart targetHead
		HeadPart targetEyes
		HeadPart targetHair
		HeadPart targetFacialHair
		HeadPart targetMouth
		HeadPart targetScar
		HeadPart targetBrows

		;apply target head parts to player
		int totalHeadPartsTarget = targetBase.GetNumHeadParts()
		int totalHeadPartsPlayer = playerBase.GetNumHeadParts()
		i = 0
		While i < totalHeadPartsTarget
			HeadPart current = targetBase.GetNthHeadPart(i)
			HeadPart old = playerBase.GetNthHeadPart(i)

			If current.GetType() == 0 ;Mouth
				targetMouth = current
			ElseIf current.GetType() == 1 ;Head
				targetHead = current
			Elseif current.GetType() == 2 ; Eyes
				targetEyes = current
			Elseif current.GetType() == 3 ; Hair
				targetHair = current
			Elseif current.GetType() == 4 ; FacialHair
				targetFacialHair = current
			Elseif current.GetType() == 5 ; Scar
				targetScar = current
			Elseif current.GetType() == 6 ; Brows
				targetBrows = current
			Endif
			i += 1
			;Debug.MessageBox(current.GetName())
		EndWhile
		

		playerRace = player.GetRace()
		String playerRaceName = playerRace.GetName()
		Int indexDZ = stringutil.Find(playerRace, "DZ", 0) ;COTR search

		;Utility.Wait(0.1)
		;figure out head part
		if(playerRaceName == "Argonian" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(0) as HeadPart) ;argonian female
		elseif(playerRaceName == "Argonian" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(24) as HeadPart) ;argonian male

		elseif(playerRaceName == "Nord" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(12) as HeadPart) ;nord female
		elseif(playerRaceName == "Nord" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(40) as HeadPart) ;nord male

		elseif(playerRaceName == "Imperial" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(9) as HeadPart) ;imperial female
		elseif(playerRaceName == "Imperial" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(36) as HeadPart) ;imperial male

		elseif(playerRaceName == "Breton" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(1) as HeadPart) ;breton female
		elseif(playerRaceName == "Breton" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(25) as HeadPart) ;breton male

		elseif(playerRaceName == "Dark Elf" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(3) as HeadPart) ;dark elf female
		elseif(playerRaceName == "Dark Elf" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(29) as HeadPart) ;dark elf male

		elseif(playerRaceName == "High Elf" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(7) as HeadPart) ;high elf female
		elseif(playerRaceName == "High Elf" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(33) as HeadPart) ;high elf male

		elseif(playerRaceName == "Wood Elf" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(20) as HeadPart) ;wood elf female
		elseif(playerRaceName == "Wood Elf" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(46) as HeadPart) ;wood elf male

		elseif(playerRaceName == "Khajiit" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(11) as HeadPart) ;Khajiit female
		elseif(playerRaceName == "Khajiit" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(38) as HeadPart) ;Khajiit male

		elseif(playerRaceName == "Orc" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(16) as HeadPart) ;orc female
		elseif(playerRaceName == "Orc" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(42) as HeadPart) ;orc male

		elseif(playerRaceName == "Redguard" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(18) as HeadPart) ;Redguard female
		elseif(playerRaceName == "Redguard" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(44) as HeadPart) ;Redguard male

		elseif(playerRaceName == "Old People Race" && playerBase.GetSex() == 1) 
			player.ChangeHeadPart(headPartsList.GetAt(6) as HeadPart) ;elder female
		elseif(playerRaceName == "Old People Race" && playerBase.GetSex() == 0) 
			player.ChangeHeadPart(headPartsList.GetAt(32) as HeadPart) ;elder male

		elseif(indexDZ >= 0 && playerBase.GetSex() == 1)
			;Debug.MessageBox("COTR FEMALE RAN")
			HeadPart cotrPart = Game.GetFormFromFile(0x0144EA, "COR_AllRace.esp") as HeadPart ;COTR female
			player.ChangeHeadPart(cotrPart)
		elseif(indexDZ >= 0 && playerBase.GetSex() == 0)
			;Debug.MessageBox("COTR MALE RAN")
			HeadPart cotrPart = Game.GetFormFromFile(0x05512D, "COR_AllRace.esp") as HeadPart ;COTR male
			player.ChangeHeadPart(cotrPart)

		elseif playerBase.GetSex() == 1
			player.ChangeHeadPart(headPartsList.GetAt(12) as HeadPart) ;nord female
		elseif playerBase.GetSex() == 0
			player.ChangeHeadPart(headPartsList.GetAt(40) as HeadPart) ;nord male
		endIf

		Utility.Wait(0.1)
		player.ChangeHeadPart(targetMouth)
		player.ChangeHeadPart(targetEyes)
		player.ChangeHeadPart(targetScar)
		player.ChangeHeadPart(targetFacialHair)
		player.ChangeHeadPart(targetHair)
		player.ChangeHeadPart(targetBrows)

		;(player.GetActorBase()).SetNthHeadPart(targetMouth,i )
		;Debug.Notification("MaxPresets:" + totalPresets + " MaxMorphs:" + totalMorphs + " TotalHeadParts:" + totalHeadPartsTarget)

		;face and skin textures
		playerBase.SetFaceTextureSet(targetBase.GetFaceTextureSet())
		playerBase.SetSkin(targetBase.GetSkin())
		playerBase.SetSkinFar(targetBase.GetSkinFar())

		;hair color
		playerBase.SetHairColor(targetBase.GetHairColor())
		rcMenu.SaveHair()
		Utility.Wait(0.1)
		player.QueueNiNodeUpdate()
		playerBase.SetHairColor(targetBase.GetHairColor())
    Endif
endFunction



Function Proteus_PresetFunction(Actor gTarget)
	
	string[] stringArray
	stringArray= new String[5]
	stringArray[0] = " Save Player Appearance as Preset"
	stringArray[1] = " Load Preset on NPC"
	stringArray[2] = " Back"
	stringArray[3] = " Main Menu"
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
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character appearance as?")
		Proteus_SaveNPCAppearanceFunction(presetName, Game.GetPlayer())
		Proteus_PresetFunction(gTarget)
	elseif result == 1 
		Proteus_LoadCharacterAppearanceFunction(gTarget)
	elseif result == 2
		Proteus_EditNPCAppearance(gTarget)
	elseif result == 3		
		Proteus_NPCMainMenu(gTarget)
	elseif result == 4
	endIf
endFunction


Function Proteus_NPCChangeHairColor(Actor gTarget)
	Debug.Notification("Hair Color menu loading...may take a few seconds!")
	String[] stringArray = new String[125]
	Form[] hairArray = new Form[125]
	int k = 0
	while k < hairColorList.GetSize()
		Form temp = hairColorList.GetAt(k)
		hairArray[k] = temp
		stringArray[k] = " " + temp.GetName()
		k+=1
	endWhile
	UIListMenu listMenuHair = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	listMenuHair.AddEntryItem("Quit")
	int i
	if listMenuHair
		int n = k+1
		i = 0
		while i < n
		listMenuHair.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenuHair.OpenMenu()
	int result = listMenuHair.GetResultInt()

	if result > 0 && result <= 130
		int numR = result - 1
		ColorForm hairColorT = hairColorList.GetAt(numR) as ColorForm
		SetHairColor(gTarget, hairColorT)
		gTarget.QueueNiNodeUpdate()
		SetHairColor(gTarget, hairColorT)
		;Debug.MessageBox("ColorName:" + (hairColorList.GetAt(numR) as ColorForm).GetName())
	else
	endIf

endFunction
	

function Proteus_SaveNPCAppearanceFunction(String presetName, Actor gTarget)
	Int lengthInt = stringutil.GetLength(presetName)
	if lengthInt > 0
		Proteus_SaveCharacterAppearance(presetName, gTarget)
		debug.Notification(gTarget.GetDisplayName() + " appearance saved into Proteus system.")
	else
		debug.Notification("Invalid character name.")
	endIf
endFunction

function Proteus_SaveCharacterAppearance(String name, Actor target)
	;saves appearance of the player character
	Proteus_SavePlayerRace(target, name)
	SaveCharacter(name)
	SaveCharacterPreset(target, name)
	debug.Notification(target.GetDisplayName() + " appearance saved into Proteus system.")
endFunction

function Proteus_SavePlayerRace(Actor target, String presetName) global
	Int jRaceList
	Int jRaceForms = jmap.object()
	String raceFormKey = jmap.nextKey(jRaceList, "", "")
	
	Race value = target.GetRace()
	;Debug.MessageBox("Saved race Name: " + value.GetName())
	jmap.SetForm(jRaceForms, "Race", value as form)
	jvalue.writeToFile(jRaceForms, jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
	debug.Notification(target.GetDisplayName() + " race saved into the Proteus system.")
endFunction


function Proteus_LoadCharacterAppearanceFunction(Actor gTarget)

	String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player appearance preset?")	
	Int lengthPresetName = StringUtil.GetLength(presetName as String)

	if(lengthPresetName > 0)
		Race presetRace = Proteus_LoadCharacterRace(presetName)
		Proteus_NPCLoadTargetStrings(presetName, gTarget, 1)
		Proteus_LoadCharacterAppearance(presetName, gTarget, gTarget.GetRace(), presetRace)

		;save into Proteus system to load across all saves
		String NPCName = gTarget.GetActorBase().GetName()
		String processedNPCName = processName(NPCName)
		Proteus_JSave_NPCForms(gTarget, processedNPCName, presetName)		

		Debug.Notification(presetName + " appearance preset was loaded onto " + gTarget.GetDisplayName())
	else
		Debug.Notification("Invalid character name.")
	endIf
	Proteus_PresetFunction(gTarget)
endFunction

Race Function Proteus_LoadCharacterRace(String presetName)
	Race presetRace
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
		Int JRaceList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
		Int jStats = jmap.object()
		String raceForm = jmap.nextKey(JRaceList , "", "")

		Race value = jmap.GetForm(JRaceList, raceForm, none) as Race
		if raceForm == "race"
			presetRace = value
		EndIf
	else
		debug.Notification("Name not found in Proteus system.")
	EndIf
	return presetRace
endFunction

Function Proteus_LoadCharacterAppearance(String presetName, Actor target, Race currentRace, Race presetRace)
		if(presetRace == currentRace)
			ColorForm colorHair = target.GetActorBase().GetHairColor()	
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
			Utility.Wait(0.1)
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
		else
			target.SetRace(presetRace)
			Utility.Wait(0.2)
			ColorForm colorHair = target.GetActorBase().GetHairColor()
			LoadCharacterPreset(target, presetName, colorHair)
			LoadCharacter(target, presetRace, presetName)
			Utility.Wait(0.2)	
			target.SetRace(currentRace)
			Utility.Wait(0.2)
			target.SetRace(presetRace)
			Utility.Wait(0.2)
			LoadCharacterPreset(target, presetName, colorHair) 
			LoadCharacter(target, presetRace, presetName)
		endIf			
		debug.Notification(presetName + " appearance loaded from Proteus system.")
endFunction

;Checks if this world has a number assigned to it, if not assigns one
function WorldIdentityFunction()	
	if(ZZNPCAppearanceSaved.GetValue() == 0)
		int i = 1
		bool setVal = false
		while i < 1000 && setVal == false
			if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + i + ".json"))
			else
				setVal = true
				ZZNPCAppearanceSaved.SetValue(i)
			endIf
			i+=1
		endWhile
	endIf
endFunction


;saves the actor form id to ProteusN_M1 file (only needed if NPC preset to be used across all saved game characters/playthroughs
function Proteus_JSave_NPCForms(Actor targetName, String processedNPCName, String presetName)
	Int jNPCFormList

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
	endIf

	Int jNFormNames = jmap.object()
	String NPCFormKey = jmap.nextKey(jNPCFormList, "", "")
	Bool insertNewNPC = true
	int i = 0
	while NPCFormKey
		Actor value = jmap.GetForm(jNPCFormList,NPCFormKey, none) as Actor
		if value == targetName
			insertNewNPC = false
			jmap.SetForm(jNFormNames, i + "_ProteusNPC_" + processedNPCName, value as form)
		else
			jmap.SetForm(jNFormNames, NPCFormKey, value as form)
		endIf
		i+=1
		NPCFormKey = jmap.nextKey(jNPCFormList, NPCFormKey, "")
	endWhile
	if insertNewNPC == true
		jmap.SetForm(jNFormNames, i + "_ProteusNPC_" + processedNPCName, targetName as form)
	endIf

	jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")

	Proteus_JSave_NPCPresetNames(targetName, processedNPCName, presetName)
endFunction

;saves the actor's preset name to a ProteusN_M2 file
function Proteus_JSave_NPCPresetNames(Actor targetName, String processedNPCName, String presetName)
	Int jNPCList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_NPC_GeneralInfo_Template.json")
	Int jNStats = jmap.object()
	Int maxCount = jvalue.Count(jNPCList)
	Int j = 0
	while j < maxCount
		String value
		String stat = jarray.getStr(jNPCList, j, "")
		if j == 0
			value = presetName
		EndIf
		j += 1
		jmap.SetStr(jNStats, stat, value)
	endWhile

	jvalue.writeToFile(jNStats, jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
	debug.Notification(targetName.GetDisplayName() + " form/preset saved into the Proteus system.")
endFunction





Function Proteus_SaveNPCVoiceType(Actor targetName, String processedNPCName)
	;also save voice type
	;Int jVTList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_NPC_GeneralInfo_Template.json")
	Int jVTList
    Int JVT = jmap.object()
    jmap.SetForm(JVT, "VT", targetName.GetVoiceType())
    jvalue.writeToFile(JVT, jcontainers.userDirectory() + "/Proteus/Proteus_Character_VT_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")

	Int lengthProcessedName = StringUtil.GetLength(processedNPCName)
	String targetPresetName
	if (lengthProcessedName > 0)
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json"))
			Int JNPCList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
			Int jStats = jmap.object()
			String stat = jmap.nextKey(JNPCList, "", "")
			String value = jmap.GetStr(JNPCList, stat, "")
			if stat == "name"
				targetPresetName = value
				;Debug.MessageBox("Found Target Preset Name: " + value)
			endIf
			stat = jmap.nextKey(JNPCList, stat, "")
			value = jmap.GetStr(JNPCList, stat, "")
			if stat == "name"
				targetPresetName = value
				;Debug.MessageBox("Found Target Preset Name: " + value)
			endIf
		EndIf
	endIf

	Int lengthPresetName = StringUtil.GetLength(targetPresetName)
	if(lengthPresetName > 0)
		Proteus_JSave_NPCForms(targetName, processedNPCName, targetPresetName)	
	else
		Proteus_JSave_NPCForms(targetName, processedNPCName, "")	
	endIf
endFunction


function Proteus_SaveNPCPlayableCharacter(Actor gTarget)
	String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save NPC character as:")	
	Int lengthPresetName = StringUtil.GetLength(presetName as String)

	if(lengthPresetName > 0)
		Proteus_SaveNPCAppearanceFunction(presetName, gTarget)
	endIf

endFunction



;postTargetAcquire (0 = spawned character, 1 = load appearance preset, 2 = swap characters)
function Proteus_NPCLoadTargetStrings(String presetName, Actor target, int postTargetAcquire)
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusCGeneral_M2_" + presetName + ".json"))
		Int JStringList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusCGeneral_M2_" + presetName + ".json")
		Int maxCount = jvalue.Count(JStringList )

		Int jStats = jmap.object()
		Int i = 0
		String text = jmap.nextKey(JStringList, "", "")

		while i < maxCount
			String value = jmap.GetStr(JStringList, text, "")
			if text == "name"
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
			elseif text == "CarryWeight"
			EndIf
			text = jmap.nextKey(JStringList, text, "")
			i += 1
		endWhile
		;debug.Notification("Name loaded from the Proteus system.")
	else
		;debug.Notification("Name not found in Proteus system.")
	EndIf
endFunction



Function Proteus_NPCTakeControlFunction(Actor target)
	NPCControlSpell.Cast(target, target)
EndFunction









function Proteus_NPCLevelFunction(Actor gTarget)

	string[] stringArray = new String[10]
	stringArray[0] = " Set to Player's Level"
	stringArray[1] = " Level 1"
	stringArray[2] = " Level -10"
	stringArray[3] = " Level -1"
	stringArray[4] = " Level +1"
	stringArray[5] = " Level +10"
	stringArray[6] = " Level 100"
	stringArray[7] = " Custom Level"
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
		Int playerLevel = Game.GetPlayer().GetLevel()
		SetSelectedReference(gTarget)
		ExecuteCommand("setlevel " + playerLevel as Int)
		Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
	elseIf result == 1
		SetSelectedReference(gTarget)
		ExecuteCommand("setlevel 1")
		Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
	elseIf result == 2
		int amount = gTarget.GetLevel() - 10
		if(amount > 0)
			SetSelectedReference(gTarget)
			ExecuteCommand("setlevel " + amount)
			Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
		else
			SetSelectedReference(gTarget)
			ExecuteCommand("setlevel 1")
			Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
		endIf
	elseIf result == 3
		int amount = gTarget.GetLevel() - 1
		if(amount > 0)
			SetSelectedReference(gTarget)
			ExecuteCommand("setlevel " + amount)
			Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
		else
			SetSelectedReference(gTarget)
			ExecuteCommand("setlevel 1")
			Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
		endIf
	elseIf result == 4
		int amount = gTarget.GetLevel() + 1
		SetSelectedReference(gTarget)
		ExecuteCommand("setlevel " + amount)
		Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
	elseIf result == 5
		int amount = gTarget.GetLevel() + 10
		SetSelectedReference(gTarget)
		ExecuteCommand("setlevel " + amount)
		Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
	elseIf result == 6
		SetSelectedReference(gTarget)
		ExecuteCommand("setlevel 100")
		Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
	elseIf result == 7
		String customAttributeValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Level of NPC:")
		if (customAttributeValue as Int) > 0 
			Int newAttributeValue = customAttributeValue as Int
			SetSelectedReference(gTarget)
			ExecuteCommand("setlevel " + newAttributeValue)
			Debug.Notification("NPC level is now " +  Proteus_Round(gTarget.GetLevel() , 0))
		else
			Debug.Notification("Invalid level entered. Try again")
			Proteus_NPCLevelFunction(gTarget)
		endIf
	elseIf result == 7
		Proteus_NPCMainMenu(gTarget)
	elseIf result == 8
	endIf
endFunction



;remove NPC 
function Proteus_ClearNPCEdits(Actor targetName)
	String NPCName = targetName.GetActorBase().GetName()
	String processedNPCName = processName(NPCName)

	Int jNPCFormList
	jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")


	Int jNFormNames = jmap.object()
	String NPCFormKey = jmap.nextKey(jNPCFormList, "", "")
	Bool insertNewNPC = true
	int i = 0
	while NPCFormKey
		Actor value = jmap.GetForm(jNPCFormList,NPCFormKey, none) as Actor
		if value == targetName
		else
			jmap.SetForm(jNFormNames, NPCFormKey, value as form)
		endIf
		i+=1
		NPCFormKey = jmap.nextKey(jNPCFormList, NPCFormKey, "")
	endWhile

	;write file with removed NPC form
	jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")


	;delete file with preset name for this NPC
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
	endIf

	;delete voice file with preset name for this NPC
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_VT_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_VT_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
	endIf

	ClearPreset(targetName.GetActorBase())
	DeleteFaceGenData(targetName.GetActorBase())

	if IsFormInMod(targetName, "PROTEUS.esp") == true
		targetName.GetActorBase().SetName("Unused Slot")
		targetName.MoveTo(voidMarker)
	endIf


	debug.Notification(processedNPCName + " edits removed from the Proteus system.")
endFunction


































Function Teleporter(Actor gTarget)
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
		(teleportLocationsList.GetAt(numR) as Spell).Cast(gTarget, gTarget)
	else
	endIf
endFunction


Function LevelScaler(Actor target)
	Utility.Wait(0.1)
    Debug.MessageBox("Select which previously saved Proteus preset you would like to scale the NPC to.")
    Utility.Wait(0.1)
    ;figure out which preset to use
    String presetName = Proteus_SelectPreset()

    ;initial variable setup
    Int totalSkills = 0
    Int totalAttributes = 0
    Int levelPreset = 0
    int skillDiff = 0
    int attributeDiff = 0
    int skillCurrentTotal = 0
    int attributeCurrentTotal = 0
    Bool ran = false

    ;get skills and attributes of selected preset
    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusCSKILLS_M1_" + presetName + ".json"))
        ran = true
        Int jSkillList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusCSKILLS_M1_" + presetName + ".json")
        Int jSkills = jmap.object()
        String skillForm = jmap.nextKey(jSkillList, "", "")
        Int maxCount = jvalue.Count(jSkillList)
        Int j = 0
        String stat = jmap.nextKey(JSkillList, "", "")
        while j < maxCount
            String value = jmap.GetStr(jSkillList , stat, "")
            if stat == "Alchemy"
                totalSkills += value as Int 
            elseIf stat == "Alteration"
                totalSkills += value as Int 
            elseIf stat == "Marksman"
                totalSkills += value as Int 
            elseIf stat == "Block"
                totalSkills += value as Int  
            elseIf stat == "Conjuration"
                totalSkills += value as Int 
            elseIf stat == "Destruction"
                totalSkills += value as Int  
            elseIf stat == "Enchanting"
                totalSkills += value as Int 
            elseIf stat == "HeavyArmor"
                totalSkills += value as Int 
            elseIf stat == "Illusion"
                totalSkills += value as Int 
            elseIf stat == "LightArmor"
                totalSkills += value as Int  
            elseIf stat == "Lockpicking"
                totalSkills += value as Int 
            elseIf stat == "OneHanded"
                totalSkills += value as Int 
            elseIf stat == "PickPocket"
                totalSkills += value as Int 
            elseIf stat == "Restoration"
                totalSkills += value as Int 
            elseIf stat == "Smithing"
                totalSkills += value as Int  
            elseIf stat == "Sneak"
                totalSkills += value as Int 
            elseIf stat == "Speechcraft"
                totalSkills += value as Int  
            elseIf stat == "Twohanded"
                totalSkills += value as Int 
            elseIf stat == "Health"
                totalAttributes += value as Int 
            elseIf stat == "Magicka"
                totalAttributes += value as Int 
            elseIf stat == "Stamina"
                totalAttributes += value as Int  
            elseIf stat == "Level"
                levelPreset = value as Int
            elseIf stat == "Name"
            elseIf stat == "Experience"
            elseIf stat == "ZPerkPoints"
            endIf
            stat = jmap.nextKey(JSkillList, stat, "")
            j += 1
        endWhile
    endIf

    ;figure out the skill/attribute differences between selected preset and target
    if ran == true
		
        int levelDiff = levelPreset - target.GetLevel()
		Utility.Wait(0.1)
		if(levelDiff > 0)
			SetSelectedReference(target)
			ExecuteCommand("setlevel " + levelPreset)
			Debug.MessageBox(target.GetActorBase().GetName() + " is now level " + levelPreset as Int + ".")
        else
            Debug.MessageBox("Level scaler only works when used on a character with a lower level than that of the selected character.")
        endIf
    endIf
    ;Debug.MessageBox("Player \nSkills"+totalSkills + "\nAttrib" + totalAttributes + "\nSkillDiff"+skillDiff + "\nAttribDiff"+attributeDiff)
endFunction



String Function Proteus_SelectPreset()
	presetsLoaded = new String[100]
    Int jPLAYERPRESETFormList
    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
        jPLAYERPRESETFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
    endIf

	Int jNFormNames = jmap.object()
    String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
    int i = 0
    String value
    while PLAYERPRESETFormKey
        value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
        presetsLoaded[i] = value
        i+=1
        PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
    endWhile

	string[] stringArray = new String[100]
	int k = 0
	while StringUtil.GetLength(presetsLoaded[k]) > 0
		stringArray[k] = presetsLoaded[k]
		k+=1
	endWhile
	stringArray[k] = " Enter Name"
	k+=1
	stringArray[k] = " Back"
	k+=1
	stringArray[k] = " Exit"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = k+1
		i = 0
		while i < n
			;Debug.Notification("Adding List Item: " + stringArray[i])
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int customOption = k - 2
	int backOption = k - 1
	int exitOption = k
	;Debug.Notification("TempName " + itemNameTemp + " Result " + result + " VoE" + vieworedit)

	if (result == backOption || result == exitOption)
		Debug.Notification("No preset selected.")
		return ""
	elseif(result == customOption)
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Enter character name:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			return presetName
		else
			;Debug.Notification("Invalid preset name entered.")
			return ""
		endIf
	else
		return stringArray[result]
	endIf
endFunction




function Proteus_SaveSkillsAttributes(String presetName, Actor target)

	Int jSkillList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Character_Skills_Template.json")
	Int jSkills = jmap.object()
	Int maxCount = jvalue.Count(jSkillList)
	Int j = 0
	while j < maxCount
		String value
		String stat = jarray.getStr(jSkillList, j, "")
		if j == 0
			value = target.GetBaseActorValue("Alchemy")
		elseIf j == 1
			value = target.GetBaseActorValue("Alteration")
		elseIf j == 2
			value = target.GetBaseActorValue("Marksman")
		elseIf j == 3
			value = target.GetBaseActorValue("Block")
		elseIf j == 4
			value = target.GetBaseActorValue("Conjuration")
		elseIf j == 5
			value = target.GetBaseActorValue("Destruction")
		elseIf j == 6
			value = target.GetBaseActorValue("Enchanting")
		elseIf j == 7
			value = target.GetBaseActorValue("HeavyArmor")
		elseIf j == 8
			value = target.GetBaseActorValue("Illusion")
		elseIf j == 9
			value = target.GetBaseActorValue("LightArmor")
		elseIf j == 10
			value = target.GetBaseActorValue("Lockpicking")
		elseIf j == 11
			value = target.GetBaseActorValue("OneHanded")
		elseIf j == 12
			value = target.GetBaseActorValue("Pickpocket")
		elseIf j == 13
			value = target.GetBaseActorValue("Restoration")
		elseIf j == 14
			value = target.GetBaseActorValue("Smithing")
		elseIf j == 15
			value = target.GetBaseActorValue("Sneak")
		elseIf j == 16
			value = target.GetBaseActorValue("Speechcraft")
		elseIf j == 17
			value = target.GetBaseActorValue("TwoHanded")
		elseIf j == 18
			value = target.GetBaseActorValue("Health")
		elseIf j == 19
			value = target.GetBaseActorValue("Magicka")
		elseIf j == 20
			value = target.GetBaseActorValue("Stamina")
		elseIf j == 21
			value = target.GetLevel()
		elseIf j == 22
			value = target.GetActorBase().GetName()
		elseIf j == 23
			value = Game.GetPlayerExperience()
		elseif j == 24
			value = ActorValueInfo.GetActorValueInfoByName("Alchemy").GetSkillExperience()
		elseIf j == 25
			value = ActorValueInfo.GetActorValueInfoByName("Alteration").GetSkillExperience()
		elseIf j == 26
			value = ActorValueInfo.GetActorValueInfoByName("Marksman").GetSkillExperience()
		elseIf j == 27
			value = ActorValueInfo.GetActorValueInfoByName("Block").GetSkillExperience()
		elseIf j == 28
			value = ActorValueInfo.GetActorValueInfoByName("Conjuration").GetSkillExperience()
		elseIf j == 29
			value = ActorValueInfo.GetActorValueInfoByName("Destruction").GetSkillExperience()
		elseIf j == 30
			value = ActorValueInfo.GetActorValueInfoByName("Enchanting").GetSkillExperience()
		elseIf j == 31
			value = ActorValueInfo.GetActorValueInfoByName("HeavyArmor").GetSkillExperience()
		elseIf j == 32
			value = ActorValueInfo.GetActorValueInfoByName("Illusion").GetSkillExperience()
		elseIf j == 33
			value = ActorValueInfo.GetActorValueInfoByName("LightArmor").GetSkillExperience()
		elseIf j == 34
			value = ActorValueInfo.GetActorValueInfoByName("Lockpicking").GetSkillExperience()
		elseIf j == 35
			value = ActorValueInfo.GetActorValueInfoByName("OneHanded").GetSkillExperience()
		elseIf j == 36
			value = ActorValueInfo.GetActorValueInfoByName("Pickpocket").GetSkillExperience()
		elseIf j == 37
			value = ActorValueInfo.GetActorValueInfoByName("Restoration").GetSkillExperience()
		elseIf j == 38
			value = ActorValueInfo.GetActorValueInfoByName("Smithing").GetSkillExperience()
		elseIf j == 39
			value = ActorValueInfo.GetActorValueInfoByName("Sneak").GetSkillExperience()
		elseIf j == 40
			value = ActorValueInfo.GetActorValueInfoByName("Speechcraft").GetSkillExperience()
		elseIf j == 41
			value = ActorValueInfo.GetActorValueInfoByName("TwoHanded").GetSkillExperience()
		elseIf j == 42
			value = Game.GetPerkPoints()
		endIf
		j += 1
		jmap.SetStr(jSkills, stat, value)

	endWhile
	jvalue.writeToFile(jSkills, jcontainers.userDirectory() + "/Proteus/ProteusCSkills_M1_" + presetName + ".json")


	;CUSTOM SKILLS FRAMEWORK SAVE
	Int jCustomSkillsList
    Int jCustomSkillsForms = jmap.object()    
    String jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, "", "")
    
	if(glenmorilPerksActive == TRUE)
		GlobalVariable glenmorilLevel = Game.GetFormFromFile(0x001D62, "Perk-Glenmoril.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "GlenmorilLevel", glenmorilLevel.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf

	if(vigilantPerksActive == TRUE)
		GlobalVariable VigilantLevel = Game.GetFormFromFile(0x002D64, "Perk-Vigilant.esp") as GlobalVariable
        jmap.SetStr(jCustomSkillsForms, "VigilantLevel", VigilantLevel.GetValue())
        jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf
	
	if(haemophiliaActive == TRUE)
		GlobalVariable vampirismLevel = Game.GetFormFromFile(0x00081C, "Haemophilia.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "VampirismLevel", vampirismLevel.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf	

	if(handtohandActive == TRUE)
		GlobalVariable handtohandLevel = Game.GetFormFromFile(0x000D61, "Perk-HandToHand.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "HandToHandLevel", handtohandLevel.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
		GlobalVariable handtohandPerkPoints = Game.GetFormFromFile(0x000D65, "Perk-HandToHand.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "HandToHandPerkPoints", handtohandPerkPoints.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf	

	if(unarmouredDefenseActive == TRUE)
		GlobalVariable unarmouredDefenseLevel = Game.GetFormFromFile(0x000D61, "Perk-Unarmoured.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "UnarmouredDefenseLevel", unarmouredDefenseLevel.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
		GlobalVariable unarmouredDefensePerkPoints = Game.GetFormFromFile(0x000D65, "Perk-Unarmoured.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "UnarmouredDefensePerkPoints", unarmouredDefensePerkPoints.GetValue())
		jCustomSkillsKey = jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf	

	if(dragonbornCustomPerkActive == TRUE)
		GlobalVariable DragonbornCustomPerksLevel = Game.GetFormFromFile(0x000800, "DragonbornShoutPerks.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "DragonbornCustomPerksLevel", DragonbornCustomPerksLevel.GetValue())
		jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
		GlobalVariable DragonbornCustomPerksPerkPoints = Game.GetFormFromFile(0x000802, "DragonbornShoutPerks.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "DragonbornCustomPerksPerkPoints", DragonbornCustomPerksPerkPoints.GetValue())
		jCustomSkillsKey = jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
		GlobalVariable DragonbornCustomPerksSkillProgress = Game.GetFormFromFile(0x000801, "DragonbornShoutPerks.esp") as GlobalVariable
		jmap.SetStr(jCustomSkillsForms, "DragonbornCustomPerksSkillProgress", DragonbornCustomPerksSkillProgress.GetValue())
		jCustomSkillsKey = jmap.nextKey(jCustomSkillsList, jCustomSkillsKey, "")
	endIf	

	jvalue.writeToFile(jCustomSkillsForms, jcontainers.userDirectory() + "/Proteus/ProteusCSkills_Custom_M1_" + presetName + ".json")

	;debug.Notification(characterSavingName + " stats saved into Proteus system.")
endFunction


Function Proteus_CheckActiveMods()
	;initially set all bools as false and then check if mods are active in user's load order
	obisActive = false
	lotdActive = false

	haemophiliaActive  = false
	unarmouredDefenseActive  = false
	dragonbornCustomPerkActive = false
	vigilantPerksActive  = false
	glenmorilPerksActive  = false
	handtohandActive  = false
	pmwActive  = false
	apocalypseActive  = false
	edmrActive  = false
	pmeActive  = false
	odinActive  = false
	triumActive  = false
	imperiousActive  = false
	aethActive = false
	morningstarActive = false
	betterVampiresActive = false
	bloodlinesActive = false
	bloodmoonRisingActive = false
	curseVampireActive = false
	manbeastActive = false
	lupineActive = false
	moonlightTalesActive = false
	sacrilegeActive = false
	sacrosanctActive = false
	sanguinaireActive = false
	scionActive = false
	vampyriumActive = false
	werewolfPerksExpandedActive = false
	growlActive = false
	truaActive = false
	wintersunActive = false
	pilgrimActive = false
	arcanumActive = false
	shadowspellsActive = false
	acebloodActive = false
	mysticiscmActive = false

	;------------------------------------------------------------------------------------------------------
	;check for mods critical to running Project Proteus
	;------------------------------------------------------------------------------------------------------
	Int targetModIndex = Game.GetModByName("RaceMenu.esp")
	if TargetModIndex != 255
	else
		Debug.Notification("RaceMenu is not installed. It must be installed for the Player Module to work properly!")
	endIf
	targetModIndex = Game.GetModByName("UIExtensions.esp")
	if TargetModIndex != 255
	else
		Debug.Notification("UIExtensions is not installed. It must be installed for the Player Module to work properly!")
	endIf
	
	;------------------------------------------------------------------------------------------------------
	;check for mods that may have certain items Proteus will have to add back to player / spawn inventory
	;------------------------------------------------------------------------------------------------------
	;check for mods with special items
	targetModIndex = Game.GetModByName("OBIS SE.esp")
	if TargetModIndex != 255
		obisActive = true
	endIf

	targetModIndex = Game.GetModByName("LegacyoftheDragonborn.esm")
	if TargetModIndex != 255
		lotdActive = true
	endIf

	;------------------------------------------------------------------------------------------------------
	;custom perk trees (that use Custom Skills Framework)
	targetModIndex = Game.GetModByName("Haemophilia.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Haemophilia Patch.esp")
		if TargetModIndex != 255
			haemophiliaActive = true
		else
			Debug.Notification("Proteus Haemophilia patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Vigilant.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Vigilant Patch.esp")
		if TargetModIndex != 255
			vigilantPerksActive = true
		else
			Debug.Notification("Proteus Vigilant Perk patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Glenmoril.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Glenmoril Patch.esp")
		if TargetModIndex != 255
			glenmorilPerksActive = true
		else
			Debug.Notification("Proteus Glenmoril Perk patch not installed. Please install it!")
		endIf
		
	endIf

	targetModIndex = Game.GetModByName("Perk-HandToHand.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - HandToHand Patch.esp")
		if TargetModIndex != 255
			handtohandActive = true
		else
			Debug.Notification("Proteus Hand to Hand patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Unarmoured.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - UnarmouredDefense Patch.esp")
		if TargetModIndex != 255
			unarmouredDefenseActive = true
		else
			Debug.Notification("Proteus Unarmoured Defense patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("DragonbornShoutPerks.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Dragonborn Custom Perk Patch.esp")
		if TargetModIndex != 255
			dragonbornCustomPerkActive = true
		else
			Debug.Notification("Proteus Dragonborn Custom Perk patch not installed. Please install it!")
		endIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for spell mods
	targetModIndex = Game.GetModByName("Phenderix Magic World.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Phenderix Magic World Patch.esp")
		if TargetModIndex != 255
			pmwActive = true
		else
			Debug.Notification("Proteus Phenderix Magic World patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Apocalypse - Magic of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Apocalypse Patch.esp")
		if TargetModIndex != 255
			apocalypseActive = true
		else
			Debug.Notification("Proteus Apocalypse patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Phenderix Magic Evolved.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Phenderix Magic Evolved Patch.esp")
		if TargetModIndex != 255
			pmeActive = true
		else
			Debug.Notification("Proteus Phenderix Magic Evolved patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Elemental Destruction Magic Redux.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - EDM Redux Patch.esp")
		if TargetModIndex != 255
			edmrActive = true
		else
			Debug.Notification("Proteus Elemental Destruction Magic Redux patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Elemental Destruction.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - EDM Patch.esp")
		if TargetModIndex != 255
			edmActive = true
		else
			Debug.Notification("Proteus Elemental Destruction Magic patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Odin - Skyrim Magic Overhaul.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Odin Patch.esp")
		if TargetModIndex != 255
			odinActive = true
		else
			Debug.Notification("Proteus Odin patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Triumvirate - Mage Archetypes.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Triumvirate Patch.esp")
		if TargetModIndex != 255
			triumActive = true
		else
			Debug.Notification("Proteus Triumvirate patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("MysticismMagic.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Mysticism Patch.esp")
		if TargetModIndex != 255
			mysticiscmActive = true
		else
			Debug.Notification("Proteus Mysticism patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("ShadowSpellPackage.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Shadow Spells Patch.esp")
		if TargetModIndex != 255
			shadowspellsActive = true
		else
			Debug.Notification("Proteus Shadow Spells patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Ace Blood Magic SE.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Ace Blood Patch.esp")
		if TargetModIndex != 255
			acebloodActive = true
		else
			Debug.Notification("Proteus Ace Blood patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Arcanum.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Arcanum Patch.esp")
		if TargetModIndex != 255
			arcanumActive = true
		else
			Debug.Notification("Proteus Arcanum patch not installed. Please install it!")
		EndIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for race mods
	targetModIndex = Game.GetModByName("Imperious - Races of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Imperious Patch.esp")
		if TargetModIndex != 255
			imperiousActive = true
		else
			Debug.Notification("Proteus Imperious patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Morningstar - Minimalistic Races of Skyrim.esl")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Morningstar Patch.esp")
		if TargetModIndex != 255
			morningstarActive = true
		else
			Debug.Notification("Proteus Morningstar patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Aetherius.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Aetherius Patch.esp")
		if TargetModIndex != 255
			aethActive = true
		else
			Debug.Notification("Proteus Aetherius patch not installed. Please install it!")
		EndIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for religion mods
	targetModIndex = Game.GetModByName("Trua - Minimalistic Faiths of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Trua Patch.esp")
		if TargetModIndex != 255
			truaActive = true
		else
			Debug.Notification("Proteus Trua patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Wintersun - Faiths of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Wintersun Patch.esp")
		if TargetModIndex != 255
			wintersunActive = true
		else
			Debug.Notification("Proteus Wintersun patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Pilgrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Pilgrim Patch.esp")
		if TargetModIndex != 255
			pilgrimActive = true
		else
			Debug.Notification("Proteus Pilgrim patch not installed. Please install it!")
		EndIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for vampire mods
	targetModIndex = Game.GetModByName("Better Vampires.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Better Vampires Patch.esp")
		if TargetModIndex != 255
			betterVampiresActive = true
		else
			Debug.Notification("Proteus Better Vampires patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Bloodlines of Tamriel.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Bloodlines Patch.esp")
		if TargetModIndex != 255
			bloodlinesActive = true
		else
			Debug.Notification("Proteus Bloodlines patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Curse of the Vampire.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Curse of the Vampire Patch.esp")
		if TargetModIndex != 255
			curseVampireActive = true
		else
			Debug.Notification("Proteus Curse of the Vampire patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sacrilege - Minimalistic Vampires of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Sacrilege Patch.esp")
		if TargetModIndex != 255
			sacrilegeActive = true
		else
			Debug.Notification("Proteus Sacrilege patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sacrosanct - Vampires of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Sacrosanct Patch.esp")
		if TargetModIndex != 255
			sacrosanctActive = true
		else
			Debug.Notification("Proteus Sacrosanct patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sanguinaire.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Sanguinaire Patch.esp")
		if TargetModIndex != 255
			sanguinaireActive = true
		else
			Debug.Notification("Proteus Sanguinaire patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Scion.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Scion Patch.esp")
		if TargetModIndex != 255
			scionActive = true
		else
			Debug.Notification("Proteus Scion patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Vampyrium2.0.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Vampyrium Patch.esp")
		if TargetModIndex != 255
			vampyriumActive = true
		else
			Debug.Notification("Proteus Vampyrium patch not installed. Please install it!")
		EndIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for werewolf mods
	targetModIndex = Game.GetModByName("BloodmoonRising.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Bloodmoon Rising Patch.esp")
		if TargetModIndex != 255
			bloodmoonRisingActive = true
		else
			Debug.Notification("Proteus Bloodmoon Rising patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Manbeast.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Manbeast Patch.esp")
		if TargetModIndex != 255
			manbeastActive = true
		else
			Debug.Notification("Proteus Manbeast patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("LupineWerewolfPerkExpansion.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Lupine Patch.esp")
		if TargetModIndex != 255
			lupineActive = true
		else
			Debug.Notification("Proteus Lupine patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Moonlight Tales Special Edition.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Moonlight Tales Patch.esp")
		if TargetModIndex != 255
			moonlightTalesActive = true
		else
			Debug.Notification("Proteus Moonlight Tales patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Growl - Werebeasts of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Growl Patch.esp")
		if TargetModIndex != 255
			growlActive = true
		else
			Debug.Notification("Proteus Growl patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("WerewolfPerksExpanded.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Project Proteus - Werewolf Perks Expanded Patch.esp")
		if TargetModIndex != 255
			werewolfPerksExpandedActive = true
		else
			Debug.Notification("Proteus Werewolf Perks Expanded patch not installed. Please install it!")
		EndIf
	endIf

endFunction




Function Proteus_CheatOutfit(Actor target, int startingPoint, int currentPage) ;option 0 = cheat, 1 = reset
    Debug.Notification("Outfit menu loading...may take a few seconds!")
    Form[] allGameOutfits = GetAllForms(124) ;get all Outfits in game and from mods

    int numPages = (allGameOutfits.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit Outfit Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search Outfits]")
        i+=1
        while startingPoint <= allGameOutfits.Length && i < 128
            listMenuBase.AddEntryItem(GetFormEditorID(allGameOutfits[startingPoint]))
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
            ;int itemCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, 124)
            Form[] foundItems = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 124)
            Proteus_CheatOutfitSearch(target, foundItems, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatOutfit(target, startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Outfit selectedOutfit = allGameOutfits[startingPointInitial + result - 2] as Outfit
			target.SetOutfit(selectedOutfit)
        Else
            Outfit selectedOutfit = allGameOutfits[result - 2] as Outfit
			target.SetOutfit(selectedOutfit)
        endIf
    endIf
EndFunction

Function Proteus_CheatOutfitSearch(Actor target, Form[] foundItems, int startingPoint, int currentPage) ;option 0 = cheat, 1 = reset
    Debug.Notification("Outfit menu loading...may take a few seconds!")
    Form[] allGameOutfits = foundItems ;get all Outfits in game and from mods

    int numPages = (allGameOutfits.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit Outfit Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search Outfits]")
        i+=1
        while startingPoint <= allGameOutfits.Length && i < 128
            listMenuBase.AddEntryItem(GetFormEditorID(allGameOutfits[startingPoint]))
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
           ;int itemCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, 124)
            Form[] foundItems2 = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 124)
            Proteus_CheatOutfitSearch(target, foundItems2, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatOutfitSearch(target, foundItems, startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Outfit selectedOutfit = allGameOutfits[startingPointInitial + result - 2] as Outfit
			target.SetOutfit(selectedOutfit)
        Else
            Outfit selectedOutfit = foundItems[result - 2] as Outfit
			target.SetOutfit(selectedOutfit)
        endIf
    endIf
EndFunction




;updated in 5.2.0
Function Proteus_NPCVoiceTypeExhaustive(Actor target, int startingPoint, int currentPage)
    Debug.Notification("Voice Type menu loading...may take a few seconds!")
    Form[] allGameVT = GetAllForms(98) ;get all Outfits in game and from mods

    int numPages = (allGameVT.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit VT Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search VT]")
        i+=1
        while startingPoint <= allGameVT.Length && i < 128
            listMenuBase.AddEntryItem(GetFormEditorID(allGameVT[startingPoint]))
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
            Form[] foundItems = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 98)
            Proteus_NPCVoiceTypeExhaustiveSearch(target, foundItems, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_NPCVoiceTypeExhaustive(target, startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            VoiceType selectedVT = allGameVT[startingPointInitial + result - 2] as VoiceType
            target.GetActorBase().SetVoiceType(selectedVT)
            Proteus_SaveNPCVoiceType(target, target.GetActorBase().GetName())
            Debug.Notification(target.GetActorBase().GetName() + " voice type successfully changed.")
        Else
            VoiceType selectedVT = allGameVT[result - 2] as VoiceType
            target.GetActorBase().SetVoiceType(selectedVT)
            Proteus_SaveNPCVoiceType(target, target.GetActorBase().GetName())
            Debug.Notification(target.GetActorBase().GetName() + " voice type successfully changed.")
        endIf
    endIf
endFunction





Function Proteus_NPCVoiceTypeExhaustiveSearch(Actor target, Form[] foundItems, int startingPoint, int currentPage) ;option 0 = cheat, 1 = reset
    Debug.Notification("Voice Type menu loading...may take a few seconds!")
    Form[] allGameVT = foundItems ;get all Outfits in game and from mods

    int numPages = (allGameVT.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit VT Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search VT]")
        i+=1
        while startingPoint <= allGameVT.Length && i < 128
            listMenuBase.AddEntryItem(GetFormEditorID(allGameVT[startingPoint]))
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
           ;int itemCount = ProteusDLLUtils.ProteusGetItemCount(searchTerm, 124)
            Form[] foundItems2 = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 98)
            Proteus_NPCVoiceTypeExhaustiveSearch(target, foundItems2, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatOutfitSearch(target, foundItems, startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            VoiceType selectedVT = allGameVT[startingPointInitial + result - 2] as VoiceType
            target.GetActorBase().SetVoiceType(selectedVT)
            Proteus_SaveNPCVoiceType(target, target.GetActorBase().GetName())
            Debug.Notification(target.GetActorBase().GetName() + " voice type successfully changed.")
        Else
            VoiceType selectedVT = allGameVT[result - 2] as VoiceType
            target.GetActorBase().SetVoiceType(selectedVT)
            Proteus_SaveNPCVoiceType(target, target.GetActorBase().GetName())
            Debug.Notification(target.GetActorBase().GetName() + " voice type successfully changed.")
        endIf
    endIf
EndFunction