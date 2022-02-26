Scriptname ProteusSpawnerScript extends activemagiceffect  

Import ProteusDLLUtils
Import PhenderixToolResourceScript
Import ProteusCheatFunctions

Quest property ZZProteusSkyUIMenu auto

function OnEffectStart(Actor akplayer, Actor akCaster)
	Proteus_Spawner(ZZProteusSkyUIMenu, akplayer, 0, 1)
EndFunction
