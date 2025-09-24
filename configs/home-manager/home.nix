# Skeleton config. Check shared and user modules for the actual configurations.
{
  config,
  _inputs,
  lib,
  libAnsiColors,
  libModulon,
  self,
  ...
}:
let
  mkUserConfig =
    username:
    { ... }:
    {
      imports =
        # User profile configuration module
        [ ./users/${username}/profile.nix ]
        ++
        # Import user-specific modules
        lib.optional (builtins.pathExists ./users/${username}/modules) (libModulon {
          dirs = [ ./users/${username}/modules ];
        });

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
      extraSpecialArgs = { inherit _inputs libAnsiColors self; };

      # Dynamically import shared modules
      sharedModules = [
        (libModulon {
          dirs = [
            ./modules
          ];
          excludePaths = [
            "/modules/applications/zsh/" # The module has a separate auto importer for shell aliases and functions
          ];
          extraModules = [
            ./modules/applications/zsh/zsh.nix
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
