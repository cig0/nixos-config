# TODO: configure Yazi
{
  config,
  inputs,
  lib,
  pkgs,
  yazi,
  ...
}:
let
  cfg.enable = {
    fromPackage = config.mySystem.yazi.enable.package;
    nixosConfig = config.mySystem.yazi.enable.nixosConfig;
    overlay = config.mySystem.yazi.enable.asOverlay;
  };
in
{
  options.mySystem.yazi = {
    enable = {
      fromPackage = lib.mkEnableOption "Whether to install Yazi terminal file manager package from nixpkgs-unstable";
      nixosConfig = lib.mkEnableOption "Whether to enable Yazi terminal file manager with NixOS options (follows NixOS release channel)";
      overlay = lib.mkEnableOption "Whether to enable Yazi terminal file manager as an overlay";
    };
  };

  config = lib.mkIf cfg.enable.nixosConfig {
    programs.yazi = {
      enable = true;
      package = yazi.packages.${pkgs.system}.default; # if you use overlays, you can omit this

      # "https://yazi-rs.github.io/docs/tips/"
      # plugins = {
      #   toggle-pane = "yazi-rs/plugins:toggle-pane";
      # };
    };

    # TODO: wip -- I NEED TO ADD the options to correctly handling nix.settings.extra-* so each module doesn't overwrite the other
    nix.settings = {
      extra-substituters = [ "https://yazi.cachix.org" ];
      extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    };

    # In NixOS, when multiple modules define the nixpkgs.overlays option, the module system concatenates the lists from all modules rather than overriding them.
    # https://wiki.nixos.org/wiki/Overlays
    # nixpkgs.overlays = [ inputs.yazi.overlays.default ];
  };
}
