/datum/interaction/lewd/earfuck
	description = "Fuck their ear."
	interaction_sound = null
	required_from_user_exposed = INTERACTION_REQUIRE_PENIS
	required_from_target_exposed = INTERACTION_REQUIRE_EARS
	interaction_flags = INTERACTION_FLAG_ADJACENT | INTERACTION_FLAG_OOC_CONSENT | INTERACTION_FLAG_EXTREME_CONTENT
	write_log_user = "earfucked"
	write_log_target = "had their ear fucked by"

/datum/interaction/lewd/earfuck/earsocketfuck
	description = "Fuck their earsocket."
	required_from_target_exposed = INTERACTION_REQUIRE_EARSOCKETS
	write_log_user = "earsocket fucked"
	write_log_target = "had their earsocket fucked by"

/datum/interaction/lewd/earfuck/display_interaction(mob/living/user, mob/living/partner)
	var/message
	var/u_His = user.p_their()
	var/genital_name = user.get_penetrating_genital_name()

	if(user.is_fucking(partner, CUM_TARGET_EARS))
		message = "[pick(
			"pounds into \the <b>[partner]</b>'s [partner.has_ears() ? "ear":"earsocker"].",
			"shoves [u_His] [genital_name] deep into \the <b>[partner]</b>'s skull",
			"thrusts in and out of \the <b>[partner]</b>'s [partner.has_ears() ? "ear":"eyesocket"].",
			"goes balls deep into \the <b>[partner]</b>'s cranium over and over again.")]"
		var/client/cli = partner.client
		var/mob/living/carbon/C = partner
		if(cli && istype(C))
			if(cli.prefs.extremeharm != "No")
				if(prob(15))
					C.bleed(2)
				if(prob(25))
					C.adjustOrganLoss(ORGAN_SLOT_EARS, rand(3,7))
					C.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
	else
		message = "forcefully slides [u_His] [genital_name] inside \the <b>[partner]</b>'s [partner.has_ears() ? "ear":"earsocket"]."
		user.set_is_fucking(partner, CUM_TARGET_EARS, user.getorganslot(ORGAN_SLOT_PENIS))

	playlewdinteractionsound(get_turf(user), pick('modular_sand/sound/interactions/champ1.ogg',
												'modular_sand/sound/interactions/champ2.ogg'), 50, 1, -1)
	user.visible_message(message = span_lewd("<b>\The [user]</b> [message]"), ignored_mobs = user.get_unconsenting(interaction_flags))
	if(user.can_penetrating_genital_cum())
		user.handle_post_sex(NORMAL_LUST, CUM_TARGET_EARS, partner, ORGAN_SLOT_PENIS) //SPLURT edit
	partner.handle_post_sex(LOW_LUST, null, user)
