# Don't remove this line! This is a NixOS applications module.

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
            autoWrapCommitMessage = false;
          };
          merging = {
            manualCommit = true;
          };
          update = {
            method = "background";
            days = 14;
          };
          os = {
            edit = "${config.mySystem.cli.editor} {{filename}}";
            editAtLine = "${config.mySystem.cli.editor} {{filename}} +{{line}}";
            editInTerminal = true;
            openDirInEditor = "${config.mySystem.cli.editor} {{dir}}";
          };
        };

        promptToReturnFromSubprocess = false;
      };
    };
  };
}
