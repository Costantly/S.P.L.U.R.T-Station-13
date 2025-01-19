/datum/quirk/jiggly_ass
	name = "Buns of Thunder"
	desc = "That pants-stretching, seat-creaking, undie-devouring butt of yours is as satisfying as it is difficult to keep balanced when smacked!"
	value = 0
	mob_trait = TRAIT_JIGGLY_ASS
	gain_text = span_notice("Your butt feels extremely smackable.")
	lose_text = span_notice("Your butt feels normally smackable again.")

/datum/quirk/jiggly_ass/add()
	// Add examine text
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine_holder))

/datum/quirk/jiggly_ass/remove()
	// Remove examine text
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

// Quirk examine text
/datum/quirk/jiggly_ass/proc/on_examine_holder(atom/examine_target, mob/living/carbon/human/examiner, list/examine_list)
	examine_list += span_lewd("[quirk_holder.p_their(TRUE)] butt could use a firm smack.")
