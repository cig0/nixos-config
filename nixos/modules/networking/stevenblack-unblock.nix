{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.stevenblack-unblock;

in {
  options.mySystem.stevenblack-unblock = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to unblock defined hosts";
  };

  config = lib.mkIf (cfg == "true") {
    systemd.services.stevenblack-unblock = {
      description = "Unblock a few domains from the StevenBlack block lists";
      after = ["multi-user.target"];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.gnused}/bin/sed -i -e '/reddit/d' -e '/whatsapp/d' -e '/linkedin/d' -e '/licdn.com/d' -e '/instagram.com/d' /etc/hosts";
      };
    };
  };
}



# READ ME!
# ========

# https://github.com/StevenBlack/hosts