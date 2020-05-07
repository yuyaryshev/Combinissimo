rem to see all tests not just failed use -v
@cls
@lua test.lua 
@lua -lluacov test.lua
