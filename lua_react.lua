-- ПОЧЕМУ нельзя просто циклами сравнивать таблицы и применять что изменилось??????
-- ПОТОМУ ЧТО FACTORIO API сделан так, что часть свойств READONLY.
-- Они их не меняет и на ругается если пытаться их изменить.
-- Эти свойства все равно хардкодить - для них пересоздавать UI.
-- ========================================================================================

require("update_ui_funcs");

function get_ui_full_path(ui, suffix)
	return (ui and ui.parent and get_ui_full_path(ui.parent).."." or "") .. (ui and ui.name or "") .. (suffix and "."..suffix or "")
end


function ui_concat(...)
	local r = {}
	for i,v in ipairs(arg) do
		for j=1,#v do
			if v[j] then
				table.insert(r, v[j])
			end
		end
	end
	return r
end

--	local function sample_component(props, state) 
--	return
--	    {
--	    type="frame", 
--	    name="lo_radio_network_frame", 
--	    caption={"lo-radio-device-settings"}, 
--	    direction="vertical"
--	    children={
--	        {type="label", name="lbChannel", caption={"lo-radio-device-channel"}},
--			{type="textfield", name="tbChannel", text=device.network_name},
--			{type="label", name="lbChannel", caption={"lo-radio-device-channel-hint"}},
--			{type="button", name="btnOk", caption={"lo-radio-device-ok"}},
--			{type="button", name="btnCancel", caption={"lo-radio-device-cancel"}}
--	    }}
--	end


local function ui_set_min_max(ui, k, new_node, old_node)
	ui.set_slider_minimum_maximum(new_node["slider_minimum"] or 0, new_node["slider_maximum"] or 100)
end

local function ui_set_discrete_slider(ui, k, new_node, old_node)
	local enabled = new_node["slider_discrete_slider"] or false
	if enabled then
		ui.set_slider_discrete_slider(true)
		ui.set_slider_discrete_values(new_node["slider_discrete_values"] or {0,1})
	else 
		ui.set_slider_discrete_slider(false)
	end
end

local function noop() end
local function copy(ui, k, new_node, old_node) 
	new_node.ui[k] = new_node[k]
end

-- Here all special props should be resolved - these are props which have an explicit setter and/or getter
local ui_set_special_fields = {
	["type"] = noop,
	["children"] = noop,
	["ui"] = noop,
	["direction"] = "recreate",
	["items"] = function(ui, k, new_node, old_node)
		ui.clear_items()
		for i, v2 in ipairs(new_node[k]) do
			ui.set_item(v2)
		end
	end,
	["slider_minimum"] = ui_set_min_max,
	["slider_maximum"] = ui_set_min_max,
	["slider_value_step"] = function(ui, k, new_node, old_node) ui.set_slider_value_step(new_node[k] or 1) end,
	["slider_discrete_slider"] = ui_set_discrete_slider,
	["slider_discrete_values"] = ui_set_discrete_slider,
	["selection"] = function(ui, k, new_node, old_node) ui.select(new_node[k].s, new_node[k].e) end,
}

local current_observer = nil

function useObserver(callback)
	local observedCallback 
	observedCallback = function() 
		local old_observer = current_observer
		current_observer = observedCallback
		callback()
		current_observer = old_observer
	end
	observedCallback()
end

function render_one(ui_parent, new_node, old_node)
--	if game then
--		game.players[1].print("render_one " .. get_ui_full_path(ui_parent, new_node.name))
--	end
	
	if not new_node.type then
		if old_node.ui then
			old_node.ui.destroy()
		end
	else
		update_ui_funcs[new_node.type](ui_parent, new_node, old_node)
		
		-- Recurse to children
		if new_node.children then
			render_array(new_node.ui, new_node.children, old_node and old_node.children or {})
		else
			if old_node and old_node.children and #old_node.children then
				for k,v in old_node.children do
					v.ui.destroy()
				end
			end
		end		
	end
end

function render_array(ui_parent, new_nodes, old_nodes)
	-- Delete old_nodes and their UI 
	--		If the node doesn't exist anymore
	-- 		If new node isn't compartible with old one
	
	for k,old_node in pairs(old_nodes) do
		local new_node = new_nodes[k]
		if old_node and not (new_node or new_node.type ~= old_node.type) then
			old_nodes[k].ui.destroy()
			old_nodes[k].ui = nil
			old_nodes[k] = nil
		end
	end
	
	-- Walk all new_nodes
	for k,new_node in pairs(new_nodes) do
		-- Set new properties
		render_one(ui_parent, new_node, old_nodes[k])
	end
end

local all_old_nodes = {}


function render(ui_parent, new_node)
	if not new_node.name then
		error("Can't render without root name. If you need to hide ui - please set type = nil instead. Root name should never change.")
	end
	local ui_full_path = get_ui_full_path(ui_parent, new_node.name)
	local old_node = all_old_nodes[ui_full_path]
	all_old_nodes[ui_full_path] = new_node
	
	render_one(ui_parent, new_node, old_node)
end

--============================= MOBX implementation ====================================================

local prv = {}
local bindings_prv = {}

-- create metatable
local mt = {
  __index = function (proxy,k)
	if k~=prv and k~=bindings_prv and current_observer then
		if not proxy[bindings_prv][k] then
			proxy[bindings_prv][k] = {}
		end
		table.insert(proxy[bindings_prv][k], current_observer)
	end
	return proxy[prv][k]   -- access the original table
  end,

  __newindex = function (proxy,k,v)
	proxy[prv][k] = v   -- update original table
	if proxy[bindings_prv][k] then
		local tmp = proxy[bindings_prv][k]
		proxy[bindings_prv][k] = nil
		for _, refresh_func in ipairs(tmp) do
			refresh_func()
		end
	end
  end
}

function newObservableTable()
  local proxy = {}
  proxy[prv] = {}
  proxy[bindings_prv] = {}
  setmetatable(proxy, mt)
  return proxy
end
