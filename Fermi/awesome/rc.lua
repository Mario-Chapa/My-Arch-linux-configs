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

vicious = require("vicious")
-- Initialize widget
cpuwidget = awful.widget.graph()

-- Graph properties
cpuwidget:set_width(20)
cpuwidget:set_background_color("#050505")
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#008686"}, {5, "#004444"},
                    {10, "#001111" }}})
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Pop-up Notifications Settings
naughty.config.defaults.font               = "Liberation mono 12"
naughty.config.presets.timeout             = 30
naughty.config.presets.fg                  = '#FFFFFF'
naughty.config.presets.bg                  = '#00FFFF'
naughty.config.presets.normal.border_color = '#00FF00'

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

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
        -- awful.layout.suit.tile.left,
        --awful.layout.suit.fair,
        --awful.layout.suit.floating,
        --awful.layout.suit.magnifier,
        --awful.layout.suit.tile.top
        --awful.layout.suit.fair.horizontal,
        --awful.layout.suit.spiral,
        --awful.layout.suit.spiral.dwindle,
        -- lain.layout.centerwork,
-- }}}

-- Original wallpaper code
-- {{{ Wallpaper
-- if beautiful.wallpaper then
--     for s = 1, screen.count() do
--         gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--     end
-- end
-- -- {{{ Tags
-- -- Define a tag table which hold all screen tags.
-- tags = {}
-- for s = 1, screen.count() do
--     -- Each screen has its own tag table.
--     tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
-- end
-- -- }}}

 -- One wallpaper across two screens
-- tags[1] = awful.tag(tags.names, 1, tags.layout)
--   tags[2] = awful.tag(tags2.names, 2, tags2.layout)
--   gears.wallpaper.maximized(beautiful.wallpaperdual, nil, true)

local layouts = {
        awful.layout.suit.tile,
        awful.layout.suit.tile.bottom,
        }

tags = {
         names  = { " 01",     " 02",     " 03",    " 04",  " 05",    " 6:Mail",  " 7:IRC"},
         layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]}
     }

tags[1] = awful.tag(tags.names, 1, tags.layout)

-- Wallpaper randomizer, uses the list passed from theme.lua
selected_paper = math.random(#beautiful.wallpaper)
gears.wallpaper.maximized(beautiful.wallpaper[selected_paper], 1, true)

-- tags2 = {
--         names  = { " 1:Web",    " 2:Mail",   " 3:Skype",  " 4:Music"  },
--         layout = { layouts[1], layouts[3], layouts[3], layouts[2] }
--         }

-- if screen.count() == 2 then
--     tags[2] = awful.tag(tags2.names, 2, tags2.layout)
--     gears.wallpaper.maximized(beautiful.wallpaper2, 2, true)
-- else
    -- for s = 1, screen.count() do
        -- tags[1] = awful.tag(tags_singlehead.names, 1, tags_singlehead.layout)
        -- gears.wallpaper.maximized(beautiful.wallpaper, 1, true)
    -- end
-- end
 -- }}}

--{{{ Menu
--Create a laucher widget and a main menu
-- myawesomemenu = {
--       { "manual", terminal .. " -e man awesome" },
--       { "edit config", editor_cmd .. " " .. awesome.conffile },
--       { "restart", awesome.restart },
--       { "quit", awesome.quit }
-- }

-- mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
-- { "open terminal", terminal }
-- }
-- })

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
-- menu = mymainmenu })

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = terminal
awful.menu.menu_keys.up = { "k" }
awful.menu.menu_keys.down = { "j" }
awful.menu.menu_keys.enter = { "f" }

-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %d %b(%a), %H:%M ")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
                if c == client.focus then
                    c.minimized = true
                else
                    -- Without this, the following
                    -- :isvisible() makes no sense
                    c.minimized = false
                    if not c:isvisible() then
                                    awful.tag.viewonly(c:tags()[1])
                    end
                    -- This will also un-minimize
                    -- the client, if needed
                    client.focus = c
                    c:raise()
                end
end),
awful.button({ }, 3, function ()
                if instance then
                                instance:hide()
                                instance = nil
                else
                                instance = awful.menu.clients({ width=250 })
                end
end),
awful.button({ }, 4, function ()
                awful.client.focus.byidx(1)
                if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                                                                                       awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                                                                                             awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                                                                                             awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                                                                                             awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
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

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () end),
    awful.button({ }, 13, function () awful.menu.clients({width=850}) end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

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

awful.key({ modkey,  }, "Right",   awful.tag.viewnext       ),
awful.key({ modkey,  }, "Left",  awful.tag.viewprev       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
-- WADS and vim inspired binds to change tags
awful.key({ modkey, }, "a",   awful.tag.viewprev       ),
awful.key({ modkey, }, "d",  awful.tag.viewnext       ),

awful.key({ modkey,           }, "j",
                function ()
                                awful.client.focus.byidx( 1)
                                if client.focus then client.focus:raise() end
                end),
awful.key({ modkey,           }, "k",
                function ()
                                awful.client.focus.byidx(-1)
                                if client.focus then client.focus:raise() end
                end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( 1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
                function ()
                                awful.client.focus.history.previous()
                                if client.focus then
                                                client.focus:raise()
                                end
                end),

-- Standard program
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
-- Custom Programs for Archy
awful.key({ modkey, "Shift"   }, "g",      function () awful.util.spawn("gogglesmm" ) end),
awful.key({ modkey, "Shift"   }, "i",      function () awful.util.spawn("chromium" ) end),
awful.key({ modkey, "Shift" }, "d",      function () awful.util.spawn("dolphin" ) end),
awful.key({ modkey, "Shift" }, "p",      function () awful.util.spawn("subl3" ) end),
awful.key({ modkey, "Shift" }, "v",      function () awful.util.spawn("kmix" ) end),
awful.key({ modkey, "" }, "s",      function () awful.util.spawn("synergy" ) end),
        -- body

awful.key({ modkey, "Control" }, "q",      function () awful.util.spawn("systemctl poweroff" ) end),
awful.key({ modkey, "Control" }, "r",      function () awful.util.spawn("systemctl reboot" ) end),
awful.key({ modkey, "Control" }, "s",      function () awful.util.spawn("systemctl suspend" ) end),

awful.key({ modkey, "Shift" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey, "Control" }, "n", awful.client.restore),

-- Prompt
awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

-- Menubar
awful.key({ modkey }, "p",
    function()
        awful.menu.clients({ width=850 })
        end)
)
-- menu_keys.up = { "j" }
-- menu_keys.down = { "k" }

clientkeys = awful.util.table.join(
awful.key({ modkey            }, "x",      function () awful.util.spawn_with_shell("setxkbmap -layout jp")
                                                        awful.util.spawn_with_shell("sleep 2;xmodmap ~/.Xmodmap")
                                                                                                 end),
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ modkey,  }, "y",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",
                function (c)
                                -- The client currently has the input focus, so it cannot be
                                -- minimized, since minimized clients can't have the focus.
                                c.minimized = true
                end),

-- Shortcuts for media play control
awful.key({modkey}, "Insert", nil, function () os.execute("xdotool key --delay 0 XF86AudioPlay") end ),
awful.key({ modkey}, "Home",  nil, function ()  os.execute("xdotool key --delay 0 XF86AudioPrev")  end ),
awful.key({ modkey}, "End",   nil, function ()  os.execute("xdotool key --delay 0 XF86AudioNext")  end ),
-- awful.key({modkey}, "Delete", nil, function () awful.util.spawn_with_shell("xdotool key --delay 0 XF86AudioMute")  end ),

-- previous/next

-- volume down/up
-- awful.key({ modkey}, "Prior", nil, function ()  awful.util.spawn_with_shell("xdotool key --delay 0 XF86AudioLowerVolume")  end ),
-- awful.key({ modkey}, "Next",  nil, function ()  awful.util.spawn_with_shell("xdotool key --delay 0 XF86AudioRaiseVolume")  end ),

-- mute


awful.key({ modkey,           }, "m",
                function (c)
                                c.maximized_horizontal = false --not c.maximized_horizontal
                                c.maximized_vertical   = false --not c.maximized_vertical
                end)

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 7 do
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
                awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                awful.button({ }, 13, function () awful.menu.clients({width=850}) end),
                awful.button({ modkey }, 1, awful.mouse.client.move),
                awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
   { rule = { },
   properties = { border_width = beautiful.border_width,
   border_color = beautiful.border_normal,
   focus = awful.client.focus.filter,
   keys = clientkeys,
   buttons = clientbuttons } },
    { rule = { class = "pinentry" },
            properties = { floating = true } },
     { rule = { name = "Copying" },
            properties = {floating = true} },
    { rule = { class = "gimp" },
            properties = { floating = true } },
    }
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 1
                           end)
client.connect_signal("unfocus", function(c)
                                c.border_color = beautiful.border_normal
                                c.opacity = 0.9
                             end)
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    -- c:connect_signal("mouse::enter", function(c)
    --                 if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --                                 and awful.client.focus.filter(c) then
    --                                 client.focus = c
    --                 end
    -- end)

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

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
                    -- buttons for the titlebar
                    local buttons = awful.util.table.join(
                                                    awful.button({ }, 1, function()
                                                                    client.focus = c
                                                                    c:raise()
                                                                    awful.mouse.client.move(c)
                                                    end),
                                                    awful.button({ }, 3, function()
                                                                    client.focus = c
                                                                    c:raise()
                                                                    awful.mouse.client.resize(c)
                                                    end)
                                                    )

                    -- Widgets that are aligned to the left
                    local left_layout = wibox.layout.fixed.horizontal()
                    left_layout:add(awful.titlebar.widget.iconwidget(c))
                    left_layout:buttons(buttons)

                    -- Widgets that are aligned to the right
                    local right_layout = wibox.layout.fixed.horizontal()
                    right_layout:add(awful.titlebar.widget.floatingbutton(c))
                    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
                    right_layout:add(awful.titlebar.widget.stickybutton(c))
                    right_layout:add(awful.titlebar.widget.ontopbutton(c))
                    right_layout:add(awful.titlebar.widget.closebutton(c))

                    -- The title goes in the middle
                    local middle_layout = wibox.layout.flex.horizontal()
                    local title = awful.titlebar.widget.titlewidget(c)
                    title:set_align("center")
                    middle_layout:add(title)
                    middle_layout:buttons(buttons)

                    -- Now bring it all together
                    local layout = wibox.layout.align.horizontal()
                    layout:set_left(left_layout)
                    layout:set_right(right_layout)
                    layout:set_middle(middle_layout)

                    awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Run once function, to avoid multiple instances of a program
-- running when restarting lua.
function run_once(prg,arg_string,screen)
    if not prg then
        do return nil end
    end

    pname = prg
    if not arg_string then
        awful.util.spawn_with_shell("pgrep -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

-- run_once("sudo dhcpcd")
awful.util.spawn_with_shell("setxkbmap -layout jp")
run_once("conky","--config=/home/mario/.conkyrc-awesome")
run_once("kmix")
run_once("redshift")
run_once("compton","--backend glx --blur-background --blur-kern 11x11gaussian;11x11gaussian -i 0.75")
awful.util.spawn_with_shell("sleep 1; /usr/bin/xmodmap /home/mario/.Xmodmap")



-- run_once("amor")
-- run_once("xcompmgr","-c -C -o.1 -t-5 -l-5 -r4.2")
  -- run_once("compton", "--backend glx --paint-on-overlay --vsync opengl-swc --glx-no-stencil --glx-no-rebind-pixmap --unredir-if-possible --blur-background --blur-kern 11x11gaussian;11x11gaussian -i 0.75")
-- awful.util.spawn_with_shell("xmodmap ~/.Xmodmap")
-- run_once("xautolock","-time 15 -locker \"xscreensaver-command -activate\"")
-- python -c 'from ctypes import *; X11 = cdll.LoadLibrary("libX11.so.6"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'
