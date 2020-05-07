data:extend({
  {
    type = "item-subgroup",
    name = "invisible-combinator-signal",
    group = "signals",
    order = "z[invisible-combinator-signal]"
  },

  {
    type = "virtual-signal",
    name = "invisible-combinator-channel",
    icon = MOD_NAME.."/graphics/invisible-combinator-channel-signal.png",
	icon_size = 32,
    subgroup = "invisible-combinator-signal",
    order = "z[invisible-combinator-signal]"
  },  
})