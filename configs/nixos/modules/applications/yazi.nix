# TODO: (wip) configure Yazi
{
  config,
  _inputs,
  lib,
  myArgs,
  pkgs,
  ...
}:
let
  cfg = {
    package = config.myNixos.package.yazi.enable;
    programs = config.myNixos.programs.yazi.enable;
  };
in
{
  options.myNixos = {
    package.yazi.enable = lib.mkEnableOption "Whether to install Yazi terminal file manager from a package";
    programs.yazi.enable = lib.mkEnableOption "Whether to enable Yazi terminal file manager (follows NixOS release channel set in the flake)";
  };

  config = {
    # Install Yazi from pkgs-unstable instead of from NixOS options
    environment.systemPackages = lib.mkIf cfg.package [ myArgs.packages.pkgs-unstable.yazi ];

    # TODO: remove this after upgrading to NixOS 25.05
    # Install Yazi from the flake if the program option is enabled
    # Disabled as of Fri 7 Mar 2025 because NixOS tracks the stable channel and Yazi's flake needs to pull about half a gigabyte of dependencies from unstable
    # This will be reverted and this notice removed after upgrading to NixOS 25.05
    programs.yazi = lib.mkIf cfg.programs {
      enable = true;

      # package = _inputs.yazi.packages.${pkgs.system}.default; # TODO: decide which way to go with the following options. If you use overlays, you can omit this.
      # In NixOS, when multiple modules define the nixpkgs.overlays option, the module system concatenates the lists from all modules rather than overriding them.
      # https://wiki.nixos.org/wiki/Overlays
      # nixpkgs.overlays = [ inputs.yazi.overlays.default ];

      # "https://yazi-rs.github.io/docs/tips/"
      # plugins = {
      #   toggle-pane = "yazi-rs/plugins:toggle-pane";
      # };
    };

    # TODO: (wip) -- I NEED TO ADD the options to correctly handling nix.settings.extra-* so each module doesn't overwrite each others' configurations
    # nix.settings = lib.mkIf cfg.programs {
    #   extra-substituters = [ "https://yazi.cachix.org" ];
    #   extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    # };
  };
}
