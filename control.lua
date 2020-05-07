-- This is free and unencumbered software released into the public domain.
-- 
-- Anyone is free to copy, modify, publish, use, compile, sell, or
-- distribute this software, either in source code form or as a compiled
-- binary, for any purpose, commercial or non-commercial, and by any
-- means.
-- 
-- In jurisdictions that recognize copyright laws, the author or authors
-- of this software dedicate any and all copyright interest in the
-- software to the public domain. We make this dedication for the benefit
-- of the public at large and to the detriment of our heirs and
-- successors. We intend this dedication to be an overt act of
-- relinquishment in perpetuity of all present and future rights to this
-- software under copyright law.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
-- 
-- For more information, please refer to <http://unlicense.org/>

require("lua_react");

local test_table = {}

local ic = nil
local editor_chunk_radius = 3
local editor_usefull_chunk_radius = editor_chunk_radius - 1

------------------------------------------------------------------------------------------------------------------------------
local function getKey(entity)
	return "los_x" .. entity.position.x .. "y".. entity.position.y
end
------------------------------------------------------------------------------------------------------------------------------
function is_valid(entity)
	return (entity ~= nil and entity.valid)
end
------------------------------------------------------------------------------------------------------------------------------
function isDualWired(entity)
	return entity and entity.valid and (entity.type == "decider-combinator" or entity.type == "arithmetic-combinator")
end
------------------------------------------------------------------------------------------------------------------------------
local obsTable1 = newObservableTable()
	obsTable1.tick = 0

local rendered = false
	
function render_ui(d) 
	local player = game.players[1]
	obsTable1.tick = d.tick
	if not rendered then
		rendered = true
		useObserver(function() 
			local parent = player.gui.center
				render(player.gui.center, {
				name="combinissimo_entity_ui",
				type="frame", 
				caption="Combonator", 
			--	columns=2,
				children={
					{type="flow", direction="vertical", children={
						{type="flow", direction="horizontal", children={
							{ type="label", caption="Layout ID" },
							{ type="text-box", text="zz "..(obsTable1.tick or "none") },
						}},
						{type="flow", direction="horizontal", children={
							{ type="button", caption="Open" },
							{ type="button", caption="Close" },
						}},
					}},
				},
			})
		end)
	end
end

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

function init()
	if ic then
		return
	end
	
--	local old_version, new_version = nil
--	local new_version_str = game.active_mods[MOD_NAME]
--	if new_version_str then
--		new_version = string.format("%02d.%02d.%02d", string.match(new_version_str, "(%d+).(%d+).(%d+)"))
--	end
	
	if not global.combinissimo then
		global.combinissimo = {}
	end
	
	ic = global.combinissimo
	if not ic.queues then
		ic.queues = {{},{},{},{},{},{},{},{}}
	end
end

script.on_init(init)
script.on_load(init)

function lo_assert(condition)
	if not condition then
		game.players[1].print("Assertion failed!")
	end
end


local function get_player_data(player)
	return ic.players_data[player.name]
end



		

local function create_player_data(player_data)
	player_data.chunks_required						= 4*editor_chunk_radius*editor_chunk_radius
	player_data.finished							= false					
	player_data.entrance_position					= {0,0}
	player_data.editor_surface						= game.create_surface("inv_comb "..player_data.player.name, {width = 64*editor_chunk_radius-62, height = 64*editor_chunk_radius-62})
	player_data.editor_surface.daytime				= 0
	player_data.editor_surface.freeze_daytime		= true
	player_data.editor_surface.always_day			= true
	
end

local function finish_player_data(player_data)
	if not player_data.finished then
		player_data.finished							= true
		player_data.editor_surface.destroy_decoratives({{-10000,-10000},{10000,10000}})
		local tile_rectangles = {
					{"hazard-concrete-left",	-64*editor_usefull_chunk_radius-1,	-64*editor_usefull_chunk_radius-1,		64*editor_usefull_chunk_radius+1,	-64*editor_usefull_chunk_radius-1	},
					{"hazard-concrete-left",	-64*editor_usefull_chunk_radius-1,	 64*editor_usefull_chunk_radius+1,		64*editor_usefull_chunk_radius+1,	 64*editor_usefull_chunk_radius+1	},
					{"hazard-concrete-left",	-64*editor_usefull_chunk_radius-1,	-64*editor_usefull_chunk_radius,	   -64*editor_usefull_chunk_radius-1,	 64*editor_usefull_chunk_radius		},
					{"hazard-concrete-left",	 64*editor_usefull_chunk_radius+1,	-64*editor_usefull_chunk_radius,	    64*editor_usefull_chunk_radius+1,	 64*editor_usefull_chunk_radius		},
					{"concrete",				-64*editor_usefull_chunk_radius,	-64*editor_usefull_chunk_radius,		64*editor_usefull_chunk_radius,		 64*editor_usefull_chunk_radius 	},
				}	
		local tiles = {}
		for _, r in ipairs(tile_rectangles) do
			for x = r[2], r[4]-1 do
				for y = r[3], r[5]-1 do
					table.insert(tiles, {name = r[1], position={x, y}})
				end
			end
		end
		player_data.editor_surface.set_tiles(tiles)	
	end
end

local function create_surfaces_for_players()
	if not ic.players_data then
		ic.players_data = {}
	end

	local existing_players = {}
	
	-- Create surfaces for all players
	for _, player in pairs(game.players) do
		if not ic.players_data[player.name] then
			local player_data = 
				{
					player_name = player.name,
					player = player,
				}
				
			create_player_data(player_data)
			existing_players[player.name] = true
			player_data.editor_surface.request_to_generate_chunks({0, 0}, editor_chunk_radius)				
			ic.players_data[player.name] = player_data
		end
	end
	
	-- Destroy surfaces for non-existing players
	for player_name, _ in pairs(ic.players_data) do
		if not existing_players[player_name] then
			ic.players_data.editor_surface.destroy()
			ic.players_data = nil			
		end
	end
end


local function restore_layout(player, surface, editor_data, invisible_mode, origin_entity)
	-- Restore entities
	local entityByKey = {}
    for key, entity_data in pairs(editor_data.entities) do
    	local entity = surface.create_entity({ 
			name = entity_data.name,		            
			position = entity_data.position, 
			force = player.force 
			})
		entityByKey[key] = entity
    	if entity_data.cb_parameters then
    	    entity.get_control_behavior().parameters = entity_data.cb_parameters
    	end
    	if entity_data.power_switch_state then
        	entity.power_switch_state = entity_data.power_switch_state
        end
    end
	
	-- Restore wires
    for _, t in pairs(editor_data.rewires) do
		local source = entityByKey[t.source]
		if t.mode == "device" then
			source.connect_neighbour({
				wire = t.wire,
				target_entity = entityByKey[t.target_entity],
				source_circuit_id = t.source_circuit_id,
				target_circuit_id = t.target_circuit_id,
			})
		elseif t.mode == "pole" then
			source.connect_neighbour(entityByKey[t.target_entity])
		end
    end
end


local function enter_editor(player, editor_data)
	local player_data		= get_player_data(player)
	finish_player_data(player_data)
	local editor_surface	= player_data.editor_surface
	
	player_data.saved_entrace_data = 
		{
		position	= player.position,
		surface		= player.surface,
		}		
	
	-- Destroy all entities on surface
	for _, entity in pairs(editor_surface.find_entities({{-1000, -1000},{1000, 1000}})) do
		entity.destroy()
	end
		
	-- Create base entities for editor
	editor_surface.create_entity({ name = "invisible-power-distributor",	position = {0,0}, force = player.force })
	editor_surface.create_entity({ name = "invisible-power-provider",		position = {0,0}, force = player.force })
	editor_surface.create_entity({ name = "steel-furnace",		            position = {0,0}, force = player.force })

	restore_layout(player, editor_surface, editor_data, false)
	
	-- Teleport player to editor
	player.teleport(player_data.entrance_position, editor_surface)

	--	TODO_lo
	-- 		Save inventory, quickbar, weapon and tools
	-- 		Clean inventory, quickbar, weapon and tools
	-- 		Generate inventory
	-- 			Free connection cables
	--          Free combinators
end

local function exit_editor(player)
 	local player_data		= get_player_data(player)
 	local editor_surface    = player_data.editor_surface
	local sourceEntities	= editor_surface.find_entities()
    local entities          = {}
	local wiredKeys			= {}				-- Stores keys connections to which should not be saved
	local rewires			= {}
	local nextKey			= 1

	for _, entity in pairs(sourceEntities) do
	    local entity_data = {
		    name = entity.name,
		    position = entity.position,
		}
		local cb = entity.get_control_behavior()
		if cb then
		    entity_data.cb_parameters = entity.get_control_behavior().parameters
		end
		
	    if entity.name == "combinissimo-input" then
	        entity_data.exists = true
	    elseif entity.name == "combinissimo-output" then
	        entity_data.exists = true
	    elseif entity.name == "arithmetic-combinator" then
	        entity_data.exists = true
	    elseif entity.name == "decider-combinator" then
	        entity_data.exists = true
	    elseif entity.name == "constant-combinator" then
	        entity_data.exists = true
	    elseif entity.name == "programmable-speaker" then
	        entity_data.exists = true
	    elseif entity.name == "power-switch" then
	        entity_data.exists = true
	        entity_data.power_switch_state = entity.power_switch_state
	    end
		
		if entity_data.exists then
			entities[getKey(entity)] = entity_data
		end
	end

	-- https://lua-api.factorio.com/0.16.51/LuaEntity.html#LuaEntity.circuit_connection_definitions
	-- https://lua-api.factorio.com/0.16.51/LuaEntity.html#LuaEntity.connect_neighbour
	-- https://lua-api.factorio.com/0.16.51/LuaEntity.html#LuaEntity.neighbours

	-- Saving circuits
	for _, source in pairs(sourceEntities) do
		if source and source.valid and source.circuit_connection_definitions then -- and isDualWired(source) then
			wiredKeys[getKey(source)] = true
		
			-- Iterate source's connections
			for _, target in pairs(source.circuit_connection_definitions) do
				local tk = getKey(target.target_entity)
				if not wiredKeys[tk] then
					table.insert(rewires, {mode="device", source = getKey(source), 
						wire = target.wire,
						target_entity = getKey(target.target_entity),
						source_circuit_id = target.source_circuit_id,
						target_circuit_id = target.target_circuit_id,
						})
				end
			end
		end
	end
	
	-- Saving pole connections
	for _, source in pairs(sourceEntities) do
		if source.valid and source.type == "pole" and source.neighbours then
			wiredKeys[getKey(source)] = true
			local wires = {}
			if source.neighbours.copper or source.neighbours.red or source.neighbours.green then
				wires.copper = {}
				wires.red = {}
				wires.green = {}
				
				for _, target in ipairs(source.neighbours["copper"]) do
					local k = getKey(target)
					if not wiredKeys[k] then
						table.insert(rewires, {mode="pole", source = getKey(source), target = getKey(target)})
					end
				end

				for _, source in ipairs(source.neighbours["red"]) do
					local k = getKey(source)
					if not wiredKeys[k] then
						table.insert(rewires, {mode="device", source = getKey(source),
							wire =  defines.wire_type.red,
							target_entity = getKey(target.target_entity),
							})
					end
				end

				for _, source in ipairs(source.neighbours["green"]) do
					local k = getKey(source)
					if not wiredKeys[k] then
						table.insert(rewires, {mode="device", source = getKey(source), 
							wire =  defines.wire_type.green,
							target_entity = getKey(target.target_entity),
							})
					end
				end
			end
		end
	end
			
	local saved = player_data.saved_entrace_data
    if saved then
        player.teleport(saved.position, saved.surface)
        player_data.saved_entrace_data = nil
        
        --	TODO_lo
        -- 		Clean inventory, quickbar, weapon and tools
        -- 		Load inventory, quickbar, weapon and tools
    else
        player.print("ERROR combinissimo: Failed to load player data");
    end
    
    return {entities = entities, rewires = rewires}
end

local editor_test_data = {entities = {}, rewires = {}}

local on_tick_handler_once = false
function on_tick_handler(event)
	
	if ((game.tick+2*60) % (60 * 2))<1 then
		render_ui({tick=game.tick})
	end
	

    local player = game.players[1]
    if is_valid(player.opened) and player.opened.name == "stone-furnace" then
        game.players[1].print("Entering editor...")
        enter_editor(game.players[1], editor_test_data)
        game.players[1].print("Entered editor!")
        player.opened = nil
    end

    if is_valid(player.opened) and player.opened.name == "steel-furnace" then
        game.players[1].print("Exiting editor...")
        editor_test_data = exit_editor(game.players[1])
        game.players[1].print("Exited editor!")
        player.opened = nil
    end
    
	if event.tick > 100 then
		if not on_tick_handler_once then
			on_tick_handler_once = true
			game.players[1].print("on_tick_handler_once - begin")
			--enter_editor(game.players[1], {entities = {}, rewires = {}})
		    exit_editor(game.players[1])
			game.players[1].print("on_tick_handler_once - end")
		end
	end
end

script.on_event(defines.events.on_tick, on_tick_handler) --subscribe ticker when train stops exist

script.on_event(defines.events.on_player_created, function(event)
	create_surfaces_for_players()
end)
