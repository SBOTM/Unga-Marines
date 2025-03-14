/obj/machinery/holosign
	name = "holosign"
	desc = "Small wall-mounted holographic projector"
	icon = 'icons/obj/machines/holosign.dmi'
	icon_state = "sign_off"
	layer = MOB_LAYER
	anchored = TRUE
	var/lit = 0
	var/id = null
	var/on_icon = "sign_on"

/obj/machinery/holosign/proc/toggle()
	if(machine_stat & (BROKEN|NOPOWER))
		return
	lit = !lit
	update_icon()

/obj/machinery/holosign/update_icon_state()
	. = ..()
	if(!lit)
		icon_state = "sign_off"
	else
		icon_state = on_icon

/obj/machinery/holosign/power_change()
	if(machine_stat & NOPOWER)
		lit = 0
	update_icon()

/obj/machinery/holosign/surgery
	name = "surgery holosign"
	desc = "Small wall-mounted holographic projector. This one reads SURGERY."
	on_icon = "surgery"

/obj/machinery/holosign_switch
	name = "holosign switch"
	icon = 'icons/obj/power.dmi'
	icon_state = "light1"
	desc = "A remote control switch for holosign."
	anchored = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 4
	var/id = null
	var/active = 0

/obj/machinery/holosign_switch/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/holosign_switch/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	if(istype(I, /obj/item/detective_scanner))
		return
	else
		return attack_hand(user)

/obj/machinery/holosign_switch/attack_hand(mob/living/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	use_power(active_power_usage)

	active = !active
	if(active)
		icon_state = "light1"
	else
		icon_state = "light0"

	for(var/obj/machinery/holosign/M in GLOB.machines)
		if(M.id == src.id)
			INVOKE_ASYNC(M, TYPE_PROC_REF(/obj/machinery/holosign, toggle))
