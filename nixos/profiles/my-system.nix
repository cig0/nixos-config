{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.selector;
in {
  imports = builtins.filter (x: x != null) [
    ./selector.nix
  ];

  options.mySystem.selector = lib.mkOption {
    type = lib.types.enum ["laptop" "desktop" "home-lab"];
    default = null;
    description = "System profile.";
  };

  config = {
    role = cfg;
  };
}
