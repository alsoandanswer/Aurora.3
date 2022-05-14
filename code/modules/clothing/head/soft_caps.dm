/obj/item/clothing/head/softcap
	name = "softcap"
	desc = "It's a softcap in a tasteless color."
	icon = 'icons/obj/clothing/hats/soft_caps.dmi'
	icon_state = "softcap"
	item_state = "softcap"
	item_flags = SHOWFLAVORTEXT
	contained_sprite = TRUE
	var/flipped = FALSE
	siemens_coefficient = 0.9

/obj/item/clothing/head/softcap/dropped()
	icon_state = initial(icon_state)
	item_state = icon_state
	flipped = FALSE
	..()

/obj/item/clothing/head/softcap/verb/ToggleHat()
	set name = "Flip Hat"
	set category = "Object"
	set src in usr

	if(use_check_and_message(usr))
		return 0

	flipped = !flipped
	icon_state = "[initial(icon_state)][flipped ? "_flipped" : ""]"
	item_state = icon_state
	to_chat(usr, "You flip the hat [flipped ? "backwards" : "forwards"].")
	update_clothing_icon()	//so our mob-overlays update

/obj/item/clothing/head/softcap/colorable
	icon_state = "softcap_colorable"
	item_state = "softcap_colorable"

/obj/item/clothing/head/softcap/colorable/random/Initialize()
	. = ..()
	color = get_random_colour(TRUE)

/obj/item/clothing/head/softcap/rainbow
	name = "rainbow cap"
	desc = "It's a peaked cap in a bright rainbow of colors."
	icon_state = "rainbowsoft"
	item_state = "rainbowsoft"

/obj/item/clothing/head/softcap/red // Antag red.
	name = "red softcap"
	desc = "It's a softcap in a menacing crimson red."
	icon_state = "softcap_red"
	item_state = "softcap_red"

/obj/item/clothing/head/softcap/tcfl
	name = "tcfl cap"
	desc = "A rugged softcap in TCFL colours, go Biesel!"
	icon_state = "tcfl"
	item_state = "tcfl"

// Departmental softcaps. By Wowzewow (Wezzy).

/obj/item/clothing/head/softcap/captain
	name = "captain's softcap"
	desc = "It's a peaked cap in a authoritative blue and yellow."
	icon_state = "softcap_captain"
	item_state = "softcap_captain"

/obj/item/clothing/head/softcap/security
	name = "security softcap"
	desc = "It's a peaked cap in a secure blue and grey."
	icon_state = "softcap_sec"
	item_state = "softcap_sec"

/obj/item/clothing/head/softcap/medical
	name = "medical softcap"
	desc = "It's a peaked cap in a sterile white and green."
	icon_state = "softcap_med"
	item_state = "softcap_med"

/obj/item/clothing/head/softcap/science
	name = "science softcap"
	desc = "It's a peaked cap in a analytical white and purple."
	icon_state = "softcap_sci"
	item_state = "softcap_sci"

/obj/item/clothing/head/softcap/engineering
	name = "engineering softcap"
	desc = "It's a peaked cap in a reflective yellow and orange."
	icon_state = "softcap_engi"
	item_state = "softcap_engi"

/obj/item/clothing/head/softcap/atmos
	name = "atmospherics softcap"
	desc = "It's a peaked cap in a refreshing yellow and blue."
	icon_state = "softcap_atmos"
	item_state = "softcap_atmos"

/obj/item/clothing/head/softcap/hydro
	name = "hydroponics softcap"
	desc = "It's a peaked cap in a fresh green and blue."
	icon_state = "softcap_hydro"
	item_state = "softcap_hydro"

/obj/item/clothing/head/softcap/cargo
	name = "cargo softcap"
	desc = "It's a peaked cap in a dusty yellow and black."
	icon_state = "softcap_cargo"
	item_state = "softcap_cargo"

/obj/item/clothing/head/softcap/miner
	name = "mining softcap"
	desc = "It's a peaked cap in a chalky purple and brown."
	icon_state = "softcap_miner"
	item_state = "softcap_miner"

/obj/item/clothing/head/softcap/janitor
	name = "janitor softcap"
	desc = "It's a peaked cap, freshly sanitized and ready for a day of viscera cleanup."
	icon = 'icons/obj/contained_items/department_uniforms/service.dmi'
	contained_sprite = TRUE
	icon_state = "softcap_janitor"
	item_state = "softcap_janitor"

// Corporate.

/obj/item/clothing/head/softcap/iac
	name = "IAC cap"
	desc = "An IAC cap. Standard issue and utilitarian."
	icon_state = "iac"
	item_state = "iac"

/obj/item/clothing/head/softcap/idris
	name = "idris cap"
	desc = "A company-issue Idris cap. Comes with flagrant corporate branding. There's a liability waiver written on the inside, somehow."
	icon_state = "idris"
	item_state = "idris"

/obj/item/clothing/head/softcap/pmc
	name = "PMCG cap"
	desc = "A company-issue PMCG cap. For amoral mercenaries that prefer style over protection."
	icon_state = "pmc"
	item_state = "pmc"

/obj/item/clothing/head/softcap/pmc/alt
	icon_state = "pmcalt"
	item_state = "pmcalt"

/obj/item/clothing/head/softcap/zavod
	name = "zavodskoi cap"
	desc = "A company-issue Zavokdskoi cap with the symbol of the corporation at its front. It seems to be immaculately starched; maybe it's just the material it's made out of."
	icon_state = "zav"
	item_state = "zav"

/obj/item/clothing/head/softcap/zavod/alt
	icon_state = "zavalt"
	item_state = "zavalt"

/obj/item/clothing/head/softcap/zeng
	desc = "A company-issue Zeng-Hu cap. It feels synthetic to the touch."
	icon_state = "zeng"
	item_state = "zeng"

/obj/item/clothing/head/softcap/nt
	desc = "A company-issue NanoTrasen cap. Smells of phoron."
	icon_state = "nt"
	item_state = "nt"
