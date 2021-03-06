/obj/item/modular_computer/tablet/preset/custom_loadout/cheap/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit/small(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/micro(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module/nano(src)
	battery_module.charge_to_full()

/obj/item/modular_computer/tablet/preset/custom_loadout/advanced/install_default_hardware()
	..()
	processor_unit = new/obj/item/weapon/computer_hardware/processor_unit/small(src)
	hard_drive = new/obj/item/weapon/computer_hardware/hard_drive/small(src)
	network_card = new/obj/item/weapon/computer_hardware/network_card(src)
	nano_printer = new/obj/item/weapon/computer_hardware/nano_printer(src)
	card_slot = new/obj/item/weapon/computer_hardware/card_slot(src)
	battery_module = new/obj/item/weapon/computer_hardware/battery_module(src)
	battery_module.charge_to_full()


// Cargo Delivery
/obj/item/modular_computer/tablet/preset/custom_loadout/advanced/cargo_delivery/
	_app_preset_name = "cargo_delivery"
	enrolled = 1