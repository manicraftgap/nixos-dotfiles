{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    elephant.url = "github:abenz1267/elephant";
    oledctl.url = "github:manicraftgap/oledctl/hyprsunset";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    helium.url = "github:oxcl/nix-flake-helium-browser";
    millennium.url = "github:SteamClientHomebrew/Millennium/next?dir=packages/nix";
    openlogi = {
      url = "github:AprilNEA/OpenLogi?dir=packaging";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
    nixosConfigurations.hyprnix = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        {
          nixpkgs.overlays = [
            inputs.millennium.overlays.default
            (final: prev: {
              learnharness = prev.callPackage (
                { pkgs, ... }:
                let
                  pname = "learnharness";
                  version = "0.3.4";
                  src = pkgs.fetchurl {
                    url = "https://github.com/amosblomqvist/learnharness/releases/download/v0.3.4/LearnHarness-0.3.4-x86_64.AppImage";
                    hash = "sha256-Mz1JKFhE8M8CipALAxWDgUoXqLRRqmYsZJPomaeCe6E=";
                  };
                  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
                in
                pkgs.appimageTools.wrapType2 {
                  inherit pname version src;
                  extraInstallCommands = ''
                    install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
                    substituteInPlace $out/share/applications/${pname}.desktop \
                      --replace 'Exec=AppRun' 'Exec=${pname}'
                    cp -r ${appimageContents}/usr/share/icons $out/share/
                  '';
                }
              ) {};
            })
          ];
        }
        nixos-hardware.nixosModules.asus-zephyrus-gu605my
        inputs.helium.nixosModules.default
        inputs.oledctl.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.mani = import ./home.nix;
          };
        }
      ];
    };
  };
}
