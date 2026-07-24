{ config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    
    policies = {
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "{c49b13b1-5dee-4345-925e-0c793377e3fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4842469/youtube_enhancer_vc-1.33.0.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock-6.1.7.xpi";
          installation_mode = "force_installed";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes-3.0.0.18.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4915668/bitwarden_password_manager-2026.7.0.xpi";
          installation_mode = "force_installed";
        };
        "{71e91189-9cd2-4e46-895d-bcc38f0053c4}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4905377/ttv_ab_twitch_ad_blocker-12.1.0.xpi";
          installation_mode = "force_installed";
        };
        "vpn@proton.ch" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4851750/proton_vpn_firefox_extension-1.3.5.xpi";
          installation_mode = "force_installed";
        };
        "GXThemeStyles@Godie" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4703873/gx_theme_styles-1.0.8.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      settings = import ./libreprefs.nix;
      bookmarks = {
        force = true;
        settings = [
          {
            name = "MCSR";
            url = "https://mcsrranked.com/stats/manicraftgap";
          }
          {
            name = "MCSR Stats";
            url = "https://mcsrstats.netlify.app/";
          }
          {
            name = "Gapcheck";
            url = "https://gapcheck.gg/practice";
          }
          {
            name = "Typeracer";
            url = "https://play.typeracer.com/";
          }
          {
            name = "NixDots";
            url = "https://github.com/manicraftgap/nixos-dotfiles/tree/main";
          }
        ];
      };
    };
  };

  home.file.".librewolf/default/chrome" = {
    source = ./config/librewolf/chrome;
    recursive = true;
  };
}
