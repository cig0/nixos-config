{
  config,
  lib,
  ...
}:
let
  mkUserConfig =
    username:
    { config, nixosConfig, ... }:
    {
      imports = [
        ./modules/module-loader.nix # Shared modules
        # ./users/${username}/profile.nix # User configuration
        ./users/${username}.nix # User configuration
      ];

      home = {
        homeDirectory = "/home/${username}";

        sessionVariables = {
          EDITOR = nixosConfig.mySystem.myOptions.cli.editor;
          VISUAL = "code";
        };

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
