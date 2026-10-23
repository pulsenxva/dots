-- ==========================================
-- MONITORS
-- ==========================================
hl.monitor({ output = "eDP-1", mode = "1920x1200", position = "-1920x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "0x0", scale = 1 })

-- ==========================================
-- MY PROGRAMS
-- ==========================================
local terminal = "alacritty"
local fileManager = "nautilus"
local menu = "wofi --show drun"
local browser = "firefox"
local bar = "waybar"
local calculator = "gnome-calculator --mode=keyboard"
local network = "happ"

-- ==========================================
-- AUTOSTART
-- ==========================================
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")
    hl.exec_cmd("sh -c 'export $(gnome-keyring-daemon --start --components=secrets)'")
    hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("dunst & waybar")
    hl.exec_cmd("wl-clipboard-history -t")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("wl-clip-persist --clipboard regular --display wayland-1")
end)

-- ==========================================
-- ENVIRONMENT VARIABLES
-- ==========================================
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")

-- ==========================================
-- LOOK AND FEEL
-- ==========================================
hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true
    },
    general = {
        gaps_in = 2,
        gaps_out = 3, 4, 4, 4,
        border_size = 0,
        col = {
            active_border = "rgb(268bd2)",
            inactive_border = "rgb(1a1a1a)"
        },
        layout = "dwindle"
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            new_optimizations = true,
            vibrancy = 1
        },
        shadow = {
            enabled = false,
            range = 4,
            offset = {2, 2},
            render_power = 2,
            color = "0x66000000"
        }
    },
    dwindle = {
        preserve_split = true
    },
    master = {
        new_status = "master",
        new_on_top = true
    },
    gestures = {
        workspace_swipe_forever = true,
        workspace_swipe_invert = true
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- ==========================================
-- ANIMATIONS (Bezier & Tree)
-- ==========================================
hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- ==========================================
-- INPUT & DEVICES
-- ==========================================
hl.config({
    input = {
        kb_layout = "us,ru",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules = "",
        repeat_rate = 35,
        repeat_delay = 200,
        follow_mouse = 1,
        sensitivity = -0.7,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.3
        }
    },
    device = {
        {
            name = "elan2611:00-04f3:31dc-touchpad",
            sensitivity = 1.0
        },
        {
            name = "elan2611:00-04f3:31dc-mouse",
            sensitivity = 1.0
        }
    }
})

-- ==========================================
-- KEYBINDINGS
-- ==========================================
local mainMod = "SUPER"

-- Applications & Utilities
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("emacs"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill " .. bar .. " || " .. bar))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(calculator))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("blueman-manager"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(network))

-- Move focus (hl.dsp.focus)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind("ALT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("ALT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("ALT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("ALT + down", hl.dsp.window.move({ direction = "d" }))

-- Resize active (repeating = true заменяет 'binde')
hl.bind("CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + bracketleft", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + bracketright", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

-- Workspaces 1-10
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- Special workspace
hl.bind(mainMod .. " + A", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse wheel workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window interactions (mouse = true заменяет 'bindm')
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume Control (locked = true позволяет использовать бинды при заблокированном экране)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness Control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true, locked = true })
