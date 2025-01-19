/datum/quirk/hallowed
	name = "Hallowed"
	desc = "You have been blessed by a higher power or are otherwise imbued with holy energy in some way. Your divine presence drives away magic and the unholy! Holy water will restore your health."
	value = 1 // Maybe up the cost if more is added later.
	mob_trait = TRAIT_HALLOWED
	medical_record_text = "Patient contains an unidentified hallowed material concentrated in their blood. Please consult a chaplain."
	gain_text = span_notice("You feel holy energy starting to flow through your body.")
	lose_text = span_notice("You feel your holy energy fading away...")

/datum/quirk/hallowed/add()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Give the holy trait.
	ADD_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Give the antimagic trait.
	ADD_TRAIT(quirk_mob, TRAIT_ANTIMAGIC, "quirk_hallowed")

	// Makes the user holy.
	quirk_mob.mind.isholy = TRUE

	// Add examine text.
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine_holder))

/datum/quirk/hallowed/remove()
	// Define quirk mob.
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove the holy trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_HOLY, "quirk_hallowed")

	// Remove the antimagic trait.
	REMOVE_TRAIT(quirk_mob, TRAIT_ANTIMAGIC, "quirk_hallowed")

	// Makes the user not holy.
	quirk_mob.mind.isholy = FALSE

	// Remove examine text
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

// Quirk examine text.
/datum/quirk/hallowed/proc/on_examine_holder(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	examine_list += "[quirk_holder.p_they(TRUE)] radiates divine power..."
