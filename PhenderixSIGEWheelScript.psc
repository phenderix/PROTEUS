Scriptname PhenderixSIGEWheelScript extends activemagiceffect  

;-- Properties --------------------------------------
Spell property ZZEditArmor auto
Spell property ZZEditWeapon auto
Spell property ZZEditSpell auto
Spell property ZZEditNPC auto
Spell property ZZEditPlayer auto
Spell property ZZEditWeather auto
Spell property ZZEditUtility auto

;-- Variables ---------------------------------------
Actor target

;-- Functions ---------------------------------------
function OnEffectStart(Actor akTarget, Actor akCaster)
	target = akTarget
	self.MainMenu()
endFunction

function MainMenu()

		Int EditWeapon = 0
		Int EditArmor = 1
		Int EditSpell = 2
		Int EditPlayer = 3
		Int EditNPC = 4
		Int EditWeather = 5
		Int EditUtility = 6
		Int Command_Exit = 7

		UIWheelMenu wheelMenu = UIExtensions.GetMenu("UIWheelMenu") as UIWheelMenu

		if wheelMenu
			wheelMenu.SetPropertyIndexString("optionText", EditWeapon, "  Weapon")
			wheelMenu.SetPropertyIndexString("optionText", EditArmor, " Armor")
			wheelMenu.SetPropertyIndexString("optionText", EditSpell, " Spell")
			wheelMenu.SetPropertyIndexString("optionText", EditPlayer, " Player")
			wheelMenu.SetPropertyIndexString("optionText", EditNPC, " NPC")
			wheelMenu.SetPropertyIndexString("optionText", EditWeather, " Weather")
			wheelMenu.SetPropertyIndexString("optionText", EditUtility, " Utility")
			wheelMenu.SetPropertyIndexString("optionText", Command_Exit, " Exit")

			wheelMenu.SetPropertyIndexString("optionLabelText", EditWeapon, "  Weapon")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditArmor, " Armor")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditSpell, " Spell")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditPlayer, " Player")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditNPC, " NPC")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditWeather, " Weather")
			wheelMenu.SetPropertyIndexString("optionLabelText", EditUtility, " Utility")
			wheelMenu.SetPropertyIndexString("optionLabelText", Command_Exit, " Exit")

			wheelMenu.SetPropertyIndexBool("optionEnabled", EditWeapon, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled", EditArmor, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  EditSpell, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  EditPlayer, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  EditNPC, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  EditWeather, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  EditUtility, true)
			wheelMenu.SetPropertyIndexBool("optionEnabled",  Command_Exit, true)
			int selection = wheelMenu.OpenMenu(target)
			
			If selection == EditWeapon
				ZZEditWeapon.Cast(target)
			ElseIf selection == EditArmor
				ZZEditArmor.Cast(target)
			ElseIf selection == EditSpell
				ZZEditSpell.Cast(target)
			ElseIf selection == EditPlayer
				ZZEditPlayer.Cast(target)
			ElseIf selection == EditNPC
				ZZEditNPC.Cast(target)
			ElseIf selection == EditWeather
				ZZEditWeather.Cast(target)
			ElseIf selection == EditUtility
				ZZEditUtility.Cast(target)
			Elseif selection == Command_Exit || selection == -1
			Endif

		Endif
		GoToState("")

endFunction