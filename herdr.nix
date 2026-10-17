{ config, pkgs, ... }:

let
  herdrConfig = ''
    onboarding = false

    [ui]
    mouse_capture = true       # Keep mouse enabled for clicking panes, tabs, and resizing

    [theme]
    name = "terminal"

    [keys]
    prefix = "ctrl+space"      # Set prefix to Ctrl+Space

    # Pane Layout Controls
    split_vertical = "prefix+v"      # Split side-by-side
    split_horizontal = "prefix+minus"# Split stacked (tmux style)
    zoom = "prefix+z"                # Toggle pane zoom

    # Vim Pane Focus Controls
    focus_pane_left = "prefix+h"
    focus_pane_down = "prefix+j"
    focus_pane_up = "prefix+k"
    focus_pane_right = "prefix+l"

    # Tab Switching
    switch_tab = "prefix+1..9"
  '';
in
{
  # Install Pi, Node.js runtime, and Git for your agent workflows
  home.packages = with pkgs; [
    pi-coding-agent
    nodejs_22
    git
  ];

  xdg.configFile."herdr/config.toml".text = herdrConfig;
}
