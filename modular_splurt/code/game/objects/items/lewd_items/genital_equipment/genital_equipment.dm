/obj/item/genital_equipment
	var/genital_slot
	var/datum/component/genital_equipment/equipment

/obj/item/genital_equipment/ComponentInitialize()
	. = ..()
	var/list/procs_list = list(
		"before_inserting" = CALLBACK(src, .proc/item_inserting),
		"after_inserting" = CALLBACK(src, .proc/item_inserted),
		"before_removing" = CALLBACK(src, .proc/item_removing),
		"after_removing" = CALLBACK(src, .proc/item_removed)
	)
	AddComponent(/datum/component/genital_equipment, genital_slot, procs_list)
	equipment = GetComponent(/datum/component/genital_equipment)

/// Item-specific checks to run before inserting in a genital
/obj/item/genital_equipment/proc/item_inserting(datum/source, obj/item/organ/genital/G, mob/user)
	return TRUE

/// Runs after the item has been inserted in a genital
/obj/item/genital_equipment/proc/item_inserted(datum/source, obj/item/organ/genital/G, mob/user)
	return TRUE

/// Item-specific checks to run before removing from a genital
/obj/item/genital_equipment/proc/item_removing(datum/source, obj/item/organ/genital/G, mob/user)
	return TRUE

/// Runs after the item has been removed from a genital
/obj/item/genital_equipment/proc/item_removed(datum/source, obj/item/organ/genital/G, mob/user)
	return TRUE
