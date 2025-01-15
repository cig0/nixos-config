# { modulesPath, pkgsUnstable, ... }:
{ config, inputs, lib, pkgs, pkgsUnstable, ... }:

let
  cfg = config.mySystem.home-manager;

in {
  imports = [
    # (modulesPath + "/profiles/minimal.nix")
    inputs.home-manager.nixosModules.home-manager
  ];

  options.mySystem.home-manager = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable atop, the console system performance monitor";
  };

  config = lib.mkIf (cfg == "true") {
    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        cig0 = { ... }: {
          imports = [
            ./modules/applications/atuin.nix
            ./modules/applications/starship.nix
            ./modules/applications/zsh/zsh.nix
            ./modules/config-files/apps-cargo.nix
            ./modules/config-files/aws.nix
            ./modules/config-files/git.nix
            ./modules/user/maintenance/apps-cargo.nix
          ];

          home = {
            homeDirectory = "/home/cig0";

            sessionVariables = {
              EDITOR = "nvim";
              VISUAL = "code";
            };

            packages = with pkgs; [
              ] ++
              (with pkgsUnstable; [
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


        fine = { ... }: {
          imports = [
            ./modules/applications/atuin.nix
            ./modules/applications/starship.nix
            ./modules/applications/zsh/zsh.nix
            ./modules/config-files/apps-cargo.nix
            ./modules/config-files/aws.nix
            ./modules/config-files/git.nix
            ./modules/user/maintenance/apps-cargo.nix
          ];

          home = {
            homeDirectory = "/home/fine";

            sessionVariables = {
              EDITOR = "nvim";
              VISUAL = "code";
            };

            packages = with pkgs; [
              ] ++
              (with pkgsUnstable; [
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
