
scriptName PhenderixToolEditWeaponScript extends activemagiceffect


import PO3_SKSEFunctions
Import PhenderixToolResourceScript
Import ObjectReference
Import JContainers

;-- Properties --------------------------------------
globalvariable property ZZProteusWeaponTotalEdits auto
message property PromptSaveMenu auto
message property PromptEnchantmentMain auto
message property PromptChangeType auto
message property PromptProteus_WeaponMainMenuFunction auto
message property PromptViewStatsMenu auto
message property PromptHandSelection auto
message property PromptEnchantmentAbsorb auto
message property PromptEditWeapon auto
message property PromptIncreaseDecrease auto
message property PromptEnchantmentDamage auto
message property ZZWeaponContinueEditMenu auto
message property ZZWeaponEnchantmentMenuHandChoice auto
message property ZZWeaponEditStatsMenuHandChoice auto
message property ZZWeaponDuplicateHandChoice auto

Keyword property weapTypeBattleaxe auto
Keyword property weapTypeBow auto
Keyword property weapTypeDagger auto
Keyword property weapTypeGreatsword auto
Keyword property weapTypeMace auto
Keyword property weapTypeStaff auto
Keyword property weapTypeSword auto
Keyword property weapTypeWarAxe auto
Keyword property weapTypeWarhammer auto


enchantment property ZZEnchNone auto

MagicEffect property ZZEnchWeaponFireDamageEff auto
MagicEffect property ZZEnchWeaponFrostDamageEff auto
MagicEffect property ZZEnchWeaponShockDamageEff auto
MagicEffect property ZZEnchWeaponMagickaDamageEff auto
MagicEffect property ZZEnchWeaponStaminaDamageEff auto
MagicEffect property ZZEnchWeaponAbsorbHealthEff auto
MagicEffect property ZZEnchWeaponAbsorbMagickaEff auto
MagicEffect property ZZEnchWeaponAbsorbStaminaEff auto
MagicEffect property ZZEnchWeaponBanishEff auto
MagicEffect property ZZEnchWeaponTurnUndeadEff auto
MagicEffect property ZZEnchWeaponSoulTrapEff auto
MagicEffect property ZZEnchWeaponParalysisEff auto
MagicEffect property ZZEnchWeaponFearEff auto
Quest property ZZProteusSkyUIMenu auto

;-- Variables ---------------------------------------
Actor target
Int handWeaponEquipped ;0 = left, 1 = right

function OnEffectStart(Actor akTarget, Actor akCaster)
	target = akCaster
	Proteus_WeaponMainMenuFunction()
endFunction


function Proteus_WeaponMainMenuFunction()
	
	string[] stringArray= new String[5]
	stringArray[0] = " Weapon Summary"
	stringArray[1] = " Weapon Edit"
	stringArray[2] = " Enchant"
	stringArray[3] = " Duplicate"
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
		if Proteus_WeaponEquippedCheck() == 1		
			 Proteus_WeaponViewStatsFunction()
		else
			Proteus_WeaponMainMenuFunction()
		EndIf
	elseIf result == 1
		if Proteus_WeaponEquippedCheck() == 1		
			Proteus_WeaponEditHandSelectionFunction()
		else
			Proteus_WeaponMainMenuFunction()
		EndIf
	elseIf result == 2
		if Proteus_WeaponEquippedCheck() == 1		
			Proteus_WeaponEnchantmentHandSelectionFunction()
		else
			Proteus_WeaponMainMenuFunction()
		EndIf
	elseIf result == 3
		if Proteus_WeaponEquippedCheck() == 1		
			Proteus_WeaponDuplicateFunction()
		else
			Proteus_WeaponMainMenuFunction()
		EndIf
	elseIf result == 4
	endIf

endFunction

Int Function Proteus_WeaponEquippedCheck()
	int o = 1
	if (target.GetEquippedItemType(0) == 0 || target.GetEquippedItemType(0) == 9 || target.GetEquippedItemType(0) == 10 || target.GetEquippedItemType(0) == 11) && ((target.GetEquippedItemType(1) == 0 || target.GetEquippedItemType(1) == 9 || target.GetEquippedItemType(1) == 10 || target.GetEquippedItemType(1) == 11))
			debug.Notification("No valid weapon equipped in either hand.")
			o = 0
	endIf
	return o
EndFunction



function Proteus_WeaponViewStatsFunction()
	Int ibutton2 = PromptViewStatsMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton2 == 0
		if target.GetEquippedItemType(0) == 0 || target.GetEquippedItemType(0) == 9 || target.GetEquippedItemType(0) == 10 || target.GetEquippedItemType(0) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			 Proteus_WeaponViewStatsFunction()
		else
			Proteus_WeaponGenerateViewStats(target.GetEquippedWeapon(true), 0)
			 Proteus_WeaponViewStatsFunction()
		endIf
	elseIf ibutton2 == 1
		if target.GetEquippedItemType(1) == 0 || target.GetEquippedItemType(1) == 9 || target.GetEquippedItemType(1) == 10 || target.GetEquippedItemType(1) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			 Proteus_WeaponViewStatsFunction()
		else
			Proteus_WeaponGenerateViewStats(target.GetEquippedWeapon(false), 0)
			 Proteus_WeaponViewStatsFunction()
		endIf
	elseIf ibutton2 == 2
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction




function Proteus_WeaponEditHandSelectionFunction()
	Int ibutton2 = ZZWeaponEditStatsMenuHandChoice.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton2 == 0
		if target.GetEquippedItemType(0) == 0 || target.GetEquippedItemType(0) == 9 || target.GetEquippedItemType(0) == 10 || target.GetEquippedItemType(0) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponEditHandSelectionFunction()
		else
			handWeaponEquipped = 0
			Proteus_WeaponEditStatsFunction(target.GetEquippedWeapon(true))
		endIf
	elseIf ibutton2 == 1
		if target.GetEquippedItemType(1) == 0 || target.GetEquippedItemType(1) == 9 || target.GetEquippedItemType(1) == 10 || target.GetEquippedItemType(1) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponEditHandSelectionFunction()
		else
			handWeaponEquipped = 1
			Proteus_WeaponEditStatsFunction(target.GetEquippedWeapon(false))
		endIf
	elseIf ibutton2 == 2
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction



function Proteus_WeaponStaggerFunction(weapon item)
	String name = item.GetName()
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " 0 stagger (dagger)"
	stringArray[1] = " 0.25 stagger"
	stringArray[2] = " 0.50 stagger"
	stringArray[3] = " 0.75 stagger"
	stringArray[4] = " 1.00 stagger"
	stringArray[5] = " 1.25 stagger (warhammer)"
	stringArray[6] = " Custom Stagger Value"
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
		item.SetStagger(0)
		debug.Notification(name + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 1
		item.SetStagger(0.25)
		debug.Notification(name + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 2
		item.SetStagger(0.5)
		debug.Notification(name + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 3
		item.SetStagger(0.75)
		debug.Notification(name + " stagger is now "+ Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 4
		item.SetStagger(1.00)
		debug.Notification(name + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 5
		item.SetStagger(1.25)
		debug.Notification(name + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 6
		Float customStagger = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + name + " stagger to:" + "\n(reference: 0 daggers have 0 and warhammers have 1.25)") as Float
		if(customStagger > 0)
			item.SetStagger(customStagger)
			Debug.Notification(name + " stagger is now "  + Proteus_Round(item.GetStagger(), 2))
		else
			Debug.Notification("Invalid stagger entered. Try again.")
		EndIf
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 7
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 8
	endIf

endFunction


function Proteus_WeaponGenerateViewStats(weapon item, int option)
	String weapType = Proteus_GetWeaponType(item)
	String baseDmg = Proteus_Round(item.GetBaseDamage() as Float, 0)
	String speed = Proteus_Round(item.GetSpeed() as Float, 2)
	String stagger = Proteus_Round(item.GetStagger() as Float, 2)
	String criticalDamage =Proteus_Round( item.GetCritDamage() as Float, 0)
	String reach =Proteus_Round( item.GetReach() as Float, 2)
	String weight = Proteus_Round(item.GetWeight() as Float, 1)
	String goldValue =Proteus_Round(item.GetGoldValue() as Float, 0)

	String eName = item.GetEnchantment().GetName()
	int eNameLength = StringUtil.GetLength(eName)
	if eNameLength < 1
		eName = "None"
	endIf


	debug.MessageBox(item.GetName() + "\n\nType: " + weapType + "\nEnchant: " + eName + "\n\nBase Damage: " + baseDmg + "\nCritical Damage: " + criticalDamage + "\nSpeed: " + speed + "\nStagger: " + stagger + "\nReach: " + reach + "\nWeight: " + weight + "\nGold Value: " + goldValue)
	
	if option == 1
		Int ibuttonContinue = ZZWeaponContinueEditMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		if ibuttonContinue == 0	
			Proteus_WeaponEditStatsFunction(item)	
		elseif ibuttonContinue == 1	
			Proteus_WeaponJSaveOption(item)
		elseif ibuttonContinue == 2
			Proteus_WeaponMainMenuFunction()
		endIf
	endIf

	;Proteus_WeaponKeywords(item) ;comment out
endFunction


function Proteus_WeaponJSaveOption(weapon item)

	Int ibutton4 = PromptSaveMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton4 == 0
		Proteus_JSaveWeapon(item, 0)
	elseIf ibutton4 == 1
		Proteus_JSaveWeapon(item, 1)
	elseIf ibutton4 == 2
		Proteus_WeaponEditStatsFunction(item)
	elseIf ibutton4 == 3
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction

function Proteus_JSaveWeapon(weapon wName, Int saveOption)
	String playerName = Game.GetPlayer().GetActorBase().GetName()
	String processedPlayerName = processName(playerName)
	String weaponName = wName.GetName()
	String processedWeaponName = processName(weaponName)
	Proteus_JSaveWeaponForm(wName, processedPlayerName, processedWeaponName, saveOption)
endFunction


function Proteus_WeaponGoldFunction(weapon item)
	String name = item.GetName()
	string[] stringArray
	stringArray= new String[10]
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Gold Value"
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
		item.SetGoldValue(item.GetGoldValue() * 0.0 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 1
		item.SetGoldValue(item.GetGoldValue() * 0.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 2
		item.SetGoldValue(item.GetGoldValue() * 0.9 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 3
		item.SetGoldValue(item.GetGoldValue() * 1.1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 4
		item.SetGoldValue(item.GetGoldValue() * 1.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 5
		item.SetGoldValue(item.GetGoldValue() * 2.0 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 6
		item.SetGoldValue(item.GetGoldValue() + 1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction(item)
	elseIf result == 7
		Int customGoldValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " gold value to:" ) as Int
		if(customGoldValue > 0)
			item.SetGoldValue(customGoldValue )
			Debug.Notification(name + " gold value is now "  + Proteus_Round(item.GetGoldValue(), 0))
		else
			Debug.Notification("Invalid gold value entered. Try again.")
		EndIf
		Proteus_WeaponGoldFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	endIf
endFunction


function Proteus_WeaponCritDamageFunction(weapon item)
	String name = item.GetName()
	string[] stringArray
	stringArray= new String[10]
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Critical Damage Value"
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
		item.SetCritDamage(item.GetCritDamage() * 0.0 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 1
		item.SetCritDamage(item.GetCritDamage() * 0.5 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 2
		item.SetCritDamage(item.GetCritDamage() * 0.9 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 3
		item.SetCritDamage(item.GetCritDamage() * 1.1 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 4
		item.SetCritDamage(item.GetCritDamage() * 1.5 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 5
		item.SetCritDamage(item.GetCritDamage() * 2.0 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 6
		item.SetCritDamage(item.GetCritDamage() + 1 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 7
		Int customCritDamage = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " crit damage to:" ) as Int
		if(customCritDamage > 0)
			item.SetCritDamage(customCritDamage )
			Debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		else
			Debug.Notification("Invalid critical damage entered. Try again.")
		EndIf
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	endIf

endFunction


function Proteus_WeaponSpeedFunction(weapon item)
	String name = item.GetName()
	string[] stringArray
	stringArray= new String[10]
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Speed Value"
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
		item.SetSpeed(item.GetSpeed() * 0.0)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 1
		item.SetSpeed(item.GetSpeed() * 0.5)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 2
		item.SetSpeed(item.GetSpeed() * 0.9)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 3
		item.SetSpeed(item.GetSpeed() * 1.1)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 4
		item.SetSpeed(item.GetSpeed() * 1.5)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 5
		item.SetSpeed(item.GetSpeed() * 2.0)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 6
		item.SetSpeed(item.GetSpeed() + 1)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 7
		Int customSpeed = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " speed to:" ) as Int
		if(customSpeed > 0)
			item.SetSpeed(customSpeed )
			Debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		else
			Debug.Notification("Invalid speed entered. Try again.")
		EndIf
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	endIf
endFunction


function Proteus_WeaponDuplicateFunction()

	Int ibutton2 = ZZWeaponDuplicateHandChoice.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton2 == 0
		if target.GetEquippedItemType(0) == 0 || target.GetEquippedItemType(0) == 9 || target.GetEquippedItemType(0) == 10 || target.GetEquippedItemType(0) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponDuplicateFunction()
		else
			target.AddItem(target.GetEquippedWeapon(true) as form, 1, false)
			Proteus_WeaponDuplicateFunction()
		endIf
	elseIf ibutton2 == 1
		if target.GetEquippedItemType(1) == 0 || target.GetEquippedItemType(1) == 9 || target.GetEquippedItemType(1) == 10 || target.GetEquippedItemType(1) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponDuplicateFunction()
		else
			target.AddItem(target.GetEquippedWeapon(false) as form, 1, false)
			Proteus_WeaponDuplicateFunction()
		endIf
	elseIf ibutton2 == 2
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction

function Proteus_WeaponBaseDamageFunction(weapon item)
	String name = item.GetName()
	string[] stringArray
	stringArray= new String[10]		
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Base Damage Value"
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
		item.SetBaseDamage(item.GetBaseDamage() * 0.0 as Int)
		debug.Notification(name + " base damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 1
		item.SetBaseDamage(item.GetBaseDamage() * 0.5 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 2
		item.SetBaseDamage(item.GetBaseDamage() * 0.9 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 3
		item.SetBaseDamage(item.GetBaseDamage() * 1.1 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 4
		item.SetBaseDamage(item.GetBaseDamage() * 1.5 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 5
		item.SetBaseDamage(item.GetBaseDamage() * 2.0 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 6
		item.SetBaseDamage(item.GetBaseDamage() + 1 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 7
		Int customDamage = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " base damage to:" ) as Int
		if(customDamage > 0)
			item.SetBaseDamage(customDamage )
			Debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		else
			Debug.Notification("Invalid base damage entered. Try again.")
		EndIf
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	endIf
endFunction



function Proteus_JSaveWeaponStats(weapon wName, String processedTargetName, String processedWeaponName, Int saveOption)

	Int jWeaponStatList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Weapon_Template.json")
	Int jWStats = jmap.object()
	Int maxCount = jvalue.Count(jWeaponStatList)
	Int j = 0
	while j < maxCount
		String value
		String stat = jarray.getStr(jWeaponStatList, j, "")
		if j == 0
			value = wName.GetBaseDamage() as String
		elseIf j == 1
			value = wName.GetSpeed() as String
		elseIf j == 2
			value = wName.GetStagger() as String
		elseIf j == 3
			value = wName.GetReach() as String
		elseIf j == 4
			value = wName.GetCritDamage() as String
		elseIf j == 5
			value = wName.GetWeight() as String
		elseIf j == 6
			value = wName.GetGoldValue() as String
		elseIf j == 7
			if(wName.HasKeyword(WeapTypeBattleaxe) == TRUE)
				value = "Battleaxe"
			elseif(wName.HasKeyword(WeapTypeBow) == TRUE)
				value = "Bow"
			elseif(wName.HasKeyword(WeapTypeDagger) == TRUE)
				value = "Dagger"
			elseif(wName.HasKeyword(WeapTypeGreatsword) == TRUE)
				value = "Greatsword"
			elseif(wName.HasKeyword(WeapTypeMace) == TRUE)
				value = "Mace"
			elseif(wName.HasKeyword(WeapTypeStaff) == TRUE)
				value = "Staff"
			elseif(wName.HasKeyword(WeapTypeSword) == TRUE)
				value = "Sword"
			elseif(wName.HasKeyword(WeapTypeWarAxe) == TRUE)
				value = "Waraxe"
			elseif(wName.HasKeyword(WeapTypeWarhammer) == TRUE)
				value = "Warhammer"
			else
				value = "NoType"
			endIf
		endIf
		j += 1
		jmap.SetStr(jWStats, stat, value)
	endWhile
	if saveOption == 0
		jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedTargetName + "_" + processedWeaponName + ".json")
	elseIf saveOption == 1
		jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedWeaponName + ".json")
	endIf
	debug.Notification(wName.GetName() + " stats saved into the Proteus system.")
	Proteus_WeaponEditStatsFunction(wName)
endFunction




function Proteus_JSaveWeaponForm(weapon wName, String processedTargetName, String processedWeaponName, Int saveOption)

	Int jWeaponFormList
	if saveOption == 0
		if ZZProteusWeaponTotalEdits.GetValue() == 1 as Float
			if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedTargetName + ".json"))
				jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedTargetName + ".json")
			endIf
		endIf
	elseIf saveOption == 1
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json"))
			jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
		endIf
	endIf
	Int jWFormNames = jmap.object()
	String weaponFormKey = jmap.nextKey(jWeaponFormList, "", "")
	Bool insertNewWeapon = true
	while weaponFormKey
		weapon value = jmap.GetForm(jWeaponFormList, weaponFormKey, none) as weapon
		if value == wName
			insertNewWeapon = false
		endIf
		jmap.SetForm(jWFormNames, weaponFormKey, value as form)
		weaponFormKey = jmap.nextKey(jWeaponFormList, weaponFormKey, "")
	endWhile
	if insertNewWeapon == true
		jmap.SetForm(jWFormNames, processedWeaponName, wName as form)
		ZZProteusWeaponTotalEdits.SetValue(1 as Float)
	endIf
	if saveOption == 0
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedTargetName + ".json")
	elseIf saveOption == 1
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
	endIf
	Proteus_JSaveWeaponStats(wName, processedTargetName, processedWeaponName, saveOption)
endFunction


function Proteus_WeaponEnchantmentHandSelectionFunction()
	Int ibutton2 = ZZWeaponEnchantmentMenuHandChoice.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton2 == 0
		if target.GetEquippedItemType(0) == 0 || target.GetEquippedItemType(0) == 9 || target.GetEquippedItemType(0) == 10 || target.GetEquippedItemType(0) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponEnchantmentHandSelectionFunction()
		else
			Proteus_WeaponEnchantmentFunction(true)
		endIf
	elseIf ibutton2 == 1
		if target.GetEquippedItemType(1) == 0 || target.GetEquippedItemType(1) == 9 || target.GetEquippedItemType(1) == 10 || target.GetEquippedItemType(1) == 11
			debug.MessageBox("No valid weapon equipped in this hand.")
			Proteus_WeaponEnchantmentHandSelectionFunction()
		else
			Proteus_WeaponEnchantmentFunction(false)
		endIf
	elseIf ibutton2 == 2
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction





function Proteus_WeaponEnchantmentFunction(Bool hand)

	string[] stringArray
	stringArray= new String[16]
	stringArray[0] = " Damage Fire"
	stringArray[1] = " Damage Frost"
	stringArray[2] = " Damage Shock"
	stringArray[3] = " Damage Magicka"
	stringArray[4] = " Damage Stamina"
	stringArray[5] = " Absorb Health"
	stringArray[6] = " Absorb Magicka"
	stringArray[7] = " Absorb Stamina"
	stringArray[8] = " Banish"
	stringArray[9] = " Fear"
	stringArray[10] = " Paralysis"
	stringArray[11] = " Soul Trap"
	stringArray[12] = " Turn Undead"
	stringArray[13] = " No Enchantment"
	stringArray[14] = " Back"
	stringArray[15] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 16
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	
	Weapon wName = target.GetEquippedWeapon(hand)
	
	;set up arrays for create enchantment function
	MagicEffect[] arrayEffect = new MagicEffect[1]
	Int[] arrayArea = new Int[1]
	Int[] arrayDuration = new Int[1]
	Float[] arrayMagnitude = new Float[1]
	
	if result == 0 ;FIRE DAMAGE
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0) 
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponFireDamageEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 1 ;FROST DAMAGE
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponFrostDamageEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 2 ;SHOCK DAMAGE
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponShockDamageEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 3 ;DAMAGE MAGICKA
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponMagickaDamageEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 4 ;DAMAGE STAMINA
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponStaminaDamageEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 5 ;ABSORB HEALTH
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponAbsorbHealthEff 
			arrayArea[0] = 0
			arrayDuration[0] = 1
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 6 ;ABSORB MAGICKA
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponAbsorbMagickaEff 
			arrayArea[0] = 0
			arrayDuration[0] = 1
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 7 ;ABSORB STAMINA
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponAbsorbStaminaEff 
			arrayArea[0] = 0
			arrayDuration[0] = 1
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 8 ;BANISH
		;get magnitude or duration of enchantment
		int eMagnitude = EnchantmentLevelStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponBanishEff 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 9 ;FEAR
		;get magnitude or duration of enchantment
		int eMagnitude = EnchantmentLevelStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponFearEff 
			arrayArea[0] = 0
			arrayDuration[0] = 30
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 10 ;PARALYSIS
		;get magnitude or duration of enchantment
		int eMagnitude = EnchantmentLevelParalysisFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponParalysisEff 
			arrayArea[0] = 0
			arrayDuration[0] = eMagnitude
			arrayMagnitude[0] = 0
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 11 ;SOUL TRAP
		;get magnitude or duration of enchantment
		int eMagnitude = Proteus_WeaponEnchantmentLevelSoulTrapFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponSoulTrapEff 
			arrayArea[0] = 0
			arrayDuration[0] = eMagnitude
			arrayMagnitude[0] = 0
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 12 ;TURN UNDEAD
		;get magnitude or duration of enchantment
		int eMagnitude = EnchantmentLevelStrengthFunction(hand)

		if(eMagnitude > 0)
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchWeaponTurnUndeadEff 
			arrayArea[0] = 0
			arrayDuration[0] = 30
			arrayMagnitude[0] = eMagnitude
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, hand, wName)
		endIf
	elseif result == 13 ;NONE ENCHANTMENT
		if hand == true
			WornObject.SetEnchantment(target, 0, 0, ZZEnchNone, 100000)
		else
			WornObject.SetEnchantment(target, 1, 0, ZZEnchNone, 100000)
		endIf
	elseif result == 14
		Proteus_WeaponMainMenuFunction()
	EndIf



endFunction


;this function will use skse wornobject functions to apply custom enchantment to selected weapon
Function Proteus_CreateEnchantment(MagicEffect[] arrayEffect, Float[] arrayMagnitude, Int[] arrayArea, Int[] arrayDuration, bool hand, Weapon wName)
		if(hand == true)
			WornObject.CreateEnchantment(target, 0, 0, 100, arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
			target.UnequipItemEx(wName, 2)
			target.EquipItemEx(wName, 2)
		else
			WornObject.CreateEnchantment(target, 1, 0, 100, arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
			target.UnequipItemEx(wName, 1)
			target.EquipItemEx(wName, 1)
		endIf
		Debug.Notification("Enchantment applied to " + wName.GetName() + ".")
EndFunction


Int Function Proteus_WeaponEnchantmentDamageStrengthFunction(Bool hand)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Rank 1: 5 dmg"
	stringArray[1] = " Rank 2: 10 dmg"
	stringArray[2] = " Rank 3: 15 dmg"
	stringArray[3] = " Rank 4: 20 dmg"
	stringArray[4] = " Rank 5: 25 dmg"
	stringArray[5] = " Rank 6: 30 dmg"
	stringArray[6] = " Custom Value"
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
		return 5
	elseIf result == 1
		return 10
	elseIf result == 2
		return 15
	elseIf result == 3
		return 20
	elseIf result == 4
		return 25
	elseIf result == 5
		return 30
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Enchantment Magnitude:")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_WeaponEnchantmentFunction(hand)
	elseIf result == 8
	endIf
EndFunction



Int Function EnchantmentLevelStrengthFunction(Bool hand)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Rank 1: Up to level 10"
	stringArray[1] = " Rank 2: Up to level 20"
	stringArray[2] = " Rank 3: Up to level 30"
	stringArray[3] = " Rank 4: Up to level 40"
	stringArray[4] = " Rank 5: Up to level 50"
	stringArray[5] = " Rank 6: Up to level 60"
	stringArray[6] = " Custom Value"
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
		return 10
	elseIf result == 1
		return 20
	elseIf result == 2
		return 30
	elseIf result == 3
		return 40
	elseIf result == 4
		return 50
	elseIf result == 5
		return 60
	elseIf result == 6
		String levelAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Up to level:")		
		return levelAmount as Int
	elseIf result == 7
		Proteus_WeaponEnchantmentFunction(hand)
	elseIf result == 8
	endIf
EndFunction


Int Function EnchantmentLevelParalysisFunction(Bool hand)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Rank 1: 1 second"
	stringArray[1] = " Rank 2: 2 seconds"
	stringArray[2] = " Rank 3: 3 seconds"
	stringArray[3] = " Rank 4: 4 seconds"
	stringArray[4] = " Rank 5: 5 seconds"
	stringArray[5] = " Rank 6: 6 seconds"
	stringArray[6] = " Custom Value"
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
		return 1
	elseIf result == 1
		return 2
	elseIf result == 2
		return 3
	elseIf result == 3
		return 4
	elseIf result == 4
		return 5
	elseIf result == 5
		return 6
	elseIf result == 6
		String paralysisDuration = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Paralysis enchantment duration:")		
		return paralysisDuration as Int
	elseIf result == 7
		Proteus_WeaponEnchantmentFunction(hand)
	elseIf result == 8
	endIf
EndFunction


Int Function Proteus_WeaponEnchantmentLevelSoulTrapFunction(Bool hand)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Rank 1: 5 seconds"
	stringArray[1] = " Rank 2: 7 seconds"
	stringArray[2] = " Rank 3: 10 seconds"
	stringArray[3] = " Rank 4: 15 seconds"
	stringArray[4] = " Rank 5: 20 seconds"
	stringArray[5] = " Rank 6: 30 seconds"
	stringArray[6] = " Custom Value"
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
		return 5
	elseIf result == 1
		return 7
	elseIf result == 2
		return 10
	elseIf result == 3
		return 15
	elseIf result == 4
		return 20
	elseIf result == 5
		return 30
	elseIf result == 6
		String soulTrapDuration = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Soul Trap enchantment duration:")		
		return soulTrapDuration as Int
	elseIf result == 7
		Proteus_WeaponEnchantmentFunction(hand)
	elseIf result == 8
	endIf
EndFunction



function Proteus_WeaponWeightFunction(weapon item)
	string[] stringArray
	stringArray= new String[10]
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Weight Value"
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
		item.SetWeight(item.GetWeight() * 0.0)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 1
		item.SetWeight(item.GetWeight() * 0.5)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 2
		item.SetWeight(item.GetWeight() * 0.9)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 3
		item.SetWeight(item.GetWeight() * 1.1)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 4
		item.SetWeight(item.GetWeight() * 1.5)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 5
		item.SetWeight(item.GetWeight() * 2.0)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 6
		item.SetWeight(item.GetWeight() + 1 as Float)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction(item)
	elseIf result == 7
		Int customWeight = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " weight to:" ) as Int
		if(customWeight > 0)
			item.SetWeight(customWeight)
			Debug.Notification("Item weight: "  + item.GetWeight() as String)
		else
			Debug.Notification("Invalid custom weight entered. Try again.")
		EndIf
		Proteus_WeaponWeightFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	EndIf
endFunction



function Proteus_WeaponReachFunction(weapon item)
	string[] stringArray
	stringArray= new String[10]
	stringArray[0] = " -100%"
	stringArray[1] = " -50%"
	stringArray[2] = " -10%"
	stringArray[3] = " +10%"
	stringArray[4] = " +50%"
	stringArray[5] = " +100%"
	stringArray[6] = " +1"
	stringArray[7] = " Custom Reach Value"
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
		item.SetReach(item.GetReach() * 0.0)
		debug.Notification("Item Reach: " + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 1
		item.SetReach(item.GetReach() * 0.5)
		debug.Notification("Item Reach: " + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 2
		item.SetReach(item.GetReach() * 0.9)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 3
		item.SetReach(item.GetReach() * 1.1)
		debug.Notification("Item Reach: " + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 4
		item.SetReach(item.GetReach() * 1.5)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 5
		item.SetReach(item.GetReach() * 2.0)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 6
		item.SetReach(item.GetReach() + 1 as Float)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction(item)
	elseIf result == 7
		Float customReach = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " reach to:" ) as Float
		if(customReach > 0)
			item.SetReach(customReach)
			Debug.Notification("Item Reach: "  + item.GetReach() as String)
		else
			Debug.Notification("Invalid custom Reach entered. Try again.")
		EndIf
		Proteus_WeaponReachFunction(item)
	elseIf result == 8
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
	EndIf
endFunction


String function Proteus_GetWeaponType(weapon item)
	String weapType

	if(item.GetWeaponType() == 0)
		weapType = " Fist"
	elseif(item.GetWeaponType() == 1)
		weapType = " Sword"
	elseif(item.GetWeaponType() == 2)
		weapType = " Dagger"
	elseif(item.GetWeaponType() == 3)
		weapType = " War Axe"
	elseif(item.GetWeaponType() == 4)
		weapType = " Mace"
	elseif(item.GetWeaponType() == 5)
		weapType = " Greatsword"
	elseif(item.GetWeaponType() == 6)
		weapType = " Battleaxe/Warhammer"
	elseif(item.GetWeaponType() == 7)
		weapType = " Bow"
	elseif(item.GetWeaponType() == 8)
		weapType = " Staff"
	elseif(item.GetWeaponType() == 9)
		weapType = " Crossbow"
	else
		weapType = " Unknown"
	endIf

	return weapType
endFunction


Function Proteus_WeaponEditStatsFunction(weapon item)
	string[] stringArray
	stringArray= new String[13]
	stringArray[0] = " Base Damage"
	stringArray[1] = " Critical Damage"
	stringArray[2] = " Speed"
	stringArray[3] = " Stagger"
	stringArray[4] = " Reach"
	stringArray[5] = " Weight"
	stringArray[6] = " Gold Value"
	stringArray[7] = " Weapon Name"
	stringArray[8] = "View Stat Summary"
	stringArray[9] = " Permanently Save Stats"
	stringArray[10] = " Clear Weapon Proteus System Edits"
	stringArray[11] = " Back"
	stringArray[12] = " Exit"

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

	if result == 0
		Proteus_WeaponBaseDamageFunction(item)
	elseIf result == 1
		Proteus_WeaponCritDamageFunction(item)
	elseIf result == 2
		Proteus_WeaponSpeedFunction(item)
	elseIf result == 3
		Proteus_WeaponStaggerFunction(item)
	elseIf result == 4
		Proteus_WeaponReachFunction(item)
	elseIf result == 5
		Proteus_WeaponWeightFunction(item)
	elseIf result == 6
		Proteus_WeaponGoldFunction(item)
	elseIf result == 7
		Proteus_WeaponNameFunction(item)
	elseIf result == 8
		Proteus_WeaponGenerateViewStats(item, 1)
	elseIf result == 9
		Proteus_WeaponJSaveOption(item)
	elseIf result == 10
		Proteus_ClearWeaponEdits(item)
	elseIf result == 11
		Proteus_WeaponMainMenuFunction()
	endIf
EndFunction


Function Proteus_WeaponTypeFunction(Weapon item)
	String[] stringArray = new String[12]
	stringArray[0] = " Battleaxe"
	stringArray[1] = " Bow"
	stringArray[2] = " Dagger"
	stringArray[3] = " Greatsword"
	stringArray[4] = " Mace"
	stringArray[5] = " Staff"
	stringArray[6] = " Sword"
	stringArray[7] = " WarAxe"
	stringArray[8] = " Warhammer"
	stringArray[9] = " Back"
	stringArray[10] = " Main Menu"
	stringArray[11] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 12
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	

	Weapon leftHandWeapon
	Weapon rightHandWeapon
	Bool leftE = false
	Bool rightE = false

	if(target.GetEquippedWeapon(false) != NONE) ;right hand
		rightHandWeapon = target.GetEquippedWeapon(false)
		target.UnequipItemEx(target.GetEquippedWeapon(false), 1)
		rightE = true
	endIf
	if(target.GetEquippedWeapon(true) != NONE) ;left hand
		leftHandWeapon = target.GetEquippedWeapon(true)
		target.UnequipItemEx(target.GetEquippedWeapon(true), 2)
		leftE = true
	endIf
 
	Utility.Wait(0.5)

	;clear existing weapon keywords
	if result >= 0 && result < 9
		if(item.HasKeyword(WeapTypeBattleaxe) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeBattleaxe)
		endIf
		if(item.HasKeyword(WeapTypeBow) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeBow)
		endIf
		if(item.HasKeyword(WeapTypeDagger) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeDagger)
		endIf
		if(item.HasKeyword(WeapTypeGreatsword) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeGreatsword)
		endIf
		if(item.HasKeyword(WeapTypeMace) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeMace)
		endIf
		if(item.HasKeyword(WeapTypeStaff) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeStaff)
		endIf
		if(item.HasKeyword(WeapTypeSword) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeSword)
		endIf
		if(item.HasKeyword(WeapTypeWarAxe) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeWarAxe)
		endIf
		if(item.HasKeyword(WeapTypeWarhammer) == TRUE)
			RemoveKeywordOnForm(item, WeapTypeWarhammer)
		endIf
	endIf
	Utility.Wait(0.5)

	if result == 0 ;set to battleaxe
		AddKeywordToForm(item, WeapTypeBattleaxe)
		Debug.Notification(item.GetName() + " converted to battleaxe.")

		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 1 ;set to bow
		AddKeywordToForm(item, WeapTypeBow)
		Debug.Notification(item.GetName() + " converted to bow.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 2 ;set to dagger
		AddKeywordToForm(item, WeapTypeDagger)
		Debug.Notification(item.GetName() + " converted to dagger.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 3 ;set to greatsword
		AddKeywordToForm(item, WeapTypeGreatsword)
		Debug.Notification(item.GetName() + " converted to greatsword.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 4 ;set to mace
		AddKeywordToForm(item, WeapTypeMace)
		Debug.Notification(item.GetName() + " converted to mace.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 5 ;set to staff
		AddKeywordToForm(item, WeapTypeStaff)
		Debug.Notification(item.GetName() + " converted to staff.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 6 ;set to Sword
		AddKeywordToForm(item, WeapTypeSword)
		Debug.Notification(item.GetName() + " converted to sword.")
		Utility.Wait(0.5)
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 7 ;set to Waraxe
		AddKeywordToForm(item, WeapTypeWarAxe)
		Debug.Notification(item.GetName() + " converted to waraxe.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseif result == 8 ;set to Warhammer
		AddKeywordToForm(item, weapTypeWarhammer)
		Debug.Notification(item.GetName() + " converted to warhammer.")
		if leftE == true
			target.EquipItemEx(leftHandWeapon, 2, false, false)
		endIf
		if rightE == true
			target.EquipItemEx(rightHandWeapon, 1, false, false)
		endIf
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 9
		Proteus_WeaponEditStatsFunction(item)
	elseIf result == 10
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction



Function Proteus_WeaponNameFunction(weapon item)
	String weapName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " weight to:")		
	Int lengthInt = StringUtil.GetLength(weapName as String)
	if(lengthInt > 0)
		WornObject.SetDisplayName(target, handWeaponEquipped, 0, weapName)
		Debug.Notification("Weapon name changed to: " + weapName)
	else
		Debug.Notification("Invalid weapon name entered. Try again.")
	endIf
	Proteus_WeaponEditStatsFunction(item)
endFunction




;remove weapon edits 
function Proteus_ClearWeaponEdits(Weapon targetName)

    String playerName = Game.GetPlayer().GetActorBase().GetName()
    String processedPlayerName = processName(playerName)
    Int jWeaponFormList

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json"))
		jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
		Int jNFormNames = jmap.object()
		String WeaponFormKey = jmap.nextKey(jWeaponFormList, "", "")
		Bool insertNewWeapon = true
		int i = 0
		while WeaponFormKey
			Weapon value = jmap.GetForm(jWeaponFormList,WeaponFormKey, none) as Weapon
			if value == targetName
			else
				jmap.SetForm(jNFormNames, WeaponFormKey, value as form)
			endIf
			i+=1
			WeaponFormKey = jmap.nextKey(jWeaponFormList, WeaponFormKey, "")
		endWhile
		;write file with removed Weapon form
		jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
	endIf

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json"))
		jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json")
		Int jNFormNames = jmap.object()
		String WeaponFormKey = jmap.nextKey(jWeaponFormList, "", "")
		Bool insertNewWeapon = true
		int i = 0
		while WeaponFormKey
			Weapon value = jmap.GetForm(jWeaponFormList,WeaponFormKey, none) as Weapon
			if value == targetName
			else
				jmap.SetForm(jNFormNames, WeaponFormKey, value as form)
			endIf
			i+=1
			WeaponFormKey = jmap.nextKey(jWeaponFormList, WeaponFormKey, "")
		endWhile
		;write file with removed Weapon form
		jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json")
	endIf

	String weaponName = targetName.GetName()
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + weaponName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + weaponName + ".json")
	endIf
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + weaponName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + weaponName + ".json")
	endIf

	debug.Notification(targetName.GetName() + " edits removed. Must relaunch Skyrim for weapon stats to properly reset.")
endFunction




Function Proteus_WeaponKeywords(Weapon item)
	Keyword tempKW
	Int numKW = item.GetNumKeywords()
	int i = 0

	while i < numKW
		Debug.MessageBox("KW" + i + "\n" + tempKW.GetName())
		i+=1
	endWhile
	Proteus_WeaponGetEnchantment(item)
EndFunction

Function Proteus_WeaponGetEnchantment(Weapon item)
	Enchantment tempE = item.GetEnchantment()
	Debug.MessageBox("Enchant: " + tempE.GetName())
EndFunction