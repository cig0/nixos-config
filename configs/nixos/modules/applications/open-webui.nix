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
