theme = {}

theme.font = "Consolas 12"
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height = 20
theme.menu_width  = 400

theme.bg_normal          = "#101010"
theme.fg_normal          = "#26ABF2"
theme.fg_focus           = "#101010"
theme.bg_focus           = "#268BD2"
theme.bg_urgent          = "#3f3f3f"
theme.fg_urgent          = "#e34c10"
theme.bg_minimize        = "#101010"
theme.fg_minimize        = "#008282"
theme.tasklist_bg_normal = "#101010"
theme.tasklist_fg_normal = "#0888AA"
theme.tasklist_bg_focus  = "#101010"
theme.tasklist_fg_focus  = "#00FFFF"
theme.border_normal      = "#3f3f3f"
theme.border_focus       = "#00a6dc"
theme.border_marked      = "#cc9393"
theme.bg_systray         = theme.bg_normal
theme.border_width       = 1


 -- theme.taglist_fg_focus = "~/.config/awesome/taglist_bg_focus.png"
-- theme.topbar_path

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

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- Wallpaper list
local pathWallpaper = "/home/mario/.config/awesome/"
local nameWallpaper = {
        "AsaryW.png",
        "FNevulaW.png",
        "UranusW.png"
        }

theme.wallpaper = {}
for i, name in ipairs(nameWallpaper) do
  theme.wallpaper[i] = pathWallpaper .. nameWallpaper[i]
end


local pathLayoutImg = "/home/mario/.config/awesome/layouticon/"
-- You can use your own layout icons like this:
theme.layout_magnifier  = pathLayoutImg .. "magnifier.png"
theme.layout_fullscreen = pathLayoutImg .. "max.png"
theme.layout_tilebottom = pathLayoutImg .. "tilebottom.png"
theme.layout_tile       = pathLayoutImg .. "tile.png"

-- theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.awesome_icon = "/usr/share/awesome/themes/sky/awesome-icon.png"
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
