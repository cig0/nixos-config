# https://github.com/StevenBlack/hosts
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "systemd" "services" "stevenblack-unblock" "enable" ] config;
in
{
  options.mySystem.systemd.services.stevenblack-unblock.enable =
    lib.mkEnableOption "Whether to unblock hosts added by {option}networking.stevenblack.block to /etc/hosts.";

  config = lib.mkIf cfg {
    systemd.services.stevenblack-unblock = {
      description = "Unblock a few domains from the StevenBlack block lists";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.gnused}/bin/sed -i -e '/reddit/d' -e '/whatsapp/d' -e '/linkedin/d' -e '/licdn.com/d' -e '/instagram.com/d' -e '/x.com/d' /etc/hosts";
      };
    };
  };
}
