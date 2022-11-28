
local S = hades_paleoflora.translator

-- onion seeds
minetest.register_node("hades_paleoflora:seed_rhamnus_salifocifus", {
	description = S("Wild Onion Seed"),
	tiles = {"hades_paleoflora_rhamnus_salifocifus_seeds.png"},
	inventory_image = "hades_paleoflora_rhamnus_salifocifus_seeds.png",
	wield_image = "hades_paleoflora_rhamnus_salifocifus_seeds.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:rhamnus_salifocifus_1")
	end,
})

-- rhamnus salifocifus
temp_effects.register_effect_type("rhamnus_poison", {
  desc = S("Rhamnua Poison"),
  apply_effect = function(player_name, params)
    params.time_sum = params.time_sum or 0
    print("appliing rhamnua poison: "..params.time_sum)
    if (params.time_sum>0) then
      if (math.random()>(math.abs(params.time_sum-300)/300)) then
        local player = minetest.get_player_by_name(player_name)
        player:set_hp(player:get_hp()-1, {
            type = "set_hp",
            description = S("Rhamnua Poison"),
          })
      end
    end
    local next_time = math.random(15,45)
    params.time_sum = params.time_sum + next_time
    if (params.time_sum<600) then
      return next_time
    end
    return 0
  end,
})

minetest.register_craftitem("hades_paleoflora:rhamnus_salifocifus", {
	description = S("Rhamnus Salifocifus"),
	inventory_image = "hades_paleoflora_rhamnus_salifocifus.png",
	groups = {seed = 2, flammable = 3, food = 2, eatable = 1},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "hades_paleoflora:rhamnus_salifocifus_1")
	end,
	on_use = function(itemstack, user, pointed_thing)
    local player_name = user:get_player_name()
    if (player_name~="") then
      temp_effects.add_effect("rhamnus_poison", player_name, math.random(500,700), nil)
    end
    return minetest.do_item_eat(5, nil, itemstack, user, pointed_thing)
  end,
})

-- crop definition
local def = {
	drawtype = "plantlike",
	tiles = {"hades_paleoflora_rhamnus_salifocifus_plant_1.png"},
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
minetest.register_node("hades_paleoflora:rhamnus_salifocifus_1", table.copy(def))

-- stage 2
def.tiles = {"hades_paleoflora_rhamnus_salifocifus_plant_2.png"}
minetest.register_node("hades_paleoflora:rhamnus_salifocifus_2", table.copy(def))

-- stage 3
def.tiles = {"hades_paleoflora_rhamnus_salifocifus_plant_3.png"}
minetest.register_node("hades_paleoflora:rhamnus_salifocifus_3", table.copy(def))

-- stage 4
def.tiles = {"hades_paleoflora_rhamnus_salifocifus_plant_4.png"}
minetest.register_node("hades_paleoflora:rhamnus_salifocifus_4", table.copy(def))

-- stage 7
def.tiles = {"hades_paleoflora_rhamnus_salifocifus_plant_7.png"}
def.groups.growing = nil
def.selection_box = farming.select_final
def.drop = {
	max_items = 5, items = {
		{items = {"hades_paleoflora:seed_rhamnus_salifocifus"}, rarity = 1},
		{items = {"hades_paleoflora:rhamnus_salifocifus"}, rarity = 1},
		{items = {"hades_paleoflora:seed_rhamnus_salifocifus"}, rarity = 5},
	}
}
minetest.register_node("hades_paleoflora:rhamnus_salifocifus_7", table.copy(def))

-- add to registered_plants
farming.registered_plants["hades_paleoflora:rhamnus_salifocifus"] = {
	crop = "hades_paleoflora:rhamnus_salifocifus",
	seed = "hades_paleoflora:seed_rhamnus_salifocifus",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 5
}
