/datum/interaction/lewd/eyefuck
	description = "Fuck their eye."
	interaction_sound = null
	required_from_user_exposed = INTERACTION_REQUIRE_PENIS
	required_from_target_exposed = INTERACTION_REQUIRE_EYES
	interaction_flags = INTERACTION_FLAG_ADJACENT | INTERACTION_FLAG_OOC_CONSENT | INTERACTION_FLAG_EXTREME_CONTENT
	write_log_user = "eyefucked"
	write_log_target = "had their eye fucked by"

/datum/interaction/lewd/eyefuck/eyesocketfuck
	description = "Fuck their eyesocket."
	required_from_target_exposed = INTERACTION_REQUIRE_EYESOCKETS
	write_log_user = "eyesocketfucked"
	write_log_target = "had their eyesocket fucked by"

/datum/interaction/lewd/eyefuck/display_interaction(mob/living/user, mob/living/partner)
	var/message
	var/u_His = user.p_their()
	var/genital_name = user.get_penetrating_genital_name()

	if(user.is_fucking(partner, CUM_TARGET_EYES))
		message = "[pick(
			"pounds into \the <b>[partner]</b>'s [partner.has_eyes() ? "eye":"eyesocket"].",
			"shoves [u_His] [genital_name] deep into \the <b>[partner]</b>'s skull",
			"thrusts in and out of \the <b>[partner]</b>'s [partner.has_eyes() ? "eye":"eyesocket"].",
			"goes balls deep into \the <b>[partner]</b>'s cranium over and over again.")]"
		var/client/cli = partner.client
		var/mob/living/carbon/C = partner
		if(cli && istype(C))
			if(cli.prefs.extremeharm != "No")
				if(prob(15))
					C.bleed(2)
				if(prob(25))
					C.adjustOrganLoss(ORGAN_SLOT_EYES,rand(3,7))
					C.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
	else
		message = "forcefully slides [u_His] [genital_name] inbetween \the <b>[partner]</b>'s [partner.has_eyes() ? "eyelid":"eyesocket"]."
		user.set_is_fucking(partner, CUM_TARGET_EYES, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/champ1.ogg',
												'modular_sand/sound/interactions/champ2.ogg'), 50, 1, -1)
	user.visible_message(span_lewd("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting(interaction_flags))
	if(user.can_penetrating_genital_cum())
		user.handle_post_sex(NORMAL_LUST, CUM_TARGET_EYES, partner, ORGAN_SLOT_PENIS) //SPLURT edit
	partner.handle_post_sex(LOW_LUST, null, user)
