//succubus and incubus below
/datum/quirk/succubus
	name = "Succubus"
	desc = "Your seductress-like metabolism can only be sated by semen. (And milk, if you're an Incubus as well.)"
	value = 0
	mob_trait = TRAIT_SUCCUBUS
	processing_quirk = TRUE

/datum/quirk/succubus/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/succubus/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	REMOVE_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)

/datum/quirk/succubus/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjust_nutrition(-0.09)//increases their nutrition loss rate to encourage them to gain a partner they can essentially leech off of
