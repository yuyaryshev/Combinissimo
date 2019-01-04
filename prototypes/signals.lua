data:extend({
  {
    type = "item-subgroup",
    name = "combinissimo-signal",
    group = "signals",
    order = "z[combinissimo-signal]"
  },

  {
    type = "virtual-signal",
    name = "combinissimo-channel",
    icon = MOD_NAME.."/graphics/combinissimo-channel-signal.png",
	icon_size = 32,
    subgroup = "combinissimo-signal",
    order = "z[combinissimo-signal]"
  },  
})