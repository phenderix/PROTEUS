Scriptname ProteusSpawnerScript extends activemagiceffect  

Import ProteusDLLUtils
Import PO3_SKSEFunctions
Import PhenderixToolResourceScript

;Addded in v.3.7.0
ActorBase property banditArcherFemale auto
ActorBase property banditArcherMale auto
ActorBase property banditBerserkerFemale auto
ActorBase property banditBerserkerMale auto
ActorBase property banditBossFemale auto
ActorBase property banditBossMale auto
ActorBase property banditMageFemale auto
ActorBase property banditMageMale auto

;Added in v.3.1.0
ActorBase property ashguardian auto
ActorBase property ashhopper auto
ActorBase property atronachflame auto
ActorBase property atronachfrost auto
ActorBase property atronachstorm auto
ActorBase property bearsnow auto
ActorBase property bristleback auto
ActorBase property chaurus auto
ActorBase property chaurushunter auto
ActorBase property chicken auto
ActorBase property corruptedshade auto
ActorBase property cow auto
ActorBase property deathhound auto
ActorBase property deer auto
ActorBase property dog auto
ActorBase property doghusky auto
ActorBase property dragon auto
ActorBase property dragonserpentine auto
ActorBase property dragonskeletal auto
ActorBase property dragonpriest auto
ActorBase property draugrarcher auto
ActorBase property dremoraarcher auto
ActorBase property dremorawarrior auto
ActorBase property dwarvenballista auto
ActorBase property elk auto
ActorBase property falmerarcher auto
ActorBase property falmerwarrior auto
ActorBase property fox auto
ActorBase property foxsnow auto
ActorBase property goat auto
ActorBase property icewraith auto
ActorBase property lurker auto
ActorBase property mudcrab auto
ActorBase property netch auto
ActorBase property rabbit auto
ActorBase property sabrecatsnow auto
ActorBase property sabrecatvale auto
ActorBase property seeker auto
ActorBase property skeletonarcher auto
ActorBase property sprigganmatron auto
ActorBase property sprigganburnt auto
ActorBase property werebear auto
ActorBase property werewolf auto
ActorBase property wispmother auto
ActorBase property wolfice auto



;Added pre-v.3.1.0
ActorBase property bear auto
ActorBase property draugrwarrior auto
ActorBase property gargoyle auto
ActorBase property horker auto
ActorBase property sabrecat auto
ActorBase property skeletonwarrior auto
ActorBase property spriggan auto
ActorBase property troll auto
ActorBase property wolf auto
Actorbase property hagraven auto
Actorbase property giant auto
Actorbase property giantFrost auto
Actorbase property mammoth auto
Actorbase property trollfrost auto
Actorbase property spiderFrostbite auto
Actorbase property slaughterfish auto
Actorbase property dwarvenSphere auto
Actorbase property dwarvenCenturion auto
Actorbase property dwarvenSpider auto

Quest property ZZProteusSkyUIMenu auto
Actor player

function OnEffectStart(Actor akplayer, Actor akCaster)
	player = Game.GetPlayer()
	Proteus_Spawner(0, 1)
	;Proteus_SpawnerMainMenu()
endFunction


;old code, not in use
function Proteus_SpawnerMainMenu()

	String[] stringArray = new String[66]
	stringArray[0] = " Ash Guardian"
	stringArray[1] = " Ash Hopper"
	stringArray[2] = " Atronach (Flame)"
	stringArray[3] = " Atronach (Frost)"
	stringArray[4] = " Atronach (Storm)"
	stringArray[5] = " Bear"
	stringArray[6] = " Bear (Snow)"
	stringArray[7] = " Bristleback"
	stringArray[8] = " Chaurus"
	stringArray[9] = " Chaurus Hunter"
	stringArray[10] = " Chicken"
	stringArray[11] = " Corrupted Shade"
	stringArray[12] = " Cow"
	stringArray[13] = " Death Hound"
	stringArray[14] = " Deer"
	stringArray[15] = " Dog"
	stringArray[16] = " Dog (Husky)"
	stringArray[17] = " Dragon"
	stringArray[18] = " Dragon (Serpentine)"
	stringArray[19] = " Dragon (Skeletal)"
	stringArray[20] = " Dragon Priest"
	stringArray[21] = " Draugr (Archer)"
	stringArray[22] = " Draugr (Warrior)"
	stringArray[23] = " Dremora (Archer)"
	stringArray[24] = " Dremora (Warrior)"
	stringArray[25] = " Dwarven Ballista"
	stringArray[26] = " Dwarven Centurion"
	stringArray[27] = " Dwarven Sphere"
	stringArray[28] = " Dwarven Spider"
	stringArray[29] = " Elk"
	stringArray[30] = " Falmer (Archer)"
	stringArray[31] = " Falmer (Warrior)"
	stringArray[32] = " Fox"
	stringArray[33] = " Fox (Snow)"
	stringArray[34] = " Gargoyle"
	stringArray[35] = " Giant"
	stringArray[36] = " Giant (Frost)"
	stringArray[37] = " Goat"
	stringArray[38] = " Hagraven"
	stringArray[39] = " Horker"
	stringArray[40] = " Ice Wraith"
	stringArray[41] = " Lurker"
	stringArray[42] = " Mammoth"
	stringArray[43] = " Mudcrab"
	stringArray[44] = " Netch"
	stringArray[45] = " Rabbit"
	stringArray[46] = " Sabrecat"
	stringArray[47] = " Sabrecat (Snow)"
	stringArray[48] = " Sabrecat (Vale)"
	stringArray[49] = " Seeker"
	stringArray[50] = " Skeleton (Archer)"
	stringArray[51] = " Skeleton (Warrior)"
	stringArray[52] = " Slaughterfish"
	stringArray[53] = " Spider (Frostbite)"
	stringArray[54] = " Spriggan"
	stringArray[55] = " Spriggan (Burnt)"
	stringArray[56] = " Spriggan (Matron)"
	stringArray[57] = " Troll"
	stringArray[58] = " Troll (Frost)"
	stringArray[59] = " Werebear"
	stringArray[60] = " Werewolf"
	stringArray[61] = " Wispmother"
	stringArray[62] = " Wolf"
	stringArray[63] = " Wolf (Ice)"
	stringArray[64] = " [Bandits Menu]"
	stringArray[65] = " Exit"

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		int n = 66
		int i = 0
		while i < n
			listMenu.AddEntryItem(stringArray[i])
			i += 1
		endwhile
	EndIf
		
	listMenu.OpenMenu()
	int result = listMenu.GetResultInt()
	
	
	if result == 0
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many ash guardians?")
		player.PlaceAtMe(ashguardian, enteredNumber as Int)
	elseif result == 1
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many ash hoppers?")
		player.PlaceAtMe(ashhopper, enteredNumber as Int)
	elseif result == 2
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many atronachs?")
		player.PlaceAtMe(atronachflame, enteredNumber as Int)
	elseif result == 3
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many atronachs?")
		player.PlaceAtMe(atronachfrost, enteredNumber as Int)
	elseif result == 4
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many atronachs?")
		player.PlaceAtMe(atronachstorm, enteredNumber as Int)
	elseif result == 5
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bears?")
		player.PlaceAtMe(bear, enteredNumber as Int)
	elseif result == 6
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bears?")
		player.PlaceAtMe(bearsnow, enteredNumber as Int)
	elseif result == 7
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bristlebacks?")
		player.PlaceAtMe(bristleback, enteredNumber as Int)
	elseif result == 8
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many chaurus?")
		player.PlaceAtMe(chaurus, enteredNumber as Int)
	elseif result == 9
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many chaurus hunters?")
		player.PlaceAtMe(chaurushunter, enteredNumber as Int)
	elseif result == 10
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many chickens?")
		player.PlaceAtMe(chicken, enteredNumber as Int)
	elseif result == 11
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many shades?")
		player.PlaceAtMe(corruptedshade, enteredNumber as Int)
	elseif result == 12
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many cows?")
		player.PlaceAtMe(cow, enteredNumber as Int)
	elseif result == 13
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many hounds?")
		player.PlaceAtMe(deathhound, enteredNumber as Int)
	elseif result == 14
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many deer?")
		player.PlaceAtMe(deer, enteredNumber as Int)
	elseif result == 15
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dogs?")
		player.PlaceAtMe(dog, enteredNumber as Int)
	elseif result == 16
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many huskies?")
		player.PlaceAtMe(doghusky, enteredNumber as Int)
	elseif result == 17
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dragons?")
		player.PlaceAtMe(dragon, enteredNumber as Int)
	elseif result == 18
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dragons?")
		player.PlaceAtMe(dragonserpentine, enteredNumber as Int)
	elseif result == 19
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dragons?")
		player.PlaceAtMe(dragonskeletal, enteredNumber as Int)
	elseif result == 20
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dragon priests?")
		player.PlaceAtMe(dragonpriest, enteredNumber as Int)
	elseif result == 21
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many draugr?")
		player.PlaceAtMe(draugrarcher, enteredNumber as Int)
	elseif result == 22
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many draugr?")
		player.PlaceAtMe(draugrwarrior, enteredNumber as Int)
	elseif result == 23
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dremora?")
		player.PlaceAtMe(dremoraarcher, enteredNumber as Int)
	elseif result == 24
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dremora?")
		player.PlaceAtMe(dremorawarrior, enteredNumber as Int)
	elseif result == 25
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dwarven ballistas?")
		player.PlaceAtMe(dwarvenballista, enteredNumber as Int)
	elseif result == 26
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dwarven centurions?")
		player.PlaceAtMe(dwarvenCenturion, enteredNumber as Int)
	elseif result == 27
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dwarven spheres?")
		player.PlaceAtMe(dwarvenSphere, enteredNumber as Int)
	elseif result == 28
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many dwarven spiders?")
		player.PlaceAtMe(dwarvenSpider, enteredNumber as Int)
	elseif result == 29
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many elk?")
		player.PlaceAtMe(elk, enteredNumber as Int)
	elseif result == 30
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many falmer?")
		player.PlaceAtMe(falmerarcher, enteredNumber as Int)
	elseif result == 31
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many falmer?")
		player.PlaceAtMe(falmerwarrior, enteredNumber as Int)
	elseif result == 32
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many foxes?")
		player.PlaceAtMe(fox, enteredNumber as Int)
	elseif result == 33
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many foxes?")
		player.PlaceAtMe(foxsnow, enteredNumber as Int)
	elseif result == 34
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many gargoyles?")
		player.PlaceAtMe(gargoyle, enteredNumber as Int)
	elseif result == 35
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many giants?")
		player.PlaceAtMe(giant, enteredNumber as Int)
	elseif result == 36
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many frost giants?")
		player.PlaceAtMe(giantFrost, enteredNumber as Int)
	elseif result == 37
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many goats?")
		player.PlaceAtMe(goat, enteredNumber as Int)
	elseif result == 38
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many hagraven?")
		player.PlaceAtMe(hagraven, enteredNumber as Int)
	elseif result == 39
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many horkers?")
		player.PlaceAtMe(horker, enteredNumber as Int)
	elseif result == 40
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many wraiths?")
		player.PlaceAtMe(icewraith, enteredNumber as Int)
	elseif result == 41
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many lurkers?")
		player.PlaceAtMe(lurker, enteredNumber as Int)
	elseif result == 42
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many mammoths?")
		player.PlaceAtMe(mammoth, enteredNumber as Int)
	elseif result == 43
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many mudcrabs?")
		player.PlaceAtMe(mudcrab, enteredNumber as Int)
	elseif result == 44
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many netch?")
		player.PlaceAtMe(netch, enteredNumber as Int)
	elseif result == 45
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many rabbits?")
		player.PlaceAtMe(rabbit, enteredNumber as Int)
	elseif result == 46
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many sabrecats?")
		player.PlaceAtMe(sabrecat, enteredNumber as Int)
	elseif result == 47
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many sabrecats?")
		player.PlaceAtMe(sabrecatsnow, enteredNumber as Int)
	elseif result == 48
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many sabrecats?")
		player.PlaceAtMe(sabrecatvale, enteredNumber as Int)
	elseif result == 49
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many seekers?")
		player.PlaceAtMe(seeker, enteredNumber as Int)
	elseif result == 50
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many skeletons?")
		player.PlaceAtMe(skeletonarcher, enteredNumber as Int)
	elseif result == 51
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many skeletons?")
		player.PlaceAtMe(skeletonwarrior, enteredNumber as Int)
	elseif result == 52
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many slaughterfish?")
		player.PlaceAtMe(slaughterfish, enteredNumber as Int)
	elseif result == 53
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many frostbite spiders?")
		player.PlaceAtMe(spiderFrostbite, enteredNumber as Int)
	elseif result == 54
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many spriggans?")
		player.PlaceAtMe(spriggan, enteredNumber as Int)
	elseif result == 55
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many spriggans?")
		player.PlaceAtMe(sprigganburnt, enteredNumber as Int)
	elseif result == 56
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many spriggans?")
		player.PlaceAtMe(sprigganmatron, enteredNumber as Int)
	elseif result == 57
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many trolls?")
		player.PlaceAtMe(troll, enteredNumber as Int)
	elseif result == 58
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many frost trolls?")
		player.PlaceAtMe(trollfrost, enteredNumber as Int)
	elseif result == 59
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many werebears?")
		player.PlaceAtMe(werebear, enteredNumber as Int)
	elseif result == 60
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many werewolves?")
		player.PlaceAtMe(werewolf, enteredNumber as Int)
	elseif result == 61
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many wispmothers?")
		player.PlaceAtMe(wispmother, enteredNumber as Int)
	elseif result == 62
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many wolves?")
		player.PlaceAtMe(wolf, enteredNumber as Int)
	elseif result == 63
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many wolves?")
		player.PlaceAtMe(wolfice, enteredNumber as Int)
	elseif result == 64
		BanditsMenu()
	endIf
	
	if result >= 0 && result <= 63
		Proteus_SpawnerMainMenu()
	endIf
endFunction

;old code, not in use
Function BanditsMenu()
	String[] stringArray = new String[9]
	stringArray[0] = " Archer Female"
	stringArray[1] = " Archer Male"
	stringArray[2] = " Berserker Female"
	stringArray[3] = " Berserker Male"
	stringArray[4] = " Boss Female"
	stringArray[5] = " Boss Male"
	stringArray[6] = " Mage Female"
	stringArray[7] = " Mage Male"
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
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit archers?")
		player.PlaceAtMe(banditArcherFemale, enteredNumber as Int)
	elseif result == 1
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit archers?")
		player.PlaceAtMe(banditArcherMale, enteredNumber as Int)
	elseif result == 2
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit berserkers?")
		player.PlaceAtMe(banditBerserkerFemale, enteredNumber as Int)
	elseif result == 3
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit berserkers?")
		player.PlaceAtMe(banditBerserkerMale, enteredNumber as Int)
	elseif result == 4
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit bosses?")
		player.PlaceAtMe(banditBossFemale, enteredNumber as Int)
	elseif result == 5
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit bosses?")
		player.PlaceAtMe(banditBossMale, enteredNumber as Int)
	elseif result == 6
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit mages?")
		player.PlaceAtMe(banditMageFemale, enteredNumber as Int)
	elseif result == 7
		String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many bandit mages?")
		player.PlaceAtMe(banditMageMale, enteredNumber as Int)
	endIf

	if result >= 0 && result <= 7
		BanditsMenu()
	endIf
endFunction


Function Proteus_Spawner(int startingPoint, int currentPage) ;option 0 = cheat, 1 = reset
    Debug.Notification("Spawner menu loading...may take a few seconds!")
    Form[] allGameForms = GetAllForms(43) ;get all NPCs in game and from mods

    int numPages = (allGameForms.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search]")
        i+=1
        while startingPoint <= allGameForms.Length && i < 128
			String name = GetFormEditorID(allGameForms[startingPoint])
			if(name == "")
				name = allGameForms[startingPoint].GetName()
			endif
			if(name == "")
				name = "(Missing Name)"
			endif
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            Form[] foundItems = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 43)
            Proteus_SpawnerSearch(foundItems, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf

    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_Spawner(startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedForm = allGameForms[startingPointInitial + result - 2] as Form
			String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many " + selectedForm.GetName() + "?")
			player.PlaceAtMe(selectedForm, enteredNumber as Int)
            Proteus_Spawner(startingPointInitial, currentPage)
        Else
            Form selectedForm = allGameForms[result - 2] as Form
			String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many " + selectedForm.GetName() + "?")
			player.PlaceAtMe(selectedForm, enteredNumber as Int)
            Proteus_Spawner(startingPointInitial, currentPage)
        endIf
    endIf
EndFunction

Function Proteus_SpawnerSearch(Form[] foundItems, int startingPoint, int currentPage) ;option 0 = cheat, 1 = reset
    Debug.Notification("Form menu loading...may take a few seconds!")
    Form[] allGameForms = foundItems ;get all Forms in game and from mods

    int numPages = (allGameForms.Length / 127) as Int
    int startingPointInitial = startingPoint

    UIListMenu listMenuBase = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    if listMenuBase 
        int i = 0
        listMenuBase.AddEntryItem("[Exit Menu]")
        i+=1
        listMenuBase.AddEntryItem("[Search]")
        i+=1
        while startingPoint <= allGameForms.Length && i < 128
			String name = GetFormEditorID(allGameForms[startingPoint])
			if(name == "")
				name = allGameForms[startingPoint].GetName()
			endif
			if(name == "")
				name = "(Missing Name)"
			endif
            listMenuBase.AddEntryItem(name)
            i += 1
            startingPoint += 1
            if(i == 127)
                listMenuBase.AddEntryItem("[Continue to Page " + Proteus_Round(currentPage + 1, 0) as String + " of " + Proteus_Round(numPages, 0) as String + "]")
            endIf
        endwhile
    EndIf
    listMenuBase.OpenMenu()
    int result = listMenuBase.GetResultInt()
    if result == 1 ;search option
        String searchTerm = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Search for:")
        Utility.Wait(0.1)
        Int lengthSearchTerm = StringUtil.GetLength(searchTerm)
        if (lengthSearchTerm > 0)   
            Form[] foundItems2 = ProteusDLLUtils.ProteusGetItemEditorIdBySearch(searchTerm, 43)
            Proteus_SpawnerSearch(foundItems2, 0, 1)
        else
            Debug.Notification("Invalid length search term.")
        endIf
    elseif result == 127 ;next page option
        currentPage += 1
        Proteus_SpawnerSearch(foundItems, startingPoint, currentPage)
    elseif(result > 0 && result != 127)
        if(startingPoint > 127)
            Form selectedForm = allGameForms[startingPointInitial + result - 2] as Form
			String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many " + selectedForm.GetName() + "?")
			player.PlaceAtMe(selectedForm, enteredNumber as Int)
            Proteus_SpawnerSearch(foundItems, startingPointInitial, currentPage)
        Else
            Form selectedForm = foundItems[result - 2] as Form
			String enteredNumber = ((ZZProteusSkyUIMenu as Form) as UILIB_1).ShowTextInput("Spawn how many " + selectedForm.GetName() + "?")
			player.PlaceAtMe(selectedForm, enteredNumber as Int)
            Proteus_SpawnerSearch(foundItems, startingPointInitial, currentPage)
        endIf
    endIf
EndFunction

