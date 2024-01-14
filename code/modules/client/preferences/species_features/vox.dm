#define VOX_BODY_COLOR "#99FF99"
#define VOX_SNOUT_COLOR "#F0F064"
#define VOX_HAIR_COLOR "#FF9966"

/proc/generate_vox_side_shots(list/sprite_accessories, key, include_snout = TRUE, accessory_color = VOX_HAIR_COLOR)
	var/list/values = list()

	var/icon/vox_head = icon('icons/mob/species/vox/bodyparts.dmi', "vox_head_m")
	var/icon/eyes = icon('icons/mob/species/vox/eyes.dmi', "eyes_l")
	var/icon/eyes_r = icon('icons/mob/species/vox/eyes.dmi', "eyes_r")


	vox_head.Blend(VOX_BODY_COLOR, ICON_MULTIPLY)
	eyes.Blend(COLOR_TEAL, ICON_MULTIPLY)
	eyes_r.Blend(COLOR_TEAL, ICON_MULTIPLY)
	eyes.Blend(eyes_r, ICON_OVERLAY)
	vox_head.Blend(eyes, ICON_OVERLAY)

	if(include_snout)
		var/icon/snout = icon('icons/mob/species/vox/vox_snouts.dmi', "m_snout_vox_ADJ")
		snout.Blend(VOX_SNOUT_COLOR, ICON_MULTIPLY)
		vox_head.Blend(snout, ICON_OVERLAY)

	for (var/name in sprite_accessories)
		var/datum/sprite_accessory/sprite_accessory = sprite_accessories[name]

		var/icon/final_icon = icon(vox_head)

		var/icon/accessory_icon = icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ")
		accessory_icon.Blend(accessory_color, ICON_MULTIPLY)
		final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(10, 19, 22, 31)
		final_icon.Scale(32, 32)

		values[name] = final_icon

	return values

/datum/preference/choiced/vox_snout
	savefile_key = "feature_vox_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	should_generate_icons = TRUE
	main_feature_name = "Snout"

/datum/preference/choiced/vox_snout/init_possible_values()
	return generate_vox_side_shots(GLOB.vox_snouts_list, "snout", FALSE, VOX_SNOUT_COLOR)

/datum/preference/choiced/vox_snout/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/choiced/vox_snout/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return FALSE

/datum/preference/choiced/vox_snout/create_default_value()
	var/datum/sprite_accessory/vox_snouts/voxsnout = /datum/sprite_accessory/vox_snouts/vox
	return initial(voxsnout.name)

/datum/preference/choiced/vox_spines
	savefile_key = "feature_vox_spines"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/spines/vox

/datum/preference/choiced/vox_spines/init_possible_values()
	return assoc_to_keys(GLOB.spines_list_vox)

/datum/preference/choiced/vox_spines/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["spines_vox"] = value

/datum/preference/choiced/vox_hair
	savefile_key = "feature_vox_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	should_generate_icons = TRUE
	main_feature_name = "Hairstyle"
	relevant_external_organ = /obj/item/organ/external/vox_hair

/datum/preference/choiced/vox_hair/init_possible_values()
	return generate_vox_side_shots(GLOB.vox_hair_list, "vox_hair")

/datum/preference/choiced/vox_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_hair"] = value

/datum/preference/choiced/vox_hair/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "hair_color"

	return data

/datum/preference/choiced/vox_facial_hair
	savefile_key = "feature_vox_facial_hair"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Facial Hairstyle"
	should_generate_icons = TRUE
	relevant_external_organ = /obj/item/organ/external/vox_facial_hair

/datum/preference/choiced/vox_facial_hair/init_possible_values()
	return generate_vox_side_shots(GLOB.vox_facial_hair_list, "vox_facial_hair")

/datum/preference/choiced/vox_facial_hair/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_facial_hair"] = value

/datum/preference/choiced/vox_facial_hair/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "facial_hair_color"

	return data
