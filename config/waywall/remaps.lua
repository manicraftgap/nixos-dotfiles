local helpers = require("waywall.helpers")

return {
	remapped_kb = {
		["1"] = "backspace",
		["CapsLock"] = "F3",
		["mmb"] = "RIGHTSHIFT",
		["a"] = "o",
		["d"] = "r",
		["q"] = "a",
		["b"] = "d",
		["o"] = "q",
		["r"] = "b",
		["grave"] = "grave", -- replace to zero when mb5 is cahnged to pick block
	},

	normal_kb = {
		-- Keys to remain active during chat/menu mode (if any)
	},
}
