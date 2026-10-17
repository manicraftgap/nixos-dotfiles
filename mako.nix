{ pkgs, ... }:

{
  services.mako = {
    settings = {
      text-color = "#e7e9ea";
      border-color = "#e7e9ea";
      background-color = "#000000";
      border-size = 1;
      border-radius = 6;
      padding = "10";
      width = 420;
      height = 110;
      anchor = "top-right";
      margin = "20";
      default-timeout = 5000;
      max-icon-size = 32;
    };

    extraConfig = ''
      [app-name=Spotify]
      invisible=1

      [mode=do-not-disturb]
      invisible=true

      [mode=do-not-disturb app-name=notify-send]
      invisible=false
    '';
  };
}
