{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./pkgs.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "hyprnix";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.wifi.powersave = false;
  services.resolved.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
    };
  };
  programs.gamemode.enable = true;
  fileSystems."/mnt/omarch" = {
    device = "/dev/disk/by-uuid/b0774602-1073-46fa-bf7e-ab998a110cbb";
    fsType = "luks";
    options = [
      "noauto"
      "x-gvfs-show"
      "x-udisks-auth"
    ];
  };

  services.ratbagd.enable = true;
  hardware.keyboard.qmk.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  services.getty.autologinUser ="mani";
  users.users."mani" = {
    isNormalUser = true;
    description = "mani";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [];
  };
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0b10", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
  '';
  nixpkgs.config.allowUnfree = true;
  programs.hyprland.enable = true;
  programs.localsend.enable = true;
  programs.helium = {
      enable = true;
      flags = [
        "--ozone-platform-hint=auto"
      ];
    };
  services.power-profiles-daemon.enable = true;
  services.flatpak.enable = true;
  hardware.bluetooth.enable = true;
  environment.variables = {
      EDITOR = "nvim";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  };

  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      ${pkgs.systemd}/bin/systemctl suspend
    '';
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libxkbcommon
      libXtst
      libX11
      libXext
      libXrender
      libXi
      libXt
      libXinerama
    ];
  };

  xdg.mime.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "inode/directory" = "org.gnome.Nautilus.desktop";
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
    BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment?
}
