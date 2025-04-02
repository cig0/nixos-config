{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.home-manager.enable;

  mkUserConfig =
    username:
    { config, ... }:
    {
      imports = [
        ./modules/default.nix # Shared modules
        ./users/${username}/profile.nix # User configuration
      ];
    };
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
          cig0 = mkUserConfig "cig0";
        }
        (lib.mkIf config.mySystem.users.users.doomguy {
          doomguy = mkUserConfig "doomguy";
        })
        {
          fine = mkUserConfig "fine";
        }
      ];
    };
  };
}
