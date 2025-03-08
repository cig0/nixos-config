# TODO: (wip) configure Yazi
{
  config,
  inputs,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  cfg.mySystem = {
    package = config.mySystem.package.yazi.enable;
    programs = config.mySystem.programs.yazi.enable;
  };
in
{
  options.mySystem = {
    package.yazi.enable = lib.mkEnableOption "Whether to install Yazi terminal file manager from a package";
    programs.yazi.enable = lib.mkEnableOption "Whether to enable Yazi terminal file manager (follows NixOS release channel set in the flake)";
  };

  config = {
    assertions = [
      # How this assertion checking works
      # ---------------------------------
      # `lib.count (x: x)`: Counts how many true values are in the list.
      # An alternate more explicit notation could be: `lib.count (flag: flag == true)`
      # `<= 1`: Ensures that no more than one option is true.
      # Behavior: Fails if two or more are true, passes if zero or one are true.
      {
        assertion =
          lib.count (x: x) [
            config.programs.yazi.enable
            config.mySystem.package.yazi.enable
            config.mySystem.programs.yazi.enable
          ] <= 1;
        message = "Only one of config.programs.yazi.enable, mySystem.packages.yazi.enable, or mySystem.programs.yazi.enable can be enabled at a time.";
      }
    ];

    # Install Yazi from pkgsUnstable if the package option is enabled
    environment.systemPackages = lib.mkIf cfg.mySystem.package [ pkgsUnstable.yazi ];

    # TODO: remove this after upgrading to NixOS 25.05
    # Install Yazi from the flake if the program option is enabled
    # Disabled as of Fri 7 Mar 2025 because NixOS tracks the stable channel and Yazi's flake needs to pull about half a gigabyte of dependencies from unstable
    # This will be reverted and this notice removed after upgrading to NixOS 25.05
    programs.yazi = lib.mkIf cfg.mySystem.programs {
      enable = true;

      # TODO: decide which way to go with the following options
      package = inputs.yazi.packages.${pkgs.system}.default; # if you use overlays, you can omit this
      # In NixOS, when multiple modules define the nixpkgs.overlays option, the module system concatenates the lists from all modules rather than overriding them.
      # https://wiki.nixos.org/wiki/Overlays
      # nixpkgs.overlays = [ inputs.yazi.overlays.default ];

      # "https://yazi-rs.github.io/docs/tips/"
      # plugins = {
      #   toggle-pane = "yazi-rs/plugins:toggle-pane";
      # };
    };

    # TODO: (wip) -- I NEED TO ADD the options to correctly handling nix.settings.extra-* so each module doesn't overwrite the other
    nix.settings = lib.mkIf cfg.mySystem.programs {
      extra-substituters = [ "https://yazi.cachix.org" ];
      extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    };
  };
}
