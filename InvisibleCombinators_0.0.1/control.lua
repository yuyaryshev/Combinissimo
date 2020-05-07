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


local ic = nil
local editor_chunk_radius = 3
local editor_usefull_chunk_radius = editor_chunk_radius - 1

function init()
	if ic then
		return
	end
	
--	local old_version, new_version = nil
--	local new_version_str = game.active_mods[MOD_NAME]
--	if new_version_str then
--		new_version = string.format("%02d.%02d.%02d", string.match(new_version_str, "(%d+).(%d+).(%d+)"))
--	end
	
	if not global.invisible_combinators then
		global.invisible_combinators = {}
	end
	
	ic = global.invisible_combinators
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


local function enter_editor(player)
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
	editor_surface.create_entity({ name = "invisible-power-distributor",	position = {0,0}, force = force })
	editor_surface.create_entity({ name = "invisible-power-provider",		position = {0,0}, force = force })

	--	TODO_lo Create combinators layout
	
	-- Teleport player to editor
	player.teleport(player_data.entrance_position, editor_surface)

	--	TODO_lo
	-- 		Save inventory, quickbar, weapon and tools
	-- 		Clean inventory, quickbar, weapon and tools
	-- 		Generate inventory
	-- 			Free connection cables
end

local function exit_editor()
	local saved = player_data.saved_entrace_data
	player.teleport(saved.position, saved.surface)
	player_data.saved_entrace_data = nil
	
	--	TODO_lo
	-- 		Clean inventory, quickbar, weapon and tools
	-- 		Load inventory, quickbar, weapon and tools
end


local on_tick_handler_once = false
function on_tick_handler(event)
	if event.tick > 100 then
		if not on_tick_handler_once then
			on_tick_handler_once = true
			game.players[1].print("on_tick_handler_once - begin")
			enter_editor(game.players[1])
			game.players[1].print("on_tick_handler_once - end")
		end
	end
end

script.on_event(defines.events.on_tick, on_tick_handler) --subscribe ticker when train stops exist

script.on_event(defines.events.on_player_created, function(event)
	create_surfaces_for_players()
end)
