# Skeleton config. Check the modules for the actual configuration.
{
  config,
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
        /*
          Importing the shared modules for each user isn't the best approach, but otherwise I have
          to modify the module-loader library to pass `nixosConfi` to the modules it loads.

          This way, though, because the modules are loaded under the user namespace, they  already
          can access the `nixosConfig` and `config` variables.
        */
        ./modules/module-loader.nix

        # User configuration
        ./users/${username}.nix
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
