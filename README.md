
# nixos dotfiles

## Reproducible configuration and dotfiles for my NixOs system

This repository houses all* of my nixos configuration files to allow me to declaratively configure all of the programs and services that I need most. This repo is structured in a way that allows home-manager to symlink configuration files for programs from ~/nixos-dotfiles/config/program/ into ~/.config/program/ (program being an example name), this structure allows the user to avoid some of the confusing nature and configuration of nix for programs that could be configured often. 

## Installation / Reproduction

### Note these steps are not fully accurate as I haven't reinstalled my system in a long time. 

I installed this system by using this guide https://www.youtube.com/watch?v=7QLhCgDMqgw&t=169s. follow it for more details

To install this configuration on your own nixos system I advise you to use the minimal or graphical iso of your choosing 

#### Note: If your using the graphical ISO I **highly** suggest that you don't install and desktop environment during installation as you will need to uninstall it after or during install. This is **untested** and could lead to conflicting services and lingering unused programs.

Once you have installed nixos you must edit your default configuration.nix file in /etc/nixos/configuration.nix to include git as one of your packages, include networking.networkmanager.enable = true; in your config if you are using wifi.

Once you have an internet connection and git installed you can go to your home directory and clone this repository. Once cloned you can run "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#hyprnix" where hyprnix is your user name. 

After your system is rebuilt, reboot your computer and you should be able to log into this configuration

Some service configurations have not been set declaratively as this installation process is currently untested. These services have note been configured declaratively either because it would be a security risk to do so and push them out or because they've been deemed to much of a hassle to do. 
