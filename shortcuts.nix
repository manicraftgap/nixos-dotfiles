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
      icon = "/home/mani/.local/share/PrismLauncher/instances/PVP+/icon.png";
      exec = "prismlauncher --launch PVP+";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/PVP+";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    Casual = {
      name = "Casual";
      comment = "Launch Casual instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/Casual/icon.webp";
      exec = "prismlauncher --Casual";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/Casual";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    Create-plus = {
      name = "Create";
      comment = "Launch Create instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/Create/icon.png";
      exec = "prismlauncher --launch Create";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/Create";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    RSG = {
      name = "RSG";
      comment = "Launch RSG instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/RSG/icon.png";
      exec = "prismlauncher --launch RSG";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/RSG";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    SkyFactory4 = {
      name = "SkyFactory4";
      comment = "Launch SkyFactory4 instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/SkyFactory4/icon.png";
      exec = "prismlauncher --launch SkyFactory4";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/SkyFactory4";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    "The Broken Script Enhanced" = {
      name = "The Broken Script Enhanced";
      comment = "Launch The Broken Script Enhanced instance in Prism Launcher";
      icon = "/home/mani/.local/share/PrismLauncher/instances/TBS-Enhanced/icon.png";
      exec = "prismlauncher --launch TBS-Enhanced";
      categories = [ "Game" ];
      settings = {
        Path = "/home/mani/.local/share/PrismLauncher/instances/TBS-Enhanced/";
        Keywords = "Minecraft;Prism;Launcher;";
      };
    };

    youtube = {
      name = "YouTube";
      comment = "YouTube";
      icon = ./config/icons/YouTube.png;
      exec = "uwsm-app -- xdg-open \"https://youtube.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };

    github = {
      name = "GitHub";
      comment = "GitHub";
      icon = ./config/icons/GitHub.png;
      exec = "uwsm-app -- xdg-open \"https://github.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };

    monkeytype = {
      name = "Monkeytype";
      comment = "Monkeytype";
      icon = ./config/icons/Monkeytype.png;
      exec = "uwsm-app -- xdg-open \"https://monkeytype.com/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };

    lichess = {
      name = "Lichess";
      comment = "Lichess";
      icon = ./config/icons/lichess.png;
      exec = "uwsm-app -- xdg-open \"https://lichess.org/\"";
      terminal = false;
      settings = {
        StartupNotify = "true";
      };
    };
  };
}
