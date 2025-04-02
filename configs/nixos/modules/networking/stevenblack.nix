# https://github.com/StevenBlack/hosts
{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.networking.stevenblack;
in
{
  options.mySystem.networking.stevenblack = {
    enable = lib.mkEnableOption "the StevenBlack hosts file blocklist";
    block = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "gambling"
          "porn"
          "social"
        ]
      );
      default = [ ];
      example = [
        "gambling"
        "porn"
      ];
      description = ''
        A list of categories to block using StevenBlack's blocklist.
        Available categories: gambling, porn, social.
        At least one category must be selected if the blocklist is enabled.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = lib.length cfg.block > 0;
        message = ''
          At least one category must be selected from: gambling, porn, social.

          If you want to disable all the lists, set:
            myConfig.networking.stevenblack.enable = false;
        '';
      }
    ];

    networking.stevenblack = {
      enable = true;
      block = cfg.block;
    };
  };
}
