local function debugPrint(string)
    local p
    if game and game.players[1] then
        p = game.players[1].print
    else
        p = print
    end
    p(string)
end

function merge_signals(r, signals)
	if r == nil then
		error('merge_signals: r is nil.')			-- Writing to nil won't change the container
	end
	
	if signals == nil then return end
	
	if signals[1] ~= nil then
--		debug_log('signals in factorio form',0)
		
		-- signals in factorio form
		for _,signal in ipairs(signals) do
			local key = signal.signal.type .. ":" .. signal.signal.name
			r[key] = r[key] and { signal = signal.signal, count = signal.count + r[key].count } or signal
		end
	else
--		debug_log('signals in lua table',0)
		
		-- signals in lua table
		for key, signal in pairs(signals) do
			debug_log('key = '..key,0)
		
			r[key] = r[key] and { signal = signal.signal, count = signal.count + r[key].count } or signal
		end
	end

--	debug_log('Dump = '..DataDumper(r),0)
end

function table_to_string(t)
	local r =  nil
	if t == nil then
		return "nil"
	end
	
    for k,v in pairs(t) do
		if r ~= nil then
			r =  r .. ", "
		else
			r = ""
		end
		
		if type(v) == "table" then
			r = r .. k .. " = ".. table_to_string(v)
		elseif type(v) == "userdata" then
			r = r .. k .. " = [".. type(v).."]"
		else
			r = r .. k .. " = ".. v
			--v
		end
	end
	
	if r ~= nil then
		return "{" .. r .. "}"
	else
		return "{}"
	end
end

function print_signals(state, x)
    debugPrint("print_signals "..x.." " .. table_to_string(state))
end

-- Convert signals from lua table to factorio format
function format_signals(state)
--    debugPrint("Formatting Signals")
	if state == nil then return {} end
	
    local signals = {}
    local index = 1
    for _,signal in pairs(state) do
        signal.index = index
        index = index + 1
--        debugPrint("Formatting: " .. signal.signal.name)
        table.insert(signals, signal)
    end
    return signals
end
