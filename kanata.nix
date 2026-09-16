{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;

  # Force Kanata systemd services to run as root to access /dev/uinput
  systemd.services.kanata-laptop.serviceConfig = {
    User = "root";
    Group = "root";
  };

  systemd.services.kanata-keychron.serviceConfig = {
    User = "root";
    Group = "root";
  };

  services.kanata = {
    enable = true;

    keyboards = {
      laptop = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            ralt h j k l u i o p
            f4 f12
          )

          (defalias
            mov (layer-toggle movement)
          )

          (deflayer default
            @mov h j k l u i o p
            f4 f12
          )

          (deflayer movement
            _ left down up rght home pgup pgdn end
            f13 f14
          )
        '';
      };

      keychron = {
        devices = [
          "/dev/input/by-id/usb-Keychron_Keychron_Q1_HE-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
            ralt h j k l u i o p
          )

          (defalias
            mov (layer-toggle movement)
          )

          (deflayer default
            @mov h j k l u i o p
          )

          (deflayer movement
            _ left down up rght home pgup pgdn end
          )
        '';
      };
    };
  };
}
