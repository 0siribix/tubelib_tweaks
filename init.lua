#Tubelib Tweaks


curFolder = minetest.get_modpath(minetest.get_current_modname())

-- override the tubelib.put_item function
function tubelib.put_item(meta, listname, item, refill)
	if meta == nil or meta.get_inventory == nil then return false end
	local inv = meta:get_inventory()
	if refill then
		local leftover = inv:add_item(listname, item)
		if leftover:get_count() == 0 then
			return true
		else
			item:set_count(leftover:get_count())
		end
	else
		if inv:room_for_item(listname, item) then
			inv:add_item(listname, item)
			return true
		end
	end
	return false
end


if minetest.setting_get("tubelib_techpack_refill") ~= "false" then
	tubelib.refill = true
	dofile(curFolder .. "/1_techpack_refill.lua")
end

if minetest.setting_get("tubelib_techpack_HP") ~= "false" then
	dofile(curFolder .. "/2_techpack_HP.lua")
end
