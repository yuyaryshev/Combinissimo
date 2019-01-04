function delete_entities(surface)
	for _, entity in pairs(surface.find_entities({{-1000, -1000},{1000, 1000}})) do
		entity.destroy()
	end
end

function add_tile_rect(tiles, tile_name, xmin, ymin, xmax, ymax) -- tiles is rw
	local i = #tiles
	for x = xmin, xmax-1 do
		for y = ymin, ymax-1 do
			i = i + 1
			tiles[i] = {name = tile_name, position={x, y}}
		end
	end
end

function create_surface(factory, layout)
-- from factorissimo
	local surface_name = "Inside factory " .. factory.unit_number
	local surface = game.create_surface(surface_name, {width = 64*layout.chunk_radius-62, height = 64*layout.chunk_radius-62})
	surface.request_to_generate_chunks({0, 0}, layout.chunk_radius)
	global["factory-surface"][factory.unit_number] = surface -- surface_name
	global["surface-structure"][surface_name] = {parent = factory, ticks = 0, connections = {}, chunks_generated = 0, chunks_required = 4*layout.chunk_radius*layout.chunk_radius, finished = false}
	global["surface-layout"][surface_name] = layout.name
	global["surface-exit"][surface_name] = {x = factory.position.x+layout.exit_x, y = factory.position.y+layout.exit_y, surface = factory.surface}
	reset_daytime(surface)
end

script.on_event(defines.events.on_chunk_generated, function(event)
-- from factorissimo
	if is_factory(event.surface) then
		local structure = get_structure(event.surface)
		structure.chunks_generated = structure.chunks_generated + 1 -- Wait until all chunks are generated and then some, to avoid other mods' worldgen interfering
	end
end)

function get_surface(factory)
-- from factorissimo
	return global["factory-surface"][factory.unit_number]
end

local function on_tick_handler()
	-- from factorissimo
	if structure.parent and structure.parent.valid and structure.chunks_generated == structure.chunks_required then
		-- We need to wait until the factory interior surface is generated with default worldgen, then replace it with our own interior
		local surface = get_surface(structure.parent)
		local layout = get_layout(surface)
		build_factory_interior(structure.parent, surface, layout, structure)
		-- This can theoretically be called repeatedly each tick until the factory is marked finished
		if structure.finished then
			-- Check connections once the factory is finished
			mark_connections_dirty(structure.parent)
		end
	end
end

function build_factory_interior(factory, surface, layout, structure)
	-- from factorissimo
	delete_entities(surface)
	tiles = {}
	for _, pconn in pairs(layout.possible_connections) do
		add_tile_rect(tiles, "factory-wall", pconn.inside_x-1, pconn.inside_y-1, pconn.inside_x+2, pconn.inside_y+2)
	end
	for _, rect in pairs(layout.rectangles) do
		add_tile_rect(tiles, rect.tile, rect.x1, rect.y1, rect.x2, rect.y2)
	end
	for _, pconn in pairs(layout.possible_connections) do
		add_tile_rect(tiles, "factory-entrance", pconn.inside_x, pconn.inside_y, pconn.inside_x+1, pconn.inside_y+1)
	end
	surface.set_tiles(tiles)
	if layout.is_power_plant then
		place_entity_generated(surface, "factory-power-receiver", layout.provider_x, layout.provider_y, "power_provider")
	else
		place_entity_generated(surface, "factory-power-provider", layout.provider_x, layout.provider_y, "power_provider")
	end
	place_entity_generated(surface, "factory-power-distributor", layout.distributor_x, layout.distributor_y)
	structure.finished = true
end


local function make_surface()

	-- from factorissimo
	player.teleport({layout.entrance_x, layout.entrance_y}, new_surface)
end

local function make_wire(input_entity, output_entity, color)
	local input_index = 1
	if input_entity.name == "decider-combinator" or input_entity.name == "arithmetic-combinator" then
		input_index = 2
	end
	input_entity.connect_neighbour({
		wire = color,
		target_entity = output_entity,
		source_circuit_id = input_index,
		target_circuit_id = 1,
		})
end

local function make_entity(context, combinator_type)
--	local context = 
--		{
--		 position = {0,0}
--		,player = game.players[1]
--		,force = game.players[1].force
--		}
	local prefix = ""

	if combinator_type == "d" then		-- decider
		local c3 = surface.create_entity({
				name = prefix.."decider-combinator",
				position = context.position,
				force = context.force,
				})

		c3.get_control_behavior().parameters = {parameters={
			 first_signal = {type="virtual",name="signal-red"}
			,constant = 10
			,comparator = ">"
			,output_signal = {type="virtual",name="signal-blue"}
			,copy_count_from_input = false
			}}
			
		local c4 = surface.create_entity({
				name = prefix.."decider-combinator",
				position = context.position,
				force = context.force,
				})
		c4.get_control_behavior().parameters = {parameters={
			 first_signal = {type="virtual",name="signal-red"}
			,constant = 12
			,comparator = ">"
			,output_signal = {type="virtual",name="signal-yellow"}
			,copy_count_from_input = false
			}}
	
	elseif combinator_type == "a" then	-- arithmetic
		local c2 = surface.create_entity({
				name = prefix.."arithmetic-combinator",
				position = test_positions[2],
				force = player.force,
				})
		c2.get_control_behavior().parameters = {parameters={
			 first_signal = {type="virtual",name="signal-green"}
	--		,second_signal = {type="virtual",name="signal-green"}
			,second_constant = 3
			,operation = "+"
			,output_signal = {type="virtual",name="signal-red"}
			}}
			
	elseif combinator_type == "c" then  -- constant
		local c1 = surface.create_entity({
				name = prefix.."constant-combinator",
				position = test_positions[1],
				force = player.force,
				})
		c1.get_control_behavior().parameters = {parameters={{index = 1, signal = {type="virtual",name="signal-green"}, count = 15 }}}
	elseif combinator_type == "s" then  -- power-switch
	end
			
			
			
			
	
			
		
	c1.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = c2,
		source_circuit_id = 1,
		target_circuit_id = 1,
		})
	
	c1.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = poles[1],
		source_circuit_id = 1,
		target_circuit_id = 1,
		})
			
	
	c2.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = c3,
		source_circuit_id = 2,
		target_circuit_id = 1,
		})
	
	c2.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = poles[2],
		source_circuit_id = 2,
		target_circuit_id = 1,
		})
	
	c3.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = poles[3],
		source_circuit_id = 2,
		target_circuit_id = 1,
		})
	
	c2.connect_neighbour({
		wire = defines.wire_type.green,
		target_entity = c4,
		source_circuit_id = 2,
		target_circuit_id = 1,
		})
		
	c4.connect_neighbour({
		wire = defines.wire_type.red,
		target_entity = poles[4],
		source_circuit_id = 2,
		target_circuit_id = 1,
		})		
end


script.on_event(defines.events.on_chunk_generated, function(event)
	if is_factory(event.surface) then
		local structure = get_structure(event.surface)
		structure.chunks_generated = structure.chunks_generated + 1 -- Wait until all chunks are generated and then some, to avoid other mods' worldgen interfering
	end
end)



function try_enter_factory(player)
	local factory = get_factory_beneath(player)
	if factory and math.abs(factory.position.x-player.position.x) < 0.6 then
		local new_surface = get_surface(factory)
		if new_surface and factory_placement_valid(new_surface, factory.surface) then
			local structure = get_structure(new_surface)
				if structure.finished then
					local layout = get_layout(new_surface)
					reset_daytime(new_surface)
					player.teleport({layout.entrance_x, layout.entrance_y}, new_surface)
					return
				end
		end
	end
end

function try_leave_factory(player)
	local exit_building = get_exit_beneath(player)
	if exit_building then
		local exit_pos = get_exit(player.surface)
		if exit_pos then
			player.teleport({exit_pos.x, exit_pos.y}, exit_pos.surface)
			return
		end
	end
end





