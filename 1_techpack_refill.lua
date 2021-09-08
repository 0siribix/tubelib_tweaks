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

tubelib.NodeDef["default:furnace"].on_push_item = function(pos, side, item)
	local meta = minetest.get_meta(pos)
	minetest.get_node_timer(pos):start(1.0)
	if minetest.get_craft_result({method="fuel", width=1, items={item}}).time ~= 0 then
		return tubelib.put_item(meta, "fuel", item, tubelib.refill)
	else
		return tubelib.put_item(meta, "src", item, tubelib.refill)
	end
end

tubelib.NodeDef["shop:shop"].on_push_item = function(pos, side, item, player_name)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	if player_name == owner or player_name == "" then
		return tubelib.put_item(meta, "stock", item, tubelib.refill)
	end
	return false
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

