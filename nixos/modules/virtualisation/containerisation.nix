{ config, lib, ... }:

let
  cfg = {
    virtualisation.podman.enable = config.mySystem.virtualisation.podman.enable;
    virtualisation.podman.autoPrune.enable = config.mySystem.virtualisation.podman.autoPrune.enable;
  };

in {
  options.mySystem.virtualisation.podman = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "This option enables Podman, a daemonless container engine for
developing, managing, and running OCI Containers on your Linux System.

It is a drop-in replacement for the {command}`docker` command.";
    };
    autoPrune.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to periodically prune Podman resources. If enabled, a
systemd timer will run `podman system prune -f`
as specified by the `dates` option.";
    };

  };

  config = lib.mkIf (cfg.virtualisation.podman.enable == true) {
    virtualisation = {  # https://wiki.nixos.org/wiki/Podman
      oci-containers.backend = "podman";  # Enable running Podman containers as systemd services.
      containers.enable = true;  # Enable common container config files in /etc/containers.

      # https://wiki.nixos.org/wiki/Podman
      # Options: https://search.nixos.org/options?channel=24.05&show=virtualisation.podman.autoPrune.dates&from=0&size=50&sort=relevance&type=packages&query=virtualisation.podman
      podman = {
        enable = true;
        autoPrune = {
          enable = cfg.virtualisation.podman.autoPrune.enable;
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