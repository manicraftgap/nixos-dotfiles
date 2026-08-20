{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  xdg.desktopEntries."org.prismlauncher.PrismLauncher" = {
    name = "Prism Launcher";
    exec = "env QT_SCALE_FACTOR=1.3 prismlauncher %u";
    icon = "org.prismlauncher.PrismLauncher";
    terminal = false;
    categories = [ "Game" ];
  };

  xdg.dataFile."PrismLauncher/icons" = {
    source = create_symlink "${dotfiles}/prism/icons";
    recursive = true;
    force = true;
  };

  xdg.dataFile."PrismLauncher/catpacks" = {
    source = create_symlink "${dotfiles}/prism/catpacks";
    recursive = true;
    force = true;
  };

  xdg.dataFile."PrismLauncher/themes" = {
    source = create_symlink "${dotfiles}/prism/themes";
    recursive = true;
    force = true;
  };

  xdg.dataFile."PrismLauncher/prismlauncher.cfg" = {
    source = create_symlink "${dotfiles}/prism/prismlauncher.cfg";
    force = true;
  };
}
