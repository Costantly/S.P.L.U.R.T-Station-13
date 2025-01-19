/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire."
	mob_trait = TRAIT_DISTANT
	value = 0
	gain_text = span_notice("Others' touches begin to make your blood boil...")
	lose_text = span_notice("Having your head pet doesn't sound so bad right about now...")
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_hater/add()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = new
	act_toggle.Grant(quirk_mob)

/datum/quirk/headpat_hater/remove()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = locate() in quirk_mob.actions
	if(act_toggle)
		act_toggle.Remove(quirk_mob)

/datum/action/cooldown/toggle_distant
	name = "Toggle Distant"
	desc = "Allows you to let your headpat-guard down, or put it back up."
	icon_icon = 'modular_splurt/icons/mob/actions/lewd_actions/lewd_icons.dmi'
	button_icon_state = "pain_max"

/datum/action/cooldown/toggle_distant/Activate()
	var/mob/living/carbon/human/action_owner = owner

	if(HAS_TRAIT(action_owner, TRAIT_DISTANT))
		REMOVE_TRAIT(action_owner, TRAIT_DISTANT, ROUNDSTART_TRAIT)
		to_chat(action_owner, span_notice("You let your headpat-guard down!"))
	else
		ADD_TRAIT(action_owner, TRAIT_DISTANT, ROUNDSTART_TRAIT)
		to_chat(action_owner, span_warning("You let your headpat-guard up!"))
