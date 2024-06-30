# https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module

{ modulesPath, pkgs, unstablePkgs, ... }: # Note!!! using the unstable release channel, defined in the flake

{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];

  # Optionally, use home-manager.extraSpecialArgs to pass
  # arguments to home.nix
  home-manager = {
    backupFileExtension = "bkp";
    useGlobalPkgs = false; # Whether or not use global packages; if true, saves space by symlinking packages from the system store; if false, improves isolation by downloading and installing any needed pacakges.
    useUserPackages = true; # Allow user-specific packages. This option is what makes Home Manager, Home Manager :)

    users = {
      cig0 = { ... }: {
        # Define user-specific packages and configurations
        home.packages = [
        ];

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "23.11";
      };
      
      fine = { ... }: {
        home.packages = [
        ];

        # The state version is required and should stay at the version you
        # originally installed.
        home.stateVersion = "23.11";
      };
    };
  };
}
