-- local prv = {}
-- 
-- -- create metatable
-- local mt = {
--   __index = function (t,k)
-- 	game.players[1].print("*access to element " .. tostring(k))
-- 	return t[prv][k]   -- access the original table
--   end,
-- 
--   __newindex = function (t,k,v)
--   		game.players[1].print("*update of element " .. tostring(k) .." to " .. tostring(v))
-- 	t[prv][k] = v   -- update original table
--   end
-- }
-- 
-- function track (t)
--   local proxy = {}
--   proxy[prv] = t
--   setmetatable(proxy, mt)
--   return proxy
-- end