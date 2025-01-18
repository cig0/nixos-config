# { modulesPath, pkgsUnstable, ... }:
{
  config,
  inputs,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "home-manager" "enable"] config;
in {
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
      users = {
        cig0 = {...}: {
          imports = [
            ./modules/applications/main.nix
            ./modules/config-files/main.nix
            ./modules/user/maintenance/apps-cargo.nix
          ];

          home = {
            homeDirectory = "/home/cig0";

            sessionVariables = {
              EDITOR = "nvim";
              VISUAL = "code";
            };

            packages = with pkgs;
              [
              ]
              ++ (with pkgsUnstable; [
                # Web
                # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
              ]);

            # The state version is required and should stay at the version you
            # originally installed.
            stateVersion = "24.11";
          };
        };

        # doomguy = { ... }: {
        #   home = {
        #     homeDirectory = "/home/doomguy";

        #     sessionVariables = {
        #       EDITOR = "nvim";
        #       VISUAL = "code";
        #     };

        #     packages = with pkgs; [
        #       ] ++
        #       (with pkgsUnstable; [
        #       # Web
        #         # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
        #     ]);

        # # The state version is required and should stay at the version you
        # # originally installed.
        #   stateVersion = "24.11";
        # };

        fine = {...}: {
          imports = [
            ./modules/applications/main.nix
            ./modules/config-files/main.nix
            ./modules/user/maintenance/apps-cargo.nix
          ];

          home = {
            homeDirectory = "/home/fine";

            sessionVariables = {
              EDITOR = "nvim";
              VISUAL = "code";
            };

            packages = with pkgs;
              [
              ]
              ++ (with pkgsUnstable; [
                # Web
                # (pkgsUnstable.wrapFirefox (pkgsUnstable.firefox-unwrapped.override { pipewireSupport = true;}) {})
              ]);

            # The state version is required and should stay at the version you
            # originally installed.
            stateVersion = "24.11";
          };
        };
      };
    };
  };
}
