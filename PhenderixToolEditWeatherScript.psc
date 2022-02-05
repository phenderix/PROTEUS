
scriptName PhenderixToolEditWeatherScript extends activemagiceffect

;-- Properties --------------------------------------
weather property eclipse auto
weather property fogWeather auto
weather property clearWeather auto
weather property ash auto
weather property apocrypha auto
weather property snowWeather auto
weather property FXSkyrimStormBlowingGrass auto
weather property rainWeather auto
weather property SoulCairnAurora auto
weather property cloudyWeather auto
weather property SkuldafnCloudy auto
weather property BlackreachWeather auto
weather property HelgenAttackWeather auto
weather property KarthspireRedoubtFog auto
weather property SkyrimOvercastRain auto
weather property SovngardeClear auto
weather property SovngardeDark auto
weather property SovngardeFog auto
weather property SkyrimClear_A auto  ;clearVariant1 
weather property SkyrimClearMA auto  ;clearVariant2 
weather property SkyrimClearVT auto  ;clearVariant3 
weather property SkyrimDA02Weather auto  ;dark blue skies 
weather property SkyrimFogRE auto  

;-- Functions ---------------------------------------
function OnEffectStart(Actor akTarget, Actor akCaster)
	MainMenu()
endFunction

function MainMenu()
	string[] stringArray = new String[24]
	stringArray[0] = " Clear"
	stringArray[1] = " Clear Variant 1"
	stringArray[2] = " Clear Variant 2"
	stringArray[3] = " Clear Variant 3"
	stringArray[4] = " Cloudy"
	stringArray[5] = " Cloudy Variant 1"
	stringArray[6] = " Dark Clouds"
	stringArray[7] = " Dark Blue Cloudy"
	stringArray[8] = " Fog"
	stringArray[9] = " Fog Variant 1"
	stringArray[10] = " Fog Variant 2"
	stringArray[11] = " Storm Blowing Grass"
	stringArray[12] = " Storm Rain"
	stringArray[13] = " Storm Rain Overcast"
	stringArray[14] = " Storm Snow"
	stringArray[15] = " Aurora"
	stringArray[16] = " Volcanic Ash"
	stringArray[17] = " Apocrypha"
	stringArray[18] = " Eclipse"
	stringArray[19] = " Blackreach"
	stringArray[20] = " Sovngarde Clear"
	stringArray[21] = " Sovngarde Dark"
	stringArray[22] = " Sovngarde Fog"
	stringArray[23] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 24
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()

	
	if result == 0
		clearWeather.ForceActive(false)
	elseif result == 1
		SkyrimClear_A.ForceActive(false)
	elseif result == 2
		SkyrimClearMA.ForceActive(false)
	elseif result == 3
		SkyrimClearVT.ForceActive(false)
	elseif result == 4
		cloudyWeather.ForceActive(false)
	elseif result == 5
		SkuldafnCloudy.ForceActive(false)
	elseif result == 6
		HelgenAttackWeather.ForceActive(false)
	elseif result == 7
		SkyrimDA02Weather.ForceActive(false)
	elseif result == 8
		fogWeather.ForceActive(false)
	elseif result == 9
		KarthspireRedoubtFog.ForceActive(false)
	elseif result == 10
		SkyrimFogRE.ForceActive(false)
	elseif result == 11
		FXSkyrimStormBlowingGrass.ForceActive(false)
	elseif result == 12
		rainWeather.ForceActive(false)
	elseif result == 13
		SkyrimOvercastRain.ForceActive(false)
	elseif result == 14
		snowWeather.ForceActive(false)
	elseif result == 15
		SoulCairnAurora.ForceActive(false)
	elseif result == 16
		ash.ForceActive(false)
	elseif result == 17
		apocrypha.ForceActive(false)
	elseif result == 18
		eclipse.ForceActive(false)
	elseif result == 19
		BlackreachWeather.ForceActive(false)
	elseif result == 20
		SovngardeClear.ForceActive(false)
	elseif result == 21
		SovngardeDark.ForceActive(false)
	elseif result == 22
		SovngardeFog.ForceActive(false)
	elseif result == 23
	endIf
endFunction

