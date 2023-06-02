
local S = hades_paleoflora.translator

-- potato seeds
minetest.register_node("hades_paleoflora:seed_wild_potato", {
	description = S("Wild Potato Seed"),
	tiles = {"hades_paleoflora_wild_potato_seeds.png"},
	inventory_image = "hades_paleoflora_wild_potato_seeds.png",
	wield_image = "hades_paleoflora_wild_potato_seeds.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:potato_1")
	end,
})

-- wild potato
minetest.register_craftitem("hades_paleoflora:wild_potato", {
	description = S("Wild Potato"),
	inventory_image = "hades_paleoflora_wild_potato.png",
	groups = {seed = 2, flammable = 3, food = 2, eatable = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:wild_potato_1")
	end,
	on_use = minetest.item_eat(math.floor(math.random(1,4)/4))
})

-- wild potato pack
minetest.register_craftitem("hades_paleoflora:wild_potato_pack", {
	description = S("Wild Potato Pack"),
	inventory_image = "hades_paleoflora_wild_potato_pack.png",
	groups = {seed = 2, food_potato = 1, flammable = 3, food = 2, eatable = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:potato_1")
	end,
	on_use = minetest.item_eat(1)
})

minetest.register_craft({
	output = "hades_extrafarming:wild_potato_pack",
	recipe = {
		{"hades_paleoflora:wild_potato", "hades_paleoflora:wild_onion"},
		{"hades_paleoflora:wild_potato", "hades_paleoflora:wild_onion"},
	},
})

-- crop definition
local def = {
	drawtype = "plantlike",
	tiles = {"hades_paleoflora_wild_potato_1.png"},
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
minetest.register_node("hades_paleoflora:wild_potato_1", table.copy(def))

-- stage 2
def.tiles = {"hades_paleoflora_wild_potato_2.png"}
minetest.register_node("hades_paleoflora:wild_potato_2", table.copy(def))

-- stage 3
def.tiles = {"hades_paleoflora_wild_potato_3.png"}
minetest.register_node("hades_paleoflora:wild_potato_3", table.copy(def))

-- stage 4
def.tiles = {"hades_paleoflora_wild_potato_4.png"}
minetest.register_node("hades_paleoflora:wild_potato_4", table.copy(def))

-- stage 5
def.tiles = {"hades_paleoflora_wild_potato_5.png"}
minetest.register_node("hades_paleoflora:wild_potato_5", table.copy(def))

-- stage 6
def.tiles = {"hades_paleoflora_wild_potato_6.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	max_items = 3, items = {
		{items = {"hades_paleoflora:wild_potato"}, rarity = 1},
		{items = {"hades_paleoflora:wild_potato"}, rarity = 2},
		{items = {"hades_paleoflora:wild_potato"}, rarity = 5}
	}
}
minetest.register_node("hades_paleoflora:wild_potato_6", table.copy(def))

-- add to registered_plants
farming.registered_plants["hades_paleoflora:wild_potato"] = {
	crop = "hades_paleoflora:wild_potato",
	seed = "hades_paleoflora:seed_wild_potato",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 6
}

