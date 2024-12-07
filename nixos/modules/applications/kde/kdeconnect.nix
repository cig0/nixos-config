# kdeconnect.nix - KDE Connect

{ ... }:

{
  programs.kdeconnect = {
    enable = false;
    settings = {
      General = {
        DiscoveryTimeout = 10;
        AutoConnect = true;
        AutoConnectDelay = 10;
      };
      Advanced = {
        DiscoveryInterval = 10;
        AutoConnectInterval = 10;
      };
    };
  };
}