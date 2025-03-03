# TODO: think about adding toggle to enable/disable importing modules
# { modulesPath, pkgsUnstable, ... }:
{
  config,
  inputs,
  lib,
  # pkgs,
  # pkgsUnstable,
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
        {
          cig0 =
            { ... }:
            {
              imports = [
                # ░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░
                # ░░░░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░
                # ░░░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░
                ./modules/default.nix
              ];

              # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
              # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
              # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
              myHM = {
                # Config-files
                xdg.configFile."git/config".enable = false; # Testing programs.git.config. Check for nixos/modules/applications/gix.nix.
                xdg.configFile."git/gitignore_global".enable = true;
              };

              home = {
                homeDirectory = "/home/cig0";

                sessionVariables = {
                  # EDITOR = "nvim";
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
        {
          fine =
            { ... }:
            {
              imports = [
                # ░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░
                # ░░░░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░
                # ░░░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░
                ./modules/default.nix
              ];

              # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
              # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
              # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
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
        (lib.mkIf config.mySystem.users.users.doomguy {
          doomguy =
            { ... }:
            {
              imports = [
                # ░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░
                # ░░░░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░
                # ░░░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░
                ./modules/applications/default.nix
                ./modules/config-files/default.nix
                ./modules/system/default.nix
              ];

              # ░░░░░░░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░░
              # ░░░░░░░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█░░░░░░░
              # ░░░░░░░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░░
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
      ];
    };
  };
}
