{ config, lib, ... }:

let
  cfg = config.mySystem.stevenblack;

in {
  options.mySystem.stevenblack = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Steven Black's hosts block lists";
  };

  config = lib.mkIf (cfg == "true") {
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