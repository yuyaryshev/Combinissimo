require("deep_equal");

update_ui_funcs = {
button = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            mouse_button_filter = n.mouse_button_filter
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.mouse_button_filter ~= o.mouse_button_filter then n.ui.mouse_button_filter = n.mouse_button_filter end
    end
end,

["sprite-button"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            sprite = n.sprite,
            hovered_sprite = n.hovered_sprite,
            clicked_sprite = n.clicked_sprite,
            number = n.number,
            show_percent_for_small_numbers = n.show_percent_for_small_numbers,
            mouse_button_filter = n.mouse_button_filter
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.sprite ~= o.sprite then n.ui.sprite = n.sprite end
        if n.hovered_sprite ~= o.hovered_sprite then n.ui.hovered_sprite = n.hovered_sprite end
        if n.clicked_sprite ~= o.clicked_sprite then n.ui.clicked_sprite = n.clicked_sprite end
        if n.number ~= o.number then n.ui.number = n.number end
        if n.show_percent_for_small_numbers ~= o.show_percent_for_small_numbers then n.ui.show_percent_for_small_numbers = n.show_percent_for_small_numbers end
        if n.mouse_button_filter ~= o.mouse_button_filter then n.ui.mouse_button_filter = n.mouse_button_filter end
    end
end,

checkbox = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            state = n.state
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.state ~= o.state then n.ui.state = n.state end
    end
end,

flow = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.direction ~= o.direction 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            direction = n.direction
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

frame = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.direction ~= o.direction 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            direction = n.direction
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

label = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

line = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.direction ~= o.direction 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            direction = n.direction
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

progressbar = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            value = n.value
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.value ~= o.value then n.ui.value = n.value end
    end
end,

table = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.column_count ~= o.column_count 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            column_count = n.column_count,
            draw_vertical_lines = n.draw_vertical_lines,
            draw_horizontal_lines = n.draw_horizontal_lines,
            draw_horizontal_line_after_headers = n.draw_horizontal_line_after_headers,
            vertical_centering = n.vertical_centering
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.draw_vertical_lines ~= o.draw_vertical_lines then n.ui.draw_vertical_lines = n.draw_vertical_lines end
        if n.draw_horizontal_lines ~= o.draw_horizontal_lines then n.ui.draw_horizontal_lines = n.draw_horizontal_lines end
        if n.draw_horizontal_line_after_headers ~= o.draw_horizontal_line_after_headers then n.ui.draw_horizontal_line_after_headers = n.draw_horizontal_line_after_headers end
        if n.vertical_centering ~= o.vertical_centering then n.ui.vertical_centering = n.vertical_centering end
    end
end,

textfield = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            text = n.text,
            numeric = n.numeric,
            allow_decimal = n.allow_decimal,
            allow_negative = n.allow_negative,
            is_password = n.is_password,
            lose_focus_on_confirm = n.lose_focus_on_confirm,
            clear_and_focus_on_right_click = n.clear_and_focus_on_right_click
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.text ~= o.text then n.ui.text = n.text end
        if n.numeric ~= o.numeric then n.ui.numeric = n.numeric end
        if n.allow_decimal ~= o.allow_decimal then n.ui.allow_decimal = n.allow_decimal end
        if n.allow_negative ~= o.allow_negative then n.ui.allow_negative = n.allow_negative end
        if n.is_password ~= o.is_password then n.ui.is_password = n.is_password end
        if n.lose_focus_on_confirm ~= o.lose_focus_on_confirm then n.ui.lose_focus_on_confirm = n.lose_focus_on_confirm end
        if n.clear_and_focus_on_right_click ~= o.clear_and_focus_on_right_click then n.ui.clear_and_focus_on_right_click = n.clear_and_focus_on_right_click end
    end
end,

radiobutton = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            state = n.state
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.state ~= o.state then n.ui.state = n.state end
    end
end,

sprite = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            sprite = n.sprite
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.sprite ~= o.sprite then n.ui.sprite = n.sprite end
    end
end,

["scroll-pane"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            horizontal_scroll_policy = n.horizontal_scroll_policy,
            vertical_scroll_policy = n.vertical_scroll_policy
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.horizontal_scroll_policy ~= o.horizontal_scroll_policy then n.ui.horizontal_scroll_policy = n.horizontal_scroll_policy end
        if n.vertical_scroll_policy ~= o.vertical_scroll_policy then n.ui.vertical_scroll_policy = n.vertical_scroll_policy end
    end
end,

["drop-down"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            items = n.items,
            selected_index = n.selected_index
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if not deep_equal(n.items, o..items) then n.ui.items = n.items end
        if n.selected_index ~= o.selected_index then n.ui.selected_index = n.selected_index end
    end
end,

["list-box"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            items = n.items,
            selected_index = n.selected_index
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if not deep_equal(n.items, o..items) then n.ui.items = n.items end
        if n.selected_index ~= o.selected_index then n.ui.selected_index = n.selected_index end
    end
end,

camera = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            position = n.position,
            surface_index = n.surface_index,
            zoom = n.zoom
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if not deep_equal(n.position, o..position) then n.ui.position = n.position end
        if n.surface_index ~= o.surface_index then n.ui.surface_index = n.surface_index end
        if n.zoom ~= o.zoom then n.ui.zoom = n.zoom end
    end
end,

["choose-elem-button"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.elem_type ~= o.elem_type 
        or  n.item ~= o.item 
        or  n.tile ~= o.tile 
        or  n.signal ~= o.signal 
        or  n.fluid ~= o.fluid 
        or  n.recipe ~= o.recipe 
        or  n.decorative ~= o.decorative 
        or  n["item-group"] ~= o["item-group"] 
        or  n.achievement ~= o.achievement 
        or  n.equipment ~= o.equipment 
        or  n.technology ~= o.technology 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            elem_type = n.elem_type,
            item = n.item,
            tile = n.tile,
            entity = n.entity,
            signal = n.signal,
            fluid = n.fluid,
            recipe = n.recipe,
            decorative = n.decorative,
            ["item-group"] = n["item-group"],
            achievement = n.achievement,
            equipment = n.equipment,
            technology = n.technology
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if not deep_equal(n.entity, o..entity) then n.ui.entity = n.entity end
    end
end,

["text-box"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            text = n.text,
            clear_and_focus_on_right_click = n.clear_and_focus_on_right_click
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.text ~= o.text then n.ui.text = n.text end
        if n.clear_and_focus_on_right_click ~= o.clear_and_focus_on_right_click then n.ui.clear_and_focus_on_right_click = n.clear_and_focus_on_right_click end
    end
end,

slider = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.minimum_value ~= o.minimum_value 
        or  n.maximum_value ~= o.maximum_value 
        or  n.value_step ~= o.value_step 
        or  n.discrete_slider ~= o.discrete_slider 
        or  n.discrete_values ~= o.discrete_values 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            minimum_value = n.minimum_value,
            maximum_value = n.maximum_value,
            value = n.value,
            value_step = n.value_step,
            discrete_slider = n.discrete_slider,
            discrete_values = n.discrete_values
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.value ~= o.value then n.ui.value = n.value end
    end
end,

minimap = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.chart_player_index ~= o.chart_player_index 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            position = n.position,
            surface_index = n.surface_index,
            chart_player_index = n.chart_player_index,
            force = n.force,
            zoom = n.zoom
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if not deep_equal(n.position, o..position) then n.ui.position = n.position end
        if n.surface_index ~= o.surface_index then n.ui.surface_index = n.surface_index end
        if n.force ~= o.force then n.ui.force = n.force end
        if n.zoom ~= o.zoom then n.ui.zoom = n.zoom end
    end
end,

["entity-preview"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

["empty-widget"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

["tabbed-pane"] = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

tab = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
        or  n.badge_text ~= o.badge_text 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            badge_text = n.badge_text
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
    end
end,

switch = function(ui_parent, n, o)
-- If one of readonly attrs changed -> recreate, else -> update props
    if not o 
        or not n.ui
        or  n.type ~= o.type 
        or  n.name ~= o.name 
    then
        -- Recreate ui
        if o and o.ui then
            o.ui.destroy()
            o.children = nil 
        end
        n.ui = ui_parent.add{	
            type = n.type,
            name = n.name,
            caption = n.caption,
            tooltip = n.tooltip,
            enabled = n.enabled,
            ignored_by_interaction = n.ignored_by_interaction,
            style = n.style,
            switch_state = n.switch_state,
            allow_none_state = n.allow_none_state,
            left_label_caption = n.left_label_caption,
            left_label_tooltip = n.left_label_tooltip,
            right_label_caption = n.right_label_caption,
            right_label_tooltip = n.right_label_tooltip
        }
    else
        n.ui = o.ui
    -- Update props
        if n.caption ~= o.caption then n.ui.caption = n.caption end
        if n.tooltip ~= o.tooltip then n.ui.tooltip = n.tooltip end
        if n.enabled ~= o.enabled then n.ui.enabled = n.enabled end
        if n.ignored_by_interaction ~= o.ignored_by_interaction then n.ui.ignored_by_interaction = n.ignored_by_interaction end
        if n.style ~= o.style then n.ui.style = n.style end
        if n.switch_state ~= o.switch_state then n.ui.switch_state = n.switch_state end
        if n.allow_none_state ~= o.allow_none_state then n.ui.allow_none_state = n.allow_none_state end
        if n.left_label_caption ~= o.left_label_caption then n.ui.left_label_caption = n.left_label_caption end
        if n.left_label_tooltip ~= o.left_label_tooltip then n.ui.left_label_tooltip = n.left_label_tooltip end
        if n.right_label_caption ~= o.right_label_caption then n.ui.right_label_caption = n.right_label_caption end
        if n.right_label_tooltip ~= o.right_label_tooltip then n.ui.right_label_tooltip = n.right_label_tooltip end
    end
end
}
