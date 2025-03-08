/* Windoor (window door) assembly -Nodrak
* Step 1: Create a windoor out of rglass
* Step 2: Add r-glass to the assembly to make a secure windoor (Optional)
* Step 3: Rotate or Flip the assembly to face and open the way you want
* Step 4: Wrench the assembly in place
* Step 5: Add cables to the assembly
* Step 6: Set access for the door.
* Step 7: Screwdriver the door to complete
*/

/obj/structure/windoor_assembly
	icon = 'icons/obj/doors/windoor.dmi'

	name = "Windoor Assembly"
	icon_state = "l_windoor_assembly01"
	anchored = FALSE
	density = FALSE
	dir = NORTH
	allow_pass_flags = PASS_GLASS|PASS_AIR
	atom_flags = ON_BORDER

	var/obj/item/circuitboard/airlock/electronics = null

	//Vars to help with the icon's name
	/// Does the windoor open to the left or right?
	var/facing = "l"
	/// Whether or not this creates a secure windoor
	var/secure = ""
	/// How far the door assembly has progressed in terms of sprites
	var/state = "01"

/obj/structure/windoor_assembly/Initialize(mapload, start_dir=NORTH, constructed=0)
	. = ..()
	if(constructed)
		state = "01"
		anchored = FALSE
	switch(start_dir)
		if(NORTH, SOUTH, EAST, WEST)
			setDir(start_dir)
		else //If the user is facing northeast. northwest, southeast, southwest or north, default to north
			setDir(NORTH)
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_try_exit),
	)
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/windoor_assembly/setDir(newdir)
	. = ..()
	update_icon()

/obj/structure/windoor_assembly/update_icon_state()
	. = ..()
	icon_state = "[facing]_[secure]windoor_assembly[state]"

/obj/structure/windoor_assembly/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return

	switch(state)
		if("01")
			//Adding plasteel makes the assembly a secure windoor assembly. Step 2 (optional) complete.
			if(istype(I, /obj/item/stack/rods) && !secure)
				var/obj/item/stack/rods/R = I
				if(R.get_amount() < 4)
					to_chat(user, span_warning("You need more rods to do this."))
					return

				to_chat(user, span_notice("You start to reinforce the windoor with rods."))
				if(!do_after(user,4 SECONDS, NONE, src, BUSY_ICON_BUILD) || secure)
					return

				if(!R.use(4))
					return

				to_chat(user, span_notice("You reinforce the windoor."))
				secure = "secure_"
				if(anchored)
					name = "Secure Anchored Windoor Assembly"
				else
					name = "Secure Windoor Assembly"

			//Adding cable to the assembly. Step 5 complete.
			else if(iscablecoil(I) && anchored)
				user.visible_message("[user] wires the windoor assembly.", "You start to wire the windoor assembly.")

				var/obj/item/stack/cable_coil/CC = I
				if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
					return

				if(!CC.use(1))
					return

				to_chat(user, span_notice("You wire the windoor!"))
				state = "02"
				if(secure)
					name = "Secure Wired Windoor Assembly"
				else
					name = "Wired Windoor Assembly"
		if("02")
			//Adding airlock electronics for access. Step 6 complete.
			if(istype(I, /obj/item/circuitboard/airlock) && I.icon_state != "door_electronics_smoked")
				playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
				user.visible_message("[user] installs the electronics into the airlock assembly.", "You start to install electronics into the airlock assembly.")

				if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
					return

				user.drop_held_item()
				I.forceMove(src)
				to_chat(user, span_notice("You've installed the airlock electronics!"))
				name = "Near finished Windoor Assembly"
				electronics = I
	//Update to reflect changes(if applicable)
	update_icon()

/obj/structure/windoor_assembly/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(state != "01")
		return
	if(!anchored)
		return
	var/obj/item/tool/weldingtool/WT = I
	if(!WT.remove_fuel(0, user))
		to_chat(user, span_notice("You need more welding fuel to dissassemble the windoor assembly."))
		return

	user.visible_message("[user] dissassembles the windoor assembly.", "You start to dissassemble the windoor assembly.")
	playsound(loc, 'sound/items/welder2.ogg', 25, 1)

	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	if(!src || !WT.isOn())
		return
	to_chat(user, span_notice("You dissasembled the windoor assembly!"))
	new /obj/item/stack/sheet/glass/reinforced(get_turf(src), 5)
	if(secure)
		new /obj/item/stack/rods(get_turf(src), 4)
	qdel(src)
	update_icon()

/obj/structure/windoor_assembly/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(state != "01")
		return
	//Wrenching an unsecure assembly anchors it in place. Step 4 complete
	if(!anchored)
		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message("[user] secures the windoor assembly to the floor.", "You start to secure the windoor assembly to the floor.")

		if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
			return

		to_chat(user, span_notice("You've secured the windoor assembly!"))
		anchored = TRUE
		if(secure)
			name = "Secure Anchored Windoor Assembly"
		else
			name = "Anchored Windoor Assembly"
	//Unwrenching an unsecure assembly un-anchors it. Step 4 undone
	else
		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message("[user] unsecures the windoor assembly to the floor.", "You start to unsecure the windoor assembly to the floor.")

		if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
			return

		to_chat(user, span_notice("You've unsecured the windoor assembly!"))
		anchored = FALSE

		if(secure)
			name = "Secure Windoor Assembly"
		else
			name = "Windoor Assembly"
	update_icon()

/obj/structure/windoor_assembly/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	//Removing wire from the assembly. Step 5 undone.
	if(state != "02")
		return
	if(electronics)
		return
	playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
	user.visible_message("[user] cuts the wires from the airlock assembly.", "You start to cut the wires from airlock assembly.")

	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	to_chat(user, span_notice("You cut the windoor wires.!"))
	new /obj/item/stack/cable_coil(get_turf(user), 1)
	state = "01"
	if(secure)
		name = "Secure Anchored Windoor Assembly"
	else
		name = "Anchored Windoor Assembly"
	update_icon()

/obj/structure/windoor_assembly/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	//Screwdriver to remove airlock electronics. Step 6 undone.
	if(state != "02")
		return
	if(!electronics)
		return

	playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
	user.visible_message("[user] removes the electronics from the airlock assembly.", "You start to uninstall electronics from the airlock assembly.")

	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	if(!electronics)
		return

	to_chat(user, span_notice("You've removed the airlock electronics!"))
	if(secure)
		name = "Secure Wired Windoor Assembly"
	else
		name = "Wired Windoor Assembly"
	var/obj/item/circuitboard/airlock/ae = electronics
	electronics = null
	ae.forceMove(loc)
	update_icon()

/obj/structure/windoor_assembly/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	//Crowbar to complete the assembly, Step 7 complete.
	if(state != "02")
		return

	if(!electronics)
		to_chat(user, span_warning("The assembly is missing electronics."))
		return
	DIRECT_OUTPUT(user, browse(null, "window=windoor_access"))
	playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
	user.visible_message("[user] pries the windoor into the frame.", "You start prying the windoor into the frame.")

	if(!do_after(user, 4 SECONDS, NONE, src, BUSY_ICON_BUILD))
		return

	density = TRUE //Shouldn't matter but just incase
	to_chat(user, span_notice("You finish the windoor!"))

	if(secure)
		var/obj/machinery/door/window/secure/BR = new(loc)
		if(facing == "l")
			BR.icon_state = "leftsecureopen"
			BR.base_state = "leftsecure"
		else
			BR.icon_state = "rightsecureopen"
			BR.base_state = "rightsecure"
		BR.setDir(dir)
		BR.density = FALSE
		if(electronics.one_access)
			BR.req_access = null
			BR.req_one_access = electronics.conf_access
		else
			BR.req_access = electronics.conf_access
		BR.electronics = electronics
		electronics.forceMove(BR)
	else
		var/obj/machinery/door/window/WR = new(loc)
		if(facing == "l")
			WR.icon_state = "leftopen"
			WR.base_state = "left"
		else
			WR.icon_state = "rightopen"
			WR.base_state = "right"
		WR.setDir(dir)
		WR.density = FALSE
		if(electronics.one_access)
			WR.req_access = null
			WR.req_one_access = electronics.conf_access
		else
			WR.req_access = electronics.conf_access
		WR.electronics = electronics
		electronics.forceMove(WR)
	qdel(src)
	update_icon()

//Rotates the windoor assembly clockwise
/obj/structure/windoor_assembly/verb/revrotate()
	set name = "Rotate Windoor Assembly"
	set category = "IC.Rotate"
	set src in oview(1)

	if (src.anchored)
		to_chat(usr, "It is fastened to the floor; therefore, you can't rotate it!")
		return 0
	setDir(turn(src.dir, 270))

//Flips the windoor assembly, determines whather the door opens to the left or the right
/obj/structure/windoor_assembly/verb/flip()
	set name = "Flip Windoor Assembly"
	set category = "IC.Rotate"
	set src in oview(1)

	if(facing == "l")
		to_chat(usr, "The windoor will now slide to the right.")
		facing = "r"
	else
		facing = "l"
		to_chat(usr, "The windoor will now slide to the left.")

	update_icon()

