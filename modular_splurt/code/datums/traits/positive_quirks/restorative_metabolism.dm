/datum/quirk/restorative_metabolism
	name = "Restorative Metabolism"
	desc = "Your body possesses a differentiated reconstutitive ability, allowing you to slowly recover from injuries. Note, however, that critical injuries, wounds or genetic damage will still require medical attention."
	value = 3
	mob_trait = TRAIT_RESTORATIVE_METABOLISM
	gain_text = span_notice("You feel a surge of reconstutitive vitality coursing through your body...")
	lose_text = span_notice("You sense your enhanced reconstutitive ability fading away...")
	processing_quirk = TRUE

/datum/quirk/restorative_metabolism/on_process()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder

	// The only_organic flag allows robotic biotypes to not be excluded.
	H.adjustBruteLoss(-0.5, only_organic = FALSE) //The healing factor will only regenerate fully if not burnt beyond a specific threshold.
	H.adjustFireLoss(-0.25,  only_organic = FALSE)
	if(H.getBruteLoss() > 0 && H.getFireLoss() <= 50 || H.getFireLoss() > 0 && H.getFireLoss() <= 50)
		H.adjustBruteLoss(-0.5, forced = TRUE, only_organic = FALSE)
		H.adjustFireLoss(-0.25, forced = TRUE, only_organic = FALSE)
	/* Doesn't heal robotic toxin damage (only_organic = FALSE not needed for tox),
	another adjustToxLoss check with toxins_type = TOX_SYSCORRUPT,
	(or just adding TOX_OMNI to the already existing one) could be added to heal robotic corruption,
	but would make robotic species unbalanced.
	*/
	else if (H.getToxLoss() <= 90)
		H.adjustToxLoss(-0.3, forced = TRUE)
