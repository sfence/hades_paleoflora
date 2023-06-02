
local S = hades_paleoflora.translator

local schemdir = minetest.get_modpath(minetest.get_current_modname()).."/schematics/"

local function sapling_can_grow(pos, node)
  local def = minetest.registered_nodes[node.name]
  light = minetest.get_natural_light(pos)
  if light<(def._min_grow_light or 12) then
    return false
  end
  
  pos = vector.add(pos, vector.new(0,-1,0))
  node = minetest.get_node(pos)
  def = minetest.registered_nodes[node.name]
  
  if (minetest.get_item_group(node.name, "dirt")>0) then
    return true
  end
  
  return false
end

local function sapling_on_timer(pos, schem_file)
  local node = minetest.get_node(pos)
  local def = minetest.registered_nodes[node.name]
  if def._can_grow and (def._can_grow(pos, node)==false) then
    minetest.get_node_timer(pos):start(math.random(240, 600))
    return
  end
  minetest.remove_node(pos)
  minetest.place_schematic(vector.add(pos, vector.new(-5,0,-5), schem_file))
end

function hades_paleoflora.register_flower_onenode(name, def)
  minetest.register_node("hades_paleoflora:"..name, {
      description = def.desc,
      drawtype = "plantlike",
      tiles = {"hades_paleoflora_"..name..".png"},
      use_texture_alpha = "clip",
      inventory_image = "hades_paleoflora_"..name..".png",
      wield_image = "hades_paleoflora_"..name..".png",
      waving = 1,
      paramtype = "light",
      walkable = false,
      buildable_to = true,
      floodable = true,
      groups = {snappy=3,flower=1,flora2=1,flamable=2,attached_node=1},
    })
end

function hades_paleoflora.register_flower_treenode(name, def)
  minetest.register_node("hades_paleoflora:"..name, {
      description = def.desc,
      drawtype = "plantlike",
      tiles = {"hades_paleoflora_"..name..".png"},
      use_texture_alpha = "clip",
      inventory_image = "hades_paleoflora_"..name..".png",
      wield_image = "hades_paleoflora_"..name..".png",
      waving = 1,
      paramtype = "light",
      walkable = false,
      buildable_to = true,
      floodable = true,
      groups = {snappy=3,flower=1,flora2=1,flamable=2,attached_node=1},
    })
  minetest.register_node("hades_paleoflora:"..name.."_bottom", {
      description = def.desc,
      drawtype = "plantlike",
      tiles = {"hades_paleoflora_"..name.."_bottom.png"},
      use_texture_alpha = "clip",
      inventory_image = "hades_paleoflora_"..name..".png",
      wield_image = "hades_paleoflora_"..name..".png",
      waving = 1,
      paramtype = "light",
      walkable = false,
      buildable_to = true,
      floodable = true,
      groups = {snappy=3,flower=1,flora2=1,flamable=2,attached_node=1},
    })
  minetest.register_node("hades_paleoflora:"..name.."_top", {
      description = def.desc,
      drawtype = "plantlike",
      tiles = {"hades_paleoflora_"..name.."_top.png"},
      use_texture_alpha = "clip",
      inventory_image = "hades_paleoflora_"..name..".png",
      wield_image = "hades_paleoflora_"..name..".png",
      waving = 1,
      paramtype = "light",
      walkable = false,
      buildable_to = true,
      floodable = true,
      groups = {snappy=3,flower=1,flora2=1,flamable=2,attached_node=1},
    })
end

function hades_paleoflora.register_tree(prefix, def)
  minetest.register_node(prefix.."_trunk", {
    description = S("@1 Trunk",def.desc),
    tiles = {
      def.file_prefix.."_trunk_top.png",
      def.file_prefix.."_trunk_top.png",
      def.file_prefix.."_trunk.png",
    },
    paramtype = "light",
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        {-0.5,-0.5,-3/16, 0.5,0.5,3/16},
        {-7/16,-0.5,-5/16, 7/16,0.5,5/16},
        {-6/16,-0.5,-6/16, 6/16,0.5,6/16},
        {-5/16,-0.5,-7/16, 5/16,0.5,7/16},
        {-3/16,-0.5,-0.5, 3/16,0.5,0.5},
      },
    },
    collision_box = {
      type = "fixed",
      fixed = {{ -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }},
    },
    is_ground_content = false,
    groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
    sounds = def.sounds or hades_sounds.node_sound_wood_defaults(),
  })
  local drop
  if def.drop_item then
    drop = {
      max_items = 1,
      items = {
      {
          -- player will get def.drop_item with chance of (1/def.drop_rarity)
          items = {def.drop_item},
          rarity = def.drop_rarity,
        },
        {
          -- player will get leaves only if they get no def.drop_item,
          -- this is because max_items is 1
          items = {"hades_trees:"..id},
        }
      }
    }
  end
  minetest.register_node(prefix.."_leaves", {
    description = S("@1 Leaves", def.desc),
    drawtype = "allfaces_optional",
    tiles = {def.file_prefix.."_leaves.png"},
    paramtype = "light",
    waving = 1,
    is_ground_content = false,
    place_param2 = 1,
    groups = {snappy=3, leafdecay=def.leafdecay or 3, leafdecay_any=def.leafdecay_any, flammable=2, leaves=1, ash_fertilizer=def.ash_fertilizer, porous=1},
    drop = drop,
    sounds = hades_sounds.node_sound_leaves_defaults(),
    -- Store node name of corresponding trunk node
    _hades_trees_trunk = prefix.."_trunk",
  })
  minetest.register_node(prefix.."_sapling", {
    description = S("@1 Sapling", def.desc),
    _tt_help = S("Needs Dirt and light to grow"),
    drawtype = "plantlike",
    tiles = {def.file_prefix.."_sapling.png"},
    inventory_image = def.file_prefix.."_sapling.png",
    wield_image = def.file_prefix.."_sapling.png",
    paramtype = "light",
    walkable = false,
    is_ground_content = false,
    floodable = true,
    selection_box = {
      type = "fixed",
      fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    },
    groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1, sapling=1},
    sounds = hades_sounds.node_sound_bush_defaults(),
    _can_grow = sapling_can_grow,
    on_timer = function(pos)
      sapling_on_timer(pos, schemdir..def.file_prefix..".mts")
    end,
    on_construct = function(pos)
      minetest.get_node_timer(pos):start(math.random(def.grow_time_min or 2400, def.grow_time_max or 4800))
    end
  })
  minetest.register_node(prefix.."_wood", {
		description = S("@1 Wood", def.desc),
    tiles = {def.file_prefix.."_wood.png"},
		groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3,wood=1},
		is_ground_content = false,
		sounds = hades_sounds.node_sound_wood_defaults(),
	})
  minetest.register_craft({
      output = prefix.."_wood 4",
      recipe = {
        {prefix.."_trunk"},
      },
    })
end

