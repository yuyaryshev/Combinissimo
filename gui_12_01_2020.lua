local player = game.players["thelordodin"]
local parent = player.gui.center.editorParent
parent.clear()
parent.visible = true
local win = remote.call("fui","make_window",({ mod_name="fui-test", view_name="Example0", reload = true, player=player, header="Example", parent=parent }))

local combonator_window = win.element.add({ type="frame", caption="Combonator", columns=2 })
combonator_window.add({ type="label", caption="Layout ID" })
combonator_window.add({ type="text-box", text="1" })
combonator_window.add({ type="button", caption="Open" })
combonator_window.add({ type="button", caption="Close" })

