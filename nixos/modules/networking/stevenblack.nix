{ config, lib, ... }:

let
  cfg = config.mySystem.networking.stevenblack.enable;

in {
  options.mySystem.networking.stevenblack.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Steven Black's hosts block lists";
  };

  config = lib.mkIf (cfg == true) {
    networking.stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
        "social"
      ];
    };
  };
}



# READ ME!
# ========

# https://github.com/StevenBlack/hosts