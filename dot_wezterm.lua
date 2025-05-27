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

-- Keybinds
config.keys = {
    -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
    {
        key = 'LeftArrow',
        mods = 'OPT',
        action = wezterm.action{SendString="\x1bb"},
    },
    {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action{SendString="\x1bf"},
    },
}

-- Misc settings
config.window_close_confirmation = 'NeverPrompt' -- Disable close confirmation

-- Finally, return the configuration
return config