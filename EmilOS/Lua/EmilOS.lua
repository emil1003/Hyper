--[[
	EmilOS, remade using Titanium.
	(c) 2018 Emil Inc.

	Titanium is (c) 2016 Harry Felton.
]]

-- Application Instance
local App = Application():set({
	terminatable = true,
	color = colors.black,
	backgroundColor = colors.white
})

App:importFromTML( "EmilOS/UI/TML/EmilOS.tml" )
App:addTheme( Theme.fromFile( "EmilOS", "EmilOS/UI/Themes/EmilOS.theme" ) )

local function getNode( id )
	return App:query(id).result[1]
end

-- Get nodes and organize them
local Topbar = {
	container = getNode "#Topbar",

	clock = getNode "#TopbarClock",
	searchButton = getNode "#TopbarSearchButton",
	sidebarButton = getNode "#TopbarSidebarButton"
}

local Sidebar = {
	container = getNode "#Sidebar",

	tabContainer = getNode "#SidebarTabContainer",

	Notifications = {
		container = getNode "#SidebarNotifications"
	},

	isOpen = false
}

-- Stupid fixes that shouldn't have to be done like this, but it's the only way.
function Sidebar:toggle() -- Can't be inside Sidebar because reasons
	if Sidebar.isOpen then
		Sidebar.container:animate( "showSidebar", "X", App.width + 1, 0.3, "inCubic" )
	else
		Sidebar.container:animate( "hideSidebar", "X", App.width - Sidebar.container.width + 1, 0.3, "outCubic" )
	end
	Sidebar.isOpen = not Sidebar.isOpen
end

Sidebar.tabContainer:set({ -- TabbedPageContainer doesn't apply colors from theme
	tabColour = colors.black,
	tabBackgroundColour = colors.lightGray,
	selectedTabColour = colors.white,
	selectedTabBackgroundColour = colors.lightBlue
})

-- Setup event handlers
Sidebar.tabContainer:selectPage( "SidebarNotifications" )
Topbar.sidebarButton:on( "trigger", Sidebar.toggle )



-- Start Titanium event loop
App:schedule( function() Topbar.clock:update() end, 0.5, true )
App:start()