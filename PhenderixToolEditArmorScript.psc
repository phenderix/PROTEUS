scriptName PhenderixToolEditArmorScript extends activemagiceffect

import PO3_SKSEFunctions
Import PhenderixToolResourceScript
Import JContainers

;-- Properties --------------------------------------
globalvariable property ZZProteusArmorTotalEdits auto

message property PromptIncreaseDecrease auto
message property PromptArmorPiece2 auto
message property PromptArmorLightHeavy auto
message property PromptArmorPiece auto
message property PromptEnchantmentMain auto
message property PromptArmorPiece3 auto
message property PromptEditWeapon auto
message property PromptArmorAttribute auto
message property PromptEnchantmentAbsorb auto
message property PromptEnchantmentDamage auto
message property PromptSaveMenu auto
message property ZZArmorContinueEditMenu auto
message property ZZArmorContinueViewMenu auto
keyword property armorHeavy auto

;ReferenceAlias property heavyArmorAlias auto
;Quest property heavyArmorQuest auto

Keyword property lightArmorKWD auto
Keyword property heavyArmorKWD auto

enchantment property ZZEnchNone auto

MagicEffect property ZZEnchArmorFortifyAlchemyConstantSelf auto
MagicEffect property ZZEnchArmorFortifyAlterationConstantSelf auto
MagicEffect property ZZEnchArmorFortifyArcheryConstantSelf auto
MagicEffect property ZZEnchArmorFortifyArmorRatingSelf auto
MagicEffect property ZZEnchArmorFortifyArticulation auto
MagicEffect property ZZEnchArmorFortifyBlockConstantSelf auto
MagicEffect property ZZEnchArmorFortifyCarryConstantSelf auto
MagicEffect property ZZEnchArmorFortifyConjurationConstantSelf auto
MagicEffect property ZZEnchArmorFortifyDestructionConstantSelf auto
MagicEffect property ZZEnchArmorFortifyEnchantingConstantSelf auto
MagicEffect property ZZEnchArmorFortifyHealRateConstantSelf auto
MagicEffect property ZZEnchArmorFortifyHealthConstantSelf auto
MagicEffect property ZZEnchArmorFortifyHeavyArmorConstantSelf auto
MagicEffect property ZZEnchArmorFortifyIllusionConstantSelf auto
MagicEffect property ZZEnchArmorFortifyLightArmorConstantSelf auto
MagicEffect property ZZEnchArmorFortifyLockpickingConstantSelf auto
MagicEffect property ZZEnchArmorFortifyMagickaConstantSelf auto
MagicEffect property ZZEnchArmorFortifyMagickaRateConstantSelf auto
MagicEffect property ZZEnchArmorFortifyOneHandedConstantSelf auto
MagicEffect property ZZEnchArmorFortifyPickpocketConstantSelf auto
MagicEffect property ZZEnchArmorFortifyRestorationConstantSelf auto
MagicEffect property ZZEnchArmorFortifyShoutTimerConstantSelf auto
MagicEffect property ZZEnchArmorFortifySmithingConstantSelf auto
MagicEffect property ZZEnchArmorFortifySneakConstantSelf auto
MagicEffect property ZZEnchArmorFortifyStaminaConstantSelf auto
MagicEffect property ZZEnchArmorFortifyStaminaRateConstantSelf auto
MagicEffect property ZZEnchArmorFortifyTwoHandedConstantSelf auto
MagicEffect property ZZEnchArmorMuffleConstantSelf auto
MagicEffect property ZZEnchArmorResistDiseaseConstantSelf auto
MagicEffect property ZZEnchArmorResistFireConstantSelf auto
MagicEffect property ZZEnchArmorResistFrostConstantSelf auto
MagicEffect property ZZEnchArmorResistMagicConstantSelf auto
MagicEffect property ZZEnchArmorResistPoisonConstantSelf auto
MagicEffect property ZZEnchArmorResistShockConstantSelf auto
MagicEffect property ZZEnchArmorWaterbreathingConstantSelf auto
MagicEffect property ZZEnchArmorFortifyEnchantingStrengthConstantSelf auto
Quest property ZZProteusSkyUIMenu auto


;-- Variables ---------------------------------------
Actor target
Armor currentArmor
Int currentArmorSlot
Form[] equippedArmorListForms
String[] equippedArmorListNames

;-- Functions ---------------------------------------
function OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
	Proteus_ArmorGenerateListFunction() ;populate arrays for equipped armor form IDs and equipper armor names for menus
	Proteus_ArmorMainMenuFunction()
endFunction

function Proteus_ArmorMainMenuFunction()
	string[] stringArray
	stringArray= new String[5]
	stringArray[0] = " Armor Summary"
	stringArray[1] = " Armor Edit"
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
		Proteus_ArmorEquippedMenuGenerationFunction(0)
	elseIf result == 1
		Proteus_ArmorEquippedMenuGenerationFunction(1)
	elseIf result == 2
		Proteus_ArmorEquippedMenuGenerationFunction(2)
	elseIf result == 3
		Proteus_ArmorEquippedMenuGenerationFunction(3)
	elseIf result == 4
	endIf
endFunction


function Proteus_ArmorGenerateListFunction()
	int equippedCountTracker = 0
	
	;load equipped items form array
	equippedArmorListForms = Utility.CreateFormArray(40)
	equippedArmorListNames = Utility.CreateStringArray(40)
	int slotsChecked
	slotsChecked += 0x00100000
	slotsChecked += 0x00200000 ;ignore reserved slots
    	slotsChecked += 0x80000000
 
	int thisSlot = 0x01
	while (thisSlot < 0x80000000)
        if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check slots we haven't found anything equipped on already
            Armor thisArmor = target.GetWornForm(thisSlot) as Armor
            if (thisArmor)
				if(equippedArmorListNames.RFind(thisArmor.GetName()) < 0)
					equippedArmorListForms[equippedCountTracker] = thisArmor
					equippedArmorListNames[equippedCountTracker] = thisArmor.GetName()
					equippedCountTracker+=1
				else
					;fixes problem of populating array with duplicate items as some individual items take up multiple equip slots
				endIf
				
            else ;no armor was found on this slot
                slotsChecked += thisSlot
            endif
        endif
        thisSlot *= 2 ;double the number to move on to the next slot
    endWhile
EndFunction

;vieworedit = 0 means view stats, vieworedit = 1 means edit stats
function Proteus_ArmorEquippedMenuGenerationFunction(int vieworedit)
	Int equippedArmorListLength = equippedArmorListNames.Length
	;Debug.MessageBox("Equipped Armor Count: " + equippedArmorListLength)
	string[] stringArray = new String[42]
	int k = 0
	while StringUtil.GetLength(equippedArmorListNames[k]) > 0
		stringArray[k] = equippedArmorListNames[k]
		;Debug.Notification("String Array K: " + stringArray[k])
		k+=1
	endWhile
	stringArray[k] = " Back"
	;Debug.Notification("String Array K: " + stringArray[k])
	k+=1
	stringArray[k] = " Exit"
	;Debug.Notification("String Array K: " + stringArray[k])
	;Debug.Notification("K: " + k)
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = k+1
		int i = 0
		while i < n
			;Debug.Notification("Adding List Item: " + stringArray[i])
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	int backOption = k - 1

	String itemNameTemp = equippedArmorListNames[result]
	Int itemNameLength = StringUtil.GetLength(itemNameTemp)

	;Debug.Notification("TempName " + itemNameTemp + " Result " + result + " VoE" + vieworedit)

	if vieworedit == 0 && result <= k  && result >= 0 && itemNameTemp != "" ;view equipped armor stats
		Proteus_ViewArmorStatsFunction(equippedArmorListForms[result] as Armor, 0)
	elseif vieworedit == 1 && result <= k && result >= 0 && itemNameLength > 0;edit equipped armor stats
		Proteus_EditArmorStatsFunction(equippedArmorListForms[result] as Armor)
	elseif vieworedit == 2 && result <= k && result >= 0 && itemNameLength > 0;enchant equipped armor
		Proteus_ArmorEnchantFunction(equippedArmorListForms[result] as Armor)
	elseif vieworedit == 3 && result <= k && result >= 0 && itemNameLength > 0;duplicate armor
		target.AddItem(equippedArmorListForms[result], 1)
		Debug.Notification(target.GetDisplayName() + "'s " + equippedArmorListNames[result] + " duplicated.")
		Proteus_ArmorEquippedMenuGenerationFunction(3)
	elseif result == backOption
		Proteus_ArmorMainMenuFunction()
	Else
	endIf
endFunction



function Proteus_ViewArmorStatsFunction(Armor item, int option) ;option = 0 means coming from view stats, option = 1 means coming from edit stats
	String armorType
	Float armorRating = item.GetArmorRating() as Float
	Float weightClass = item.GetWeightClass() as Float
	if weightClass == 0 as Float
		armorType = "Light Armor"
	elseIf weightClass == 1 as Float
		armorType = "Heavy Armor"
	else
		armorType = "None"
	endIf
	Float weight = item.GetWeight()
	Float goldValue = item.GetGoldValue() as Float
	debug.MessageBox(item.GetName() + "\n\nArmor Rating: " + Proteus_Round(armorRating, 0) + "\nType: " + armorType + "\nWeight: " + Proteus_Round(weight, 0) + "\nGold Value: " + Proteus_Round(goldValue, 0) + "\nWarmth: " + Proteus_Round(item.GetWarmthRating(), 0))

	if(option == 0)
		Int ibutton = ZZArmorContinueViewMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		if ibutton == 0 ;back to stats
			Proteus_ArmorEquippedMenuGenerationFunction(0)
		elseif ibutton == 1 ;main menu
			Proteus_ArmorMainMenuFunction()
		elseif ibutton == 2 ;exit menu
		EndIf
	elseif(option == 1)
		Int ibutton = ZZArmorContinueEditMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		if ibutton == 0 ;back to edit
			Proteus_ArmorEquippedMenuGenerationFunction(1)
		elseif ibutton == 1 ;save into Proteus
			Proteus_ArmorJSaveOption(item)
		elseif ibutton == 2 ;main menu
			Proteus_ArmorMainMenuFunction()
		elseif ibutton == 3 ;exit menu
		EndIf
	endIf
endFunction


function Proteus_EditArmorStatsFunction(Armor item)
	string[] stringArray = new String[10]
	stringArray[0] = " Armor Rating"
	stringArray[1] = " Weight"
	stringArray[2] = " Gold Value"
	stringArray[3] = " Weight Class"
	stringArray[4] = " Armor Name"
	stringArray[5] = "Stat Summary"
	stringArray[6] = " Permanently Save"
	stringArray[7] = " Clear Armor Proteus System Edits"
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
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 1
		Proteus_ArmorWeightFunction(item)
	elseIf result == 2
		Proteus_ArmorGoldFunction(item)
	elseIf result == 3
		Proteus_ArmorHeavyLightFunction(item)
	elseIf result == 4
		Proteus_ArmorNameFunction(item)
	elseIf result == 5
		Proteus_ViewArmorStatsFunction(item, 1)
	elseIf result == 6
		Proteus_ArmorJSaveOption(item)
	elseIf result == 7
		Proteus_ClearArmorEdits(item)
	elseIf result == 8
		Proteus_ArmorEquippedMenuGenerationFunction(1)
	endIf

endFunction

function Proteus_ArmorEnchantFunction(Armor item)

		string[] stringArray
		stringArray= new String[40]
		stringArray[0] = " Fortify Alchemy (Stronger Potions)"
		stringArray[1] = " Fortify Alteration (Reduce Magicka Cost)"
		stringArray[2] = " Fortify Archery (Increase Damage)"
		stringArray[3] = " Fortify Armor Rating"
		stringArray[4] = " Fortify Articulation (Better Prices)"
		stringArray[5] = " Fortify Block (Increase Blocked Damage)"
		stringArray[6] = " Fortify Carry Weight"
		stringArray[7] = " Fortify Conjuration (Reduce Magicka Cost)"
		stringArray[8] = " Fortify Destruction (Reduce Magicka Cost)"
		stringArray[9] = " Fortify Enchanting (Skill Level)"
		stringArray[10] = " Fortify Enchanting (Better Enchants)"
		stringArray[11] = " Fortify Heal Regen Rate"
		stringArray[12] = " Fortify Health"
		stringArray[13] = " Fortify Heavy Armor (Skill Level)"
		stringArray[14] = " Fortify Illusion (Reduce Magicka Cost)"
		stringArray[15] = " Fortify LightArmor (Skill Level)"
		stringArray[16] = " Fortify Lockpicking (Better Lockpicking)"
		stringArray[17] = " Fortify Magicka"
		stringArray[18] = " Fortify Magicka Regen Rate"
		stringArray[19] = " Fortify Onehanded (Increase Damage)"
		stringArray[20] = " Fortify Pickpocket"
		stringArray[21] = " Fortify Restoration (Reduce Magicka Cost)"
		stringArray[22] = " Fortify Shout Cooldown"
		stringArray[23] = " Fortify Smithing (Better Smithing)"
		stringArray[24] = " Fortify Sneak (Better Sneaking)"
		stringArray[25] = " Fortify Stamina"
		stringArray[26] = " Fortify Stamina Regen Rate"
		stringArray[27] = " Fortify Twohanded (Increase Damage)"
		stringArray[28] = " Muffle"
		stringArray[29] = " Resist Disease"
		stringArray[30] = " Resist Fire"
		stringArray[31] = " Resist Frost"
		stringArray[32] = " Resist Magic"
		stringArray[33] = " Resist Poison"
		stringArray[34] = " Resist Shock"
		stringArray[35] = " Waterbreathing"
		stringArray[36] = " None"
		stringArray[37] = " Back"
		stringArray[38] = " Main Menu"
		stringArray[39] = " Exit"
	
		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			int n = 40
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
		
		if result == 0 ;Fortify Alchemy
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyAlchemyConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 1 ;Fortify Alteration
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyMagicSkillFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyAlterationConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 2 ;Fortify Archery
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyDamageFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyArcheryConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 3 ;Fortify Armor Rating
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyLargeFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyArmorRatingSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 4 ;Fortify Speechcraft
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyArticulation 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 5 ;Fortify Block
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBlockFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyBlockConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 6 ;Fortify Carryweight
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyLargeFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyCarryConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 7 ;Fortify Conjuration
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyMagicSkillFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyConjurationConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 8 ;Fortify Destruction
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyMagicSkillFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyDestructionConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 9 ;Fortify Enchanting
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyEnchantingConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 10 ;Fortify Enchanting Strength
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyEnchantingStrengthConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 11 ;Fortify Heal Rate
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyRegenFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyHealRateConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 12 ;Fortify Health
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyLargeFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyHealthConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 13 ;Fortify HeavyArmor
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyHeavyArmorConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 14 ;Fortify Illusion
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyMagicSkillFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyIllusionConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 15 ;Fortify LightArmor
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyLightArmorConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 16 ;Fortify Lockpicking
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyLockpickingConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 17 ;Fortify Magicka
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyLargeFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyMagickaConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 18 ;Fortify Magicka Regen Rate
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyRegenFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyMagickaRateConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 19 ;Fortify OneHanded
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyDamageFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyOneHandedConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 20 ;Fortify Pickpocket
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyPickpocketConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 21 ;Fortify Restoration
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyMagicSkillFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyRestorationConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 22 ;Fortify Shout Cooldown
			;get magnitude or duration of enchantment
			Float eMagnitude = Proteus_ArmorEnchantmentFortifyShoutCooldownFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyShoutTimerConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 23 ;Fortify Smithing
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifySmithingConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 24 ;Fortify Sneak
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyBetterFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifySneakConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 25 ;Fortify Stamina
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyLargeFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyStaminaConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 26 ;Fortify Stamina Regen Rate
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyRegenFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyStaminaRateConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 27 ;Fortify TwoHanded
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyDamageFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorFortifyTwoHandedConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 28 ;Muffle
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchArmorMuffleConstantSelf 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = 0.5
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
		elseif result == 29 ;Resist Disease
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistDiseaseConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 30 ;Resist Fire
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistFireConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 31 ;Resist Frost
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistFrostConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 32 ;Resist Magic
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistMagicConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 33 ;Resist Poison
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistPoisonConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 34 ;Resist Shock
			;get magnitude or duration of enchantment
			int eMagnitude = Proteus_ArmorEnchantmentFortifyResistFunction(item)
			if(eMagnitude > 0) 
				;set up initial effect attributes for create enchantment function
				arrayEffect[0] = ZZEnchArmorResistShockConstantSelf 
				arrayArea[0] = 0
				arrayDuration[0] = 0
				arrayMagnitude[0] = eMagnitude
				Float maxCharge = 100000
				Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
			endIf
		elseif result == 35 ;Waterbreathing
			;set up initial effect attributes for create enchantment function
			arrayEffect[0] = ZZEnchArmorWaterbreathingConstantSelf 
			arrayArea[0] = 0
			arrayDuration[0] = 0
			arrayMagnitude[0] = 1
			Float maxCharge = 100000
			Proteus_CreateEnchantment(arrayEffect, arrayMagnitude, arrayArea, arrayDuration, item)
		elseif result == 36
			WornObject.SetEnchantment(target, 0, item.GetSlotMask(), ZZEnchNone, 100000)
		elseif result == 37
			Proteus_ArmorEquippedMenuGenerationFunction(2)
		elseif result == 38
			Proteus_ArmorMainMenuFunction()
		endIf
endFunction



;this function will use skse wornobject functions to apply custom enchantment to selected armor
Function Proteus_CreateEnchantment(MagicEffect[] arrayEffect, Float[] arrayMagnitude, Int[] arrayArea, Int[] arrayDuration, Armor aName)
	WornObject.CreateEnchantment(target, 0, aName.GetSlotMask(), 100, arrayEffect, arrayMagnitude, arrayArea, arrayDuration)
	target.UnequipItemEx(aName, aName.GetSlotMask())
	target.EquipItemEx(aName, aName.GetSlotMask())
	Debug.Notification("Enchantment applied to " + aName.GetName() + ".")
EndFunction


Int Function Proteus_ArmorEnchantmentFortifyFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Fortify by 5"
	stringArray[1] = " Fortify by 10"
	stringArray[2] = " Fortify by 15"
	stringArray[3] = " Fortify by 20"
	stringArray[4] = " Fortify by 25"
	stringArray[5] = " Fortify by 30"
	stringArray[6] = " Custom Fortify"
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
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Fortify Magnitude:")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction

Int Function Proteus_ArmorEnchantmentFortifyLargeFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " Fortify by 20"
	stringArray[1] = " Fortify by 50"
	stringArray[2] = " Fortify by 100"
	stringArray[3] = " Fortify by 150"
	stringArray[4] = " Fortify by 200"
	stringArray[5] = " Fortify by 300"
	stringArray[6] = " Custom Fortify"
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
		return 20
	elseIf result == 1
		return 50
	elseIf result == 2
		return 100
	elseIf result == 3
		return 150
	elseIf result == 4
		return 200
	elseIf result == 5
		return 300
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Fortify Magnitude:")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction


Int Function Proteus_ArmorEnchantmentFortifyRegenFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " +20% Regeneration"
	stringArray[1] = " +30% Regeneration"
	stringArray[2] = " +40% Regeneration"
	stringArray[3] = " +50% Regeneration"
	stringArray[4] = " +75% Regeneration"
	stringArray[5] = " +100% Regeneration"
	stringArray[6] = " Custom Regeneration"
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
		return 20
	elseIf result == 1
		return 30
	elseIf result == 2
		return 40
	elseIf result == 3
		return 50
	elseIf result == 4
		return 75
	elseIf result == 5
		return 100
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Regeneration Magnitude: \n(don't include the %, ex: 40)")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction

Int Function Proteus_ArmorEnchantmentFortifyResistFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " 15% Resist"
	stringArray[1] = " 30% Resist"
	stringArray[2] = " 40% Resist"
	stringArray[3] = " 50% Resist"
	stringArray[4] = " 60% Resist"
	stringArray[5] = " 100% Resist"
	stringArray[6] = " Custom Resist"
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
		return 15
	elseIf result == 1
		return 30
	elseIf result == 2
		return 40
	elseIf result == 3
		return 50
	elseIf result == 4
		return 60
	elseIf result == 5
		return 100
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Resist Magnitude: \n(don't include the %, ex: 40)")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction


Int Function Proteus_ArmorEnchantmentFortifyMagicSkillFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " -10% Magicka Cost"
	stringArray[1] = " -20% Magicka Cost"
	stringArray[2] = " -30% Magicka Cost "
	stringArray[3] = " -40% Magicka Cost"
	stringArray[4] = " -50% Magicka Cost"
	stringArray[5] = " -100% Magicka Cost"
	stringArray[6] = " Custom Magicka Cost Reduction"
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
		return 100
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Magicka Cost Reduction: \n(don't include the %, ex: 40)")		
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction



Int Function Proteus_ArmorEnchantmentFortifyDamageFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " +10% Damage"
	stringArray[1] = " +20% Damage"
	stringArray[2] = " +30% Damage"
	stringArray[3] = " +40% Damage"
	stringArray[4] = " +50% Damage"
	stringArray[5] = " +60% Damage"
	stringArray[6] = " Custom Damage"
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
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Damage Magnitude: \n(don't include the %, ex: 40)")			
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction

Int Function Proteus_ArmorEnchantmentFortifyBlockFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " +10% Blocked Damage"
	stringArray[1] = " +20% Blocked Damage"
	stringArray[2] = " +30% Blocked Damage"
	stringArray[3] = " +40% Blocked Damage"
	stringArray[4] = " +50% Blocked Damage"
	stringArray[5] = " +60% Blocked Damage"
	stringArray[6] = " Custom Blocked Damage"
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
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Blocked Damage Magnitude: \n(don't include the %, ex: 40)")			
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction


Int Function Proteus_ArmorEnchantmentFortifyBetterFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " 10% Better"
	stringArray[1] = " +15% Better"
	stringArray[2] = " +20% Better"
	stringArray[3] = " +25% Better"
	stringArray[4] = " +30% Better"
	stringArray[5] = " +50% Better"
	stringArray[6] = " Custom % Better"
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
		return 15
	elseIf result == 2
		return 20
	elseIf result == 3
		return 25
	elseIf result == 4
		return 30
	elseIf result == 5
		return 50
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("% Better Magnitude: \n(don't include the %, ex: 40)")			
		return magnitudeAmount as Int
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction

Float Function Proteus_ArmorEnchantmentFortifyShoutCooldownFunction(Armor item)
	string[] stringArray
	stringArray= new String[9]
	stringArray[0] = " -10% Shout Cooldown"
	stringArray[1] = " -20% Shout Cooldown"
	stringArray[2] = " -30% Shout Cooldown"
	stringArray[3] = " -40% Shout Cooldown"
	stringArray[4] = " -50% Shout Cooldown"
	stringArray[5] = " -100% Shout Cooldown"
	stringArray[6] = " Custom Shout Cooldown"
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
		return 0.10
	elseIf result == 1
		return 0.20
	elseIf result == 2
		return 0.30
	elseIf result == 3
		return 0.40
	elseIf result == 4
		return 0.50
	elseIf result == 5
		return 1.00
	elseIf result == 6
		String magnitudeAmount = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Custom Shout Cooldown Magnitude: \n(don't include the %, ex: 40)")			
		return (magnitudeAmount as Float)/100 as Float
	elseIf result == 7
		Proteus_ArmorEnchantFunction(item)
	elseIf result == 8
	endIf
EndFunction
























































function Proteus_ArmorArmorRatingFunction(Armor item)
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
	stringArray[7] = " Custom Armor Rating"
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
		item.SetArmorRating((item.GetArmorRating() as Float * 0.0) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 1
		item.SetArmorRating((item.GetArmorRating() as Float * 0.5) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 2
		item.SetArmorRating((item.GetArmorRating() as Float * 0.9) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 3
		item.SetArmorRating((item.GetArmorRating() as Float * 1.1) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 4
		item.SetArmorRating((item.GetArmorRating() as Float * 1.5) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 5
		item.SetArmorRating((item.GetArmorRating() as Float * 2.0) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 6
		item.SetArmorRating((item.GetArmorRating() as Float + 1 as Float) as Int)
		debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
		Proteus_ArmorArmorRatingFunction(item)
	elseIf result == 7
		String customArmorRating = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " armor rating to:")	
		Int customLength = StringUtil.GetLength(customArmorRating)
		if(customLength > 0)
			item.SetArmorRating(customArmorRating as Int)
			debug.Notification(item.GetName() + "'s Armor Rating is now " + Proteus_Round(item.GetArmorRating(),0))
			Proteus_EditArmorStatsFunction(item)
		Else
			Debug.Notification("Invalid custom value entered. Try again.")
			Proteus_ArmorArmorRatingFunction(item)
		endIf
	elseIf result == 8
		Proteus_EditArmorStatsFunction(item)
	endIf
endFunction

function Proteus_ArmorGoldFunction(Armor item)
	String name = item.GetName()
	string[] stringArray = new String[10]
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
		Proteus_ArmorGoldFunction(item)
	elseIf result == 1
		item.SetGoldValue(item.GetGoldValue() * 0.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 2
		item.SetGoldValue(item.GetGoldValue() * 0.9 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 3
		item.SetGoldValue(item.GetGoldValue() * 1.1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 4
		item.SetGoldValue(item.GetGoldValue() * 1.5 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 5
		item.SetGoldValue(item.GetGoldValue() * 2.0 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 6
		item.SetGoldValue(item.GetGoldValue() + 1 as Int)
		debug.Notification(name + " gold value is now " + Proteus_Round(item.GetGoldValue(), 0))
		Proteus_ArmorGoldFunction(item)
	elseIf result == 7
		Int customGoldValue = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " gold value to:" ) as Int
		if(customGoldValue > 0)
			item.SetGoldValue(customGoldValue )
			Debug.Notification(name + " gold value is now "  + Proteus_Round(item.GetGoldValue(), 0))
		else
			Debug.Notification("Invalid gold value entered. Try again.")
		EndIf
		Proteus_ArmorGoldFunction(item)
	elseIf result == 8
		Proteus_EditArmorStatsFunction(item)
	elseIf result == 9
	endIf
endFunction











function Proteus_ArmorWeightFunction(Armor item)
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
		Proteus_ArmorWeightFunction(item)
	elseIf result == 1
		item.SetWeight(item.GetWeight() * 0.5)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 2
		item.SetWeight(item.GetWeight() * 0.9)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 3
		item.SetWeight(item.GetWeight() * 1.1)
		debug.Notification("Item weight: " + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 4
		item.SetWeight(item.GetWeight() * 1.5)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 5
		item.SetWeight(item.GetWeight() * 2.0)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 6
		item.SetWeight(item.GetWeight() + 1 as Float)
		debug.Notification("Item weight: "  + Proteus_Round(item.GetWeight(), 1))
		Proteus_ArmorWeightFunction(item)
	elseIf result == 7
		Int customWeight = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " weight to:" ) as Int
		if(customWeight > 0)
			item.SetWeight(customWeight)
			Debug.Notification("Item weight: "  + item.GetWeight() as String)
		else
			Debug.Notification("Invalid custom weight entered. Try again.")
		EndIf
		Proteus_ArmorWeightFunction(item)
	elseIf result == 8
		Proteus_EditArmorStatsFunction(item)
	elseIf result == 9
	EndIf
endFunction







function Proteus_ArmorHeavyLightFunction(Armor item)
	Int ibutton4 = PromptArmorLightHeavy.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton4 == 0 ;set to light armor
		item.SetWeightClass(0)
		if(item.HasKeyword(HeavyArmorKWD) == TRUE)
			ReplaceKeywordOnForm(item, lightArmorKWD, heavyArmorKWD)
		elseif(item.HasKeyword(lightArmorKWD) == FALSE)
			AddKeywordToForm(item, lightArmorKWD)
		endIf
		Debug.Notification(item.GetName() + " converted to light armor.")
		Proteus_EditArmorStatsFunction(item)
	elseIf ibutton4 == 1 ;set to heavy armor
		item.SetWeightClass(1)
		if(item.HasKeyword(HeavyArmorKWD) == TRUE)
			ReplaceKeywordOnForm(item, lightArmorKWD, heavyArmorKWD)
		elseif(item.HasKeyword(lightArmorKWD) == FALSE)
			AddKeywordToForm(item, lightArmorKWD)
		endIf
		Debug.Notification(item.GetName() + " converted to heavy armor.")
		Proteus_EditArmorStatsFunction(item)
	elseIf ibutton4 == 2 ;set to neither light or heavy armor
		if(item.HasKeyword(HeavyArmorKWD) == TRUE)
			RemoveKeywordOnForm(item, HeavyArmorKWD)
		endIf
		if(item.HasKeyword(LightArmorKWD) == TRUE)
			RemoveKeywordOnForm(item, LightArmorKWD)
		endif
		item.SetWeightClass(2)
		Proteus_EditArmorStatsFunction(item)
	elseIf ibutton4 == 3
		Proteus_EditArmorStatsFunction(item)
	elseIf ibutton4 == 4
		Proteus_ArmorMainMenuFunction()
	endIf
endFunction






function Proteus_ArmorJSaveOption(Armor item)
	Int ibutton4 = PromptSaveMenu.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	if ibutton4 == 0
		Proteus_ArmorJSaveArmor(item, 0)
	elseIf ibutton4 == 1
		Proteus_ArmorJSaveArmor(item, 1)
	elseIf ibutton4 == 2
		Proteus_EditArmorStatsFunction(item)
	elseIf ibutton4 == 3
		Proteus_ArmorMainMenuFunction()
	endIf
endFunction

function Proteus_ArmorJSaveArmor(Armor wName, Int saveOption)
	String playerName = game.GetPlayer().GetBaseObject().GetName()
	String processedPlayerName = PhenderixToolResourceScript.processName(playerName)
	String armorName = wName.GetName()
	String processedArmorName = PhenderixToolResourceScript.processName(armorName)
	Proteus_ArmorJSaveArmorForm(wName, processedPlayerName, processedArmorName, saveOption)
endFunction

function Proteus_ArmorJSaveArmorForm(Armor wName, String processedTargetName, String processedArmorName, Int saveOption)
	Int jArmorFormList
	if saveOption == 0
		if ZZProteusArmorTotalEdits.GetValue() == 1 as Float
			if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedTargetName + ".json"))
				jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedTargetName + ".json")
			endIf
		endIf
	elseIf saveOption == 1
		if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json"))
			jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json")
		endIf
	endIf
	Int jWFormNames = jmap.object()
	String armorFormKey = jmap.nextKey(jArmorFormList, "", "")
	Bool insertNewArmor = true
	while armorFormKey
		Armor value = jmap.GetForm(jArmorFormList, armorFormKey, none) as Armor
		if value == wName
			insertNewArmor = false
		endIf
		jmap.SetForm(jWFormNames, armorFormKey, value as form)
		armorFormKey = jmap.nextKey(jArmorFormList, armorFormKey, "")
	endWhile
	if insertNewArmor == true
		jmap.SetForm(jWFormNames, processedArmorName, wName as form)
		ZZProteusArmorTotalEdits.SetValue(1 as Float)
	endIf
	if saveOption == 0
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedTargetName + ".json")
	elseIf saveOption == 1
		jvalue.writeToFile(jWFormNames, jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json")
	endIf
	Proteus_ArmorJSaveArmorStats(wName, processedTargetName, processedArmorName, saveOption)
endFunction

function Proteus_ArmorJSaveArmorStats(Armor wName, String processedTargetName, String processedArmorName, Int saveOption)
	Int jArmorStatList = jvalue.readFromFile("Data/Scripts/Proteus JSON/Proteus_Armor_Template.json")
	Int jWStats = jmap.object()
	Int maxCount = jvalue.Count(jArmorStatList)
	Int j = 0
	while j < maxCount
		String value
		String stat = jarray.getStr(jArmorStatList, j, "")
		if j == 0
			value = wName.GetArmorRating() as String
		elseIf j == 1
			value = wName.GetWeightClass() as String
		elseIf j == 2
			value = wName.GetWeight() as String
		elseIf j == 3
			value = wName.GetGoldValue() as String
		elseif j == 4
			if(wName.HasKeyword(HeavyArmorKWD) == TRUE)
				value = "HeavyArmor"
			elseif(wName.HasKeyword(LightArmorKWD) == TRUE)
				value = "LightArmor"
			else
				value = "NoType"
			endIf
		endIf
		j += 1
		jmap.SetStr(jWStats, stat, value)
	endWhile
	if saveOption == 0
		jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedTargetName + "_" + processedArmorName + ".json")
	elseIf saveOption == 1
		jvalue.writeToFile(jWStats, jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedArmorName + ".json")
	endIf
	debug.Notification(wName.GetName() + " stats saved into the Proteus system.")
	Proteus_EditArmorStatsFunction(wName)
endFunction



Function Proteus_ArmorNameFunction(Armor item)
	String armorName = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Change " + item.GetName() + " weight to:")	
	Int lengthInt = StringUtil.GetLength(armorName as String)
	if(lengthInt > 0)
		WornObject.SetDisplayName(target, 0, item.GetSlotMask(), armorName)
		Debug.Notification("Armor name changed to: " + armorName)
		
	else
		Debug.Notification("Invalid armor name entered. Try again.")
	endIf
	Proteus_EditArmorStatsFunction(item)
endFunction


;remove Armor edits 
function Proteus_ClearArmorEdits(Armor targetName)

    String playerName = Game.GetPlayer().GetActorBase().GetName()
    String processedPlayerName = processName(playerName)
    Int jArmorFormList

    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json"))
        jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json")
        Int jNFormNames = jmap.object()
        String ArmorFormKey = jmap.nextKey(jArmorFormList, "", "")
        Bool insertNewArmor = true
        int i = 0
        while ArmorFormKey
            Armor value = jmap.GetForm(jArmorFormList,ArmorFormKey, none) as Armor
            if value == targetName
            else
                jmap.SetForm(jNFormNames, ArmorFormKey, value as form)
            endIf
            i+=1
            ArmorFormKey = jmap.nextKey(jArmorFormList, ArmorFormKey, "")
        endWhile
        ;write file with removed Armor form
        jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusA_M1_ACROSS_ALL_SAVES.json")
    endIf

    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedPlayerName + ".json"))
        jArmorFormList = jvalue.readFromFile(jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedPlayerName + ".json")
        Int jNFormNames = jmap.object()
        String ArmorFormKey = jmap.nextKey(jArmorFormList, "", "")
        Bool insertNewArmor = true
        int i = 0
        while ArmorFormKey
            Armor value = jmap.GetForm(jArmorFormList,ArmorFormKey, none) as Armor
            if value == targetName
            else
                jmap.SetForm(jNFormNames, ArmorFormKey, value as form)
            endIf
            i+=1
            ArmorFormKey = jmap.nextKey(jArmorFormList, ArmorFormKey, "")
        endWhile
        ;write file with removed Armor form
        jvalue.writeToFile(jNFormNames, jcontainers.userDirectory() + "/Proteus/ProteusA_M1_" + processedPlayerName + ".json")
    endIf

    String ArmorName = targetName.GetName()
    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedPlayerName + "_" + ArmorName + ".json"))
        removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + processedPlayerName + "_" + ArmorName + ".json")
    endIf
    if(fileExistsAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + ArmorName + ".json"))
        removeFileAtPath(jcontainers.userDirectory() + "/Proteus/ProteusA_M2_" + ArmorName + ".json")
    endIf

    debug.Notification(targetName.GetName() + " edits removed. Must relaunch Skyrim for armor stats to properly reset.")
endFunction

