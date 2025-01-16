{ config, lib, ... }:

let
  cfg = config.mySystem.services.openssh.enable;

in {
  options.mySystem.services.openssh.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable the OpenSSH server";
  };

  config = lib.mkIf (cfg == true) {
    services.openssh = {
      enable = true;
      openFirewall = true;
      listenAddresses = [
        {
          addr = "127.0.0.1";
          port = 22;
        }
        {  # Tailscale
          addr = "100.0.0.0";
          port = 22222;
        }
      ];
    };
  };
}
