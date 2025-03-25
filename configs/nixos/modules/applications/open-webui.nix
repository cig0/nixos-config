{
  config,
  lib,
  myArgs,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "programs" "lazygit" ] config;
in
{
  options.mySystem.services.open-webui = {
    enable = lib.mkEnableOption "Whether to enable Open WebUI, a self-hosted AI platform";
    port = lib.mkOption {
      type = lib.types.int;
      default = 3000;
      description = "The port on which Open WebUI will listen";
    };
    openFirewall = lib.mkEnableOption "Whether to open the firewall for Open WebUI";
  };

  config = lib.mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      # package = myArgs.packages.pkgsUnstable.open-webui;
      port = 3000;
      openFirewall = true;
    };
  };
}
