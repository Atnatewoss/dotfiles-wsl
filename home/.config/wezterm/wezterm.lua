local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.0
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.window_padding = {
    left = 18,
    right = 18,
    top = 12,
    bottom = 18,
}

local target_pct = 0.75

wezterm.on("gui-startup", function()
    local _, _, window = wezterm.mux.spawn_window({})
    local gui_window = window:gui_window()
    if gui_window then
        local screens = wezterm.gui.screens()
        if screens and screens.main then
            local screen = screens.main
            local target_w = math.floor(screen.width * target_pct)
            local target_h = math.floor(screen.height * target_pct)
            gui_window:set_inner_size(target_w, target_h)

            wezterm.time.call_after(0.15, function()
                local dims = gui_window:get_dimensions()
                if dims then
                    local x = screen.x + (screen.width - dims.pixel_width) / 2
                    local y = screen.y + (screen.height - dims.pixel_height) / 2
                    gui_window:set_position(x, y)
                end
            end)
        end
    end
end)

return config
