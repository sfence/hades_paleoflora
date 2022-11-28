
local S = hades_paleoflora.translator

-- onion seeds
minetest.register_node("hades_paleoflora:seed_wild_onion", {
	description = S("Wild Onion Seed"),
	tiles = {"hades_paleoflora_wild_onion_seed.png"},
	inventory_image = "hades_paleoflora_wild_onion_seed.png",
	wield_image = "hades_paleoflora_wild_onion_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:wild_onion_1")
	end,
})

-- wild onion
minetest.register_craftitem("hades_paleoflora:wild_onion", {
	description = S("Wild Onion"),
	inventory_image = "hades_paleoflora_onion.png",
	groups = {seed = 2, flammable = 3, food = 2, eatable = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:wild_onion_1")
	end,
	on_use = minetest.item_eat(math.floor(math.random(1,4)/4))
})

-- wild onion pack
minetest.register_craftitem("hades_paleoflora:wild_onion_pack", {
	description = S("Wild Onion Pack"),
	inventory_image = "hades_paleoflora_onion.png",
	groups = {seed = 2, food_onion = 1, flammable = 3, food = 2, eatable = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:onion_1")
	end,
	on_use = minetest.item_eat(1)
})

minetest.register_craft({
	output = "hades_extrafarming:wild_onion_pack",
	recipe = {
		{"hades_paleoflora:wild_onion", "hades_paleoflora:wild_onion"},
		{"hades_paleoflora:wild_onion", "hades_paleoflora:wild_onion"},
	},
})

-- crop definition
local def = {
	drawtype = "plantlike",
	tiles = {"hades_paleoflora_wild_wild_onion_1.png"},
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
minetest.register_node("hades_paleoflora:wild_onion_1", table.copy(def))

-- stage 2
def.tiles = {"hades_paleoflora_wild_wild_onion_2.png"}
minetest.register_node("hades_paleoflora:wild_onion_2", table.copy(def))

-- stage 3
def.tiles = {"hades_paleoflora_wild_wild_onion_3.png"}
minetest.register_node("hades_paleoflora:wild_onion_3", table.copy(def))

-- stage 4
def.tiles = {"hades_paleoflora_wild_wild_onion_4.png"}
minetest.register_node("hades_paleoflora:wild_onion_4", table.copy(def))

-- stage 5
def.tiles = {"hades_paleoflora_wild_wild_onion_5.png"}
minetest.register_node("hades_paleoflora:wild_onion_5", table.copy(def))

-- stage 6
def.tiles = {"hades_paleoflora_wild_wild_onion_6.png"}
minetest.register_node("hades_paleoflora:wild_onion_6", table.copy(def))

-- stage 7
def.tiles = {"hades_paleoflora_wild_wild_onion_7.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	max_items = 3, items = {
		{items = {"hades_paleoflora:wild_onion"}, rarity = 1},
		{items = {"hades_paleoflora:wild_onion"}, rarity = 2},
		{items = {"hades_paleoflora:wild_onion"}, rarity = 5}
	}
}
minetest.register_node("hades_paleoflora:wild_onion_7", table.copy(def))

-- add to registered_plants
farming.registered_plants["hades_paleoflora:wild_onion"] = {
	crop = "hades_paleoflora:wild_onion",
	seed = "hades_paleoflora:wild_onion",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 7
}
