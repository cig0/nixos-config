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
        default = ./secrets/tailscale-authKeyFile-${myArgs.system.hostname};
        description = ''
          A file containing the auth key.
          Tailscale will be automatically started if provided.
        '';
      };
    };

    myOptions.services.tailscale = {
      ip = lib.mkOption {
        type = lib.types.str;
        description = "The Tailscale IP address assigned to this host; useful to configure other modules like opensshd.nix.";
      };
      openssh.port = lib.mkOption {
        type = lib.types.port;
        default = 22;
        description = "The Tailscale IP address assigned to this host; useful to configure other modules like opensshd.nix.";
      };
      tailnetName = lib.mkOption {
        type = lib.types.str;
        description = "The Tailscale network name; useful to configure other modules like opensshd.nix.";
      };
    };
  };

  config = lib.mkIf config.myNixos.services.tailscale.enable {
    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];
      };
      search = [
        (config.myNixos.myOptions.services.tailscale.tailnetName)
      ];
    };

    services = {
      tailscale = {
        enable = true;
        # authKeyFile = config.myNixos.services.tailscale.authKeyFile; # TODO: evaluate using this option
        openFirewall = true;
        extraUpFlags = [ "--ssh" ];
      };
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
