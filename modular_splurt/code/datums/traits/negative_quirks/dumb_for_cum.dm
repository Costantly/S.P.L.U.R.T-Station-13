/datum/quirk/dumb4cum
	name = "Dumb For Cum"
	desc = "For one reason or another, you're totally obsessed with seminal fluids. The heat of it, the smell... the taste... It's quite simply euphoric."
	value = 0
	mob_trait = TRAIT_DUMB_CUM
	gain_text = span_notice("You feel an insatiable craving for seminal fluids.")
	lose_text = span_notice("Cum didn't even taste that good, anyways.")
	medical_record_text = "Patient seems to have an unhealthy psychological obsession with seminal fluids."
	mood_quirk = TRUE
	var/timer
	var/timer_trigger = 15 MINUTES

/datum/quirk/dumb4cum/add()
	// Set timer
	timer = addtimer(CALLBACK(src, PROC_REF(crave)), timer_trigger, TIMER_STOPPABLE)

/datum/quirk/dumb4cum/remove()
	// Remove status trait
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Remove penalty traits
	REMOVE_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Remove mood event
	SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, QMOOD_DUMB_CUM)

	// Remove timer
	deltimer(timer)

/datum/quirk/dumb4cum/proc/crave()
	// Check if conscious
	if(quirk_holder.stat == CONSCIOUS)
		// Display emote
		quirk_holder.emote("sigh")

		// Define list of phrases
		var/list/trigger_phrases = list(
										"Your stomach rumbles a bit and cum comes to your mind.",\
										"Urgh, you should really get some cum...",\
										"Some jizz wouldn't be so bad right now!",\
										"You're starting to long for some more cum..."
									)
		// Alert user in chat
		to_chat(quirk_holder, span_love("[pick(trigger_phrases)]"))

	// Add active status trait
	ADD_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Add illiterate, dumb, and pacifist
	ADD_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	ADD_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	ADD_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Add negative mood effect
	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_DUMB_CUM, /datum/mood_event/cum_craving)

/datum/quirk/dumb4cum/proc/uncrave()
	// Remove active status trait
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB_CUM_CRAVE, DUMB_CUM_TRAIT)

	// Remove penalty traits
	REMOVE_TRAIT(quirk_holder, TRAIT_ILLITERATE, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_DUMB, DUMB_CUM_TRAIT)
	REMOVE_TRAIT(quirk_holder, TRAIT_PACIFISM, DUMB_CUM_TRAIT)

	// Add positive mood event
	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_DUMB_CUM, /datum/mood_event/cum_stuffed)

	// Remove timer
	deltimer(timer)
	timer = null

	// Add new timer
	timer = addtimer(CALLBACK(src, PROC_REF(crave)), timer_trigger, TIMER_STOPPABLE)

/datum/mood_event/cum_craving
	description = span_warning("I... NEED... CUM...\n")
	mood_change = -20

/datum/mood_event/cum_stuffed
	description = span_nicegreen("The cum feels so good inside me!\n")
	mood_change = 8
	timeout = 5 MINUTES
