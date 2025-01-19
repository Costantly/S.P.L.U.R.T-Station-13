/datum/quirk/masked_mook
	name = "Bane Syndrome"
	desc = "For some reason you don't feel... right without wearing some kind of gas mask."
	gain_text = span_danger("You start feeling unwell without any gas mask on.")
	lose_text = span_notice("You no longer have a need to wear some gas mask.")
	value = 0
	mood_quirk = TRUE
	medical_record_text = "Patient feels more secure when wearing a gas mask."
	processing_quirk = TRUE

/datum/quirk/masked_mook/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/gasmask = H.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(gasmask))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_MASKED_MOOK, /datum/mood_event/masked_mook_incomplete)

/datum/quirk/masked_mook/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/cosmetic/gasmask = new(get_turf(quirk_holder)) // Uses a custom gas mask
	H.equip_to_slot_if_possible(gasmask, ITEM_SLOT_MASK) // If character have a loadout mask, the custom one will not overwrite it but instead will be dropped on floor
	H.regenerate_icons()
