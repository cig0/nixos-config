{ config, inputs, ... }:

{
  sops = {
    age.keyFile = "/home/cig0/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      "syncthing/cig0/password" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/TUXEDOInfinityBookPro" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/satama" = { owner = config.users.users.cig0.name; };
      "syncthing/cig0/devices/koira" = { owner = config.users.users.cig0.name; };
    };
  };
}