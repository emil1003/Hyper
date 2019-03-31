--[[
	Hyper Initial Setup
	(c) 2019 Emil Inc.
]]

--TODO: Create setup application
--For now, resume launching desktop

local termSize = {term.getSize()}

-- Application Instance
local App = Application():set({
	width = termSize[1],
	height = termSize[2],
	terminatable = true,
	color = colors.black,
	backgroundColor = colors.white
})

local function getNode(id)
	return App:query(id).result[1]
end

App:importFromTML("Hyper/UI/TML/Setup.tml")
App:addTheme(Theme.fromFile("Hyper", "Hyper/UI/Themes/Hyper.theme"))
App:addTheme(Theme.fromFile("Setup", "Hyper/UI/Themes/Setup.theme"))

App:query("#SetupWindow"):on("close", function() App:stop() end)

App:start()





