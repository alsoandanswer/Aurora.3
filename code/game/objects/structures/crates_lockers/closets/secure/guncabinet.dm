/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	req_access = list(access_armory)
	icon = 'icons/obj/guncabinet.dmi'
	icon_state = "base"
	anchored = 1
	canbemoved = 1


/obj/structure/closet/secure_closet/guncabinet/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/closet/secure_closet/guncabinet/LateInitialize()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/toggle()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/update_icon()
	cut_overlays()
	if(opened)
		add_overlay("door_open")
	else
		var/lazors = 0
		var/shottas = 0
		for (var/obj/item/gun/G in contents)
			if (istype(G, /obj/item/gun/energy))
				lazors++
			if (istype(G, /obj/item/gun/projectile/))
				shottas++
		if (lazors || shottas)
			for (var/i = 0 to 2)
				if (lazors > 0 && (shottas <= 0 || prob(50)))
					lazors--
					add_overlay("laser[i]")
				else if (shottas > 0)
					shottas--
					add_overlay("projectile[i]")

		add_overlay("door")
		if(welded)
			add_overlay("welded")
		if(broken)
			add_overlay("broken")
		else if (locked)
			add_overlay("locked")
		else
			add_overlay("open")

/obj/structure/closet/secure_closet/guncabinet/sci
	name = "science gun cabinet"
	req_access = list(access_tox_storage)
	icon = 'icons/obj/sciguncabinet.dmi'
	icon_state = "sci"
