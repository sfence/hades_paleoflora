
hades_paleoflora = {
  translator = minetest.get_translator("paleoflora")
}

local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/functions.lua")

dofile(modpath.."/flowers.lua")
dofile(modpath.."/crops/ajuginucula_smithii.lua")
dofile(modpath.."/crops/rhamnus_salifocifus.lua")
dofile(modpath.."/crops/wild_onion.lua")
dofile(modpath.."/crops/wild_potato.lua")
dofile(modpath.."/trees.lua")

