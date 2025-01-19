/datum/quirk/breathless
	name = "Breathless"
	desc = "Whether due to genetic engineering, technology, or bluespace magic, you no longer require air to function. This also means that administering life-saving manuevers such as CPR would be impossible."
	value = 3
	medical_record_text = "Patient's biology demonstrates no need for breathing."
	gain_text = span_notice("You no longer need to breathe.")
	lose_text = span_notice("You need to breathe again...")
	processing_quirk = TRUE

/datum/quirk/breathless/add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_NOBREATH,ROUNDSTART_TRAIT)

/datum/quirk/breathless/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_NOBREATH, ROUNDSTART_TRAIT)

/datum/quirk/breathless/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.adjustOxyLoss(-3) /* Bandaid-fix for a defibrillator "bug",
	Which causes oxy damage to stack for mobs that don't breathe */
