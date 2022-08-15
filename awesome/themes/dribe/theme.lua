-------------------------------
--[[ Default awesome theme ]]--
-------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = {}

theme.font          = "Sans Regular 8" -- "sans 8"

theme.bg_normal     = "#2e3440" -- "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#4c566a"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = "#4c566a" -- "#2E3440" -- "#000000"
theme.border_focus  = "#81A1C1" -- "#4c566a" -- "#535d6c"
theme.border_marked = "#91231c"

--[[
There are other variable sets overriding the dribe one when defined, the sets are:
    taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
    tasklist_[bg|fg]_[focus|urgent]
    titlebar_[bg|fg]_[normal|focus]
    tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
    mouse_finder_[color|timeout|animate_timeout|radius|factor]
    prompt_[fg|bg|fg_cursor|bg_cursor|font]
    hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|
    label_fg|group_margin|font|description_font]
Example: 
    theme.taglist_bg_focus = "#ff0000"
--]]

-- Generate taglist squares:
local taglist_square_size = dpi(5)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."dribe/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
titlebar_path = themes_path.."dribe/titlebar/"
theme.titlebar_close_button_normal = titlebar_path.."close_normal.png"
theme.titlebar_close_button_focus  = titlebar_path.."close_focus.png"
theme.titlebar_minimize_button_normal = titlebar_path.."minimize_normal.png"
theme.titlebar_minimize_button_focus  = titlebar_path.."minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive = titlebar_path.."ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = titlebar_path.."ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = titlebar_path.."ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = titlebar_path.."ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive = titlebar_path.."sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = titlebar_path.."sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = titlebar_path.."sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = titlebar_path.."sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive = titlebar_path.."floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = titlebar_path.."floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = titlebar_path.."floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = titlebar_path.."floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = titlebar_path.."maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = titlebar_path.."maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = titlebar_path.."maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = titlebar_path.."maximized_focus_active.png"

theme.wallpaper = themes_path.."dribe/wallpapers/ocean-2.jpg"

-- You can use your own layout icons like this:
layouts_path = themes_path.."dribe/layouts/"
theme.layout_fairh = layouts_path.."fairhw.png"
theme.layout_fairv = layouts_path.."fairvw.png"
theme.layout_floating  = layouts_path.."floatingw.png"
theme.layout_magnifier = layouts_path.."magnifierw.png"
theme.layout_max = layouts_path.."maxw.png"
theme.layout_fullscreen = layouts_path.."fullscreenw.png"
theme.layout_tilebottom = layouts_path.."tilebottomw.png"
theme.layout_tileleft   = layouts_path.."tileleftw.png"
theme.layout_tile = layouts_path.."tilew.png"
theme.layout_tiletop = layouts_path.."tiletopw.png"
theme.layout_spiral  = layouts_path.."spiralw.png"
theme.layout_dwindle = layouts_path.."dwindlew.png"
theme.layout_cornernw = layouts_path.."cornernww.png"
theme.layout_cornerne = layouts_path.."cornernew.png"
theme.layout_cornersw = layouts_path.."cornersww.png"
theme.layout_cornerse = layouts_path.."cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- theme.icon_theme = nil
theme.icon_theme = "/usr/share/icons/Nordzy-dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
