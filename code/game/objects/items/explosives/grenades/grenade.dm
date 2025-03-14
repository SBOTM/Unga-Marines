/obj/item/explosive/grenade
	name = "\improper M40 HEDP grenade"
	desc = "A small, but deceptively strong high explosive grenade that has been phasing out the M15 fragmentation grenades. Capable of being loaded in the any grenade launcher, or thrown by hand."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/items/grenade.dmi'
	icon_state = "grenade"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/inhands/weapons/grenades_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/weapons/grenades_right.dmi',
	)
	item_state = "grenade"
	throw_speed = 3
	throw_range = 7
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/weapons/smash.ogg'
	icon_state_mini = "grenade_red"
	///if launched from a UGL/grenade launcher
	var/launched = FALSE
	///bonus impact damage if launched from a UGL/grenade launcher
	var/launchforce = 10
	var/det_time = 4 SECONDS
	///Does it make a danger overlay for humans? Can synths use it?
	var/dangerous = TRUE
	var/arm_sound = 'sound/weapons/grenade/grenade_pinout.ogg'
	var/hud_state = "grenade_he"
	var/hud_state_empty = "grenade_empty"
	var/G_throw_sound = 'sound/weapons/grenade/grenade_throw.ogg'
	/// Power of the explosion
	var/power = 105
	/// Falloff of our explosion, aka distance, by the formula of power / falloff
	var/falloff = 30
	var/overlay_type = "red"


/obj/item/explosive/grenade/Initialize(mapload)
	. = ..()
	det_time = rand(det_time - 1 SECONDS, det_time + 1 SECONDS)

/obj/item/explosive/grenade/attack_self(mob/user)
	if(active)
		return

	if(!user.dextrous)
		balloon_alert(user, "not enough dexterity")
		return

	if(issynth(user) && dangerous && !CONFIG_GET(flag/allow_synthetic_gun_use))
		balloon_alert(user, "can't, against your programming")
		return

	activate(user)

	balloon_alert_to_viewers("primes grenade")
	if(initial(dangerous) && ishumanbasic(user))
		var/nade_sound = user.gender == FEMALE ? SFX_FEMALE_FRAGOUT : SFX_MALE_FRAGOUT

		for(var/mob/living/carbon/human/H in hearers(6,user))
			H.playsound_local(user, nade_sound, 35)

		var/image/grenade = image('icons/mob/talk.dmi', user, "grenade")
		user.add_emote_overlay(grenade)

/obj/item/explosive/grenade/afterattack(atom/target, mob/user, has_proximity, click_parameters)
	. = ..()
	if(!active)
		return
	user.throw_item(target)

/obj/item/explosive/grenade/proc/activate(mob/user)
	if(active)
		return

	if(user)
		log_bomber(user, "primed", src)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[user.ckey]
		personal_statistics.grenades_primed++

	icon_state = initial(icon_state) + "_active"
	active = TRUE
	playsound(loc, arm_sound, 30, 1, 6)
	if(dangerous)
		GLOB.round_statistics.grenades_thrown++
		SSblackbox.record_feedback(FEEDBACK_TALLY, "round_statistics", 1, "grenades_thrown")
		update_icon()
	addtimer(CALLBACK(src, PROC_REF(prime)), det_time)
	return TRUE

/obj/item/explosive/grenade/update_overlays()
	. = ..()
	if(active && overlay_type)
		. += image('icons/effects/danger.dmi', icon_state = "danger_[overlay_type]")


/obj/item/explosive/grenade/proc/prime()
	cell_explosion(loc, power = src.power, falloff = src.falloff)
	qdel(src)

/obj/item/explosive/grenade/fire_act(burn_level, flame_color)
	activate()

/obj/item/explosive/grenade/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	walk(src, null, null)
	return

///Adjusts det time, used for grenade launchers
/obj/item/explosive/grenade/proc/launched_det_time()
	det_time = min(12, det_time)

/obj/item/explosive/grenade/throw_at(target, range, speed, thrower, spin, flying, targetted_throw)
	. = ..()
	playsound(thrower, G_throw_sound, 25, 1, 6)

////RAD GRENADE - TOTALLY RAD MAN
/obj/item/explosive/grenade/rad
	name = "\improper V-40 rad grenade"
	desc = "Rad grenades release an extremely potent but short lived burst of radiation, debilitating organic life and frying electronics in a moderate radius. After the initial detonation, the radioactive effects linger for a time. Handle with extreme care."
	icon_state = "grenade_rad" //placeholder
	item_state = "grenade_rad" //placeholder
	icon_state_mini = "grenade_red" //placeholder
	det_time = 40 //default
	arm_sound = 'sound/weapons/armbomb.ogg' //placeholder
	hud_state = "grenade_he" //placeholder
	///The range for the grenade's full effect
	var/inner_range = 4
	///The range range for the grenade's weak effect
	var/outer_range = 7
	///The potency of the grenade
	var/rad_strength = 20

/obj/item/explosive/grenade/rad/prime()
	var/turf/impact_turf = get_turf(src)

	playsound(impact_turf, 'sound/effects/portal_opening.ogg', 50, 1)
	for(var/mob/living/victim in hearers(outer_range, src))
		var/strength
		var/sound_level
		if(get_dist(victim, impact_turf) <= inner_range)
			strength = rad_strength
			sound_level = 3
		else
			strength = rad_strength * 0.6
			sound_level = 2

		strength = victim.modify_by_armor(strength, BIO, 25)
		victim.apply_radiation(strength, sound_level)
	qdel(src)
