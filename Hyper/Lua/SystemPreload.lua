--[[
	Hyper System Preloader
	(c) 2019 Emil Inc.
]]

-- Check if settings files exists and are not corrupt
if not fs.exists("/.Hyper") then
	--Settings don't exist, run Setup
	dofile("Hyper/Lua/Setup.lua")
end

-- All set, continue loading Hyper
dofile("Hyper/Lua/Hyper.lua")
