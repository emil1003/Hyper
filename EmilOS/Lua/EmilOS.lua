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
	self = getNode "#Topbar",

	menuButton = getNode "#TopbarMenuButton",

	clock = getNode "#TopbarClock",
	searchButton = getNode "#TopbarSearchButton",
	sidebarButton = getNode "#TopbarSidebarButton"
}

local Sidebar = {
	self = getNode "#Sidebar",

	tabContainer = getNode "#SidebarTabContainer",

	Notifications = {
		self = getNode "#SidebarNotifications",
		list = getNode "#SidebarNotificationsList"
	},

	isOpen = false
}

local Dialog = {
	self = getNode "#Dialog",

	label = getNode "#DialogLabel",

	rightButton = getNode "#DialogButtonRight",
	leftButton = getNode "#DialogButtonLeft"
}

-- Stupid fixes that shouldn't have to be done like this, but it's the only way.
function Sidebar:toggle() -- Can't be inside Sidebar because reasons
	if Sidebar.isOpen then
		Sidebar.self:animate( "showSidebar", "X", App.width + 1, 0.3, "inCubic" )
	else
		Sidebar.self:animate( "hideSidebar", "X", App.width - Sidebar.self.width + 1, 0.3, "outCubic" )
	end
	Sidebar.isOpen = not Sidebar.isOpen
end

function Dialog:create( label, buttonRight, buttonLeft, funcRight, funcLeft )
	Dialog.label:setText( label )
	Dialog.rightButton:setText( buttonRight and buttonRight or "" )
	Dialog.rightButton:on( "trigger", function()
		Dialog.self:animate( "dialog", "Y", App.height + 1, 0.3, "inCubic" )
		if funcRight then funcRight() end
	end)
	Dialog.leftButton:setText( buttonLeft and buttonLeft or "" )
	Dialog.leftButton:on( "trigger", function()
		Dialog.self:animate( "dialog", "Y", App.height + 1, 0.3, "inCubic" )
		if funcLeft then funcLeft() end
	end)

	Dialog.self:animate( "dialog", "Y", (App.height - Dialog.self.height) / 2, 0.3, "outCubic" )
end


Sidebar.tabContainer:set({ -- TabbedPageContainer doesn't apply colors from theme
	tabColour = colors.black,
	tabBackgroundColour = colors.lightGray,
	selectedTabColour = colors.white,
	selectedTabBackgroundColour = colors.lightBlue
})

-- Setup event handlers
Topbar.menuButton:on( "trigger", function()
	if Topbar.Menu then
		App:removeNode( Topbar.Menu )
	end
	Topbar.Menu = App:addNode( ContextMenu({
		{"button", " Om EmilOS ", function()
			App:removeNode( Topbar.Menu )
			Dialog.create( nil --[[ why? ]], "EmilOS Titanium 0.0.1", "OK" )
		end},
		{"rule"},
		{"button", " Indstillinger ", function() end},
		{"rule"},
		{"menu", " Afslut...   \16 ", {
			{"button", " Log af ", function()
				App:removeNode( Topbar.Menu )
				Dialog:create( "Vil du logge af?", "Ja", "Nej", function() App:stop() end )
			end},
			{"button", " Genstart ", function() os.reboot() end},
			{"button", " Luk ned ", function() os.shutdown() end}
		}}
	}, 2, 2 ))
end)

Sidebar.tabContainer:selectPage( "SidebarNotifications" )
Topbar.sidebarButton:on( "trigger", Sidebar.toggle )

App:schedule( function() Sidebar.Notifications.list:addNode( Label( "Hej med dig", 2 ) ) end, 10 )


-- Start Titanium event loop
App:schedule( function() Topbar.clock:update() end, 0.5, true )
App:start()