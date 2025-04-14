{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "virtualisation" "podman"] config;
in {
  options.myNixos.virtualisation.podman = {
    enable =
      lib.mkEnableOption "This option enables Podman, a daemonless container engine for
developing, managing, and running OCI Containers on your Linux System.

It is a drop-in replacement for the {command}`docker` command.";
    autoPrune.enable =
      lib.mkEnableOption "Whether to periodically prune Podman resources. If enabled, a
systemd timer will run `podman system prune -f`
as specified by the `dates` option.";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      containers.enable = true; # Enable common container config files in /etc/containers.
      oci-containers = {
        backend = "podman"; # Enable running Podman containers as systemd services.
        containers = {
          # container-name = {
          #   image = "container-image";
          #   autoStart = true;
          #   ports = ["127.0.0.1:1234:1234"];
          # };
        };
      };

      # https://wiki.nixos.org/wiki/Podman
      # Options: https://search.nixos.org/options?channel=24.05&show=virtualisation.podman.autoPrune.dates&from=0&size=50&sort=relevance&type=packages&query=virtualisation.podman
      podman = {
        enable = true;
        autoPrune = {
          enable = cfg.autoPrune.enable;
          dates = "weekly";
          flags = ["--all"];
        };
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
