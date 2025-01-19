/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a bigger mood boost and cause aroused reactions."
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	gain_text = span_notice("You crave headpats immensely!")
	lose_text = span_notice("Your headpats addiction wanes.")
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/headpat_slut/add()
	. = ..()
	quirk_holder.AddElement(/datum/element/wuv/headpat, null, null, /datum/mood_event/pet_animal)

/datum/quirk/headpat_slut/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/wuv/headpat)
