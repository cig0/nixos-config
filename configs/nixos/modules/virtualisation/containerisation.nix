{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixos.virtualisation.podman;
in
{
  options.myNixos.virtualisation.podman = {
    enable = lib.mkEnableOption ''
      Podman, a daemonless container engine for developing, managing, and running OCI Containers.
      It is a drop-in replacement for the `docker` command.
    '';
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      containers = {
        enable = true; # Enable common container config files in /etc/containers.

        /*
          TODO:
          - Consider opening a ticket to include unqualified-search-registries in NixOS default config.
          - Add a note in the wiki

          Configures unqualified-search-registries for Podman to enable pulling images from trusted registries:
          unqualified-search-registries = ["docker.io", "registry.fedoraproject.org", "registry.access.redhat.com"]

          Ref: https://podman.io/docs/installation#configuration-files
          Fixes: https://github.com/containers/podman/issues/8896#issuecomment-755359836
          Note: Risk of using unqualified image names; always prefer fully qualified names to avoid spoofing.

          See containers-registries.conf(5) for full details.
        */
        registries = {
          search = [
            "docker.io"
            "gcr.io"
            "ghcr.io"
            "mcr.microsoft.com"
            "registry.access.redhat.com"
            "registry.gitlab.com"
            "registry.fedoraproject.org"
          ];
        };
      };
      oci-containers = lib.mkMerge [
        {
          containers = {
            # container-name = {
            #   image = "container-image";
            #   autoStart = true;
            #   ports = ["127.0.0.1:1234:1234"];
            # };
          };
        }

        # Podman-specific configuration (only when podman is enabled)
        (lib.mkIf config.virtualisation.podman.enable {
          backend = "podman";
        })
      ];

      # https://wiki.nixos.org/wiki/Podman
      # Options: https://search.nixos.org/options?channel=24.05&show=virtualisation.podman.autoPrune.dates&from=0&size=50&sort=relevance&type=packages&query=virtualisation.podman
      podman = {
        enable = true;
        autoPrune = {
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
