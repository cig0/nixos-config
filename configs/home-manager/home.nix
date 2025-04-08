{
  config,
  lib,
  ...
}:
let
  mkUserConfig =
    username:
    { config, ... }:
    {
      imports = [
        ./modules/module-loader.nix # Shared modules
        ./users/${username}.nix # User configuration
      ];
    };
in
{
  imports = [
    # (modulesPath + "/profiles/minimal.nix")
  ];

  options.mySystem.home-manager.enable = lib.mkEnableOption "Whether to enable Home Manager.";

  config = lib.mkIf config.mySystem.home-manager.enable {
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
