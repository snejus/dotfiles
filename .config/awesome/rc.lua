--[[
    Helo helo
    snejus
        Based on lcpz/awesome-copycats

    Mentions
        slack                   chat
        slock                   screen lock
        tilix                   terminal
        evolution               emails
        flameshot               screenshots
        brave-browser           browser
        mpd / mpc / ncmpcpp     music
--]]

---------------
--- IMPORTS ---
---------------
local awesome, client, screen, root = awesome, client, screen, root

local dpi           = require("beautiful.xresources").apply_dpi
local lain          = require("lain")
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local naughty       = require("naughty")
local beautiful     = require("beautiful")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")

----------------------
--- ERROR HANDLING ---
----------------------
local function notify_errors(text) -- notify errors and switch to the fallback config if needed
    naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, errors!", text = text })
end

-- Startup
if awesome.startup_errors then notify_errors(awesome.startup_errors) end

-- Runtime
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true; notify_errors(tostring(err)); in_error = false
    end)
end

----------------------------
--- WINDOWLESS PROCESSES ---
----------------------------
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
run_once({ "unclutter -root" })

-- XDG autostart specification (I don't have dex currently though)
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";'
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    -- 'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"'
         -- https://github.com/jceb/dex
)


-----------------
--- VARIABLES ---
-----------------
local altkey       = "Mod1"
local modkey       = "Mod4"

local terminal     = "tilix"
local scrlocker    = "slock"
local editor       = os.getenv("EDITOR") or "vim"

local cycle_prev   = false -- cycle trough all previous client or just the first
                           -- https://github.com/lcpz/awesome-copycats/issues/274
                           --
local theme            = "helohelo"
local path_to_theme    = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme)
local enable_titlebars = false
local local_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

local KB_GROUPS = { -- keyboard binding group names
    TAG = "tag",
    CLIENT = "client",
    SCREEN = "screen",
    LAYOUT = "layout",
    WIDGET = "widgets",
    SOUND = "music / sound",
    LAUNCHER = "awesome / launcher",
}

--------------
--- LAYOUT ---
--------------
---   ᚊ   ᚏ   ᚅ    ᚔ ᚔ    ᚙ  ណ    ᭄  ឦ     -⃢ -⃢    ꫞
awful.util.terminal = terminal
awful.util.tagnames = { "A", "B", "C", "D", "E" }
awful.layout.layouts = {
    awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    lain.layout.cascade.tile,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- lain.layout.termfair,
    -- lain.layout.termfair.center,
}

-- lain.layout.termfair.nmaster           = 3
-- lain.layout.termfair.ncol              = 1
-- lain.layout.termfair.center.nmaster    = 3
-- lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 3


-- taglist mouse control: 1 - left click, 3 - right click, 4, 5 - scroll
awful.util.taglist_buttons = local_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

beautiful.init(path_to_theme)

------------
--- MENU ---
------------
local awesomemenu = {
    { "hotkeys               MOD + s", function() return false, hotkeys_popup.show_help end },
    { "manual                       ", terminal .. " -e man awesome" },
    { "edit config                  ", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart        CTRL + MOD + r", awesome.restart },
    { "quit           CTRL + MOD + q", function() awesome.quit() end }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or dpi(16),
    before = {{ "Awesome", awesomemenu, beautiful.awesome_icon }},
    after = {{ "Open terminal", terminal }}
})

--------------
--- SCREEN ---
--------------
-- Reset wallpaper when screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    local wallpaper = beautiful.wallpaper
    if wallpaper then
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders for maximised clients
screen.connect_signal("arrange", function (s)
    for _, c in pairs(s.clients) do
        if c.maximized then c.border_width = 0 else c.border_width = beautiful.border_width end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)


----------------------
--- MOUSE BINDINGS ---
----------------------
root.buttons(local_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

--------------------
--- KEY BINDINGS ---
--------------------
local function describe_group(group)
   return function(description)
        return {description = description, group = group}
   end
end

local descr = describe_group(KB_GROUPS.LAUNCHER)
local globalkeys = local_table.join(
    -- awful.key({ "Alt_L"           }, "Space", function () mykeyboardlayout.next_layout(); end),
    --- LAUNCHER ---
    awful.key({ modkey }, "s", hotkeys_popup.show_help, descr("show key bindings")),
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end, descr("open terminal")),
    awful.key({ modkey }, "w", function () awful.util.mymainmenu:show() end, descr("show main menu")),
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end, descr("run prompt")),
    awful.key({ modkey }, "x", function () os.execute("rofi -show combi") end, descr("show rofi")),
    awful.key({ modkey }, "z", function () awful.screen.focused().quake:toggle() end, descr("dropdown application")),
    -- awful.key({ altkey }, "y", function () os.execute("flameshot gui") end, descr("screenshot")),
    awful.key({ altkey, "Control" }, "l", function () os.execute(scrlocker) end, descr("lock screen")),
    awful.key({ modkey, "Control" }, "r", awesome.restart, descr("reload awesome")),
    awful.key({ modkey, "Control" }, "q", awesome.quit, descr("quit awesome")),
    awful.key({ modkey }, "b", function ()
            for s in screen do
                if s.topwibox then s.topwibox.visible = not s.topwibox.visible end
                if s.mybottomwibox then s.mybottomwibox.visible = not s.mybottomwibox.visible end
            end
        end,  descr("toggle wibox"))
)

--- SCREEN ---
descr = describe_group(KB_GROUPS.SCREEN)
globalkeys = local_table.join(globalkeys,
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, descr("focus next screen")),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, descr("focus prev screen"))
)


--- CLIENT ---
descr = describe_group(KB_GROUPS.CLIENT)
globalkeys = local_table.join(globalkeys,
    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end, descr("focus next by index")),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end, descr("focus previous by index")),
    awful.key({ modkey }, "h", function () awful.client.focus.global_bydirection("left")
        if client.focus then client.focus:raise() end end, descr("focus left")),
    awful.key({ modkey }, "l", function () awful.client.focus.global_bydirection("right")
        if client.focus then client.focus:raise() end end, descr("focus right")),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, descr("jump to urgent client")),
    awful.key({ modkey }, "Tab", function ()
        if cycle_prev then awful.client.focus.history.previous() else awful.client.focus.byidx(-1) end
        if client.focus then client.focus:raise() end end, descr("cycle with previous/go back")),
    awful.key({ modkey, "Shift" }, "j", function ()
        awful.client.swap.byidx(  1) end, descr("swap with next client by index")),
    awful.key({ modkey, "Shift" }, "k", function ()
        awful.client.swap.byidx( -1) end, descr("swap with previous client by index")),
    awful.key({ modkey, "Shift" }, "Tab", function () if cycle_prev then awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end end end, descr("go forth")),
    awful.key({ modkey, "Control" }, "n", function () local c = awful.client.restore()
        if c then client.focus = c; c:raise() end end, descr("restore minimized"))
)

--- TAG ---
descr = describe_group(KB_GROUPS.TAG)
globalkeys = local_table.join(globalkeys,
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end, descr("add new tag")),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end, descr("rename tag")),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end, descr("delete tag")),
    awful.key({ modkey, "Shift" }, "p", function () awful.tag.togglemfpol() end, descr("toggle size fill policy")),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end, descr("move tag to the left")),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end, descr("move tag to the right"))
)

--- LAYOUT ---
descr = describe_group(KB_GROUPS.LAYOUT)
globalkeys = local_table.join(globalkeys,
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, descr("toggle floating")),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, descr("make main client")),
    awful.key({ modkey, "Shift"   }, "h", function () awful.tag.incnmaster( 1, nil, true) end, descr("+1 master client")),
    awful.key({ modkey, "Shift"   }, "l", function () awful.tag.incnmaster(-1, nil, true) end, descr("-1 master client")),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1) end, descr("select previous")),
    awful.key({ modkey            }, "space", function () awful.layout.inc( 1) end, descr("select next")),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(1) end, descr("+ useless gaps")),
    awful.key({ altkey, "Control" }, "=", function () lain.util.useless_gaps_resize(-1) end, descr("- useless gaps")),
    awful.key({ altkey, "Shift"   }, "l", function () awful.tag.incmwfact( 0.05) end, descr("wider main client")),
    awful.key({ altkey, "Shift"   }, "h", function () awful.tag.incmwfact(-0.05) end, descr("narrower main client"))
)

--- WIDGET POPUPS ---
descr = describe_group(KB_GROUPS.WIDGET)
globalkeys = local_table.join(globalkeys,
    awful.key({ altkey }, "c", function () beautiful.cal.show(7) end, descr("show calendar")),
    awful.key({ altkey }, "h", function () beautiful.fs.show(7) end, descr("show filesystem")),
    awful.key({ altkey }, "w", function () beautiful.weather.show(7) end, descr("show weather"))
)

-- Music and sound.
-- F5           previous track
-- F6           volume down
-- F7           volume up
-- F8           next track
-- F9           play / pause
-- F10          replay track
-- Shift + F9   repeat

local vol = beautiful.volume
local mpd = beautiful.mpd
local host = "--host /run/user/1000/mpd/socket"
local function update(component, command)
   return function() os.execute(command) component.update() end
end
descr = describe_group(KB_GROUPS.SOUND)
globalkeys = local_table.join(globalkeys,
    awful.key({ modkey }, "F5", function() os.execute(string.format("amixer -q set %s 3%%-", beautiful.volume.channel)) beautiful.volume.update() end, descr("volume down")),
    awful.key({ modkey }, "F6", update(mpd, "mpc prev " .. host), descr("mpc prev")),
    awful.key({ modkey }, "F7", update(mpd, "mpc next " .. host), descr("mpc next")),
    awful.key({ modkey }, "F8", function() os.execute(string.format("amixer -q set %s 3%%+", beautiful.volume.channel)) beautiful.volume.update() end, descr("volume up")),
    awful.key({ modkey }, "F9", update(mpd, "mpc toggle " .. host), descr("mpc toggle: play / pause")),
    awful.key({ modkey }, "F10", update(mpd, "mpc seek 0:00 " .. host), descr("mpc replay")),
    awful.key({ modkey, "Shift" }, "F9", function () os.execute(terminal .. " -e ncmpcpp") end, descr("open ncmpcpp"))
)

------- CLIENT KEYS -----------
descr = describe_group(KB_GROUPS.CLIENT)
local clientkeys = local_table.join(
    awful.key({ altkey }, "q", function (c) c:kill() end, descr("close")),
    awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen c:raise() end, descr("fullscreen")),
    awful.key({ modkey }, "o", function (c) c:move_to_screen() end, descr("move to another screen")),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end, descr("keep on top")),
    awful.key({ modkey }, "n", function (c) c.minimized = true end, descr("minimize")),
    awful.key({ modkey }, "m", function (c) c.maximized = not c.maximized c:raise() end, descr("maximize"))
)

descr = describe_group(KB_GROUPS.TAG)
-- Bind all key numbers to tags.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = descr("view tag #")
        descr_toggle = descr("toggle tag #")
        descr_move = descr("move focused client to tag #")
        descr_toggle_focus = descr("toggle focused client on tag #")
    end
    globalkeys = local_table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function () local tag = awful.screen.focused().tags[i]; if tag then tag:view_only() end end, descr_view),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function () local tag = awful.screen.focused().tags[i] if tag then awful.tag.viewtoggle(tag) end end, descr_toggle),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:move_to_tag(tag) end end end, descr_move),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:toggle_tag(tag) end end end, descr_toggle_focus)
    )
end

local clientbuttons = gears.table.join(
    awful.button({        }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.resize(c) end)
)

-- Set keys
root.keys(globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = true
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } }, properties = { titlebars_enabled = enable_titlebars } },

    -- Set Brave to always map on the second tag on screen 1.
    { rule = { class = "Brave" }, properties = { screen = 1, tag = awful.util.tagnames[2] } },
    { rule = { class = "Slack" }, properties = { screen = 1, tag = awful.util.tagnames[3] } },
    { rule = { class = "Evolution" }, properties = { screen = 1, tag = awful.util.tagnames[3] } },
    -- { rule = { class = "Gvim" }, properties = { maximized = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = local_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function() c:kill() end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(16)}) : setup {
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

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- possible workaround for tag preservation when switching back to default screen:
-- https://github.com/lcpz/awesome-copycats/issues/251
-- }}}
