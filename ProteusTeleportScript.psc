Scriptname ProteusTeleportScript extends ActiveMagicEffect  

ObjectReference property markerA auto

function OnEffectStart(Actor akplayer, Actor akCaster)
	Game.GetPlayer().MoveTo(markerA)
endFunction