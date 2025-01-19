// Small issue with this. If the quirk holder has NO_HUNGER or NO_THIRST, this trait can still be taken and they will still get the benefits of it.
// It's unlikely that someone will be both, especially at round start, but vampirism makes me wary of having these separate.
/datum/quirk/hungry
	name = "Hungry"
	desc = "You find yourself unusually hungry. Gotta eat twice as much as normal."
	value = -1
	gain_text = span_danger("You're starting to feel hungrier a lot faster.")
	lose_text = span_notice("Your elevated craving for food begins dying down.")
	medical_record_text = "Patient reports eating twice as many meals per day than usual for their species."

/datum/quirk/hungry/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/physiology/P = H.physiology
	P.hunger_mod *= 2

/datum/quirk/hungry/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/physiology/P = H.physiology
		P.hunger_mod /= 2
