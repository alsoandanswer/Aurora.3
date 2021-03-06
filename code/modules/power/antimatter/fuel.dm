/obj/item/weapon/fuel
	name = "nagnetic storage ring"
	desc = "A magnetic storage ring."
	icon = 'icons/obj/items.dmi'
	icon_state = "rcdammo"
	opacity = 0
	density = 0
	anchored = 0.0
	var/fuel = 0
	var/s_time = 1.0
	var/content = null

/obj/item/weapon/fuel/H
	name = "hydrogen storage ring"
	content = "Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/antiH
	name = "anti-hydrogen storage ring"
	content = "Anti-Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/attackby(obj/item/weapon/fuel/F, mob/user)
	..()
	if(istype(src, /obj/item/weapon/fuel/antiH))
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			F.fuel = 0
			to_chat(user, "You add the anti-Hydrogen to the storage ring. It now contains [src.fuel]kg.")
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			qdel(F)
			F = null
			src:annihilation(src.fuel)
	if(istype(src, /obj/item/weapon/fuel/H))
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			F.fuel = 0
			to_chat(user, "You add the Hydrogen to the storage ring. It now contains [src.fuel]kg")
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			qdel(src)
			F:annihilation(F.fuel)

/obj/item/weapon/fuel/antiH/proc/annihilation(var/mass)


	var/strength = convert2energy(mass)

	if (strength < 773.0)
		var/turf/T = get_turf(src)

		if (strength > (450+T0C))
			explosion(T, 0, 1, 2, 4)
		else
			if (strength > (300+T0C))
				explosion(T, 0, 0, 2, 3)

		qdel(src)
		return

	var/turf/ground_zero = get_turf(loc)

	var/ground_zero_range = round(strength / 387)
	explosion(ground_zero, ground_zero_range, ground_zero_range*2, ground_zero_range*3, ground_zero_range*4)

	//SN src = null
	qdel(src)
	return


/obj/item/weapon/fuel/examine()
	..()
	to_chat(user, "<span class='info'>A magnetic storage ring containing [fuel]kg of [content ? content : "nothing"].</span>")

/obj/item/weapon/fuel/proc/injest(mob/M as mob)
	switch(content)
		if("Anti-Hydrogen")
			to_chat(mob, span("notice", "That was not a very bright idea."))
			M.gib()
		if("Hydrogen")
			to_chat(M, "<span class='notice'>You feel very light, as if you might just float away...</span>")
	qdel(src)
	return

/obj/item/weapon/fuel/attack(mob/M as mob, mob/user as mob)
	if (user != M)
		//If you come from the distant future and happen to find this unincluded and derelict file, you may be wondering what this is. In truth, it's better that you don't know.
		var/obj/effect/equip_e/human/O = new /obj/effect/equip_e/human(  )
		O.source = user
		O.target = M
		O.item = src
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "fuel"
		M.requests += O
		spawn( 0 )
			O.process()
			return
	else
		for(var/mob/O in viewers(M, null))
			O.show_message(text("<span class='warning'>\The [M] eats the [content ? content : "empty canister"]!</span>"), 1)
		src.injest(M)
