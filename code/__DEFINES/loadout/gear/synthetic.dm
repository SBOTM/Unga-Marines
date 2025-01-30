GLOBAL_LIST_INIT(synthetic_gear_listed_products, list(
	/obj/effect/vendor_bundle/synth = list(CAT_ESS, "Essential synthetic set", 0, "white"),
	//command stuff
	/obj/item/beacon/supply_beacon = list(CAT_SYNTH, "Supply beacon", 5, "blue"),
	/obj/item/beacon/orbital_bombardment_beacon = list(CAT_SYNTH, "Orbital beacon", 5, "blue"),
	/obj/item/fulton_extraction_pack = list(CAT_SYNTH, "Fulton Extraction Pack", 5, "blue"),
	/obj/item/deployable_camera = list(CAT_SYNTH, "Deployable Overwatch Camera", 1, "blue"),
	/obj/item/whistle = list(CAT_SYNTH, "Whistle", 1, "yellow"),
	/obj/item/megaphone = list(CAT_SYNTH, "Megaphone", 1, "yellow"),
	//engi stuff
	/obj/item/stack/sheet/metal/small_stack = list(CAT_SYNTH, "Metal x10", METAL_PRICE_IN_GEAR_VENDOR, "orange"),
	/obj/item/stack/sheet/plasteel/small_stack = list(CAT_SYNTH, "Plasteel x10", PLASTEEL_PRICE_IN_GEAR_VENDOR, "orange"),
	/obj/item/stack/sandbags_empty/half = list(CAT_SYNTH, "Sandbags x25", SANDBAG_PRICE_IN_GEAR_VENDOR, "orange"),
	/obj/item/tool/weldingtool/hugetank = list(CAT_SYNTH, "High-capacity industrial blowtorch", 5, "orange"),
	/obj/item/explosive/plastique = list(CAT_SYNTH, "Plastique explosive", 2, "orange3"),
	/obj/item/explosive/plastique/genghis_charge = list(CAT_SYNTH, "EX-62 Genghis incendiary charge", 6, "orange3"),
	/obj/effect/teleporter_linker = list(CAT_SYNTH, "Teleporters", 15, "blue"),
	/obj/item/tool/pickaxe/plasmacutter = list(CAT_SYNTH, "Plasma cutter", 15, "blue"),
	/obj/item/attachable/buildasentry = list(CAT_SYNTH, "Build-A-Sentry Attachment", 30, "blue"),
	/obj/item/deployable_floodlight = list(CAT_SYNTH, "Deployable floodlight", 2, "blue"),
	/obj/item/weapon/shield/riot/marine/deployable = list(CAT_SYNTH, "TL-182 deployable shield", 3, "yellow"),
	/obj/item/tool/handheld_charger = list(CAT_SYNTH, "Hand-held cell charger", 2, "yellow"),
	/obj/item/cell/high = list(CAT_SYNTH, "High capacity powercell", 1, "yellow"),
	/obj/item/cell/rtg/small = list(CAT_SYNTH, "Recharger powercell", 2, "yellow"),
	/obj/item/cell/rtg/large = list(CAT_SYNTH, "Large recharger powercell", 5, "yellow"),
	//medic stuff
	/obj/item/reagent_containers/glass/bottle/lemoline/doctor = list(CAT_SYNTH, "Lemoline bottle", 14, "orange"),
	/obj/item/storage/pill_bottle/meralyne = list(CAT_SYNTH, "Meralyne pills", 14, "orange"),
	/obj/item/storage/pill_bottle/dermaline = list(CAT_SYNTH, "Dermaline pills", 14, "orange"),
	/obj/item/storage/pill_bottle/russian_red = list(CAT_SYNTH, "Red Russian pills", 12, "orange"),
	/obj/item/storage/pill_bottle/quickclot = list(CAT_SYNTH, "Quickclot pills", 6, "orange"),
	/obj/item/storage/pill_bottle/peridaxon = list(CAT_SYNTH, "Peridaxon pills", 6, "orange"),
	/obj/item/stack/medical/heal_pack/advanced/bruise_combat_pack = list(CAT_SYNTH, "Combat Trauma Kit", 3, "orange"),
	/obj/item/stack/medical/heal_pack/advanced/burn_combat_pack = list(CAT_SYNTH, "Combat Burn Kit", 3, "orange"),
	/obj/item/reagent_containers/hypospray/advanced = list(CAT_SYNTH, "Hypospray", 1, "yellow"),
	/obj/item/reagent_containers/hypospray/advanced/big = list(CAT_SYNTH, "Big hypospray", 2, "yellow"),
	/obj/item/storage/syringe_case/meralyne = list(CAT_SYNTH, "syringe Case (120u Meralyne)", 14, "blue"),
	/obj/item/storage/syringe_case/dermaline = list(CAT_SYNTH, "syringe Case (120u Dermaline)", 14, "blue"),
	/obj/item/storage/syringe_case/meraderm = list(CAT_SYNTH, "syringe Case (120u Meraderm)", 14, "blue"),
	/obj/item/storage/syringe_case/nanoblood = list(CAT_SYNTH, "syringe Case (120u Nanoblood)", 4, "blue"),
	/obj/item/reagent_containers/hypospray/advanced/meralyne = list(CAT_SYNTH, "Hypospray (120u Meralyne)", 14, "cyan"), //half the units of the mera case half the price
	/obj/item/reagent_containers/hypospray/advanced/dermaline = list(CAT_SYNTH, "Hypospray (120u dermaline)", 14, "cyan"), //half the units of the derm case half the price
	/obj/item/reagent_containers/hypospray/advanced/meraderm = list(CAT_SYNTH, "Hypospray (120u Meraderm)", 14, "cyan"), //half the units of the meraderm case half the price
	/obj/item/reagent_containers/hypospray/advanced/nanoblood = list(CAT_SYNTH, "Hypospray (60u Nanoblood)", 2, "cyan"), //bit more than half of the nanoblood case
	/obj/item/reagent_containers/hypospray/advanced/russian_red = list(CAT_SYNTH, "Hypospray (120u Russian Red)", 16, "cyan"),
	/obj/item/reagent_containers/hypospray/advanced/quickclot = list(CAT_SYNTH, "Hypospray (120u Quickclot)", 4, "blue"),
	/obj/item/reagent_containers/hypospray/advanced/oxycodone = list(CAT_SYNTH, "Hypospray (120u Oxycodone)", 12, "blue"),
	/obj/item/reagent_containers/hypospray/advanced/peridaxon = list(CAT_SYNTH, "Hypospray (Peridaxon)", 7, "blue"),
	/obj/item/reagent_containers/hypospray/autoinjector/quickclot = list(CAT_SYNTH, "Injector (Quickclot)", 2, "cyan"),
	/obj/item/reagent_containers/hypospray/autoinjector/peridaxon = list(CAT_SYNTH, "Injector (Peridaxon)", 2, "cyan"),
	/obj/item/reagent_containers/hypospray/autoinjector/combat_advanced = list(CAT_SYNTH, "Injector (Advanced)", 3, "cyan"),
	/obj/item/reagent_containers/hypospray/autoinjector/synaptizine = list(CAT_SYNTH, "Injector (Synaptizine)", 2, "cyan"),
	/obj/item/reagent_containers/hypospray/autoinjector/oxycodone = list(CAT_SYNTH, "Injector (Oxycodone)", 2, "cyan"),
	/obj/item/reagent_containers/hypospray/autoinjector/neuraline = list(CAT_SYNTH, "Injector (Neuraline)", 7, "cyan"),
	/obj/item/healthanalyzer/gloves = list(CAT_SYNTH, "Health scanner gloves", 2, "yellow"),
	/obj/item/defibrillator/gloves = list(CAT_SYNTH, "Advanced medical gloves", 4, "yellow"),
	/obj/item/defibrillator/advanced = list(CAT_SYNTH, "advanced emergency defibrillator", 4, "yellow"),
	/obj/item/tweezers_advanced = list(CAT_SYNTH, "Advanced Tweezers", 8, "yellow"),
	/obj/effect/vendor_bundle/stretcher = list(CAT_SYNTH, "Medivac Stretcher", 20, "yellow"),
	/obj/item/deployable_optable = list(CAT_SYNTH, "Deployable Operating Table", 12, "yellow"),
	/obj/item/storage/box/t312case = list(CAT_MEDSUP, "R-312 'Albedo' Revolver", 25, "red"), // can buy for other, why not
))
