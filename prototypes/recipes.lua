data:extend({
	{
		type = "recipe",
		name = "combinissimo",
		energy_required = 10,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 10},
			{"copper-cable", 20},
			{"electronic-circuit", 20},
		},
		result = "combinissimo"
	},
	{
		type = "recipe",
		name = "combinissimo-input",
		energy_required = 1,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 1},
			{"electronic-circuit", 1},
		},
		result = "combinissimo-input"
	},
	{
		type = "recipe",
		name = "combinissimo-output",
		energy_required = 1,
		enabled = true,
		ingredients =
		{
			{"iron-plate", 1},
			{"electronic-circuit", 1},
		},
		result = "combinissimo-output"
	},
})