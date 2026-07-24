{ pkgs, ... }: {
  xdg.desktopEntries = {

    Nvim = {
      name = "Neovim";
      icon = "nvim";
      exec = "ghostty -e nvim %F";
      terminal = false;
    };

    draftout = {
      name = "Draftout";
      comment = "Launch Draftout instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/Draftout/minecraft/icon.png";
      exec = "prismlauncher --launch Draftout";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/Draftout/minecraft/icon.png";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    mcsr-ranked = {
      name = "MCSR Ranked";
      comment = "Launch MCSR instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/MCSRRanked/minecraft/icon.png";
      exec = "prismlauncher --launch MCSRRanked";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/MCSRRanked";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    pvp-plus = {
      name = "PVP+";
      comment = "Launch PVP+ instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/PVP+/minecraft/icon.png";
      exec = "prismlauncher --launch PVP+";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/PVP+";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    youtube = {
      name = "YouTube";
      comment = "YouTube";
      icon = "./config/icons/YouTube.png";
      exec = "uwsm-app -- xdg-open \"https://youtube.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };

    github = {
      name = "GitHub";
      comment = "GitHub";
      icon = "./config/icons/GitHub.png";
      exec = "uwsm-app -- xdg-open \"https://github.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };

    monkeytype = {
      name = "Monkeytype";
      comment = "Monkeytype";
      icon = "./config/icons/Monkeytype.png";
      exec = "uwsm-app -- xdg-open \"https://monkeytype.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };

    lichess = {
      name = "Lichess";
      comment = "Lichess";
      icon = "./config/icons/lichess.png";
      exec = "uwsm-app -- xdg-open \"https://monkeytype.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };
  };
}
