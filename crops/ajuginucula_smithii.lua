

local S = hades_paleoflora.translator

-- onion seeds
minetest.register_node("hades_paleoflora:seed_ajuginucula_smithii", {
	description = S("Ajuginucula Smithii Seeds"),
	tiles = {"hades_paleoflora_ajuginucula_smithi_seeds.png"},
	inventory_image = "hades_paleoflora_ajuginucula_smithi_seeds.png",
	wield_image = "hades_paleoflora_ajuginucula_smithi_seeds.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:ajuginucula_smithi_1")
	end,
})

-- Ajuginucula Smithi
minetest.register_craftitem("hades_paleoflora:ajuginucula_smithi", {
	description = S("Ajuginucula Smithii"),
	inventory_image = "hades_paleoflora_ajuginucula_smithi.png",
	groups = {seed = 2, flammable = 3, food = 2, eatable = 1},
	on_use = minetest.item_eat(1)
})

-- crop definition
local def = {
	drawtype = "plantlike",
	tiles = {"hades_paleoflora_ajuginucula_smithii_plant_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 3, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = hades_sounds.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("hades_paleoflora:ajuginucula_smithii_1", table.copy(def))

-- stage 2
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_2.png"}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_2", table.copy(def))

-- stage 3
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_3.png"}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_3", table.copy(def))

-- stage 4
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_4.png"}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_4", table.copy(def))

-- stage 5
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_5.png"}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_5", table.copy(def))

-- stage 6
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_6.png"}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_6", table.copy(def))

-- stage 7
def.tiles = {"hades_paleoflora_ajuginucula_smithii_plant_7.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	max_items = 5, items = {
		{items = {"hades_paleoflora:seed_ajuginucula_smithii"}, rarity = 1},
		{items = {"hades_paleoflora:ajuginucula_smithii"}, rarity = 1},
		{items = {"hades_paleoflora:seed_ajuginucula_smithii"}, rarity = 5},
	}
}
minetest.register_node("hades_paleoflora:ajuginucula_smithii_7", table.copy(def))

-- add to registered_plants
farming.registered_plants["hades_paleoflora:ajuginucula_smithii"] = {
	crop = "hades_paleoflora:ajuginucula_smithi",
	seed = "hades_paleoflora:seed_ajuginucula_smithii",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}
