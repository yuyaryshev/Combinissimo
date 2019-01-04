data:extend({
  	{
		type = "item",
		name = "combinissimo",
		icon = MOD_NAME.."/graphics/combinissimo-item.png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "b[combinators]-combinissimo-1",
		place_result = "combinissimo",
		stack_size = 50,
		enabled = true
	},
  	{
		type = "item",
		name = "combinissimo-input",
		icon = MOD_NAME.."/graphics/combinissimo-input-item.png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "b[combinators]-combinissimo-2-input",
		place_result = "combinissimo-input",
		stack_size = 50,
		enabled = true
	},
  	{
		type = "item",
		name = "combinissimo-output",
		icon = MOD_NAME.."/graphics/combinissimo-output-item.png",
		icon_size = 32,
		flags = {"goes-to-quickbar"},
		subgroup = "circuit-network",
		order = "b[combinators]-combinissimo-3-output",
		place_result = "combinissimo-output",
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



