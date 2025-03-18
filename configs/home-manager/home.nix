/*
  TODO: apply same dynamic module loading as in NixOS

  Being worked on in branch refactor/home-manager/autoload-module
*/
{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.home-manager.enable;
in
{
  imports = [
    # (modulesPath + "/profiles/minimal.nix")
  ];

  options.mySystem.home-manager.enable = lib.mkEnableOption "Whether to enable Home Manager.";

  config = lib.mkIf cfg {
    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      users = lib.mkMerge [
        {
          cig0 =
            { ... }:
            {
              imports = [
                ./modules/default.nix # Shared modules
                ./users/cig0/default.nix # User configuration
              ];
            };
        }
        (lib.mkIf config.mySystem.users.users.doomguy {
          doomguy =
            { ... }:
            {
              imports = [
                ./modules/default.nix # Shared modules
                ./users/doomguy/default.nix # User configuration
              ];
            };
        })
        {
          fine =
            { ... }:
            {
              imports = [
                ./modules/default.nix # Shared modules
                ./users/fine/default.nix # User configuration
              ];
            };
        }
      ];
    };
  };
}
