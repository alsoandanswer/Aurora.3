/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		Ushanka
 *		Pumpkin head
 *		Kitty ears
 *
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	item_state_slots = list(
		slot_l_hand_str = "welding",
		slot_r_hand_str = "welding"
		)
	matter = list(DEFAULT_WALL_MATERIAL = 3000, "glass" = 1000)
	var/up = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	flags_inv = (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
	body_parts_covered = HEAD|FACE|EYES
	action_button_name = "Flip Welding Mask"
	siemens_coefficient = 0.75 // what? it's steel.
	w_class = 3
	var/base_state
	flash_protection = FLASH_PROTECTION_MAJOR
	tint = TINT_HEAVY
	sprite_sheets = list(
		"Vox" = 'icons/mob/species/vox/head.dmi'
		)
	drop_sound = 'sound/items/drop/helm.ogg'

/obj/item/clothing/head/welding/attack_self()
	if(!base_state)
		base_state = icon_state
	toggle()


/obj/item/clothing/head/welding/verb/toggle()
	set category = "Object"
	set name = "Adjust welding mask"
	set src in usr

	if(!base_state)
		base_state = icon_state

	if(usr.canmove && !usr.stat && !usr.restrained())
		if(src.up)
			src.up = !src.up
			body_parts_covered |= (EYES|FACE)
			flags_inv |= (HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			flash_protection = initial(flash_protection)
			tint = initial(tint)
			icon_state = base_state
			to_chat(usr, "You flip the [src] down to protect your eyes.")
		else
			src.up = !src.up
			body_parts_covered &= ~(EYES|FACE)
			flash_protection = FLASH_PROTECTION_NONE
			tint = TINT_NONE
			flags_inv &= ~(HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE)
			icon_state = "[base_state]up"
			to_chat(usr, "You push the [src] up out of your face.")
		update_clothing_icon()	//so our mob-overlays
		usr.update_action_buttons()


/*
 * Cakehat
 */
/obj/item/clothing/head/cakehat
	name = "cake-hat"
	desc = "It's tasty looking!"
	icon_state = "cake0"
	item_state = "cake0"
	var/onfire = 0
	body_parts_covered = HEAD

/obj/item/clothing/head/cakehat/process()
	if(!onfire)
		STOP_PROCESSING(SSprocessing, src)
		return

	var/turf/location = src.loc
	if(istype(location, /mob/))
		var/mob/living/carbon/human/M = location
		if(M.l_hand == src || M.r_hand == src || M.head == src)
			location = M.loc

	if (istype(location, /turf))
		location.hotspot_expose(700, 1)

/obj/item/clothing/head/cakehat/attack_self(mob/user as mob)
	src.onfire = !( src.onfire )
	if (src.onfire)
		src.force = 3
		src.damtype = "fire"
		src.icon_state = "cake1"
		src.item_state = "cake1"
		START_PROCESSING(SSprocessing, src)
	else
		src.force = null
		src.damtype = "brute"
		src.icon_state = "cake0"
		src.item_state = "cake0"
	return


/*
 * Ushanka
 */
/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "A warm fur hat with ear flaps that can be raised and tied to be out of the way."
	icon_state = "ushanka"
	flags_inv = HIDEEARS
	var/earsup = 0

/obj/item/clothing/head/ushanka/grey
	name = "grey ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "greyushanka"

/obj/item/clothing/head/ushanka/attack_self(mob/user as mob)
	src.earsup = !src.earsup
	if(src.earsup)
		icon_state = "[icon_state]_up"
		to_chat(user, "You raise the ear flaps on the ushanka.")
	else
		src.icon_state = initial(icon_state)
		to_chat(user, "You lower the ear flaps on the ushanka.")
	update_clothing_icon()

/*
 * Pumpkin head
 */

/obj/item/clothing/head/pumpkin
	name = "carved pumpkin"
	desc = "A pumpkin with a spooky face carved on it. Looks like it needs a candle."
	icon_state = "pumpkin_carved"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	drop_sound = 'sound/items/drop/herb.ogg'
	w_class = 3
	throwforce = 1
	throw_speed = 0.5

/obj/item/clothing/head/pumpkin/attackby(var/obj/O, mob/user as mob)
    if(istype(O, /obj/item/weapon/flame/candle))
        var/obj/item/weapon/flame/candle/c = O
        var/candle_wax = c.wax
        to_chat(user, "You add [O] to [src].")
        playsound(src.loc, 'sound/items/drop/gloves.ogg', 50, 1)
        qdel(O)
        var/obj/item/clothing/head/pumpkin/lantern/L = new /obj/item/clothing/head/pumpkin/lantern(user.loc)
        L.wax = candle_wax
        user.put_in_hands(L)
        qdel(src)
        return

/obj/item/clothing/head/pumpkin/lantern
	name = "jack o' lantern"
	desc = "A pumpkin with a spooky face carved on it, with a candle inside. Believed to ward off evil spirits."
	light_color = "#E09D37"
	var/wax = 900
	var/lit = 0

/obj/item/clothing/head/pumpkin/lantern/update_icon()
	icon_state = "pumpkin_carved[lit ? "_lit" : ""]"
	if(ismob(loc))
		var/mob/living/M = loc
		M.update_inv_head(0)
		M.update_inv_l_hand(0)
		M.update_inv_r_hand(1)

/obj/item/clothing/head/pumpkin/lantern/attackby(obj/item/weapon/W as obj, mob/user as mob)
	..()
	if(W.iswelder())
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.isOn()) //Badasses dont get blinded by lighting their candle with a welding tool
			light("<span class='notice'>\The [user] casually lights the [name] with [W].</span>")
	else if(isflamesource(W))
		light()
	else if(istype(W, /obj/item/weapon/flame/candle))
		var/obj/item/weapon/flame/candle/C = W
		if(C.lit)
			light()

/obj/item/clothing/head/pumpkin/lantern/proc/light(var/flavor_text = "<span class='notice'>\The [usr] lights the [name].</span>")
	if(!src.lit)
		src.lit = 1
		playsound(src.loc, 'sound/items/cigs_lighters/cig_light.ogg', 50, 1)
		//src.damtype = "fire"
		for(var/mob/O in viewers(usr, null))
			O.show_message(flavor_text, 1)
		set_light(CANDLE_LUM)
		update_icon()
		update_clothing_icon()
		START_PROCESSING(SSprocessing, src)

/obj/item/clothing/head/pumpkin/lantern/process()
	if(!lit)
		return
	wax--
	if(!wax)
		new /obj/item/clothing/head/pumpkin (src.loc)
		if(istype(src.loc, /mob))
			src.dropped()

		STOP_PROCESSING(SSprocessing, src)
		qdel(src)
	update_icon()
	if(istype(loc, /turf)) //start a fire if possible
		var/turf/T = loc
		T.hotspot_expose(700, 5)

/obj/item/clothing/head/pumpkin/lantern/attack_self(mob/user as mob)
	if(lit)
		lit = 0
		to_chat(user, span("notice", "You snuff out the flame."))
		playsound(src.loc, 'sound/items/cigs_lighters/cig_snuff.ogg', 50, 1)
		update_icon()
		set_light(0)

/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	siemens_coefficient = 1.5
	item_icons = list()

/obj/item/clothing/head/kitty/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if (slot == slot_head && istype(user))
		var/hairgb = rgb(user.r_hair, user.g_hair, user.b_hair)
		var/icon/blended = SSicon_cache.kitty_ear_cache[hairgb]
		if (!blended)
			blended = icon('icons/mob/head.dmi', "kitty")
			blended.Blend(hairgb, ICON_ADD)
			blended.Blend(icon('icons/mob/head.dmi', "kittyinner"), ICON_OVERLAY)

			SSicon_cache.kitty_ear_cache[hairgb] = blended

		icon_override = blended
	else if (icon_override)
		icon_override = null

/obj/item/clothing/head/richard
	name = "chicken mask"
	desc = "You can hear the distant sounds of rhythmic electronica."
	icon_state = "richard"
	body_parts_covered = HEAD|FACE
	flags_inv = BLOCKHAIR
