/datum/quirk/pharmacokinesis //Supposed to prevent unwanted organ additions. But i don't think it's really working rn
	name = "Acute Hepatic Pharmacokinesis" //copypasting dumbo
	desc = "You have a genetic disorder that causes Incubus Draft and Succubus Milk to be absorbed by your liver instead."
	value = 0
	mob_trait = TRAIT_PHARMA
	lose_text = span_notice("Your liver feels... different, somehow.")
	var/active = FALSE
	var/power = 0
	var/cachedmoveCalc = 1
