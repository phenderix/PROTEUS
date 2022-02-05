
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
Weapon item
String wName
String targetName
Int handWeaponEquipped ;0 = left, 1 = right

function OnEffectStart(Actor akTarget, Actor akCaster)
	target = akCaster
	targetName = processName(target.GetActorBase().GetName())
	Proteus_WeaponMainMenuFunction()
endFunction


function Proteus_WeaponMainMenuFunction()
	string[] stringArray= new String[5]
	stringArray[0] = " Weapon Summary"
	stringArray[1] = " Weapon Edit"
	stringArray[2] = " Weapon Enchant"
	stringArray[3] = " Weapon Duplication"
	stringArray[4] = " [Exit Menu]"
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
	if result == 0 ;weapon summary, stats function
		Proteus_WeaponViewStats()
	elseIf result == 1 ;weapon edit
		Proteus_WeaponSelectHand(0)
	elseIf result == 2 ;weapon enchant
		Proteus_WeaponSelectHand(1)
	elseIf result == 3 ;duplicate
		Proteus_WeaponSelectHand(2)
	elseIf result == 4
	endIf
endFunction

function Proteus_WeaponViewStats()
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	bool left = false
	bool right = false
	int z = 0
	if target.GetEquippedWeapon(true) ;left hand weapon
		Proteus_WeaponGenerateStatSummary(target.GetEquippedWeapon(true), "Left")
		Utility.Wait(0.1)
	endIf
	If target.GetEquippedWeapon(false) ;right hand weapon
		Proteus_WeaponGenerateStatSummary(target.GetEquippedWeapon(false), "Right")
		Utility.Wait(0.1)
	EndIf	
endFunction

function Proteus_WeaponSelectHand(int option) ;0 call edit weapon, 1 call enchant, 2 duplicate
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	bool left = false
	bool right = false
	int z = 0
	if target.GetEquippedWeapon(true) ;left hand weapon
		listMenu.AddEntryItem("Left Hand: " + target.GetEquippedWeapon(true).GetName())
		left = true
		z += 1
	endIf
	If target.GetEquippedWeapon(false) ;right hand weapon
		listMenu.AddEntryItem("Right Hand: " + target.GetEquippedWeapon(false).GetName())
		right = true
		z += 1
	EndIf
	if z != 0
		listMenu.OpenMenu()
		int result = listMenu.GetResultInt()
		if result == 0 && left == true ;left hand
			item = target.GetEquippedWeapon(true)
			wName = processName(item.GetName())
			handWeaponEquipped = 0
			if option == 0
				Proteus_WeaponEdit()
			elseif option == 1
				Proteus_WeaponEnchant()
			elseif option == 2
				target.AddItem(target.GetEquippedWeapon(true), 1)
				Proteus_WeaponSelectHand(option)
			endIf
		elseIf result == 1 || (result == 0 && right == true) ; right hand
			item = target.GetEquippedWeapon(false)
			wName = processName(item.GetName())
			handWeaponEquipped = 1
			if option == 0
				Proteus_WeaponEdit()
			elseif option == 1
				Proteus_WeaponEnchant()
			elseif option == 2
				target.AddItem(target.GetEquippedWeapon(false), 1)
				Proteus_WeaponSelectHand(option)
			endIf
		elseif result != -1
			Debug.MessageBox("No weapons equipped.")
		endIf
	endIf	
endFunction


function Proteus_WeaponStaggerFunction()
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
        debug.Notification(wName + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 1
        item.SetStagger(0.25)
        debug.Notification(wName + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 2
        item.SetStagger(0.5)
        debug.Notification(wName + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 3
        item.SetStagger(0.75)
        debug.Notification(wName + " stagger is now "+ Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 4
        item.SetStagger(1.00)
        debug.Notification(wName + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 5
        item.SetStagger(1.25)
        debug.Notification(wName + " stagger is now " + Proteus_Round(item.GetStagger(), 2))
        Proteus_WeaponStaggerFunction()
    elseIf result == 6
        Float customStagger = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + wName + " stagger to:" + "\n(reference: 0 daggers have 0 and warhammers have 1.25)") as Float
        if(customStagger > 0)
            item.SetStagger(customStagger)
            Debug.Notification(wName + " stagger is now "  + Proteus_Round(item.GetStagger(), 2))
        else
			Debug.Notification("Invalid stagger entered. Try again.")
		EndIf
		Proteus_WeaponStaggerFunction()
	elseIf result == 7
		Proteus_WeaponEdit()
	elseIf result == 8
	endIf

endFunction


function Proteus_WeaponGenerateStatSummary(weapon itemTemp, String hand)
	String weapType = Proteus_GetWeaponType(itemTemp)
	String baseDmg = Proteus_Round(itemTemp.GetBaseDamage() as Float, 0)
	String speed = Proteus_Round(itemTemp.GetSpeed() as Float, 2)
	String stagger = Proteus_Round(itemTemp.GetStagger() as Float, 2)
	String criticalDamage = Proteus_Round(itemTemp.GetCritDamage() as Float, 0)
	String reach =Proteus_Round( itemTemp.GetReach() as Float, 2)
	String weight = Proteus_Round(itemTemp.GetWeight() as Float, 1)
	String goldValue =Proteus_Round(itemTemp.GetGoldValue() as Float, 0)
	String eName = itemTemp.GetEnchantment().GetName()
	int eNameLength = StringUtil.GetLength(eName)
	if eNameLength < 1
		eName = "None"
	endIf
	debug.MessageBox(itemTemp.GetName() + "\nEquip Hand: " + hand + "\n\nType: " + weapType + "\nEnchant: " + eName + "\n\nBase Damage: " + baseDmg + "\nCritical Damage: " + criticalDamage + "\nSpeed: " + speed + "\nStagger: " + stagger + "\nReach: " + reach + "\nWeight: " + weight + "\nGold Value: " + goldValue)
endFunction


function Proteus_WeaponJSaveOption()
	Int ibutton4 = PromptSaveMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton4 == 0
		Proteus_JSaveWeaponForm(0)
	elseIf ibutton4 == 1
		Proteus_JSaveWeaponForm(1)
	elseIf ibutton4 == 2
		Proteus_WeaponEdit()
	elseIf ibutton4 == 3
		Proteus_WeaponMainMenuFunction()
	endIf
endFunction

function Proteus_WeaponGoldFunction()
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
		Proteus_WeaponGoldFunction()
	elseIf result == 1
		item.SetGoldValue(item.GetGoldValue() * 0.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 2
		item.SetGoldValue(item.GetGoldValue() * 0.9 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 3
		item.SetGoldValue(item.GetGoldValue() * 1.1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 4
		item.SetGoldValue(item.GetGoldValue() * 1.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 5
		item.SetGoldValue(item.GetGoldValue() * 2.0 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 6
		item.SetGoldValue(item.GetGoldValue() + 1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_WeaponGoldFunction()
	elseIf result == 7
		Int customGoldValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " gold value to:" ) as Int
		if(customGoldValue > 0)
			item.SetGoldValue(customGoldValue )
			Debug.Notification(name + " gold value is now "  + Proteus_Round(item.GetGoldValue(), 0))
		else
			Debug.Notification("Invalid gold value entered. Try again.")
		EndIf
		Proteus_WeaponGoldFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	endIf
endFunction


function Proteus_WeaponCritDamageFunction()
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
		Proteus_WeaponCritDamageFunction()
	elseIf result == 1
		item.SetCritDamage(item.GetCritDamage() * 0.5 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 2
		item.SetCritDamage(item.GetCritDamage() * 0.9 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 3
		item.SetCritDamage(item.GetCritDamage() * 1.1 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 4
		item.SetCritDamage(item.GetCritDamage() * 1.5 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 5
		item.SetCritDamage(item.GetCritDamage() * 2.0 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 6
		item.SetCritDamage(item.GetCritDamage() + 1 as Int)
		debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		Proteus_WeaponCritDamageFunction()
	elseIf result == 7
		Int customCritDamage = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " crit damage to:" ) as Int
		if(customCritDamage > 0)
			item.SetCritDamage(customCritDamage )
			Debug.Notification(name + " critical damage  is now " + Proteus_Round(item.GetCritDamage(), 0))
		else
			Debug.Notification("Invalid critical damage entered. Try again.")
		EndIf
		Proteus_WeaponCritDamageFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	endIf

endFunction


function Proteus_WeaponSpeedFunction()
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
		Proteus_WeaponSpeedFunction()
	elseIf result == 1
		item.SetSpeed(item.GetSpeed() * 0.5)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 2
		item.SetSpeed(item.GetSpeed() * 0.9)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 3
		item.SetSpeed(item.GetSpeed() * 1.1)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 4
		item.SetSpeed(item.GetSpeed() * 1.5)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 5
		item.SetSpeed(item.GetSpeed() * 2.0)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 6
		item.SetSpeed(item.GetSpeed() + 1)
		debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		Proteus_WeaponSpeedFunction()
	elseIf result == 7
		Int customSpeed = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " speed to:" ) as Int
		if(customSpeed > 0)
			item.SetSpeed(customSpeed )
			Debug.Notification(name + " speed is now " + Proteus_Round(item.GetSpeed(), 2))
		else
			Debug.Notification("Invalid speed entered. Try again.")
		EndIf
		Proteus_WeaponSpeedFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	endIf
endFunction


function Proteus_WeaponBaseDamageFunction()
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
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 1
		item.SetBaseDamage(item.GetBaseDamage() * 0.5 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 2
		item.SetBaseDamage(item.GetBaseDamage() * 0.9 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 3
		item.SetBaseDamage(item.GetBaseDamage() * 1.1 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 4
		item.SetBaseDamage(item.GetBaseDamage() * 1.5 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 5
		item.SetBaseDamage(item.GetBaseDamage() * 2.0 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 6
		item.SetBaseDamage(item.GetBaseDamage() + 1 as Int)
		debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 7
		Int customDamage = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " base damage to:" ) as Int
		if(customDamage > 0)
			item.SetBaseDamage(customDamage )
			Debug.Notification(name + " base Damage is now " + Proteus_Round(item.GetBaseDamage(), 0))
		else
			Debug.Notification("Invalid base damage entered. Try again.")
		EndIf
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	endIf
endFunction


function Proteus_JSaveWeaponStats(Int saveOption)
    Int jWeaponStatList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Weapon_Template.json")
    Int jWStats = jmap.object()
    Int maxCount = jvalue.Count(jWeaponStatList)
    Int j = 0
    while j < maxCount
        String value
        String stat = jarray.getStr(jWeaponStatList, j, "")
        if j == 0
            value = item.GetBaseDamage() as String
        elseIf j == 1
            value = item.GetSpeed() as String
        elseIf j == 2
            value = item.GetStagger() as String
        elseIf j == 3
            value = item.GetReach() as String
        elseIf j == 4
            value = item.GetCritDamage() as String
        elseIf j == 5
            value = item.GetWeight() as String
        elseIf j == 6
            value = item.GetGoldValue() as String
        elseIf j == 7
            if(item.HasKeyword(WeapTypeBattleaxe) == TRUE)
                value = "Battleaxe"
            elseif(item.HasKeyword(WeapTypeBow) == TRUE)
                value = "Bow"
            elseif(item.HasKeyword(WeapTypeDagger) == TRUE)
                value = "Dagger"
            elseif(item.HasKeyword(WeapTypeGreatsword) == TRUE)
                value = "Greatsword"
            elseif(item.HasKeyword(WeapTypeMace) == TRUE)
                value = "Mace"
            elseif(item.HasKeyword(WeapTypeStaff) == TRUE)
                value = "Staff"
            elseif(item.HasKeyword(WeapTypeSword) == TRUE)
                value = "Sword"
            elseif(item.HasKeyword(WeapTypeWarAxe) == TRUE)
                value = "Waraxe"
            elseif(item.HasKeyword(WeapTypeWarhammer) == TRUE)
                value = "Warhammer"
            else
                value = "NoType"
            endIf
        endIf
        j += 1
        jmap.SetStr(jWStats, stat, value)
    endWhile
    if saveOption == 0
        jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + targetName + "_" + wName + ".json")
    elseIf saveOption == 1
        jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + wName + ".json")
    endIf
    debug.Notification(item.GetName() + " stats saved into the Proteus system.")
    Proteus_WeaponEdit()
endFunction


function Proteus_JSaveWeaponForm(int saveOption)
	Int jWeaponFormList
    if saveOption == 0
        if ZZProteusWeaponTotalEdits.GetValue() == 1 as Float
            if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + targetName + ".json"))
                jWeaponFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + targetName + ".json")
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
        if value == item
            insertNewWeapon = false
        endIf
        jmap.SetForm(jWFormNames, weaponFormKey, value as form)
        weaponFormKey = jmap.nextKey(jWeaponFormList, weaponFormKey, "")
    endWhile
    if insertNewWeapon == true
        jmap.SetForm(jWFormNames, wName, item as form)
        ZZProteusWeaponTotalEdits.SetValue(1 as Float)
    endIf
    if saveOption == 0
        jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + targetName + ".json")
    elseIf saveOption == 1
        jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_ACROSS_ALL_SAVES.json")
    endIf
    Proteus_JSaveWeaponStats(saveOption)
endFunction


function Proteus_WeaponEnchant()
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
    
    ;set up arrays for create enchantment function
    MagicEffect[] arrayEffect = new MagicEffect[1]
    Int[] arrayArea = new Int[1]
    Int[] arrayDuration = new Int[1]
    Float[] arrayMagnitude = new Float[1]
    
    if result == 0 ;FIRE DAMAGE
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0) 
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponFireDamageEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 1 ;FROST DAMAGE
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponFrostDamageEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 2 ;SHOCK DAMAGE
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponShockDamageEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 3 ;DAMAGE MAGICKA
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponMagickaDamageEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 4 ;DAMAGE STAMINA
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponStaminaDamageEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 5 ;ABSORB HEALTH
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponAbsorbHealthEff 
            arrayArea[0] = 0
            arrayDuration[0] = 1
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 6 ;ABSORB MAGICKA
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponAbsorbMagickaEff 
            arrayArea[0] = 0
            arrayDuration[0] = 1
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 7 ;ABSORB STAMINA
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentDamageStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponAbsorbStaminaEff 
            arrayArea[0] = 0
            arrayDuration[0] = 1
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 8 ;BANISH
        ;get magnitude or duration of enchantment
        int eMagnitude = EnchantmentLevelStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponBanishEff 
            arrayArea[0] = 0
            arrayDuration[0] = 0
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 9 ;FEAR
        ;get magnitude or duration of enchantment
        int eMagnitude = EnchantmentLevelStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponFearEff 
            arrayArea[0] = 0
            arrayDuration[0] = 30
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 10 ;PARALYSIS
        ;get magnitude or duration of enchantment
        int eMagnitude = EnchantmentLevelParalysisFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponParalysisEff 
            arrayArea[0] = 0
            arrayDuration[0] = eMagnitude
            arrayMagnitude[0] = 0
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 11 ;SOUL TRAP
        ;get magnitude or duration of enchantment
        int eMagnitude = Proteus_WeaponEnchantmentLevelSoulTrapFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponSoulTrapEff 
            arrayArea[0] = 0
            arrayDuration[0] = eMagnitude
            arrayMagnitude[0] = 0
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 12 ;TURN UNDEAD
        ;get magnitude or duration of enchantment
        int eMagnitude = EnchantmentLevelStrengthFunction()

        if(eMagnitude > 0)
            ;set up initial effect attributes for create enchantment function
            arrayEffect[0] = ZZEnchWeaponTurnUndeadEff 
            arrayArea[0] = 0
            arrayDuration[0] = 30
            arrayMagnitude[0] = eMagnitude
            Float maxCharge = 100000
            Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
        endIf
    elseif result == 13 ;NONE ENCHANTMENT
        if handWeaponEquipped == true
            WornObject.SetEnchantment(target, 0, 0, ZZEnchNone, 100000)
        else
            WornObject.SetEnchantment(target, 1, 0, ZZEnchNone, 100000)
        endIf
    elseif result == 14
        Proteus_WeaponMainMenuFunction()
    EndIf


endFunction




;this function will use skse wornobject functions to apply custom enchantment to selected weapon
Function Proteus_CreateEnchantment(MagicEffect[] arrayEffect, Float[] arrayMagnitude, Int[] arrayArea, Int[] arrayDuration)
		if(handWeaponEquipped == 0)
			WornObject.CreateEnchantment(target, 0, 0, 100, arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
			target.UnequipItemEx(item, 2)
			target.EquipItemEx(item, 2)
		else
			WornObject.CreateEnchantment(target, 1, 0, 100, arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
			target.UnequipItemEx(item, 1)
			target.EquipItemEx(item, 1)
		endIf
		Debug.Notification("Enchantment applied to " + wName + ".")
EndFunction


Int Function Proteus_WeaponEnchantmentDamageStrengthFunction()
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
		Proteus_WeaponEnchant()
	elseIf result == 8
	endIf
EndFunction

Int Function EnchantmentLevelStrengthFunction()
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
		Proteus_WeaponEnchant()
	elseIf result == 8
	endIf
EndFunction

Int Function EnchantmentLevelParalysisFunction()
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
		Proteus_WeaponEnchant()
	elseIf result == 8
	endIf
EndFunction

Int Function Proteus_WeaponEnchantmentLevelSoulTrapFunction()
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
		Proteus_WeaponEnchant()
	elseIf result == 8
	endIf
EndFunction

function Proteus_WeaponWeightFunction()
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
		Proteus_WeaponWeightFunction()
	elseIf result == 1
		item.SetWeight(item.GetWeight() * 0.5)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 2
		item.SetWeight(item.GetWeight() * 0.9)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 3
		item.SetWeight(item.GetWeight() * 1.1)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 4
		item.SetWeight(item.GetWeight() * 1.5)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 5
		item.SetWeight(item.GetWeight() * 2.0)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 6
		item.SetWeight(item.GetWeight() + 1 as Float)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_WeaponWeightFunction()
	elseIf result == 7
		Int customWeight = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " weight to:" ) as Int
		if(customWeight > 0)
			item.SetWeight(customWeight)
			Debug.Notification("Item weight: "  + item.GetWeight() as String)
		else
			Debug.Notification("Invalid custom weight entered. Try again.")
		EndIf
		Proteus_WeaponWeightFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	EndIf
endFunction

function Proteus_WeaponReachFunction()
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
		Proteus_WeaponReachFunction()
	elseIf result == 1
		item.SetReach(item.GetReach() * 0.5)
		debug.Notification("Item Reach: " + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 2
		item.SetReach(item.GetReach() * 0.9)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 3
		item.SetReach(item.GetReach() * 1.1)
		debug.Notification("Item Reach: " + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 4
		item.SetReach(item.GetReach() * 1.5)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 5
		item.SetReach(item.GetReach() * 2.0)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 6
		item.SetReach(item.GetReach() + 1 as Float)
		debug.Notification("Item Reach: "  + Proteus_Round(item.GetReach(), 1))
		Proteus_WeaponReachFunction()
	elseIf result == 7
		Float customReach = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " reach to:" ) as Float
		if(customReach > 0)
			item.SetReach(customReach)
			Debug.Notification("Item Reach: "  + item.GetReach() as String)
		else
			Debug.Notification("Invalid custom Reach entered. Try again.")
		EndIf
		Proteus_WeaponReachFunction()
	elseIf result == 8
		Proteus_WeaponEdit()
	elseIf result == 9
	EndIf
endFunction

String function Proteus_GetWeaponType(Weapon itemTemp)
	String weapType
	if(itemTemp.GetWeaponType() == 0)
		weapType = " Fist"
	elseif(itemTemp.GetWeaponType() == 1)
		weapType = " Sword"
	elseif(itemTemp.GetWeaponType() == 2)
		weapType = " Dagger"
	elseif(itemTemp.GetWeaponType() == 3)
		weapType = " War Axe"
	elseif(itemTemp.GetWeaponType() == 4)
		weapType = " Mace"
	elseif(itemTemp.GetWeaponType() == 5)
		weapType = " Greatsword"
	elseif(itemTemp.GetWeaponType() == 6)
		weapType = " Battleaxe/Warhammer"
	elseif(itemTemp.GetWeaponType() == 7)
		weapType = " Bow"
	elseif(itemTemp.GetWeaponType() == 8)
		weapType = " Staff"
	elseif(itemTemp.GetWeaponType() == 9)
		weapType = " Crossbow"
	else
		weapType = " Unknown"
	endIf
	return weapType
endFunction

Function Proteus_WeaponEdit()
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
		Proteus_WeaponBaseDamageFunction()
	elseIf result == 1
		Proteus_WeaponCritDamageFunction()
	elseIf result == 2
		Proteus_WeaponSpeedFunction()
	elseIf result == 3
		Proteus_WeaponStaggerFunction()
	elseIf result == 4
		Proteus_WeaponReachFunction()
	elseIf result == 5
		Proteus_WeaponWeightFunction()
	elseIf result == 6
		Proteus_WeaponGoldFunction()
	elseIf result == 7
		Proteus_WeaponNameFunction()
	elseIf result == 8
		Proteus_WeaponViewStats()
	elseIf result == 9
		Proteus_WeaponJSaveOption()
	elseIf result == 10
		Proteus_ClearWeaponEdits()
	elseIf result == 11
		Proteus_WeaponMainMenuFunction()
	endIf
EndFunction


Function Proteus_WeaponNameFunction()
	String weapName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + wName + " weight to:")		
	Int lengthInt = StringUtil.GetLength(weapName as String)
	if(lengthInt > 0)
		WornObject.SetDisplayName(target, handWeaponEquipped, 0, weapName)
		Debug.Notification("Weapon name changed to: " + weapName)
	else
		Debug.Notification("Invalid weapon name entered. Try again.")
	endIf
	Proteus_WeaponEdit()
endFunction


;remove weapon edits 
function Proteus_ClearWeaponEdits()
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
			if value == item
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
			if value == item
			else
				jmap.SetForm(jNFormNames, WeaponFormKey, value as form)
			endIf
			i+=1
			WeaponFormKey = jmap.nextKey(jWeaponFormList, WeaponFormKey, "")
		endWhile
		;write file with removed Weapon form
		jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusW_M1_" + processedPlayerName + ".json")
	endIf

	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + wName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + processedPlayerName + "_" + wName + ".json")
	endIf
	if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + wName + ".json"))
		removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusW_M2_" + wName + ".json")
	endIf

	debug.Notification(targetName + " edits removed. Must relaunch Skyrim for weapon stats to properly reset.")
endFunction
