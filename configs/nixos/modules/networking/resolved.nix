{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "services" "resolved" "enable"] config;
in {
  options.myNixos.services.resolved.enable = lib.mkEnableOption "Whether to enable resolved for stage 1 networking.
Uses the toplevel 'services.resolved' options for 'resolved.conf'";

  config = lib.mkIf cfg {
    services.resolved = {
      enable = true;
      fallbackDns = ["1.1.1.1" "208.67.222.123" "8.8.8.8"];
    };
  };
}
