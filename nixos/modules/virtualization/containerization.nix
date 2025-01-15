{ config, lib, ... }:

let
  cfg = config.mySystem.podman;

in {
  options.mySystem.podman = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Whether to enable Podman and containerization support";
  };

  config = lib.mkIf (cfg == "true") {
    virtualisation = {  # https://wiki.nixos.org/wiki/Podman
      oci-containers.backend = "podman";  # Enable running Podman containers as systemd services.
      containers.enable = true;  # Enable common container config files in /etc/containers.

      # https://wiki.nixos.org/wiki/Podman
      # Options: https://search.nixos.org/options?channel=24.05&show=virtualisation.podman.autoPrune.dates&from=0&size=50&sort=relevance&type=packages&query=virtualisation.podman
      podman = {
        enable = true;
        autoPrune = {
          enable = false;
          dates = "weekly";
          flags = [ "--all" ];
        };
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}