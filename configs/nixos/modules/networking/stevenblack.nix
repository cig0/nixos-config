# https://github.com/StevenBlack/hosts
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixos;
in
{
  options.myNixos = {
    networking.stevenblack = {
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
    systemd.services.stevenblack-unblock.enable = lib.mkEnableOption "Whether to unblock hosts added by {option}networking.stevenblack.block to /etc/hosts.";
  };

  config = lib.mkIf cfg.networking.stevenblack.enable {
    assertions = [
      {
        assertion = lib.length cfg.networking.stevenblack.block > 0;
        message = ''
          At least one category must be selected from: gambling, porn, social.

          If you want to disable all the lists, set:
            myConfig.networking.stevenblack.enable = false;
        '';
      }
    ];

    networking.stevenblack = {
      enable = true;
      block = cfg.networking.stevenblack.block;
    };

    systemd.services.stevenblack-unblock = lib.mkIf cfg.systemd.services.stevenblack-unblock.enable {
      description = "Unblock the specified domains from the StevenBlack block lists";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.gnused}/bin/sed -i -e '/reddit/d' -e '/whatsapp/d' -e '/linkedin/d' -e '/licdn.com/d' -e '/instagram.com/d' /etc/hosts";
      };
    };
  };
}
