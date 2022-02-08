ScriptName ProteusDLLUtils

; @brief Returns if the DLL is loaded and connected
; @return Returns 0 if there is an error.
Int Function IsDLLLoaded() Global Native 

; @brief Returns the current Standing Stone Perk.
; @return Returns 0 if there is an error or if the player doesnt have one.
Perk Function GetCurrentStandingStonePerk(Actor actor) global native

; @brief Returns an array of all perks known by the user.
; @return Returns 0 if there is an error.
Perk[] Function GetAllPerks(Actor actor) global native

; @brief Removes all of the actors perks
; @return Returns 0 if there is an error.
int Function RemoveAllPerks(Actor a_reference) Global Native

; @brief Returns an array of all visible perks.
; @return Returns 0 if there is an error.
Perk[] Function GetAllVisiblePerks(Actor actor) global native

; @brief Removes all of the actors visible perks
; @return Returns 0 if there is an error.
int Function RemoveAllVisiblePerks(Actor a_reference) Global Native

; @brief Returns an array of perks for the skill
; @return Returns 0 if there is an error.
Perk[] Function GetPerksForPerkTree(Actor actor, String skill, bool purchasedPerksOnly) global native

; @brief Returns an array of perks for all perk trees
; @return Returns 0 if there is an error.
Perk[] Function GetAllPerkTreePerks(Actor actor, bool purchasedPerksOnly) global native

; @brief Removes all of the perks for a specific tree
; @return Returns 0 if there is an error.
int Function RemovePerksForTree(Actor a_reference, String skill) Global Native

; @brief Removes all of the skill tree perks
; @return Returns 0 if there is an error.
int Function RemovePerksForAllTrees(Actor a_reference) Global Native

; @brief Returns if a spell is favorited
; @return Returns 0 if there is an error.
bool Function IsFavoritedSpell(Spell spell) global native

; @brief Returns an array of all spells known by the user.
; @return Returns 0 if there is an error.
Spell[] Function GetAllSpells(Actor actor) global native

; @brief Returns an array of all the favorited spells known by the player.
; @return Returns 0 if there is an error.
Spell[] Function GetAllFavoritedSpells() global native

; @brief Remove all of the actors spells.
; @return Returns 0 if there is an error.
int Function RemoveAllSpells(Actor a_reference) Global Native

; @brief Returns an array of all shouts known by the user.
; @return Returns 0 if there is an error.
Shout[] Function GetAllShouts(Actor actor) global native

; @brief Returns an array of all favorited items known by the player.
; @return Returns 0 if there is an error.
Form[] Function GetAllFavoritedItems() global native 

; @brief Returns the amount of items in the form by formType.
; @return Returns 0 if there is an error.
int Function ProteusGetItemCount(String containsText, Int formType) Global Native

; @brief Returns all the items that contain the text (Case Insensitive) by formtype.
; @return Returns 0 if there is an error.
Form[] Function ProteusGetItemBySearch(String containsText, Int formType) Global Native 

; @brief Returns all the items that contain the text by editor id (Case Insensitive) by formtype.
; @return Returns 0 if there is an error.
Form[] Function ProteusGetItemEditorIdBySearch(String containsText, Int formType) Global Native 

; @brief Returns a list of items on the Object that match the parameters
; @return Returns an empty list if there is an error.
Form[] Function ProteusAddAllItemsToArray(ObjectReference akRef, bool abNoEquipped = true, bool abNoFavorited = false, bool abNoQuestItem = false) global native

; @brief Returns all the items from a form type with a cache.
; @return Returns 0 if there is an error.
Form[] Function ProteusGetAllByFormId(Int formType) Global Native 

; @brief Sets the sex onto the target actor. 1 == female. 0 == male Checks if it is already the sex before setting it. Does nothing if its the same sex.
; @return Returns 0 if there is an error.
Int Function SetSex(Actor actor, Int sex) Global Native 

; @brief Sets the level onto the actor
; @return Returns 0 if there is an error.
Int Function SetLevel(Actor actor, Int level) Global Native 

; @brief Shows the racemenu
; @return Returns 0 if there is an error.
Int Function ShowRaceMenu() Global Native 

; @brief Favorites an item / spell / shout in the inventory
; @return Returns 0 if there is an error.
Int Function ProteusMarkItemAsFavorite(Form whichForm) Global Native 

; @brief Unfavorites an item / spell / shout in the inventory
; @return Returns 0 if there is an error.
Int Function ProteusUnmarkItemAsFavorite(Form whichForm) Global Native 

; @brief Returns the editor id for the form. Only works on Voices and Quests in SE.
; @return Returns Empty String if there is an error.
String Function ProteusGetFormEditorID(Form akForm) global native

; @brief Replaces a keyword on a form with another keyword. Both keywords are required.
; @return Returns 0 if there is an error.
Int Function ProteusReplaceKeywordOnForm(Form akForm, Keyword akKeywordAdd, Keyword akKeywordRemove) global native

; @brief Adds a new keyword to a form
; @return Returns 0 if there is an error.
Int Function ProteusAddKeywordToForm(Form akForm, Keyword akKeyword) global native

; @brief Removes a keyword from a form
; @return Returns 0 if there is an error.
bool Function ProteusRemoveKeywordOnForm(Form akForm, Keyword akKeyword) global native

; @brief Sets hair color on actor. Changes may persist throughout gaming session, even when reloading previous saves.
; @return Returns 0 if there is an error.
Int Function ProteusSetHairColor(Actor akActor, ColorForm akColor) global native

; @brief Returns true or false if the form is part of a mod
; @return Returns 0 if there is an error.
bool Function ProteusIsFormInMod(Form akForm, String asModName) global native