{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      # Theme colors
      background = "#000000";
      foreground = "#E5E5E5";
      cursor = "#FFFFFF";
      cursor_text_color = "#000000";
      selection_background = "#262626";
      selection_foreground = "#FFFFFF";

      color0 = "#121212";
      color1 = "#D71921";
      color2 = "#A3A3A3";
      color3 = "#737373";
      color4 = "#E5E5E5";
      color5 = "#B0131A";
      color6 = "#D4D4D4";
      color7 = "#E5E5E5";
      color8 = "#333333";
      color9 = "#FF2A33";
      color10 = "#FFFFFF";
      color11 = "#8E8E93";
      color12 = "#FAFAFA";
      color13 = "#D71921";
      color14 = "#E5E5E5";
      color15 = "#FFFFFF";

      # Window
      window_padding_width = 14;
      confirm_os_window_close = 0;

      # Cursor styling
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # Shell integration (disable the cursor-shape feature, keep the rest)
      shell_integration = "no-cursor";

      # Slow down mouse scrolling
      wheel_scroll_multiplier = 4.75;
    };

    keybindings = {
      "shift+insert" = "paste_from_clipboard";
      "ctrl+insert" = "copy_to_clipboard";
      "super+ctrl+shift+alt+down" = "resize_window shorter 20";
      "super+ctrl+shift+alt+up" = "resize_window taller 20";
      "super+ctrl+shift+alt+left" = "resize_window narrower 20";
      "super+ctrl+shift+alt+right" = "resize_window wider 20";
    };
  };
}
