--[[
	Hyper pre-init script
]]

local X, Y = term.getSize()

term.setBackgroundColor(colors.white)
term.setTextColor(colors.gray)
term.clear()

term.setCursorPos(2, Y - 1)
write("Hold SHIFT for boot options")

-- Load self contained Titanium package
dofile("Hyper/Titanium/Titanium.lua")
