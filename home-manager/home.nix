{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "home-manager" "enable" ] config;
in
{
  imports = [
    # (modulesPath + "/profiles/minimal.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  options.mySystem.home-manager.enable = lib.mkEnableOption "Whether to enable Home Manager.";

  config = lib.mkIf cfg {
    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      users = lib.mkMerge [
        #       ---------   ATTENTION!   ---------
        # Always use stateVersion = "24.11" for new users
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
                ./modules/applications/zsh/zsh.nix
                ./modules/applications/atuin.nix
                ./modules/applications/starship.nix
                ./modules/config-files/default.nix
                ./modules/system/default.nix
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
