{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "lazygit"] config;
in {
  options.mySystem.programs.lazygit = {
    enable = lib.mkEnableOption "Whether to enable lazygit, a simple terminal UI for git commands.";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        promptToReturnFromSubprocess = false;
      };
    };
  };
}
