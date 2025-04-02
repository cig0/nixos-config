{
  config,
  lib,
  ...
}:
let
  cfg = {
    enable = lib.getAttrFromPath [ "mySystem" "networking" "networkmanager" "enable" ] config;
    dns = lib.getAttrFromPath [ "mySystem" "networking" "networkmanager" "dns" ] config;
  };
in
{
  options.mySystem.networking.networkmanager.enable = lib.mkEnableOption ''
    Whether to use NetworkManager to obtain an IP address and other
    configuration for all network interfaces that are not manually
    configured. If enabled, a group `networkmanager`
    will be created. Add all users that should have permission
    to change network settings to this group.'';

  options.mySystem.networking.networkmanager.dns = lib.mkOption {
    type = lib.types.enum [
      "default"
      "dnsmasq"
      "systemd-resolved"
      "none"
    ];
    default = "default";
    description = ''
      Set the DNS (`resolv.conf`) processing mode.

      A description of these modes can be found in the main section of
      [
        https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
      ](https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html)
      or in
      {manpage}`NetworkManager.conf(5)`.'';
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
      dns = cfg.dns;
    };
  };
}
