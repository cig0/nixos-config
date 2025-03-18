{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.services.openssh.enable;
in {
  options.mySystem.services.openssh.enable = lib.mkEnableOption "Whether to enable the OpenSSH server";

  config = lib.mkIf cfg {
    services.openssh = {
      enable = true;
      openFirewall = true;
      listenAddresses = [
        {
          addr = "127.0.0.1";
          port = 22;
        }
      ];
    };
  };
}
