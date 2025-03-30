{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.services.openssh.enable;
in
{
  options.mySystem = {
    services.openssh = {
      enable = lib.mkEnableOption "Whether to enable the OpenSSH server";
      listenAddresses = lib.mkOption {
        type = lib.types.nullOr (
          lib.types.listOf (
            lib.types.submodule {
              options = {
                addr = lib.mkOption { type = lib.types.str; };
                port = lib.mkOption { type = lib.types.port; };
              };
            }
          )
        );
        default = null;
        description = "List of addresses and ports for OpenSSH to listen on";
      };
    };
  };

  config = lib.mkIf cfg {
    services.openssh = {
      enable = true;
      openFirewall = true;
      listenAddresses = config.mySystem.services.openssh.listenAddresses;
    };

    systemd.services.sshd = lib.mkIf config.mySystem.services.tailscale.enable {
      after = [ "tailscaled.service" ];
      # requires = [ "tailscaled.service" ]; # Makes Tailscale a hard dependency.
    };
  };
}
