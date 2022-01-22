-- override tubelib registered legacy_nodes
tubelib.NodeDef["default:chest"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	return tubelib.put_item(meta, "main", item, tubelib.refill)
end

tubelib.NodeDef["default:chest_locked"].on_push_item = function(pos, side, item, player_name)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	if player_name == owner or player_name == "" then
		return tubelib.put_item(meta, "main", item, tubelib.refill)
	end
	return false
end

-- Needed for new furnace funtion
local function is_source(pos,meta,  item)
	local inv = minetest.get_inventory({type="node", pos=pos})
	local name = item:get_name()
	if meta:get_string("src_item") == name then
		return true
	elseif inv:get_stack("src", 1):get_name() == name then
		meta:set_string("src_item", name)
		return true
	end
	return false
end

tubelib.NodeDef["default:furnace"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	minetest.get_node_timer(pos):start(1.0)
	if (side == "D") or (side ~= "U" and minetest.get_craft_result({method="fuel", width=1, items={item}}).time ~= 0) then
		return tubelib.put_item(meta, "fuel", item, tubelib.refill)
	else
		return tubelib.put_item(meta, "src", item, tubelib.refill)
	end
end

tubelib.NodeDef["shop:shop"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	minetest.get_node_timer(pos):start(1.0)
	if is_source(pos, meta, item) then
		return tubelib.put_item(meta, "src", item, tubelib.refill)
	elseif minetest.get_craft_result({method="fuel", width=1, items={item}}).time ~= 0 then
		return tubelib.put_item(meta, "fuel", itemtubelib.refill)
	else
		return tubelib.put_item(meta, "src", item, tubelib.refill)
	end
end


tubelib.NodeDef["signs_bot:box"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	return tubelib.put_item(meta, "main", item, tubelib.refill)
end

tubelib.NodeDef["signs_bot:chest"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	return tubelib.put_item(meta, "main", item, tubelib.refill)
end


-- override gravelsieve
local STEP_DELAY
if minetest.setting_get then
	STEP_DELAY = tonumber(minetest.setting_get("gravelsieve_step_delay")) or 1.0
else
	STEP_DELAY = tonumber(minetest.settings:get("gravelsieve_step_delay")) or 1.0
end

if tubelib.NodeDef["gravelsieve:auto_sieve3"] then
	tubelib.NodeDef["gravelsieve:auto_sieve3"].on_push_item = function(pos, side, item)
		minetest.get_node_timer(pos):start(STEP_DELAY)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "src", item, tubelib.refill)
	end
end

-- override quarry
if tubelib.NodeDef["tubelib_addons1:quarry"] then
	tubelib.NodeDef["tubelib_addons1:quarry"].on_push_item = function(pos, side, item)
		if not tubelib.is_fuel(item) then
			return false
		end
		return tubelib.put_item(minetest.get_meta(pos), "fuel", item, tubelib.refill)
	end
end

-- override autocrafter
if tubelib.NodeDef["tubelib_addons1:autocrafter"] then
	tubelib.NodeDef["tubelib_addons1:autocrafter"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override Tubelib Protected Chest
if tubelib.NodeDef["tubelib_addons1:chest"] then
	tubelib.NodeDef["tubelib_addons1:chest"].on_push_item = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "main", item, tubelib.refill)
	end
end

-- override Fermenter
if tubelib.NodeDef["tubelib_addons1:fermenter"] then
	tubelib.NodeDef["tubelib_addons1:fermenter"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override Grinder
if tubelib.NodeDef["tubelib_addons1:grinder"] then
	tubelib.NodeDef["tubelib_addons1:grinder"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override Harvester
if tubelib.NodeDef["tubelib_addons1:harvester_base"] then
	tubelib.NodeDef["tubelib_addons1:harvester_base"].on_push_item = function(pos, side, item)
		if not tubelib.is_fuel(item) then
			return false
		end
		return tubelib.put_item(minetest.get_meta(pos), "fuel", item, tubelib.refill)
	end
end

-- override Liquid Sampler
if tubelib.NodeDef["tubelib_addons1:liquidsampler"] then
	tubelib.NodeDef["tubelib_addons1:liquidsampler"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override Reformer
if tubelib.NodeDef["tubelib_addons1:reformer"] then
	tubelib.NodeDef["tubelib_addons1:reformer"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override HP Chest
if tubelib.NodeDef["tubelib_addons3:chest"] then
	tubelib.NodeDef["tubelib_addons3:chest"].on_push_item = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "main", item, tubelib.refill)
	end
end

-- override Chest Cart
if tubelib.NodeDef["tubelib_addons3:chest_cart"] then
	tubelib.NodeDef["tubelib_addons3:chest_cart"].on_push_item = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		return tubelib.put_item(meta, "main", item, tubelib.refill)
	end
end

-- override HP Distributor
if tubelib.NodeDef["tubelib_addons3:distributor"] then
	tubelib.NodeDef["tubelib_addons3:distributor"].on_push_item = function(pos, side, item)
		return tubelib.put_item(minetest.get_meta(pos), "src", item, tubelib.refill)
	end
end

-- override Pushing Chest
local Cache = {}

local function set_state(meta, state)
	local number = meta:get_string("number")
	meta:set_string("infotext", S("HighPerf Pushing Chest").." "..number..": "..state)
	meta:set_string("state", state)
end

local function configured(meta, item)
	local inv = meta:get_inventory()
	local number = meta:get_string("number")
	if not Cache[number] then
		Cache[number] = {}
		for _,items in ipairs(inv:get_list("main")) do
			Cache[number][items:get_name()] = true
		end
	end
	return Cache[number][item:get_name()] == true
end

if tubelib.NodeDef["tubelib_addons3:pushing_chest"] then
	tubelib.NodeDef["tubelib_addons3:pushing_chest"].on_push_item = function(pos, side, item)
		local meta = minetest.get_meta(pos)
		if configured(meta, item) then
			if tubelib.put_item(meta, "main", item, tubelib.refill) then
				set_state(meta, "loaded")
				return true
			else
				set_state(meta, "full")
				return tubelib.put_item(meta, "shift", item, tubelib.refill)
			end
		else
			return tubelib.put_item(meta, "shift", item, tubelib.refill)
		end
	end

	local AGING_LEVEL1 = 50 * tubelib.machine_aging_value
	local AGING_LEVEL2 = 150 * tubelib.machine_aging_value

	minetest.override_item("tubelib_addons3:pushing_chest", {on_timer = function(pos, _)
		if tubelib.data_not_corrupted(pos) then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if not inv:is_empty("shift") then
				local number = meta:get_string("number")
				local player_name = meta:get_string("player_name")
				local offs = meta:get_int("offs")
				meta:set_int("offs", offs + 1)
				for i = 0,7 do
					local idx = ((i + offs) % 8) + 1
					local stack = inv:get_stack("shift", idx)
					local count = stack:get_count()
					if count > 0 then
						if tubelib.push_items(pos, "R", stack, player_name) then
							inv:set_stack("shift", idx, ItemStack(""))
							local cnt = meta:get_int("tubelib_aging") + 1
							meta:set_int("tubelib_aging", cnt)
							if cnt > AGING_LEVEL1 and math.random(AGING_LEVEL2) == 1 then
								minetest.get_node_timer(pos):stop()
								local node = minetest.get_node(pos)
								node.name = "tubelib_addons3:pushing_chest_defect"
								minetest.swap_node(pos, node)
							end
							return true
						else
							-- Complete stack rejected
							if count == stack:get_count() then
								set_state(meta, "blocked")
							else
								inv:set_stack("shift", idx, stack)
							end
						end
					end
				end
			end
			return true
		end
		return false
	end})
end
