-- override tubelib registered legacy_nodes
tubelib.NodeDef["default:chest"].on_pull_stack = function(pos, side)
	local meta = minetest.get_meta(pos)
	return tubelib.get_stack(meta, "main")
end


tubelib.NodeDef["default:chest_locked"].on_pull_stack = function(pos, side, player_name)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	if player_name == owner or player_name == "" then
		return tubelib.get_stack(meta, "main")
	end
	return nil
end

tubelib.NodeDef["default:furnace"].on_pull_stack = function(pos, side)
	local meta = minetest.get_meta(pos)
	return tubelib.get_stack(meta, "dst")
end

tubelib.NodeDef["shop:shop"].on_pull_stack = function(pos, side, player_name)
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")
	if player_name == owner or player_name == "" then
		return tubelib.get_stack(meta, "register")
	end
	return nil
end

tubelib.NodeDef["signs_bot:box"].on_pull_stack = function(pos, side)
	local meta = minetest.get_meta(pos)
	return tubelib.get_stack(meta, "main")
end

tubelib.NodeDef["signs_bot:chest"].on_pull_stack = function(pos, side)
	local meta = minetest.get_meta(pos)
	return tubelib.get_stack(meta, "main")
end


-- override gravelsieve
if tubelib.NodeDef["gravelsieve:auto_sieve3"] then
	tubelib.NodeDef["gravelsieve:auto_sieve3"].on_pull_stack = function(pos, side)
		local meta = minetest.get_meta(pos)
		return tubelib.get_stack(meta, "dst")
	end
end

-- override quarry
if tubelib.NodeDef["tubelib_addons1:quarry"] then
	tubelib.NodeDef["tubelib_addons1:quarry"].on_pull_stack = function(pos, side)
		return tubelib.get_stack(M(pos), "main")
	end
end

-- override Fermenter
if tubelib.NodeDef["tubelib_addons1:fermenter"] then
	tubelib.NodeDef["tubelib_addons1:fermenter"].on_pull_stack = function(pos, side)
		return tubelib.get_stack(M(pos), "dst")
	end
end

-- override Reformer
if tubelib.NodeDef["tubelib_addons1:reformer"] then
	tubelib.NodeDef["tubelib_addons1:reformer"].on_pull_item = function(pos, side)
		return tubelib.get_item(M(pos), "dst")
	end
end

-- override HP Distributor (source inventory)
if tubelib.NodeDef["tubelib_addons3:distributor"] then
	tubelib.NodeDef["tubelib_addons3:distributor"].on_pull_item = function(pos, side)
		return tubelib.get_item(M(pos), "src")
	end
end
