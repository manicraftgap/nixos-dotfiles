-- ~/.config/hypr/bindings.lua
local mainMod = "SUPER"

-- --- Application Bindings ---
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec tmux new"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("uwsm-app -- hyprlock"))
hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd("ghostty --title=wiremix -e wiremix"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("ghostty --title=bluetui -e bluetui"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("ghostty --title=impala -e impala"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("ghostty --title=btop -e btop"))

-- Web Browser
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("uwsm-app -- librewolf"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("uwsm-app -- librewolf"))
hl.bind(mainMod .. " + SHIFT + ALT + B", hl.dsp.exec_cmd("uwsm-app -- librewofl --private-window"))

-- File Manager
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"))
hl.bind(mainMod .. " + ALT + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window ~"))

-- Multimedia / System TUI Launchers
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm-app -- flatpak run com.github.neithern.g4music"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("uwsm-app -- vesktop"))

-- --- Screenshots ---
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screenshot-capture region"))
hl.bind("PRINT", hl.dsp.exec_cmd("screenshot-capture fullscreen"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))

-- --- Web Applications ---
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd([[uwsm-app -- xdg-open "https://gemini.google.com/app"]]))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd([[uwsm-app -- xdg-open "https://youtube.com/"]]))
hl.bind(
	mainMod .. " + SHIFT + CTRL + G",
	hl.dsp.exec_cmd([[uwsm-app -- xdg-open "https://messages.google.com/web/conversations"]])
)

-- --- Window Resizing ---
local resizeUnit = 30
hl.bind(mainMod .. " + SHIFT + ALT + right", hl.dsp.window.resize({ x = resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + left", hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + up", hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + down", hl.dsp.window.resize({ x = 0, y = resizeUnit, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + L", hl.dsp.window.resize({ x = resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + H", hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + K", hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }))
hl.bind(mainMod .. " + SHIFT + ALT + J", hl.dsp.window.resize({ x = 0, y = resizeUnit, relative = true }))

-- === Universal Clipboard ===
hl.bind(mainMod .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert", window = "activewindow" }))
hl.bind(mainMod .. " + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert", window = "activewindow" }))
hl.bind(mainMod .. " + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X", window = "activewindow" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("walker -m clipboard"))

-- Audio Output Switch
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("audio-output-switch"), { locked = true })

-- Volume & Mic Controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd([[
    sh -c "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; \
    if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then \
        swayosd-client --custom-message 'Microphone muted' --custom-icon 'microphone-sensitivity-muted-symbolic'; \
    else \
        swayosd-client --custom-message 'Microphone on' --custom-icon 'audio-input-microphone-symbolic'; \
    fi"
]]),
	{ locked = true, repeating = false, ignore_mods = true }
)

-- Screen Brightness
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower"),
	{ locked = true, repeating = true, ignore_mods = true }
)

-- Keyboard Backlight
hl.bind(
	"XF86KbdBrightnessUp",
	hl.dsp.exec_cmd("kbd-backlight up"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"XF86KbdBrightnessDown",
	hl.dsp.exec_cmd("kbd-backlight down"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind("XF86KbdLightOnOff", hl.dsp.exec_cmd("kbd-backlight cycle"), { locked = true, ignore_mods = true })

-- Touchpad Controls
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("touchpad-toggle"), { locked = true, ignore_mods = true })
hl.bind("XF86TouchpadOn", hl.dsp.exec_cmd("touchpad-toggle on"), { locked = true, ignore_mods = true })
hl.bind("XF86TouchpadOff", hl.dsp.exec_cmd("touchpad-toggle off"), { locked = true, ignore_mods = true })

-- Display Mirroring
hl.bind(mainMod .. " + CTRL + ALT + Delete", hl.dsp.exec_cmd("display-mirror toggle"))

-- Precise 1% Adjustments
hl.bind(
	"ALT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ && swayosd-client --output-volume raise"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"ALT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && swayosd-client --output-volume lower"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"ALT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl set 1%+ && swayosd-client --brightness raise"),
	{ locked = true, repeating = true, ignore_mods = true }
)
hl.bind(
	"ALT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl set 1%- && swayosd-client --brightness lower"),
	{ locked = true, repeating = true, ignore_mods = true }
)

-- Media Player Controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { locked = true, ignore_mods = true })
hl.bind(
	"XF86AudioPause",
	hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"),
	{ locked = true, ignore_mods = true }
)
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"),
	{ locked = true, ignore_mods = true }
)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { locked = true, ignore_mods = true })

-- Monitor Focus
hl.bind("CTRL + ALT + TAB", hl.dsp.focus({ monitor = "+1" }))
hl.bind("CTRL + ALT + SHIFT + TAB", hl.dsp.focus({ monitor = "-1" }))

-- Power Menu
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("power-menu"))

-- Hyprsunset Toggle --
hl.bind(
	mainMod .. " + CTRL + N",
	hl.dsp.exec_cmd([[
  export PATH=$PATH:/run/current-system/sw/bin:$HOME/.nix-profile/bin

  if pgrep -x hyprsunset >/dev/null; then
    pkill -x hyprsunset
    notify-send -u low "   Daylight screen temperature"
  else
    hyprsunset -t 4000 &
    notify-send -u low "  Nightlight screen temperature"
  fi

  if grep -q "custom/nightlight" ~/.config/waybar/config.jsonc; then
    pkill -SIGUSR2 waybar
  fi
]])
)

-- === Window Management & Tiling ===
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + N", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Focus
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Workspaces (1-10)
for i = 1, 9 do
	local ws = tostring(i)
	hl.bind(mainMod .. " + " .. ws, hl.dsp.focus({ workspace = ws }))
	hl.bind(mainMod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = ws, follow = true }))
	hl.bind(mainMod .. " + SHIFT + ALT + " .. ws, hl.dsp.window.move({ workspace = ws, follow = false }))
end

-- Workspace 10 (0 Keybind)
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = true }))
hl.bind(mainMod .. " + SHIFT + ALT + 0", hl.dsp.window.move({ workspace = "10", follow = false }))

-- Scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Workspace Cycling
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Winwdow Cycling
hl.bind("ALT + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind("ALT + SHIFT + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next({ prev = true }))
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Swap Windows
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

-- Window Grouping
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + G", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mainMod .. " + ALT + LEFT", hl.dsp.window.move({ into_group = "left" }))
hl.bind(mainMod .. " + ALT + RIGHT", hl.dsp.window.move({ into_group = "right" }))
hl.bind(mainMod .. " + ALT + UP", hl.dsp.window.move({ into_group = "up" }))
hl.bind(mainMod .. " + ALT + DOWN", hl.dsp.window.move({ into_group = "down" }))
hl.bind(mainMod .. " + ALT + TAB", hl.dsp.group.active({ index = 1 }))
hl.bind(mainMod .. " + ALT + SHIFT + TAB", hl.dsp.group.active({ index = -1 }))

-- Move/Resize with Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- === Utilities & Walkers ===
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("walker --width 645 --height 375"))
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("walker -m symbols"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("pkill waybar || waybar &"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("walker --provider menus:backgroundSelector"))

-- Notifications (Mako)
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind(mainMod .. " + ALT + COMMA", hl.dsp.exec_cmd("makoctl invoke"))
hl.bind(mainMod .. " + SHIFT + ALT + COMMA", hl.dsp.exec_cmd("makoctl restore"))

-- Dictation
hl.bind(mainMod .. " + CTRL + X", hl.dsp.exec_cmd("voxtype record toggle"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("voxtype record start"))
hl.bind(mainMod .. " + F9", hl.dsp.exec_cmd("voxtype record stop"), { release = true })

-- Zoom
hl.bind(mainMod .. " + CTRL + Z", function()
	local zoom = hl.get_config("cursor.zoom_factor") or 1
	hl.config({ cursor = { zoom_factor = zoom + 1 } })
end)

hl.bind(mainMod .. " + CTRL + ALT + Z", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)
