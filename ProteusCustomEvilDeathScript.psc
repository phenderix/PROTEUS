Scriptname ProteusCustomEvilDeathScript extends Actor  

;-- Properties --------------------------------------
explosion property exp1 auto
objectreference property voidMarker auto

;-- Variables ---------------------------------------
Float posX
Float posY
Float posZ


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if self.GetAV("Health") <= 0
		;posX = self.GetPositionX()
		;posY = self.GetPositionY()
		;posZ = self.GetPositionZ() + 100 as Float
		;objectreference placedObject = self.placeatme(objectVariable as form, 1, false, false)
		;placedObject.SetPosition(posX, posY, posZ)
		self.placeatme(exp1, 1, false, false)
		self.MoveTo(voidMarker)
	endIf
endEvent