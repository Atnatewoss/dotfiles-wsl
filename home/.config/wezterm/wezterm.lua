local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- PowerShell 7
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.6

-- Theme
config.color_scheme = "Tokyo Night"

-- Window
config.window_background_opacity = 0.85

-- Windows 11 Acrylic blur
config.win32_system_backdrop = "Acrylic"

config.window_padding = {
    left = 18,
    right = 18,
    top = 12,
    bottom = 18,
}

-- Hide tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Hide the title text ("pwsh.exe")
config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"

config.enable_scroll_bar = false

-- Launch centered at 75% of screen size
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

-- Apply font size to new panes too
wezterm.on("window-config-reloaded", function(window, pane)
    window:set_config_overrides({
        font_size = config.font_size,
    })
end)

return config
