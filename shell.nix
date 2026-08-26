{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    bat
    fzf
    zoxide
    starship
  ];

  programs.bash = {
    enable = true;
    historySize = 32768;
    historyFileSize = 32768;
    historyControl = [ "ignoreboth" ];
    bashrcExtra = ''
      set +h
      if [[ ! -v BASH_COMPLETION_VERSINFO && -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
      fi
    '';

    shellAliases = {
      ls = "eza --long --header --icons=auto";
      lsa = "ls -a";
      lt = "eza --tree --level=4 --long --icons --git";
      lta = "lt -a";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      btw = "echo I use hyprland btw";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hyprnix";
      ncg = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      vim = "nvim";
      spf = "superfile";
      nrw = "pkill -f walker; pkill -f elephant; nohup walker >/dev/null 2>&1 & nohup elephant >/dev/null 2>&1 &";

      # Git Utilities
      g = "git";
      gcm = "git commit -m";
      gcam = "git commit -a -m";
      gcad = "git commit -a --amend";

      # NBTrackr
      nbb = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p \"(python3.withPackages (ps: with ps; [ requests pyqt5 pyside6 pillow tkinter ps.\\\"sseclient-py\\\" ]))\" steam-run --run \"steam-run \\\$(which python3) /home/mani/nixos-dotfiles/config/waywall/resources/NBTrackr-imgpin-v2.7.0/NBTrackr-imgpin.py\"";
    };

    initExtra = ''
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '

      n() { 
        if [ "$#" -eq 0 ]; then command nvim . ; else command nvim "$@"; fi
      }

      gcr() {
        cd ~/nixos-dotfiles || exit 1
        git fetch origin
        git reset --hard origin/main
        cd ~/
        nrs
        hyprctl reload
      }
    '';
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec start-hyprland
      fi
    '';
  };

  programs.readline = {
    enable = true;
    variables = {
      meta-flag = "on";
      input-meta = "on";
      output-meta = "on";
      convert-meta = "off";
      completion-ignore-case = "on";
      completion-prefix-display-length = 2;
      show-all-if-ambiguous = "on";
      show-all-if-unmodified = "on";
      mark-symlinked-directories = "on";
      match-hidden-files = "off";
      page-completions = "off";
      completion-query-items = 200;
      visible-stats = "on";
      skip-completed-text = "on";
      colored-stats = "on";
      menu-complete-display-prefix = "on";
    };
    bindings = {
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
      "\\e[C" = "forward-char";
      "\\e[D" = "backward-char";
      "TAB" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
    };
  };

  home.sessionVariables = {
    SUDO_EDITOR = "$EDITOR";
    BAT_THEME = "ansi";
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
