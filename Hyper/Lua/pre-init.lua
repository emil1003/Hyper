--[[
	Hyper pre-init script
]]

local X, Y = term.getSize()

local function writeCentered(text, y)
    x = math.ceil(math.ceil((X / 2) - (#text / 2)), 0)+1
    term.setCursorPos(x, y)
    write(text)
end

term.setBackgroundColor(colors.white)
term.clear()

term.setTextColor(colors.gray)
writeCentered("Hyper", math.ceil(Y / 2))

term.setTextColor(colors.lightGray)
writeCentered("Hold SHIFT for boot options", Y - 1)

-- Load self contained Titanium package
dofile("Hyper/Titanium/Titanium.lua")
