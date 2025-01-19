//well-trained moved to neutral to stop the awkward situation of a dom snapping and the 30 trait powergamers fall to the floor.
/datum/quirk/well_trained
	name = "Well-Trained"
	desc = "You absolutely love being dominated. The thought of someone stronger than you is enough to make you act up."
	value = 0
	gain_text = span_notice("You feel like being someone's pet...")
	lose_text = span_notice("You no longer feel like being a pet...")
	processing_quirk = TRUE
	var/notice_delay = 0
	var/mob/living/carbon/human/last_dom

/datum/quirk/well_trained/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine_holder))

/datum/quirk/well_trained/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

/datum/quirk/well_trained/proc/on_examine_holder(atom/source, mob/living/user, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(user))
		return
	if(!user.has_quirk(/datum/quirk/dominant_aura))
		return
	examine_list += span_lewd("You sense a strong aura of submission from [quirk_holder.p_them()].")

/datum/quirk/well_trained/on_process()
	. = ..()
	if(!quirk_holder)
		return

	var/good_x = "pet"
	switch(quirk_holder.gender)
		if(MALE)
			good_x = "boy"
		if(FEMALE)
			good_x = "girl"

	//Check for possible doms with the dominant_aura quirk, and for the closest one if there is
	. = FALSE
	var/list/mob/living/carbon/human/doms = range(DOMINANT_DETECT_RANGE, quirk_holder)
	var/closest_distance
	for(var/mob/living/carbon/human/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura))
			if(!closest_distance || get_dist(quirk_holder, dom) <= closest_distance)
				. = dom
				closest_distance = get_dist(quirk_holder, dom)

	//Return if no dom is found
	if(!.)
		last_dom = null
		return

	//Handle the mood
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(istype(mood.mood_events[QMOOD_WELL_TRAINED], /datum/mood_event/dominant/good_boy))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_WELL_TRAINED, /datum/mood_event/dominant/good_boy)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, QMOOD_WELL_TRAINED, /datum/mood_event/dominant/need)

	//Don't do anything if a previous dom was found
	if(last_dom)
		notice_delay = world.time + 15 SECONDS
		return

	last_dom = .

	if(notice_delay > world.time)
		return

	//Let them know they're near
	var/list/notices = list(
		"You feel someone's presence making you more submissive...",
		"Thoughts of being commanded flood you with lust...",
		"You really want to be called a good [good_x]...",
		"Someone's presence is making you all flustered...",
		"You start getting sweaty and excited..."
	)

	to_chat(quirk_holder, span_lewd(pick(notices)))
	notice_delay = world.time + 15 SECONDS
