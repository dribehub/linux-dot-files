-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local nc = naughty.config
    nc.spacing = 8
    nc.defaults.icon_size = 64
    nc.defaults.margin = 16
    nc.defaults.padding = 8
    nc.defaults.position = "bottom_right"
    nc.presets.low.timeout = 3
    nc.presets.low.bg = "#63ae8d"
    nc.presets.low.fg = "#ffffff"
    nc.presets.critical.bg = "#c97074"
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Useless Gaps (overwrites /themes/dribe/theme.lua)
-- beautiful.useless_gap = 15

-- {{{ User defined functions
function run(command) 
    return function() awful.util.spawn(command) end end
function info(desc, gr) 
    return {["description"] = desc; ["group"] = gr} end
function shell(command) 
    awful.spawn.with_shell(command) end
function async(command, func) 
    awful.spawn.easy_async_with_shell(command, func) end

function brightness(increment)
    local get_level = "xrandr --verbose | grep Brightness | awk '{printf $NF}'"
    return function() 
        awful.spawn.easy_async_with_shell(get_level,
            function(actual_brightness)
                actual_brightness = tonumber(actual_brightness)
                local command = "xrandr --output eDP-1 --brightness "
                if (actual_brightness > 1) then 
                    shell(command .. 1);
                elseif (actual_brightness == 1 and increment > 0) then
                    return
                else 
                    shell(command .. (actual_brightness + increment))
                end
            end)
    end
end
--- }}}

-- {{{ Error handling
    -- Check if awesome encountered an error during startup and fell back to
    -- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify({ 
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        })
    end

    -- Handle runtime errors after startup
    do
        local in_error = false
        awesome.connect_signal("debug::error", function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then return end
            in_error = true

            naughty.notify({ 
                preset = naughty.config.presets.critical,
                title = "Oops, an error happened!",
                text = tostring(err)
            })
            in_error = false
        end)
    end
-- }}}

-- {{{ Variable definitions
    -- Themes define colours, icons, font and wallpapers.
    beautiful.init(gears.filesystem.get_themes_dir() .. "dribe/theme.lua")
    beautiful.init("~/.config/awesome/themes/dribe/theme.lua")
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end

    -- This is used later as the default terminal and editor to run.
    terminal = "alacritty"
    editor = os.getenv("EDITOR") or "vim"
    editor_cmd = terminal .. " -e " .. editor

    -- Default modkey.
    -- Usually, Mod4 is the key with a logo between Control and Alt.
    -- If you do not like this or do not have such a key,
    -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
    -- However, you can use another modifier like Mod1, but it may interact with others.
    alt_l = "Mod1"
    alt_r = "Mod5"
    modkey = "Mod4"

    -- Table of layouts to cover with awful.layout.inc, order matters.
    awful.layout.layouts = {
        awful.layout.suit.corner.nw,
        awful.layout.suit.floating,
    --[[
        awful.layout.suit.fair,
        awful.layout.suit.tile,
        awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.fair.horizontal,
        awful.layout.suit.max,
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.magnifier,
        awful.layout.suit.corner.ne,
        awful.layout.suit.corner.sw,
        awful.layout.suit.corner.se,
    ]]--
    }
-- }}}

-- {{{ Menu
    -- Create a launcher widget and a main menu
    myawesomemenu = {
       { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
       { "manual", terminal .. " -e man awesome" },
       { "edit config", editor_cmd .. " " .. awesome.conffile },
       { "restart", awesome.restart },
       { "quit", function() awesome.quit() end },
    }

    mymainmenu = awful.menu({ items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }})

    mylauncher = awful.widget.launcher({ 
        image = beautiful.awesome_icon,
        menu = mymainmenu
    })

    -- Menubar configuration
    menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
    -- Create a textclock widget
    mytextclock = wibox.widget.textclock()

    -- Create a wibox for each screen and add it
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) 
            t:view_only() end),
        awful.button({modkey}, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end end),
        awful.button({ }, 3, 
            awful.tag.viewtoggle),
        awful.button({modkey}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end end),
        awful.button({ }, 4, function(t)
            awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t)
            awful.tag.viewprev(t.screen) end)
    )

    local tasklist_buttons = gears.table.join(
        awful.button({ }, 1, function(c)
              if c == client.focus then
                  c.minimized = true
              else
                  c:emit_signal( "request::activate", "tasklist", {raise = true})
              end
          end),
        awful.button({ }, 3, function() 
            awful.menu.client_list({theme = {width = 250}}) end),
        awful.button({ }, 4, function() 
            awful.client.focus.byidx(1) end),
        awful.button({ }, 5, function() 
            awful.client.focus.byidx(-1) end))

    local function set_wallpaper(s)
        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)

    awful.screen.connect_for_each_screen(function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Each screen has its own tag table.
        awful.tag({ "", "", "", "", "" }, s, awful.layout.layouts[1])

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
           awful.button({ }, 1, function() awful.layout.inc( 1) end),
           awful.button({ }, 3, function() awful.layout.inc(-1) end),
           awful.button({ }, 4, function() awful.layout.inc( 1) end),
           awful.button({ }, 5, function() awful.layout.inc(-1) end))
       )
        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_buttons
        }

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s, visible = false })

        -- Add padding for Polybar
        -- awful.screen.padding(screen[s], { top = 25, bottom = 25 })
        awful.screen.padding(screen[s], { top = 25 })

        -- Add widgets to the wibox
        s.mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                -- mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                -- mykeyboardlayout,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            },
        }
    end)
-- }}}

-- {{{ Mouse bindings
    root.buttons(gears.table.join(
        awful.button({ }, 3, function() mymainmenu:toggle() end)
        -- awful.button({ }, 4, awful.tag.viewnext),
        -- awful.button({ }, 5, awful.tag.viewprev)
    ))
-- }}}

-- {{{ Key bindings
    globalkeys = gears.table.join(
        awful.key({modkey, "Control"}, "s", hotkeys_popup.show_help, info("show help", "awesome")),
        awful.key({modkey}, "Escape", hotkeys_popup.show_help, info("show help", "awesome")),
        awful.key({modkey}, "Prior", awful.tag.viewprev, info("view previous", "tag")),
        awful.key({modkey}, "Next", awful.tag.viewnext, info("view next", "tag")),
        -- awful.key({modkey}, "Escape", awful.tag.history.restore, info("switch to last tag", "tag")),
        awful.key({alt_l}, "Tab", awful.tag.history.restore, info("switch to last tag", "tag")),
        awful.key({alt_r}, "Tab", awful.tag.history.restore, info("switch to last tag", "tag")),
        
        awful.key({modkey}, "j", function() awful.client.focus.byidx( 1) end, info("focus next by index", "client")),
        awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end, info("focus previous by index", "client")),

        -- Layout manipulation
        awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(  1) end, info("swap with next client by index", "client")),
        awful.key({modkey, "Shift"}, "k", function() awful.client.swap.byidx( -1) end, info("swap with previous client by index", "client")),
        awful.key({modkey, "Control"}, "j", function() awful.screen.focus_relative( 1) end, info("focus the next screen", "screen")),
        awful.key({modkey, "Control"}, "k", function() awful.screen.focus_relative(-1) end, info("focus the previous screen", "screen")),
        awful.key({modkey}, "u", awful.client.urgent.jumpto, info("jump to urgent client", "client")),
        awful.key({modkey}, "Tab",
            function()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
        info("go back", "client")),
        
        -- Lock Screen and Sleep
        awful.key({}, "XF86Sleep", run("i3lock-fancy-rapid 10 5")),

        -- Audio
        awful.key({}, "XF86AudioMute", run("pamixer -t")),
        awful.key({}, "XF86AudioRaiseVolume", run("pamixer -ui 5")),
        awful.key({}, "XF86AudioLowerVolume", run("pamixer -ud 5")),
        awful.key({}, "XF86AudioPrev", run("spotifyctl -q previous")),
        awful.key({}, "XF86AudioPlay", run("spotifyctl -q playpause")),
        awful.key({}, "XF86AudioNext", run("spotifyctl -q next")),

        -- Brightness
        awful.key({}, "XF86MonBrightnessUp", brightness(.05)),
        awful.key({}, "XF86MonBrightnessDown", brightness(-.05)),

        -- Network
        awful.key({modkey, "Shift"}, "r", run("nmcli d connect wlp2s0"), info("reload network", "system")),

        -- Polybar
        awful.key({modkey}, "p", run("/home/dribe/Scripts/toggle-polybar"), info("show/hide polybar", "system")),

        -- Task manager
        awful.key({"Ctrl", "Mod1"}, "m", run("xfce4-taskmanager"), info("open task manager", "system")),

        -- Screenshot
        awful.key({}, "Print", run("/home/dribe/Scripts/scs -ec"), info("copy entire screen", "screenshot")),
        awful.key({"Shift"}, "Print", run("/home/dribe/Scripts/scs -es"), info("save entire screen", "screenshot")),
        awful.key({modkey}, "s", run('/home/dribe/Scripts/scs -rc'), info("copy selected region", "screenshot")),
        awful.key({modkey, "Shift"}, "s", run('/home/dribe/Scripts/scs -rs'), info("save selected region", "screenshot")),

        -- Standard program
        awful.key({modkey}, "Return", function() awful.spawn(terminal) end, info("terminal", "launcher")),
        awful.key({modkey, "Control"}, "r", awesome.restart, info("reload awesome", "awesome")),
        awful.key({modkey, "Shift"}, "q", awesome.quit, info("quit awesome", "awesome")),

        awful.key({modkey}, "l", function() awful.tag.incmwfact( 0.05) end, info("increase master width factor", "layout")),
        awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end, info("decrease master width factor", "layout")),
        awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster( 1, nil, true) end, info("increase the number of master clients", "layout")),
        awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1, nil, true) end, info("decrease the number of master clients", "layout")),
        awful.key({modkey, "Control"}, "h", function() awful.tag.incncol( 1, nil, true) end, info("increase the number of columns", "layout")),
        awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1, nil, true) end, info("decrease the number of columns", "layout")),
        awful.key({modkey}, ",", function() awful.layout.inc(1) end, info("select next", "layout")),
        awful.key({modkey}, ".", function() awful.layout.inc(-1) end, info("select previous", "layout")),

        awful.key({modkey, "Shift"}, "n",
                  function()
                      local c = awful.client.restore()
                      -- Focus restored client
                      if c then
                        c:emit_signal("request::activate", "key.unminimize", {raise = true})
                      end
                  end,
                  info("restore minimized", "client")),

        -- Prompt
        -- awful.key({modkey}, "r", function() awful.screen.focused().mypromptbox:run() end, info("run", "launcher")),
        -- Lock
        awful.key({modkey, "Control", "Shift"}, "l", run("i3lock-fancy-rapid 10 5"), info("lock screen", "system")),
        -- Rofi
        awful.key({modkey}, "space", run("rofi -show drun"), info("rofi", "launcher")),
         -- Thunar
        awful.key({modkey}, "e", run("thunar"), info("thunar", "launcher")),
         -- Thunar desktop
        awful.key({modkey}, "d", run("thunar Desktop"), info("desktop", "launcher")),
         -- Firefox
        awful.key({modkey}, "b", run("firefox"), info("firefox", "launcher")),
        awful.key({modkey, "Shift"}, "b", run("firefox --private-window"), info("firefox incognito", "launcher")),
         -- Homepage
        awful.key({modkey, "Shift"}, "Return", run("firefox /home/dribe/Repos/nord-startpage-personal/index.html"), info("homepage", "launcher")),
         -- Telegram
        awful.key({modkey}, "t", run("telegram-desktop"), info("telegram", "launcher"))
    )

    clientkeys = gears.table.join(
        awful.key({modkey}, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            info("toggle fullscreen", "client")),
        awful.key({modkey}, "w", function(c) c:kill() end, info("close", "client")),
        awful.key({modkey, "Control"}, "space",  awful.client.floating.toggle, info("toggle floating", "client")),
        awful.key({modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, info("move to master", "client")),
        awful.key({modkey}, "o", function(c) c:move_to_screen() end, info("move to screen", "client")),
        awful.key({modkey}, "t", function(c) c.ontop = not c.ontop end, info("toggle keep on top", "client")),
                -- The client currently has the input focus, so it cannot be minimized, since minimized clients can't have the focus.
        awful.key({modkey}, "n", function(c) c.minimized = true end, info("minimize", "client")),
        awful.key({modkey}, "m", 
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            info("(un)maximize", "client")),
        awful.key({modkey, "Control"}, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            info("(un)maximize vertically", "client")),
        awful.key({modkey, "Shift"}, "m", 
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            info("(un)maximize horizontally", "client"))
    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = gears.table.join(globalkeys,
            -- View tag only.
            awful.key({modkey}, "#" .. i + 9,
                      function()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                               tag:view_only()
                            end
                      end,
                      info("view tag #"..i, "tag")),
            -- Toggle tag display.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                      function()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end,
                      info("toggle tag #" .. i, "tag")),
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                      function()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:move_to_tag(tag)
                              end
                         end
                      end,
                      info("move focused client to tag #"..i, "tag")),
            -- Toggle tag on focused client.
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                      function()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:toggle_tag(tag)
                              end
                          end
                      end,
                      info("toggle focused client on tag #" .. i, "tag"))
        )
    end

    clientbuttons = gears.table.join(
        awful.button({ }, 1, 
            function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
        awful.button({modkey}, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({modkey}, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    -- Set keys
    root.keys(globalkeys)
-- }}}

-- {{{ Rules
    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
            properties = { 
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen
            }
        },

        -- Floating clients.
        { rule_any = {
            instance = {
              "DTA",  -- Firefox addon DownThemAll.
              "copyq",  -- Includes session name in class.
              "pinentry",
            },
            class = {
              "Arandr",
              "Blueman-manager",
              "Gpick",
              "Kruler",
              "MessageWin",  -- kalarm.
              "Sxiv",
              "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
              "Wpa_gui",
              "veromix",
              "xtightvncviewer"},

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
              "Event Tester",  -- xev.
            },
            role = {
              "AlarmWindow",  -- Thunderbird's calendar.
              "ConfigManager",  -- Thunderbird's about:config.
              "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
          }, properties = { floating = true }},

        -- Add titlebars to normal clients and dialogs
        { 
            rule_any = { type = { "normal", "dialog" } }, 
            properties = { titlebars_enabled = false }
        },

        -- Remove Polybar Borders
        -- { 
        --     rule = { instance = "polybar" },
        --     properties = { border_width = false }
        -- },

        -- Set Firefox to always map on the tag named "2" on screen 1.
        --[[ {
            rule = { class = "Firefox" },
            properties = { screen = 1, tag = "2" }
        }, ]]--
    }
-- }}}

-- {{{ Signals
    -- Signal function to execute when a new client appears.
    client.connect_signal("manage", function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup
          and not c.size_hints.user_position
          and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end)

    -- Add a titlebar if titlebars_enabled is set to true in the rules.
    client.connect_signal("request::titlebars", function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
            end)
        )

        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end)

    -- Rounded corners
    client.connect_signal("manage", function (c)
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,0)
        end
    end)

    -- Enable sloppy focus, so that focus follows mouse.
    -- client.connect_signal("mouse::enter", function(c) 
    --     c:emit_signal("request::activate", "mouse_enter", {raise = false}) end)
    
    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart
    shell("nitrogen --restore")
    shell("polybar main")
--    shell("polybar top")
--    shell("polybar bottom")
--    shell("picom")
--    shell("~/scripts/init.sh")
-- }}}
