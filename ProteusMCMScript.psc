Scriptname ProteusMCMScript extends SKI_ConfigBase


;-- Properties --------------------------------------
globalvariable property k1 auto
globalvariable property k2 auto
globalvariable property k3 auto
globalvariable property k5 auto
globalvariable property k6 auto
globalvariable property k7 auto
globalvariable property k8 auto
globalvariable property k9 auto
globalvariable property k10 auto
globalvariable property k11 auto
globalvariable property k12 auto
globalvariable property k13 auto
globalvariable property disableHotkeys auto
globalvariable property explosionsOn auto
globalvariable property ZZEnableSpawnPerkLoad auto
globalvariable property ZZEnableSpawnSpellLoad auto
globalvariable property ZZLoadPlayerPreset auto

;-- Variables ---------------------------------------
Int castK1
Int castK2
Int castK3
Int castK5
Int castK6
Int castK7
Int castK8
Int castK9
Int castK10
Int castK11
Int castK12
Int castK13

Int disableOID
Int explosionsOnOID
Int spawnPerksLoadOID
Int spawnSpellsLoadOID
Int presetGameStartOID

Bool disableVal
Bool explosionsOnVal
Bool spawnPerksOnVal
Bool spawnSpellsOnVal
Bool presetGameStartOnVal

;-- Functions ---------------------------------------

function OnPageReset(String page)
	if page == "General"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)
		self.AddHeaderOption("Player Module Options", 0)
		explosionsOnOID = self.AddToggleOption("Green Explosion on Appearance Change", explosionsOn.getValue() as Bool)
		spawnPerksLoadOID = self.AddToggleOption("Spawns Have Perks", ZZEnableSpawnPerkLoad.getValue() as Bool)
		spawnSpellsLoadOID = self.AddToggleOption("Spawns Have Spells", ZZEnableSpawnSpellLoad.getValue() as Bool)
		presetGameStartOID = self.AddToggleOption("Load Preset on Player at Game Start", ZZLoadPlayerPreset.getValue() as Bool)

		self.SetCursorPosition(1)
		self.AddHeaderOption("NPC Module Options", 0)
	endIf

	if page == "Hotkeys"
		self.SetCursorFillMode(self.TOP_TO_BOTTOM)

		self.AddHeaderOption("Hotkey Options:", 0)
		disableOID = self.AddToggleOption("Disable All Hotkeys", disableHotkeys.getValue() as Bool)
		self.AddHeaderOption("Player Module Hotkeys:", 0)
		castK9 = self.AddKeyMapOption("Player Module Menu", k9.getValue() as Int, 0)
		castK1 = self.AddKeyMapOption("Save Character", k1.getValue() as Int, 0)
		;castK2 = self.AddKeyMapOption("Quicksave Player Character", k2.getValue() as Int, 0)
		castK3 = self.AddKeyMapOption("Switch Character", k3.getValue() as Int, 0)
		castK6 = self.AddKeyMapOption("Summon Existing Character", k6.getValue() as Int, 0)
		castK7 = self.AddKeyMapOption("Load Appearance Preset", k7.getValue() as Int, 0)
		castK10 = self.AddKeyMapOption("Load Appearance + Equipped Items Preset", k10.getValue() as Int, 0)
		castK11 = self.AddKeyMapOption("Player Cheat Menu", k11.getValue() as Int, 0)

		self.AddHeaderOption("NPC Module Hotkeys", 0)
		castK8 = self.AddKeyMapOption("NPC Module Menu", k8.getValue() as Int, 0)
		castK5 = self.AddKeyMapOption("Take Control of NPC", k5.getValue() as Int, 0)

		self.SetCursorPosition(1)
		self.AddHeaderOption("Other Hotkeys", 0)
		castK12 = self.AddKeyMapOption("Proteus Wheel", k12.getValue() as Int, 0)
		castK13 = self.AddKeyMapOption("Spawner", k13.getValue() as Int, 0)

	endIf
endFunction


function OnOptionKeyMapChange(Int option, Int keyCode, String a_conflictControl, String a_conflictName)
{Called when a key has been remapped}
	if option == castK1 
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k1.setValue(keyCode as Float)
	;elseif option == castK2
	;	self.SetKeyMapOptionValueST(keyCode, false, "")
	;	k2.setValue(keyCode as Float)
	elseif option == castK3
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k3.setValue(keyCode as Float)
	elseif option == castK5
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k5.setValue(keyCode as Float)
	elseif option == castK6
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k6.setValue(keyCode as Float)
	elseif option == castK7
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k7.setValue(keyCode as Float)
	elseif option == castK8
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k8.setValue(keyCode as Float)
	elseif option == castK9
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k9.setValue(keyCode as Float)
	elseif option == castK10
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k10.setValue(keyCode as Float)
	elseif option == castK11
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k11.setValue(keyCode as Float)
	elseif option == castK12
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k12.setValue(keyCode as Float)
	elseif option == castK13
		self.SetKeyMapOptionValueST(keyCode, false, "")
		k13.setValue(keyCode as Float)
	endIf
	self.ForcePageReset()
endFunction

function OnOptionHighlight(Int option)
	if option == disableOID
		self.SetInfoText("Enable to disable all hotkeys added by Project Proteus.\nDefault: false")
	elseif option == explosionsOnOID
		self.SetInfoText("Enable to have green explosion emit from player character upon changing appearance.\nDefault: true")
	elseif option == spawnPerksLoadOID
		self.SetInfoText("Enable to have Proteus Spawns load perks from the associated player character.\nDefault: true")
	elseif option == spawnSpellsLoadOID
		self.SetInfoText("Enable to have Proteus Spawns load spells from the associated player character.\nDefault: true")
	elseif option == presetGameStartOID
		self.SetInfoText("Enable to have preset load on player at game start. Prevents appearance issues.\nDefault: true")
	endIf
endFunction


function OnOptionDefault(Int option)
	if option == disableOID
		disableVal = false
		self.SetToggleOptionValue(disableOID, disableVal, false)
		if disableVal == false
			disableHotkeys.setValue(0 as Float)
		elseIf disableVal == true
			disableHotkeys.setValue(1 as Float)
		endIf
	endIf

	if option == explosionsOnOID
		explosionsOnVal = true
		self.SetToggleOptionValue(explosionsOnOID, explosionsOnVal, false)
		if explosionsOnVal == false
			explosionsOn.setValue(0 as Float)
		elseIf explosionsOnVal == true
			explosionsOn.setValue(1 as Float)
		endIf
	endIf

	if option == spawnPerksLoadOID
		spawnPerksOnVal = true
		self.SetToggleOptionValue(spawnPerksLoadOID, spawnPerksOnVal, false)
		if spawnPerksOnVal == false
			ZZEnableSpawnPerkLoad.setValue(0 as Float)
		elseIf spawnPerksOnVal == true
			ZZEnableSpawnPerkLoad.setValue(1 as Float)
		endIf
	endIf

	if option == spawnSpellsLoadOID
		spawnSpellsOnVal = true
		self.SetToggleOptionValue(spawnSpellsLoadOID, spawnSpellsOnVal, false)
		if spawnSpellsOnVal == false
			ZZEnableSpawnSpellLoad.setValue(0 as Float)
		elseIf spawnSpellsOnVal == true
			ZZEnableSpawnSpellLoad.setValue(1 as Float)
		endIf
	endIf

	if option == presetGameStartOID
		presetGameStartOnVal = true
		self.SetToggleOptionValue(presetGameStartOID, presetGameStartOnVal, false)
		if presetGameStartOnVal == false
			ZZLoadPlayerPreset.setValue(0 as Float)
		elseIf presetGameStartOnVal == true
			ZZLoadPlayerPreset.setValue(1 as Float)
		endIf
	endIf
endFunction

Int function GetVersion()
	return 1
endFunction

function OnOptionSelect(Int option)
	if option == disableOID
		disableVal = !disableVal
		self.SetToggleOptionValue(disableOID, disableVal, false)
		if disableVal == false
			disableHotkeys.setValue(0 as Float)
		elseIf disableVal == true
			disableHotkeys.setValue(1 as Float)
		endIf
	endIf

	if option == explosionsOnOID
		explosionsOnVal = !explosionsOnVal
		self.SetToggleOptionValue(explosionsOnOID, explosionsOnVal, false)
		if explosionsOnVal == false
			explosionsOn.setValue(0 as Float)
		elseIf explosionsOnVal == true
			explosionsOn.setValue(1 as Float)
		endIf
	endIf

	if option == spawnPerksLoadOID
		spawnPerksOnVal = !spawnPerksOnVal
		self.SetToggleOptionValue(spawnPerksLoadOID, spawnPerksOnVal, false)
		if spawnPerksOnVal == false
			ZZEnableSpawnPerkLoad.setValue(0 as Float)
		elseIf spawnPerksOnVal == true
			ZZEnableSpawnPerkLoad.setValue(1 as Float)
		endIf
	endIf

	if option == spawnSpellsLoadOID
		spawnSpellsOnVal = !spawnSpellsOnVal
		self.SetToggleOptionValue(spawnSpellsLoadOID, spawnSpellsOnVal, false)
		if spawnSpellsOnVal == false
			ZZEnableSpawnSpellLoad.setValue(0 as Float)
		elseIf spawnSpellsOnVal == true
			ZZEnableSpawnSpellLoad.setValue(1 as Float)
		endIf
	endIf

	if option == presetGameStartOID
		presetGameStartOnVal = !presetGameStartOnVal
		self.SetToggleOptionValue(presetGameStartOID, presetGameStartOnVal, false)
		if presetGameStartOnVal == false
			ZZLoadPlayerPreset.setValue(0 as Float)
		elseIf presetGameStartOnVal == true
			ZZLoadPlayerPreset.setValue(1 as Float)
		endIf
	endIf
endFunction

function OnOptionSliderAccept(Int option, Float value)
{Called when a new slider value has been accepted}

endFunction

function OnOptionSliderOpen(Int option)
{Called when a slider option has been selected}

endFunction

