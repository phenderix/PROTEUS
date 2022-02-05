Scriptname ProteusNPCControlScript extends ActiveMagicEffect  

Spell property proteusControlSpell auto
Spell property proteusControlSpell2 auto

GlobalVariable property npcHotkey auto
Actor target
Int iHotkey
Int leftAttack
Int rightAttack
Int shoutSpell
Int jump
Int activate
Int sneak
int readyWeapon
int sprint
Int sneakingToggle
Spell spellLeft
Spell spellRight
Spell spellVoice
String raceName

Spell Property crSprigganConcentration auto
Spell Property crAtronachFlameFirebolt auto
Spell Property crAtronachFlameFlames auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	if(akTarget.GetAV("Health") > 0)
		raceName = akTarget.GetRace().GetName()
		sneakingToggle = 0
		Actor playerRef = Game.GetPlayer()
		target = akTarget
		iHotkey = npcHotkey.GetValue() as Int

		Game.SetCameraTarget(akTarget)
		target.SetPlayerControls(true)
		akCaster.SetPlayerControls(false)
		target.EnableAI(true)
		Game.SetPlayerAIDriven(true)
		Game.DisablePlayerControls(false, true, false, false, false, True, true, false, 0)
		Game.ForceThirdPerson()
		;target.StopCombat()

		leftAttack = input.Getmappedkey("Left Attack/Block")
		rightAttack = input.Getmappedkey("Right Attack/Block")
		shoutSpell = input.Getmappedkey("Shout")
		jump = input.Getmappedkey("Jump")
		activate = input.Getmappedkey("Activate")
		sneak = input.GetMappedKey("Sneak")
		readyWeapon = input.GetMappedKey("Ready Weapon")
		sprint = input.GetMappedKey("Sprint")
		;Debug.Notification("LAtk:" + leftAttack + " RAtk:" + rightAttack)
	
		spellLeft = target.GetEquippedSpell(0)
		spellRight = target.GetEquippedSpell(1)
		spellVoice = target.GetEquippedSpell(2)

		RegisterForKey(leftAttack)
		RegisterForKey(rightAttack)
		RegisterForKey(shoutSpell)
		RegisterForKey(activate)
		RegisterForKey(jump)
		RegisterForKey(sneak)
		RegisterForKey(readyWeapon)
		RegisterForKey(sprint)
	
		Debug.SendAnimationEvent(target, "IdleStopInstant")

		;starting animations, some of which enable combat animations
		if(raceName == "Wolf")
			Debug.SendAnimationEvent(target, "idleWolfHowlStart")
		elseif raceName == "Bear" || raceName == "Cave Bear" || raceName == "Snow Bear"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif (raceName == "Sabre Cat" || raceName == "Snowy Sabre Cat")
			Debug.SendAnimationEvent(target, "combatIdle1Start") ;as 2 start before
		elseif (raceName == "Troll" || raceName == "Snow Troll")
			Debug.SendAnimationEvent(target, "idleStartRoar")
		elseif raceName == "Mammoth"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Giant"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Frostbite Spider"
			Debug.SendAnimationEvent(target, "combatStanceStart") ;MLh_SpellRelease_event
		elseif raceName == "Hagraven"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Mudcrab"
			Debug.SendAnimationEvent(target, "pickFeedingIdle")
		elseif raceName == "Flame Atronach"
			Debug.SendAnimationEvent(target, "combatIdleStart") ;idle special 1?
		elseif raceName == "Frost Atronach"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Storm Atronach"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Chaurus"
			Debug.SendAnimationEvent(target, "PickNewTaunt")
		elseif raceName == "Horker"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Spriggan"
			Debug.SendAnimationEvent(target, "recoilStart")
		elseif raceName == "Ice Wraith"
			;Debug.SendAnimationEvent(target, "AmbushVertEnterInstant")
		elseif raceName == "Troll" || raceName == "Snow Troll"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		else
			Debug.SendAnimationEvent(target, "IdleStopInstant")
		endIf
		Utility.Wait(0.1)
		RegisterForSingleUpdate(0.5)
	endIf
EndEvent



Event OnUpdate()
	bool endUpdates = false
	;Debug.Notification("Control taken of " + raceName)
	if (Input.IsKeyPressed(iHotkey))
		Actor playerRef = Game.GetPlayer()

		target.SetPlayerControls(false)
		Game.SetPlayerAIDriven(false)
		target.EnableAI(true)
		Game.SetCameraTarget(playerRef)

		UnregisterForKey(leftAttack)
		UnregisterForKey(rightAttack)
		UnregisterForKey(shoutSpell)
		UnregisterForKey(activate)
		UnregisterForKey(readyWeapon)
		UnregisterForKey(jump)
		UnregisterForKey(sneak)
		UnregisterForKey(sprint)
		target.DispelSpell(proteusControlSpell)
		target.DispelSpell(proteusControlSpell2)

		endUpdates = true
		Game.EnablePlayerControls()
		UnregisterForUpdate()
	else
		if(target.GetAV("Health") <= 0)
			Actor playerRef = Game.GetPlayer()
			target.SetPlayerControls(false)
			Game.SetPlayerAIDriven(false)
			target.EnableAI(true)
			Game.SetCameraTarget(playerRef)

			UnregisterForKey(leftAttack)
			UnregisterForKey(rightAttack)
			UnregisterForKey(shoutSpell)
			UnregisterForKey(activate)
			UnregisterForKey(jump)
			UnregisterForKey(readyWeapon)
			UnregisterForKey(sneak)
			UnregisterForKey(sprint)
			target.DispelSpell(proteusControlSpell)
			target.DispelSpell(proteusControlSpell2)
			endUpdates = true
			Game.EnablePlayerControls()
			UnregisterForUpdate()
		else
			RegisterForSingleUpdate(0.5)
		endIf
	endIf
endEvent



Event OnKeyDown(Int KeyCode)
	;Debug.Notification("On Key Down ran!")
	bool endUpdates = false
	if(Input.IsKeyPressed(leftAttack))
		if(raceName == "Bear" || raceName == "Cave Bear" || raceName == "Snow Bear" || raceName == "Sabre Cat" || raceName == "Snowy Sabre Cat")
			Debug.SendAnimationEvent(target, "attackStart_AttackLeft1")
		elseif raceName == "Wolf"
			Debug.SendAnimationEvent(target, "attackStart_Attack1")
		elseif raceName == "Mammoth"
			Debug.SendAnimationEvent(target, "attackStart_Attack1")
		elseif raceName == "Giant"
			Debug.SendAnimationEvent(target, "attackStart_HandSwipeAttack")
		elseif raceName == "Frostbite Spider"
			Debug.SendAnimationEvent(target, "attackStart_Bite1")
		elseif raceName == "Hagraven"
			Debug.SendAnimationEvent(target, "attackStart_L")
		elseif raceName == "Mudcrab"
			Debug.SendAnimationEvent(target, "attackStart_LeftChop")
		elseif raceName == "Flame Atronach"
			Debug.SendAnimationEvent(target, "Spell_Release")
			crAtronachFlameFirebolt.Cast(target)
		elseif raceName == "Frost Atronach"
			Debug.SendAnimationEvent(target, "attackPowerStart_PowerAttack_L1")
		elseif raceName == "Storm Atronach"
			Debug.SendAnimationEvent(target, "attackPowerStart_ForwardAttack")
		elseif raceName == "Chaurus"
			Debug.SendAnimationEvent(target, "AttackStart_LeftChop")
		elseif raceName == "Horker"
			Debug.SendAnimationEvent(target, "attackStart_AttackLeft1")
		elseif raceName == "Spriggan"
			Debug.SendAnimationEvent(target, "Spell_Concentration_LH")
			crSprigganConcentration.Cast(target)
		elseif raceName == "Ice Wraith"
			Debug.SendAnimationEvent(target, "attackStart_AttackLtoR")
		elseif raceName == "Troll" || raceName == "Snow Troll"
			Debug.SendAnimationEvent(target, "attackStartLeftB")
		else ;default
			;Debug.SendAnimationEvent(target, "AttackStartLeftHand")
			Debug.SendAnimationEvent(target, "attackStart_AttackLeft1")
		endIf

	elseif(Input.IsKeyPressed(rightAttack))
		if(raceName == "Bear" || raceName == "Cave Bear" || raceName == "Snow Bear" || raceName == "Sabre Cat" || raceName == "Snowy Sabre Cat")
			Debug.SendAnimationEvent(target, "attackStart_AttackRight1")
		elseif raceName == "Wolf"
			Debug.SendAnimationEvent(target, "attackStart_Attack2")
		elseif raceName == "Mammoth"
			Debug.SendAnimationEvent(target, "attackStart_Attack2")
		elseif raceName == "Giant"
			Debug.SendAnimationEvent(target, "attackStart_ClubAttack2")
		elseif raceName == "Frostbite Spider"
			Debug.SendAnimationEvent(target, "attackStart_Bite2")
		elseif raceName == "Hagraven"
			Debug.SendAnimationEvent(target, "attackStart_R")
		elseif raceName == "Mudcrab"
			Debug.SendAnimationEvent(target, "attackStart_RightChop")
		elseif raceName == "Flame Atronach"
			Debug.SendAnimationEvent(target, "Spell_Concentration_LH")
			crAtronachFlameFlames.Cast(target)
		elseif raceName == "Frost Atronach"
			Debug.SendAnimationEvent(target, "attackPowerStart_ForwardPowerAttack_R1")
		elseif raceName == "Storm Atronach"
			Debug.SendAnimationEvent(target, "attackStart_Attack_Swipe")
		elseif raceName == "Chaurus"
			Debug.SendAnimationEvent(target, "AttackStart_RightChop")
		elseif raceName == "Horker"
			Debug.SendAnimationEvent(target, "attackStart_AttackLeft2")
		elseif raceName == "Spriggan"
			Debug.SendAnimationEvent(target, "Spell_Concentration_LH")
			crSprigganConcentration.Cast(target)
		elseif raceName == "Ice Wraith"
			Debug.SendAnimationEvent(target, "attackStart_AttackRtoL")
		elseif raceName == "Troll" || raceName == "Snow Troll"
			Debug.SendAnimationEvent(target, "attackStartRightA")
		else ;default
			;Debug.SendAnimationEvent(target, "AttackStartRightHand")
			Debug.SendAnimationEvent(target, "attackStart_AttackRight1")
		endIf



	elseif(Input.IsKeyPressed(readyWeapon))
		;Debug.Notification("activate")
		Debug.SendAnimationEvent(target, "WeapEquip")

		if raceName == "Chaurus"
			Debug.SendAnimationEvent(target, "AttackStartLungeBite")
		elseif raceName == "Horker"
			Debug.SendAnimationEvent(target, "attackStart_ForwardPowerShort")
		elseif raceName == "Spriggan"
			;Debug.SendAnimationEvent(target, "IdleStop")
		elseif raceName == "Ice Wraith"
			Debug.SendAnimationEvent(target, "attackPowerStart_PowerAttack")
		elseif raceName == "Troll"
			Debug.SendAnimationEvent(target, "attackStartPowerComboA")
		elseif raceName == "Wolf"
			Debug.SendAnimationEvent(target, "attackStart_ForwardPower")
		elseif raceName == "Mammoth"
			Debug.SendAnimationEvent(target, "attackStart_ForwardPower")
		elseif raceName == "Giant"
			;Debug.SendAnimationEvent(target, "attackStart_BackAttack")
		elseif raceName == "Sabre Cat" || raceName == "Snowy Sabre Cat"
			Debug.SendAnimationEvent(target, "attackStart_ForwardPower")
		elseif raceName == "Mudcrab"
			Debug.SendAnimationEvent(target, "Spell_FireForget_LH")
		elseif raceName == "Hagraven"
			Debug.SendAnimationEvent(target, "AttackStartLungeBite")
		elseif raceName == "Frostbite Spider"
			Debug.SendAnimationEvent(target, "bashStart")
		elseif raceName == "Bear" || raceName == "Cave Bear" || raceName == "Snow Bear"
			Debug.SendAnimationEvent(target, "attackStart_ForwardPower")
		elseif raceName == "Flame Atronach"
			;Debug.SendAnimationEvent(target, "staggerStart") ;idle special 1?
		elseif raceName == "Frost Atronach"
			;Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Storm Atronach"
			;Debug.SendAnimationEvent(target, "combatIdleStart")
		endIf


	elseif(Input.IsKeyPressed(jump))
		;Debug.Notification("jump")
		if(raceName == "Wolf")
			Debug.SendAnimationEvent(target, "idleWolfHowlStart")
		elseif raceName == "Bear" || raceName == "Cave Bear" || raceName == "Snow Bear"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif (raceName == "Sabre Cat" || raceName == "Snowy Sabre Cat")
			Debug.SendAnimationEvent(target, "combatIdle1Start") ;as 2 start before
		elseif raceName == "Mammoth"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Giant"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Frostbite Spider"
			Debug.SendAnimationEvent(target, "combatStanceStart") ;MLh_SpellRelease_event
		elseif raceName == "Hagraven"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Mudcrab"
			Debug.SendAnimationEvent(target, "pickFeedingIdle")
		elseif raceName == "Flame Atronach"
			Debug.SendAnimationEvent(target, "idleSpecial1")
		elseif raceName == "Frost Atronach"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Storm Atronach"
			Debug.SendAnimationEvent(target, "combatIdleStart")
		elseif raceName == "Chaurus"
			Debug.SendAnimationEvent(target, "PickNewTaunt")
		elseif raceName == "Horker"
			Debug.SendAnimationEvent(target, "aggroWarningStart")
		elseif raceName == "Spriggan"
			Debug.SendAnimationEvent(target, "idleCombatSpecial1")
		elseif raceName == "Ice Wraith"
			;Debug.SendAnimationEvent(target, "AmbushVertEnterInstant")
		elseif raceName == "Troll" || raceName == "Snow Troll"
			;Debug.SendAnimationEvent(target, "idleStartFlail")
		Else ;default
			Debug.SendAnimationEvent(target, "JumpStandingStart")
			target.TranslateTo(target.GetPositionX(),target.GetPositionY(), target.GetPositionZ() + 55, target.GetAngleX(), target.GetAngleY(), target.GetAngleZ(), 1000)
			Utility.Wait(0.5)
			Debug.SendAnimationEvent(target, "JumpLand")
		endIf
		
	elseif(Input.IsKeyPressed(sneak))
		if(sneakingToggle == 1)
			Debug.SendAnimationEvent(target, "SneakStop")
			sneakingToggle = 0
		Else
			Debug.SendAnimationEvent(target, "SneakStart")
			sneakingToggle = 1
		endIf
	elseif(Input.IsKeyPressed(readyWeapon))
		Debug.SendAnimationEvent(target, "unequip")
	elseif(Input.IsKeyPressed(sprint))
		Debug.SendAnimationEvent(target, "sprintStart")
	endIf
endEvent


Event OnKeyUp(Int KeyCode, Float HoldTime)
	if(Input.IsKeyPressed(sprint) == false)
		Debug.SendAnimationEvent(target, "sprintStop")
	endIf
endEvent



Event OnEffectFinish(Actor akTarget, Actor akCaster)
	Actor playerRef = Game.GetPlayer()
	Game.EnablePlayerControls()
	target.SetPlayerControls(false)
	Game.SetPlayerAIDriven(false)
	target.EnableAI(true)
	Game.SetCameraTarget(playerRef)
	UnregisterForKey(leftAttack)
	UnregisterForKey(rightAttack)
	UnregisterForKey(shoutSpell)
	UnregisterForKey(activate)
	UnregisterForKey(readyWeapon)
	UnregisterForKey(jump)
	UnregisterForKey(sneak)
	UnregisterForKey(sprint)
	target.DispelSpell(proteusControlSpell)
	target.DispelSpell(proteusControlSpell2)
	UnregisterForUpdate()
  endEvent