{
  config,
  lib,
  myArgs,
  ...
}:
{
  options.myNixos = {
    services.tailscale = {
      enable = lib.mkEnableOption "Whether to enable Tailscale client daemon.";
      authKeyFile = lib.mkOption {
        type = lib.types.path;
        default = ./configs/nixos/hosts/${myArgs.system.hostname}/profile/secrets/tailscale-authKeyFile;
        description = ''
          A file containing the auth key.
          Tailscale will be automatically started if provided.
        '';
      };
    };

    myOptions.services.tailscale = {
      ip = lib.mkOption {
        type = lib.types.str;
        default = null;
        description = "The Tailscale IP address assigned to this host; useful to configure other modules like opensshd.nix.";
      };
      openssh.port = lib.mkOption {
        type = lib.types.port;
        default = 22;
        description = "The Tailscale IP address assigned to this host; useful to configure other modules like opensshd.nix.";
      };
    };
  };

  config = lib.mkIf config.myNixos.services.tailscale.enable {
    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];
      };
      search = [ "tuxedo-goanna.ts.net" ]; # FIXME: sops-nix
    };

    services = {
      tailscale = {
        enable = true;
        # authKeyFile = config.myNixos.ervices.tailscale.authKeyFile;
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
      /*
        TODO: Add options to:
        - Enable/disable tailscaleAuth
        - Group and user

        tailscaleAuth = {
          enable = false;
          group = "";
          user = "";
        };
      */
    };

    systemd.services.tailscaled = {
      after = [
        "network-pre.target"
        "NetworkManager.service"
        "systemd-resolved.service"
      ];
      before = [ "sshd.service" ];
      bindsTo = [
        "nm-file-secret-agent.service"
      ];
      wants = [
        "network-pre.target"
      ];
    };
  };
}
