# home.nix - https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
# This file contains the configuration for Home Manager.
#
# The unstablePkgs argument is defined in ../flake.nix

# { modulesPath, unstablePkgs, ... }:
{ pkgs, unstablePkgs, ... }:

{
  # imports = [
  #   (modulesPath + "/profiles/minimal.nix")
  # ];

  home-manager = {  # Define user-specific packages and configurations
    backupFileExtension = "backup";
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        imports = [
          ./modules/applications/atuin.nix
          ./modules/applications/starship.nix
          ./modules/applications/zsh/zsh.nix
          ./modules/config-files/apps-cargo.nix ./modules/user/maintenance/apps-cargo.nix
          ./modules/config-files/aws.nix
          ./modules/config-files/git.nix
        ];

        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "code";
        };

        home.packages =
          with pkgs; [
          ] ++
          (with unstablePkgs; [
            # Web
              # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
          ]);

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "24.11";
      };

      # doomguy = { ... }: {
      #   home.packages =
      #     with pkgs; [
      #     ] ++
      #     (with unstablePkgs; [
      #     ]);

      #   home.stateVersion = "24.11";
      # };

      # fine = { ... }: {
      #   home.packages =
      #     with pkgs; [
      #     ] ++
      #     (with unstablePkgs; [
      #     ]);

      #   home.stateVersion = "24.11";
      # };
    };
  };
}
