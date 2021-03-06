-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- More widgets functionality
vicious = require("vicious")

-- Awful CPU usage widget
cpuwidget = awful.widget.graph()
cpuwidget:set_width(20)
cpuwidget:set_background_color("#050505")
cpuwidget:set_color( {  type = "linear",
			from = { 0, 0 }, to = { 10,0 },
			stops = { {0 , "#00A6A6"},
			          {10, "#008484"},
	                          {15, "#004141"}
	                        }
	              } )
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

-- Vertical Screen setup fragment:
-- It gets the screen width in px to guess the screen orientation
-- isscreen_vertical = false
-- local scr_width = screen[1].workarea.width
-- if scr_width == 600 then
-- 	isscreen_vertical = true
-- else
-- 	isscreen_vertical = false
-- end

-- Pop-up Notifications Settings
naughty.config.presets.timeout             = 30
naughty.config.defaults.font               = "Ericsson GA628 14"
naughty.config.presets.fg                  = '#FFFFFF'
naughty.config.presets.bg                  = '#00FFFF'
naughty.config.presets.normal.border_color = '#00FF00'

-- Additional Functions
function run_once(prg,arg_string)
	if not prg then
		do return nil end
	end
	pname = prg

	if not arg_string then
		awful.util.spawn_with_shell("pgrep -u $USER -x '" .. pname .. "' || (" .. prg .. ")")
	else
		awful.util.spawn_with_shell("pgrep -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")")
	end
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
	title = "Oops, there were errors during startup!",
	text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
	-- Make sure we don't go into an endless error loop
	if in_error then return end
		in_error = true
		naughty.notify({ preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = err })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/mario/.config/awesome/theme.lua")
terminal = "xterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

local layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.max.fullscreen
}

-- For the main screen (netbook screen)
tags = {
	names  = { " 01",       " 02",      " 03",     " 04",       " 05"},
	layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]}
}
-- Extra screen (attached monitor, proyector)
tags_2 = {
	names  = { " Main ",   " Fullscreen ",  },
	layout = { layouts[1], layouts[1], }
}

-- Wallpaper ramdomizer
selected_paper = math.random(#beautiful.wallpaper)
if screen.count == 2 then
	tags[1] = awful.tag(tags.names,   1, tags.layout)
	tags[2] = awful.tag(tags_2.names, 2, tags_2.layout)
	gears.wallpaper.maximized(beautiful.wallpaper[selected_paper], 1, true)
	gears.wallpaper.maximized(beautiful.wallpaper_projector, 2, true)
else
	tags[1] = awful.tag(tags.names, 1, tags.layout)
	gears.wallpaper.maximized(beautiful.wallpaper[selected_paper], 1, true)
end


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- vim-like binds for the programs menu (mod+p)
awful.menu.menu_keys.up = { "k" }
awful.menu.menu_keys.down = { "j" }
awful.menu.menu_keys.enter = { "f" }
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %H:%M ")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}

-- I dont like this mouse click to do stuff, so commenting out
mytaglist.buttons = awful.util.table.join(
	-- awful.button({ }, 1, awful.tag.viewonly),
	-- awful.button({ modkey }, 1, awful.client.movetotag),
	-- awful.button({ }, 3, awful.tag.viewtoggle),
	-- awful.button({ modkey }, 3, awful.client.toggletag),
	-- awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	-- awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
-- awful.button({ }, 1, function (c)
-- if c == client.focus then
-- c.minimized = true
-- else
-- -- Without this, the following
-- -- :isvisible() makes no sense
-- c.minimized = false
-- if not c:isvisible() then
-- awful.tag.viewonly(c:tags()[1])
-- end
-- -- This will also un-minimize
-- -- the client, if needed
-- client.focus = c
-- c:raise()
-- end
-- end),

-- awful.button({ }, 3, function ()
-- if instance then
-- instance:hide()
-- instance = nil
-- else
-- instance = awful.menu.clients({ width=250 })
-- end
-- end),
-- awful.button({ }, 4, function ()
-- awful.client.focus.byidx(1)
-- if client.focus then client.focus:raise() end
-- end),
-- awful.button({ }, 5, function ()
-- awful.client.focus.byidx(-1)
-- if client.focus then client.focus:raise() end
-- end)
)

for s = 1, screen.count() do
-- Create a promptbox for each screen
mypromptbox[s] = awful.widget.prompt()
-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox[s] = awful.widget.layoutbox(s)
mylayoutbox[s]:buttons(awful.util.table.join(
-- awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
-- awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
-- awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
-- awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
))

-- Create a taglist widget
mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

-- Create a tasklist widget
mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

-- Create the wibox
mywibox[s] = awful.wibox({ position = "top", screen = s })

-- Widgets that are aligned to the left
local left_layout = wibox.layout.fixed.horizontal()
--left_layout:add(mylauncher)
left_layout:add(mylayoutbox[s])
left_layout:add(mytaglist[s])
left_layout:add(mypromptbox[s])

-- Widgets that are aligned to the right
local right_layout = wibox.layout.fixed.horizontal()
if s == 1 then right_layout:add(wibox.widget.systray()) end
right_layout:add(mytextclock)
right_layout:add(cpuwidget)

-- Now bring it all together (with the tasklist in the middle)
local layout = wibox.layout.align.horizontal()
layout:set_left(left_layout)
layout:set_middle(mytasklist[s])
layout:set_right(right_layout)


mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindingsbuttons
root.buttons(awful.util.table.join(
-- awful.button({ }, 3, function ()  end),
-- awful.button({ }, 2, function () awful.menu.clients({width=850}) end),
-- awful.button({ }, 4, awful.tag.viewnext),
-- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	-- minimizing and "show desktop" trick
	awful.key({ modkey, "Control" }, "n", awful.client.restore),

	awful.key({ modkey }, "z",
	  function ()
	      local curtag
	      local curtags = awful.tag.selectedlist()
	      local client
	      local clients
	      local allminimized

	      for x, curtag in pairs(curtags) do
	          clients = curtag:clients()
	          -- check if all clients are minimized
	          allminimized = true
	          for y, client in pairs(clients) do
	              if client.minimized ~= true then
	                  allminimized = false
	                  break
	              end
	          end

	          -- If at least one client isn't minimized, minimize all clients
	          -- Otherwise unminimize all clients
	          for y, client in pairs(clients) do
	              if allminimized == true then
	                  client.minimized = false
	              else
	                  client.minimized = true
	              end
	          end
	      end
	  end),

	awful.key({ modkey }, "i",
		function ()
			local curtag
			local curtags = awful.tag.selectedlist()
			local client
			local clients

			for x, curtag in pairs(curtags) do
				clients = curtag:clients()
			end

				-- If at least one client isn't minimized, minimize all clients
				-- Otherwise unminimize all clients
				for y, client in pairs(clients) do
					if client.minimized ~= true then
						client.minimized = true
					end
				end
		end),


	awful.key({ modkey }, "o",
		function ()
			local curtag
			local curtags = awful.tag.selectedlist()
			local client
			local clients
			for x, curtag in pairs(curtags) do
				clients = curtag:clients()
			end


				-- If at least one client isn't minimized, minimize all clients
				-- Otherwise unminimize all clients
				for y, client in pairs(clients) do
					if client.minimized == true then
						client.minimized = false
					end
				end
		end),

	awful.key({ modkey,  }, "Left",   awful.tag.viewprev       ),
	awful.key({ modkey,  }, "Right",  awful.tag.viewnext       ),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
	-- WADS and vim inspired binds to change tags
	awful.key({ modkey, }, "a",   awful.tag.viewprev       ),
	awful.key({ modkey, }, "d",  awful.tag.viewnext       ),

	awful.key({ modkey }, "j",
		function ()
		awful.client.focus.byidx( 1)
		if client.focus then client.focus:raise() end
		end),
	awful.key({ modkey }, "k",
		function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
		end),

	-- Layout manipulation
	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
	awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( 1)    end),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(1) end),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
	awful.key({ modkey,           }, "Tab",	function ()
						awful.client.focus.history.previous()
						if client.focus then
							client.focus:raise()
						end
					end),

	-- Standard program
	awful.key({ modkey }, "Return", function () awful.util.spawn(terminal) end),
	-- Custom Programs for Archy
	awful.key({ modkey, "Shift"   }, "g",      function () awful.util.spawn("gogglesmm" ) end),
	awful.key({ modkey, "Shift"   }, "n",      function () awful.util.spawn("nestopia" ) end),
	awful.key({ modkey, "Shift"   }, "a",      function () awful.util.spawn("stella" ) end),
	awful.key({ modkey, "Shift"   }, "s",      function () awful.util.spawn("zsnes" ) end),
	awful.key({ modkey, "Shift"   }, "i",      function () awful.util.spawn("chromium" ) end),
	awful.key({ modkey, "Shift"   }, "d",      function () awful.util.spawn("dolphin" ) end),
	awful.key({ modkey, "Shift"   }, "p",      function () awful.util.spawn("subl3" ) end),
	awful.key({ modkey            }, "s",      function () awful.util.spawn("synergy") end),
	awful.key({ modkey }, "Up",      function () awful.util.spawn("xbacklight -inc 20" ) end),
	awful.key({ modkey }, "Down",      function () awful.util.spawn("xbacklight -dec 20" ) end),
	-- Shutdown, reboot, log out, etc.
	awful.key({ modkey, "Control" }, "q",      function () awful.util.spawn("sudo systemctl poweroff" ) end),
	awful.key({ modkey, "Control" }, "r",      function () awful.util.spawn("systemctl reboot" ) end),
	awful.key({ modkey, "Control" }, "s",      function () awful.util.spawn("systemctl suspend" ) end),
	awful.key({ modkey, "Shift"   }, "r", awesome.restart ),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit),

	-- Prompt
	awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
	awful.key({ modkey }, "p", function() awful.menu.clients({ width=850 }) end),
	-- Keyboard layouts
	awful.key({ modkey }, "x", function () 	awful.util.spawn_with_shell("setxkbmap -layout jp")
	awful.util.spawn_with_shell("sleep 3;xmodmap ~/.Xmodmap")
	end),

	awful.key({ modkey }, "c", function () 	awful.util.spawn_with_shell("setxkbmap -layout latam")
	awful.util.spawn_with_shell("sleep3;xmodmap ~/.Xmodmap")
	end)
)

clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
	awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
	awful.key({ modkey, "Shift"          }, "t",      function (c) c.ontop = not c.ontop            end),
	awful.key({ modkey,           }, "n",
		function (c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
		end),
		awful.key({ modkey,           }, "m",
		function (c)
		c.maximized_horizontal = not c.maximized_horizontal
		c.maximized_vertical   = not c.maximized_vertical
		end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#" .. i + 9,
		function ()
			local screen = mouse.screen
			local tag = awful.tag.gettags(screen)[i]
			if tag then
				awful.tag.viewonly(tag)
			end
		end),
		awful.key({ modkey, "Control" }, "#" .. i + 9,
		function ()
			local screen = mouse.screen
			local tag = awful.tag.gettags(screen)[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end),
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
		function ()
			local tag = awful.tag.gettags(client.focus.screen)[i]
			if client.focus and tag then
				awful.client.movetotag(tag)
			end
		end),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
		function ()
			local tag = awful.tag.gettags(client.focus.screen)[i]
			if client.focus and tag then
				awful.client.toggletag(tag)
		end
	end))
end

clientbuttons = awful.util.table.join(
	-- awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	-- awful.button({ }, 2, function () awful.menu.clients({width=850}) end),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
	)
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule       = { },
	properties   = {
		border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		focus        = awful.client.focus.filter,
		keys         = clientkeys,
		buttons      = clientbuttons,
		size_hints_honor = false
		} },

	{ rule       = { class = "gimp" },
	properties   = { floating = true } },
	-- { rule       = { class = "gogglesmm" },
	-- properties   = { tag = tags[1][5],
	-- border_color = "#FFFF93"}}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end
)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- startup programs
run_once("xcompmgr", "-c -C -o.1 -t-5 -l-5 -r4.2")
-- run_once("compton", "--backend glx --paint-on-overlay --vsync opengl-swc --glx-no-stencil --glx-no-rebind-pixmap --unredir-if-possible --blur-background --blur-kern 11x11gaussian")
run_once("conky")
run_once("ksystraycmd --icon kmix kmix")
awful.util.spawn_with_shell("sleep 1; /usr/bin/xmodmap /home/mario/.Xmodmap")
-- run_once("amor")
run_once("redshift", "-l 35:139")
run_once("setxkbmap", "-layout jp")
