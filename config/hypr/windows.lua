hl.config({
	general = {
		layout = "dwindle", --[cite: 16]
		gaps_in = 2, --[cite: 16]
		gaps_out = 4, --[cite: 16]
		border_size = 1, --[cite: 16]
		["col.active_border"] = "rgba(2E3134FF)", --[cite: 16]
		["col.inactive_border"] = "rgba(101010FF)", --[cite: 16]
		resize_on_border = false, --[cite: 10]
		allow_tearing = false, --[cite: 10]
	},
	decoration = {
		rounding = 6, --[cite: 16]
		dim_special = 0.0, --[cite: 16]
		active_opacity = 1.0, --[cite: 16]
		inactive_opacity = 0.85, --[cite: 16]
		shadow = {
			enabled = true, --[cite: 10]
			range = 2, --[cite: 10]
			render_power = 3, --[cite: 10]
			color = "rgba(1a1a1aee)", --[cite: 10]
		},
		blur = {
			enabled = true, --[cite: 16]
			size = 8, --[cite: 16]
			passes = 1, --[cite: 16]
			new_optimizations = true, --[cite: 16]
			xray = false, --[cite: 16]
			contrast = 0.7, --[cite: 16]
			brightness = 0.5, --[cite: 16]
			noise = 0.1, --[cite: 16]
			vibrancy = 0.1696, --[cite: 16]
			vibrancy_darkness = 0.0, --[cite: 16]
			special = true, --[cite: 16]
		},
	},
	group = {
		["col.border_active"] = "rgba(2E3134FF)", --[cite: 16]
		["col.border_inactive"] = "rgba(101010FF)", --[cite: 16]
		groupbar = {
			font_family = "JetBrainsMono Nerd Font Mono", --[cite: 16]
			font_size = 10, --[cite: 16]
			height = 30, --[cite: 16]
			text_offset = -1, --[cite: 16]
			indicator_gap = 1, --[cite: 16]
			indicator_height = 1, --[cite: 16]
			["col.active"] = "rgba(6E7378ff)", --[cite: 16]
			["col.inactive"] = "rgba(191919FF)", --[cite: 16]
			text_color = "rgba(e7e9eaff)", --[cite: 16]
			text_color_inactive = "rgba(6E7378ff)", --[cite: 16]
			gaps_in = 0, --[cite: 16]
			gaps_out = 0, --[cite: 16]
		},
	},
	animations = {
		enabled = true, --[cite: 10]
		-- Define Beziers[cite: 10]
		bezier = {
			"easeOutQuint,0.23,1,0.32,1",
			"easeInOutCubic,0.65,0.05,0.36,1",
			"linear,0,0,1,1",
			"almostLinear,0.5,0.5,0.75,1.0",
			"quick,0.15,0,0.1,1",
		},
		-- Define Animations[cite: 10]
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
		preserve_split = true, --[cite: 10]
		force_split = 2, --[cite: 10]
	},
	misc = {
		disable_hyprland_logo = true, --[cite: 10]
		disable_splash_rendering = true, --[cite: 10]
		disable_scale_notification = true, --[cite: 10]
		focus_on_activate = true, --[cite: 10]
		key_press_enables_dpms = true, --[cite: 9]
		mouse_move_enables_dpms = true, --[cite: 9]
	},
	cursor = {
		hide_on_key_press = true, --[cite: 10]
		warp_on_change_workspace = 1, --[cite: 10]
	},
	binds = {
		hide_special_on_workspace_change = true, --[cite: 10]
	},
})

-- Window Rules[cite: 11]
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
