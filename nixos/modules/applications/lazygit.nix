{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "programs" "lazygit" ] config;
in
{
  options.mySystem.programs.lazygit = {
    enable = lib.mkEnableOption "Whether to enable lazygit, a simple terminal UI for git commands.";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          scrollPastBottom = false;
        };

        git = {
          commit = {
            signOff = true;
            autoWrapCommitMessage = true;
            # autoWrapWidth = 144;
          };
          merging = {
            manualCommit = true;
          };
          update = {
            method = "background";
            days = 14;
          };
          os = {
            edit = "nvim {{filename}}";
            editAtLine = "nvim {{filename}} +{{line}}";
            editInTerminal = true;
            openDirInEditor = "nvim {{dir}}";
          };
        };

        promptToReturnFromSubprocess = false;
      };
    };
  };
}
