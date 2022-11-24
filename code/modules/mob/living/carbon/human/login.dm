/mob/living/carbon/human/LateLogin()
	..()
	update_hud()
	if(species)
		species.handle_login_special(src)
	if(client)
		overlays -= image('icons/effects/effects.dmi', icon_state = "zzz_glow")
	var/datum/antagonist/antag = player_is_antag(mind, FALSE)
	if(antag)
		antag.handle_latelogin(src)
