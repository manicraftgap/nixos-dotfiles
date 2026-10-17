{ config, pkgs, ... }:

let
  # Shared by GTK3 and GTK4 (identical in both gtk-3.0/ and gtk-4.0/)
  nothingCss = ''
    /* Nothing OS Theme Overrides for Libadwaita / Nautilus */

    /* Main Backgrounds & Text */
    @define-color window_bg_color #000000;
    @define-color window_fg_color #E5E5E5;
    @define-color view_bg_color #000000;
    @define-color view_fg_color #E5E5E5;

    /* Headerbar & Cards */
    @define-color headerbar_bg_color #000000;
    @define-color headerbar_fg_color #E5E5E5;
    @define-color card_bg_color #1A1A1A;
    @define-color card_fg_color #E5E5E5;
    @define-color dialog_bg_color #1A1A1A;

    /* Sidebars & Views */
    @define-color sidebar_bg_color #000000;
    @define-color sidebar_fg_color #A3A3A3;
    @define-color sidebar_backdrop_color #000000;

    /* Nothing OS Signature Red Accents */
    @define-color accent_color #D70000;
    @define-color accent_bg_color #D70000;
    @define-color accent_fg_color #FFFFFF;

    /* Selections & Popovers */
    @define-color popover_bg_color #1A1A1A;
    @define-color popover_fg_color #E5E5E5;

    /* UI Elements Tweaks */
    .nautilus-window {
        background-color: #000000;
    }

    /* Selected folder/file icons and rows */
    view:selected, iconview:selected, list row:selected {
        background-color: #262626;
        color: #FFFFFF;
    }

    /* --- Chromium / Helium Overrides --- */
    /* Window frame background */
    window.chromium {
        background-color: #000000;
    }

    /* Address bar, fields, and search inputs */
    .entry.chromium {
        background-color: #1A1A1A;
        color: #E5E5E5;
    }

    /* Selection and Accent color sampling */
    .chromium selection, .chromium:selected {
        background-color: #D70000;
        color: #FFFFFF;
    }

    /* Ensure the main window and GTK canvas stay pure black */
    window.chromium,
    .window.background.chromium {
        background-color: #000000;
    }

    /* Force Chromium's GTK viewports, rendering containers, and web views to black */
    window.chromium view,
    window.chromium viewport,
    window.chromium contents {
        background-color: #000000;
    }
  '';
in
{
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
      size = 24;
    };

    iconTheme = {
      name = "Yaru-red";
      package = pkgs.yaru-theme;
    };

    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = 1;
      extraCss = nothingCss;
      # was ~/.config/gtk-3.0/bookmarks
      bookmarks = [ "file://${config.home.homeDirectory}/Downloads Downloads" ];
    };

    gtk4 = {
      extraConfig.gtk-application-prefer-dark-theme = 1;
      extraCss = nothingCss;
    };
  };
}
