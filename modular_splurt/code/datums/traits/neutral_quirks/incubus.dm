//succubus and incubus below
/datum/quirk/incubus
	name = "Incubus"
	desc = "Your seductor-like metabolism can only be sated by milk. (And semen, if you're a Succubus as well.)"
	value = 0
	mob_trait = TRAIT_INCUBUS
	processing_quirk = TRUE

/datum/quirk/incubus/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/incubus/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/incubus/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_nutrition(-0.09)//increases their nutrition loss rate to encourage them to gain a partner they can essentially leech off of
