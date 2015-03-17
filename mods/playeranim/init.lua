Normalmodel = false

-- if 3D Armor
if minetest.get_modpath("3d_armor") then
	dofile(minetest.get_modpath("playeranim").."/model_armor.lua")
end

-- Minecraft 1.8 Model
if not minetest.get_modpath("3d_armor") then
	dofile(minetest.get_modpath("playeranim").."/model_18.lua")
end

-- Normal Model
if Normalmodel == true then
	dofile(minetest.get_modpath("playeranim").."/model_normal.lua")
end
