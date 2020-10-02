--[[
    Helo Helo
    snejus
    Based on Holo Awesome WM theme 3.0
    github.com/lcpz

    Requires
        IBM Plex font       IBM/plex
--]]

local dpi           = require("beautiful.xresources").apply_dpi
local lain          = require("lain")
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local keyboard_layout = require("keyboard_layout")
-- local net_widgets   = require("net_widgets")

local math, string, os = math, string, os
local markup = lain.util.markup
-- local net_interface_to_monitor = "wlp2s0"  -- network interface monitored by the widget

local COLOURS = {
    BLUE            = "#AF3A03",
    BLACK           = "#000000",
    WHITE           = "#FFFFFF",
    ORANGE          = "#FF9933",
    GOLDEN          = "#EDB879",
    BEAUTYBLUE      = "#80CCE6",
    BEAUTYPINK      = "#FFACE6",
    LIGHT_PINK      = "#CC9393",
    LIGHT_BLUE      = "#006B8E",
    LIGHTER_BLUE    = "#0099CC",
    DARK_GREY       = "#242424",
    DARKER_GREY     = "#202020",
}
local theme         = {}
theme.default_dir  = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir     = os.getenv("HOME") .. "/.config/awesome/themes/helohelo/icons"
-- theme.wallpaper    = os.getenv("HOME") .. "/.config/awesome/themes/holo/rave.jpg"
theme.wallpaper    = os.getenv("HOME") .. "/.config/awesome/themes/helohelo/dino.png"

-------------------------
--- DIMENSIONS / MISC ---
-------------------------
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true
theme.border_width             = dpi(2)
theme.menu_icon_size           = dpi(64)
theme.menu_height              = dpi(40)
theme.menu_width               = dpi(320)
theme.useless_gap              = dpi(8)

------------
--- FONT ---
------------
theme.smallfont = "IBM Plex Mono Bold 9"
theme.font      = "IBM Plex Mono Bold 10"
theme.largefont = "IBM Plex Mono Bold 11"

--------------
--- COLOUR ---
--------------
theme.fg_normal           = COLOURS.WHITE
theme.fg_focus            = COLOURS.LIGHTER_BLUE
theme.fg_urgent           = COLOURS.LIGHT_PINK

theme.bg_focus            = COLOURS.BLACK
theme.bg_normal           = COLOURS.BLACK
theme.bg_urgent           = COLOURS.LIGHT_BLUE

theme.border_focus        = COLOURS.ORANGE
theme.border_normal       = COLOURS.DARK_GREY

theme.taglist_fg_focus    = COLOURS.BEAUTYBLUE
theme.taglist_bg_urgent   = COLOURS.BLACK
theme.taglist_fg_empty    = COLOURS.ORANGE
theme.taglist_fg_occupied = COLOURS.ORANGE
theme.taglist_spacing     = dpi(1)

theme.tasklist_fg_focus  = COLOURS.ORANGE
theme.tasklist_bg_normal = COLOURS.BLACK

-------------
--- ICONS ---
-------------
theme.awesome_icon                               = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                      = theme.icon_dir .. "/awesome_icon.png"

-- theme.taglist_squares_unsel                      = theme.icon_dir .. "/square_unsel.png"
-- theme.taglist_squares_sel                        = theme.icon_dir .. "/square_sel.png"

theme.spr_bottom_right                           = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_very_small                             = theme.icon_dir .. "/spr_very_small.png"
theme.spr_small                                  = theme.icon_dir .. "/spr_small.png"
theme.spr_right                                  = theme.icon_dir .. "/spr_right.png"
theme.spr_left                                   = theme.icon_dir .. "/spr_left.png"

theme.bar                                        = theme.icon_dir .. "/bar.png"
theme.nex                                        = theme.icon_dir .. "/next.png"
theme.prev                                       = theme.icon_dir .. "/prev.png"
theme.stop                                       = theme.icon_dir .. "/stop.png"
theme.play                                       = theme.icon_dir .. "/play.png"
theme.pause                                      = theme.icon_dir .. "/pause.png"
theme.cpu                                        = theme.icon_dir .. "/cpu_arc.svg"
theme.mpd                                        = theme.icon_dir .. "/mpd_arc.png"
-- theme.mpd_on                                     = theme.icon_dir .. "/mpd_on.png"
theme.bottom_bar                                 = theme.icon_dir .. "/bottom_bar.png"
theme.system_time                                = theme.icon_dir .. "/system_time_arc.svg"
theme.calendar                                   = theme.icon_dir .. "/calendar_arc.svg"
theme.network_receive                            = theme.icon_dir .. "/network_receive_arc.svg"
theme.network_transmit                           = theme.icon_dir .. "/network_transmit_arc.svg"


theme.layout_max                                 = theme.icon_dir .. "/max.png"
theme.layout_tile                                = theme.icon_dir .. "/tile.png"
theme.layout_fairv                               = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                               = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                              = theme.icon_dir .. "/spiral.png"
theme.layout_tiletop                             = theme.icon_dir .. "/tiletop.png"
theme.layout_dwindle                             = theme.icon_dir .. "/dwindle.png"
theme.layout_floating                            = theme.icon_dir .. "/floating.png"
theme.layout_tileleft                            = theme.icon_dir .. "/tileleft.png"
theme.layout_magnifier                           = theme.icon_dir .. "/magnifier.png"
theme.layout_tilebottom                          = theme.icon_dir .. "/tilebottom.png"
theme.layout_fullscreen                          = theme.icon_dir .. "/fullscreen.png"

theme.titlebar_close_button_focus                = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_close_button_normal               = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_minimize_button_focus             = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_minimize_button_normal            = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_ontop_button_focus_inactive       = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive      = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_normal_active        = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active         = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_focus_inactive      = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive     = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_normal_active       = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active        = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_focus_inactive    = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive   = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_normal_active     = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active      = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_focus_inactive   = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive  = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_normal_active    = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active     = theme.default_dir.."/titlebar/maximized_focus_active.png"

-------------
--- AUDIO ---
-------------
theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

-------------------------------------------------- SETTINGS DECLARED

-- We use this a lot, so two colours get pre-configured
local function coloured_markup(font, colour)
    return function(text)
        return markup.fontfg(font, colour, text)
    end
end
local orange_markup = coloured_markup(theme.font, COLOURS.ORANGE)
local blue_markup = coloured_markup(theme.font, COLOURS.BEAUTYBLUE)
local golden_markup = coloured_markup(theme.largefont, COLOURS.GOLDEN)
local pink_markup = coloured_markup(theme.largefont, COLOURS.BEAUTYPINK)

-- Also be able to pre-define widget parameters
local function paramd_widget(widget)
    return function(left, right, top, bottom)
        return function(content)
            return widget(content, dpi(left), dpi(right), dpi(top), dpi(bottom))
        end
    end
end

-- And pre-define an imagebox that does not resize
local function noresize_imagebox(image)
    return wibox.widget.imagebox(image, false)
end

-- Pre-define mostly used parameters to be called later
local margins_widget = paramd_widget(wibox.container.margin)
local topdown_margins_widget = margins_widget(0, 0, 5, 5)
local function icon_widget(image)
    return margins_widget(5, 5, 8, 0)(noresize_imagebox(image))
end

-- Clock
local clock_widget = margins_widget(0, 0, 3, 3)(wibox.widget.textclock(golden_markup("%H:%M")))
local clock_icon = icon_widget(theme.system_time)

-- Calendar
local calendar_widget = margins_widget(0, 5, 5, 5)(wibox.widget.textclock(golden_markup("%d %b")))
local calendar_icon = margins_widget(0, 5, 8, 0)(noresize_imagebox(theme.calendar))
theme.cal = lain.widget.cal({
    attach_to = { clock_widget, clock_icon, calendar_widget, calendar_icon },
    notification_preset = {
        fg = COLOURS.ORANGE,
        bg = theme.bg_focus,
        font = theme.largefont,
        position = "top_middle",
    }
})

-- MPD
-- local mpd_icon = margins_widget(0, 0, 2, 2)(awful.widget.launcher({ image = theme.mpd, command = theme.musicplr }))
-- theme.mpd = lain.widget.mpd({
--     host="/run/user/1000/mpd/socket",
--     music_dir="~/music",
--     settings = function ()
--         local widget, mpd_now = widget, mpd_now
--         if mpd_now.state == "play" then
--             mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
--             mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)

--             local MAXLENGTH = 100
--             local SPACE = " "
--             local text = mpd_now.artist .. " - " ..  mpd_now.title
--             text = text:sub(0, MAXLENGTH - 2)
--             local length = text:len()
--             local extraspaces = SPACE:rep(math.floor((MAXLENGTH - length) / 2))
--             local progress = mpd_now.elapsed / mpd_now.time
--             local index = math.floor(length * progress)
--             local orangetext = extraspaces .. text:sub(0, index)
--             local bluetext = text:sub(index + 1, length) .. extraspaces
--             widget:set_markup(orange_markup(orangetext) .. blue_markup(bluetext))

--         elseif mpd_now.state == "pause" then
--             widget:set_markup(orange_markup(" MPD PAUSED "))
--         else
--             widget:set_markup("")
--         end
--     end
-- })
-- local musicwidget = topdown_margins_widget(theme.mpd.widget)

-- ALSA volume bar
theme.volume = lain.widget.alsabar({
    notification_preset = { font = theme.font},
    width = dpi(200), height = dpi(10), border_width = dpi(0),
    colors = {
        background = COLOURS.BLACK,
        unmute     = COLOURS.BEAUTYBLUE,
        mute       = COLOURS.LIGHT_PINK
    },
})
theme.volume.bar.paddings = dpi(0)
theme.volume.bar.margins = dpi(5)
local volumewidget = topdown_margins_widget(theme.volume.bar)


-- Network
-- local net_wireless = net_widgets.wireless({interface=net_interface_to_monitor, font=theme.font})
-- local net_internet = net_widgets.internet({indent = 0, timeout = 5})
----

-- fs
-- requires Gio/Glib >= 2.54
theme.fs = lain.widget.fs({
    notification_preset = { bg = theme.bg_normal, font = theme.font},
})

-- CPU
local cpu_icon = icon_widget(theme.cpu)
local cpu = lain.widget.cpu({settings = function() widget:set_markup(orange_markup("CPU " .. cpu_now.usage .. "%")) end})
local cpuwidget = margins_widget(0, 10, 5, 5)(cpu.widget)

-- Net
local netdown = lain.widget.net({settings = function() widget:set_markup(orange_markup(net_now.received)) end})
local netup = lain.widget.net({settings = function() widget:set_markup(orange_markup(net_now.sent)) end})
local netdown_icon = icon_widget(theme.network_receive)
local netup_icon = icon_widget(theme.network_transmit)
local netdownwidget = topdown_margins_widget(netdown.widget)
local netupwidget = topdown_margins_widget(netup.widget)

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2643743, -- London
    notification_preset = { font = theme.largefont, position = "bottom_right" },
})

-- Language
local kbdcfg = keyboard_layout.kbdcfg({type = "tui"})

kbdcfg.add_primary_layout("English", "US", "us")

kbdcfg.add_additional_layout("Lietuvių", "LT", "lt")
kbdcfg.add_additional_layout("Deutsch",  "DE", "de")
kbdcfg.bind()

kbdcfg.widget:buttons(
    awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch_next() end),
                          awful.button({ }, 3, function () kbdcfg.menu:toggle() end))
)

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

    -- Taglist
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    s.mytag = margins_widget(2, 2, 5, 5)(s.mytaglist)

    -- Prompt
    s.mypromptbox = awful.widget.prompt()

    -----------------
    --- TOP WIBOX ---
    -----------------
    s.topwibox = awful.wibar({ position = "top", screen = s, height = dpi(32) })
    s.topborderwibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(1),
        bg = COLOURS.BEAUTYBLUE,
        x = dpi(33),
        y = dpi(0)
    })

    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            s.mytag,
            s.mypromptbox
        },
        { -- Center
            layout = wibox.layout.fixed.horizontal,
            -- cpu_icon,
            -- cpuwidget,
            -- calendar_icon,
            calendar_widget,
            clock_widget,
            -- clock_icon,
            -- net_wireless,
            -- net_internet,
            -- netdown_icon,
            -- netdownwidget,
            -- netup_icon,
            -- netupwidget,
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            kbdcfg.widget,
            -- wibox.widget.systray(),
            -- bat.widget,
            -- musicwidget,
            volumewidget,
            -- mpd_icon,
        },
    }
end

return theme
