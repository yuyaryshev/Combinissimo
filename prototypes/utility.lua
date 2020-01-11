function merge_tables(s1, s2, s3)
	local r = {}
	if s1 then
		for key, value in pairs(s1) do
			r[key] = value
		end
	end
	if s2 then
		for key, value in pairs(s2) do
			r[key] = value
		end
	end
	if s3 then
		for key, value in pairs(s3) do
			r[key] = value
		end
	end
	return r
end

-- adds a recipe which is unlocked when the given technology is researched
function addTechnologyUnlocksRecipe(technologyName, recipeName)
	local tech = data.raw["technology"][technologyName]
	if tech then
		local recipe = data.raw.recipe[recipeName]
		if recipe == nil then
			error("Technology "..technologyName.." should unlock "..recipeName.." but recipe is not initialized yet")
		else
			data.raw["recipe"][recipeName].enabled = false
			if tech.effects == nil then
				tech.effects = {}
			end
			table.insert(tech.effects, {type = "unlock-recipe", recipe = recipeName })
		end
	else
		error("Technology "..technologyName.." not found when adding recipe "..recipeName..". Did you mean?")
		for name,_ in pairs(data.raw["technology"]) do
			error(" "..name)
		end
	end
end

function copyPrototype(s1, s2)
	local s = merge_tables(s1, s2)  

  if not s.source_type then error("copyPrototype called with s.source_type == nil !") end
  if not s.source_name then error("copyPrototype called with s.source_name == nil !") end
  if not s.new_name then error("copyPrototype called with s.new_name == nil !") end
  if not data.raw[s.source_type] then error("data.raw["..s.source_type.."] doesn't exist") end
  if not data.raw[s.source_type][s.source_name] then error("data.raw["..s.source_type.."]["..s.source_name.."] doesn't exist") end
  local p = table.deepcopy(data.raw[s.source_type][s.source_name])
  p.name = s.new_name
  
  if p.minable and p.minable.result then
	p.minable.result = s.new_name
  end
  if p.place_result then
	p.place_result = s.new_name
  end
  if p.result then
	p.result = s.new_name
  end
  if p.results then
		for _,result in pairs(p.results) do
			if result.name == s.source_name then
				result.name = s.new_name
			end
		end
	end
  return p
end
