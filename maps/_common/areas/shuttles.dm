////////////
//SHUTTLES//
////////////
/area/shuttle
	name = "Shuttle"
	icon_state = "shuttle"
	requires_power = 0
	sound_env = SMALL_ENCLOSED
	no_light_control = 1
	flags = RAD_SHIELDED | SPAWN_ROOF
	centcomm_area = 1

/area/shuttle/arrival
	name = "Arrival Shuttle"
<<<<<<< HEAD
	ambience = AMBIENCE_ARRIVALS
	flags = RAD_SHIELDED | SPAWN_ROOF

/area/shuttle/arrival/centcom
	icon_state = "shuttle2"
=======
>>>>>>> master
	base_turf = /turf/unsimulated/floor/plating

/area/shuttle/arrival/Entered(atom/movable/Obj, atom/oldLoc)
	. = ..()
	if (!istype(Obj, /mob/living) || !SSarrivals)
		return

	SSarrivals.on_hotzone_enter(Obj)

/area/shuttle/arrival/Exited(atom/movable/Obj, atom/newLoc)
	. = ..()
	if (!istype(Obj, /mob/living) || !SSarrivals)
		return

	SSarrivals.on_hotzone_exit(Obj)

/area/shuttle/escape
	name = "Transfer Shuttle"
	base_turf = /turf/unsimulated/floor/plating
	sound_env = LARGE_ENCLOSED

/area/shuttle/escape_pod
	name = "Escape pod"
	base_turf = /turf/unsimulated/floor/asteroid/ash

/area/shuttle/escape_pod/pod1
	name = "Escape pod - 1"

/area/shuttle/escape_pod/pod2
	name = "Escape pod - 2"

/area/shuttle/escape_pod/pod3
	name = "Escape pod - 3"

/area/shuttle/mining
	name = "Mining Shuttle"

/area/shuttle/transport1
	icon_state = "shuttle"
	name = "Transport Shuttle"
	base_turf = /turf/unsimulated/floor/plating

/area/shuttle/specops
	name = "Special Ops Shuttle"
	base_turf = /turf/unsimulated/floor/plating
	ambience = AMBIENCE_HIGHSEC

/area/shuttle/burglar
	name = "Unidentified Transport"

/area/shuttle/skipjack

/area/shuttle/mercenary

/area/shuttle/syndicate_elite
	name = "Naval Transport Shuttle"

/area/shuttle/administration
	name = "Unidentified Corvette"
	base_turf = /turf/unsimulated/floor/plating
	sound_env = LARGE_ENCLOSED

/area/shuttle/research
	name = "Research Shuttle"
	base_turf = /turf/unsimulated/floor/asteroid/ash

/area/shuttle/legion
	name = "Foreign Legion Shuttle"
	base_turf = /turf/unsimulated/floor/plating

/area/shuttle/distress
	name = "Unidentified Shuttle"
	base_turf = /turf/unsimulated/floor/plating

/area/shuttle/merchant
	name = "Merchant Ship"
	flags = RAD_SHIELDED | SPAWN_ROOF
	base_turf = /turf/space
	sound_env = LARGE_ENCLOSED
