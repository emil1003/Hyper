--[[
	Hyper Initial Setup
	(c) 2019 Emil Inc.
]]

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

--Import DOM
App:importFromTML("Hyper/UI/TML/Setup.tml")

--Inherit master theme
App:addTheme(Theme.fromFile("Hyper", "Hyper/UI/Themes/Hyper.theme"))

--Load own theme
App:addTheme(Theme.fromFile("Setup", "Hyper/UI/Themes/Setup.theme"))

local PageContainer = getNode("#PageContainer")
PageContainer:selectPage("Page1")

getNode("#Button"):on("trigger", function() PageContainer:selectPage("Page2") end)

getNode("#SetupWindow"):on("close", function() App:stop() end)

App:start()
