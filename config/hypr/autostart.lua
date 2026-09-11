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
