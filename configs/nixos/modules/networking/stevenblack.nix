# https://github.com/StevenBlack/hosts
{
  config,
  lib,
  pkgs,
  ...
}:
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

  config = lib.mkIf config.myNixos.networking.stevenblack.enable {
    networking.stevenblack = {
      enable = true;
      block = config.myNixos.networking.stevenblack.block;
    };

    systemd.services.stevenblack-unblock =
      lib.mkIf config.myNixos.systemd.services.stevenblack-unblock.enable
        {
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
