/datum/gear/pipe
	display_name = "smoking pipe selection"
	path = /obj/item/clothing/mask/smokable/pipe

/datum/gear/pipe/New()
	..()
	var/pipe = list()
	pipe["pipe, smoking"] = /obj/item/clothing/mask/smokable/pipe
	pipe["pipe, corn"] = /obj/item/clothing/mask/smokable/pipe/cobpipe
	gear_tweaks += new/datum/gear_tweak/path(pipe)

/datum/gear/matchbook
	display_name = "matchbook"
	path = /obj/item/storage/box/matches

/datum/gear/lighter
	display_name = "lighter selection"
	path = /obj/item/storage/fancy/cigarettes

/datum/gear/lighter/New()
	..()
	var/lighter = list()
	lighter["cheap lighter"] = /obj/item/flame/lighter
	lighter["zippo lighter"] = /obj/item/flame/lighter/zippo
	gear_tweaks += new/datum/gear_tweak/path(lighter)

/datum/gear/cigarcase
	display_name = "cigar case"
	path = /obj/item/storage/fancy/cigar

/datum/gear/cigarette
	display_name = "cigarette packet selection"
	path = /obj/item/storage/fancy/cigarettes

/datum/gear/cigarette/New()
	..()
	var/cigarettes = list()
	cigarettes["cigarette packet"] = /obj/item/storage/fancy/cigarettes
	cigarettes["dromedaryco cigarette packet"] = /obj/item/storage/fancy/cigarettes/dromedaryco
	gear_tweaks += new/datum/gear_tweak/path(cigarettes)