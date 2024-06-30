# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
 # Note!!! Home Manageer is configured to use the unstable release channel, defined in the flake.

{ modulesPath, unstablePkgs, ... }:
{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];

  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        # Define user-specific packages and configurations
        home.packages = with unstablePkgs; [
          obsidian
        ];

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "23.11";
      };
      
      fine = { ... }: {
        home.packages = with unstablePkgs; [
        ];

        home.stateVersion = "23.11";
      };
    };
  };
}
