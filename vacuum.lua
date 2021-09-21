--[[

	Tubelib Tweaks
	================


	AGPL v2.1
	See LICENSE.txt for more information

	vacuum.lua

	A high performance Vacuum
	This is nearly entirely borrowed from tubelib_addons1 and tubelib_addons3 funnels
	Code has only been slightly modified to get entities from below the source and a wider radius

]]--

-- Load support for I18n
local S = tubelib_tweaks.S

local dist1 = 1.5	-- 3x3x3 = 1.5
local dist2 = 3.5	-- 7x7x7 = 3.5
local interval = 2	-- seconds between scans

-- calculate sperical radius from center of vacuum point to furthest corner
local radius1 = math.sqrt((((dist1 * 2) + 0.5) ^ 2) * 3)
local radius2 = math.sqrt((((dist2 * 2) + 0.5) ^ 2) * 3)


local function formspec()
	return "size[9,7]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[context;main;0.5,0;8,2;]"..
	"list[current_player;main;0.5,3.3;8,4;]"..
	"listring[context;main]"..
	"listring[current_player;main]"
end

local function scan_for_objects(pos, dist, radius)
	local meta = minetest.get_meta(pos)
	pos.y = pos.y - 0.5 - dist
	local ot = minetest.get_objects_inside_radius(pos, radius)
	for i = 1, #ot do
		local lua_entity = ot[i]:get_luaentity()
		if lua_entity and
					lua_entity.name == "__builtin:item" and
					lua_entity.itemstring ~= "" and
					not ot[i]:is_player() then
			local p = ot[i]:getpos()
			if math.abs(pos.y - p.y) <= dist and
				math.abs(pos.x - p.x) <= dist and
				math.abs(pos.z - p.z) <= dist then
				if tubelib.put_item(meta, "main", lua_entity.itemstring) then
					lua_entity.itemstring = ""
					ot[i]:remove()
				end
			end

		end
	end
	return true
end

minetest.register_node("tubelib_tweaks:vacuum", {
	description = S("Tubelib Vacuum"),
	tiles = {
		-- up, down, right, left, back, front
		'tubelib_addons1_funnel_top.png',
		'tubelib_addons1_funnel_top.png',
		'tubelib_addons1_funnel.png^[transform2',
	},

	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16,  8/16, 8/16, -6/16},
			{-8/16, -8/16,  6/16,  8/16, 8/16,  8/16},
			{-8/16, -8/16, -8/16, -6/16, 8/16,  8/16},
			{ 6/16, -8/16, -8/16,  8/16, 8/16,  8/16},
			{-6/16, -4/16, -6/16,  6/16, 8/16,  6/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-8/16, -8/16, -8/16,   8/16, 8/16, 8/16},
	},

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 16)
	end,

	after_place_node = function(pos, placer)
		tubelib.add_node(pos, "tubelib_tweaks:vacuum")
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec())
		minetest.get_node_timer(pos):start(interval)
	end,

	on_timer = function(pos, elapsed) return scan_for_objects(pos, dist1, radius1) end,
	on_rotate = screwdriver.disallow,

	can_dig = function(pos, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return false
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		tubelib.remove_node(pos)
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		minetest.log("action", player:get_player_name().." moves "..stack:get_name()..
				" to vacuum at "..minetest.pos_to_string(pos))
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		minetest.log("action", player:get_player_name().." takes "..stack:get_name()..
				" from vacuum at "..minetest.pos_to_string(pos))
		return stack:get_count()
	end,

	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {choppy=2, cracky=2, crumbly=2},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("tubelib_tweaks:vacuum2", {
	description = S("HighPerf Vacuum"),
	tiles = {
		-- up, down, right, left, back, front
		'tubelib_addons1_funnel_top.png^tubelib_addons3_node_frame4.png',
		'tubelib_addons1_funnel_top.png^tubelib_addons3_node_frame4.png',
		'tubelib_addons1_funnel.png^[transform2^tubelib_addons3_node_frame4.png',
	},

	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16,  8/16, 8/16, -6/16},
			{-8/16, -8/16,  6/16,  8/16, 8/16,  8/16},
			{-8/16, -8/16, -8/16, -6/16, 8/16,  8/16},
			{ 6/16, -8/16, -8/16,  8/16, 8/16,  8/16},
			{-6/16, -4/16, -6/16,  6/16, 8/16,  6/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-8/16, -8/16, -8/16,   8/16, 8/16, 8/16},
	},

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 16)
	end,

	after_place_node = function(pos, placer)
		tubelib.add_node(pos, "tubelib_tweaks:vacuum2")
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec())
	end,

	on_timer = function(pos, elapsed) return scan_for_objects(pos, dist2, radius2) end,
	on_rotate = screwdriver.disallow,

	can_dig = function(pos, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return false
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		tubelib.remove_node(pos)
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		minetest.log("action", player:get_player_name().." moves "..stack:get_name()..
				" to HighPerf vacuum at "..minetest.pos_to_string(pos))
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		minetest.log("action", player:get_player_name().." takes "..stack:get_name()..
				" from HighPerf vacuum at "..minetest.pos_to_string(pos))
		return stack:get_count()
	end,

	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {choppy=2, cracky=2, crumbly=2},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_craft({
	output = "tubelib_tweaks:vacuum2",
	recipe = {
		{"default:tin_ingot", "tubelib_tweaks:vacuum", ""},
		{"tubelib_tweaks:vacuum", "default:gold_ingot", ""},
		{"", "", ""},
	},
})

minetest.register_craft({
	output = "tubelib_tweaks:vacuum 2",
	recipe = {
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"", "default:mese_crystal",	""},
		{"group:wood", "tubelib:tubeS", "group:wood"},
	},
})


tubelib.register_node("tubelib_tweaks:vacuum", {"tubelib_tweaks:vacuum2"}, {
	invalid_sides = {"D"},
	on_pull_stack = function(pos, side)
		local meta = minetest.get_meta(pos)
		return tubelib.get_stack(meta, "main")
	end,
	on_pull_item = function(pos, side)
		local meta = minetest.get_meta(pos)
		return tubelib.get_item(meta, "main")
	end,
	on_unpull_item = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "main", item)
	end,

	on_recv_message = function(pos, topic, payload)
		if topic == "state" then
			local meta = minetest.get_meta(pos)
			return tubelib.get_inv_state(meta, "main")
		else
			return "unsupported"
		end
	end,
	on_node_load = function(pos)
		minetest.get_node_timer(pos):start(interval)
	end,

})


