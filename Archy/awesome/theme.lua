---------------------------
-- sky awesome theme --
---------------------------

theme         = {}
--theme.font  = "Ericsson GA628 12"
--theme.font  = "Liberation mono 11"
--theme.font  = "Anonymous Pro 8"
-- theme.font = "Verily Serif Mono 9"
-- theme.font    = "Latin Modern Mono 8"
theme.font  = "terminus 8"

theme.bg_normal          = "#101010F0"
theme.fg_normal          = "#268BD2"
theme.fg_focus           = "#101010"
theme.bg_focus           = "#268BD2F0"
theme.bg_urgent          = "#3f3f3f60"
theme.fg_urgent          = "#e34c10"
theme.bg_minimize        = "#10101060"
theme.fg_minimize        = "#008282"
theme.bg_systray         = "#10101060"
theme.tasklist_bg_normal = "#101010F0"
theme.tasklist_fg_normal = "#0258C8"
theme.tasklist_bg_focus  = "#101010F0"
theme.tasklist_fg_focus  = "#00FFFF"
theme.taglist_fg_focus   = "#101010F0"
theme.taglist_bg_focus   = "#268BD2"


theme.border_width  = 1
theme.border_normal = "#3f3f3f55"
theme.border_focus  = "#00a6dc55"
theme.border_marked = "#cc939355"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/mario/.config/awesome/figs/bookmark.png"
theme.taglist_squares_unsel = "/home/mario/.config/awesome/figs/darkarrowmini.png"
-- theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

local pathWallpaper = "/home/mario/.config/awesome/Wallpapers/"
local nameWallpaper = {
        "Darkspace.png",
        "Orbit.png",
        "Purple.png"
}

theme.wallpaper = {}
for i, name in ipairs(nameWallpaper) do
  theme.wallpaper[i] = pathWallpaper .. nameWallpaper[i]
end
-- vertical_wallpaper_name = "NaviVertical.jpg"
-- theme.vertical_wallpaper = pathWallpaper .. vertical_wallpaper_name

-- You can use your own layout icons like this:
local pathLayoutImg = "/home/mario/.config/awesome/layouticon/"
-- You can use your own layout icons like this:
theme.layout_magnifier  = pathLayoutImg .. "magnifier.png"
theme.layout_fullscreen = pathLayoutImg .. "max.png"
theme.layout_tilebottom = pathLayoutImg .. "tilebottom.png"
theme.layout_tile       = pathLayoutImg .. "tile.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
