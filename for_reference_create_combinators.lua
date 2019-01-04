local ic = nil

script.on_init(function()
	local old_version, new_version = nil
	local new_version_str = game.active_mods[MOD_NAME]
	if new_version_str then
		new_version = string.format("%02d.%02d.%02d", string.match(new_version_str, "(%d+).(%d+).(%d+)"))
	end
	
	ic = global.programmable_combinator
	if not ic.queues then
		ic.queues = {{},{},{},{},{},{},{},{}}
	end
end)

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

function lo_assert(condition)
	if not condition then
		game.players[1].print("Assertion failed!")
	end
end


function on_tick_handler(event)
	local surface = game.surfaces.nauvis
	local player = game.players[1]
	local entities = surface.find_entities({{-100, -100},{100, 100}} )
	
	for _,entity in pairs(entities) do
		if entity.name == "medium-electric-pole" then
			return
		end
	end

	for _,entity in pairs(entities) do
		if not(entity.name == "player") then
			player.print("entity.name="..entity.name)
			entity.destroy()
		end
	end
	
	player.print("Creating test")


	surface.create_entity({
		name = "solar-panel",
		position = {-3,0},
		force = player.force,
		})

	
	local poles = {
	surface.create_entity({
		name = "medium-electric-pole",
		position = {0,0},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {3,0},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {6,0},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {9,0},
		force = player.force,
		}),
		




	surface.create_entity({
		name = "medium-electric-pole",
		position = {0,8},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {3,8},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {6,8},
		force = player.force,
		}),
		
	surface.create_entity({
		name = "medium-electric-pole",
		position = {9,8},
		force = player.force,
		}),		
	}
	
	local test_positions = {{0,2},{3,2},{6,2},{9,2}}
	local prefix = ""
	local do_test = 0
	
	if do_test then
		prefix = "invisible-"
		test_positions = {{3,2},{3,2},{3,2},{3,2}}
	end
	
	local c1 = surface.create_entity({
			name = test_prefix.."constant-combinator",
			position = test_positions[1],
			force = player.force,
			})
	c1.get_control_behavior().parameters = {parameters={{index = 1, signal = {type="virtual",name="signal-green"}, count = 15 }}}
			
			
	local c2 = surface.create_entity({
			name = test_prefix.."arithmetic-combinator",
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
			
			
	local c3 = surface.create_entity({
			name = test_prefix.."decider-combinator",
			position = test_positions[3],
			force = player.force,
			})
	c3.get_control_behavior().parameters = {parameters={
		 first_signal = {type="virtual",name="signal-red"}
		,constant = 10
		,comparator = ">"
		,output_signal = {type="virtual",name="signal-blue"}
		,copy_count_from_input = false
		}}
	
			
	local c4 = surface.create_entity({
			name = test_prefix.."decider-combinator",
			position = test_positions[4],
			force = player.force,
			})
	c4.get_control_behavior().parameters = {parameters={
		 first_signal = {type="virtual",name="signal-red"}
		,constant = 12
		,comparator = ">"
		,output_signal = {type="virtual",name="signal-yellow"}
		,copy_count_from_input = false
		}}
		
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

local function enter_editor()
	-- Create a surface
	-- Teleport player there
	-- Save inventory, quickbar, weapon and tools
	-- Clean inventory, quickbar, weapon and tools
	-- Generate inventory
end

local function exit_editor()
end

script.on_event(defines.events.on_tick, on_tick_handler) --subscribe ticker when train stops exist
