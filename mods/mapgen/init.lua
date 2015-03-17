-- MGPlatform (the easiest way to customize your map generation!)
-- Includes in-development features such as biomes, floatlands, and moretrees. (all in development)

minetest.clear_registered_biomes()

--
-- Variables
--

submoretrees = false -- set this to true if you want to replace the default trees with moretrees versions.
floatlands = true -- enable this to enable floatlands
normalbiomes = true -- enable this to enable biomes

--
-- Enable/Disable Biomes
--
enablemeadow = true
enablejungle = true
enabledesert = true
enablesnowmountain = true
enablegrassmountain = true
enablealpine = true
enabledune = true
enableprairie = true


--
-- Normal Biomes (indev)
--

if normalbiomes then

	if enablemeadow then
		minetest.register_biome({
			name = "meadow",
			node_top = "default:dirt_with_grass",		depth_top = 1,
			node_filler = "default:dirt",			depth_filler = 3,
			height_min = 2,					height_max = 500,
			heat_point = 100,				humidity_point = 30,
		})
	end

	if enablejungle then
		minetest.register_biome({
			name = "jungle",
			node_top = "default:dirt_with_grass",		depth_top = 1,
			node_filler = "default:dirt",			depth_filler = 3,
			height_min = 2,					height_max = 500,
			heat_point = 150,				humidity_point = 80,
		})
	end

	if enabledesert then
		minetest.register_biome({
			name = "desert",
			node_top = "default:desert_sand",		depth_top = 1, -- 3
			node_filler = "default:desert_stone",		depth_filler = 3, -- 57
			height_min = -500,				height_max = 500,
			heat_point = 100, 				humidity_point = 30, -- 40 --- 0
		})
	end

	if enablesnowmountain then
		minetest.register_biome({
			name = "snowmountain",
			node_top = "default:snowblock",			depth_top = 1,
			node_filler = "default:dirt_with_snow",		depth_filler = 1,
			height_min = 80,				height_max = 1000,
		})
	end

	if enablegrassmountain then
		minetest.register_biome({
			name = "grassmountain",
			node_top = "default:dirt_with_grass",		depth_top = 1,
			node_filler = "default:dirt",			depth_filler = 1,
			height_min = 300,				height_max = 1000,
		})
	end

	if enablealpine then
		minetest.register_biome({
			name = "alpine",
			node_top = "default:snowblock",			depth_top = 1,
			node_filler = "default:dirt_with_snow",		depth_filler = 1,
			height_min = 100,				height_max = 800,
		})
	end

	if enabledune then
		minetest.register_biome({
			name = "dune",
			node_top = "default:sand",			depth_top = 3,
			node_filler = "default:dirt",			depth_filler = 2,
			height_min = 1,					height_max = 500,
			heat_point = 100,				humidity_point = 10,
		})
	end

	if enableprairie then
		minetest.register_biome({
			name = "prairie",
			node_top = "default:dirt_with_grass",		depth_top = 1,
			node_filler = "default:dirt",			depth_filler = 4,
			height_min = 40,				height_max = 500,
			heat_point = 40,				humidity_point = 20,
		})
	end
end

--
-- Floatlands Biomes (indev)
--
if floatlands then
minetest.register_biome({
	name = "floatlands",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	height_min = 500,				height_max = 31000,
	heat_point = 40,				humidity_point = 20,
})
end

--
-- More Trees mod support (thanks VanessaE!) (not working)
--

if submoretrees and minetest.get_modpath("moretrees") ~= nil then

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.027,
	biomes = {"forest"},
	decoration = "moretrees:beech_sapling_ongen",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on ="default:dirt_with_grass",
	sidelen = 80,
	fill_ratio = 0.003,
	biomes = {"meadow"},
	decoration = "moretrees:beech_sapling_ongen",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.013,
	biomes = {"jungle"},
	decoration = {"moretrees:jungletree_sapling_ongen"},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:sand",
	sidelen = 16,
	fill_ratio = 0.027,
	spawn_by = "default:water_source",		num_spawn_by = 2,
	biomes = {"tropical_beach"},
	decoration = "moretrees:palm_sapling_ongen",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 80,
	fill_ratio = 0.003,
	biomes = {"jungle"},
	decoration = {"moretrees:rubber_tree_sapling_ongen"},
})

else

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.037,
	biomes = {"forest"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("mapgen").."/schematics/appletree.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 80,
	fill_ratio = 0.003,
	biomes = {"meadow"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("mapgen").."/schematics/appletree.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.057,
	biomes = {"jungle"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("mapgen").."/schematics/jungletree.mts",
})

end

--
-- Schematics
--

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:snowblock",
	sidelen = 16,
	fill_ratio = 0.047,
	flags = "place_center_x, place_center_z",
	biomes = {"mountain"},
	schematic = minetest.get_modpath("mapgen").."/schematics/snowtreeongen.mts",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.17,
	biomes = {"jungle"},
	decoration = {"default:junglegrass"},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:sand",
	sidelen = 16,
	noise_params = {offset = 0, scale = 1, spread = {x = 80, y = 80, z = 80}, seed = 983240, octaves = 4, persist = 0.55},
	biomes = {"dune"},
	decoration = "default:grass_5",
})


minetest.register_abm({
	nodenames = "default:sapling",
	interval = 40,
	chance = 20,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "default:snowblock" then
			return
		end
		minetest.remove_node(pos)
		pos.x = pos.x-3
		pos.z = pos.z-3
		minetest.place_schematic(pos, minetest.get_modpath("mapgen").."/schematics/snowtree.mts", 0, {}, false)
	end,
})

