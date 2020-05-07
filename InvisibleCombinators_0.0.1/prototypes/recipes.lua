data:extend({
	{
		type = "recipe",
		name = "invisible-combinator",
		energy_required = 10,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 10},
			{"copper-cable", 20},
			{"electronic-circuit", 20},
		},
		result = "invisible-combinator"
	},
	{
		type = "recipe",
		name = "invisible-combinator-input",
		energy_required = 1,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 1},
			{"electronic-circuit", 1},
		},
		result = "invisible-combinator-input"
	},
	{
		type = "recipe",
		name = "invisible-combinator-output",
		energy_required = 1,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 1},
			{"electronic-circuit", 1},
		},
		result = "invisible-combinator-output"
	},
})