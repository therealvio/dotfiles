-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Colour Schemes
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return 'Dark'
end

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Atelier Dune (base16)'
    else
        return 'Atelier Dune Light (base16)'
    end
end

-- Apply the color scheme to the config
config.color_scheme = scheme_for_appearance(get_appearance())

-- Set font
config.font = wezterm.font("Fira Code")
config.font_size = 14.0

-- Set window size
config.initial_rows = 30
config.initial_cols = 100

-- Keybinds
local act = wezterm.action
config.keys = {
    -- OPT-Left/Right: skip words (ALT-b / ALT-f)
    { key = 'LeftArrow',  mods = 'OPT', action = act.SendString '\x1bb' },
    { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },
    -- CMD-Left/Right: beginning / end of line (Ctrl-A / Ctrl-E)
    { key = 'LeftArrow',  mods = 'CMD', action = act.SendString '\x01' },
    { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x05' },
}

-- Misc settings
config.window_close_confirmation = 'NeverPrompt' -- Disable close confirmation

-- Finally, return the configuration
return config
