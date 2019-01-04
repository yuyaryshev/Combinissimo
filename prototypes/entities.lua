local invisible_combinator = copyPrototype("programmable-speaker", "programmable-speaker", "combinissimo")
	invisible_combinator.icon = MOD_NAME.."/graphics/combinissimo-item.png"
	invisible_combinator.icon_size = 32
	invisible_combinator.energy_usage_per_tick = "1kW"
	invisible_combinator.sprite = 
	{
      layers =
      {
		{
			filename = MOD_NAME.."/graphics/combinissimo-entity.png",
			x = 158,
			y = 5,
			width = 79,
			height = 63,
			frame_count = 1,
			shift = {0.140625, 0.140625},
		},	
		}
	}
	

local invisible_combinator_input = copyPrototype("programmable-speaker", "programmable-speaker", "combinissimo-input")
	invisible_combinator_input.energy_usage_per_tick = "1W"
	invisible_combinator_input.icon = MOD_NAME.."/graphics/combinissimo-input-item.png"
	invisible_combinator_input.icon_size = 32
	invisible_combinator_input.sprite =
		{
		  layers =
		  {
			{
			  filename = MOD_NAME.."/graphics/combinissimo-input-entity.png",
			  priority = "extra-high",
			  width = 30,
			  height = 89,
			  shift = util.by_pixel(-2, -39.5),
			  hr_version = {
				filename = MOD_NAME.."/graphics/hr-combinissimo-input-entity.png",
				priority = "extra-high",
				width = 59,
				height = 178,
				shift = util.by_pixel(-2.25, -39.5),
				scale = 0.5,
			  }
			},
			{
			  filename = MOD_NAME.."/graphics/combinissimo-input-entity-shadow.png",
			  priority = "extra-high",
			  width = 119,
			  height = 25,
			  shift = util.by_pixel(52.5, -2.5),
			  draw_as_shadow = true,
			  hr_version = {
				filename = MOD_NAME.."/graphics/hr-combinissimo-input-entity.png",
				priority = "extra-high",
				width = 237,
				height = 50,
				shift = util.by_pixel(52.75, -3),
				draw_as_shadow = true,
				scale = 0.5,
			  }
			}
		  }
		}

local invisible_combinator_output = copyPrototype("constant-combinator", "constant-combinator", "combinissimo-output")
	invisible_combinator_output.icon = MOD_NAME.."/graphics/combinissimo-output-item.png"
	invisible_combinator_output.icon_size = 32
	invisible_combinator_output.sprites = 
		{
		  north =
		  {
			filename = MOD_NAME.."/graphics/combinissimo-output-entity.png",
			x = 158,
			y = 5,
			width = 79,
			height = 63,
			frame_count = 1,
			shift = {0.140625, 0.140625},
		  },
		  east =
		  {
			filename = MOD_NAME.."/graphics/combinissimo-output-entity.png",
			y = 5,
			width = 79,
			height = 63,
			frame_count = 1,
			shift = {0.140625, 0.140625},
		  },
		  south =
		  {
			filename = MOD_NAME.."/graphics/combinissimo-output-entity.png",
			x = 237,
			y = 5,
			width = 79,
			height = 63,
			frame_count = 1,
			shift = {0.140625, 0.140625},
		  },
		  west =
		  {
			filename = MOD_NAME.."/graphics/combinissimo-output-entity.png",
			x = 79,
			y = 5,
			width = 79,
			height = 63,
			frame_count = 1,
			shift = {0.140625, 0.140625},
		  }
		}

data:extend({invisible_combinator, invisible_combinator_input, invisible_combinator_output})

local function make_sprite_empty(lua_table)
	lua_table.filename = MOD_NAME.."/graphics/empty.png"
	lua_table.x = 0
	lua_table.width = 1
	lua_table.height = 1
	lua_table.shift = util.by_pixel(0, 0)
	if lua_table.hr_version then
		lua_table.hr_version.scale = 0
		lua_table.hr_version.filename = MOD_NAME.."/graphics/empty.png"
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
						make_sprite_empty(lua_table[key])
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

local invisible_constant_combinator = copyPrototype("constant-combinator", "constant-combinator", "invisible-constant-combinator")
	make_invisible(invisible_constant_combinator)

local invisible_decider_combinator = copyPrototype("decider-combinator", "decider-combinator", "invisible-decider-combinator")
	make_invisible(invisible_decider_combinator)
	
local invisible_arithmetic_combinator = copyPrototype("arithmetic-combinator", "arithmetic-combinator", "invisible-arithmetic-combinator")
	make_invisible(invisible_arithmetic_combinator)
		

--for _, entity in ipairs(data) do
--	-- entity.icon = empty
--		e
--	    entity.collision_mask = {"doodad-layer"},
--
--end


-- Power supply for editor surface
local invisible_power_distributor = copyPrototype("electric-pole", "substation", "invisible-power-distributor")
	make_invisible(invisible_power_distributor,1)
	invisible_power_distributor.supply_area_distance = 64 -- 64 is hard limit

local invisible_power_provider = copyPrototype("solar-panel", "solar-panel", "invisible-power-provider")
	make_invisible(invisible_power_provider)
	invisible_power_provider.production = "1000GW"

local invisible_entities = 
	{
	invisible_constant_combinator, 
	invisible_decider_combinator, 
	invisible_arithmetic_combinator,
	invisible_power_distributor,
	invisible_power_provider,
	}		

data:extend(invisible_entities)

--------
--local invisible_combinator = copyPrototype("item", "constant-combinator", "combinissimo")
--	invisible_combinator_input.icon = MOD_NAME.."/graphics/combinissimo-item.png"
--
--local invisible_combinator_output = copyPrototype("item", "constant-combinator", "combinissimo-input")
--	invisible_combinator_input.icon = MOD_NAME.."/graphics/combinissimo-input-item.png"
--	
--local invisible_combinator_output = copyPrototype("item", "constant-combinator", "combinissimo-output")
--	invisible_combinator_input.icon = MOD_NAME.."/graphics/combinissimo-output-item.png"
--------


--addTechnologyUnlocksRecipe("circuit-network","combinissimo")
--addTechnologyUnlocksRecipe("circuit-network","combinissimo-input")
--addTechnologyUnlocksRecipe("circuit-network","combinissimo-output")



