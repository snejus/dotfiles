--[[

    Sarunas Holo
    Based on Holo Awesome WM theme 3.0
    github.com/lcpz

--]]

local gears         = require("gears")
local lain          = require("lain")
local awful         = require("awful")
local wibox         = require("wibox")
local dpi           = require("beautiful.xresources").apply_dpi
local net_widgets   = require("net_widgets")

local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local net_interface_to_monitor = "wlp2s0"  -- network interface that will be monitored in the widget

local COLOURS = {
    BLUE            = "#AF3A03",
    BLACK           = "#000000",
    WHITE           = "#FFFFFF",
    ORANGE          = "#FF9933",
    BEAUTYBLUE      = "#80CCE6",
    LIGHT_PINK      = "#CC9393",
    LIGHT_BLUE      = "#006B8E",
    LIGHTER_BLUE    = "#0099CC",
    DARK_GREY       = "#242424",
    DARKER_GREY     = "#202020",
    -- "#222222"  -- blackish
}
local theme                                     = {}
theme.default_dir  = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir     = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper    = os.getenv("HOME") .. "/.config/awesome/themes/holo/dino.jpg"

-------------------------
--- DIMENSIONS / MISC ---
-------------------------
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true
theme.border_width             = dpi(2)
theme.menu_icon_size           = dpi(32)
theme.menu_height              = dpi(20)
theme.menu_width               = dpi(160)
theme.useless_gap              = dpi(8)

-------------
--- FONT ---
-------------
theme.smallfont = "IBM Plex Mono Bold 9"
theme.font      = "IBM Plex Mono Bold 10"
theme.largefont = "IBM Plex Mono Bold 11"

---------------
--- COLOUR ---
---------------
theme.fg_normal          = COLOURS.WHITE
theme.fg_focus           = COLOURS.LIGHTER_BLUE
theme.fg_urgent          = COLOURS.LIGHT_PINK

theme.bg_focus           = COLOURS.DARKER_GREY
theme.bg_normal          = COLOURS.DARK_GREY
theme.bg_urgent          = COLOURS.LIGHT_BLUE

theme.border_focus       = COLOURS.ORANGE
theme.border_normal      = COLOURS.DARK_GREY

theme.taglist_fg_focus   = COLOURS.BLACK
theme.taglist_fg_normal  = COLOURS.BLACK

theme.tasklist_fg_focus  = COLOURS.ORANGE
theme.tasklist_bg_normal = COLOURS.DARK_GREY

-------------
--- ICONS ---
-------------
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"

theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"

theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"

theme.bar                                       = theme.icon_dir .. "/bar.png"
-- theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.nex                                       = theme.icon_dir .. "/next.png"
-- theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
theme.prev                                      = theme.icon_dir .. "/prev.png"
theme.stop                                      = theme.icon_dir .. "/stop.png"
theme.play                                      = theme.icon_dir .. "/play.png"
theme.pause                                     = theme.icon_dir .. "/pause.png"
-- theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
-- theme.net_up                                    = theme.icon_dir .. "/net_up.png"
-- theme.net_down                                  = theme.icon_dir .. "/net_down.png"
-- theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"

theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"

theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"

theme.cpu_arc                                   = theme.icon_dir .. "/cpu_arc.svg"
theme.mpd_arc                                   = theme.icon_dir .. "/mpd_arc.png"
theme.system_time                               = theme.icon_dir .. "/system_time_arc.svg"
theme.calendar_arc                              = theme.icon_dir .. "/calendar_arc.svg"
theme.network_transmit_arc                      = theme.icon_dir .. "/network_transmit_arc.svg"
theme.network_receive_arc                       = theme.icon_dir .. "/network_receive_arc.svg"

-------------
--- AUDIO ---
-------------
theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

--------------------------------------------------------------------

local markup = lain.util.markup

-- Clock
local clock = wibox.widget.textclock(markup.fontfg(theme.font, COLOURS.ORANGE, "%H:%M"))
local clock_widget = wibox.container.margin(clock, dpi(0), dpi(0), dpi(3), dpi(3))

local clock_img = wibox.widget.imagebox(theme.system_time, false)
local clock_icon = wibox.container.margin(clock_img, dpi(5), dpi(15), dpi(8), dpi(3))

-- Calendar
local calendar = wibox.widget.textclock(markup.fontfg(theme.font, COLOURS.ORANGE, "%d %b"))
local calendar_widget = wibox.container.margin(calendar, dpi(0), dpi(5), dpi(5), dpi(5))

local calendar_img = wibox.widget.imagebox(theme.calendar_arc, false)
local calendar_icon = wibox.container.margin(calendar_img, dpi(0), dpi(5), dpi(8), dpi(0))
theme.cal = lain.widget.cal({
    attach_to = { clock, calendar },
    notification_preset = {
        fg = COLOURS.ORANGE,
        bg = theme.bg_focus,
        position = "bottom_right",
        font = theme.largefont
    }
})

-- Mail IMAP check
--[[ commented because it needs to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        mail_notification_preset.fg = "#FFFFFF"
        mail  = ""
        count = ""

        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(blue, mail) .. markup("#FFFFFF", count)))
    end
})
--]]

-- MPD
local mpd_icon = awful.widget.launcher({ image = theme.mpd_arc, command = theme.musicplr })
theme.mpd = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.fontfg(theme.smallfont, COLOURS.BEAUTYBLUE, mpd_now.artist .. " - " ..  mpd_now.title .. "  "))

        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.smallfont, " MPD PAUSED "))
        else
            widget:set_markup("")
        end
    end
})
local musicwidget = wibox.container.margin(theme.mpd.widget, dpi(0), dpi(0), dpi(5), dpi(5))


-- Network
local net_wireless = net_widgets.wireless({interface=net_interface_to_monitor, font=theme.font})
local net_internet = net_widgets.internet({indent = 0, timeout = 5})
----

-- / fs
-- requires Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { bg = theme.bg_normal, font = theme.font},
})

-- ALSA volume bar
theme.volume = lain.widget.alsabar({
    notification_preset = { font = theme.font},
    width = dpi(150), height = dpi(10), border_width = dpi(0),
    colors = {
        background = COLOURS.BLACK,
        unmute     = COLOURS.BEAUTYBLUE,
        mute       = COLOURS.LIGHT_PINK
    },
})
theme.volume.bar.paddings = dpi(0)
theme.volume.bar.margins = dpi(5)
local volumewidget = wibox.container.margin(theme.volume.bar, dpi(0), dpi(0), dpi(5), dpi(5))

-- CPU
local cpu_img = wibox.widget.imagebox(theme.cpu_arc, false)
local cpu_icon = wibox.container.margin(cpu_img, dpi(5), dpi(5), dpi(8), dpi(0))
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, COLOURS.ORANGE, "CPU " .. cpu_now.usage .. "%  "))
    end
})
local cpuwidget = wibox.container.margin(cpu.widget, dpi(0), dpi(5), dpi(5), dpi(5))

-- Net
local netdown_img = wibox.widget.imagebox(theme.network_receive_arc, false)
local netup_img = wibox.widget.imagebox(theme.network_transmit_arc, false)
local netdown_icon = wibox.container.margin(netdown_img, dpi(5), dpi(5), dpi(8), dpi(0))
local netup_icon = wibox.container.margin(netup_img, dpi(5), dpi(5), dpi(8), dpi(0))

local netdown = lain.widget.net({
    settings = function() widget:set_markup(markup.fontfg(theme.font, COLOURS.ORANGE, net_now.received)) end
})
local netup = lain.widget.net({
    settings = function() widget:set_markup(markup.fontfg(theme.font, COLOURS.ORANGE, net_now.sent)) end
})
local netdownwidget = wibox.container.margin(netdown.widget, dpi(0), dpi(0), dpi(5), dpi(5))
local netupwidget = wibox.container.margin(netup.widget, dpi(0), dpi(10), dpi(5), dpi(5))

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = theme.largefont, position = "bottom_right" },
})

-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 9"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    s.mytag = wibox.container.margin(s.mytaglist, dpi(2), dpi(2), dpi(5), dpi(5))

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s,
        awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, {
            bg_focus = theme.bg_focus,
            shape = gears.shape.rectangle,
            -- shape_border_width = 1,
            -- shape_border_color = COLOURS.WHITE,
            align = "center" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytag,
            spr_small,
            s.mylayoutbox,
            spr_small,
            s.mypromptbox,
        },
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- wibox.widget.systray(),
            --theme.mail.widget,
            -- bat.widget,
            -- prev_icon,
            -- next_icon,
            -- stop_icon,
            -- play_pause_icon,
            -- bar,
            musicwidget,
            volumewidget,
            mpd_icon,
        },
    }

    -- Create the bottom wibox
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = dpi(0), height = dpi(32) })
    s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(1), bg = COLOURS.BEAUTYBLUE, x = dpi(0), y = dpi(33)})

    -- Add widgets to the bottom wibox
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            net_wireless,
            net_internet,
            netdown_icon,
            netdownwidget,
            netup_icon,
            netupwidget,
            cpu_icon,
            cpuwidget,
            calendar_icon,
            calendar_widget,
            clock_widget,
            clock_icon,
        },
    }
end

return theme
