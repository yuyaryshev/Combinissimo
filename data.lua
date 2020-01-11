require ("mod_name")
require ("prototypes.utility")
require ("prototypes.styles")
require ("prototypes.technology")

local function hide_sprite(lua_table)
	lua_table.filename = MOD_NAME.."/graphics/empty/1.png"
	lua_table.x = 0
	lua_table.width = 1
	lua_table.height = 1
	lua_table.shift = util.by_pixel(0, 0)
	if lua_table.hr_version then
		lua_table.hr_version.scale = 0
		lua_table.hr_version.filename = MOD_NAME.."/graphics/empty/1.png"
		lua_table.hr_version.x = 0
		lua_table.hr_version.width = 1
		lua_table.hr_version.height = 1
		lua_table.hr_version.shift = util.by_pixel(0, 0)
	end
end



local function make_invisible(lua_table)
	if lua_table then
		local zero_point = {0.0,0.0}
		local empty_rect = {{0.0,0.0}, {0.0, 0.0}}
		local empty_sprite = 
		{
			filename = MOD_NAME.."/graphics/empty_1x1.png",
			x = 0,
			width = 1,
			height = 1,
			shift = util.by_pixel(0, 0),
			hr_version =
			{
			  scale = 0,
			  filename = MOD_NAME.."/graphics/empty_1x1.png",
			  x = 0,
			  width = 1,
			  height = 1,
			  shift = util.by_pixel(0, 0),
			},
		  }	

		for key, value in pairs(lua_table) do
			if value and type(value) == "table" then
				-- replace sprites
				if value["filename"] and string.find( value["filename"],".png") then
					if lua_table[key].direction_count then
						hide_sprite(lua_table[key])
					else
						lua_table[key] = empty_sprite
					end
				-- remove sounds, indicators, lights
				elseif key == "volume" or key == "intensity" then
					lua_table[key] = 0.0
					
				-- remove all boxes
				elseif 
						key == "input_connection_bounding_box" 
					or	key == "output_connection_bounding_box"
					or	key == "collision_box"
					or	key == "selection_box"
					or	key == "drawing_box"
					then 
					lua_table[key] = empty_rect

				-- move connection_points to zero point
				elseif key == "red" or key == "green" or key == "copper" then
					lua_table[key] = zero_point
					
				else
					-- recursively...
					make_invisible(value)
				end
			end
		end
	end
end


local function make(s1, s2, s3)
	local s = merge_tables(s1, s2, s3)
	
	if not s.new_name then error("ERROR make 'name' == nil") end
	if not s.source_type then error("ERROR make 'source_type' == nil") end
	if not s.source_name then error("ERROR make 'source_name' == nil") end
	if s.invisible then s.no_recipe = true end

	---------------------------- entity -----------------------------------------
	if not s.no_entity then
		if s.invisible then 
			s.width = 1 
			s.height = 1 
		end
		
		local entity = copyPrototype(s)
		if s.width or s.height then
			if not s.width then error("ERROR make 'width' == nil") end
			if not s.height then error("ERROR make 'height' == nil") end
			
			entity.icon = MOD_NAME.."/graphics/"..s.new_name.."/item.png"
			entity.icon_size = 32
			entity.energy_usage_per_tick = "1kW"
			entity.sprite = 
			{
			  layers =
			  {
				{
					filename = MOD_NAME.."/graphics/"..s.new_name.."/entity.png",
					x = s.x or 0,
					y = s.y or 0,
					width = s.width,
					height = s.height,
					frame_count = 1,
					shift = s.shift or 0, 
				},	
				}
			}
		end
		
		if s.supply_area_distance then
			entity.supply_area_distance = s.supply_area_distance
		end
			
		if s.production then
			entity.production = s.production
		end
			
		if s.invisible then
			make_invisible(entity,1)
		end
		
		if s.inner then	
			if entity.circuit_wire_max_distance then entity.circuit_wire_max_distance = 64 end
			if entity.wire_max_distance then entity.wire_max_distance = 64 end
			if entity.supply_area_distance then entity.supply_area_distance = 64 end
		end
		
	--	entity.layers[1].tint = { r = 0.0, g = 10.0, b = 0.0, a = 1.0 }
	-- TODO - tint/или скопировать графику - зеленые - проверить, изменить
	-- TODO Нужен флаг который активирует эту "покраску"!
			
		data:extend({entity})
	end	
	
	---------------------------- recipe -----------------------------------------
	if s.ingredients and not s.no_recipe then
		local recipe = {
			type = "recipe",
			name = s.new_name,
			energy_required = s.energy_required or 0.01,
			enabled = true,
			ingredients = s.ingredients,
			result = s.new_name,
			normal = {
				ingredients = s.ingredients,
				result = s.new_name,
				},
			expensive = {
				ingredients = s.ingredients,
				result = s.new_name,
				},
		}
		data:extend({recipe})
	end
	
	
	---------------------------- item -----------------------------------------
	if not s.no_item then
		local item = copyPrototype(s, {source_type = "item", source_name = "constant-combinator"})
		item.name = "combinissimo-"..s.new_name
		item.icon = MOD_NAME.."/graphics/"..s.new_name.."-item.png"
		item.order = "b[combinators]-combinissimo-"..(s.order_name or s.new_name)
		item.place_result = s.new_name	
		
		data:extend({item})
	end
	---------------------------------------------------------------------------
end

local function makeInnerAndInvisible(s1, s2, s3)
	local s = merge_tables(s1,s2,s3)
	
	s.source_name = s.source_name or s.new_name 
	s.source_type = s.source_type or s.source_name
	
	
	make(s, {
		new_name = "inner-"..s.new_name,
	})
	
	make(s, {
		new_name = "invisible-"..s.new_name, 
		invisible = true,	
		no_recipe = true,
	})
end




--		-- Substation for editor surface
--		make({
--			source_type = "electric-pole", 
--			source_name = "substation", 
--			new_name = "power-distributor", 
--			invisible = true,
--			no_recipe = true,
--			supply_area_distance = 64, -- 64 is hard limit
--		})
--		
--		
--		
--		-- Power supply for editor surface
--		make({
--			source_type = "solar-panel", 
--			source_name = "solar-panel", 
--			new_name = "power-provider",
--			invisible = true,
--			no_recipe = true,
--			supply_area_distance = 64, -- 64 is hard limit
--		})




--		make({
--			source_type = "programmable-speaker", 
--			source_name = "programmable-speaker", 
--			new_name = "combonator_2x2",
--			x = 158,
--			y = 5,
--			width = 74,
--			height = 64,
--			shift = {0.140625, 0.140625},
--			-- shift = util.by_pixel(-2.25, -39.5),
--			energy_required = 0.15,
--			ingredients = {
--				{"iron-plate", 10},
--				{"copper-cable", 20},
--				{"electronic-circuit", 20},
--			},
--		}) 
--		
--		
--		make({	
--			source_type = "programmable-speaker", 
--			source_name = "programmable-speaker", 
--			new_name = "combonator_3x2",
--			x = 158,
--			y = 5,
--			width = 74,
--			height = 100,
--			shift = {0.140625, 0.140625},
--			-- shift = util.by_pixel(-2.25, -39.5),
--			energy_required = 0.15,
--			ingredients = {
--				{"iron-plate", 10},
--				{"copper-cable", 20},
--				{"electronic-circuit", 20},
--			},	
--		}) 
--		
--		make({
--			source_type = "programmable-speaker", 
--			source_name = "programmable-speaker", 
--			new_name = "combonator_3x3",
--			x = 158,
--			y = 5,
--			width = 100,
--			height = 100,
--			shift = {0.140625, 0.140625},
--			-- shift = util.by_pixel(-2.25, -39.5),
--			energy_required = 0.15,
--			ingredients = {
--				{"iron-plate", 10},
--				{"copper-cable", 20},
--				{"electronic-circuit", 20},
--			},	
--		})

--		makeInnerAndInvisible({
--			source_name = "small-electric-pole",
--			source_type = "electric-pole",
--			new_name = "connector",
--		})

--		makeInnerAndInvisible({
--			new_name = "constant-combinator",
--		})
--		
--		makeInnerAndInvisible({
--			new_name = "decider-combinator",
--		})
--		
--		makeInnerAndInvisible({
--			new_name = "arithmetic-combinator",
--		})
--		
--		makeInnerAndInvisible({
--			new_name = "programmable-speaker",
--		})















--			-- TODO BELOW 
--			make_item("mark",		"mark-constant-combinator"			)
--			---------------------------------------
--			-- TODO BELOW
--			---------------------------------------
--			
--			local invisible_combinator_input = copyPrototype("pole", "pole", "combinissimo-connector")
--				invisible_combinator_input.energy_usage_per_tick = "1W"
--				invisible_combinator_input.icon = MOD_NAME.."/graphics/connector/item.png"
--				invisible_combinator_input.icon_size = 32
--				invisible_combinator_input.sprite =
--					{
--					  layers =
--					  {
--						{
--						  filename = MOD_NAME.."/graphics/combinissimo-input-entity.png",
--						  priority = "extra-high",
--						  width = 30,
--						  height = 89,
--						  shift = util.by_pixel(-2, -39.5),
--						  hr_version = {
--							filename = MOD_NAME.."/graphics/hr-combinissimo-input-entity.png",
--							priority = "extra-high",
--							width = 59,
--							height = 178,
--							shift = util.by_pixel(-2.25, -39.5),
--							scale = 0.5,
--						  }
--						},
--						{
--						  filename = MOD_NAME.."/graphics/combinissimo-input-entity-shadow.png",
--						  priority = "extra-high",
--						  width = 119,
--						  height = 25,
--						  shift = util.by_pixel(52.5, -2.5),
--						  draw_as_shadow = true,
--						  hr_version = {
--							filename = MOD_NAME.."/graphics/hr-combinissimo-input-entity.png",
--							priority = "extra-high",
--							width = 237,
--							height = 50,
--							shift = util.by_pixel(52.75, -3),
--							draw_as_shadow = true,
--							scale = 0.5,
--						  }
--						}
--					  }
--					}
--			
--			data:extend({invisible_combinator, invisible_combinator_input, invisible_combinator_output})
