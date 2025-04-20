{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "services" "open-webui" ] config;
in
{
  options.myNixos.services.open-webui = {
    enable = lib.mkEnableOption "Whether to enable Open WebUI, a self-hosted AI platform";
    port = lib.mkOption {
      type = lib.types.int;
      default = 3000;
      description = "The port on which Open WebUI will listen";
    };
    openFirewall = lib.mkEnableOption "Whether to open the firewall for Open WebUI. This option
is managed by the `firewall` module.";
  };

  config = lib.mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      openFirewall = config.myNixos.ervices.open-webui.openFirewall;
      port = config.myNixos.ervices.open-webui.port;
    };
  };
}
