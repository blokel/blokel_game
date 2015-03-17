local player_sneak = {}
local player_anim = {}
local ANIM_STAND = 1
local ANIM_MINE = 2
local ANIM_WALK = 3
local ANIM_WALK_MINE = 4
local ANIM_SNEAK = 5

minetest.register_on_joinplayer(function ( pl )
	local name = pl:get_player_name()
	player_anim[name] = 0
	local prop = {
		mesh = "character_18.b3d",
		textures = {"character_18.png", },
		visual = "mesh",
		visual_size = {x=1, y=1},
	}
	pl:set_properties(prop)
end)

local bone_pos = {
	Body = {x=0,y=1,z=0};
	Head = {x=0,y=6.75,z=0};
	Arm_Left = {x=-3,y=6,z=0};
	Arm_Right = {x=3,y=6,z=0};
	Leg_Left = {x=-0.9,y=0,z=-0.3};
	Leg_Right = {x=0.9,y=0,z=0.3};
};

local BODY = "Body";
local HEAD = "Head";
local LARM = "Arm_Left";
local RARM = "Arm_Right";
local LLEG = "Leg_Left";
local RLEG = "Leg_Right";

local function rotbone ( player, bone, x, y, z )
	player:set_bone_position(bone, bone_pos[bone], { x=x, y=y, z=z });
end

local step = 0;
local FULL_STEP = 30;

local anims = {
	[ANIM_STAND] = function ( player )
		rotbone(player, BODY, 0, -18.6, 0);
		rotbone(player, LARM, 0, 0, 0);
		rotbone(player, RARM, 0, 0, 0);
		rotbone(player, LLEG, 180, -18.6, 0);
		rotbone(player, RLEG, 180, -18.6, 0);
	end;
	[ANIM_WALK] = function ( player )
		local m = step / FULL_STEP;
		local r = math.sin(m * math.rad(360));
		rotbone(player, LARM, r*-30, 2, -3);
		rotbone(player, RARM, r*30, 2, 3);
		rotbone(player, LLEG, r*30+180, -18.6, 0);
		rotbone(player, RLEG, r*-30+180, -18.6, 0);
	end;
	[ANIM_MINE] = function ( player )
		local m = step / FULL_STEP;
		local r = math.sin(m * math.rad(360));
		local look = math.deg(player:get_look_pitch());
		rotbone(player, LARM, 0, 0, 0);
		rotbone(player, RARM, r*15+100+look, -2, 0);
		rotbone(player, LLEG, 180, -18.6, 0);
		rotbone(player, RLEG, 180, -18.6, 0);
	end;
	[ANIM_WALK_MINE] = function ( player )
		local m = step / FULL_STEP;
		local r = math.sin(m * math.rad(360));
		local look = math.deg(player:get_look_pitch());
		rotbone(player, LARM, r*-30, 2, -3);
		rotbone(player, RARM, r*15+100+look, -2, 3);
		rotbone(player, LLEG, r*30+180, -18.6, 0);
		rotbone(player, RLEG, r*-30+180, -18.6, 0);
	end;
	[ANIM_SNEAK] = function ( player )
		rotbone(player, BODY, -10, -18.6, 0);
	end;
};

local function player_animate ( player, anim )
	rotbone(player,HEAD,math.deg(player:get_look_pitch()),0,0);
	step = 1+step;
	anims[anim](player);
end

minetest.register_globalstep(function ( dtime )
	for _, pl in pairs(minetest.get_connected_players()) do
		local name = pl:get_player_name()
		local controls = pl:get_player_control()
		local walking = false
		if controls.up or controls.down or controls.left or controls.right then
			walking = true
		end
		if walking and controls.LMB then
			if player_anim[name] ~= ANIM_WALK_MINE then
				player_anim[name] = ANIM_WALK_MINE
			end
		elseif walking and controls.RMB then
			if player_anim[name] ~= ANIM_WALK_MINE then
				player_anim[name] = ANIM_WALK_MINE
			end
		elseif walking then
			if player_anim[name] ~= ANIM_WALK then
				player_anim[name] = ANIM_WALK
			end
		elseif controls.LMB or controls.RMB then
			if player_anim[name] ~= ANIM_MINE then
				player_anim[name] = ANIM_MINE
			end
		elseif controls.sneak then
			if player_anim[name] ~= ANIM_SNEAK then
				player_anim[name] = ANIM_SNEAK
			end
		elseif player_anim[name] ~= ANIM_STAND then
			player_anim[name] = ANIM_STAND
		end
	player_animate(pl, player_anim[name])
	end
end);
