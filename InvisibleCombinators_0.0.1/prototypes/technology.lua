data:extend({
  {
    type = "technology",
    name = "invisible-combinator",
    icon = MOD_NAME.."/graphics/invisible-combinator-technology.png",
	icon_size = 64,
    prerequisites = {"circuit-network"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "invisible-combinator"
      },
      {
        type = "unlock-recipe",
        recipe = "invisible-combinator-input"
      },
      {
        type = "unlock-recipe",
        recipe = "invisible-combinator-output"
      },
    },
    unit =
    {
      count = 50,
      ingredients = {
         {"automation-science-pack", 1}
        ,{"logistic-science-pack", 1}
      },
      time = 2000
    },
    order = "c-g-c"
  }
})
