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
          };
          merging = {
            manualCommit = true;
          };
          update = {
            method = "background";
            days = 14;
          };
          os = {
            edit = "${config.mySystem.myOptions.cli.editor} {{filename}}";
            editAtLine = "${config.mySystem.myOptions.cli.editor} {{filename}} +{{line}}";
            editInTerminal = true;
            openDirInEditor = "${config.mySystem.myOptions.cli.editor} {{dir}}";
          };
        };

        promptToReturnFromSubprocess = false;
      };
    };
  };
}
