
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

