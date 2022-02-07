scriptName PhenderixToolEditPlayerScript extends activemagiceffect

Import ProteusDLLUtils
import PO3_SKSEFunctions
import CharGen
import PhenderixToolResourceScript
Import JContainers
Import ProteusCheatFunctions

;-- Properties--------------------------------------

;Faction properties
faction property playerFaction auto
faction property thalmorFaction auto
faction property necromancerFaction auto
faction property forswornFaction auto
faction property werewolfFaction auto
faction property vampireFaction auto
faction property banditFaction auto
faction property imperialLegionFaction auto
faction property stormcloakFaction auto
faction property cultistFaction auto
faction property dremoraFaction auto
faction property falmerFaction auto
faction property hagravenFaction auto
faction property tribalOrcsFaction auto
faction property vigilantOfStendarrFaction auto
faction property skeletonFaction auto

;Message properties
message property ZZPlayerConfirmSwitchLocation auto
message property ZZGameWorldSetMessage auto
message property ZZPlayerConfirmSpawnMessage auto
message property ZZPlayerConfirmResetCharacter auto
message property ZZPlayerSwitchMessage auto
message property ZZPlayerSpawnPerksSpellsMessage auto
message property ZZDeletePresetMenu auto

;GlobalVariable properties
GlobalVariable property ZZPresetLoadedCounter auto
GlobalVariable property ZZPresetLoadedCounter2 auto
GlobalVariable property ZZLoadPlayerPreset auto
GlobalVariable property ZZNPCAppearanceSaved auto
GlobalVariable property explosionsOn auto
GlobalVariable property ZZHasSavedPlayerCharacter auto
GlobalVariable property ZZBackupCounter auto
GlobalVariable property ZZEnableSpawnSpellLoad auto
GlobalVariable property ZZEnableSpawnPerkLoad auto
GlobalVariable property ZZZSaveGameCounter auto

;Quest properties
Quest property ZZProteusSkyUIMenu auto

;Explosion properties
Explosion property greenExplosion auto

;FormList properties
FormList property combatStylesList auto
FormList property teleportLocationsList auto
FormList property startingWeaponsList auto
FormList property ZZSpawnedCharactersList auto
Formlist Property ZZVanillaPerksListVampireWerewolf auto
FormList property ZZSpells auto
FormList property ZZCrimeFactions auto
FormList property ZZOutfits auto

;Race properties
Race property NordRace auto
Race property WoodElfRace auto
Race property DarkElfRace auto
Race property HighElfRace auto
Race property OrcRace auto
Race property BretonRace auto
Race property ImperialRace auto
Race property RedguardRace auto
Race property ArgonianRace auto
Race property KhajiitRace auto

;Actor proprties
Actor property ZZCustomF1 auto
Actor property ZZCustomF2 auto
Actor property ZZCustomF3 auto
Actor property ZZCustomF4 auto
Actor property ZZCustomF5 auto
Actor property ZZCustomF6 auto
Actor property ZZCustomF7 auto
Actor property ZZCustomF8 auto
Actor property ZZCustomF9 auto
Actor property ZZCustomF10 auto
Actor property ZZCustomM1 auto
Actor property ZZCustomM2 auto
Actor property ZZCustomM3 auto
Actor property ZZCustomM4 auto
Actor property ZZCustomM5 auto
Actor property ZZCustomM6 auto
Actor property ZZCustomM7 auto
Actor property ZZCustomM8 auto
Actor property ZZCustomM9 auto
Actor property ZZCustomM10 auto
Actor property hostilePlayerCharacter auto

;ObjectReference properties
ObjectReference property ProteusMarker auto
ObjectReference property playerMarker auto
ObjectReference property UnequippedContainer1 auto
ObjectReference property UnequippedContainer2 auto
ObjectReference property UnequippedContainer3 auto
ObjectReference property UnequippedContainer4 auto
ObjectReference property UnequippedContainer5 auto
ObjectReference property UnequippedContainer6 auto
ObjectReference property UnequippedContainer7 auto
ObjectReference property UnequippedContainer8 auto
ObjectReference property UnequippedContainer9 auto
ObjectReference property UnequippedContainer10 auto
ObjectReference property UnequippedContainer11 auto
ObjectReference property UnequippedContainer12 auto
ObjectReference property UnequippedContainer13 auto
ObjectReference property UnequippedContainer14 auto
ObjectReference property UnequippedContainer15 auto
ObjectReference property UnequippedContainer16 auto
ObjectReference property UnequippedContainer17 auto
ObjectReference property UnequippedContainer18 auto
ObjectReference property UnequippedContainer19 auto
ObjectReference property UnequippedContainer20 auto
ObjectReference property UnequippedContainer21 auto
ObjectReference property UnequippedContainer22 auto
ObjectReference property UnequippedContainer23 auto
ObjectReference property UnequippedContainer24 auto
ObjectReference property UnequippedContainer25 auto
ObjectReference property UnequippedContainer26 auto
ObjectReference property UnequippedContainer27 auto
ObjectReference property UnequippedContainer28 auto
ObjectReference property UnequippedContainer29 auto
ObjectReference property UnequippedContainer30 auto
ObjectReference property UnequippedContainer31 auto
ObjectReference property UnequippedContainer32 auto
ObjectReference property UnequippedContainer33 auto
ObjectReference property UnequippedContainer34 auto
ObjectReference property UnequippedContainer35 auto
ObjectReference property UnequippedContainer36 auto
ObjectReference property UnequippedContainer37 auto
ObjectReference property UnequippedContainer38 auto
ObjectReference property UnequippedContainer39 auto
ObjectReference property UnequippedContainer40 auto
ObjectReference property UnequippedContainer41 auto
ObjectReference property UnequippedContainer42 auto
ObjectReference property UnequippedContainer43 auto
ObjectReference property UnequippedContainer44 auto
ObjectReference property UnequippedContainer45 auto
ObjectReference property UnequippedContainer46 auto
ObjectReference property UnequippedContainer47 auto
ObjectReference property UnequippedContainer48 auto
ObjectReference property UnequippedContainer49 auto
ObjectReference property UnequippedContainer50 auto
ObjectReference property sharedContainer auto
ObjectReference property sharedContainerVoidLocationMarker auto
ObjectReference property voidMarker auto


;Sound descriptor
Sound property ZZProteusCompleteSound auto

;VoiceType properties
VoiceType property ZZMaleArgonian auto
VoiceType property ZZMaleDarkElf auto
VoiceType property ZZMaleEvenToned auto 
VoiceType property ZZMaleKhajiit auto 
VoiceType property ZZMaleOrc auto
VoiceType property ZZFemaleDarkElf auto 
VoiceType property ZZFemaleEvenToned auto 
VoiceType property ZZFemaleOrc auto 
VoiceType property ZZFemaleKhajiit auto
VoiceType property ZZFemaleArgonian auto

;Ammo properties
Ammo property crossBowAmmo auto
Ammo property bowAmmo auto

;MiscObject properties
MiscObject Property Gold001 Auto

;Spell properties
Spell property slowTimeSpell auto

;-- Variables ---------------------------------------
Actor player
Actor switchActor
Int wopCountTracker	
Int totalPerkPointsAvailable
Int  tyleNum
Int combatStyleNum
String spawnedCharacterGender
String characterSavingName
String[] presetsLoaded
Bool firstTimeSpawn
Bool playerPresetFirstLoad
ObjectReference tempMarker
String JContGlobalPath
Float targetCW

;Variables (tracking active mods)
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
Bool pmeActive ;Phenderix Magic Evolved
Bool odinActive ;Odin Odin - Skyrim Magic Overhaul
Bool triumActive ;Triumvirate - Mage Archetypes
Bool imperiousActive ;Imperious - Races of Skyrim
Bool aethActive ;Aetherius - A Race Overhaul
bool morningstarActive ;Morningstar - Minimalistic Races of Skyrim
Bool betterVampiresActive ;Better Vampires
Bool bloodlinesActive ;Bloodlines of Tamriel - A Vampire Overhaul
Bool bloodmoonRisingActive ;Bloodmoon Rising SSE Edition Werewolf Overhaul
Bool curseVampireActive ;Curse of the Vampire
bool manbeastActive ;Manbeast - A Werewolf Overhaul
Bool lupineActive ;Lupine - Werewolf Perk Expansion
Bool moonlightTalesActive ;Moonlight Tales Special Edition - Werewolf and Werebear Overhaul
Bool growlActive ;Growl - Werebeasts of Skyrim
Bool sacrilegeActive ;Sacrilege - Minimalistic Vampires of Skyrim
Bool sacrosanctActive ;Sacrosanct - Vampires of Skyrim
Bool sanguinaireActive ;Sanguinaire (Revised Edition)
Bool truaActive ;Trua - Minimalistic Faiths of Skyrim
Bool wintersunActive ;Wintersun - Faiths of Skyrim
Bool pilgrimActive ;Pilgrim - A Religion Overhaul
Bool scionActive ;Scion - A Vampire Overhaul
Bool vampyriumActive ;Vampyrium-Resurrected (Vampire Overhaul)
Bool werewolfPerksExpandedActive ;Werewolf Perks Expanded
Bool arcanumActive ;Arcanum - A New Age of Magic
Bool shadowspellsActive ;Shadow Spell Package
Bool acebloodActive ;Ace Blood Magic
Bool mysticiscmActive ;Mysticism - A Magic Overhaul
Bool edmActive ;Elemental Destruction Magic
Bool edmrActive ;Elemental Destruction Magic Redux
Bool colorfulMagicActive ;Colorful Magic by 184Gesu SE
Bool addItemsActive ;AddItemMenu - Ultimate Mod Explorer
Bool vokriinatorActive ;Vokriinator Black

;-- Functions ---------------------------------------
function OnEffectStart(Actor akplayer, Actor akCaster)

	JContGlobalPath = jcontainers.userdirectory()
	
	if(ZZNPCAppearanceSaved.GetValue() == 0)
		WorldIdentityFunction()
	endIf

	Proteus_CheckActiveMods()
	player = akplayer
	Proteus_PlayerMainMenu()
endFunction


Function Proteus_SaveGame()
	Utility.Wait(0.1)
	Game.SaveGame("Proteus_Save_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(), 0) + "_" + Proteus_Round(ZZZSaveGameCounter.GetValue(),0))
	ZZZSaveGameCounter.SetValue(ZZZSaveGameCounter.GetValue() + 1)
endFunction

function Proteus_PlayerMainMenu()
	String[] stringArray = new String[17]
	stringArray[0] = " Save Character"
	stringArray[1] = " Switch Character"
	stringArray[2] = " Import Character"
	stringArray[3] = " Spawn Hostile Character"
	stringArray[4] = " Summon Existing Spawn"
	stringArray[5] = " Start New Character"
	stringArray[6] = " Piecemeal Save Character"
	stringArray[7] = " Piecemeal Load Character"
	stringArray[8] = " Character Level Scaler"
	stringArray[9] = " Open Shared Stash"
	stringArray[10] = " Reset Spawn / Delete Character"
	stringArray[11] = " Show Race Menu (Enhanced)"
	stringArray[12] = " Edit Attributes & Skills"
	stringArray[13] = " Toggle Factions"
	stringArray[14] = " Idle Animations"
	stringArray[15] = " Cheats"
	stringArray[16] = " [Exit Menu]"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 17
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	
	if result == 0 ;save character
		Proteus_LockEnable()
		String playerName = player.GetActorBase().GetName()
		Proteus_CharacterSave(player, playerName) ;save skills, perks, inventory, attributes, level, spells, appearance
		ZZProteusCompleteSound.play(playerMarker)
		Proteus_LockDisable()
		Proteus_SaveGame()
	elseIf result == 1 ;switch character
		Proteus_LockEnable()
		Proteus_SwitchCharacter()
		Proteus_LockDisable()
		ZZProteusCompleteSound.play(playerMarker)
		player.DispelAllSpells() ;remove active magic effects
		Proteus_SaveGame()
	elseIf result == 2 ;import character
		Proteus_LockEnable()
		playerMarker.MoveTo(player)
		Proteus_LoadCharacterSpawn(player, "")
		ZZProteusCompleteSound.play(playerMarker)
		Debug.Notification("Import process completed.")
		Proteus_LockDisable()
		Proteus_SaveGame()
	elseif result == 3 ;spawn hostile
		Proteus_LockEnable()
		Proteus_LoadCharacterSpawn(player, "evilproteusspawn")
		ZZProteusCompleteSound.play(playerMarker)
		Proteus_LockDisable()
	elseIf result == 4 ;summon existing spawn
		Proteus_TeleportExistingSummonToPlayer("")
	elseIf result == 5 ;new character / reset
		Proteus_LockEnable()
		Int ibutton= ZZPlayerConfirmResetCharacter.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		if(ibutton == 0)
			Proteus_NewCharacter()
		Else
			Proteus_PlayerMainMenu()
		EndIf
		Proteus_LockDisable()
		player.DispelAllSpells()
		Proteus_SaveGame()
	elseIf result == 6 ;piecemeal save
		Proteus_PlayerPiecemealSaveFunction(player)
	elseIf result == 7 ;piecemeal load
		Proteus_PlayerPiecemealLoadFunction(player)
	elseif result == 8
		LevelScaler(player)
	elseif result == 9 ;shared stash
		Proteus_OpenSharedStash()
	elseIf result == 10 ;permanently delete character
		Proteus_LockEnable()
		String presetDelete = Proteus_SelectPresetSwitch(true)
		if(presetDelete == "")
			Proteus_PlayerMainMenu()
		else
			Int ibutton= ZZDeletePresetMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)		
			if ibutton == 0
				Proteus_ResetSpawn(presetDelete)
			elseif ibutton == 1
				Proteus_DeletePlayerCharacter(presetDelete)
			endIf
		endIf
		Proteus_LockDisable()
	elseIf result == 11 ;racemenu enhanced
		;ExecuteCommand("showracemenu")
		Utility.Wait(0.5)
		String presetName = player.GetActorBase().GetName()
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if lengthPresetName > 0
			Proteus_SaveTargetStrings(player, presetName)
			Proteus_SaveCharacterAppearance(presetName, player) ;save appearance of target's character (including race)
			SaveAppearancePresetJSON(player.GetActorBase().GetName(), presetName)
			SavePresetGlobalVariables(presetName)
		else
			Debug.Notification("Invalid preset name entered.")
		endIf
		Proteus_SaveGame()
	elseif result == 12 ;submenu
		ProteusPlayerMainMenu2()
	elseIf result == 13
		Proteus_PlayerFactionsFunction()
	elseIf result == 14
		Proteus_PlayerIdleAnimationFunction(player) ;located in PhenderixToolEditNPCScript
	elseIf result == 15
		PlayerCheats() ;load skills, attributes, level, spells, appearance	
	endIf
endFunction


function ProteusPlayerMainMenu2()
	String[] stringArray = new String[6]
	stringArray[0] = " Attributes"
	stringArray[1] = " Skills"
	stringArray[2] = " Resistances"
	stringArray[3] = " Scale/Size"
	stringArray[4] = " [Back]"
	stringArray[5] = " [Exit Menu]"
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
	if result == 0 ;attributes
		Proteus_PlayerAttributesFunction(player) ;located in PhenderixToolEditNPCScript
	elseif result == 1 ;skills
		Proteus_PlayerSkillsFunction(player) ;located in PhenderixToolEditNPCScript
	elseif result == 2 ;resistance
		Proteus_PlayerResistanceFunction(player) ;located in PhenderixToolEditNPCScript
	elseif result == 3 ;size scale
		Proteus_PlayerSizeScaleFunction(player) ;located in PhenderixToolEditNPCScript
	elseif result == 4 ;back to main menu
		Proteus_PlayerMainMenu()
	endIf
endFunction

Function Teleporter()
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





function PlayerCheats()
	String[] stringArray= new String[13]

	stringArray[0] = " Add Weapon"
	stringArray[1] = " Add Armor"
	stringArray[2] = " Add Misc Item"
	stringArray[3] = " Add Ammo"
	stringArray[4] = " Add Scroll"
	stringArray[5] = " Add Book"
	stringArray[6] = " Add Spell"
	stringArray[7] = " Add Perk"
	stringArray[8] = " Add Shout"
	stringArray[9] = " Add Perk Point"
	stringArray[10] = " Add Dragon Soul"
	stringArray[11] = " [Back]"
	stringArray[12] = " [Exit Menu]"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 13
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	

	if result == 0 ;weapon
		Proteus_CheatItem(0, 1, 41)
	elseIf result == 1 ;armor
		Proteus_CheatItem(0, 1, 26)
	elseif result == 2 ;misc item
		Proteus_CheatItem(0, 1, 32)
	elseif result == 3 ;ammo
		Proteus_CheatItem(0, 1, 42)
	elseif result == 4 ;scroll
		Proteus_CheatItem(0, 1, 23)
	elseif result == 5 ;book
		Proteus_CheatItem(0, 1, 27)
	elseif result == 6 ;spell
		Proteus_CheatSpell(player, 0, 1, 22, ZZProteusSkyUIMenu)
	elseif result == 7 ;perk
		Proteus_CheatPerk(player, 0, 1, 92, ZZProteusSkyUIMenu)
	elseif result == 8 ;shout
		Debug.MessageBox("Be careful using this function. Learning shouts you are not supposed to know yet, that are given by quest lines, may break the associated quest. \n\nLearning a shout via this feature will also teach you its corresponding words of power.")
		Utility.Wait(0.1)
		Proteus_CheatShout(player, 0, 1, 119, ZZProteusSkyUIMenu)
	elseif result == 9 ;perk points
		String amount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many perk points?")
		if(amount as Int > 0)
			Game.AddPerkPoints(amount as Int)
			Debug.Notification("Player gained " + Proteus_Round(amount as Int, 0) + " perk point(s).")
		endIf
		playerCheats()
	elseIf result == 10 ;dragon souls
		String amount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many dragon souls?")
		if(amount as Int > 0)
			player.modav("dragonsouls", amount as Int)
			Debug.Notification("Player gained " + Proteus_Round(amount as Int, 0) + " dragon soul(s).")
		endIf
		playerCheats()
	elseIf result == 11 	;back
		Proteus_PlayerMainMenu()
	elseIf result == 12 	;exit
	endIf
endFunction










;Checks if this world has a number assigned to it, if not assigns one
function WorldIdentityFunction()	
	if(ZZNPCAppearanceSaved.GetValue() == 0)
		int i = 1
		bool setVal = false
		while i < 1000 && setVal == false
			if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + i + ".json"))
			else
				setVal = true
				ZZNPCAppearanceSaved.SetValue(i)
			endIf
			i+=1
		endWhile
	endIf
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
	colorfulMagicActive = false
	addItemsActive = false
	vokriinatorActive = false

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

	targetModIndex = Game.GetModByName("AddItemMenuSE.esp")
	if TargetModIndex != 255
		addItemsActive = true
	endIf

	;------------------------------------------------------------------------------------------------------
	;custom perk trees (that use Custom Skills Framework)
	targetModIndex = Game.GetModByName("Haemophilia.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Haemophilia Patch.esp")
		if TargetModIndex != 255
			haemophiliaActive = true
		else
			Debug.Notification("Proteus Haemophilia patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Vigilant.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Vigilant Patch.esp")
		if TargetModIndex != 255
			vigilantPerksActive = true
		else
			Debug.Notification("Proteus Vigilant Perk patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Glenmoril.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Glenmoril Patch.esp")
		if TargetModIndex != 255
			glenmorilPerksActive = true
		else
			Debug.Notification("Proteus Glenmoril Perk patch not installed. Please install it!")
		endIf
		
	endIf

	targetModIndex = Game.GetModByName("Perk-HandToHand.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - HandToHand Patch.esp")
		if TargetModIndex != 255
			handtohandActive = true
		else
			Debug.Notification("Proteus Hand to Hand patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Perk-Unarmoured.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - UnarmouredDefense Patch.esp")
		if TargetModIndex != 255
			unarmouredDefenseActive = true
		else
			Debug.Notification("Proteus Unarmoured Defense patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("DragonbornShoutPerks.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Dragonborn Custom Perk Patch.esp")
		if TargetModIndex != 255
			dragonbornCustomPerkActive = true
		else
			Debug.Notification("Proteus Dragonborn Custom Perk patch not installed. Please install it!")
		endIf
	endIf

	;------------------------------------------------------------------------------------------------------
	;check for spell mods
	targetModIndex = Game.GetModByName("Phenderix Magic World.esm")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Phenderix Magic World Patch.esp")
		if TargetModIndex != 255
			pmwActive = true
		else
			Debug.Notification("Proteus Phenderix Magic World patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Apocalypse - Magic of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Apocalypse Patch.esp")
		if TargetModIndex != 255
			apocalypseActive = true
		else
			Debug.Notification("Proteus Apocalypse patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Phenderix Magic Evolved.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Phenderix Magic Evolved Patch.esp")
		if TargetModIndex != 255
			pmeActive = true
		else
			Debug.Notification("Proteus Phenderix Magic Evolved patch not installed. Please install it!")
		endIf
	endIf

	targetModIndex = Game.GetModByName("Elemental Destruction Magic Redux.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - EDM Redux Patch.esp")
		if TargetModIndex != 255
			edmrActive = true
		else
			Debug.Notification("Proteus Elemental Destruction Magic Redux patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Elemental Destruction.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - EDM Patch.esp")
		if TargetModIndex != 255
			edmActive = true
		else
			Debug.Notification("Proteus Elemental Destruction Magic patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Odin - Skyrim Magic Overhaul.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Odin Patch.esp")
		if TargetModIndex != 255
			odinActive = true
		else
			Debug.Notification("Proteus Odin patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Triumvirate - Mage Archetypes.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Triumvirate Patch.esp")
		if TargetModIndex != 255
			triumActive = true
		else
			Debug.Notification("Proteus Triumvirate patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("MysticismMagic.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Mysticism Patch.esp")
		if TargetModIndex != 255
			mysticiscmActive = true
		else
			Debug.Notification("Proteus Mysticism patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Colorful_Magic_SE.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Colorful Magic Patch.esp")
		if TargetModIndex != 255
			colorfulMagicActive = true
		else
			Debug.Notification("Proteus Colorful Magic patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("ShadowSpellPackage.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Shadow Spells Patch.esp")
		if TargetModIndex != 255
			shadowspellsActive = true
		else
			Debug.Notification("Proteus Shadow Spells patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Ace Blood Magic SE.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Ace Blood Patch.esp")
		if TargetModIndex != 255
			acebloodActive = true
		else
			Debug.Notification("Proteus Ace Blood patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Arcanum.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Arcanum Patch.esp")
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
		targetModIndex = Game.GetModByName("Proteus - Imperious Patch.esp")
		if TargetModIndex != 255
			imperiousActive = true
		else
			Debug.Notification("Proteus Imperious patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Morningstar - Minimalistic Races of Skyrim.esl")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Morningstar Patch.esp")
		if TargetModIndex != 255
			morningstarActive = true
		else
			Debug.Notification("Proteus Morningstar patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Aetherius.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Aetherius Patch.esp")
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
		targetModIndex = Game.GetModByName("Proteus - Trua Patch.esp")
		if TargetModIndex != 255
			truaActive = true
		else
			Debug.Notification("Proteus Trua patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Wintersun - Faiths of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Wintersun Patch.esp")
		if TargetModIndex != 255
			wintersunActive = true
		else
			Debug.Notification("Proteus Wintersun patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Pilgrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Pilgrim Patch.esp")
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
		targetModIndex = Game.GetModByName("Proteus - Better Vampires Patch.esp")
		if TargetModIndex != 255
			betterVampiresActive = true
		else
			Debug.Notification("Proteus Better Vampires patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Bloodlines of Tamriel.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Bloodlines Patch.esp")
		if TargetModIndex != 255
			bloodlinesActive = true
		else
			Debug.Notification("Proteus Bloodlines patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Curse of the Vampire.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Curse of the Vampire Patch.esp")
		if TargetModIndex != 255
			curseVampireActive = true
		else
			Debug.Notification("Proteus Curse of the Vampire patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sacrilege - Minimalistic Vampires of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Sacrilege Patch.esp")
		if TargetModIndex != 255
			sacrilegeActive = true
		else
			Debug.Notification("Proteus Sacrilege patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sacrosanct - Vampires of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Sacrosanct Patch.esp")
		if TargetModIndex != 255
			sacrosanctActive = true
		else
			Debug.Notification("Proteus Sacrosanct patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Sanguinaire.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Sanguinaire Patch.esp")
		if TargetModIndex != 255
			sanguinaireActive = true
		else
			Debug.Notification("Proteus Sanguinaire patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Scion.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Scion Patch.esp")
		if TargetModIndex != 255
			scionActive = true
		else
			Debug.Notification("Proteus Scion patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Vampyrium2.0.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Vampyrium Patch.esp")
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
		targetModIndex = Game.GetModByName("Proteus - Bloodmoon Rising Patch.esp")
		if TargetModIndex != 255
			bloodmoonRisingActive = true
		else
			Debug.Notification("Proteus Bloodmoon Rising patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Manbeast.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Manbeast Patch.esp")
		if TargetModIndex != 255
			manbeastActive = true
		else
			Debug.Notification("Proteus Manbeast patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("LupineWerewolfPerkExpansion.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Lupine Patch.esp")
		if TargetModIndex != 255
			lupineActive = true
		else
			Debug.Notification("Proteus Lupine patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Moonlight Tales Special Edition.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Moonlight Tales Patch.esp")
		if TargetModIndex != 255
			moonlightTalesActive = true
		else
			Debug.Notification("Proteus Moonlight Tales patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("Growl - Werebeasts of Skyrim.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Growl Patch.esp")
		if TargetModIndex != 255
			growlActive = true
		else
			Debug.Notification("Proteus Growl patch not installed. Please install it!")
		EndIf
	endIf
	targetModIndex = Game.GetModByName("WerewolfPerksExpanded.esp")
	if TargetModIndex != 255
		targetModIndex = Game.GetModByName("Proteus - Werewolf Perks Expanded Patch.esp")
		if TargetModIndex != 255
			werewolfPerksExpandedActive = true
		else
			Debug.Notification("Proteus Werewolf Perks Expanded patch not installed. Please install it!")
		EndIf
	endIf

	targetModIndex = Game.GetModByName("Vokriinator Black.esp")
	if TargetModIndex != 255
		vokriinatorActive = true
	endIf

endFunction

Function Proteus_AddBackModItems()

	if vigilantPerksActive == true
		Form object = Game.GetFormFromFile(0x001816, "Perk-Vigilant.esp")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added Vigilant Idol")
			player.AddItem(object, 1, true)
		endIf
	endIf

	if glenmorilPerksActive == true
		Form object = Game.GetFormFromFile(0x002D66, "Perk-Glenmoril.esp")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added Glenmoril MusicBox")
			player.AddItem(object, 1, true)
		endIf
	endIf

	if handtohandActive == true
		Form object = Game.GetFormFromFile(0x000D70, "Perk-HandToHand.esp")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added Perk H2H")
			player.AddItem(object, 1, true)
		endIf
	endIf

	if unarmouredDefenseActive == true
		Form object = Game.GetFormFromFile(0x000D77, "Perk-Unarmoured.esp")
		if(player.GetItemCount(object) == 0)
			player.AddItem(object, 1, true)
		endIf
	endIf

	if haemophiliaActive == true
		Form object = Game.GetFormFromFile(0x000823, "Haemophilia.esp")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added Haem Skull")
			player.AddItem(object, 1, true)
		endIf
		
	endIf

	if obisActive == true
		Form object = Game.GetFormFromFile(0x01074F, "OBIS SE.esp")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added OBIS Settings Book")
			player.AddItem(object, 1, true)
		endIf
	endIf

	if lotdActive == true
		Form object = Game.GetFormFromFile(0x2469A6, "LegacyoftheDragonborn.esm")
		if(player.GetItemCount(object) == 0)
			;Debug.MessageBox("Added Curator's Guide")
			player.AddItem(object, 1, true)
		endIf
	endIf

	if addItemsActive == true
		Form object = Game.GetFormFromFile(0x00690C, "AddItemMenuSE.esp")
		Form object2 = Game.GetFormFromFile(0x00895B, "AddItemMenuSE.esp")
		if(player.GetItemCount(object) == 0)
			player.AddItem(object, 1, true)
		endIf
		if(player.GetItemCount(object2) == 0)
			player.AddItem(object2, 1, true)
		endIf
	endIf
endFunction




function Proteus_CharacterSave(Actor target, String presetNameKnown)
	;initial setup of string nam
	String presetName
	characterSavingName = target.GetActorBase().GetName()
	if(presetNameKnown == "")
		presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character as?")
	else
		presetName = presetNameKnown
	endIf
	Int lengthPresetName = StringUtil.GetLength(presetName as String)
	if (lengthPresetName > 0)
		;save name, gender, race name, carry weight
		Proteus_SaveTargetStrings(target, presetName)
		;save skill levels, attributes, progress to next level
		Proteus_SaveSkillsAttributes(presetName, target)
		Debug.Notification(characterSavingName + " stats saved successfully.")

		;save equipped & unequipped items
		Proteus_SaveAllItems(presetName, target, true)
		Debug.Notification(characterSavingName + " inventory saved successfully.")

		;save perks
		Proteus_SavePerks(presetName)
		Debug.Notification(characterSavingName + " perks saved successfully.")

		;save spells
		Proteus_SaveSpells(presetName, target) ;save formIDs of spells in json file
		Debug.Notification(characterSavingName + " spells saved successfully.")

		;save appearance of target's character (including race) and make system register preset
		Proteus_SaveCharacterAppearance(presetName, target) 
		String processedPLAYERPRESETName = processName(presetName)
		Proteus_RegisterLoadedPresetOption(target, processedPLAYERPRESETName, presetName, false)
		SaveAppearancePresetJSON(processedPLAYERPRESETName, presetName)
		SavePresetGlobalVariables(presetName)
		Debug.Notification(characterSavingName + " appearance saved successfully.")

		;save crime faction bounties
		SaveCrimeFactions(presetName)

		;add back critical items added by some mods
		Proteus_AddBackModItems()

		;updated and save location
		ProteusMarker.MoveTo(target) ;moving to marker removes a lot of the notifications that pop up on screen
		target.MoveTo(ProteusMarker)
		ZZHasSavedPlayerCharacter.SetValue(ZZHasSavedPlayerCharacter.GetValue() + 1)
		debug.Notification(characterSavingName + " has been successfully saved.")
	else
		Debug.Notification("That preset name is invalid.")
	endIf
endFunction


String function Proteus_SpawnHasPerksSpells()
	Utility.Wait(0.1)
	Int ibutton= ZZPlayerSpawnPerksSpellsMessage.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if(ibutton == 0)
		return "Yes"
	Elseif(ibutton == 1)
		return "No"
	else
		Debug.Notification("Invalid response. Try again.")
		Proteus_SpawnHasPerksSpells()
	EndIf
	Utility.Wait(0.1)
endFunction

function Proteus_RemoveFavorites(Actor target)

	;remove favorited spells
	Spell[] favoritedSpells = ProteusDLLUtils.GetAllFavoritedSpells()
	int favCount = 0
	int p = 0
	while p < favoritedSpells.Length
		UnmarkItemAsFavorite(favoritedSpells[p])
		p += 1
	endWhile

	;remove favorited items
	favCount = 0
	p = 0
	Form[] favoritedItems = ProteusDLLUtils.GetAllFavoritedItems()
	while p < favoritedItems.Length
		UnmarkItemAsFavorite(favoritedItems[p])
		p += 1
	endWhile
endFunction

function Proteus_LoadCharacter(Actor target, String presetKnownName)
	String presetName = ""
	Int lengthPresetName
	Int spawnLoadPerksSpells
	firstTimeSpawn = false

	if(presetKnownName == "")
		Debug.Notification("Select which character to switch to.")
		presetName = Proteus_SelectPresetSwitch(false)	
	else
		presetName = presetKnownName
	endIf
	lengthPresetName = StringUtil.GetLength(presetName as String)
	
	;if valid preset name entered
	if (lengthPresetName > 0)
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
			Race presetRace = Proteus_LoadCharacterRace(presetName)
			Proteus_LoadTargetStrings(presetName, target, 2)

			if(StringUtil.GetLength(target.GetActorBase().GetName()) > 0)

				;set up marker for moving target to current player location and move player to target location
				playerMarker.MoveTo(player)
				Utility.Wait(0.1)
				Actor spawnedActor = Proteus_GetSpawningActor(presetName)
				if(spawnedActor == NONE)
				else
					player.MoveTo(spawnedActor)
				endIf

				;remove favorites
				Proteus_RemoveFavorites(target)

				Race currentRace = target.GetRace()
				Proteus_LoadSkillsAttributes(presetName, target, 0) ;REENABLE
				Debug.Notification(characterSavingName + " stats loaded successfully.")

				Proteus_LoadCharacterAppearance(presetName, target, currentRace, presetRace, 0) ;load appearance of character
				Debug.Notification(characterSavingName + " appearance loaded successfully.")

				Proteus_RemoveSpells(target, 0) ;removes current characters spells
				Proteus_RemovePerks(player, 0) ;remove all of player's current perks before adding other character's perks

				Proteus_LoadPerks(presetName, target)
				Debug.Notification(characterSavingName + " perks loaded successfully.")

				Proteus_LoadSpells(presetName, target) ;loads spells from json file
				Debug.Notification(characterSavingName + " spells loaded successfully.")

				Game.SetPerkPoints(totalPerkPointsAvailable)

				;INVENTORY REMOVAL AND LOADING
				Proteus_RemoveAllItems(target)
				Utility.Wait(0.1)
				Proteus_LoadItems(presetName, target) 
				Utility.Wait(0.1)
				Proteus_EquipItems(presetName, target) 
				;mark favorite items
				if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedItems_" +  presetName + ".json"))
					Int JItemMapListFavs = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedItems_" +  presetName + ".json")
					Int jItemFormNamesFav = jmap.object()
					String ItemFormKeyFavs = jmap.nextKey(JItemMapListFavs, "", "")
					while ItemFormKeyFavs 
						Form value = jmap.GetForm(JItemMapListFavs, ItemFormKeyFavs, none) as Form
						MarkItemAsFavorite(value)
						ItemFormKeyFavs = jmap.nextKey(JItemMapListFavs, ItemFormKeyFavs, "")
					endwhile
				EndIf
				
				;change carry weight
				Float currentCarryWeight = target.GetBaseAV("CarryWeight")
				Float diff = targetCW - currentCarryWeight
				target.ModAv("CarryWeight", diff)

				;make system recognize this appearance preset has been loaded
				Proteus_SavePlayerPreset(target, presetName)
				String processedPLAYERPRESETName = processName(presetName)
				Proteus_RegisterLoadedPresetOption(target, processedPLAYERPRESETName, presetName, false)
				SaveAppearancePresetJSON(target.GetActorBase().GetName(), presetName)
				LoadPresetGlobalVariables(presetName)

				;load crime faction bounties
				;LoadCrimeFactions(presetName)

				;add very important items from other mods that may not be in inventory 
				Proteus_AddBackModItems()

				Proteus_LoadCharacterAppearance(presetName, target, currentRace, presetRace, 0) ;load appearance a second time / may fix some glitches
			endIf
		else
			Debug.Notification("Player character not found.")
		endIf
	else
		Debug.MessageBox("Invalid preset name entered. Try again.")
	endIf
endFunction


function Proteus_LoadCharacterSpawn(Actor target, String presetKnownName)
	String presetName = ""
	Int lengthPresetName
	Int spawnLoadPerksSpells
	firstTimeSpawn = false

	if(presetKnownName == "evilproteusspawn")
		Debug.Notification("Select which character to spawn as an enemy.")
		presetName = Proteus_SelectPresetSpawn()
	elseif(presetKnownName == "")
		Debug.Notification("Select which character to spawn as an ally.")
		presetName = Proteus_SelectPresetSpawnImport()
	else
		presetName = presetKnownName
	endIf

	presetName = ProcessName(presetName)

	lengthPresetName = StringUtil.GetLength(presetName as String)
	Utility.Wait(0.1)
	;if valid preset name entered
	if (lengthPresetName > 0)
			if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
		
				Race presetRace = Proteus_LoadCharacterRace(presetName)

				if(presetKnownName == "evilproteusspawn")
					target = hostilePlayerCharacter
				elseif presetKnownName == "" ;spawn a player character follower
					Actor actorTemp = Proteus_GetUnusedSpawn()
					target = actorTemp
				else
					Actor actorTemp = Proteus_GetSpawningActor(presetKnownName)
					target = actorTemp
				endIf

				if(target == NONE || target == player)
					;STOP
				else
					target.MoveTo(playerMarker)
					Proteus_LoadTargetStrings(presetName, target, 2)
					if(StringUtil.GetLength(target.GetActorBase().GetName()) > 0)
						Race currentRace = target.GetRace()
						Proteus_LoadSkillsAttributes(presetName, target, 1) ;REENABLE
						Proteus_LoadCharacterAppearance(presetName, target, currentRace, presetRace, 1) ;load appearance of spawned NPC
						
						Proteus_RegisterLoadedPresetOption(target, presetName, presetName, true)

						;remove existing spells and perks from the spawn
						Proteus_RemoveSpells(target, 0) 
						Proteus_RemovePerks(target, 0)

						;load spells and perks on NPC depending on MCM
						if(ZZEnableSpawnSpellLoad.GetValue() == 1)
							Proteus_LoadSpells(presetName, target)
						endIf
						if(ZZEnableSpawnPerkLoad.GetValue() == 1)
							Proteus_LoadPerksVisible(presetName, target)
						endIf
	
						if(presetKnownName == "evilproteusspawn") ;make spawn hostile to the player and frenzied
							firstTimeSpawn = TRUE
							target.SetRelationshipRank(player, -4)
							target.SetActorValue("Aggression", 3 as Float)
							player.SetRelationshipRank(player, -4)
						else ;make spawn friendly to player
							target.SetRelationshipRank(player, 3)
							player.SetRelationshipRank(player, 3)
						endIf
	
						String processedNPCName = processName(target.GetActorBase().GetName())
						Proteus_JSave_NPCForms(target, processedNPCName, presetName) ;save into Proteus system to later reload.
						
						;load NPC voice type if it has one
						bool hasVoiceTypeSaved = FALSE
						String ZZNPCAppearanceSavedValue = Proteus_Round(ZZNPCAppearanceSaved.GetValue(), 0)
						If(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_VT_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json"))
							Int jVTList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_VT_" + ZZNPCAppearanceSavedValue + "_" + processedNPCName + ".json")
							Int JVT = jmap.object()
							String textKey = jmap.nextKey(jVTList, "", "")
							Form value = jmap.GetForm(jVTList, textKey, none) as Form
							target.GetActorBase().SetVoiceType(value as VoiceType) 
							hasVoiceTypeSaved = TRUE
							Utility.Wait(0.1)
						endIf
						
						if(firstTimeSpawn == TRUE && hasVoiceTypeSaved == FALSE)
							ActorBase spawnAB = target.GetActorBase()
							Race spawnABRace = spawnAB.GetRace()
							String spawnRaceName = spawnABRace.GetName() ;newcode
							if spawnAB.GetSex() == 0 ;male
								if(spawnRaceName == "Argonian" || spawnRaceName == "Argonian DZ")
									spawnAB.SetVoiceType(ZZMaleArgonian)
								elseif(spawnRaceName == "Dark Elf" || spawnRaceName == "Dark Elf DZ")
									spawnAB.SetVoiceType(ZZMaleDarkElf)
								elseif(spawnRaceName == "Khajiit" || spawnRaceName == "Khajiit DZ")
									spawnAB.SetVoiceType(ZZMaleKhajiit)
								elseif(spawnRaceName == "Orc" || spawnRaceName == "Orc DZ")
									spawnAB.SetVoiceType(ZZMaleOrc)
								else
									spawnAB.SetVoiceType(ZZMaleEvenToned)
								endIf
							else ;female
								if(spawnRaceName == "Argonian" || spawnRaceName == "Argonian DZ")
									spawnAB.SetVoiceType(ZZFemaleArgonian)
								elseif(spawnRaceName == "Dark Elf" || spawnRaceName == "Dark Elf DZ")
									spawnAB.SetVoiceType(ZZFemaleDarkElf)
								elseif(spawnRaceName == "Khajiit" || spawnRaceName == "Khajiit DZ")
									spawnAB.SetVoiceType(ZZFemaleKhajiit)
								elseif(spawnRaceName == "Orc" || spawnRaceName == "Orc DZ")
									spawnAB.SetVoiceType(ZZFemaleOrc)
								else
									spawnAB.SetVoiceType(ZZFemaleEvenToned)
								endIf
							endIf
	
							;Save NPC voice type JSON
							Int jVTList
							Int JVT = jmap.object()
							jmap.SetForm(JVT, "VT", target.GetVoiceType())
							jvalue.writeToFile(JVT, JContGlobalPath + "/Proteus/Proteus_Character_VT_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
						endIf
	
						Utility.Wait(0.1)
						target.RemoveAllItems()
						Utility.Wait(0.1)
						Proteus_AddEquippedItemsSpawn(presetName, target) 
						Utility.Wait(0.5)	
						target.SetActorValue("CarryWeight", targetCW)
						Proteus_LoadCharacterAppearance(presetName, target, currentRace, presetRace, 1) ;load appearance a second time / may fix some glitches
						Proteus_EquipItems(presetName, Target)
					endIf
				endIf
			else
				Debug.Notification("Player character " + presetName + " not found.")
			endIf
	else
		Debug.MessageBox("Invalid preset name entered. Try again.")
		Utility.Wait(0.1)
	endIf
endFunction



;on switching characters dump all items in this container
Function Proteus_RemoveAllItems(Actor target)
		String previousPreset
		;get current preset name
		String ZZNPCAppearanceSavedValue = Proteus_Round(ZZNPCAppearanceSaved.GetValue(), 0)
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + ZZNPCAppearanceSavedValue + ".json") == true) 		
			Int JPlayerList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + ZZNPCAppearanceSavedValue + ".json")
			Int jStats = jmap.object()
			String playerPresetName = jmap.nextKey(JPlayerList, "", "")
			while playerPresetName
				String value = jmap.GetStr(JPlayerList, playerPresetName, none) as String
				if playerPresetName == "PresetName"
					previousPreset = value 
				EndIf
				playerPresetName = jmap.nextKey(JPlayerList, playerPresetName, "")
			endWhile
		else
			Debug.Notification("Character was not saved. Storing items in temp chest.")
			previousPreset = "temp"
		endIf
		;get proper container and remove all items from it (setup phase for storage)
		ObjectReference storageContainerUnequipped = Proteus_SaveUnequippedContainerFunction(previousPreset)
		storageContainerUnequipped.RemoveAllItems()
		storageContainerUnequipped.SetName(previousPreset)
		storageContainerUnequipped.SetDisplayName(previousPreset)
		target.RemoveAllItems(storageContainerUnequipped, true, false)
endFunction

Actor Function Proteus_GetSpawningActor(String name)
	Actor spawningActor
	string[] stringArray = new String[21]
	stringArray[0] = ZZCustomM1.GetActorBase().GetName()
	stringArray[1] = ZZCustomM2.GetActorBase().GetName()
	stringArray[2] = ZZCustomM3.GetActorBase().GetName()
	stringArray[3] = ZZCustomM4.GetActorBase().GetName()
	stringArray[4] = ZZCustomM5.GetActorBase().GetName()
	stringArray[5] = ZZCustomM6.GetActorBase().GetName()
	stringArray[6] = ZZCustomM7.GetActorBase().GetName()
	stringArray[7] = ZZCustomM8.GetActorBase().GetName()
	stringArray[8] = ZZCustomM9.GetActorBase().GetName()
	stringArray[9] = ZZCustomM10.GetActorBase().GetName()
	stringArray[10] = ZZCustomF1.GetActorBase().GetName()
	stringArray[11] = ZZCustomF2.GetActorBase().GetName()
	stringArray[12] = ZZCustomF3.GetActorBase().GetName()
	stringArray[13] = ZZCustomF4.GetActorBase().GetName()
	stringArray[14] = ZZCustomF5.GetActorBase().GetName()
	stringArray[15] = ZZCustomF6.GetActorBase().GetName()
	stringArray[16] = ZZCustomF7.GetActorBase().GetName()
	stringArray[17] = ZZCustomF8.GetActorBase().GetName()
	stringArray[18] = ZZCustomF9.GetActorBase().GetName()
	stringArray[19] = ZZCustomF10.GetActorBase().GetName()
	stringArray[20] = " [Exit Menu]"

	if name == ""
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
		if result == 0
			spawningActor =  ZZCustomM1
		elseif result == 1
			spawningActor =  ZZCustomM2
		elseif result == 2
			spawningActor =  ZZCustomM3
		elseif result == 3
			spawningActor =  ZZCustomM4
		elseif result == 4
			spawningActor =  ZZCustomM5
		elseif result == 5
			spawningActor =  ZZCustomM6
		elseif result == 6
			spawningActor =  ZZCustomM7
		elseif result == 7
			spawningActor =  ZZCustomM8
		elseif result == 8
			spawningActor =  ZZCustomM9
		elseif result == 9
			spawningActor =  ZZCustomM10
		elseif result == 10
			spawningActor =  ZZCustomF1
		elseif result == 11
			spawningActor =  ZZCustomF2
		elseif result == 12
			spawningActor =  ZZCustomF3
		elseif result == 13
			spawningActor =  ZZCustomF4
		elseif result == 14
			spawningActor =  ZZCustomF5
		elseif result == 15
			spawningActor =  ZZCustomF6
		elseif result == 16
			spawningActor =  ZZCustomF7
		elseif result == 17
			spawningActor =  ZZCustomF8
		elseif result == 18
			spawningActor =  ZZCustomF9
		elseif result == 19
			spawningActor =  ZZCustomF10
		elseif result == 20
		endIf
	else
		if name == stringArray[0]
			spawningActor =  ZZCustomM1
		elseif name == stringArray[1]
			spawningActor =  ZZCustomM2
		elseif name == stringArray[2]
			spawningActor =  ZZCustomM3
		elseif name == stringArray[3]
			spawningActor =  ZZCustomM4
		elseif name == stringArray[4]
			spawningActor =  ZZCustomM5
		elseif name == stringArray[5]
			spawningActor =  ZZCustomM6
		elseif name == stringArray[6]
			spawningActor =  ZZCustomM7
		elseif name == stringArray[7]
			spawningActor =  ZZCustomM8
		elseif name == stringArray[8]
			spawningActor =  ZZCustomM9
		elseif name == stringArray[9]
			spawningActor =  ZZCustomM10
		elseif name == stringArray[10]
			spawningActor =  ZZCustomF1
		elseif name == stringArray[11]
			spawningActor =  ZZCustomF2
		elseif name == stringArray[12]
			spawningActor =  ZZCustomF3
		elseif name == stringArray[13]
			spawningActor =  ZZCustomF4
		elseif name == stringArray[14]
			spawningActor =  ZZCustomF5
		elseif name == stringArray[15]
			spawningActor =  ZZCustomF6
		elseif name == stringArray[16]
			spawningActor =  ZZCustomF7
		elseif name == stringArray[17]
			spawningActor =  ZZCustomF8
		elseif name == stringArray[18]
			spawningActor =  ZZCustomF9
		elseif name == stringArray[19]
			spawningActor =  ZZCustomF10
		else
			spawningActor = Proteus_GetUnusedSpawn()
		endIf
	endIf
	
	String name2 = spawningActor.GetActorBase().GetName()
	Int indexF1 = stringutil.Find(name2, "Unused Slot", 0)
	if indexF1 >= 0
		firstTimeSpawn = TRUE
		return spawningActor
	else
		return spawningActor
	EndIf
endFunction

Actor Function Proteus_GetUnusedSpawn()
	Actor target
	if ZZCustomM1.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM1
	elseif ZZCustomM2.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM2
	elseif ZZCustomM3.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM3
	elseif ZZCustomM4.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM4
	elseif ZZCustomM5.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM5
	elseif ZZCustomM6.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM6
	elseif ZZCustomM7.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM7
	elseif ZZCustomM8.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM8
	elseif ZZCustomM9.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM9
	elseif ZZCustomM10.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomM10
	elseif ZZCustomF1.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF1
	elseif ZZCustomF2.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF2
	elseif ZZCustomF3.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF3
	elseif ZZCustomF4.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF4
	elseif ZZCustomF5.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF5
	elseif ZZCustomF6.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF6
	elseif ZZCustomF7.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF7
	elseif ZZCustomF8.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF8
	elseif ZZCustomF9.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF9
	elseif ZZCustomF10.GetActorBase().GetName() == "Unused Slot"
		target = ZZCustomF10
	endIf
	return target
endFunction


Race Function Proteus_LoadCharacterRace(String presetName)
	Race presetRace
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
		Int JRaceList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
		Int jStats = jmap.object()
		String raceForm = jmap.nextKey(JRaceList , "", "")
		Race value = jmap.GetForm(JRaceList, raceForm, none) as Race
		if raceForm == "race"
			presetRace = value
		EndIf
	else
		debug.Notification("Race not found in Proteus system.")
	EndIf
	return presetRace
endFunction


int Function Proteus_LoadSkillsAttributes(String presetName, Actor target, Int option) ;option 0 = switch by player, option 1 = load player spawn

	Int alchemyLevel
	Int alterationLevel
	Int marksmanLevel
	Int blockLevel
	Int conjurationLevel
	Int destructionLevel
	Int enchantingLevel
	Int heavyArmorLevel
	Int illusionLevel
	Int lightArmorLevel
	Int lockpickingLevel
	Int onehandedLevel
	Int pickpocketLevel
	Int restorationLevel 
	Int smithingLevel
	Int sneakLevel
	Int speechcraftLevel
	Int twohandedLevel
	Int healthLevel
	Int staminaLevel
	Int magickaLevel
	Int overallLevel
	Float overallExperience

	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json"))
			Int jSkillList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json")
			Int jSkills = jmap.object()
			String skillForm = jmap.nextKey(jSkillList, "", "")
			Int maxCount = jvalue.Count(jSkillList)
			Int j = 0
			String stat = jmap.nextKey(JSkillList, "", "")
			while j < maxCount
				String value = jmap.GetStr(jSkillList , stat, "")
				if stat == "Alchemy"
					alchemyLevel = value as Int
				elseIf stat == "Alteration"
					alterationLevel = value as Int
				elseIf stat == "Marksman"
					marksmanLevel = value as Int
				elseIf stat == "Block"
					blockLevel = value as Int
				elseIf stat == "Conjuration"
					conjurationLevel = value as Int
				elseIf stat == "Destruction"
					destructionLevel = value as Int
				elseIf stat == "Enchanting"
					enchantingLevel = value as Int
				elseIf stat == "HeavyArmor"
					heavyArmorLevel = value as Int
				elseIf stat == "Illusion"
					illusionLevel = value as Int
				elseIf stat == "LightArmor"
					lightArmorLevel = value as Int
				elseIf stat == "Lockpicking"
					lockpickingLevel = value as Int
				elseIf stat == "OneHanded"
					onehandedLevel = value as Int
				elseIf stat == "PickPocket"
					pickpocketLevel = value as Int
				elseIf stat == "Restoration"
					restorationLevel = value as Int
				elseIf stat == "Smithing"
					smithingLevel = value as Int
				elseIf stat == "Sneak"
					sneakLevel = value as Int
				elseIf stat == "Speechcraft"
					speechcraftLevel = value as Int
				elseIf stat == "Twohanded"
					twohandedLevel = value as Int
				elseIf stat == "Health"
					healthLevel = value as Int
				elseIf stat == "Magicka"
					magickaLevel = value as Int
				elseIf stat == "Stamina"
					staminaLevel = value as Int
				elseIf stat == "Level"
					overallLevel = value as Int
				elseIf stat == "Experience"
					overallExperience = value as Float
				elseif stat == "AlchemyExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Alchemy").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "AlterationExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Alteration").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "MarksmanExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Marksman").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "BlockExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Block").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "ConjurationExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Conjuration").SetSkillExperience( value as Float )
					endIf	
				elseIf stat == "DestructionExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Destruction").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "EnchantingExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Enchanting").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "HeavyArmorExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("HeavyArmor").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "IllusionExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Illusion").SetSkillExperience( value as Float )
					endIf				
				elseIf stat == "LightArmorExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("LightArmor").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "LockpickingExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Lockpicking").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "OneHandedExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("oneHanded").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "PickpocketExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Pickpocket").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "RestorationExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Restoration").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "SmithingExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Smithing").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "SneakExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Sneak").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "SpeechcraftExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("Speechcraft").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "TwoHandedExp"
					if(option == 0)
						ActorValueInfo.GetActorValueInfoByName("twoHanded").SetSkillExperience( value as Float )
					endIf
				elseIf stat == "ZPerkPoints"
					if(option == 0)
						Game.SetPerkPoints(value as Int)
						totalPerkPointsAvailable = value as Int
					endIf
				endIf
				stat = jmap.nextKey(JSkillList, stat, "")
				j += 1
			endWhile

			;change level and skills / new block added in 4.1.0 to make NPCs load stats correctly as when
			;their level is updated, it resets all of their stats. Must load level first and then set skills / attributes
			if(option == 0)
				ProteusDLLUtils.SetLevel(target, overallLevel as Int)
				Game.SetPlayerExperience(overallExperience as Float)
			elseif(option == 1)
				ProteusDLLUtils.SetLevel(target, overallLevel as Int)
			EndIf
			Target.SetActorValue("Alchemy", alchemyLevel as Int) 
			Target.SetActorValue("Alteration", alterationLevel as Int) 
			Target.SetActorValue("Marksman", marksmanLevel as Int) 
			Target.SetActorValue("Block", blockLevel as Int) 
			Target.SetActorValue("Conjuration", conjurationLevel as Int) 
			Target.SetActorValue("Destruction", destructionLevel as Int) 
			Target.SetActorValue("Enchanting", enchantingLevel as Int) 
			Target.SetActorValue("HeavyArmor", heavyArmorLevel as Int) 
			Target.SetActorValue("Illusion", illusionLevel as Int) 
			Target.SetActorValue("LightArmor", lightArmorLevel as Int) 
			Target.SetActorValue("Lockpicking", lockpickingLevel as Int) 
			Target.SetActorValue("OneHanded", onehandedLevel as Int) 
			Target.SetActorValue("Pickpocket", pickpocketLevel as Int) 
			Target.SetActorValue("Restoration", restorationLevel as Int) 
			Target.SetActorValue("Smithing", smithingLevel as Int) 
			Target.SetActorValue("Sneak", sneakLevel as Int) 
			Target.SetActorValue("Speechcraft", speechcraftLevel as Int) 
			Target.SetActorValue("TwoHanded", twohandedLevel as Int) 
			Target.SetActorValue("Health", healthLevel as Int) 
			Target.SetActorValue("Magicka", magickaLevel as Int) 
			Target.SetActorValue("Stamina", staminaLevel as Int) 

		;CUSTOM SKILLS FRAMEWORK LOAD
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_SkillsCustom_" + presetName + ".json"))
			Int jCustomSkillsList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_SkillsCustom_" + presetName + ".json")
			Int jCustomSkillsForms = jmap.object()    
			String jCustomSkillsKey= jmap.nextKey(jCustomSkillsList, "", "")
			maxCount = jvalue.Count(jCustomSkillsList)
			j = 0
			stat = jmap.nextKey(jCustomSkillsList, "", "")
			while j < maxCount
				String value = jmap.GetStr(jCustomSkillsList , stat, "")
				if stat == "glenmorilLevel"
					if(glenmorilPerksActive == TRUE)
						GlobalVariable glenmorilLevel = Game.GetFormFromFile(0x001D62, "Perk-Glenmoril.esp") as GlobalVariable
						glenmorilLevel.SetValue(value as Float)
					endIf
				elseif stat == "VigilantLevel"
					if(vigilantPerksActive == TRUE)
						GlobalVariable VigilantLevel = Game.GetFormFromFile(0x002D64, "Perk-Vigilant.esp") as GlobalVariable
						VigilantLevel.SetValue(value as Float)
					endIf
				elseif stat == "VampirismLevel"
					if(haemophiliaActive == TRUE)
						GlobalVariable vampirismLevel = Game.GetFormFromFile(0x00081C, "Haemophilia.esp") as GlobalVariable
						vampirismLevel.SetValue(value as Float)
					endIf	
				elseif stat == "HandToHandLevel"
					if(handtohandActive == TRUE)
						GlobalVariable handtohandLevel = Game.GetFormFromFile(0x000D61, "Perk-HandToHand.esp") as GlobalVariable
						handtohandLevel.SetValue(value as Float)
					endIf
				elseif stat == "HandToHandPerkPoints"
					if(handtohandActive == TRUE)
						GlobalVariable handtohandPerkPoints = Game.GetFormFromFile(0x000D65, "Perk-HandToHand.esp") as GlobalVariable
						handtohandPerkPoints.SetValue(value as Float)
					endIf
				elseif stat == "UnarmouredDefenseLevel"
					if(unarmouredDefenseActive == TRUE)
						GlobalVariable unarmouredDefenseLevel = Game.GetFormFromFile(0x000D61, "Perk-Unarmoured.esp") as GlobalVariable
						unarmouredDefenseLevel.SetValue(value as Float)
					endIf
				elseif stat == "UnarmouredDefensePerkPoints"
					if(unarmouredDefenseActive == TRUE)
						GlobalVariable unarmouredDefensePerkPoints = Game.GetFormFromFile(0x000D65, "Perk-Unarmoured.esp") as GlobalVariable
						unarmouredDefensePerkPoints.SetValue(value as Float)
					endIf
				elseif stat == "DragonbornCustomPerksLevel"
					if(dragonbornCustomPerkActive == TRUE)
						GlobalVariable DragonbornCustomPerksLevel = Game.GetFormFromFile(0x000800, "DragonbornShoutPerks.esp") as GlobalVariable
						DragonbornCustomPerksLevel.SetValue(value as Float)
					endIf
				elseif stat == "DragonbornCustomPerksPerkPoints"
					if(dragonbornCustomPerkActive == TRUE)
						GlobalVariable DragonbornCustomPerksPerkPoints = Game.GetFormFromFile(0x000802, "DragonbornShoutPerks.esp") as GlobalVariable
						DragonbornCustomPerksPerkPoints.SetValue(value as Float)
					endIf
				elseif stat == "DragonbornCustomPerksSkillProgress"
					if(dragonbornCustomPerkActive == TRUE)
						GlobalVariable DragonbornCustomPerksSkillProgress = Game.GetFormFromFile(0x000801, "DragonbornShoutPerks.esp") as GlobalVariable
						DragonbornCustomPerksSkillProgress.SetValue(value as Float)
					endIf
				endIf
				stat = jmap.nextKey(jCustomSkillsList, stat, "")
				j += 1
			endWhile
		endIf
		return 1
	else
		return 0 ;failed to import skills and attributes
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
	jvalue.writeToFile(jSkills, JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json")


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
	jvalue.writeToFile(jCustomSkillsForms, JContGlobalPath + "/Proteus/Proteus_Character_SkillsCustom_" + presetName + ".json")
endFunction

function Proteus_SaveSpells(String preset, Actor target)
	Spell[] knownSpells = ProteusDLLUtils.GetAllSpells(player)
	Spell[] favoritedSpells = ProteusDLLUtils.GetAllFavoritedSpells()
	Shout[] knownShouts = ProteusDLLUtils.GetAllShouts(player)
	Utility.Wait(0.1)
	Proteus_ExportJSONShout(preset, knownShouts, knownShouts.Length, "/Proteus/Proteus_Character_Shouts_", 0, 1)
	Proteus_ExportJSONSpell(preset, favoritedSpells, favoritedSpells.Length, "/Proteus/Proteus_Character_FavoritedSpells_", 0, 0)
	Proteus_ExportJSONSpell(preset, knownSpells, knownSpells.Length, "/Proteus/Proteus_Character_Spells_", 0, 1)

	;save equipped spells
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	int counter = 0
	bool both = false
	String jMapKey = jmap.nextKey(jMapList, "", "")
	if(target.GetEquippedSpell(0) && target.GetEquippedSpell(1) && target.GetEquippedSpell(0) == target.GetEquippedSpell(1))
		String savedName = target.GetEquippedSpell(0).GetName()
		jmap.SetForm(jMapObject, counter + "_ProteusB_" + savedName, target.GetEquippedSpell(0))
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
		both = true
	endIf
	
	if(target.GetEquippedSpell(0) && both == false) ;left hand
		String savedName = target.GetEquippedSpell(0).GetName()
		jmap.SetForm(jMapObject, counter + "_ProteusL_" + savedName, target.GetEquippedSpell(0))
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endIf
	if(target.GetEquippedSpell(1) && both == false) ;right hand
		String savedName = target.GetEquippedSpell(1).GetName()
		jmap.SetForm(jMapObject, counter + "_ProteusR_" + savedName, target.GetEquippedSpell(1))
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endIf
	if(target.GetEquippedSpell(2)) ;other slot
		String savedName = target.GetEquippedSpell(2).GetName()
		jmap.SetForm(jMapObject, counter + "_ProteusV_" + savedName, target.GetEquippedSpell(2))
	endIf
	jvalue.writeToFile(jMapObject, JContGlobalPath + "/Proteus/Proteus_Character_EquippedSpells_" + preset + ".json")
endFunction


function Proteus_ExportJSONPerk(String presetName, Perk[] arrayToSave, Int arrayLength, String jsonPartialPath, int counter, int page)
	;Debug.Notification("Length Array: " + arrayLength)
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	Int initialCounter = counter
	String jMapKey = jmap.nextKey(jMapList, "", "")
	while j <= 127 && j < arrayLength && (j + initialCounter) < arrayLength && arrayToSave[counter] 
		String savedName = arrayToSave[counter].GetName()
		jmap.SetForm(jMapObject, counter + " " + savedName, arrayToSave[counter])
		j += 1
		counter += 1
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endwhile
	;Debug.Notification("Counter: " + counter)
	jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + page + "_"  + presetName + ".json")
	if(arrayLength > counter && arrayToSave[counter])
		page += 1
		Proteus_ExportJSONPerk(presetName, arrayToSave, arrayLength, jsonPartialPath, counter, page)
	endIf
endFunction

function Proteus_ExportJSONForm(String presetName, Form[] arrayToSave, Int arrayLength, String jsonPartialPath, int counter, int page)
	;Debug.Notification("Length Array: " + arrayLength)
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	Int initialCounter = counter
	String jMapKey = jmap.nextKey(jMapList, "", "")
	while j <= 127 && j < arrayLength && (j + initialCounter) < arrayLength && arrayToSave[counter] 
		String savedName = arrayToSave[counter].GetName()
		jmap.SetForm(jMapObject, counter + " " + savedName, arrayToSave[counter])
		j += 1
		counter += 1
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endwhile
	;Debug.Notification("Counter: " + counter)
	if(page == 0)
		jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + presetName + ".json")
	else
		jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + page + "_"  + presetName + ".json")
	endIf
	if(arrayLength > counter && arrayToSave[counter])
		page += 1
		Proteus_ExportJSONForm(presetName, arrayToSave, arrayLength, jsonPartialPath, counter, page)
	endIf
endFunction

function Proteus_ExportJSONSpell(String presetName, Spell[] arrayToSave, Int arrayLength, String jsonPartialPath, int counter, int page)
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	Int initialCounter = counter
	String jMapKey = jmap.nextKey(jMapList, "", "")
	while j <= 127 && j < arrayLength && (j + initialCounter) < arrayLength
		if(arrayToSave[counter])
			String savedName = arrayToSave[counter].GetName()
			jmap.SetForm(jMapObject, counter + " " + savedName, arrayToSave[counter])
		endIf
		j += 1
		counter += 1
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endwhile
	;Debug.Notification("Counter: " + counter)
	if(page == 0)
		jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + presetName + ".json")
	else
		jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + page + "_"  + presetName + ".json")
	endIf
	if(arrayLength > counter && arrayToSave[counter])
		page += 1
		Proteus_ExportJSONSpell(presetName, arrayToSave, arrayLength, jsonPartialPath, counter, page)
	endIf
endFunction

function Proteus_ExportJSONShout(String presetName, Shout[] arrayToSave, Int arrayLength, String jsonPartialPath, int counter, int page)
	;Debug.Notification("Length Array: " + arrayLength)
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	Int initialCounter = counter
	String jMapKey = jmap.nextKey(jMapList, "", "")
	while j <= 127 && j < arrayLength && (j + initialCounter) < arrayLength && arrayToSave[counter] 
		String savedName = arrayToSave[counter].GetName()
		jmap.SetForm(jMapObject, counter + " " + savedName, arrayToSave[counter])
		j += 1
		counter += 1
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endwhile
	;Debug.Notification("Counter: " + counter)
	jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + page + "_"  + presetName + ".json")
	if(arrayLength > counter && arrayToSave[counter])
		page += 1
		Proteus_ExportJSONShout(presetName, arrayToSave, arrayLength, jsonPartialPath, counter, page)
	endIf
endFunction

function Proteus_ExportJSONFormCount(String presetName, Form[] arrayToSave, Int arrayLength, Int[] arrayToSave2, Int arrayLength2, String jsonPartialPath, int counter, int page)
	;Debug.Notification("Length Array: " + arrayLength)
	Int jMapObject = jmap.object()
	Int jMapList
	Int j = 0
	Int initialCounter = counter
	String jMapKey = jmap.nextKey(jMapList, "", "")
	while j <= 127 && j < arrayLength && (j + initialCounter) < arrayLength && arrayToSave[counter] 
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
		String savedName = arrayToSave[counter].GetName()
		jmap.SetForm(jMapObject, counter + " " + savedName + " ProteusCount:" + arrayToSave2[counter], arrayToSave[counter])
		j += 1
		counter += 1	
		jMapKey = jmap.nextKey(jMapList, jMapKey, "")
	endwhile
	;Debug.Notification("Counter: " + counter)
	jvalue.writeToFile(jMapObject, JContGlobalPath + jsonPartialPath + page + "_"  + presetName + ".json")
	if(arrayLength > counter && arrayToSave[counter])
		page += 1
		Proteus_ExportJSONFormCount(presetName, arrayToSave, arrayLength, arrayToSave2, arrayLength2, jsonPartialPath, counter, page)
	endIf
endFunction


function Proteus_RemoveSpells(Actor target, int option) ;option 0 = switch characters, option 1 = reset character
	
	;unequip spells before removal
	if(target.GetEquippedItemType(0) == 9)
		Spell leftHand = target.GetEquippedSpell(0)
		target.UnequipSpell(leftHand, 0)
	elseif(target.GetEquippedItemType(0) == 9)
		Spell rightHand = target.GetEquippedSpell(1)
		target.UnequipSpell(rightHand, 1)
	endIf

	if option == 0
		ProteusDLLUtils.RemoveAllSpells(target)
	elseif option == 1
		;remove vanilla spells
		int k = 0
		while k < ZZSpells.GetSize()
			target.RemoveSpell(ZZSpells.GetAt(k) as Spell)
			k+=1
		endWhile
		
		FormList ZZSpellList

		;remove Phenderix Magic World Spells
		if(pmwActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Phenderix Magic World Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		EndIf
		ZZSpellList = NONE

		;remove Phenderix Magic Evolved Spells
		if(pmwActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Phenderix Magic Evolved Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		EndIf
		ZZSpellList = NONE

		;remove Apocalypse Spells
		if(apocalypseActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Apocalypse Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove EDMR spells
		if(edmrActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - EDM Redux Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Triumvirate spells
		if(triumActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Triumvirate Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Odin spells
		if(odinActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Odin Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Imperious spells
		if(imperiousActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Imperious Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Aetherius spells
		if(aethActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Aetherius Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Morningstar spells
		if(morningstarActive == true)
			ZZSpellList = Game.GetFormFromFile(0xD63, "Proteus - Morningstar Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Better Vampire spells
		if(betterVampiresActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Better Vampires Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Bloodlines spells
		if(bloodlinesActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Bloodlines Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Bloodmoon Rising spells
		if(bloodmoonRisingActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Bloodmoon Rising Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Curse of the Vampire spells
		if(curseVampireActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Curse of the Vampire Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Manbeast spells
		if(manbeastActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Manbeast Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Lupine spells
		if(lupineActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Lupine Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Moonlight Tales spells
		if(moonlightTalesActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Moonlight Tales Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Growl spells
		if(growlActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Growl Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Sacrilege spells
		if(sacrilegeActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Sacrilege Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Sacrosanct spells
		if(sacrosanctActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Sacrosanct Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Sanguinaire spells
		if(sanguinaireActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Sanguinaire Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Scion spells
		if(scionActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Scion Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Vampyrium spells
		if(vampyriumActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Vampyrium Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Trua spells
		if(truaActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Trua Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Wintersun spells
		if(wintersunActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Wintersun Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Pilgrim spells
		if(pilgrimActive == true)
			ZZSpellList = Game.GetFormFromFile(0x801, "Proteus - Pilgrim Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Shadow Spell Package spells
		if(shadowspellsActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Shadow Spells Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Ace Blood Magic spells
		if(acebloodActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Ace Blood Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Mysticism spells
		if(mysticiscmActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Mysticism Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove Arcanum spells
		if(arcanumActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - Arcanum Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove EDM spells
		if(edmActive == true)
			ZZSpellList = Game.GetFormFromFile(0x800, "Proteus - EDM Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE

		;remove colorful magic spells
		if(colorfulMagicActive == true)
			ZZSpellList = Game.GetFormFromFile(0x901, "Proteus - Colorful Magic Patch.esp") as FormList
			k = 0
			while k < ZZSpellList.GetSize()
				target.RemoveSpell(ZZSpellList.GetAt(k) as Spell)
				k+=1
			endWhile
		endIf
		ZZSpellList = NONE
	endIf
endFunction


function Proteus_LoadSpells(String presetName, Actor target)
	int counter = 1
	while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Spells_" + counter + "_" + presetName + ".json"))
		Proteus_LoadSpells2(presetName, target, counter)
		counter += 1
	endWhile
	Proteus_LoadEquippedSpell(presetName, target)

	if(target == player)
		Proteus_LoadFavoritedSpells(presetName)
		Proteus_LoadShouts(target, presetName)
	endIf
	
endFunction

Function Proteus_LoadSpells2(String presetName, Actor target, int counter)
    Int JSpellMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Spells_" + counter + "_" + presetName + ".json")
    Int jSpellFormNames = jmap.object()
    String SpellFormKey = jmap.nextKey(JSpellMapList, "", "")
    while SpellFormKey 
        Spell value = jmap.GetForm(JSpellMapList, SpellFormKey, none) as Spell
        target.AddSpell(value)
        SpellFormKey = jmap.nextKey(JSpellMapList, SpellFormKey, "")
    endwhile
endFunction

Function Proteus_LoadShouts(Actor target, String presetname)
	int counter = 1
	while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Shouts_" + counter + "_" + presetName + ".json"))
		Proteus_LoadShouts2(presetName, target, counter)
		counter += 1
	endWhile
endFunction
Function Proteus_LoadShouts2(String presetName, Actor target, int counter)
	Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Shouts_" + counter + "_" + presetName + ".json")
	Int jItemFormNames = jmap.object()
	String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
	while ItemFormKey 
		Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
		target.AddShout(value as Shout)
		ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
	endwhile
endFunction

Function Proteus_LoadFavoritedSpells(String presetname)
	;mark favorite spells (item means spells)
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedSpells_" +  presetName + ".json"))
			Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedSpells_" +  presetName + ".json")
			Int jItemFormNames = jmap.object()
			String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
			while ItemFormKey 
				Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
				MarkItemAsFavorite(value)
				ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
			endwhile
		EndIf
endFunction

Function Proteus_LoadEquippedSpell(String presetName, Actor target)
    Int JSpellMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_EquippedSpells_" + presetName + ".json")
    Int jSpellFormNames = jmap.object()
    String SpellFormKey = jmap.nextKey(JSpellMapList, "", "")
    while SpellFormKey 
        Spell value = jmap.GetForm(JSpellMapList, SpellFormKey, none) as Spell
		Int indexL = stringutil.Find(SpellFormKey, "_ProteusL_", 0)
		Int indexR = stringutil.Find(SpellFormKey, "_ProteusR_", 0)
		Int indexV = stringutil.Find(SpellFormKey, "_ProteusV_", 0)
		Int indexB = stringutil.Find(SpellFormKey, "_ProteusB_", 0)
		if indexL > 0
			target.EquipSpell(value, 0)
		elseif indexR > 0
			target.EquipSpell(value, 1)
		elseif indexV > 0
			target.EquipSpell(value, 2)
		elseif indexB > 0
			target.EquipSpell(value, 0)
			target.EquipSpell(value, 1)
		endIF
        SpellFormKey = jmap.nextKey(JSpellMapList, SpellFormKey, "")
    endwhile
endFunction


function Proteus_SaveCharacterAppearance(String name, Actor target)
	;saves appearance of the player character
	Proteus_SavePlayerRace(target, name)
	SaveCharacter(name)
	SaveCharacterPreset(target, name)
	ExportHead(name) ;new in v6
	Proteus_SavePlayerPreset(target, name) ;saves preset name to then load at the start of the game

	;create backup jslot as well
	int num1 = ZZNPCAppearanceSaved.GetValue() as Int
	Int num2 = ZZBackupCounter.GetValue() as Int
	String backupName = "ZZProteusBackup" + num1 as String + num2 as String
	SaveCharacter(backupName)
	SaveCharacterPreset(target, backupName)
	ZZBackupCounter.SetValue(ZZBackupCounter.GetValue() + 1)
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


;saves the actor's preset name to a ProteusN_M2 file
function Proteus_SaveTargetStrings(Actor targetBackup, String presetName)
	Int jTextList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Character_GeneralInfo_Template.json")
	Int jNText = jmap.object()
	Int maxCount = jvalue.Count(jTextList)

	Int j = 0
	while j < maxCount
		String value
		String text = jarray.getStr(jTextList, j, "")
		if j == 0
			value = targetBackup.GetActorBase().GetName()
		elseif j == 1
			value = (targetBackup.GetActorBase()).GetSex()
		elseif j == 2
			value = targetBackup.GetRace().GetName() as String
		elseif j == 3
			value = targetBackup.GetBaseAV("CarryWeight") as String
		EndIf
		j += 1
		jmap.SetStr(jNText, text, value)
	endWhile

	jvalue.writeToFile(jNText, JContGlobalPath + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json")
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
					Debug.MessageBox("Change to Male")
					SetSex(target, 0) 
				Elseif (value == 1) ;female
					Debug.MessageBox("Change to Female")
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


function Proteus_SavePlayerRace(Actor target, String presetName)
	Int jRaceList
	Int jRaceForms = jmap.object()
	String raceFormKey = jmap.nextKey(jRaceList, "", "")
	Race value = target.GetRace()
	jmap.SetForm(jRaceForms, "Race", value as form)
	jvalue.writeToFile(jRaceForms, JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
endFunction

function Proteus_SavePlayerPreset(Actor target, String presetName)
	Int jPresetList
	Int jPresetMap = jmap.object()
	String presetKey = jmap.nextKey(jPresetList, "", "")
	jmap.SetStr(jPresetMap, "PresetName", presetName)
	presetKey = jmap.nextKey(jPresetList, presetKey, "")
	jmap.SetStr(jPresetMap, "CarryWeight", target.GetBaseAV("CarryWeight"))
	jvalue.writeToFile(jPresetMap, JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
endFunction


function Proteus_SavePerks(String preset)
	Perk[] knownPerks = ProteusDLLUtils.GetAllPerks(player)
	Perk[] visiblePerks = ProteusDLLUtils.GetAllVisiblePerks(player) 
	;Debug.Notification("Number of Perks: " + allgamePerks.Length)
	Proteus_ExportJSONPerk(preset, visiblePerks, visiblePerks.Length, "/Proteus/Proteus_Character_VisiblePerks_", 0, 1)
	Proteus_ExportJSONPerk(preset, knownPerks, knownPerks.Length, "/Proteus/Proteus_Character_Perks_", 0, 1)
EndFunction


function Proteus_RemovePerks(Actor target, int option) ;option 0 = switch characters, option 1 = reset character
	if option == 0
		RemoveAllPerks(target)
	elseif option == 1
		Proteus_RemovePerks_SlowCheckingProcess(target, 1)
	endIf
EndFunction

;option 0 = save perks to JSON file, option = 1 = remove all known perks from player
function Proteus_RemovePerks_SlowCheckingProcess(Actor target, int option)

	;initial setup
	int perkCountTracker = 0
	Form[] allGamePerks = Utility.CreateFormArray(5000)
	int i

	RemovePerksForAllTrees(target)
	
	;add all vanilla vampire and werewolf perks to JMap
	i = 0
	while i < ZZVanillaPerksListVampireWerewolf.GetSize() && ZZVanillaPerksListVampireWerewolf != NONE
		Perk pPerk = ZZVanillaPerksListVampireWerewolf.GetAt(i) as Perk
		if player.HasPerk(pPerk) == TRUE
			allGamePerks[perkCountTracker] = ZZVanillaPerksListVampireWerewolf.GetAt(i)
			perkCountTracker += 1
		endIf
		i+=1
	endWhile

	;check for vampire or werewolf perks added by mods:
	Int targetModIndex
	;check for Project Proteus patch for the mod "Sacrosanct - Vampires of Skyrim" by EnaiSiaion
	if sacrosanctActive == true
		FormList SacrosanctPerks = Game.GetFormFromFile(0x800, "Proteus - Sacrosanct Patch.esp") As FormList 
		i = 0
		while i < SacrosanctPerks.GetSize()
			Perk pPerk = SacrosanctPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Sacrilege - Minimalistic Vampires of Skyrim" by EnaiSiaion
	if sacrilegeActive == true
		FormList SacrilegePerks = Game.GetFormFromFile(0x800, "Proteus - Sacrilege Patch.esp") As FormList
		i = 0
		while i < SacrilegePerks.GetSize()
			Perk pPerk = SacrilegePerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Better Vampires" by Brehanin
	if betterVampiresActive == true
		FormList BetterVampiresPerks = Game.GetFormFromFile(0x800, "Proteus - Better Vampires Patch.esp") As FormList
		i = 0
		while i < BetterVampiresPerks.GetSize()
			Perk pPerk = BetterVampiresPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Scion - A Vampire Overhaul" by SimonMagus616
	if scionActive == true
		FormList ScionPerks = Game.GetFormFromFile(0x800, "Proteus - Scion Patch.esp") As FormList
		i = 0
		while i < ScionPerks.GetSize()
			Perk pPerk = ScionPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Growl - Werebeasts of Skyrim" by EnaiSiaion
	if growlActive == true
		FormList GrowlPerks = Game.GetFormFromFile(0x800, "Proteus - Growl Patch.esp") As FormList
		i = 0
		while i < GrowlPerks.GetSize()
			Perk pPerk = GrowlPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Lupine - Werewolf Perk Expansion" by DomainWolf
	if lupineActive == true
		FormList LupinePerks = Game.GetFormFromFile(0x800, "Proteus - Lupine Patch.esp") As FormList
		i = 0
		while i < LupinePerks.GetSize()
			Perk pPerk = LupinePerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Manbeast" by SimonMagus616
	if manbeastActive == true
		FormList ManbeastPerks = Game.GetFormFromFile(0x800, "Proteus - Manbeast Patch.esp") As FormList
		i = 0
		while i < ManbeastPerks.GetSize()
			Perk pPerk = ManbeastPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf      
	;check for Project Proteus patch for the mod "Moonlight Tales" by Brevi, AI99, NsJones
	if moonlightTalesActive == true
		FormList MoonlightTalesPerks = Game.GetFormFromFile(0x800, "Proteus - Moonlight Tales Patch.esp") As FormList
		i = 0
		while i < MoonlightTalesPerks.GetSize()
			Perk pPerk = MoonlightTalesPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Curse of the Vampire" by TX12001
	if curseVampireActive == true
		FormList CurseOfTheVampirePerks = Game.GetFormFromFile(0x800, "Proteus - Curse of the Vampire Patch.esp") As FormList
		i = 0
		while i < CurseOfTheVampirePerks.GetSize()
			Perk pPerk = CurseOfTheVampirePerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf  
	;check for Project Proteus patch for the mod "Werewolf Perks Expanded" by MichaelDusk.
	if werewolfPerksExpandedActive == true
		FormList WerewolfPerksExpandedPerks = Game.GetFormFromFile(0x800, "Proteus - Werewolf Perks Expanded Patch.esp") As FormList
		i = 0
		while i < WerewolfPerksExpandedPerks.GetSize()
			Perk pPerk = WerewolfPerksExpandedPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Bloodmoon Rising" by XeNoN.
	if bloodmoonRisingActive == true
		FormList BloodmoonRisingPerks = Game.GetFormFromFile(0x800, "Proteus - Bloodmoon Rising Patch.esp") As FormList
		i = 0
		while i < BloodmoonRisingPerks.GetSize()
			Perk pPerk = BloodmoonRisingPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Sanguinaire" by Christopher4684.
	if sanguinaireActive == true
		FormList SanguinairePerksPerks = Game.GetFormFromFile(0x800, "Proteus - Sanguinaire Patch.esp") As FormList
		i = 0
		while i < SanguinairePerksPerks.GetSize()
			Perk pPerk = SanguinairePerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Wintersun - Faiths of Skyrim" by EnaiSiaion.
	if wintersunActive == true
		FormList WintersunPerksPerks = Game.GetFormFromFile(0x800, "Proteus - Wintersun Patch.esp") As FormList
		i = 0
		while i < WintersunPerksPerks.GetSize()
			Perk pPerk = WintersunPerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Trua - Minimalistic Faiths of Skyrim" by EnaiSiaion.
	if truaActive == true
		FormList TruaPerksPerks = Game.GetFormFromFile(0x800, "Proteus - Trua Patch.esp") As FormList
		i = 0
		while i < TruaPerksPerks.GetSize()
			Perk pPerk = TruaPerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Pilgrim - A Religion Overhaul" by SimonMagus616.
	if pilgrimActive == true
		FormList PilgrimPerksPerks = Game.GetFormFromFile(0x800, "Proteus - Pilgrim Patch.esp") As FormList
		i = 0
		while i < PilgrimPerksPerks.GetSize()
			Perk pPerk = PilgrimPerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Vampyrium-Resurrected (Vampire Overhaul)" by BatStranger.
	if vampyriumActive == true
		FormList VampyriumPerksPerks = Game.GetFormFromFile(0x800, "Proteus - Vampyrium Patch.esp") As FormList
		i = 0
		while i < VampyriumPerksPerks.GetSize()
			Perk pPerk = VampyriumPerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	;check for Project Proteus patch for the mod "Bloodlines of Tamriel - A Vampire Overhaul" by EddieTheEagle.
	if bloodlinesActive == true
		FormList BloodlinesPerksPerks = Game.GetFormFromFile(0x800, "Proteus - Bloodlines Patch.esp") As FormList
		i = 0
		while i < BloodlinesPerksPerks.GetSize()
			Perk pPerk = BloodlinesPerksPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf 
	
	;CHECK FOR RACE PERKS
	;check for Project Proteus patch for the mod "Aetherius - A Race Overhaul"
	if aethActive == true
		FormList AethPerks = Game.GetFormFromFile(0x801, "Proteus - Aetherius Patch.esp") As FormList
		i = 0
		while i < AethPerks.GetSize()
			Perk pPerk = AethPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Morningstar - Minimalistic Races of Skyrim"
	if morningstarActive == true
		FormList MorningstarPerks = Game.GetFormFromFile(0xD62, "Proteus - Morningstar Patch.esp") As FormList
		i = 0
		while i < MorningstarPerks.GetSize()
			Perk pPerk = MorningstarPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Imperious - Races of Skyrim"
	if imperiousActive == true
		FormList ImperiousPerks = Game.GetFormFromFile(0x801, "Proteus - Imperious Patch.esp") As FormList
		i = 0
		while i < ImperiousPerks.GetSize()
			Perk pPerk = ImperiousPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Mysticism - A Magic Overhaul"
	if mysticiscmActive == true
		FormList MystPerks = Game.GetFormFromFile(0x803, "Proteus - Mysticism Patch.esp") As FormList
		i = 0
		while i < MystPerks.GetSize()
			Perk pPerk = MystPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Shadow Spell Package"
	if shadowspellsActive == true
		FormList ShadowPerks = Game.GetFormFromFile(0x802, "Proteus - Shadow Spells Patch.esp") As FormList
		i = 0
		while i < ShadowPerks.GetSize()
			Perk pPerk = ShadowPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Arcanum"
	if arcanumActive == true
		FormList ArcanumPerks = Game.GetFormFromFile(0x803, "Proteus - Arcanum Patch.esp") As FormList
		i = 0
		while i < ArcanumPerks.GetSize()
			Perk pPerk = ArcanumPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Elemental Destruction Magic"
	if edmActive == true
		FormList EDMPerks = Game.GetFormFromFile(0x801, "Proteus - EDM Patch.esp") As FormList
		i = 0
		while i < EDMPerks.GetSize()
			Perk pPerk = EDMPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Colorful Magic"
	if colorfulMagicActive == true
		FormList colorfulMagicPerks = Game.GetFormFromFile(0x900, "Proteus - Colorful Magic Patch.esp") As FormList
		i = 0
		while i < colorfulMagicPerks.GetSize()
			Perk pPerk = colorfulMagicPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;CHECK FOR CUSTOM SKILL FRAMEWORK CUSTOM NEW PERK TREES
	;check for Project Proteus patch for the mod "Custom Skills - VIGILANT" by Vicn.
	if vigilantPerksActive == true
		FormList VigilantPerks = Game.GetFormFromFile(0x800, "Proteus - Vigilant Patch.esp") As FormList
		i = 0
		while i < VigilantPerks.GetSize()
			Perk pPerk = VigilantPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Custom Skills - GLENMORIL" by Vicn.
	if glenmorilPerksActive == true
		FormList GlenmorilPerks = Game.GetFormFromFile(0x800, "Proteus - Glenmoril Patch.esp") As FormList
		i = 0
		while i < GlenmorilPerks.GetSize()
			Perk pPerk = GlenmorilPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Haemophilia" by SeaSparrow.
	if haemophiliaActive == true
		FormList HaemophiliaPerks = Game.GetFormFromFile(0x002F99, "Proteus - Haemophilia Patch.esp") As FormList
		i = 0
		while i < HaemophiliaPerks.GetSize()
			Perk pPerk = HaemophiliaPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Custom Skills - Hand to Hand" by Vicn.
	if handtohandActive == true
		FormList HandToHandPerks = Game.GetFormFromFile(0x800, "Proteus - HandToHand Patch.esp") As FormList
		i = 0
		while i < HandToHandPerks.GetSize()
			Perk pPerk = HandToHandPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Custom Skills - Unarmoured Defense" by Vicn.
	if unarmouredDefenseActive == true
		FormList UnarmouredDefensePerks = Game.GetFormFromFile(0xD61, "Proteus - UnarmouredDefense Patch.esp") As FormList
		i = 0
		while i < UnarmouredDefensePerks.GetSize()
			Perk pPerk = UnarmouredDefensePerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;check for Project Proteus patch for the mod "Dragonborn - Shouts Perk Tree" by DeltaRider.
	if dragonbornCustomPerkActive == true
		FormList DragonbornCustomPerks = Game.GetFormFromFile(0x800, "Proteus - Dragonborn Custom Perk Patch.esp") As FormList
		i = 0
		while i < DragonbornCustomPerks.GetSize()
			Perk pPerk = DragonbornCustomPerks.GetAt(i) as Perk
			if player.HasPerk(pPerk) == TRUE
				allGamePerks[perkCountTracker] = pPerk
				perkCountTracker += 1
			endIf
			i+=1
		endWhile
	endIf
	;remove player known perks from player
	if(option == 1)
		i = 0
		while i < allGamePerks.length && allGamePerks[i] != NONE
			Perk pPerk = allGamePerks[i] as Perk
			String perkName = pPerk.GetName()
			if target.HasPerk(pPerk) == TRUE
				target.RemovePerk(pPerk)
			endIf
			i+=1
		endWhile
	EndIf   
EndFunction


Function Proteus_LoadPerks(String presetName, Actor target)
	int counter = 1
	while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Perks_" + counter + "_" + presetName + ".json"))
		Proteus_LoadPerks2(presetName, target, counter)
		counter += 1
	endWhile
endFunction

Function Proteus_LoadPerks2(String presetName, Actor target, int counter)
		Int JPerkMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Perks_" + counter + "_" + presetName + ".json")
		Int jPerkFormNames = jmap.object()
		String perkFormKey = jmap.nextKey(JPerkMapList, "", "")
		while perkFormKey 
			Perk value = jmap.GetForm(JPerkMapList, perkFormKey, none) as Perk
			target.AddPerk(value)
			perkFormKey = jmap.nextKey(JPerkMapList, perkFormKey, "")
		endwhile
endFunction

Function Proteus_LoadPerksVisible(String presetName, Actor target)
	int counter = 1
	while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_VisiblePerks_" + counter + "_" + presetName + ".json"))
		Proteus_LoadPerksVisible2(presetName, target, counter)
		counter += 1
	endWhile
endFunction

Function Proteus_LoadPerksVisible2(String presetName, Actor target, int counter)
		Int JPerkMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_VisiblePerks_" + counter + "_" + presetName + ".json")
		Int jPerkFormNames = jmap.object()
		String perkFormKey = jmap.nextKey(JPerkMapList, "", "")
		while perkFormKey 
			Perk value = jmap.GetForm(JPerkMapList, perkFormKey, none) as Perk
			target.AddPerk(value)
			perkFormKey = jmap.nextKey(JPerkMapList, perkFormKey, "")
		endwhile
endFunction


Function Proteus_SaveAllItems(String preset, Actor target, Bool saveUnequipped)
    ;variable setup for saving all items into 3 different JSON files (unequipped, equipped, favorites)
    Int favCount = 0
	Form[] favoritedItems = ProteusDLLUtils.GetAllFavoritedItems()

	;---------------------SAVE UNEQUIPPED ITEMS----------------------
	if(saveUnequipped == True)
		Form[] unequippedItems = Utility.CreateFormArray(2000)
		Int[] unequippedItemsCount = Utility.CreateIntArray(2000)

		;PO3 SKSE scripts that will filter inventory to get unequipped items, equipped items, and favorited items
		unequippedItems = AddAllItemsToArray(target, true, false, true)

		;get count unequipped items and record favorited unequipped items
		int e = 0
		while e < unequippedItems.Length
			unequippedItemsCount[e] = target.GetItemCount(unequippedItems[e])
			e+=1
		endWhile    
		Proteus_ExportJSONFormCount(preset, unequippedItems, unequippedItems.Length, unequippedItemsCount, unequippedItemsCount.Length, "/Proteus/Proteus_Character_UnequippedItems_", 0, 1)
	endIf

    ;---------------------SAVE EQUIPPED ITEMS----------------------
    Int equippedCountTracker = 0
    ;load equipped items form array
    Form[] equippedItems = Utility.CreateFormArray(100)
    Int[] equippedItemsCount = Utility.CreateIntArray(100)
    int i = 0
    int slotsChecked
    slotsChecked += 0x00100000
    slotsChecked += 0x00200000 ;ignore reserved slots
    slotsChecked += 0x80000000
    int thisSlot = 0x01
    while (thisSlot < 0x80000000)
        if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check slots we haven't found anything equipped on already
            Armor thisArmor = target.GetWornForm(thisSlot) as Armor
            if (thisArmor)
                equippedItems[i] = thisArmor
                equippedItemsCount[i] = target.GetItemCount(thisArmor)
                i+=1
            else ;no armor was found on this slot
                slotsChecked += thisSlot
            endif
        endif
        thisSlot *= 2 ;double the number to move on to the next slot
    endWhile

	;intial variable assignment and get target left and right hand weapon
	EquipSlot EitherHand = Game.GetForm(0x00013F44) As EquipSlot
	EquipSlot RightHand = Game.GetForm(0x00013F42) As EquipSlot
	EquipSlot LeftHand = Game.GetForm(0x00013F43) As EquipSlot
	EquipSlot BothHands = Game.GetForm(0x00013F45) As EquipSlot

	Form leftHandWeapon
	Form rightHandWeapon
	bool left = false
	bool right = false
	bool continue = true


	if(target.GetEquippedWeapon(true)) ;get left hand weapon
		left = true
		leftHandWeapon = target.GetEquippedWeapon(true)
		equippedItems[i] = leftHandWeapon
        equippedItemsCount[i] = target.GetItemCount(leftHandWeapon)
        i+=1
	endIf
	if(target.GetEquippedWeapon(false)) ;get right hand weapon
		right = true
		rightHandWeapon = target.GetEquippedWeapon(false)
        equippedItems[i] = rightHandWeapon
        equippedItemsCount[i] = target.GetItemCount(rightHandWeapon)
        i+=1
	endIf

	bool leftSelected = false
	bool rightSelected = false
    Int jItemFormListEq
    Int jItemFormNamesEq = jmap.object()
    String ItemFormKeyEq = jmap.nextKey(jItemFormListEq, "", "")
    Form value
    Int itemType
    int j = 0

	Form[] equippedTemp = new Form[100]
	Int equippedTempCount = 0

    while j < equippedItems.Length && equippedItems[j]
        itemType = equippedItems[j].GetType() ;see if clothing, armor, or weapon
        value = jmap.GetForm(jItemFormListEq,ItemFormKeyEq, none)
		if(itemType == 41 && continue == true) ;is this a weapon? 41 is weapon type
			if(left == true && right == true) ;a weapon is equipped in both hands or one weapon is equipped by both hands
				if(leftHandWeapon == equippedItems[j] && rightHandWeapon == equippedItems[j] && (equippedItems[j] as Weapon).GetEquipType() == BothHands) ;is two handed weapon equipped?
					equippedTemp[equippedTempCount] = equippedItems[j]
					equippedTempCount += 1
					jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "B" , equippedItems[j] as Form)
					continue = false
					equippedCountTracker +=1
					leftSelected = true
					rightSelected = true
				elseif(leftHandWeapon == equippedItems[j] && leftSelected == false)  ;is left handed or either handed weapon equipped?
					equippedTemp[equippedTempCount] = equippedItems[j]
					equippedTempCount += 1
					jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "L" , equippedItems[j] as Form)
					equippedCountTracker +=1
					leftSelected = true
				elseif(rightHandWeapon == equippedItems[j] && rightSelected == false)  ;is right handed or either handed weapon equipped?
					equippedTemp[equippedTempCount] = equippedItems[j]
					equippedTempCount += 1
					jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "R" , equippedItems[j] as Form)
					equippedCountTracker +=1
					rightSelected = true
				endIf
			elseif(left == true)
				if(leftHandWeapon == equippedItems[j] && leftSelected == false)  ;is left handed or either handed weapon equipped?
					equippedTemp[equippedTempCount] = equippedItems[j]
					equippedTempCount += 1
					jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "L" , equippedItems[j] as Form)
					equippedCountTracker +=1
					leftSelected = true
				endIf
			elseif(right == true)
				if(rightHandWeapon == equippedItems[j] && rightSelected == false)  ;is right handed or either handed weapon equipped?
					equippedTemp[equippedTempCount] = equippedItems[j]
					equippedTempCount += 1
					jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "R" , equippedItems[j] as Form)
					equippedCountTracker +=1
					rightSelected = true
				endIf
			endIf
		else ;not an equipped weapon
			;check to see if already in map, some items use more than one slot
			int y = 0
			bool saveForm = true
			while y < equippedTemp.Length && equippedTemp != NONE
				if(equippedTemp[y] == equippedItems[j])
					saveForm = false
				endIf
				y += 1
			endWhile
			if saveForm == true
				equippedTemp[equippedTempCount] = equippedItems[j]
				equippedTempCount += 1
				jmap.SetForm(jItemFormNamesEq , equippedCountTracker + " " + equippedItems[j].GetName() + "_ProteusCount" + equippedItemsCount[j] + "_ProteusHand" + "N" , equippedItems[j] as Form)
				equippedCountTracker +=1
			endIf
        endIf
		ItemFormKeyEq = jmap.nextKey(jItemFormListEq, ItemFormKeyEq, "")
        j+=1    
    endwhile
	;save equipped items JSON
    jvalue.writeToFile(jItemFormNamesEq, JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" +  preset + ".json")

    ;save favorited items JSON
	Proteus_ExportJSONForm(preset, favoritedItems, favoritedItems.Length, "/Proteus/Proteus_Character_FavoritedItems_", 0, 0)

endFunction



Function Proteus_AddEquippedItemsSpawn(String preset, Actor target)
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" +  preset + ".json"))
		Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" +  preset + ".json")
		Int jItemFormNames = jmap.object()
		String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
		String itemName
		while ItemFormKey 
			Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
			target.AddItem(value)
			target.EquipItem(value)
			ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
		endwhile
	EndIf
EndFunction


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




Function Proteus_LoadItems(String presetName, Actor target)
	ObjectReference storageContainerUnequipped = Proteus_LoadUnequippedContainerFunction(presetName)
	if(storageContainerUnequipped.GetDisplayname() == presetName)
		storageContainerUnequipped.RemoveAllItems(target, true, true)
	else
		int counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_UnequippedItems_" + counter + "_" + presetName + ".json"))
			Proteus_LoadItems2(presetName, target, 1)
			counter += 1
		endWhile
		
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_"  + presetName + ".json"))
			Proteus_LoadItems3(presetName, target, 1)
		endIf
	endIf
EndFunction

Function Proteus_LoadItems2(String presetName, Actor target, int counter)
    Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_UnequippedItems_" + counter + "_" + presetName + ".json")
    Int jItemFormNames = jmap.object()
    String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
    while ItemFormKey 
        Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
        int amount = StringUtil.Substring(ItemFormKey, StringUtil.Find(ItemFormKey, "ProteusCount") + 12, StringUtil.Find(ItemFormKey, "_ProteusHand")) as Int
		target.AddItem(value, amount)
        ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
    endwhile
EndFunction

Function Proteus_LoadItems3(String presetName, Actor target, int counter)
    Int JItemMapList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" + presetName + ".json")
    Int jItemFormNames = jmap.object()
    String ItemFormKey = jmap.nextKey(JItemMapList, "", "")
    while ItemFormKey 
        Form value = jmap.GetForm(JItemMapList, ItemFormKey, none) as Form
        int amount = StringUtil.Substring(ItemFormKey, StringUtil.Find(ItemFormKey, "ProteusCount") + 12, StringUtil.Find(ItemFormKey, "_ProteusHand")) as Int
		target.AddItem(value, amount)
		while(player.GetItemCount(value) < 0)
		endWhile
		if StringUtil.Find(ItemFormKey, "ProteusHandL", 0) > 0
			target.EquipItemEx(value, 2)
		elseif StringUtil.Find(ItemFormKey, "ProteusHandR", 0) > 0
			target.EquipItemEx(value, 1)
		elseif StringUtil.Find(ItemFormKey, "ProteusHandB", 0) > 0
			target.EquipItemEx(value, 1)
			target.EquipItemEx(value, 2)
		else
			if(target.IsEquipped(value))
			else
				target.EquipItem(value, false, true)	
			endIf
		endIf
        ItemFormKey = jmap.nextKey(JItemMapList, ItemFormKey, "")
    endwhile
EndFunction


Function Proteus_LoadItemsPiecemeal(String presetName, Actor target)
	int counter = 1
	while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_UnequippedItems_" + counter + "_" + presetName + ".json"))

		Proteus_LoadItems2(presetName, target, 1)
		counter += 1
	endWhile
	
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_"  + presetName + ".json"))
		Proteus_LoadItems3(presetName, target, 1)
	endIf
EndFunction

function Proteus_PlayerResistanceFunction(Actor gTarget)
	string[] stringArray = new String[8]
	stringArray[0] = " Resist Fire"
	stringArray[1] = " Resist Frost"
	stringArray[2] = " Resist Shock"
	stringArray[3] = " Resist Poison"
	stringArray[4] = " Resist Disease"
	stringArray[5] = " Stat Summary"
	stringArray[6] = " [Back]"
	stringArray[7] = " [Exit Menu]"

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
		Proteus_PlayerResistanceModifyFunction("fireResist", gTarget)
	elseIf result == 1
		Proteus_PlayerResistanceModifyFunction("frostResist", gTarget)
	elseIf result == 2
		Proteus_PlayerResistanceModifyFunction("ElectricResist", gTarget)
	elseIf result == 3
		Proteus_PlayerResistanceModifyFunction("poisonResist", gTarget)
	elseIf result == 4
		Proteus_PlayerResistanceModifyFunction("diseaseResist", gTarget)
	elseIf result == 5
		Proteus_PlayerSkillSummaryFunction(gTarget)
		Proteus_PlayerResistanceFunction(gTarget)
	elseIf result == 6
		ProteusPlayerMainMenu2()
	elseIf result == 7
	endIf
endFunction


function Proteus_PlayerSkillSummaryFunction(Actor gTarget)
	UIStatsMenu statsMenu = UIExtensions.GetMenu("UIStatsMenu") as UIStatsMenu
	statsMenu.OpenMenu(gTarget)
endFunction



function Proteus_PlayerResistanceModifyFunction(String S, Actor gTarget)
    string[] stringArray
    stringArray= new String[7]
    stringArray[0] = " -25% Resistance"
    stringArray[1] = " -5% Resistance"
    stringArray[2] = " +5% Resistance"
    stringArray[3] = " +25% Resistance"
    stringArray[4] = " Maximum Resistance"
    stringArray[5] = " [Back]"
    stringArray[6] = " [Exit Menu]"

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
        gTarget.SetActorValue(S, gTarget.GetBaseAV(S) - 25)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerResistanceModifyFunction(S, gTarget)
    elseIf result == 1
        gTarget.SetActorValue(S, gTarget.GetBaseAV(S) - 5)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerResistanceModifyFunction(S, gTarget)
    elseIf result == 2
        gTarget.SetActorValue(S, gTarget.GetBaseAV(S) + 5)
        If gTarget.GetBaseAV(S) > 100
            debug.Notification("Resistance cannot be greater than 100. Set to 100.")
            gTarget.SetActorValue(S, 100)
        endIf
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerResistanceModifyFunction(S, gTarget)
    elseIf result == 3
        gTarget.SetActorValue(S, gTarget.GetBaseAV(S) + 25)
        If gTarget.GetBaseAV(S) > 100
            debug.Notification("Resistance cannot be greater than 100. Set to 100.")
            gTarget.SetActorValue(S, 100)
        endIf
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerResistanceModifyFunction(S, gTarget)
    elseIf result == 4
        gTarget.SetActorValue(S, 100)
        debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerResistanceModifyFunction(S, gTarget)
    elseIf result == 5
        Proteus_PlayerResistanceFunction(gTarget)
    endIf
endFunction




Function Proteus_PlayerIdleAnimationFunction(Actor gTarget)
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
	stringArray[21] = " [Back]"
	stringArray[22] = " [Exit Menu]"

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
		Proteus_PlayerMainMenu()
	elseIf result == 22
	endIf
EndFunction


function Proteus_PlayerSkillsFunction(Actor gTarget)
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
	stringArray[19] = " [Back]"
	stringArray[20] = " [Exit Menu]"

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

	if result == 0
		Proteus_PlayerSkillModify("alchemy", gTarget)
	elseIf result == 1
		Proteus_PlayerSkillModify("alteration", gTarget)
	elseIf result == 2
		Proteus_PlayerSkillModify("Marksman", gTarget)
	elseIf result == 3
		Proteus_PlayerSkillModify("block", gTarget)
	elseIf result == 4
		Proteus_PlayerSkillModify("conjuration", gTarget)
	elseIf result == 5
		Proteus_PlayerSkillModify("destruction", gTarget)
	elseIf result == 6
		Proteus_PlayerSkillModify("enchanting", gTarget)
	elseIf result == 7
		Proteus_PlayerSkillModify("heavyArmor", gTarget)
	elseIf result == 8
		Proteus_PlayerSkillModify("illusion", gTarget)
	elseIf result == 9
		Proteus_PlayerSkillModify("lightArmor", gTarget)
	elseIf result == 10
		Proteus_PlayerSkillModify("lockpicking", gTarget)
	elseIf result == 11
		Proteus_PlayerSkillModify("oneHanded", gTarget)
	elseIf result == 12
		Proteus_PlayerSkillModify("pickpocket", gTarget)
	elseIf result == 13
		Proteus_PlayerSkillModify("restoration", gTarget)
	elseIf result == 14
		Proteus_PlayerSkillModify("smithing", gTarget)
	elseIf result == 15
		Proteus_PlayerSkillModify("sneak", gTarget)
	elseIf result == 16
		Proteus_PlayerSkillModify("Speechcraft", gTarget)
	elseIf result == 17
		Proteus_PlayerSkillModify("twoHanded", gTarget)
	elseIf result == 18
		Proteus_PlayerSkillSummaryFunction(gTarget)
		Proteus_PlayerSkillsFunction(gTarget)
	elseIf result == 19
		ProteusPlayerMainMenu2()
	elseIf result == 20
	endIf
EndFunction

int function Proteus_PlayerSizeScaleFunction(Actor gTarget)
	Float size = gTarget.GetScale()

	string[] stringArray
	stringArray= new String[8]
	stringArray[0] = " -0.5 Size"
	stringArray[1] = " -0.1 Size"
	stringArray[2] = " +0.1 Size"
	stringArray[3] = " +0.5 Size"
	stringArray[4] = " Reset Size to 1"
	stringArray[5] = " Custom Size"
	stringArray[6] = " [Back]"
	stringArray[7] = " [Exit Menu]"

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
		Proteus_PlayerSizeScaleFunction(gTarget)
	elseIf result == 1
		gTarget.SetScale(size - 0.1)
		Proteus_PlayerSizeScaleFunction(gTarget)
	elseIf result == 2
		gTarget.SetScale(size + 0.1)
		Proteus_PlayerSizeScaleFunction(gTarget)
	elseIf result == 3
		gTarget.SetScale(size + 0.5)
		Proteus_PlayerSizeScaleFunction(gTarget)
	elseIf result == 4
		gTarget.SetScale(1 as Float)
		Proteus_PlayerSizeScaleFunction(gTarget)
	elseIf result == 5
		String customSizeValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Size: \nBase value is 1. Enter small adjustments like 0.99 or 1.01.")
		if (customSizeValue as Float) > 0 
			Float newAttributeValue = customSizeValue as Float
			gTarget.SetScale(newAttributeValue)
			Proteus_PlayerSizeScaleFunction(gTarget)
		else
			Debug.Notification("Invalid scale size entered. Try again")
			Proteus_PlayerSizeScaleFunction(gTarget)
		endIf
	elseIf result == 6
		ProteusPlayerMainMenu2()
	endIf
endFunction

function Proteus_PlayerAttributeModifyFunction(String S, Actor gTarget)

	Float currentAttributeValue = gTarget.GetBaseAV(S)

	string[] stringArray = new String[9]
	stringArray[0] = " -100 Attribute"
	stringArray[1] = " -50 Attribute"
	stringArray[2] = " -10 Attribute"
	stringArray[3] = " +10 Attribute"
	stringArray[4] = " +50 Attribute"
	stringArray[5] = " +100 Attribute"
	stringArray[6] = " Custom Attribute"
	stringArray[7] = " [Back]"
	stringArray[8] = " [Exit Menu]"

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
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 1
		Float newAttributeValue = currentAttributeValue - 50
		if(newAttributeValue < 0)
			Debug.Notification(S + " cannot be lower than 1. Set to 1.")
			newAttributeValue = 1
		else
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		endIf
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 2
		Float newAttributeValue = currentAttributeValue - 10
		if(newAttributeValue < 0)
			Debug.Notification(S + " cannot be lower than 1. Set to 1.")
			newAttributeValue = 1
		else
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		endIf
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 3
		Float newAttributeValue = currentAttributeValue + 10
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 4
		Float newAttributeValue = currentAttributeValue + 50
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 5
		Float newAttributeValue = currentAttributeValue + 100
			Debug.Notification(S + " is now " +  Proteus_Round(newAttributeValue , 0))
		gTarget.SetActorValue(S, newAttributeValue)
		Proteus_PlayerAttributeModifyFunction(S, gTarget)
	elseIf result == 6
		String customAttributeValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Attribute Value:")
		if (customAttributeValue as Int) > 0 
			Float newAttributeValue = customAttributeValue as Float
			gTarget.SetActorValue(S, newAttributeValue)
			Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
			Proteus_PlayerAttributeModifyFunction(S, gTarget)
		else
			Debug.Notification("Invalid skill level entered. Try again")
			Proteus_PlayerAttributeModifyFunction(S, gTarget)
		endIf
	elseIf result == 7
		Proteus_PlayerAttributesFunction(gTarget)
	elseIf result == 8
	endIf
endFunction

int function Proteus_PlayerAttributesFunction(Actor gTarget)
	
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
	stringArray[9] = " [Back]"
	stringArray[10] = " [Exit Menu]"

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
		Proteus_PlayerAttributeModifyFunction("health", gTarget)
	elseIf result == 1
		Proteus_PlayerAttributeModifyFunction("stamina", gTarget)
	elseIf result == 2
		Proteus_PlayerAttributeModifyFunction("magicka", gTarget)
	elseIf result == 3
		Proteus_PlayerAttributeRegenModify("healRate", gTarget)
	elseIf result == 4
		Proteus_PlayerAttributeRegenModify("staminaRate", gTarget)
	elseIf result == 5
		Proteus_PlayerAttributeRegenModify("magickaRate", gTarget)
	elseIf result == 6
		Proteus_PlayerAttributeModifyFunction("carryWeight", gTarget)
	elseIf result == 7
		gTarget.RestoreAV("Health", 1000000 as Float)
		gTarget.RestoreAV("Stamina", 1000000 as Float)
		gTarget.RestoreAV("Magicka", 1000000 as Float)
		Debug.Notification(gTarget.GetDisplayName() + " Health, Magicka, Stamina fully restored.")
		Proteus_PlayerAttributesFunction(gTarget)
	elseIf result == 8
		Proteus_PlayerSkillSummaryFunction(gTarget)
		Proteus_PlayerAttributesFunction(gTarget)
	elseIf result == 9
		ProteusPlayerMainMenu2()
	elseIf result == 10
		return 0 ;close out of menus	
	endIf
endFunction

function Proteus_PlayerSkillModify(String S, Actor gTarget)
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
	stringArray[7] = " [Back]"
	stringArray[8] = " [Exit Menu]"

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
            gTarget.SetActorValue(S, 0)
        else
            gTarget.SetActorValue(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseif result == 1
        Float newSkillValue = currentSkillValue - 5
        if newSkillValue < 0
            debug.Notification("Skill level cannot be lower than 0. Set to 0.")
            gTarget.SetActorValue(S, 0)
        else
            gTarget.SetActorValue(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseIf result == 2
        Float newSkillValue = currentSkillValue - 1
        if newSkillValue < 0
            debug.Notification("Skill level cannot be lower than 0. Set to 0.")
            gTarget.SetActorValue(S, 0)
        else
            gTarget.SetActorValue(S, newSkillValue)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseIf result == 3
        Float newSkillValue = currentSkillValue +1
        gTarget.SetActorValue(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseIf result == 4
        Float newSkillValue = currentSkillValue +5
        gTarget.SetActorValue(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseIf result == 5
        Float newSkillValue = currentSkillValue +10
        gTarget.SetActorValue(S, newSkillValue)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
        Proteus_PlayerSkillModify(S, gTarget)
    elseIf result == 6
        String customSkillValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Skill Level:")
        if (customSkillValue as Int) > 0 
            Float newSkillValue = customSkillValue as Float
            gTarget.SetActorValue(S, newSkillValue)
            Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 0))
            Proteus_PlayerSkillModify(S, gTarget)
        else
            Debug.Notification("Invalid skill level entered. Try again")
            Proteus_PlayerSkillModify(S, gTarget)
        endIf
    elseIf result == 7
        Proteus_PlayerSkillsFunction(gTarget)
    endIf
endFunction

function Proteus_PlayerAttributeRegenModify(String S, Actor gTarget)

	string[] stringArray = new String[10]
	stringArray[0] = " -5 Regeneration"
	stringArray[1] = " -2 Regeneration"
	stringArray[2] = " -0.5 Regeneration"
	stringArray[3] = " -0.1 Regeneration"
	stringArray[4] = " +0.1 Regeneration"
	stringArray[5] = " +0.5 Regeneration"
	stringArray[6] = " +2 Regeneration"
	stringArray[7] = " +5 Regeneration"
	stringArray[8] = " [Back]"
	stringArray[9] = " [Exit Menu]"

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
        gTarget.SetActorValue(S, -5.00000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountChange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetActorValue(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseif result == 1
        gTarget.SetActorValue(S, -2.00000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountChange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetActorValue(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 2
        gTarget.SetActorValue(S, -0.500000)
        if gTarget.GetBaseAV(S) < 1 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountchange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetActorValue(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 3
        gTarget.SetActorValue(S, -0.100000)
        if gTarget.GetBaseAV(S) < 0 as Float
            debug.Notification("Rate cannot be lower than 0. Set to 0.")
            Float amountchange = 0 as Float - gTarget.GetBaseAV(S)
            gTarget.SetActorValue(S, 0)
        endIf
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 4
        gTarget.SetActorValue(S, 0.100000)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 5
        gTarget.SetActorValue(S, 0.500000)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 6
        gTarget.SetActorValue(S, 2 as Float)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 7
        gTarget.SetActorValue(S, 5 as Float)
        Debug.Notification(S + " is now " +  Proteus_Round(gTarget.GetBaseAV(S) , 1))
        Proteus_PlayerAttributeRegenModify(S, gTarget)
    elseIf result == 8
        Proteus_PlayerAttributesFunction(gTarget)
    elseIf result == 9
    endIf
endFunction




;saves the actor form id to ProteusN_M1 file (only needed if NPC preset to be used across all saved game characters/playthroughs
function Proteus_JSave_NPCForms(Actor targetName, String processedNPCName, String presetName)
	Int jNPCFormList
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		jNPCFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
	endIf

	Int jNFormNames = jmap.object()
	String NPCFormKey = jmap.nextKey(jNPCFormList, "", "")
	Bool insertNewNPC = true
	int i = 0
	Form value
	while NPCFormKey
		value = jmap.GetForm(jNPCFormList,NPCFormKey, none)
		if value == targetName
			insertNewNPC = false
			jmap.SetForm(jNFormNames, i + "_ProteusNPC_" + processedNPCName, value)
		else
			jmap.SetForm(jNFormNames, NPCFormKey, value)
		endIf
		i+=1
		NPCFormKey = jmap.nextKey(jNPCFormList, NPCFormKey, "")
	endWhile
	if insertNewNPC == true
		jmap.SetForm(jNFormNames, i + "_ProteusNPC_" + processedNPCName, targetName as form)
	endIf

	jvalue.writeToFile(jNFormNames, JContGlobalPath + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")

	Proteus_JSave_NPCPresetNames(targetName, processedNPCName, presetName)
endFunction


;saves the actor's preset name to a ProteusN_M2 file, also saves combat style
function Proteus_JSave_NPCPresetNames(Actor targetName, String processedNPCName, String presetName)
	
	combatStyleNum = 0 ;by default combat style is warrior, can change using NPC Module
	
	Int jNPCList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_NPC_GeneralInfo_Template.json")
	Int jNStats = jmap.object()
	Int maxCount = jvalue.Count(jNPCList)
	Int j = 0
	String value
	String stat
	while j < maxCount
		stat = jarray.getStr(jNPCList, j, "")
		if j == 0
			value = presetName
		elseif j == 1
			value = combatStyleNum
		EndIf
		j += 1
		jmap.SetStr(jNStats, stat, value)
	endWhile
	jvalue.writeToFile(jNStats, JContGlobalPath + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
endFunction


Function Proteus_SaveNPCVoiceType(Actor targetName, String processedNPCName)
	;also save voice type
	Int jVTList
    Int JVT = jmap.object()
    jmap.SetForm(JVT, "VT", targetName.GetVoiceType())
    jvalue.writeToFile(JVT, JContGlobalPath + "/Proteus/Proteus_Character_VT_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + processedNPCName + ".json")
endFunction



function Proteus_PlayerPiecemealSaveFunction(Actor target)
	Proteus_LockEnable()
	characterSavingName = target.GetActorBase().GetName()
	
	string[] stringArray = new String[8]
	stringArray[0] = " Save Skills & Attributes"
	stringArray[1] = " Save Perks"
	stringArray[2] = " Save Spells"
	stringArray[3] = " Save Appearance"
	stringArray[4] = " Save Appearance & Equipped Items"
	stringArray[5] = " Save Inventory"
	stringArray[6] = " [Back]"
	stringArray[7] = " [Exit Menu]"

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

	if result == 0 ;save skills/attributes/stats
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character's stats as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_SaveSkillsAttributes(presetName, target)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " stats saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 1 ;save perks
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character's perks as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_SavePerks(presetName)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " perks saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 2 ;save spells
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character's spells as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_SaveSpells(presetName, target)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " spells saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 3 ;save appearance
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character appearance preset as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		String playerName = player.GetActorBase().GetName()
		if lengthPresetName > 0
			Proteus_SaveTargetStrings(player, presetName)
			Proteus_SaveCharacterAppearance(presetName, player) ;save appearance of target's character (including race)
			SaveAppearancePresetJSON(player.GetActorBase().GetName(), presetName)
			SavePresetGlobalVariables(playerName)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " appearance saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 4 ;save appearance and equipped items
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character appearance preset as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		String playerName = player.GetActorBase().GetName()
		if lengthPresetName > 0
			Proteus_SaveTargetStrings(player, presetName)
			Proteus_SaveCharacterAppearance(presetName, player) ;save appearance of target's character (including race)
			SaveAppearancePresetJSON(player.GetActorBase().GetName(), presetName)
			SavePresetGlobalVariables(playerName)
			Proteus_SaveAllItems(presetName, player, false)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " appearance & equipped items saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 5 ;save inventory
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Save player character's inventory as:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_SaveAllItems(presetName, player, true)
			Utility.Wait(0.1)
			Debug.Notification(characterSavingName + " inventory saved successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 6 ;back
		Proteus_PlayerMainMenu()
	elseif result == 7 ;exit
	endIf

	Proteus_LockDisable()

endFunction



function Proteus_PlayerPiecemealLoadFunction(Actor target)
	Proteus_LockEnable()
	characterSavingName = target.GetActorBase().GetName()

	string[] stringArray = new String[8]
	stringArray[0] = " Load Skills & Attributes"
	stringArray[1] = " Load Perks"
	stringArray[2] = " Load Spells"
	stringArray[3] = " Load Appearance"
	stringArray[4] = " Load Appearance & Equipped Items"
	StringArray[5] = " Add Inventory Items"
	stringArray[6] = " [Back]"
	stringArray[7] = " [Exit Menu]"

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

	if result == 0 ;load skills/attributes/stats
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player character's stats?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_LoadSkillsAttributes(presetName, target, 0)
			Debug.Notification(presetName + " stats loaded successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 1 ;load perks
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player character's perks?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_RemovePerks(player, 0)
			Proteus_LoadPerks(presetName, target)
			Game.SetPerkPoints(totalPerkPointsAvailable) 
			Debug.Notification(presetName + " perks loaded successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 2 ;load spells
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player character's spells?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_RemoveSpells(target, 0)
			Proteus_LoadSpells(presetName, target)
			Debug.Notification(presetName + " spells loaded successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 3 ;load appearance
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player character appearance preset?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		String playerName = player.GetActorBase().GetName()
		if (lengthPresetName > 0)
			Race currentRace = player.GetRace()	
			Race presetRace = player.GetRace()
			Proteus_LoadTargetStrings(presetName, player, 1) ;change gender if needed
			presetRace = Proteus_LoadCharacterRace(presetName)
			if(explosionsOn.GetValue() == 1)
				player.PlaceAtMe(greenExplosion, 1)
			endIf
			Proteus_LoadCharacterAppearance(presetName, player, currentRace, presetRace, 0)
			Int jPresetList
			Int jPresetMap = jmap.object()
			String presetKey = jmap.nextKey(jPresetList, "", "")
			jmap.SetStr(jPresetMap, "PresetName", presetName)
			presetKey = jmap.nextKey(jPresetList, presetKey, "")
			jmap.SetStr(jPresetMap, "CarryWeight", player.GetBaseAV("CarryWeight"))
			jvalue.writeToFile(jPresetMap, JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
			;make system recognize this preset has been loaded
			String processedPLAYERPRESETName = processName(presetName)
			ZZHasSavedPlayerCharacter.SetValue(ZZHasSavedPlayerCharacter.GetValue() + 1)
			SaveAppearancePresetJSON(playerName, processedPLAYERPRESETName)
			SavePresetGlobalVariables(playerName)
			Debug.Notification(presetName + " appearance loaded successfully.")

		endIf
	elseif result == 4 ;load appearance and equipped items
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Load which player character appearance preset?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		String playerName = player.GetActorBase().GetName()
		if (lengthPresetName > 0)
			Race currentRace = player.GetRace()	
			Race presetRace = player.GetRace()
			Proteus_LoadTargetStrings(presetName, player, 1) ;change gender if needed
			presetRace = Proteus_LoadCharacterRace(presetName)
			if(explosionsOn.GetValue() == 1)
				player.PlaceAtMe(greenExplosion, 1)
			endIf
			Proteus_LoadCharacterAppearance(presetName, player, currentRace, presetRace, 0)
			Int jPresetList
			Int jPresetMap = jmap.object()
			String presetKey = jmap.nextKey(jPresetList, "", "")
			jmap.SetStr(jPresetMap, "PresetName", presetName)
			presetKey = jmap.nextKey(jPresetList, presetKey, "")
			jmap.SetStr(jPresetMap, "CarryWeight", player.GetBaseAV("CarryWeight"))
			jvalue.writeToFile(jPresetMap, JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
			;make system recognize this preset has been loaded
			String processedPLAYERPRESETName = processName(presetName)
			ZZHasSavedPlayerCharacter.SetValue(ZZHasSavedPlayerCharacter.GetValue() + 1)
			SaveAppearancePresetJSON(playerName, processedPLAYERPRESETName)
			SavePresetGlobalVariables(playerName)
			Proteus_EquipItems(presetName, player)
			Debug.Notification(presetName + " appearance & equipped items loaded successfully.")

		endIf
	elseif result == 5 ;load inventory
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add which player character's items?")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			Proteus_LoadItemsPiecemeal(presetName, target) 
			Utility.Wait(0.1)
			Debug.Notification(presetName + " inventory loaded successfully.")
		else
			Debug.Notification("Invalid preset name entered. Try again.")
		endIf
	elseif result == 6 ;back
		Proteus_PlayerMainMenu()
	elseif result == 7 ;exit
	endIf

	Proteus_LockDisable()
endFunction


Function Proteus_SwitchCharacter()

	String targetSwitchName = Proteus_SelectPresetSwitch(false)

	if(targetSwitchName != "")
		;find this presetname character
		Actor target
		if ZZCustomM1.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM1
		elseif ZZCustomM2.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM2
		elseif ZZCustomM3.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM3
		elseif ZZCustomM4.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM4
		elseif ZZCustomM5.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM5
		elseif ZZCustomM6.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM6
		elseif ZZCustomM7.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM7
		elseif ZZCustomM8.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM8
		elseif ZZCustomM9.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM9
		elseif ZZCustomM10.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomM10
		elseif ZZCustomF1.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF1
		elseif ZZCustomF2.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF2
		elseif ZZCustomF3.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF3
		elseif ZZCustomF4.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF4
		elseif ZZCustomF5.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF5
		elseif ZZCustomF6.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF6
		elseif ZZCustomF7.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF7
		elseif ZZCustomF8.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF8
		elseif ZZCustomF9.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF9
		elseif ZZCustomF10.GetActorBase().GetName() == targetSwitchName
			target = ZZCustomF10
		endIf

		String targetName = target.GetActorBase().GetName()
		Int targetNameLength = StringUtil.GetLength(targetName)
		String targetPresetName
		String playerPresetName

		if (targetNameLength > 0)	
			;save current character 
			String playerName = player.GetActorBase().GetName()
			Proteus_CharacterSave(player, playerName)
			Utility.Wait(0.1)

			if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + targetName + ".json"))
				Int JNPCList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_NPC_GeneralInfo_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + "_" + targetName + ".json")
				Int jStats = jmap.object()
				String stat = jmap.nextKey(JNPCList, "", "")

				String value = jmap.GetStr(JNPCList, stat, "")
				if stat == "name"
					targetPresetName = value
				endIf
				stat = jmap.nextKey(JNPCList, stat, "")
				value = jmap.GetStr(JNPCList, stat, "")
				if stat == "name"
					targetPresetName = value
				endIf
			else
				Debug.Notification("Target preset name not found. Switch failed.")
			EndIf

			if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json") == true) 		
				Int JPlayerList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
				Int jStats = jmap.object()
				String playerPresetNameKey = jmap.nextKey(JPlayerList, "", "")

				while playerPresetNameKey
					String value = jmap.GetStr(JPlayerList, playerPresetNameKey, none) as String
					if playerPresetNameKey == "PresetName"
						playerPresetName = value
					EndIf
					playerPresetNameKey = jmap.nextKey(JPlayerList, playerPresetNameKey, "")
				endWhile

				if playerPresetName != "" && targetPresetName != "" && playerPresetName != targetPresetName
					Utility.Wait(0.1)

					;load target preset on player
					Proteus_LoadCharacter(player, targetPresetName)
					Proteus_ResetSpawn(targetPresetName)
					Utility.Wait(0.1)
					Proteus_LoadCharacterSpawn(target, playerPresetName)
					Utility.Wait(0.1)

					ColorForm colorHair = player.GetActorBase().GetHairColor()
					LoadCharacterPreset(player, targetPresetName, colorHair)

					target.DispelAllSpells()

					;clear notifications
					playerMarker.MoveTo(player)
					player.MoveTo(playerMarker)
					Debug.Notification("Character switch complete.")
				elseif playerPresetName == targetPresetName
					Debug.Notification("ERROR: Player and target preset name match.")
				endIf
				
			else
				Debug.Notification("Player preset name not found. Swap failed.")
			EndIf
		endIf
	else
		;Debug.Notification("No player spawn nearby to swap with.")
	endIf
EndFunction


Function Proteus_ResetSpawn(String name)
	Actor resetActor = Proteus_GetSpawningActor(name)
	if resetActor == NONE
		;do nothing, spawn doesn't exist
	else
		resetActor.GetActorBase().SetName("Unused Slot")
		resetActor.MoveTo(voidMarker)
	
		Int jNPCFormList
		jNPCFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")	
		Int jNFormNames = jmap.object()
		String NPCFormKey = jmap.nextKey(jNPCFormList, "", "")
		Bool insertNewNPC = true
		int i = 0
		while NPCFormKey
			Actor value = jmap.GetForm(jNPCFormList,NPCFormKey, none) as Actor
			if value == name
			else
				jmap.SetForm(jNFormNames, NPCFormKey, value as form)
			endIf
			i+=1
			NPCFormKey = jmap.nextKey(jNPCFormList, NPCFormKey, "")
		endWhile
		;write file with removed NPC form
		jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/Proteus_NPC_List_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
	endif
EndFunction

Actor Function Proteus_TeleportExistingSummonToPlayer(String name)
	Actor summonedActor
	Actor[] actorArray = new Actor[20]
	Actor[] actorArrayTemp = new Actor[20]
	string[] stringArray = new String[20]
	Int count = 0

    actorArray[0] = ZZCustomM1
    actorArray[1] = ZZCustomM2
    actorArray[2] = ZZCustomM3
    actorArray[3] = ZZCustomM4
    actorArray[4] = ZZCustomM5
    actorArray[5] = ZZCustomM6
    actorArray[6] = ZZCustomM7
    actorArray[7] = ZZCustomM8
    actorArray[8] = ZZCustomM9
    actorArray[9] = ZZCustomM10
    actorArray[10] = ZZCustomF1
    actorArray[11] = ZZCustomF2
    actorArray[12] = ZZCustomF3
    actorArray[13] = ZZCustomF4
    actorArray[14] = ZZCustomF5
    actorArray[15] = ZZCustomF6
    actorArray[16] = ZZCustomF7
    actorArray[17] = ZZCustomF8
    actorArray[18] = ZZCustomF9
    actorArray[19] = ZZCustomF10

	int result
	if(name == "")

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 20
			int i = 0
			while i < n
				if(actorArray[i].GetActorBase().GetName() != "Unused Slot")
					listMenu.AddEntryItem(actorArray[i].GetActorBase().GetName())
					actorArrayTemp[count] = actorArray[i]
					count += 1
				endIf
				i += 1
			endwhile
			listMenu.AddEntryItem("[Exit Menu]")
		EndIf
		listMenu.OpenMenu()
		result = listMenu.GetResultInt()
		if result == 0
			summonedActor =  actorArrayTemp[0]
		elseif result == 1
			summonedActor =  actorArrayTemp[1]
		elseif result == 2
			summonedActor =  actorArrayTemp[2]
		elseif result == 3
			summonedActor =  actorArrayTemp[3]
		elseif result == 4
			summonedActor =  actorArrayTemp[4]
		elseif result == 5
			summonedActor =  actorArrayTemp[5]
		elseif result == 6
			summonedActor =  actorArrayTemp[6]
		elseif result == 7
			summonedActor =  actorArrayTemp[7]
		elseif result == 8
			summonedActor =  actorArrayTemp[8]
		elseif result == 9
			summonedActor =  actorArrayTemp[9]
		elseif result == 10
			summonedActor =  actorArrayTemp[10]
		elseif result == 11
			summonedActor =  actorArrayTemp[11]
		elseif result == 12
			summonedActor =  actorArrayTemp[12]
		elseif result == 13
			summonedActor =  actorArrayTemp[13]
		elseif result == 14
			summonedActor =  actorArrayTemp[14]
		elseif result == 15
			summonedActor =  actorArrayTemp[15]
		elseif result == 16
			summonedActor =  actorArrayTemp[16]
		elseif result == 17
			summonedActor =  actorArrayTemp[17]
		elseif result == 18
			summonedActor =  actorArrayTemp[18]
		elseif result == 19
			summonedActor =  actorArrayTemp[19]
		elseif result == 20
		endIf
	else
		if name == actorArray[0].GetActorBase().GetName()
			summonedActor =  ZZCustomM1
		elseif name == actorArray[1].GetActorBase().GetName()
			summonedActor =  ZZCustomM2
		elseif name == actorArray[2].GetActorBase().GetName()
			summonedActor =  ZZCustomM3
		elseif name == actorArray[3].GetActorBase().GetName()
			summonedActor =  ZZCustomM4
		elseif name == actorArray[4].GetActorBase().GetName()
			summonedActor =  ZZCustomM5
		elseif name == actorArray[5].GetActorBase().GetName()
			summonedActor =  ZZCustomM6
		elseif name == actorArray[6].GetActorBase().GetName()
			summonedActor =  ZZCustomM7
		elseif name == actorArray[7].GetActorBase().GetName()
			summonedActor =  ZZCustomM8
		elseif name == actorArray[8].GetActorBase().GetName()
			summonedActor =  ZZCustomM9
		elseif name == actorArray[9].GetActorBase().GetName()
			summonedActor =  ZZCustomM10
		elseif name == actorArray[10].GetActorBase().GetName()
			summonedActor =  ZZCustomF1
		elseif name == actorArray[11].GetActorBase().GetName()
			summonedActor =  ZZCustomF2
		elseif name == actorArray[12].GetActorBase().GetName()
			summonedActor =  ZZCustomF3
		elseif name == actorArray[13].GetActorBase().GetName()
			summonedActor =  ZZCustomF4
		elseif name == actorArray[14].GetActorBase().GetName()
			summonedActor =  ZZCustomF5
		elseif name == actorArray[15].GetActorBase().GetName()
			summonedActor =  ZZCustomF6
		elseif name == actorArray[16].GetActorBase().GetName()
			summonedActor =  ZZCustomF7
		elseif name == actorArray[17].GetActorBase().GetName()
			summonedActor =  ZZCustomF8
		elseif name == actorArray[18].GetActorBase().GetName()
			summonedActor =  ZZCustomF9
		elseif name == actorArray[19].GetActorBase().GetName()
			summonedActor =  ZZCustomF10
		endIf
	endIf

	;String summonedActorName = summonedActor.GetActorBase().GetName()
	Int indexF1 = stringutil.Find(name, "Unused Slot", 0)

	if indexF1 >= 0
		Debug.MessageBox("No player character follower loaded on this slot.")
	elseif result != -1 && result != 20
		summonedActor.MoveTo(player)
	EndIf

endFunction



function Proteus_RegisterLoadedPresetOption(Actor targetName, String processedPLAYERPRESETName, String presetName, bool isSpawn)
	playerPresetFirstLoad = false
    Int jPLAYERPRESETFormList
    if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
        jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
    endIf
    Int jNFormNames = jmap.object()
    String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
    Bool insertNewPLAYERPRESET = true
    int i = 0
    String value
    while PLAYERPRESETFormKey
        value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
        if value == processedPLAYERPRESETName
            insertNewPLAYERPRESET = false
            jmap.SetStr(jNFormNames, i + "_ProteusPlayerPreset_" + processedPLAYERPRESETName, value)
			if(!isSpawn)
				ZZPresetLoadedCounter.SetValue(i)
			endif
        else
            jmap.SetStr(jNFormNames, PLAYERPRESETFormKey, value)
        endIf
        i+=1
        PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
    endWhile
    if insertNewPLAYERPRESET == true
        jmap.SetStr(jNFormNames, i + "_ProteusPlayerPreset_" + processedPLAYERPRESETName, presetName)
		if(!isSpawn)
			ZZPresetLoadedCounter.SetValue(i)
		endif
		playerPresetFirstLoad = true
    endIf
    jvalue.writeToFile(jNFormNames, JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
endFunction



String Function Proteus_SelectPresetSwitch(bool delete)
	presetsLoaded = new String[100]
    Int jPLAYERPRESETFormList
    if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
        jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
    endIf

	String playerName = player.GetActorBase().GetName()

	Int jNFormNames = jmap.object()
    String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
    int i = 0
    String value
    while PLAYERPRESETFormKey
        value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
		if(value != playerName)
       		presetsLoaded[i] = value
			i+=1
		endIf
        PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
    endWhile


	String[] stringArray = new String[20]
	stringArray[0] = ZZCustomM1.GetActorBase().GetName()
	stringArray[1] = ZZCustomM2.GetActorBase().GetName()
	stringArray[2] = ZZCustomM3.GetActorBase().GetName()
	stringArray[3] = ZZCustomM4.GetActorBase().GetName()
	stringArray[4] = ZZCustomM5.GetActorBase().GetName()
	stringArray[5] = ZZCustomM6.GetActorBase().GetName()
	stringArray[6] = ZZCustomM7.GetActorBase().GetName()
	stringArray[7] = ZZCustomM8.GetActorBase().GetName()
	stringArray[8] = ZZCustomM9.GetActorBase().GetName()
	stringArray[9] = ZZCustomM10.GetActorBase().GetName()
	stringArray[10] = ZZCustomF1.GetActorBase().GetName()
	stringArray[11] = ZZCustomF2.GetActorBase().GetName()
	stringArray[12] = ZZCustomF3.GetActorBase().GetName()
	stringArray[13] = ZZCustomF4.GetActorBase().GetName()
	stringArray[14] = ZZCustomF5.GetActorBase().GetName()
	stringArray[15] = ZZCustomF6.GetActorBase().GetName()
	stringArray[16] = ZZCustomF7.GetActorBase().GetName()
	stringArray[17] = ZZCustomF8.GetActorBase().GetName()
	stringArray[18] = ZZCustomF9.GetActorBase().GetName()
	stringArray[19] = ZZCustomF10.GetActorBase().GetName()

	;include any preset loaded that currently matches the name of an NPC
	String[] newArray = new String[100]
	i = 0
	int counter
	while i < presetsLoaded.Length && presetsLoaded[i] != ""
		int z = 0
		bool include = false
		if delete == false
			while z < stringArray.Length && stringArray[z] != ""	;include characters already on spawns in the list
				if(presetsLoaded[i] == stringArray[z])
					include = true
				endIf
				z += 1
			endWhile
		elseif delete == true
			include = true
		endIf

		if presetsLoaded[i] == playerName ;don't include current player character in import list
			include = false
		endIf
		if include == true
			newArray[counter] = presetsLoaded[i]
			counter += 1
		endIf
		i += 1
	endWhile

	string[] stringArray2 = new String[100]
	int k = 0
	while StringUtil.GetLength(newArray[k]) > 0
		stringArray2[k] = newArray[k]
		k+=1
	endWhile
	stringArray2[k] = " [Exit Menu]"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = k+1
		i = 0
		while i < n
			listMenu.AddEntryItem(stringArray2[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int exitOption = k

	if (result == exitOption)
		return ""
	else
		return stringArray2[result]
	endIf
endFunction


String Function Proteus_SelectPresetSpawn()
	presetsLoaded = new String[100]

    Int jPLAYERPRESETFormList
    if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
        jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
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
	stringArray[k] = " [Manually Enter Name]"
	k+=1
	stringArray[k] = " [Exit Menu]"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = k+1
		i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int customOption = k - 1
	int exitOption = k

	if (result == exitOption)
		;Debug.Notification("No preset selected.")
		return ""
	elseif(result == customOption)
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Enter character name:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)	
			return presetName
		else
			return ""
		endIf
	else
		return stringArray[result]
	endIf
endFunction

String Function Proteus_SelectPresetSpawnImport()
	presetsLoaded = new String[120]

	int loadedPresetCount = 0
	int presetFileCounter = 1
	int failStreak = 0
	int previousPresetFileCounter = 0

	while presetFileCounter < 120
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + presetFileCounter + ".json"))
			Int jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + presetFileCounter + ".json")
			Int jNFormNames = jmap.object()
			String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
			String value
			while PLAYERPRESETFormKey
				value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
				int k = 0
				bool include = true
				while k < loadedPresetCount
					if(value  == presetsLoaded[k])
						include = false
					endIf
					k+=1
				endWhile
				if include == true
					presetsLoaded[loadedPresetCount] = value
					loadedPresetCount += 1
				endIf
				PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
			endWhile
		elseif failStreak > 3
			presetFileCounter = 121
		else
			if(previousPresetFileCounter == (presetFileCounter - 1))
				failStreak += 1
			else
				failStreak = 0
			endIf
			previousPresetFileCounter = presetFileCounter
		endIf
		presetFileCounter += 1
	endWhile


	String[] stringArray = new String[20]
	stringArray[0] = ZZCustomM1.GetActorBase().GetName()
	stringArray[1] = ZZCustomM2.GetActorBase().GetName()
	stringArray[2] = ZZCustomM3.GetActorBase().GetName()
	stringArray[3] = ZZCustomM4.GetActorBase().GetName()
	stringArray[4] = ZZCustomM5.GetActorBase().GetName()
	stringArray[5] = ZZCustomM6.GetActorBase().GetName()
	stringArray[6] = ZZCustomM7.GetActorBase().GetName()
	stringArray[7] = ZZCustomM8.GetActorBase().GetName()
	stringArray[8] = ZZCustomM9.GetActorBase().GetName()
	stringArray[9] = ZZCustomM10.GetActorBase().GetName()
	stringArray[10] = ZZCustomF1.GetActorBase().GetName()
	stringArray[11] = ZZCustomF2.GetActorBase().GetName()
	stringArray[12] = ZZCustomF3.GetActorBase().GetName()
	stringArray[13] = ZZCustomF4.GetActorBase().GetName()
	stringArray[14] = ZZCustomF5.GetActorBase().GetName()
	stringArray[15] = ZZCustomF6.GetActorBase().GetName()
	stringArray[16] = ZZCustomF7.GetActorBase().GetName()
	stringArray[17] = ZZCustomF8.GetActorBase().GetName()
	stringArray[18] = ZZCustomF9.GetActorBase().GetName()
	stringArray[19] = ZZCustomF10.GetActorBase().GetName()

	String playerName = player.GetActorBase().GetName()

	;remove any preset loaded that currently matches the name of an NPC
	String[] newArray = new String[100]
	int i = 0
	int counter
	while i < presetsLoaded.Length && presetsLoaded[i] != ""
		int z = 0
		bool include = true
		while z < stringArray.Length && stringArray[z] != ""	;don't include characters already on spawns in the list
			if(presetsLoaded[i] == stringArray[z])
				include = false
			endIf
			z += 1
		endWhile
		if presetsLoaded[i] == playerName ;don't include current player character in import list
			include = false
		endIf
		if include == true
			newArray[counter] = presetsLoaded[i]
			counter += 1
		endIf
		i += 1
	endWhile

	string[] stringListArray = new String[100]
	int k = 0
	while k < newArray.Length && newArray[k] != ""
		stringListArray[k] = newArray[k]
		k+=1
	endWhile
	stringListArray[k] = " [Manually Enter Name]"
	k+=1
	stringListArray[k] = " [Exit Menu]"
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = k+1
		i = 0
		while i < n
			listMenu.AddEntryItem(stringListArray[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int customOption = k - 1
	int exitOption = k

	if (result == exitOption)
		;Debug.Notification("No preset selected.")
		return ""
	elseif(result == customOption)
		String presetName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Enter character name:")
		Int lengthPresetName = StringUtil.GetLength(presetName as String)
		if (lengthPresetName > 0)
			bool include = true
			i = 0
			while i < stringArray.Length && stringArray[i] != ""
				if stringArray[i] == presetName ;allow to load or not?
					include = false
				endIf
				i += 1
			endWhile

			if include == true
				return presetName
			else
				Debug.MessageBox("This character already exists in this game world. Import cancelled.")
				Utility.Wait(0.1)
			endIf
		else
			return ""
		endIf
	else
		return stringListArray[result]
	endIf
endFunction





ObjectReference Function Proteus_SaveUnequippedContainerFunction(String preset)
    String targetName = preset
    if(UnequippedContainer1.GetDisplayName() == targetName || UnequippedContainer1.GetDisplayName() == "DefaultChest")
        return UnequippedContainer1
    elseif(UnequippedContainer2.GetDisplayName() == targetName || UnequippedContainer2.GetDisplayName() == "DefaultChest")
        return UnequippedContainer2
    elseif(UnequippedContainer3.GetDisplayName() == targetName || UnequippedContainer3.GetDisplayName() == "DefaultChest")
        return UnequippedContainer3
    elseif(UnequippedContainer4.GetDisplayName() == targetName || UnequippedContainer4.GetDisplayName() == "DefaultChest")
        return UnequippedContainer4
    elseif(UnequippedContainer5.GetDisplayName() == targetName || UnequippedContainer5.GetDisplayName() == "DefaultChest")
        return UnequippedContainer5
    elseif(UnequippedContainer6.GetDisplayName() == targetName || UnequippedContainer6.GetDisplayName() == "DefaultChest")
        return UnequippedContainer6
    elseif(UnequippedContainer7.GetDisplayName() == targetName || UnequippedContainer7.GetDisplayName() == "DefaultChest")
        return UnequippedContainer7
    elseif(UnequippedContainer8.GetDisplayName() == targetName || UnequippedContainer8.GetDisplayName() == "DefaultChest")
        return UnequippedContainer8
    elseif(UnequippedContainer9.GetDisplayName() == targetName || UnequippedContainer9.GetDisplayName() == "DefaultChest")
        return UnequippedContainer9
    elseif(UnequippedContainer10.GetDisplayName() == targetName || UnequippedContainer10.GetDisplayName() == "DefaultChest")
        return UnequippedContainer10
    elseif(UnequippedContainer11.GetDisplayName() == targetName || UnequippedContainer11.GetDisplayName() == "DefaultChest")
        return UnequippedContainer11
    elseif(UnequippedContainer12.GetDisplayName() == targetName || UnequippedContainer12.GetDisplayName() == "DefaultChest")
        return UnequippedContainer12
    elseif(UnequippedContainer13.GetDisplayName() == targetName || UnequippedContainer13.GetDisplayName() == "DefaultChest")
        return UnequippedContainer13
    elseif(UnequippedContainer14.GetDisplayName() == targetName || UnequippedContainer14.GetDisplayName() == "DefaultChest")
        return UnequippedContainer14
    elseif(UnequippedContainer15.GetDisplayName() == targetName || UnequippedContainer15.GetDisplayName() == "DefaultChest")
        return UnequippedContainer15
    elseif(UnequippedContainer16.GetDisplayName() == targetName || UnequippedContainer16.GetDisplayName() == "DefaultChest")
        return UnequippedContainer16
    elseif(UnequippedContainer17.GetDisplayName() == targetName || UnequippedContainer17.GetDisplayName() == "DefaultChest")
        return UnequippedContainer17
    elseif(UnequippedContainer18.GetDisplayName() == targetName || UnequippedContainer18.GetDisplayName() == "DefaultChest")
        return UnequippedContainer18
    elseif(UnequippedContainer19.GetDisplayName() == targetName || UnequippedContainer19.GetDisplayName() == "DefaultChest")
        return UnequippedContainer19
    elseif(UnequippedContainer20.GetDisplayName() == targetName || UnequippedContainer20.GetDisplayName() == "DefaultChest")
        return UnequippedContainer20
    elseif(UnequippedContainer21.GetDisplayName() == targetName || UnequippedContainer21.GetDisplayName() == "DefaultChest")
        return UnequippedContainer21
    elseif(UnequippedContainer22.GetDisplayName() == targetName || UnequippedContainer22.GetDisplayName() == "DefaultChest")
        return UnequippedContainer22
    elseif(UnequippedContainer23.GetDisplayName() == targetName || UnequippedContainer23.GetDisplayName() == "DefaultChest")
        return UnequippedContainer23
    elseif(UnequippedContainer24.GetDisplayName() == targetName || UnequippedContainer24.GetDisplayName() == "DefaultChest")
        return UnequippedContainer24
    elseif(UnequippedContainer25.GetDisplayName() == targetName || UnequippedContainer25.GetDisplayName() == "DefaultChest")
        return UnequippedContainer25
    elseif(UnequippedContainer26.GetDisplayName() == targetName || UnequippedContainer26.GetDisplayName() == "DefaultChest")
        return UnequippedContainer26
    elseif(UnequippedContainer27.GetDisplayName() == targetName || UnequippedContainer27.GetDisplayName() == "DefaultChest")
        return UnequippedContainer27
    elseif(UnequippedContainer28.GetDisplayName() == targetName || UnequippedContainer28.GetDisplayName() == "DefaultChest")
        return UnequippedContainer28
    elseif(UnequippedContainer29.GetDisplayName() == targetName || UnequippedContainer29.GetDisplayName() == "DefaultChest")
        return UnequippedContainer29
    elseif(UnequippedContainer30.GetDisplayName() == targetName || UnequippedContainer30.GetDisplayName() == "DefaultChest")
        return UnequippedContainer30
    elseif(UnequippedContainer31.GetDisplayName() == targetName || UnequippedContainer31.GetDisplayName() == "DefaultChest")
        return UnequippedContainer31
    elseif(UnequippedContainer32.GetDisplayName() == targetName || UnequippedContainer32.GetDisplayName() == "DefaultChest")
        return UnequippedContainer32
    elseif(UnequippedContainer33.GetDisplayName() == targetName || UnequippedContainer33.GetDisplayName() == "DefaultChest")
        return UnequippedContainer33
    elseif(UnequippedContainer34.GetDisplayName() == targetName || UnequippedContainer34.GetDisplayName() == "DefaultChest")
        return UnequippedContainer34
    elseif(UnequippedContainer35.GetDisplayName() == targetName || UnequippedContainer35.GetDisplayName() == "DefaultChest")
        return UnequippedContainer35
    elseif(UnequippedContainer36.GetDisplayName() == targetName || UnequippedContainer36.GetDisplayName() == "DefaultChest")
        return UnequippedContainer36
    elseif(UnequippedContainer37.GetDisplayName() == targetName || UnequippedContainer37.GetDisplayName() == "DefaultChest")
        return UnequippedContainer37
    elseif(UnequippedContainer38.GetDisplayName() == targetName || UnequippedContainer38.GetDisplayName() == "DefaultChest")
        return UnequippedContainer38
    elseif(UnequippedContainer39.GetDisplayName() == targetName || UnequippedContainer39.GetDisplayName() == "DefaultChest")
        return UnequippedContainer39
    elseif(UnequippedContainer40.GetDisplayName() == targetName || UnequippedContainer40.GetDisplayName() == "DefaultChest")
        return UnequippedContainer40
    elseif(UnequippedContainer41.GetDisplayName() == targetName || UnequippedContainer41.GetDisplayName() == "DefaultChest")
        return UnequippedContainer41
    elseif(UnequippedContainer42.GetDisplayName() == targetName || UnequippedContainer42.GetDisplayName() == "DefaultChest")
        return UnequippedContainer42
    elseif(UnequippedContainer43.GetDisplayName() == targetName || UnequippedContainer43.GetDisplayName() == "DefaultChest")
        return UnequippedContainer43
    elseif(UnequippedContainer44.GetDisplayName() == targetName || UnequippedContainer44.GetDisplayName() == "DefaultChest")
        return UnequippedContainer44
    elseif(UnequippedContainer45.GetDisplayName() == targetName || UnequippedContainer45.GetDisplayName() == "DefaultChest")
        return UnequippedContainer45
    elseif(UnequippedContainer46.GetDisplayName() == targetName || UnequippedContainer46.GetDisplayName() == "DefaultChest")
        return UnequippedContainer46
    elseif(UnequippedContainer47.GetDisplayName() == targetName || UnequippedContainer47.GetDisplayName() == "DefaultChest")
        return UnequippedContainer47
    elseif(UnequippedContainer48.GetDisplayName() == targetName || UnequippedContainer48.GetDisplayName() == "DefaultChest")
        return UnequippedContainer48
    elseif(UnequippedContainer49.GetDisplayName() == targetName || UnequippedContainer49.GetDisplayName() == "DefaultChest")
        return UnequippedContainer49
    elseif(UnequippedContainer50.GetDisplayName() == targetName || UnequippedContainer50.GetDisplayName() == "DefaultChest")
        return UnequippedContainer50
    else
        return NONE
    endIf
endFunction

ObjectReference Function Proteus_LoadUnequippedContainerFunction(String preset)
		String targetName = preset
		if(UnequippedContainer1.GetDisplayName() == targetName)
			return UnequippedContainer1
		elseif(UnequippedContainer2.GetDisplayName() == targetName)
			return UnequippedContainer2
		elseif(UnequippedContainer3.GetDisplayName() == targetName)
			return UnequippedContainer3
		elseif(UnequippedContainer4.GetDisplayName() == targetName)
			return UnequippedContainer4
		elseif(UnequippedContainer5.GetDisplayName() == targetName)
			return UnequippedContainer5
		elseif(UnequippedContainer6.GetDisplayName() == targetName)
			return UnequippedContainer6
		elseif(UnequippedContainer7.GetDisplayName() == targetName)
			return UnequippedContainer7
		elseif(UnequippedContainer8.GetDisplayName() == targetName)
			return UnequippedContainer8
		elseif(UnequippedContainer9.GetDisplayName() == targetName)
			return UnequippedContainer9
		elseif(UnequippedContainer10.GetDisplayName() == targetName)
			return UnequippedContainer10
		elseif(UnequippedContainer11.GetDisplayName() == targetName)
			return UnequippedContainer11
		elseif(UnequippedContainer12.GetDisplayName() == targetName)
			return UnequippedContainer12
		elseif(UnequippedContainer13.GetDisplayName() == targetName)
			return UnequippedContainer13
		elseif(UnequippedContainer14.GetDisplayName() == targetName)
			return UnequippedContainer14
		elseif(UnequippedContainer15.GetDisplayName() == targetName)
			return UnequippedContainer15
		elseif(UnequippedContainer16.GetDisplayName() == targetName)
			return UnequippedContainer16
		elseif(UnequippedContainer17.GetDisplayName() == targetName)
			return UnequippedContainer17
		elseif(UnequippedContainer18.GetDisplayName() == targetName)
			return UnequippedContainer18
		elseif(UnequippedContainer19.GetDisplayName() == targetName)
			return UnequippedContainer19
		elseif(UnequippedContainer20.GetDisplayName() == targetName)
			return UnequippedContainer20
		elseif(UnequippedContainer21.GetDisplayName() == targetName)
			return UnequippedContainer21
		elseif(UnequippedContainer22.GetDisplayName() == targetName)
			return UnequippedContainer22
		elseif(UnequippedContainer23.GetDisplayName() == targetName)
			return UnequippedContainer23
		elseif(UnequippedContainer24.GetDisplayName() == targetName)
			return UnequippedContainer24
		elseif(UnequippedContainer25.GetDisplayName() == targetName)
			return UnequippedContainer25
		elseif(UnequippedContainer26.GetDisplayName() == targetName)
			return UnequippedContainer26
		elseif(UnequippedContainer27.GetDisplayName() == targetName)
			return UnequippedContainer27
		elseif(UnequippedContainer28.GetDisplayName() == targetName)
			return UnequippedContainer28
		elseif(UnequippedContainer29.GetDisplayName() == targetName)
			return UnequippedContainer29
		elseif(UnequippedContainer30.GetDisplayName() == targetName)
			return UnequippedContainer30
		elseif(UnequippedContainer31.GetDisplayName() == targetName)
			return UnequippedContainer31
		elseif(UnequippedContainer32.GetDisplayName() == targetName)
			return UnequippedContainer32
		elseif(UnequippedContainer33.GetDisplayName() == targetName)
			return UnequippedContainer33
		elseif(UnequippedContainer34.GetDisplayName() == targetName)
			return UnequippedContainer34
		elseif(UnequippedContainer35.GetDisplayName() == targetName)
			return UnequippedContainer35
		elseif(UnequippedContainer36.GetDisplayName() == targetName)
			return UnequippedContainer36
		elseif(UnequippedContainer37.GetDisplayName() == targetName)
			return UnequippedContainer37
		elseif(UnequippedContainer38.GetDisplayName() == targetName)
			return UnequippedContainer38
		elseif(UnequippedContainer39.GetDisplayName() == targetName)
			return UnequippedContainer39
		elseif(UnequippedContainer40.GetDisplayName() == targetName)
			return UnequippedContainer40
		elseif(UnequippedContainer41.GetDisplayName() == targetName)
			return UnequippedContainer41
		elseif(UnequippedContainer42.GetDisplayName() == targetName)
			return UnequippedContainer42
		elseif(UnequippedContainer43.GetDisplayName() == targetName)
			return UnequippedContainer43
		elseif(UnequippedContainer44.GetDisplayName() == targetName)
			return UnequippedContainer44
		elseif(UnequippedContainer45.GetDisplayName() == targetName)
			return UnequippedContainer45
		elseif(UnequippedContainer46.GetDisplayName() == targetName)
			return UnequippedContainer46
		elseif(UnequippedContainer47.GetDisplayName() == targetName)
			return UnequippedContainer47
		elseif(UnequippedContainer48.GetDisplayName() == targetName)
			return UnequippedContainer48
		elseif(UnequippedContainer49.GetDisplayName() == targetName)
			return UnequippedContainer49
		elseif(UnequippedContainer50.GetDisplayName() == targetName)
			return UnequippedContainer50
		else
			return NONE
		endIf
endFunction



Function Proteus_DeletePlayerCharacter(String presetName)
	Bool deleteChar = true
	;CANNOT DELETE CURRENTLY LOADED PRESET - check which preset is currently loaded
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		Int JPlayerList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
		Int jStats = jmap.object()
		String playerPresetName = jmap.nextKey(JPlayerList, "", "")
		while playerPresetName
			String value = jmap.GetStr(JPlayerList, playerPresetName, none) as String
			if playerPresetName == "PresetName"
				if(value == presetName)
					deleteChar = false
				endIf
			endIf
			playerPresetName = jmap.nextKey(JPlayerList, playerPresetName, "")
		endWhile
	endIf

	if(presetName == "")
		Debug.Notification("Invalid preset name entered.")
		deleteChar = false
	endIf

	if(deleteChar==true)
		;delete race, skills, stats JSON files
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Race_" + presetName + ".json")
		endIf

		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json")
		endIf

		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_SkillsCustom_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_SkillsCustom_" + presetName + ".json")
		endIf

		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_GeneralInfo_" + presetName + ".json")
		endIf
		
		int counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedItems_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedItems_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile
		
		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedItems_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile

		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_UnequippedItems_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_UnequippedItems_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile
		
		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedSpells_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_EquippedSpells_" + presetName + ".json")
			counter += 1
		endWhile
		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedSpells_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_FavoritedSpells_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile
		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Spells_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Spells_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile	
		
		counter = 1
		while(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Perks_" + counter + "_" + presetName + ".json"))
			removeFileAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Perks_" + counter + "_" + presetName + ".json")
			counter += 1
		endWhile
	
		;CLEAR REGISTERED PRESETS LIST
		Int jPLAYERPRESETFormList
		if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
			jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
			Int jNFormNames = jmap.object()
			String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
			int i = 0
			String value
			while PLAYERPRESETFormKey
				value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
				if value == presetName
				else
					jmap.SetStr(jNFormNames, PLAYERPRESETFormKey, value)
				endIf
				i+=1
				PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
			endWhile
			jvalue.writeToFile(jNFormNames, JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
		endIf

		;CLEAR STORED INVENTORY CONTAINER
		ObjectReference deleteUnequipped = Proteus_LoadUnequippedContainerFunction(presetName)
		deleteUnequipped.RemoveAllItems()
		deleteUnequipped.SetName("DefaultChest")
		deleteUnequipped.SetDisplayName("DefaultChest")

		;reset any actor spawn that has this name
		Actor spawnToClear = Proteus_GetSpawningActor(presetName)
		if(spawnToClear != NONE)
			Proteus_ResetSpawn(presetName)
		endIf
	else
		Debug.MessageBox("Cannot delete as this character is currently loaded on the player.")
	endIf
endFunction



Function SaveAppearancePresetJSON(String playerName, String presetName)
	playerPresetFirstLoad = false

	Int jPLAYERPRESETFormList
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
	endIf
	Int jNFormNames = jmap.object()
	String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
	Bool insertNewPLAYERPRESET = true
	int i = 0
	String value
	while PLAYERPRESETFormKey
		value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
		if value == presetName
			insertNewPLAYERPRESET = false
			jmap.SetStr(jNFormNames, i + "_ProteusPlayerPreset_" + presetName, value)
			ZZPresetLoadedCounter2.SetValue(i)
		else
			jmap.SetStr(jNFormNames, PLAYERPRESETFormKey, value)
		endIf
		i+=1
		PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
	endWhile
	if insertNewPLAYERPRESET == true
		jmap.SetStr(jNFormNames, i + "_ProteusPlayerPreset_" + presetName, presetName)
		ZZPresetLoadedCounter2.SetValue(i)
		playerPresetFirstLoad = true
	endIf
	jvalue.writeToFile(jNFormNames, JContGlobalPath + "/Proteus/Proteus_Character_PresetsLoaded_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
endFunction

Function LevelScaler(Actor target)
	Utility.Wait(0.1)
    Debug.MessageBox("Select a saved character that you would like to scale your current character to.")
    Utility.Wait(0.1)
    ;figure out which preset to use
    String presetName = Proteus_SelectPresetSpawn()

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
    if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json"))
        ran = true
        Int jSkillList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_Character_Skills_" + presetName + ".json")
        Int jSkills = jmap.object()
        String skillForm = jmap.nextKey(jSkillList, "", "")
        Int maxCount = jvalue.Count(jSkillList)
        Int j = 0
        String stat = jmap.nextKey(JSkillList, "", "")
        while j <= maxCount
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
			ProteusDLLUtils.SetLevel(target, levelPreset)
            skillCurrentTotal += target.GetBaseAV("Alchemy") as Int
            skillCurrentTotal += target.GetBaseAV("Alteration") as Int
            skillCurrentTotal += target.GetBaseAV("Marksman") as Int
            skillCurrentTotal += target.GetBaseAV("Block") as Int
            skillCurrentTotal += target.GetBaseAV("Conjuration") as Int
            skillCurrentTotal += target.GetBaseAV("Destruction") as Int
            skillCurrentTotal += target.GetBaseAV("Enchanting") as Int
            skillCurrentTotal += target.GetBaseAV("HeavyArmor") as Int
            skillCurrentTotal += target.GetBaseAV("Illusion") as Int
            skillCurrentTotal += target.GetBaseAV("LightArmor") as Int
            skillCurrentTotal += target.GetBaseAV("Lockpicking") as Int
            skillCurrentTotal += target.GetBaseAV("OneHanded") as Int
            skillCurrentTotal += target.GetBaseAV("Pickpocket") as Int
            skillCurrentTotal += target.GetBaseAV("Restoration") as Int
            skillCurrentTotal += target.GetBaseAV("Smithing") as Int
            skillCurrentTotal += target.GetBaseAV("Sneak") as Int
            skillCurrentTotal += target.GetBaseAV("Speechcraft") as Int
            skillCurrentTotal += target.GetBaseAV("TwoHanded") as Int
            skillDiff = totalSkills - skillCurrentTotal

            attributeCurrentTotal += target.GetBaseAV("Health") as Int
            attributeCurrentTotal += target.GetBaseAV("Magicka") as Int
            attributeCurrentTotal += target.GetBaseAV("Stamina") as Int
            attributeDiff = totalAttributes - attributeCurrentTotal

            Debug.MessageBox("You have " + attributeDiff as Int + " attribute points to distribute. Each time you make a selection, your remaining available attribute points will decrease.")
            Utility.Wait(0.1)
            LevelScalerAttribute(attributeDiff, target, 10)
            Utility.Wait(0.1)
            Debug.MessageBox("You have " + skillDiff as Int + " skill points to distribute. Each time you make a selection, your remaining available skill points will decrease.")
            Utility.Wait(0.1)
            LevelScalerSkill(skillDiff, target, 1)

            ;PERKS?
            if(target == player)
                Game.AddPerkPoints(levelDiff)
                Debug.MessageBox(target.GetActorBase().GetName() + " obtained " + levelDiff as Int + " perk points and is now level " + levelPreset as Int + ".")
            endIf
        else
            Debug.MessageBox("Level scaler only works when used on a character with a lower level than that of the selected character.")
        endIf
    endIf
    ;Debug.MessageBox("Player \nSkills"+totalSkills + "\nAttrib" + totalAttributes + "\nSkillDiff"+skillDiff + "\nAttribDiff"+attributeDiff)
endFunction


function LevelScalerAttribute(Int amountRemaining, Actor target, Int incrementAmount)
    ;Debug.Notification("Attribute points left to distribute = " + amountRemaining as Int)
	if (incrementAmount > amountRemaining)
		incrementAmount = amountRemaining
	endIf

    string[] stringArray = new String[4]
    stringArray[0] = " [Increment:" + Proteus_Round(incrementAmount, 0) + ", Remaining:" + Proteus_Round(amountRemaining, 0) + "]"
	stringArray[1] = " Health " + target.GetBaseAV("Health") as Int
    stringArray[2] = " Magicka " + target.GetBaseAV("Magicka") as Int
    stringArray[3] = " Stamina " + target.GetBaseAV("Stamina") as Int

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

    if amountRemaining > 0
		if result == 0
			Int incrementAmountInput = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change increment amount to:") as Int
			Utility.Wait(0.1)
			if incrementAmountInput > 0
				incrementAmount = incrementAmountInput
				LevelScalerAttribute(amountRemaining, target, incrementAmount)
			else
				Debug.Notification("Must enter an integer greater than 0.")
				LevelScalerAttribute(amountRemaining, target, incrementAmount)
			endif
		elseif result == 1
            target.SetActorValue("Health", target.GetBaseAV("Health") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerAttribute(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 2
            target.SetActorValue("Magicka", target.GetBaseAV("Magicka") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerAttribute(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 3
            target.SetActorValue("Stamina", target.GetBaseAV("Stamina") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerAttribute(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == -1
            Debug.Notification("You must distribute your remaining " + amountRemaining as Int + " attribute points.")
            if amountRemaining > 0
                LevelScalerAttribute(amountRemaining, target, incrementAmount)
            endIf
        endIf
    endIf
endFunction

function LevelScalerSkill(Int amountRemaining, Actor target, Int incrementAmount)
    ;Debug.Notification("Skill points left to distribute = " + amountRemaining as Int)
	if (incrementAmount > amountRemaining)
		incrementAmount = amountRemaining
	endIf
    string[] stringArray = new String[19]
	stringArray[0] = " [Increment:" + Proteus_Round(incrementAmount, 0) + ", Remaining:" + Proteus_Round(amountRemaining, 0) + "]"
    stringArray[1] = " Alchemy " + target.GetBaseAV("Alchemy") as Int
    stringArray[2] = " Alteration "+ target.GetBaseAV("Alteration") as Int   
    stringArray[3] = " Archery " + target.GetBaseAV("Marksman") as Int   
    stringArray[4] = " Block "+ target.GetBaseAV("Block") as Int
    stringArray[5] = " Conjuration "+ target.GetBaseAV("Conjuration") as Int
    stringArray[6] = " Destruction "+ target.GetBaseAV("Destruction") as Int
    stringArray[7] = " Enchanting "+ target.GetBaseAV("Enchanting") as Int
    stringArray[8] = " HeavyArmor "+ target.GetBaseAV("HeavyArmor") as Int
    stringArray[9] = " Illusion "+ target.GetBaseAV("Illusion") as Int
    stringArray[10] = " LightArmor "+ target.GetBaseAV("LightArmor") as Int
    stringArray[11] = " Lockpicking "+ target.GetBaseAV("Lockpicking") as Int
    stringArray[12] = " OneHanded "+ target.GetBaseAV("OneHanded") as Int
    stringArray[13] = " PickPocket "+ target.GetBaseAV("PickPocket") as Int
    stringArray[14] = " Restoration "+ target.GetBaseAV("Restoration") as Int
    stringArray[15] = " Smithing "+ target.GetBaseAV("Smithing") as Int
    stringArray[16] = " Sneak "+ target.GetBaseAV("Sneak") as Int
    stringArray[17] = " Speechcraft "+ target.GetBaseAV("Speechcraft") as Int
    stringArray[18] = " Twohanded "+ target.GetBaseAV("Twohanded") as Int

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenu
        int n = 19
        int i = 0
        while i < n
            listMenu.AddEntryItem(stringArray[i])
            i += 1
        endwhile
    EndIf

    listMenu.OpenMenu()
    int result = listMenu.GetResultInt()

    if amountRemaining > 0
		if result == 0
			Int incrementAmountInput = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change increment amount to:") as Int
			Utility.Wait(0.1)
            if incrementAmountInput > 0
                incrementAmount = incrementAmountInput
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            else
                Debug.Notification("Must enter an integer greater than 0.")
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endif
        elseif result == 1
            target.SetActorValue("Alchemy", target.GetBaseAV("Alchemy") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 2
            target.SetActorValue("Alteration", target.GetBaseAV("Alteration") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 3
            target.SetActorValue("Marksman", target.GetBaseAV("Marksman") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 4
            target.SetActorValue("Block", target.GetBaseAV("Block") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 5
            target.SetActorValue("Conjuration", target.GetBaseAV("Conjuration") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 6
            target.SetActorValue("Destruction", target.GetBaseAV("Destruction") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 7
            target.SetActorValue("Enchanting", target.GetBaseAV("Enchanting") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 8
            target.SetActorValue("HeavyArmor", target.GetBaseAV("HeavyArmor") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 9
            target.SetActorValue("Illusion", target.GetBaseAV("Illusion") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 10
            target.SetActorValue("LightArmor", target.GetBaseAV("LightArmor") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 11
            target.SetActorValue("Lockpicking", target.GetBaseAV("Lockpicking") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 12
            target.SetActorValue("OneHanded", target.GetBaseAV("OneHanded") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 13
            target.SetActorValue("PickPocket", target.GetBaseAV("PickPocket") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 14
            target.SetActorValue("Restoration", target.GetBaseAV("Restoration") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 15
            target.SetActorValue("Smithing", target.GetBaseAV("Smithing") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 16
            target.SetActorValue("Sneak", target.GetBaseAV("Sneak") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 17
            target.SetActorValue("Speechcraft", target.GetBaseAV("Speechcraft") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == 18
            target.SetActorValue("Twohanded", target.GetBaseAV("Twohanded") + incrementAmount)
            amountRemaining -= incrementAmount
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        elseIf result == -1
            Debug.Notification("You must distribute your remaining " + amountRemaining as Int + " skill points.")
            if amountRemaining > 0
                LevelScalerSkill(amountRemaining, target, incrementAmount)
            endIf
        endIf
    else
    endIf
endFunction


Function SavePresetGlobalVariables(String playerName)
	playerPresetFirstLoad = false
	Int jPLAYERPRESETFormList
	Int jNFormNames = jmap.object()
	String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
	Bool insertNewPLAYERPRESET = true
	int i = 0
	String value
	while i < 2
		value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
		if i == 0
			jmap.SetStr(jNFormNames, "GV1", ZZPresetLoadedCounter.GetValue() as Int)
		elseif i == 1
			jmap.SetStr(jNFormNames, "GV2", ZZPresetLoadedCounter2.GetValue() as Int)
		endIf
		i+=1
		PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
	endWhile

	jvalue.writeToFile(jNFormNames, JContGlobalPath + "/Proteus/ProteusPresetsLoadedGV_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
endFunction


Function LoadPresetGlobalVariables(String playerName)
	playerPresetFirstLoad = false
	Int jPLAYERPRESETFormList
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/ProteusPresetsLoadedGV_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json"))
		jPLAYERPRESETFormList = jvalue.readFromFile(JContGlobalPath + "/Proteus/ProteusPresetsLoadedGV_" + playerName + "_" + Proteus_Round(ZZNPCAppearanceSaved.GetValue(),0) + ".json")
		Int jNFormNames = jmap.object()
		String PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, "", "")
		Bool insertNewPLAYERPRESET = true
		int i = 0
		String value
		while PLAYERPRESETFormKey
			value = jmap.GetStr(jPLAYERPRESETFormList,PLAYERPRESETFormKey, none)
			if PLAYERPRESETFormKey == "GV1"
				;ZZPresetLoadedCounter.SetValue(value as Int)
			elseif PLAYERPRESETFormKey == "GV2"
				ZZPresetLoadedCounter2.SetValue(value as Int)
			endIf
			i+=1
			PLAYERPRESETFormKey = jmap.nextKey(jPLAYERPRESETFormList, PLAYERPRESETFormKey, "")
		endWhile
	endIf
endFunction



Function Proteus_NewCharacter()
	Debug.Notification("New character function started.")

	;First save current character into Proteus system
	Debug.Notification("Before creating new character, saving current character.")
	characterSavingName = player.GetActorBase().GetName()
	Proteus_CharacterSave(player, characterSavingName)
	playerMarker.MoveTo(player)
	Proteus_RemoveFavorites(player)

	;spawn a copy of the just saved character
	Utility.Wait(0.1)
	Proteus_LoadCharacterSpawn(player, characterSavingName)

	Utility.Wait(0.1)
	;Proteus_TeleportExistingSummonToPlayer(characterSavingName)

	;reset skills, attributes, experience, perk points available
	player.SetActorValue("Alchemy", 20) 
	player.SetActorValue("Alteration", 20) 
	player.SetActorValue("Marksman", 20) 
	player.SetActorValue("Block", 20) 
	player.SetActorValue("Conjuration", 20) 
	player.SetActorValue("Destruction", 20) 
	player.SetActorValue("Enchanting", 20) 
	player.SetActorValue("HeavyArmor", 20) 
	player.SetActorValue("Illusion", 20) 
	player.SetActorValue("LightArmor", 20) 
	player.SetActorValue("Lockpicking", 20) 
	player.SetActorValue("OneHanded", 20) 
	player.SetActorValue("Pickpocket", 20) 
	player.SetActorValue("Restoration", 20) 
	player.SetActorValue("Smithing", 20) 
	player.SetActorValue("Sneak", 20) 
	player.SetActorValue("Speechcraft", 20) 
	player.SetActorValue("TwoHanded", 20) 
	player.SetActorValue("Health", 100) 
	player.SetActorValue("Magicka", 100) 
	player.SetActorValue("Stamina", 100) 
	player.SetActorValue("CarryWeight", 300)
	ProteusDLLUtils.SetLevel(player, 1)
	Game.SetPlayerExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Alchemy").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Alteration").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Marksman").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Block").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Conjuration").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Destruction").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Enchanting").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("HeavyArmor").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Illusion").SetSkillExperience(0)     
	ActorValueInfo.GetActorValueInfoByName("LightArmor").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Lockpicking").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("oneHanded").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Pickpocket").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Restoration").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Smithing").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("Sneak").SetSkillExperience(0)
 	ActorValueInfo.GetActorValueInfoByName("Speechcraft").SetSkillExperience(0)
	ActorValueInfo.GetActorValueInfoByName("twoHanded").SetSkillExperience(0)
	Game.SetPerkPoints(0)

	;reset bounties
	;ResetCrimeFactions()

	;remove all perks, vanilla spells and spells added by mods with Proteus patches, and items
	Debug.Notification("Removing perks. This process may take a while.")
	Proteus_RemovePerks_SlowCheckingProcess(player, 1)
	Debug.Notification("Removing spells. This process may take a while.")
	Proteus_RemoveSpells(player, 1)
	Proteus_RemoveAllItems(player)

	;select starting outfit, weapons, and spells
	Debug.MessageBox("You will now select/edit: \nStarting Armor\nStarting Weapon\nAppearance\nStarting Location")
	Utility.Wait(0.1)
	Proteus_CheatItem(0, 1, 26) ;armor search	
	Utility.Wait(0.1)
	Proteus_CheatItem(0, 1, 41) ;weapon search

	Utility.Wait(0.1)
	Proteus_CheatSpell(player, 0, 1, 22, ZZProteusSkyUIMenu)
	Utility.Wait(0.1)

	;dispel spells, add back important mod items, and edit appearance
	player.DispelAllSpells()
	;ExecuteCommand("showracemenu")
	Utility.Wait(0.1)
	Proteus_AddBackModItems()
	Utility.Wait(0.1)

	;pick starting location
	Debug.MessageBox("Pick your starting location.")
	Utility.Wait(0.1)
	Teleporter()
	Utility.Wait(0.1)

	;save new character into the Proteus system
	String playerName = player.GetActorBase().GetName()
	Proteus_CharacterSave(player, playerName)
	Debug.MessageBox("New player character successfully created and saved into the Proteus system.")
endFunction

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Proteus_PlayerFactionsFunction()
	string[] stringArray
	stringArray= new String[17]
	stringArray[0] = " Bandit"
	stringArray[1] = " Forsworn"
	stringArray[2] = " Necromancer"
	stringArray[3] = " Vampire"
	stringArray[4] = " Werewolf"
	stringArray[5] = " Thalmor"
	stringArray[6] = " Imperial Legion"
	stringArray[7] = " Stormcloak"
	stringArray[8] = " Cultist"
	stringArray[9] = " Dremora"
	stringArray[10] = " Falmer"
	stringArray[11] = " Hagraven"
	stringArray[12] = " Tribal Orc"
	stringArray[13] = " Vigilant of Stendarr"
	stringArray[14] = " Skeleton"
	stringArray[15] = " [Back]"
	stringArray[16] = " [Exit Menu]"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 17
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	if result == 0
		if player.IsInFaction(banditFaction) == 0 as Bool
			player.AddToFaction(banditFaction)
			banditFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Bandit faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(banditFaction)
			banditFaction.SetReaction(playerFaction, 1)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Bandit faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 1
		if player.IsInFaction(forswornFaction) == 0 as Bool
			player.AddToFaction(forswornFaction)
			forswornFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Forsworn faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(forswornFaction)
			forswornFaction.SetReaction(forswornFaction, 1)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Forsworn faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 2
		if player.IsInFaction(necromancerFaction) == 0 as Bool
			player.AddToFaction(necromancerFaction)
			necromancerFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Necromancer faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(necromancerFaction)
			necromancerFaction.SetReaction(playerFaction, 1)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Necromancer faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 3
		if player.IsInFaction(vampireFaction) == 0 as Bool
			player.AddToFaction(vampireFaction)
			vampireFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Vampire faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(vampireFaction)
			vampireFaction.SetReaction(playerFaction, 1)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Vampire faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 4
		if player.IsInFaction(werewolfFaction) == 0 as Bool
			player.AddToFaction(werewolfFaction)
			werewolfFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Werewolf faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(werewolfFaction)
			werewolfFaction.SetReaction(playerFaction, 1)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Werewolf faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 5
		if player.IsInFaction(thalmorFaction) == 0 as Bool
			player.AddToFaction(thalmorFaction)
			thalmorFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Thalmor faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(thalmorFaction)
			thalmorFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Thalmor faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 6
		if player.IsInFaction(imperialLegionFaction) == 0 as Bool
			player.AddToFaction(imperialLegionFaction)
			imperialLegionFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Imperial Legion faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(imperialLegionFaction)
			imperialLegionFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Imperial Legion faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 7
		if player.IsInFaction(stormCloakFaction) == 0 as Bool
			player.AddToFaction(stormCloakFaction)
			stormCloakFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Stormcloak faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(stormCloakFaction)
			stormCloakFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Stormcloak faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 8
		if player.IsInFaction(cultistFaction) == 0 as Bool
			player.AddToFaction(cultistFaction)
			cultistFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Cultist faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(cultistFaction)
			cultistFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Cultist faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 9
		if player.IsInFaction(dremoraFaction) == 0 as Bool
			player.AddToFaction(dremoraFaction)
			dremoraFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Dremora faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(dremoraFaction)
			dremoraFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Dremora faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 10
		if player.IsInFaction(falmerFaction) == 0 as Bool
			player.AddToFaction(falmerFaction)
			falmerFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Falmer faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(falmerFaction)
			falmerFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Falmer faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 11
		if player.IsInFaction(hagravenFaction) == 0 as Bool
			player.AddToFaction(hagravenFaction)
			hagravenFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Hagraven faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(hagravenFaction)
			hagravenFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Hagraven faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 12
		if player.IsInFaction(tribalOrcsFaction) == 0 as Bool
			player.AddToFaction(tribalOrcsFaction)
			tribalOrcsFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Tribal Orc faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(tribalOrcsFaction)
			tribalOrcsFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Tribal Orc faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 13
		if player.IsInFaction(vigilantOfStendarrFaction) == 0 as Bool
			player.AddToFaction(vigilantOfStendarrFaction)
			vigilantOfStendarrFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Vigilant of Stendarr faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(vigilantOfStendarrFaction)
			vigilantOfStendarrFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Vigilant of Stendarr faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 14
		if player.IsInFaction(skeletonFaction) == 0 as Bool
			player.AddToFaction(skeletonFaction)
			skeletonFaction.SetReaction(playerFaction, 3)
			debug.Notification(player.GetActorBase().GetName() + " is now a member of the Skeleton faction.")
			Proteus_PlayerFactionsFunction()
		else
			player.RemoveFromFaction(skeletonFaction)
			skeletonFaction.SetReaction(playerFaction, 0)
			debug.Notification(player.GetActorBase().GetName() + " is no longer a member of the Skeleton faction.")
			Proteus_PlayerFactionsFunction()
		endIf
	elseIf result == 15
		Proteus_PlayerMainMenu()
	endIf
endFunction



Function Proteus_OpenSharedStash()
	sharedContainer.MoveTo(player, 0, 0, -10000)
	Utility.Wait(0.1)
	while(player.GetParentCell() != sharedContainer.GetParentCell())
	endWhile
	Utility.Wait(0.1)
	sharedContainer.Activate(player)
	Utility.Wait(0.1)
endFunction


Function ResetCrimeFactions()
	int maxCount = ZZCrimeFactions.GetSize()
	Int j = 0
	while j < maxCount
		Faction factionTemp = ZZCrimeFactions.GetAt(j) as Faction
		factionTemp.SetCrimeGoldViolent(0)
		factionTemp.SetCrimeGold(0)
		j += 1
	endWhile
EndFunction

Function SaveCrimeFactions(String presetName)
	Int jCrimeFactions = jmap.object()
	Int jCrimeFactionsList
	String crimeFormKey = jmap.nextKey(jCrimeFactionsList, "", "")
	int maxCount = ZZCrimeFactions.GetSize()

	Int j = 0
	while j < maxCount
		String value
		Faction factionTemp = ZZCrimeFactions.GetAt(j) as Faction
		String factionName = GetFormEditorID(factionTemp as Form)

		String crimeGoldViolent = factionTemp.GetCrimeGoldViolent()
		jmap.SetForm(jCrimeFactions, factionName + "_CrimeGoldViolent_" + crimeGoldViolent , factionTemp)
		crimeFormKey = jmap.nextKey(jCrimeFactionsList, crimeFormKey, "")

		String crimeGoldNonViolent = factionTemp.GetCrimeGoldNonViolent()
		jmap.SetForm(jCrimeFactions, factionName + "_CrimeGoldNonviolent_" + crimeGoldNonViolent , factionTemp)
		crimeFormKey = jmap.nextKey(jCrimeFactionsList, crimeFormKey, "")

		j += 1
	endWhile
	jvalue.writeToFile(jCrimeFactions, JContGlobalPath + "/Proteus/Proteus_CrimeFactionGold_" + presetName + ".json")
EndFunction


Function LoadCrimeFactions(String presetName)
	;get beginning amount of gold and add enough to pay bounties
	int beginningGoldPre = player.GetItemCount(Gold001)
	int incrementAmount = 100000
	player.AddItem(Gold001, incrementAmount)
	Utility.Wait(0.2)
	int beginningGoldPost = player.GetItemCount(Gold001)

	int maxCount = ZZCrimeFactions.GetSize() * 2 ;getting violent and non-violent
	if(fileExistsAtPath(JContGlobalPath + "/Proteus/Proteus_CrimeFactionGold_" + presetName + ".json"))
		Int jCrimeFactionsList = jvalue.readFromFile(JContGlobalPath + "/Proteus/Proteus_CrimeFactionGold_" + presetName + ".json")
		Int jCrimeFactions = jmap.object()
		String crimeFormKey = jmap.nextKey(jCrimeFactionsList, "", "")
		int j = 0
		while j < maxCount
			Faction factionTemp = jmap.GetForm(jCrimeFactionsList,crimeFormKey, none) as Faction
			Debug.Notification(factionTemp.GetName())
			Int currentCrimeGoldViolent = factionTemp.GetCrimeGoldViolent()
			Int currentCrimeGoldNonViolent = factionTemp.GetCrimeGoldNonViolent()

			Int indexCrimeGoldViolent = stringutil.Find(crimeFormKey, "_CrimeGoldViolent_", 0)
			Int indexCrimeGoldNonViolent = stringutil.Find(crimeFormKey, "_CrimeGoldNonviolent_", 0)
			Int crimeAmount = 0

			if indexCrimeGoldViolent >= 0
				crimeAmount = StringUtil.Substring(crimeFormKey, stringutil.Find(crimeFormKey, "_CrimeGoldViolent_" + 18, 0)) as Int
				if(crimeAmount > 0)
					Debug.MessageBox("CrimeViolent: " + crimeAmount)
				elseif(crimeAmount == 0)
					factionTemp.PlayerPayCrimeGold(false, false)
				endIf
				factionTemp.SetCrimeGoldViolent(crimeAmount)
			elseif indexCrimeGoldNonViolent >= 0
				crimeAmount = StringUtil.Substring(crimeFormKey, stringutil.Find(crimeFormKey, "_CrimeGoldNonviolent_" + 21, 0)) as Int
				factionTemp.SetCrimeGold(crimeAmount)	
			endIf
			j+=1
			crimeFormKey = jmap.nextKey(jCrimeFactionsList, crimeFormKey, "")
		endWhile
		;reset gold to beginning value
		Utility.Wait(0.1)
		int endingGold = player.GetItemCount(Gold001)

		int differenceGold = beginningGoldPost - endingGold
		player.RemoveItem(Gold001, beginningGoldPost - differenceGold - beginningGoldPre)
	endIf
EndFunction


function Proteus_LockEnable()
	;slowTimeSpell.Cast(player,player)
	Game.SetHudCartMode()
	Game.DisablePlayerControls(true,true,true,true,true, true, true, true)
	Game.ForceFirstPerson()
endFunction

function Proteus_LockDisable()
	Utility.Wait(0.1)
	Game.SetHudCartMode(false)
	Game.EnablePlayerControls()
	;player.DispelSpell(slowTimeSpell)
endFunction










Function Proteus_CheatItem(int startingPoint, int currentPage, int typeCode) ;option 0 = cheat, 1 = reset
    Debug.Notification("Item menu loading...may take a few seconds!")
    Form[] allGameItems = GetAllForms(typeCode) ;get all Items in game and from mods

	String typeString
	if(typeCode == 41)
		typeString = "Weapons"
	elseif typeCode == 32
		typeString = "Misc Items"
	elseif typeCode == 26
		typeString = "Armors"
	elseif typeCode == 23
		typeString = "Scrolls"
	elseif typeCode == 27
		typeString = "Books"
	elseif typeCode == 42
		typeString = "Ammo"
	endIf

    int numPages = (allGameItems.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding " + typeString + "]")
        i+=1
        listMenuBase.AddEntryItem("[Search " + typeString + "]")
        i+=1
        while startingPoint <= allGameItems.Length && i < 128
			String name = GetFormEditorID(allGameItems[startingPoint])
			if(name == "")
				name = allGameItems[startingPoint].GetName()
			endif
            listMenuBase.AddEntryItem(name)
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
            int itemCount = ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundItems = ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatItemSearch(foundItems, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatItem(startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedItem = allGameItems[startingPointInitial + result - 2]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				player.AddItem(selectedItem, itemAmount,  true)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + GetFormEditorID(selectedItem) + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					player.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItem(startingPointInitial, currentPage, typeCode)
        Else
            Form selectedItem = allGameItems[result - 2]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				player.AddItem(selectedItem, itemAmount,  true)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + GetFormEditorID(selectedItem) + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					player.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItem(startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction

Function Proteus_CheatItemSearch(Form[] foundItems, int startingPoint, int currentPage, int typeCode) ;option 0 = cheat, 1 = reset
    Debug.Notification("Item menu loading...may take a few seconds!")
    Form[] allGameItems = foundItems ;get all Items in game and from mods

	String typeString
	if(typeCode == 41)
		typeString = "Weapons"
	elseif typeCode == 32
		typeString = "Misc Items"
	elseif typeCode == 26
		typeString = "Armors"
	elseif typeCode == 23
		typeString = "Scrolls"
	elseif typeCode == 27
		typeString = "Books"
	elseif typeCode == 42
		typeString = "Ammo"
	endIf

    int numPages = (allGameItems.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Done Adding " + typeString + "]")
        i+=1
        listMenuBase.AddEntryItem("[Search " + typeString + "]")
        i+=1
        while startingPoint <= allGameItems.Length && i < 128
			String name = GetFormEditorID(allGameItems[startingPoint])
			if(name == "")
				name = allGameItems[startingPoint].GetName()
			endif
            listMenuBase.AddEntryItem(name)
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
            int itemCount = ProteusGetItemCount(searchTerm, typeCode)
            Form[] foundItems2 = ProteusGetItemBySearch(searchTerm, typeCode)
            Proteus_CheatItemSearch(foundItems2, 0, 1, typeCode)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_CheatItemSearch(foundItems, startingPoint, currentPage, typeCode)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedItem = allGameItems[startingPointInitial + result - 2]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				player.AddItem(selectedItem, itemAmount,  true)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + GetFormEditorID(selectedItem) + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					player.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItemSearch(foundItems, startingPointInitial, currentPage, typeCode)
        Else
            Form selectedItem = foundItems[result - 2]
			Int itemAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Add how many " + selectedItem.GetName() + "?") as Int
			Utility.Wait(0.1)
			if (itemAmount > 0)   
				player.AddItem(selectedItem, itemAmount,  true)
				Debug.Notification(Proteus_Round(itemAmount, 0) + " " + GetFormEditorID(selectedItem) + " added to inventory.")
				if(typeCode == 41 || typeCode == 26 || typeCode == 42)
					Utility.Wait(0.1)
					player.EquipItem(selectedItem)
				endIf
			elseif itemAmount != 0
				Debug.Notification("Invalid amount entered.")
			endIf
            Proteus_CheatItemSearch(foundItems, startingPointInitial, currentPage, typeCode)
        endIf
    endIf
EndFunction