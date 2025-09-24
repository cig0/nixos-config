{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "myNixos" "programs" "bat" ] config;
in
{
  options.myNixos.programs.bat.enable =
    lib.mkEnableOption "Whether to enable bat, a cat(1) clone with wings.";

  config = {
    programs = {
      bat = {
        enable = cfg.enable;
        # TODO: configure Bat
        # settings = {
        #   italic-text = "always";
        #   map-syntax = [
        #     "*.ino:C++"
        #     ".ignore:Git Ignore"
        #   ];
        #   pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
        #   paging = "never";
        #   theme = "TwoDark";
        # };
      };
    };
  };
}
