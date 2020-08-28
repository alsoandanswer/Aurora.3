/obj/structure/door_assembly
	name = "airlock assembly"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_as_0"
	anchored = 0
	density = 1
	w_class = 5
	build_amt = 4
	var/state = 0
	var/base_icon_state = ""
	var/base_name = "Airlock"
	var/obj/item/airlock_electronics/electronics = null
	var/airlock_type = "" //the type path of the airlock once completed
	var/glass_type = "/glass"
	var/glass = 0 // 0 = glass can be installed. -1 = glass can't be installed. 1 = glass is already installed. Text = mineral plating is installed instead.
	var/created_name = null

	New()
		update_state()

/obj/structure/door_assembly/door_assembly_com
	base_icon_state = "com"
	base_name = "Command Airlock"
	glass_type = "/glass_command"
	airlock_type = "/command"

/obj/structure/door_assembly/door_assembly_sec
	base_icon_state = "sec"
	base_name = "Security Airlock"
	glass_type = "/glass_security"
	airlock_type = "/security"

/obj/structure/door_assembly/door_assembly_eng
	base_icon_state = "eng"
	base_name = "Engineering Airlock"
	glass_type = "/glass_engineering"
	airlock_type = "/engineering"

/obj/structure/door_assembly/door_assembly_min
	base_icon_state = "min"
	base_name = "Mining Airlock"
	glass_type = "/glass_mining"
	airlock_type = "/mining"

/obj/structure/door_assembly/door_assembly_atmo
	base_icon_state = "atmo"
	base_name = "Atmospherics Airlock"
	glass_type = "/glass_atmos"
	airlock_type = "/atmos"

/obj/structure/door_assembly/door_assembly_research
	base_icon_state = "res"
	base_name = "Research Airlock"
	glass_type = "/glass_research"
	airlock_type = "/research"

/obj/structure/door_assembly/door_assembly_science
	base_icon_state = "sci"
	base_name = "Science Airlock"
	glass_type = "/glass_science"
	airlock_type = "/science"

/obj/structure/door_assembly/door_assembly_med
	base_icon_state = "med"
	base_name = "Medical Airlock"
	glass_type = "/glass_medical"
	airlock_type = "/medical"

/obj/structure/door_assembly/door_assembly_mai
	base_icon_state = "mai"
	base_name = "Maintenance Airlock"
	airlock_type = "/maintenance"
	glass = -1

/obj/structure/door_assembly/door_assembly_ext
	base_icon_state = "ext"
	base_name = "External Airlock"
	airlock_type = "/external"
	glass = -1

/obj/structure/door_assembly/door_assembly_fre
	base_icon_state = "fre"
	base_name = "Freezer Airlock"
	airlock_type = "/freezer"
	glass = -1

/obj/structure/door_assembly/door_assembly_fma
	base_icon_state = "mai"
	base_name = "Freezer Maintenance Access"
	airlock_type = "/freezer_maint"
	glass = -1

/obj/structure/door_assembly/door_assembly_hatch
	base_icon_state = "hatch"
	base_name = "Airtight Hatch"
	airlock_type = "/hatch"
	glass = -1

/obj/structure/door_assembly/door_assembly_mhatch
	base_icon_state = "mhatch"
	base_name = "Maintenance Hatch"
	airlock_type = "/maintenance_hatch"
	glass = -1

/obj/structure/door_assembly/door_assembly_highsecurity
	base_icon_state = "highsec"
	base_name = "High Security Airlock"
	airlock_type = "/highsecurity"
	glass = -1

/obj/structure/door_assembly/door_assembly_vault
	base_icon_state = "vault"
	base_name = "Vault"
	airlock_type = "/vault"
	glass = -1

/obj/structure/door_assembly/door_assembly_lift
	base_icon_state = "lift"
	base_name = "Elevator Door"
	airlock_type = "/lift"
	glass = -1

/obj/structure/door_assembly/door_assembly_skrell
	base_icon_state = "skrell_purple"
	base_name = "Airlock"
	airlock_type = "/skrell"
	glass = -1

/obj/structure/door_assembly/door_assembly_skrell/grey
	base_icon_state = "skrell_grey"
	base_name = "Airlock"
	airlock_type = "/skrell/grey"

/obj/structure/door_assembly/multi_tile
	icon = 'icons/obj/doors/door_assembly2x1.dmi'
	icon_state = null //only have icons for the glass version
	dir = EAST
	var/width = 1

/*Temporary until we get sprites.
	glass_type = "/multi_tile/glass"
	airlock_type = "/multi_tile/maint"
	glass = 1*/
	base_icon_state = "g" //Remember to delete this line when reverting "glass" var to 1.
	airlock_type = "/multi_tile/glass"
	glass = -1 //To prevent bugs in deconstruction process.

/obj/structure/door_assembly/multi_tile/Initialize()
	. = ..()
	SetBounds()
	update_state()

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	SetBounds()

/obj/structure/door_assembly/multi_tile/proc/SetBounds()
	if(width > 1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size

/obj/structure/door_assembly/attackby(obj/item/W as obj, mob/user as mob)
	if(W.ispen())
		var/t = sanitizeSafe(input(user, "Enter the name for the door.", src.name, src.created_name), MAX_NAME_LEN)
		if(!t)	return
		if(!in_range(src, usr) && src.loc != usr)	return
		created_name = t
		return

	if(W.iswelder() && ( (istext(glass)) || (glass == 1) || (!anchored) ))
		var/obj/item/weldingtool/WT = W
		if (WT.remove_fuel(0, user))
			playsound(src.loc, 'sound/items/welder_pry.ogg', 50, 1)
			if(istext(glass))
				user.visible_message("[user] welds the [glass] plating off the airlock assembly.", "You start to weld the [glass] plating off the airlock assembly.")
				if(do_after(user, 40/W.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You welded the [glass] plating off!</span>")
					var/M = text2path("/obj/item/stack/material/[glass]")
					new M(src.loc, 2)
					glass = 0
			else if(glass == 1)
				user.visible_message("[user] welds the glass panel out of the airlock assembly.", "You start to weld the glass panel out of the airlock assembly.")
				if(do_after(user, 40/W.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You welded the glass panel out!</span>")
					new /obj/item/stack/material/glass/reinforced(src.loc)
					glass = 0
			else if(!anchored)
				user.visible_message("[user] dissassembles the airlock assembly.", "You start to dissassemble the airlock assembly.")
				if(do_after(user, 40/W.toolspeed))
					if(!src || !WT.isOn()) return
					to_chat(user, "<span class='notice'>You dissasembled the airlock assembly!</span>")
					dismantle()
		else
			to_chat(user, "<span class='notice'>You need more welding fuel.</span>")
			return

	else if(W.iswrench() && state == 0)
		playsound(src.loc, W.usesound, 100, 1)
		if(anchored)
			user.visible_message("<b>[user]</b> begins unsecuring the airlock assembly from the floor.", \
								SPAN_NOTICE("You start unsecuring the airlock assembly from the floor."))
		else
			user.visible_message("<b>[user]</b> begins securing the airlock assembly to the floor.", \
								SPAN_NOTICE("You start securing the airlock assembly to the floor."))

		if(do_after(user, 40/W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You [anchored? "un" : ""]secured the airlock assembly!</span>")
			anchored = !anchored

	else if(W.iscoil() && state == 0 && anchored)
		var/obj/item/stack/cable_coil/C = W
		if (C.get_amount() < 1)
			to_chat(user, "<span class='warning'>You need one length of coil to wire the airlock assembly.</span>")
			return
		user.visible_message("[user] wires the airlock assembly.", "You start to wire the airlock assembly.")
		if(do_after(user, 40) && state == 0 && anchored)
			if (C.use(1))
				src.state = 1
				to_chat(user, "<span class='notice'>You wire the airlock.</span>")

	else if(W.iswirecutter() && state == 1 )
		playsound(src.loc, 'sound/items/wirecutter.ogg', 100, 1)
		user.visible_message("[user] cuts the wires from the airlock assembly.", "You start to cut the wires from airlock assembly.")

		if(do_after(user, 40/W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You cut the airlock wires.!</span>")
			new/obj/item/stack/cable_coil(src.loc, 1)
			src.state = 0

	else if(istype(W, /obj/item/airlock_electronics) && state == 1)
		var/obj/item/airlock_electronics/EL = W
		if(!EL.is_installed)
			playsound(src.loc, 'sound/items/screwdriver.ogg', 100, 1)
			user.visible_message("[user] installs the electronics into the airlock assembly.", "You start to install electronics into the airlock assembly.")
			EL.is_installed = 1
			if(do_after(user, 40/W.toolspeed))
				EL.is_installed = 0
				if(!src) return
				user.drop_from_inventory(EL,src)
				to_chat(user, "<span class='notice'>You installed the airlock electronics!</span>")
				src.state = 2
				src.name = "Near finished Airlock Assembly"
				src.electronics = EL
			else
				EL.is_installed = 0

	else if(W.iscrowbar() && state == 2 )
		//This should never happen, but just in case I guess
		if (!electronics)
			to_chat(user, "<span class='notice'>There was nothing to remove.</span>")
			src.state = 1
			return

		playsound(src.loc, W.usesound, 100, 1)
		user.visible_message("\The [user] starts removing the electronics from the airlock assembly.", "You start removing the electronics from the airlock assembly.")

		if(do_after(user, 40/W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You removed the airlock electronics!</span>")
			src.state = 1
			src.name = "Wired Airlock Assembly"
			electronics.forceMove(src.loc)
			electronics = null

	else if(istype(W, /obj/item/stack/material) && !glass)
		var/obj/item/stack/S = W
		var/material_name = S.get_material_name()
		if (S)
			if (S.get_amount() >= 1)
				if(material_name == "rglass")
					playsound(src.loc, "crowbar", 100, 1)
					user.visible_message("[user] adds [S.name] to the airlock assembly.", "You start to install [S.name] into the airlock assembly.")
					if(do_after(user, 40) && !glass)
						if (S.use(1))
							to_chat(user, "<span class='notice'>You installed reinforced glass windows into the airlock assembly.</span>")
							glass = 1
				else if(material_name)
					// Ugly hack, will suffice for now. Need to fix it upstream as well, may rewrite mineral walls. ~Z
					if(!(material_name in list("gold", "silver", "diamond", "uranium", "phoron", "sandstone")))
						to_chat(user, "You cannot make an airlock out of that material.")
						return
					if(S.get_amount() >= 2)
						playsound(src.loc, "crowbar", 100, 1)
						user.visible_message("[user] adds [S.name] to the airlock assembly.", "You start to install [S.name] into the airlock assembly.")
						if(do_after(user, 40) && !glass)
							if (S.use(2))
								to_chat(user, "<span class='notice'>You installed [SSmaterials.material_display_name(material_name)] plating into the airlock assembly.</span>")
								glass = material_name

	else if(W.isscrewdriver() && state == 2 )
		playsound(src.loc, W.usesound, 100, 1)
		to_chat(user, "<span class='notice'>Now finishing the airlock.</span>")

		if(do_after(user, 40/W.toolspeed))
			if(!src) return
			to_chat(user, "<span class='notice'>You finish the airlock!</span>")
			var/path
			if(istext(glass))
				path = text2path("/obj/machinery/door/airlock/[glass]")
			else if (glass == 1)
				path = text2path("/obj/machinery/door/airlock[glass_type]")
			else
				path = text2path("/obj/machinery/door/airlock[airlock_type]")

			new path(src.loc, src)
			qdel(src)
	else if(istype(W, /obj/item/material/twohanded/chainsaw))
		var/obj/item/material/twohanded/chainsaw/ChainSawVar = W
		if(!ChainSawVar.wielded)
			to_chat(user, "<span class='notice'>Cutting the airlock requires the strength of two hands.</span>")
		else if(ChainSawVar.cutting)
			to_chat(user, "<span class='notice'>You are already cutting an airlock open.</span>")
		else if(!ChainSawVar.powered)
			to_chat(user, "<span class='notice'>The [W] needs to be on in order to open this door.</span>")
		else
			ChainSawVar.cutting = 1
			user.visible_message(\
				"<span class='danger'>[user.name] starts cutting the rest of the airlock with the [W]!</span>",\
				"<span class='warning'>You start cutting the rest of the airlock...</span>",\
				"<span class='notice'>You hear a loud buzzing sound and metal grinding on metal...</span>"\
			)
			if(do_after(user, ChainSawVar.opendelay SECONDS, act_target = user, extra_checks  = CALLBACK(src, .proc/CanChainsaw, W)))
				user.visible_message(\
					"<span class='warning'>[user.name] finishes cutting the airlock with the [W].</span>",\
					"<span class='warning'>You finish cutting the airlock.</span>",\
					"<span class='notice'>You hear a metal clank and some sparks.</span>"\
				)
				new /obj/item/stack/material/steel(src.loc, 2)
				ChainSawVar.cutting = 0
				qdel(src)
			else
				ChainSawVar.cutting = 0
	else
		..()
	update_state()

/obj/structure/door_assembly/proc/CanChainsaw(var/obj/item/material/twohanded/chainsaw/ChainSawVar)
	return (ChainSawVar.powered)

/obj/structure/door_assembly/proc/update_state()
	icon_state = "door_as_[glass == 1 ? "g" : ""][istext(glass) ? glass : base_icon_state][state]"
	name = ""
	switch (state)
		if(0)
			if (anchored)
				name = "Secured "
		if(1)
			name = "Wired "
		if(2)
			name = "Near Finished "
	name += "[glass == 1 ? "Window " : ""][istext(glass) ? "[glass] Airlock" : base_name] Assembly"
