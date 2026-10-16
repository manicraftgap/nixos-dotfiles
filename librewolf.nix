{ config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "normal_installed";
        };
        "{c49b13b1-5dee-4345-925e-0c793377e3fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4842469/youtube_enhancer_vc-1.33.0.xpi";
          installation_mode = "normal_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock-6.1.7.xpi";
          installation_mode = "normal_installed";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4371820/return_youtube_dislikes/latest.xpi";
          installation_mode = "normal_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4915668/bitwarden_password_manager-2026.7.0.xpi";
          installation_mode = "normal_installed";
        };
        "vpn@proton.ch" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4851750/proton_vpn_firefox_extension-1.3.5.xpi";
          installation_mode = "normal_installed";
        };
        "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4779333/hide_youtube_shorts-1.11.0.xpi";
          installation_mode = "normal_installed";
        };
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/5028285/styl_us/latest.xpi";
          installation_mode = "normal_installed";
        };
        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };

    profiles.default = {
      settings = import ./libreprefs.nix;
    };
  };

  home.file.".librewolf/default/chrome" = {
    source = ./config/librewolf/chrome;
    recursive = true;
  };
}
