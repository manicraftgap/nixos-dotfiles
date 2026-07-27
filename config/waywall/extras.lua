local waywall = require("waywall")
local helpers = require("waywall.helpers")

for i = 0, 3, 1 do
	helpers.res_mirror( -- mob_spawner
		{
			src = { x = 2467, y = 1219 + 8 * i, w = 33, h = 9 },
			dst = { x = 2258, y = 1080, w = 33 * 8, h = 9 * 8 },
			depth = 3,
			color_key = { input = "#4de1ca", output = "#FFFFFF" },
		},
		0,
		0
	)
	helpers.res_mirror( -- mob_spawner
		{
			src = { x = 2467, y = 1219 + 8 * i, w = 33, h = 9 },
			dst = { x = 2258 + 8, y = 1080 + 8, w = 33 * 8, h = 9 * 8 },
			depth = 2,
			color_key = { input = "#4de1ca", output = "#000000" },
		},
		0,
		0
	)
end

return function(config)
	-- Add any extra code here

	-- Track whether the overlay is currently visible and store its instance
	local oneshot_visible = false
	local oneshot_instance = nil

	-- Define the path to your oneshot resource
	local waywall_config_path = os.getenv("HOME") .. "/.config/waywall/"
	local oneshot_overlay_path = waywall_config_path .. "resources/oneshot.png"

	-- Inject the toggle function into the action table tied to your config key
	-- This relies on `enable_oneshot_overlay_key = "H"` defined in your config
	config.actions["H"] = function()
		if oneshot_visible and oneshot_instance then
			-- If it's already on screen, close/remove it
			oneshot_instance:close()
			oneshot_instance = nil
			oneshot_visible = false
			print("Oneshot overlay hidden")
		else
			-- If it's hidden, display the image
			-- Adjust the dst coordinates (x, y, w, h) and depth to suit your resolution
			oneshot_instance = waywall.image(oneshot_overlay_path, {
				dst = { x = 0, y = 0, w = config.window.fullscreen_width, h = config.window.fullscreen_height },
				depth = 4, -- Set high depth to stay above other mirrors/backgrounds
			})
			oneshot_visible = true
			print("Oneshot overlay shown")
		end
	end
	-- END
end
