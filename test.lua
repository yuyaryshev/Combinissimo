lu = require('luaunit')
lua_react = require('lua_react')

function component1(props)
	return {
		type="flow",
		children={
			{type="label", text=props.text},
			{type="textfield", value=props.value},
			{type="button", text="ok"}
			}
		}
end

function component2(props)
	return {
		type="flow",
		children={
			component1({text="t1", value="11"}),
			component1({text="t2", value="22"}),
			component1({text="t3", value="33"}),
			}
		}
end

function test11(a)
	lua_react.
	lu.assertEquals(2,2)
end

	
function test1(a) 
	lu.assertEquals(2,2)
end

function test2(a) 
	lu.assertEquals(2,2)
end

os.exit( lu.LuaUnit.run() )
