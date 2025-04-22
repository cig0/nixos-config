# Skeleton config. Check shared and user modules for the actual configurations.
{
  libraryAnsiColors,
  config,
  inputs,
  lib,
  libraryModuleLoader,
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
      extraSpecialArgs = { inherit libraryAnsiColors inputs; };

      # Dynamically import Home Manager modules
      sharedModules = [
        (libraryModuleLoader {
          dirs = [
            ./modules
          ];
          excludePaths = [
            "applications/zsh" # Workaround for an issue I'm having when importing this module
          ];
          extraModules = [
            ./modules/applications/zsh/zsh.nix # Workaround for an issue I'm having when importing this module
          ];
        })
      ];

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
