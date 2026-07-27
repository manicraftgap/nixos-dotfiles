-- ~ / .config/hypr/input.lua

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
	match = { class = "Alacritty|kitty|foot" },
	scroll_touchpad = 1.5,
})

hl.window_rule({
	match = { class = "com.mitchellh.ghostty" },
	scroll_touchpad = 0.2,
})
