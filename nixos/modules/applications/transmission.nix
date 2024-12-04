# transmission.nix - https://transmissionbt.com/
#
# TODO: this setting still uses Transmission 3; disabled in favor of the client app which uses v4.x (./nix-flatpak.nix)

{ config, ... }:

{
  services.transmission = {
    enable = true;
    group = "users";
    settings = {
      download-dir = "${config.services.transmission.home}/Downloads";
      rpc-bind-address = "0.0.0.0"; #Bind to own IP
      rpc-whitelist = "127.0.0.1";
    };
  };
}