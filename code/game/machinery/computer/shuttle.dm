/obj/machinery/computer/shuttle
	name = "Shuttle"
	desc = "For shuttle control."

	is_holographic = FALSE
	icon_screen = "shuttle"
	light_color = LIGHT_COLOR_CYAN
	var/auth_need = 3.0
	var/list/authorized = list(  )


/obj/machinery/computer/shuttle/attackby(var/obj/item/card/W as obj, var/mob/user as mob)
	if(stat & (BROKEN|NOPOWER))
		return

	var/datum/evacuation_controller/shuttle/evac_control = evacuation_controller
	if(!istype(evac_control))
		to_chat(user, SPAN_DANGER("This console should not in use on this map. Please report this to a developer."))
		return

	if ((!( istype(W, /obj/item/card) ) || !( SSticker ) || evacuation_controller.has_evacuated() || !( user )))
		return

	if (W.GetID())
		var/obj/item/card/id/id = W

		if (!id.access) //no access
			to_chat(user, "The access level of [id.registered_name]\'s card is not high enough. ")
			return

		var/list/cardaccess = id.access
		if(!istype(cardaccess, /list) || !cardaccess.len) //no access
			to_chat(user, "The access level of [id.registered_name]\'s card is not high enough. ")
			return

		if(!(access_heads in id.access)) //doesn't have this access
			to_chat(user, "The access level of [id.registered_name]\'s card is not high enough. ")
			return 0

		var/choice = alert(user, text("Would you like to (un)authorize a shortened launch time? [] authorization\s are still needed. Use abort to cancel all authorizations.", src.auth_need - src.authorized.len), "Shuttle Launch", "Authorize", "Repeal", "Abort")
		if(evacuation_controller.is_prepared() && user.get_active_hand() != id)
			return 0
		switch(choice)
			if("Authorize")
				src.authorized -= id.registered_name
				src.authorized += id.registered_name
				if (src.auth_need - src.authorized.len > 0)
					message_admins("[key_name_admin(user)] has authorized early shuttle launch")
					log_game("[key_name(user)] has authorized early shuttle launch",ckey=key_name(user))
					to_world(text("<span class='notice'><b>Alert: [] authorizations needed until shuttle is launched early</b></span>", src.auth_need - src.authorized.len))
				else
					message_admins("[key_name_admin(user)] has launched the shuttle")
					log_game("[key_name(user)] has launched the shuttle early",ckey=key_name(user))
					to_world("<span class='notice'><b>Alert: Shuttle launch time shortened to 10 seconds!</b></span>")
					evacuation_controller.set_launch_time(world.time+100)
					//src.authorized = null
					qdel(src.authorized)
					src.authorized = list(  )

			if("Repeal")
				src.authorized -= id.registered_name
				to_world(text("<span class='notice'><b>Alert: [] authorizations needed until shuttle is launched early</b></span>", src.auth_need - src.authorized.len))

			if("Abort")
				to_world("<span class='notice'><b>All authorizations to shortening time for shuttle launch have been revoked!</b></span>")
				src.authorized.len = 0
				src.authorized = list(  )

	else if (istype(W, /obj/item/card/emag) && !emagged)
		var/choice = alert(user, "Would you like to launch the shuttle?","Shuttle control", "Launch", "Cancel")

		if(!emagged && !evacuation_controller.is_prepared() && user.get_active_hand() == W)
			switch(choice)
				if("Launch")
					to_world("<span class='notice'><b>Alert: Shuttle launch time shortened to 10 seconds!</b></span>")
					evacuation_controller.set_launch_time(world.time+100)
					emagged = 1
				if("Cancel")
					return
	return
