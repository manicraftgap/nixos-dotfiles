-- Edit keybindings here
local KEYS = {
	thin = "*-ALT_L",
	tall = "*-F4",
	wide = "*-V",
	toggle_ninbot = "*-apostrophe",
	toggle_oneshot = "*-H",
	fullscreen = "*-F11",
}

local INPUT = {
	layout = "ch",
	repeat_rate = 40,
	repeat_delay = 300,

	-- Key remappings: source_key = destination_key
	remaps = {
		["A"] = "O",
		["D"] = "M",
		--    ["B"] = "V",
		--    ["W"] = "Z",
	},
}

-- Ninjabrain position
-- ninb_anchor: bottomleft, topleft, bottomright, topright, right, left
local THEME = {
	ninb_anchor = "topright",
	ninb_opacity = 0.7,
}

return {
	KEYS = KEYS,
	INPUT = INPUT,
	THEME = THEME,
}
