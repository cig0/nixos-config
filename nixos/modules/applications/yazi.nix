# TODO: configure Yazi
{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.mySystem.programs.yazi;
in
{
  options.mySystem.programs.yazi = {
    enable = lib.mkEnableOption "Whether to enable Yazi terminal file manager.";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      # "https://yazi-rs.github.io/docs/tips/"
      # plugins = {
      #   toggle-pane = "yazi-rs/plugins:toggle-pane";
      # };
    };

    # TODO: wip -- I NEED TO ADD the options to correctly handling nix.settings.extra-* so each module doesn't overwrite the other
    # nix.settings = {
    #   extra-substituters = [ "https://yazi.cachix.org" ];
    #   extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    # };

    # In NixOS, when multiple modules define the nixpkgs.overlays option, the module system concatenates the lists from all modules rather than overriding them.
    # https://wiki.nixos.org/wiki/Overlays
    # nixpkgs.overlays = [ inputs.yazi.overlays.default ];
  };
}
