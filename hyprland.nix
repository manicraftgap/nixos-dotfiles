{ config, pkgs, lib, ... }:

{
  # ---------------------------------------------------------------
  # hyprland.lua — entrypoint, requires the other modules
  # ---------------------------------------------------------------
  xdg.configFile."hypr/hyprland.lua".text = ''
    -- ~/.config/hypr/hyprland.lua
    -- Native Hyprland Lua Configuration

    -- Load personal configuration modules
    require("monitors")
    require("input")
    require("bindings")
    require("looknfeel")
    require("autostart")
    require("envs")
    require("windows")

    -- Smart gaps config (Replaces workspace = w[tv1] / f[1] rules)
    hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
    hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
  '';

  # ---------------------------------------------------------------
  # monitors.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/monitors.lua".text = ''
    -- ~/.config/hypr/monitors.lua

    hl.monitor({
      output = "all",   -- Explicitly matches any/all connected monitors
      mode = "preferred",
      position = "auto",
      scale = "auto"
    })

    -- Environment Variables
    hl.env("GDK_SCALE", "2")
  '';

  # ---------------------------------------------------------------
  # input.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/input.lua".text = ''
    -- ~/.config/hypr/input.lua

    hl.config({
    	input = {
    		kb_layout = "us",
    		kb_options = "compose:caps",

    		repeat_rate = 40,
    		repeat_delay = 600,

    		numlock_by_default = true,
    		scroll_factor = 0.75,

    		touchpad = {
    			scroll_factor = 0.4,
    		},
    	},
    })

    -- Scroll speed rules for specific terminal classes
    hl.window_rule({
    	match = { class = "Alacritty|kitty|ghostty" },
    	scroll_touchpad = 1.5,
    })

    hl.window_rule({
    	match = { class = "kitty" },
    	scroll_touchpad = 0.2,
    })
  '';

  # ---------------------------------------------------------------
  # bindings.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/bindings.lua".text = ''
    -- ~/.config/hypr/bindings.lua
    local mainMod = "SUPER"

    -- --- Application Bindings ---
    hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
    hl.bind(mainMod .. " + ALT + RETURN", hl.dsp.exec_cmd("uwsm-app -- xdg-terminal-exec tmux new"))
    hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("uwsm-app -- hyprlock"))
    hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd("kitty --title=wiremix -e wiremix"))
    hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("kitty --title=bluetui -e bluetui"))
    hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("kitty --title=impala -e impala"))
    hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("kitty --title=btop -e btop"))
    hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("power-profile-menu"))

    -- Web Browser
    hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("uwsm-app -- librewolf"))
    hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("uwsm-app -- librewolf"))
    hl.bind(mainMod .. " + SHIFT + ALT + B", hl.dsp.exec_cmd("uwsm-app -- librewolf --private-window"))

    -- File Manager
    hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"))
    hl.bind(mainMod .. " + ALT + SHIFT + F", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window ~"))

    -- Multimedia / System TUI Launchers
    hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm-app -- flatpak run com.github.neithern.g4music"))
    hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("uwsm-app -- vesktop"))

    -- --- Screenshots ---
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("screenshot-capture region"))
    hl.bind(mainMod .. " + ALT + SHIFT + S", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))
    hl.bind(mainMod .. " + CTRL + ALT + SHIFT + S", hl.dsp.exec_cmd('normcap --color "#D3D3D3"'))

    hl.bind("PRINT", hl.dsp.exec_cmd("screenshot-capture fullscreen"))
    hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))
    hl.bind(mainMod .. " + CTRL + PRINT", hl.dsp.exec_cmd('normcap --color "#D3D3D3"'))

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
    	hl.dsp.exec_cmd("swayosd-client --brightness +10"),
    	{ locked = true, repeating = true, ignore_mods = false }
    )
    hl.bind(
    	"XF86MonBrightnessDown",
    	hl.dsp.exec_cmd("swayosd-client --brightness -10"),
    	{ locked = true, repeating = true, ignore_mods = false }
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

    -- Airplane mode
    hl.bind("XF86RFKill", hl.dsp.exec_cmd("toggle-airplane-mode"), { locked = true, ignore_mods = true })

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
    	hl.dsp.exec_cmd("swayosd-client --brightness +1"),
    	{ locked = true, repeating = true, ignore_mods = false }
    )
    hl.bind(
    	"ALT + XF86MonBrightnessDown",
    	hl.dsp.exec_cmd("swayosd-client --brightness -1"),
    	{ locked = true, repeating = true, ignore_mods = false }
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
    hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("power-menu"))
    hl.bind("XF86PowerOff", hl.dsp.exec_cmd("power-menu"))
    hl.bind("xF86Launch4", hl.dsp.exec_cmd("power-profile-cycle"))

    -- Hyprsunset Toggle --
    hl.bind(
    	mainMod .. " + CTRL + N",
    	hl.dsp.exec_cmd([[
      export PATH=$PATH:/run/current-system/sw/bin:$HOME/.nix-profile/bin

      if pgrep -x hyprsunset >/dev/null; then
        pkill -x hyprsunset
        notify-send -u low "   Daylight screen temperature"
      else
        hyprsunset -t 4000 &
        notify-send -u low "  Nightlight screen temperature"
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
  '';

  # ---------------------------------------------------------------
  # looknfeel.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/looknfeel.lua".text = ''
    local active_border_color = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }
    local inactive_border_color = "rgba(595959aa)"

    hl.config({
      general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,

        col = {
          active_border = active_border_color,
          inactive_border = inactive_border_color,
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
      },

      decoration = {
        rounding = 0,

        shadow = {
          enabled = true,
          range = 2,
          render_power = 3,
          color = "rgba(1a1a1aee)",
        },

        blur = {
          enabled = true,
          size = 2,
          passes = 2,
          special = true,
          brightness = 0.60,
          contrast = 0.75,
        },
      },

      group = {
        col = {
          border_active = active_border_color,
          border_inactive = inactive_border_color,
        },

        groupbar = {
          font_size = 12,
          font_family = "monospace",
          font_weight_active = "ultraheavy",
          font_weight_inactive = "normal",
          indicator_height = 0,
          indicator_gap = 5,
          height = 22,
          gaps_in = 5,
          gaps_out = 0,
          text_color = "rgb(ffffff)",
          text_color_inactive = "rgba(ffffff90)",
          col = {
            active = "rgba(00000040)",
            inactive = "rgba(00000020)",
          },
          gradients = true,
          gradient_rounding = 0,
          gradient_round_only_edges = false,
        },
      },

      animations = {
        enabled = true,
      },
    })

    -- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
    hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
    hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
    hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
    hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
    hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

    hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
    hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
    hl.animation({ leaf = "windows", enabled = true, speed = 3.79, bezier = "easeOutQuint" })
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
    hl.animation({ leaf = "workspaces", enabled = false })
    hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "easeOutQuint", style = "slidevert" })

    hl.config({
      dwindle = {
        preserve_split = true,
        force_split = 2,
      },

      scrolling = {
        column_width = 0.49,
      },

      master = {
        new_status = "master",
      },

      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        disable_scale_notification = true,
        focus_on_activate = true,
        anr_missed_pings = 3,
        on_focus_under_fullscreen = 1,
      },

      cursor = {
        hide_on_key_press = true,
        warp_on_change_workspace = 1,
      },

      binds = {
        hide_special_on_workspace_change = true,
      },
    })
  '';

  # ---------------------------------------------------------------
  # autostart.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/autostart.lua".text = ''
    -- ~/.config/hypr/autostart.lua

    hl.on("hyprland.start", function()
    	-- Application execution hooks
    	hl.exec_cmd("uwsm-app -- elephant")
    	hl.exec_cmd("uwsm-app -- walker --gapplication-service")
    	hl.exec_cmd("waybar")

    	-- Core Environment Optimization
    	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    	-- Background System Processes
    	hl.exec_cmd("uwsm-app -- hypridle")
    	hl.exec_cmd("uwsm-app -- mako")
    	hl.exec_cmd("uwsm-app -- swaybg -i ~/.config/swaybg/current/current.png -m fill")
    	hl.exec_cmd("systemctl --user start swayosd")
    	hl.exec_cmd("uwsm-app -- hyprsunset")
    	hl.exec_cmd("uwsm-app -- vesktop -m")
    end)
  '';

  # ---------------------------------------------------------------
  # envs.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/envs.lua".text = ''
    -- Cursor settings
    hl.env("XCURSOR_SIZE", "24")
    hl.env("HYPRCURSOR_SIZE", "24")

    -- Force applications to use Wayland
    hl.env("GDK_BACKEND", "wayland,x11,*")
    hl.env("QT_QPA_PLATFORM", "wayland;xcb")
    hl.env("QT_STYLE_OVERRIDE", "kvantum")
    hl.env("MOZ_ENABLE_WAYLAND", "1")
    hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
    hl.env("OZONE_PLATFORM", "wayland")
    hl.env("XDG_SESSION_TYPE", "wayland")

    -- Screen sharing support
    hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
    hl.env("XDG_SESSION_DESKTOP", "Hyprland")

    -- XCompose
    hl.env("XCOMPOSEFILE", "~/.XCompose")

    hl.config({
      xwayland = {
        force_zero_scaling = true
      },
      ecosystem = {
        no_update_news = true -- Don't show update on first launch
      }
    })
  '';

  # ---------------------------------------------------------------
  # windows.lua
  # ---------------------------------------------------------------
  xdg.configFile."hypr/windows.lua".text = ''
    hl.config({
    	general = {
    		layout = "dwindle",
    		gaps_in = 2,
    		gaps_out = 4,
    		border_size = 1,
    		["col.active_border"] = "rgba(2E3134FF)",
    		["col.inactive_border"] = "rgba(101010FF)",
    		resize_on_border = false,
    		allow_tearing = false,
    	},
    	decoration = {
    		rounding = 6,
    		dim_special = 0.0,
    		active_opacity = 1.0,
    		inactive_opacity = 0.85,
    		shadow = {
    			enabled = true,
    			range = 2,
    			render_power = 3,
    			color = "rgba(1a1a1aee)",
    		},
    		blur = {
    			enabled = true,
    			size = 8,
    			passes = 1,
    			new_optimizations = true,
    			xray = false,
    			contrast = 0.7,
    			brightness = 0.5,
    			noise = 0.1,
    			vibrancy = 0.1696,
    			vibrancy_darkness = 0.0,
    			special = true,
    		},
    	},
    	group = {
    		["col.border_active"] = "rgba(2E3134FF)",
    		["col.border_inactive"] = "rgba(101010FF)",
    		groupbar = {
    			font_family = "JetBrainsMono Nerd Font Mono",
    			font_size = 10,
    			height = 30,
    			text_offset = -1,
    			indicator_gap = 1,
    			indicator_height = 1,
    			["col.active"] = "rgba(6E7378ff)",
    			["col.inactive"] = "rgba(191919FF)",
    			text_color = "rgba(e7e9eaff)",
    			text_color_inactive = "rgba(6E7378ff)",
    			gaps_in = 0,
    			gaps_out = 0,
    		},
    	},
    	animations = {
    		enabled = true,
    		bezier = {
    			"easeOutQuint,0.23,1,0.32,1",
    			"easeInOutCubic,0.65,0.05,0.36,1",
    			"linear,0,0,1,1",
    			"almostLinear,0.5,0.5,0.75,1.0",
    			"quick,0.15,0,0.1,1",
    		},
    		animation = {
    			"global, 1, 10, default",
    			"border, 1, 5.39, easeOutQuint",
    			"windows, 1, 3.79, easeOutQuint",
    			"windowsIn, 1, 4.1, easeOutQuint, popin 87%",
    			"windowsOut, 1, 1.49, linear, popin 87%",
    			"fadeIn, 1, 1.73, almostLinear",
    			"fadeOut, 1, 1.46, almostLinear",
    			"fade, 1, 3.03, quick",
    			"layers, 1, 3.81, easeOutQuint",
    			"layersIn, 1, 4, easeOutQuint, fade",
    			"layersOut, 1, 1.5, linear, fade",
    			"fadeLayersIn, 1, 1.79, almostLinear",
    			"fadeLayersOut, 1, 1.39, almostLinear",
    			"workspaces, 0, 0, ease",
    			"specialWorkspace, 1, 3, easeOutQuint, slidevert",
    		},
    	},
    	dwindle = {
    		preserve_split = true,
    		force_split = 2,
    	},
    	misc = {
    		disable_hyprland_logo = true,
    		disable_splash_rendering = true,
    		disable_scale_notification = true,
    		focus_on_activate = true,
    		key_press_enables_dpms = true,
    		mouse_move_enables_dpms = true,
    	},
    	cursor = {
    		hide_on_key_press = true,
    		warp_on_change_workspace = 1,
    	},
    	binds = {
    		hide_special_on_workspace_change = true,
    	},
    })

    -- Window Rules
    hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
    hl.window_rule({ match = { class = ".*" }, tag = "+default-opacity" })
    hl.window_rule({ match = { tag = "default-opacity" }, opacity = "0.97 0.9" })

    -- Make specific terminal tools float, center, and resize cleanly
    hl.window_rule({
    	match = { title = "^(impala|bluetui|wiremix|btop|LocalSend|satty)$" },
    	float = 1,
    	size = "800 500",
    	center = 1,
    })
    hl.window_rule({
    	match = { title = "^(Picture-in-[P|p]icture)$" },
    	float = 1,
    	pin = 1,
    	size = "200 110",
    	move = "1400 890",
    })
    hl.window_rule({
    	match = { title = "^(Calculator)$" },
    	float = 1,
    	size = "360 620",
    })
  '';
}

