# TODO: think about adding toggle to enable/disable importing modules
# { modulesPath, pkgsUnstable, ... }:
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
        #                    ATTENTION!
        #  Always use stateVersion = "24.11" for new users
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
                # ░░░░    M O D U L E S    ░░░░
                ./modules/applications/default.nix
                ./modules/config-files/default.nix
                ./modules/system/default.nix
              ];

              # ░░░░    O P T I O N S    ░░░░
              myHM = {
                # Config-files
                xdg.configFile."git/config".enable = false; # Testing programs.git.config.Check for nixos/modules/applications/gix.nix.
                xdg.configFile."git/gitignore_global".enable = true;
              };

              home = {
                homeDirectory = "/home/doomguy";

                sessionVariables = {
                  EDITOR = config.mySystem.cli.editor;
                  VISUAL = "code";
                };

                # packages = with pkgs; [
                #   ] ++
                #   (with pkgsUnstable; [
                #   # Web
                #     # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
                # ]);

                # The state version is required and should stay at the version you
                # originally installed.
                stateVersion = "24.11";
              };
            };
        })
        {
          fine =
            { ... }:
            {
              imports = [
                # ░░░░    M O D U L E S    ░░░░
                ./modules/default.nix # Shared modules
              ];

              # ░░░░    O P T I O N S    ░░░░
              myHM = {
                # Config-files
                xdg.configFile."git/config".enable = false; # Testing programs.git.config.Check for nixos/modules/applications/gix.nix.
                xdg.configFile."git/gitignore_global".enable = true;
              };

              home = {
                homeDirectory = "/home/fine";

                sessionVariables = {
                  EDITOR = config.mySystem.cli.editor;
                  VISUAL = "code";
                };

                # packages = with pkgs;
                #   [
                #   ]
                #   ++ (with pkgsUnstable; [
                #     # Web
                #     # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
                #   ]);

                # The state version is required and should stay at the version you
                # originally installed.
                stateVersion = "24.11";
              };
            };
        }
      ];
    };
  };
}
