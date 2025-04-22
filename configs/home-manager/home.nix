# Skeleton config. Check modules for the actual configuration.
{
  ansiColors,
  config,
  inputs,
  lib,
  ...
}:
let
  mkUserConfig =
    username:
    {
      ...
    }:
    {
      imports = [
        # User-specific configuration
        ./users/${username}/profile.nix
      ];

      home = {
        homeDirectory = "/home/${username}";

        # The state version is required and should stay at the version you
        # originally installed.
        stateVersion = "24.11";
      };
    };
in
{
  imports = [
    # (modulesPath + "/profiles/minimal.nix")
  ];

  options.myNixos.home-manager.enable = lib.mkEnableOption "Whether to enable Home Manager.";

  config = lib.mkIf config.myNixos.home-manager.enable {
    home-manager = {
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit ansiColors inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;
      users = lib.mkMerge [
        {
          cig0 = mkUserConfig "cig0";
        }
        (lib.mkIf config.myNixos.users.users.doomguy {
          doomguy = mkUserConfig "doomguy";
        })
        {
          fine = mkUserConfig "fine";
        }
      ];
    };
  };
}
