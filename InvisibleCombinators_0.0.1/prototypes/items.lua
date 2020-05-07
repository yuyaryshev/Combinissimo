data:extend({
  	{
		type = "item",
		name = "invisible-combinator",
		icon = MOD_NAME.."/graphics/invisible-combinator-item.png",
		icon_size = 32,
		flags = {},
		subgroup = "circuit-network",
		order = "b[combinators]-invisible-combinator-1",
		place_result = "invisible-combinator",
		stack_size = 50,
		enabled = true
	},
  	{
		type = "item",
		name = "invisible-combinator-input",
		icon = MOD_NAME.."/graphics/invisible-combinator-input-item.png",
		icon_size = 32,
		flags = {},
		subgroup = "circuit-network",
		order = "b[combinators]-invisible-combinator-2-input",
		place_result = "invisible-combinator-input",
		stack_size = 50,
		enabled = true
	},
  	{
		type = "item",
		name = "invisible-combinator-output",
		icon = MOD_NAME.."/graphics/invisible-combinator-output-item.png",
		icon_size = 32,
		flags = {},
		subgroup = "circuit-network",
		order = "b[combinators]-invisible-combinator-3-output",
		place_result = "invisible-combinator-output",
		stack_size = 50,
		enabled = true
	},
})


local invisible_constant_combinator		= copyPrototype("item", "constant-combinator", "invisible-constant-combinator")
local invisible_decider_combinator		= copyPrototype("item", "decider-combinator", "invisible-decider-combinator")
local invisible_arithmetic_combinator	= copyPrototype("item", "arithmetic-combinator", "invisible-arithmetic-combinator")
local invisible_power_distributor		= copyPrototype("item", "arithmetic-combinator", "invisible-power-distributor")
local invisible_power_provider			= copyPrototype("item", "arithmetic-combinator", "invisible-power-provider")

local invisible_items = 
	{
	invisible_constant_combinator, 
	invisible_decider_combinator, 
	invisible_arithmetic_combinator, 
	invisible_power_distributor, 
	invisible_power_provider,
	}

data:extend(invisible_items)



