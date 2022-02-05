ScriptName ProteusDLLUtils

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

; @brief Returns all the items from a form type with a cache.
; @return Returns 0 if there is an error.
Form[] Function ProteusGetAllByFormId(Int formType) Global Native 