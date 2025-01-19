/datum/quirk/social_anxiety
	value = -3
	mob_trait = TRAIT_ANXIOUS
	processing_quirk = FALSE //small fixes for big mistakes

/datum/quirk/social_anxiety/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/quirk/social_anxiety/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_MOB_SAY)

/datum/quirk/social_anxiety/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	if(HAS_TRAIT(quirk_holder, TRAIT_FEARLESS))
		return

	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	var/moodmod
	if(mood)
		moodmod = (1+0.02*(50-(max(50, mood.mood_level*(7-mood.sanity_level))))) //low sanity levels are better, they max at 6
	else
		moodmod = (1+0.02*(50-(max(50, 0.1*quirk_holder.nutrition))))
	var/nearby_people = 0
	for(var/mob/living/carbon/human/H in oview(3, quirk_holder))
		if(H.client)
			nearby_people++
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		var/list/message_split = splittext(message, " ")
		var/list/new_message = list()
		var/mob/living/carbon/human/quirker = quirk_holder
		for(var/word in message_split)
			if(prob(max(5,(nearby_people*12.5*moodmod))) && word != message_split[1]) //Minimum 1/20 chance of filler
				new_message += pick("uh,","erm,","um,")
				if(prob(min(5,(0.05*(nearby_people*12.5)*moodmod)))) //Max 1 in 20 chance of cutoff after a succesful filler roll, for 50% odds in a 15 word sentence
					quirker.silent = max(3, quirker.silent)
					to_chat(quirker, span_danger("You feel self-conscious and stop talking. You need a moment to recover!"))
					break
			if(prob(max(5,(nearby_people*12.5*moodmod)))) //Minimum 1/20 chance of stutter
				// Add a short stutter, THEN treat our word
				quirker.stuttering = max(0.25, quirker.stuttering)
				new_message += quirker.treat_message(word)

			else
				new_message += word

		message = jointext(new_message, " ")
	var/mob/living/carbon/human/quirker = quirk_holder
	if(prob(min(50,(0.50*(nearby_people*12.5)*moodmod)))) //Max 50% chance of not talking
		if(dumb_thing)
			to_chat(quirker, span_userdanger("You think of a dumb thing you said a long time ago and scream internally."))
			dumb_thing = FALSE //only once per life
			if(prob(1))
				new/obj/item/reagent_containers/food/snacks/pastatomato(get_turf(quirker)) //now that's what I call spaghetti code
		else
			to_chat(quirk_holder, span_warning("You think that wouldn't add much to the conversation and decide not to say it."))
			if(prob(min(25,(0.25*(nearby_people*12.75)*moodmod)))) //Max 25% chance of silence stacks after succesful not talking roll
				to_chat(quirker, span_danger("You retreat into yourself. You <i>really</i> don't feel up to talking."))
				quirker.silent = max(5, quirker.silent)
		speech_args[SPEECH_MESSAGE] = pick("Uh.","Erm.","Um.")
	else
		speech_args[SPEECH_MESSAGE] = message
